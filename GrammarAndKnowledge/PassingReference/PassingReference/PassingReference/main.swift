//
//  main.swift
//  PassingReference
//
//  Created by Kay on 2023/06/06.
//

import Foundation

// MARK: - inout 키워드를 사용해서 객체를 참조하는 방식으로 인자를 전달하면 실제로 해당 인자를 참조할까?
var arr = [Int]()
arr.append(1)
withUnsafePointer(to: &arr) {
    print("value \($0.pointee) has address: \($0)")
}
