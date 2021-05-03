//
//  Relay+AsBinder.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/4/17.
//

import RxCocoa
import RxSwift

extension PublishRelay {
    func asBinder() -> Binder<Element> {
        return Binder<Element>(self) { relay, e in
            relay.accept(e)
        }
    }
}

extension BehaviorRelay {
    func asBinder() -> Binder<Element> {
        return Binder<Element>(self) { relay, e in
            relay.accept(e)
        }
    }
}
