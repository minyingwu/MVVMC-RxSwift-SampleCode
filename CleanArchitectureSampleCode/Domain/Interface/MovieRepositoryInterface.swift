//
//  MovieRepositoryInterface.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol MovieRepositoryInterface {
    func fetchMovieList(sorted: APIEndpoints.DiscoverSorted, with page: Int) -> Single<MovieList>
    func fetchMovieDetail(with id: Int) -> Single<MovieDetail>
}
