//
//  MockMovieRepository.swift
//  CleanArchitectureSampleCodeTest
//
//  Created by Victor on 2021/5/3.
//

import Foundation
import RxSwift
import RxCocoa

@testable import BookMyMovie
class MockMovieRepository: MovieRepositoryInterface {
    
    var movieList: MovieList!
    var movieDetail: MovieDetail!
    
    func fetchMovieList(sorted: APIEndpoints.DiscoverSorted, with page: Int) -> Single<MovieList> {
        Single.just(movieList)
    }
    
    func fetchMovieDetail(with id: Int) -> Single<MovieDetail> {
        Single.just(movieDetail)
    }
    
}
