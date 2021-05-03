//
//  MovieRepository.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/23.
//

import Foundation
import RxSwift
import RxCocoa

class MovieRepository: MovieRepositoryInterface {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchMovieList(sorted: APIEndpoints.DiscoverSorted, with page: Int) -> Single<MovieList> {
        guard let url = URL(string: APIEndpoints.getMovieList(sorted: sorted, page: page))
        else { return Single.error(PossibleErrors.none) }
        
        return Single<MovieList>.create { [weak self] single in
            self?.networkService.get(url: url) { (data, _, error) in
                if error != nil {
                    single(.failure(PossibleErrors.none))
                    return
                }
                guard let data = data,
                      let movieList = try? JSONDecoder().decode(MovieList.self, from: data)
                else {
                    single(.failure(PossibleErrors.none))
                    return
                }
                single(.success(movieList))
            }
            
            return Disposables.create {}
        }
    }
    
    func fetchMovieDetail(with id: Int) -> Single<MovieDetail> {
        guard let url = URL(string: APIEndpoints.getMoiveDetail(id: id))
        else { return Single.error(PossibleErrors.none) }
        
        return Single<MovieDetail>.create { [weak self] single in
            self?.networkService.get(url: url) { (data, _, error) in
                if error != nil {
                    single(.failure(PossibleErrors.none))
                    return
                }
                guard let data = data,
                      let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data)
                else {
                    single(.failure(PossibleErrors.none))
                    return
                }
                single(.success(movieDetail))
            }
            
            return Disposables.create {}
        }
    }
    
}
