//
//  RxOperator.swift
//  CleanArchitectureSampleCode
//
//  Created by Victor on 2021/2/24.
//

import UIKit
import RxSwift
import RxCocoa

infix operator <-> : DefaultPrecedence

func nonMarkedText(_ textInput: UITextInput) -> String? {
    let start = textInput.beginningOfDocument
    let end = textInput.endOfDocument
    
    guard let rangeAll = textInput.textRange(from: start, to: end),
          let text = textInput.text(in: rangeAll)
    else { return nil }
    
    guard let markedTextRange = textInput.markedTextRange else { return text }
    
    guard let startRange = textInput.textRange(from: start, to: markedTextRange.start),
          let endRange = textInput.textRange(from: markedTextRange.end, to: end)
    else { return text }
    
    return (textInput.text(in: startRange) ?? "") + (textInput.text(in: endRange) ?? "")
}

func <-> <Base>(textInput: TextInput<Base>, relay: BehaviorRelay<String>?) -> Disposable {
    guard let relay = relay else { return Disposables.create() }
    
    let bindToUIDisposable = relay.bind(to: textInput.text)
    
    let bindToRelay = textInput.text
        .subscribe(onNext: { [weak base = textInput.base] n in
            guard let base = base else { return }
            let nonMarkedTextValue = nonMarkedText(base)
            
            if let nonMarkedTextValue = nonMarkedTextValue,
                   nonMarkedTextValue != relay.value {
                relay.accept(nonMarkedTextValue) }
            
        }, onCompleted: {
            bindToUIDisposable.dispose()
        })
    return Disposables.create(bindToUIDisposable, bindToRelay)
}
