//
//  CaseSensitive.swift
//  Basic_RegularExpression
//
//  Created by Kay on 2022/12/25.
//

import Foundation

// MARK: - Regular expressions are case sensitive.
func caseSensitive(_ text: String) -> Bool {
    let desirePattern = "Hello"
    
    let regex = try? NSRegularExpression(pattern: desirePattern)
    let range = NSRange(location: 0, length: text.count)
    
    if regex?.firstMatch(in: text, range: range) != nil {
        return true
    } else {
        return false
    }
    if regex?.matches(in: text, range: range) != Optional([]) {
        return true
    } else {
        return false
    }
}

// firstMatch 메서드의 반환형은 NSTextCheckingResult? 그래서 nil인지 확인
// matches 메서드의 반환형은 [NSTextCheckingResult] 하지만 regex?.matches(..)의 옵셔널 때문에 매치하는것이 없다면 Optional([])을  반환한다. regex!.matches를 사용하고 매치하는것이 없다면 []을 반환한다.

