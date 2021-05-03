//
//  MainCoordinator.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/5/1.
//

import UIKit

class MainCoordinator {
    
    enum Step: Orderable {
        case main
        case detail
    }
    
    var window: UIWindow
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController? = UINavigationController()
    
    private var currentStep: Step? = .main
    private lazy var networkService: NetworkService = NetworkService()
    
    var movieItem: MovieItem!
    
    init(window: UIWindow, parentCoordinator: AppCoordinator) {
        self.window = window
        self.parentCoordinator = parentCoordinator
        self.navigationController?.navigationBar.setupAppearance()
    }
    
    private func makeMainVC() -> UIViewController {
        return MainViewController
            .instantiate(Storyboards[.Main])
            .bind(viewModel: MainViewModel(searchMovieUseCase: makeUseCase()))
            .bind(self)
    }
    
    private func makeDetailVC() -> UIViewController {
        return DetailViewController
            .instantiate(Storyboards[.Main])
            .bind(viewModel: DetailViewModel(searchMovieUseCase: makeUseCase(), movieItem: movieItem))
            .bind(position: .left, barButtonItems: .style(.back))
            .bind(self)
    }
    
    private func makeDestinationVC(step: Step) -> UIViewController? {
        currentStep = step
        switch step {
        case .main: return makeMainVC()
        case .detail: return makeDetailVC()
        }
    }
    
    private func transitionToVC(step: Step) {
        guard let nextVC = makeDestinationVC(step: step) else { return }
        switch step {
        case .main:
            navigationController?.setViewControllers([nextVC], animated: false)
        case .detail:
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}

extension MainCoordinator {
    private func makeUseCase() -> SearchMovieUseCase {
        return SearchMovieUseCase(movieRepository: MovieRepository(networkService: networkService))
    }
}

extension MainCoordinator: Coordinator {
    
    func start() {
        transitionToVC(step: .main)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func toPrevious() {
        guard let previousStep = currentStep?.previousCase else {
            return
        }
        currentStep = previousStep
        navigationController?.popViewController(animated: true)
    }
    
    func toNext() {
        guard let nextStep = currentStep?.nextCase else {
            return
        }
        transitionToVC(step: nextStep)
    }
    
}

