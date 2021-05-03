//
//  SearchMovieUseCase.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/23.
//

import Foundation
import RxSwift
import RxCocoa

class SearchMovieUseCase {
    
    private let movieRepository: MovieRepositoryInterface
    
    init(movieRepository: MovieRepositoryInterface) {
        self.movieRepository = movieRepository
    }
    
    func executingFetchList(sorted: APIEndpoints.DiscoverSorted, page: Int) -> Single<MovieList> {
        return movieRepository.fetchMovieList(sorted: sorted, with: page)
    }
    
    func executingFetchDetail(id: Int) -> Single<MovieDetail> {
        return movieRepository.fetchMovieDetail(with: id)
    }
    
}


