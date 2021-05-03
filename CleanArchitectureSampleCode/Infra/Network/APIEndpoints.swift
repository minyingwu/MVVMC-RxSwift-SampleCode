//
//  APIEndpoints.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/23.
//

import Foundation

fileprivate let tmdbUrl = "http://api.themoviedb.org/3"
fileprivate let imageUrl = "http://image.tmdb.org/t/p/original"
fileprivate let apiKey = "dbbc5f9c21cd388646a6c5455acc8b6c"

class APIEndpoints {
    
    static func getMovieList(sorted: DiscoverSorted, page: Int = 0) -> String {
        return tmdbUrl + "/discover/movie?" + "api_key=" + apiKey + "&primary_release_date.lte=2016-12-31" + "&sort_by=" + sorted.path + "&page=\(page)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    static func getMoiveDetail(id: Int) -> String {
        return tmdbUrl + "/movie/\(id)?" + "api_key=" + apiKey
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    static func getImage(path: String) -> String {
        return imageUrl + path
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    static func getBooking() -> String {
        return "https://www.cathaycineplexes.com.sg/"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    enum DiscoverSorted: Int {
        case popularity
        case releaseDate
        case voteCount
    }
    
}

extension APIEndpoints.DiscoverSorted {
    var path: String {
        switch self {
        case .popularity:
            return "popularity.desc"
        case .releaseDate:
            return "release_date.desc"
        case .voteCount:
            return "vote_count.desc"
        }
    }
}
