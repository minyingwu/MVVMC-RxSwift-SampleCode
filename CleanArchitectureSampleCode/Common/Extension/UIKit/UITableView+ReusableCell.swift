//
//  UITableView+ReusableCell.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/25.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(withIdentifier identifier: String = String(describing: T.self), type: T.Type) -> T {
        self.dequeueReusableCell(withIdentifier: identifier) as! T
    }
    
    func cellForRow<T: UITableViewCell>(type: T.Type, at indexPath: IndexPath) -> T {
        self.cellForRow(at: indexPath) as! T
    }
    
    func setTransparentFooter() {
        tableFooterView = UIView()
        tableFooterView?.backgroundColor = .clear
    }
    
}
