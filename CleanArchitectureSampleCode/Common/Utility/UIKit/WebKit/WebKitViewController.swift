//
//  WebKitViewController.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/5/2.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class WebKitViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var linkWebView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    var webView: WKWebView!
    
    var urlString: String?
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.backgroundColor = .white
        webView.scrollView.backgroundColor = .white
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "WebKitViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: "WebKitViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateRequest()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        webView.frame = linkWebView.bounds
        linkWebView.addSubview(webView)
        webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func setupUI() {
        pageTitle.text = title
        self.backButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true) }
            .disposed(by: disposeBag)
    }
    
    func updateRequest() {
        guard let urlString = urlString,
              !urlString.isEmpty,
              let url = URL(string: urlString) else {
            self.showAlert(message: PossibleErrors.none.localizedDescription)
            return
        }
        self.webView.load(URLRequest(url: url))
    }
    
}

extension WebKitViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard isBeingDismissed || isMovingFromParent else {
            show()
            return
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hide()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let response = navigationResponse.response as? HTTPURLResponse {
            guard 200..<300 ~= response.statusCode else {
                decisionHandler(.allow)
                return
            }
            hide()
        }
        decisionHandler(.allow)
    }
    
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        hide()
    }
    
}

extension WebKitViewController: Alertable {}
extension WebKitViewController: Loadable {
    func show() {
        LoadingView.show()
    }
    
    func hide() {
        LoadingView.hide()
    }
}
