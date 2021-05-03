//
//  UIViewController+Loading.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/3/2.
//

import UIKit
import RxSwift
import RxCocoa

protocol Loadable {
    func show()
    func hide()
}

extension Loadable where Self: UIViewController, Self: ViewModelable {
    
    func bindLoading() -> Disposable? {
        viewModel?.isLoading.bind(onNext: { [weak self] in
            $0 ? self?.show() : self?.hide()
        })
    }
    
    func show() {
        LoadingView.show()
    }
    
    func hide() {
        LoadingView.hide()
    }
    
}
