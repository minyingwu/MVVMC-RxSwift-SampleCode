//
//  Refreshable.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/5/3.
//

import UIKit

@objc public protocol Refreshable {
    var mainTableView: UITableView! { get set }
    var refreshControl: UIRefreshControl? { get set }
    
    func handleRefresh(_ sender: Any)
}

public extension Refreshable where Self: UIViewController {
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.black.withAlphaComponent(0.2)
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
        
        if #available(iOS 10.0, *) {
            mainTableView.refreshControl = refreshControl
        }else {
            mainTableView.backgroundView = refreshControl
        }
    }
    
}
