//
//  CleanArchitectureSampleCodeTest.swift
//  CleanArchitectureSampleCodeTest
//
//  Created by Victor on 2021/5/3.
//

import XCTest
import RxSwift
import RxCocoa

@testable import BookMyMovie
class CleanArchitectureSampleCodeTest: XCTestCase {
    
    private var mockMovieRepository: MockMovieRepository!
    
    private var mockSearchMovieUseCase: SearchMovieUseCase!
    
    private var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockMovieRepository = MockMovieRepository()
        mockSearchMovieUseCase = SearchMovieUseCase(movieRepository: mockMovieRepository)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        mockMovieRepository = nil
        mockSearchMovieUseCase = nil
        disposeBag = nil
    }
    
    func test_fetching_movie_list() {
        guard let data = Mockata.movieListJson.data(using: .utf8),
              let movieList = try? JSONDecoder().decode(MovieList.self, from: data)
        else {
            XCTFail()
            return
        }
        
        var count: Int = -1
        mockMovieRepository.movieList = movieList
        mockSearchMovieUseCase
            .executingFetchList(sorted: .popularity, page: 1)
            .map { count = $0.results.count }
            .subscribe(onPossibleError: { _ in XCTFail() })
            .disposed(by: disposeBag)
        
        XCTAssertEqual(count, 2)
    }
    
    func test_fetch_movie_detail() {
        test_fetching_movie_list()
        guard let id = mockMovieRepository.movieList.results.first?.id
        else {
            XCTFail()
            return
        }
        XCTAssertEqual(id, 20982)
        
        guard let data = Mockata.movieDetailJson.data(using: .utf8),
              let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data)
        else {
            XCTFail()
            return
        }
        
        var genres: String? = ""
        var originalLanguage: String? = ""
        var runtime: Int = -1
        mockMovieRepository.movieDetail = movieDetail
        mockSearchMovieUseCase
            .executingFetchDetail(id: id)
            .map {
                genres = $0.genres.first?.name
                originalLanguage = $0.originalLanguage
                runtime = $0.runtime
            }
            .subscribe(onPossibleError: { _ in XCTFail() })
            .disposed(by: disposeBag)
        
        XCTAssertEqual(genres, "Family")
        XCTAssertEqual(originalLanguage, "ja")
        XCTAssertEqual(runtime, 94)
    }
    
}
