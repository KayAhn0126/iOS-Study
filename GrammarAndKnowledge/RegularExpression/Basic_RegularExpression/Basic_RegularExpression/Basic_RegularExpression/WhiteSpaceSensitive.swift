//
//  WhiteSpaceSensitive.swift
//  Basic_RegularExpression
//
//  Created by Kay on 2022/12/25.
//

import Foundation

// MARK: - Each character inside the search pattern is significant including whitespace characters (space, tab, new line).
func whiteSpaceSensitive(_ text: String) {
    let desirePattern = "Hello World!"

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
