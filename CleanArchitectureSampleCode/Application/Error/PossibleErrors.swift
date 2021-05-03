//
//  PossibleErrors.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/23.
//

import Foundation

enum PossibleErrors: Error {
    case none
}

extension PossibleErrors: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .none: return LString(ServiceError.unknowError.localizeKey)
        }
    }
    
}

enum ServiceError: String {
    case unknowError
    
    var localizeKey: String {
        switch self {
        case .unknowError: return "Err_Msg_Gen_Response_Failed_Message"
        }
    }
}
