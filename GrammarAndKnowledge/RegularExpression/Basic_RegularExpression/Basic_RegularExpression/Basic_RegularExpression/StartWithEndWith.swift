//
//  StartWithEndWith.swift
//  Basic_RegularExpression
//
//  Created by Kay on 2022/12/25.
//

import Foundation

// MARK: - Some characters have special meanings. Character ^ matches the beginning of the line (Case 1) while dollar sign $ the end of the line (Case 2)
func textStartsWith(_ text: String) {
    let desirePattern = "^who"

    let regex = try? NSRegularExpression(pattern: desirePattern)
    let range = NSRange(location: 0, length: text.count)
    
    if regex?.firstMatch(in: text, range: range) != nil {
        print("First Match success: \(text)")
    } else {
        print("First Match fail: \(text)")
    }
    if regex?.matches(in: text, range: range) != Optional([]) {
        print("Match success: \(text)")
    } else {
        print("Match fail: \(text)")
    }
}

func textEndsWith(_ text: String) {
    let desirePattern = "who$"

    let regex = try? NSRegularExpression(pattern: desirePattern)
    let range = NSRange(location: 0, length: text.count)
    
    if regex?.firstMatch(in: text, range: range) != nil {
        print("First Match success: \(text)")
    } else {
        print("First Match fail: \(text)")
    }
    if regex?.matches(in: text, range: range) != Optional([]) {
        print("Match success: \(text)")
    } else {
        print("Match fail: \(text)")
    }
}
