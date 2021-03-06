//
//  BarButtonItemable.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/5/2.
//

import UIKit

public enum BarButtonPosition {
    case left
    case right
}

@objc public protocol BarButtonItemable: class {
    var barButtonItems: [UIBarButtonItem] { get set }
    
    @objc optional func pressedRightBarButtonItems(_ sender: UIBarButtonItem)
    @objc optional func pressedLeftBarButtonItems(_ sender: UIBarButtonItem)
}

extension BarButtonItemable where Self: UIViewController {
    
    func bind(position: BarButtonPosition, barButtonItems: UIBarButtonItem?...) -> Self {

        if barButtonItems.contains(nil) {
            navigationItem.hidesBackButton = true
            return self
        }
        
        let actionButtonItems = barButtonItems
            .compactMap{ $0 }
            .map { [weak self] (buttonItem) -> UIBarButtonItem in
                guard let self = self else { return buttonItem }
                switch position {
                case .left:
                    if !self.responds(to: #selector(self.pressedLeftBarButtonItems(_:))) { break }
                    buttonItem.actionHandler({ [weak self] _ in
                        self?.pressedLeftBarButtonItems?(buttonItem)
                    })
                case .right:
                    if !self.responds(to: #selector(self.pressedRightBarButtonItems(_:))) { break }
                    buttonItem.actionHandler({ [weak self] _ in
                        self?.pressedRightBarButtonItems?(buttonItem)
                    })
                }
                return buttonItem
        }
        
        switch position {
        case .left: self.navigationItem.leftBarButtonItems = actionButtonItems
        case .right: self.navigationItem.rightBarButtonItems = actionButtonItems
        }
        
        self.barButtonItems.append(contentsOf: actionButtonItems)
        return self
    }
}
