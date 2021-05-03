//
//  UIBarButtonItem+style.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/5/2.
//
import UIKit

enum BarButtonItemType {
    case back
}

extension UIBarButtonItem {
    static func style(_ type: BarButtonItemType, style: UIBarButtonItem.Style = .plain, target: Any? = nil, action: Selector? = nil) -> UIBarButtonItem {
        switch type {
        case .back: return BackBarButtonItem()
        }
    }
}

class BackBarButtonItem: UIBarButtonItem {
    override init() {
        super.init()
        tintColor = .black
        title = "Back"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tintColor = .black
        title = "Back"
    }
}

