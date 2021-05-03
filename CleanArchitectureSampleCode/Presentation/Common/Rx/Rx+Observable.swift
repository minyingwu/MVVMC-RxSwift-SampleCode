//
//  Rx+Observable.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/5/1.
//

import RxSwift
import RxCocoa

extension Observable {
    
    public func unwrap<Result>() -> Observable<Result> where Element == Result? {
        return self.filter { $0 != nil }.map { $0! }
    }
    
}
