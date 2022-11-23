// MARK: - components + compactMap

import Foundation

var equation = "1+2-3*4/5"
var equation_with_compactMap_result = equation.components(separatedBy: ["+","-","*","/"]).compactMap { Int($0) }

// equation_with_compactMap_result = equation.components(separatedBy: ["+","-","*","/"])의 결과는
// ["1","2","3","4","5"] 이다.

// compactMap을 사용해 ["+","-","*","/"]로 나눈 결과에서 옵셔널을 제거하고 Int타입으로 반환
print(type(of: equation_with_compactMap_result))                // Array<Int>
print(equation_with_compactMap_result)                         // [1, 2, 3, 4, 5]
print(equation_with_compactMap_result[0] + equation_with_compactMap_result[1]) // 3

// 만약 compactMap이 아니라 map을 썼다면?
var equation_with_map_result = equation.components(separatedBy: ["+","-","*","/"]).map { Int($0) }
print(type(of: equation_with_map_result))                      // Array<Optional<Int>>
print(equation_with_map_result) // [Optional(1), Optional(2), Optional(3), Optional(4), Optional(5)]
// map을 사용하면 숫자로 바꿀수 없는 경우 nil이 나온다! -> 문자열을 숫자로 바꿔줄때는 compactMap을 사용!
