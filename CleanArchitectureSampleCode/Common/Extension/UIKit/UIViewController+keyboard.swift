//
//  UIViewController+keyboard.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/4/17.
//

import UIKit

extension UIViewController {
    
    func setKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
}
