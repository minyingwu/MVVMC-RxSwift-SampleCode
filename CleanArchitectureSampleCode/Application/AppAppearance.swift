//
//  AppAppearance.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/18.
//

import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UITabBar.appearance().isTranslucent = false
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UINavigationBar {

    func setupAppearance(barTintColor: UIColor = .clear) {
        shadowImage = UIImage()
        self.barTintColor = barTintColor
        superview?.backgroundColor = barTintColor

        if barTintColor != .clear { return }
        isTranslucent = true
        setBackgroundImage(shadowImage, for: .default)
    }
}
