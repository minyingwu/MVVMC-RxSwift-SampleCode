//
//  String+Utility.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/25.
//

import Foundation

public func LString(_ string: String, _ parameter: String? = nil) -> String {
    if let parameter = parameter {
        return String(format: NSLocalizedString(string, comment: ""), parameter)
    }else {
        return NSLocalizedString(string, comment: "")
    }
}
