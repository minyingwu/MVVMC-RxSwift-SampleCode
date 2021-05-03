//
//  Configurable.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/23.
//

import UIKit

public protocol Configurable {
    associatedtype Item
    
    func configure(_ item: Item) -> Self
}
