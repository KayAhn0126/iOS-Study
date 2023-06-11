//
//  main.swift
//  PassingReference
//
//  Created by Kay on 2023/06/06.
//

import Foundation

// MARK: - 먼저 객체의 주소를 얻는 방법에 대해서 알아보자!
// 일반적으로 인스턴스의 주소를 알기 위한 방법
var test = 10
withUnsafePointer(to: &test) { x in
    print(x)
}

// Unsafe는 왜 붙는걸까? -> 메모리에 직접적으로 접근한다는것은 unsafe하기 때문에.

// UnsafePointer는 타입을 사용해서 참조를 하면 특정 타입 + 해당 값을 바꿀 수 없다. 아래의 예시를 보자!
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


// UnsafeRawPointer는 타입을 사용해서 참조를 하면 모든 타입을 받을 수 있다. 하지만 포인터가 가르키고 있는 메모리내 값은 변경 불가!
func takesARawPointer(_ p: UnsafeRawPointer) {
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


// UnsafeMutablePointer 타입을 사용하면 특정 타입 + 포인터가 가르키고 있는 값을 변경할 수 있다! -> 아래의 예시를 보자.
func takesAMutablePointer(_ p: UnsafeMutablePointer<Int>) {
    print(p, p.pointee)
    p.pointee = 1000
    print(p, p.pointee)
}
var testNum1 = 10
takesAMutablePointer(&testNum1)

// 그럼.. 모든 포인터 타입을 다 받을수 있으면서 값까지 변경가능한 타입은..?
// UnsafeMutableRawPointer !!!

// MARK: 여기서 부터 다시 정리하기!!
func takesAMutableRawPointer(_ p: UnsafeMutableRawPointer) {
    print(p, p.load(as: Int.self))
    p.storeBytes(of: 0x00000000, as: Int.self)
    print(p, p.load(as: Int.self))
}
print("")
var testNum2 = 10
takesAMutableRawPointer(&testNum2)



// MARK: - inout 키워드를 사용해서 객체를 참조하는 방식으로 인자를 전달하면 실제로 해당 인자를 참조할까?


