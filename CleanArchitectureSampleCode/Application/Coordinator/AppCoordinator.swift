//
//  AppCoordinator.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/17.
//

import UIKit

class AppCoordinator {
    var window: UIWindow
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController? = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    private func initialize<T: Coordinator>(coordinator: T) {
        freeAllChildCoordinators()
        startChildCoordinator(coordinator)
    }
}

extension AppCoordinator: Coordinator {
    
    func start() {
        initialize(coordinator:
                    MainCoordinator(window: window, parentCoordinator: self))
    }
    
}

