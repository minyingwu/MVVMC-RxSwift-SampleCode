//
//  Enum+Orderable.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/5/1.
//

import Foundation

protocol Orderable: CaseIterable, Comparable {}

extension Orderable {
    var nextCase: Self? {
        let allCase = Self.allCases
        return allCase.filter { $0 > self }.first
    }
    
    var previousCase: Self? {
        let allCase = Self.allCases
        return allCase.filter { $0 < self }.last
    }
}

