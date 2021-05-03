//
//  Array+Safe.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/4/17.
//

import Foundation

extension Array {
    
    subscript(safe index: Int) -> Element? {
        if !indices.contains(index) { return nil }
        else { return self[index] }
    }
    
}
