//
//  ViewModelable.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/22.
//

import UIKit

public protocol ViewModelable: class {
    associatedtype MViewModel: ViewModel

    var viewModel: MViewModel? { get set }
}

public extension ViewModelable where Self: UIViewController {
    
    @discardableResult
    func bind<MViewModel>(viewModel: MViewModel) -> Self {
        self.viewModel = viewModel as? Self.MViewModel
        return self
    }
    
}
