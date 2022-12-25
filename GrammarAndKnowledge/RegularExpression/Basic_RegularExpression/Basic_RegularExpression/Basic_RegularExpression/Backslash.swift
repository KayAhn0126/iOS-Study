//
//  Backslash.swift
//  Basic_RegularExpression
//
//  Created by Kay on 2022/12/25.
//

import Foundation

func specialCharacter(_ text: String, _ num: Int) {
    
    var desirePattern = ""
    if num == 1 {
        desirePattern = "^$"
    } else if num == 2 {
        desirePattern = #"\$"#
    } else if num == 3 {
        desirePattern = #"^\$"#
    } else if num == 4 {
        desirePattern = #"\$$"#
    } else if num == 5 {
        desirePattern = #"\\"#
    }

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
