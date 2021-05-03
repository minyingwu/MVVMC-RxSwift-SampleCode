//
//  Single+SingleTrait.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/25.
//

import RxSwift
import RxCocoa

extension Single where PrimitiveSequence.Trait == RxSwift.SingleTrait {
    
    func subscribe(onSuccess: ((Self.Element) -> Void)? = nil,
                   onFailure: ((Error) -> Void)? = nil ,
                   onPossibleError: ((PossibleErrors) -> Void)?) -> Disposable {
        let e: (Error) -> (Void) = { error in
            if let e = error as? PossibleErrors {
                onPossibleError?(e)
            }else {
                onFailure?(error)
            }
        }
        return subscribe(onSuccess: onSuccess, onFailure: e)
    }
    
}
