//
//  Coordinated.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/17.
//

import UIKit

public protocol Coordinated: class {
    associatedtype Coordinator
    var coordinator: Coordinator? { get set }
}

extension Coordinated where Self: UIViewController {
    public func bind(_ coordinator: Coordinator) -> Self {
        self.coordinator = coordinator
        return self
    }
}
