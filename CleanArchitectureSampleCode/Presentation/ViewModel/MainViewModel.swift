//
//  MainViewModel.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/22.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel: ViewModel {
    
    let searchMovieUseCase: SearchMovieUseCase
    
    var movieItemsRelay = BehaviorRelay<[MovieItem]>(value: [])
    
    var errorRelay = PublishRelay<PossibleErrors?>()
    
    var isHiddenEmpty: Observable<Bool> { movieItemsRelay.map { $0.count > 0 } }
    
    var sortedRelay = BehaviorRelay<APIEndpoints.DiscoverSorted>(value: .popularity)
    
    var selectSorted: APIEndpoints.DiscoverSorted = .popularity {
        didSet {
            movieItemsRelay.accept([])
            nextPage = 1
        }
    }
    
    private var nextPage: Int = 1
    
    private lazy var disposeBag = DisposeBag()
    
    init(searchMovieUseCase: SearchMovieUseCase) {
        self.searchMovieUseCase = searchMovieUseCase
        super.init()
        setupBinding()
    }
    
    func query() -> Disposable {
        self.isLoading.accept(true)
        return searchMovieUseCase.executingFetchList(sorted: selectSorted, page: nextPage)
            .map { [weak self] result -> Void in
                self?.isLoading.accept(false)
                guard let self = self else { throw PossibleErrors.none }
                var currentItems = self.movieItemsRelay.value
                currentItems.append(contentsOf: result.results)
                self.movieItemsRelay.accept(currentItems)
                self.nextPage += 1 }
            .subscribe(onPossibleError: { [weak self] in
                self?.isLoading.accept(false)
                self?.errorRelay.accept($0)
            })
    }
    
    func setupBinding() {
        sortedRelay
            .bind(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.selectSorted = $0
                    self.query().disposed(by: self.disposeBag) })
            .disposed(by: disposeBag)
    }

}
