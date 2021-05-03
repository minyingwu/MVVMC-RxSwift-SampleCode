//
//  UIVIewController+notification.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/4/18.
//

import UIKit

extension UIViewController {
    
    func didBecomeActiveNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.becomeActiveAction), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func becomeActiveAction(_: NSNotification) {}
    
}


