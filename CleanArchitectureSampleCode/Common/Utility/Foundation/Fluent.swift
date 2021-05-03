//
//  Fluent.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/3/2.
//

import Foundation

@dynamicMemberLookup
struct Fluent<Subject> {
    let subject: Subject
    
    subscript<Value>(dynamicMember keyPath: WritableKeyPath<Subject, Value>) -> ((Value) -> Fluent) {
        var subject = self.subject
        return { value in
            subject[keyPath: keyPath] = value
            return Fluent(subject: subject)
        }
    }
}

postfix operator +

@discardableResult
postfix func + <T>(lhs: T) -> Fluent<T> {
    return Fluent(subject: lhs)
}
 
postfix operator -

@discardableResult
postfix func - <T>(lhs: Fluent<T>) -> T {
    return lhs.subject
}
