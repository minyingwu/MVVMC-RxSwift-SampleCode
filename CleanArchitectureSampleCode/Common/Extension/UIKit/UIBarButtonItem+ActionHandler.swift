//
//  UIBarButtonItem+ActionHandler.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/5/2.
//

import UIKit

@objc class ClosureSleeve: NSObject {
    let item : UIBarButtonItem
    let closure: (UIBarButtonItem) -> ()

    init (_ item: UIBarButtonItem, _ closure: @escaping (UIBarButtonItem) -> ()) {
        self.item = item
        self.closure = closure
    }

    @objc func invoke () {
        closure(item)
    }
}
extension UIBarButtonItem {
    func actionHandler(_ action: @escaping (UIBarButtonItem) -> Void) {
        let sleeve = ClosureSleeve(self, action)
        self.target = sleeve
        self.action = #selector(ClosureSleeve.invoke)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

