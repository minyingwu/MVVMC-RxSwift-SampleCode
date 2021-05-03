//
//  Coordinator.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/17.
//

import UIKit

public protocol Coordinator: class {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    
    func start()
    func toNext()
    func toPrevious()
    func complete()
}

extension Coordinator {
    func toNext() {}
    func toPrevious() {}
    func complete() {}
    
    public func startChildCoordinator(_ child: Coordinator) {
        childCoordinators.append(child)
        child.start()
    }
    
    public func free(child: Coordinator) {
        for (offset, coordinator) in childCoordinators.enumerated() {
            if coordinator !== child { continue }
            childCoordinators.remove(at: offset)
        }
    }
    
    public func freeAllChildCoordinators() {
        self.childCoordinators.removeAll()
    }
}
