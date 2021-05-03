//
//  MovieList.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/4/28.
//

import Foundation

struct MovieList: Codable {
    let results: [MovieItem]
    let totalPages: Int
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        case page
    }
}

struct MovieItem: Codable {
    let id: Int
    let popularity: Float
    let title: String
    let posterPath: String
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case popularity
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeWrapper(key: .id, defaultValue: 0)
        popularity = try container.decodeWrapper(key: .popularity, defaultValue: 0.0)
        title = try container.decodeWrapper(key: .title, defaultValue: "")
        posterPath = try container.decodeWrapper(key: .posterPath, defaultValue: "")
        backdropPath = try container.decodeWrapper(key: .backdropPath, defaultValue: "")
    }
    
}
