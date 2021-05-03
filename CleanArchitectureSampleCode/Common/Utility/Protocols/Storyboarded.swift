//
//  Storyboarded.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/17.
//

import UIKit

public protocol Storyboarded {
    static func instantiate(_ storyboardName: String) -> Self
}

public extension Storyboarded where Self: UIViewController {
    
    static func instantiate(_ storyboardName: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
}
