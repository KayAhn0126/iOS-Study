//
//  main.swift
//  PassingReference
//
//  Created by Kay on 2023/06/06.
//

import Foundation

// MARK: - 먼저 객체의 주소를 얻는 방법에 대해서 알아보자!

// UnsafePointer<Type> 타입을 인자로 넘겨줘야 하는 함수
// 이때 넘겨주는 인자는 변수이건, 배열이건 타입만 맞으면 된다.
func takesAPointer(_ p: UnsafePointer<Float>) {
    print(p)
    print(p.pointee)
}

var x: Float = 0.0
takesAPointer(&x)
var xArr: [Float] = [1.0, 2.0, 3.0]
takesAPointer(&xArr)
takesAPointer(&xArr[1])

/*
 맞지 않는 타입을 포인터로 넘기면 받을수 없다.
var y: Int = 1
takesAPointer(&y)
var yArr: [Int] = [1,3,5]
takesAPointer(&yArr)
*/


func takesARawPointer(_ p: UnsafeRawPointer)  {
    print(p)
    print(p.load(as: Float.self))
}

var testFloat: Float = 3.5, testInt: Int = 5
takesARawPointer(&testFloat)
takesARawPointer(&testInt)
takesARawPointer([1.0, 2.0, 3.0] as [Float])

var intArray = [1, 2, 3]
takesARawPointer(intArray)
takesARawPointer("How are you today?")


// MARK: - inout 키워드를 사용해서 객체를 참조하는 방식으로 인자를 전달하면 실제로 해당 인자를 참조할까?

var test = 10
withUnsafePointer(to: &test) { x in
    print(x)
}
