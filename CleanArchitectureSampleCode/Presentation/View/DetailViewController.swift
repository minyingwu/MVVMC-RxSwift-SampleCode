//
//  DetailViewController.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/5/1.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var bookingButton: UIButton!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var genresLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    var viewModel: DetailViewModel?
    var barButtonItems: [UIBarButtonItem] = []
    weak var coordinator: Coordinator?
    
    private lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    func setupUI() {
        bookingButton.rx.tap
            .bind(onNext: {
                let vc = WebKitViewController(urlString: APIEndpoints.getBooking())
                self.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func setupViewModel() {
        guard let viewModel = viewModel else { return }
        viewModel.movieDetailRelay
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: { [weak self] in
                    if let posterPath = $0.posterPath {
                        self?.posterImageView.kf.setImage(with: URL(string: APIEndpoints.getImage(path: posterPath)))
                    }
                    self?.synopsisLabel.text = $0.overview
                    self?.languageLabel.text = "Language\n\($0.originalLanguage)"
                    self?.genresLabel.text = "Genres\n\($0.genres.first?.name ?? "N/A")"
                    self?.durationLabel.text = "Duration\n\($0.runtime != 0 ? String($0.runtime) : "N/A") min" })
            .disposed(by: disposeBag)
        
        viewModel.errorRelay
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: { [weak self] in
                    guard let error = $0 else { return }
                    self?.showAlert(message: error.localizedDescription) })
            .disposed(by: self.disposeBag)
        
        viewModel.query()
            .disposed(by: disposeBag)
    }
    
}

extension DetailViewController: Storyboarded {}
extension DetailViewController: ViewModelable {}
extension DetailViewController: Coordinated {}
extension DetailViewController: Loadable {}
extension DetailViewController: Alertable {}

extension DetailViewController: BarButtonItemable {
    @objc func pressedLeftBarButtonItems(_ sender: UIBarButtonItem) {
        self.coordinator?.toPrevious()
    }
}
