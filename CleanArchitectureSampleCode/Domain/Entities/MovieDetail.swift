//
//  MovieDetail.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/4/28.
//

import Foundation

struct MovieDetail: Codable {
    let genres: [Genres]
    let originalLanguage: String
    let overview: String
    let runtime: Int
    
    var posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case genres
        case originalLanguage = "original_language"
        case overview
        case runtime
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decodeWrapper(key: .genres, defaultValue: [])
        originalLanguage = try container.decodeWrapper(key: .originalLanguage, defaultValue: "N/A")
        overview = try container.decodeWrapper(key: .overview, defaultValue: "...")
        runtime = try container.decodeWrapper(key: .runtime, defaultValue: 0)
    }
}

struct Genres: Codable {
    let name: String?
}


