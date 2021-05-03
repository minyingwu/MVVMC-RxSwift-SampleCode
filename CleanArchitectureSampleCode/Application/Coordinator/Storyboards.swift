//
//  Storyboards.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/17.
//

import Foundation

enum Storyboards: String {
    case Main
    
    static subscript( storyboards: Storyboards) -> String {
        return storyboards.string
    }
}

extension Storyboards {
    var string: String { self.rawValue }
}

