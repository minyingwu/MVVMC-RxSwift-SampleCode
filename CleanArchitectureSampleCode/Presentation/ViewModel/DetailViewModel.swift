//
//  DetailViewModel.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/5/1.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: ViewModel {
    
    let searchMovieUseCase: SearchMovieUseCase
    
    let movieItem: MovieItem
    
    var movieDetailRelay = PublishRelay<MovieDetail>()
    
    var errorRelay = PublishRelay<PossibleErrors?>()
    
    init(searchMovieUseCase: SearchMovieUseCase, movieItem: MovieItem) {
        self.searchMovieUseCase = searchMovieUseCase
        self.movieItem = movieItem
        super.init()
    }
    
    func query() -> Disposable {
        self.isLoading.accept(true)
        return searchMovieUseCase.executingFetchDetail(id: movieItem.id)
            .map { [weak self] result -> Void in
                self?.isLoading.accept(false)
                guard let self = self else { throw PossibleErrors.none }
                var result = result
                result.posterPath = self.movieItem.posterPath
                self.movieDetailRelay.accept(result) }
            .subscribe(onPossibleError: { [weak self] in
                self?.isLoading.accept(false)
                self?.errorRelay.accept($0)
            })
    }
    
}
