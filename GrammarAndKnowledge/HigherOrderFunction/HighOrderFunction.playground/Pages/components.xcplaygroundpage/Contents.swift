// MARK: - // split과 비슷하게 separatedBy: 매개변수를 받아 문자 기준으로 쪼갠 결과를 Array<String> 으로 반환 해준다.
// MARK: - // components는 Foundation 프레임워크에 속해 있기 때문에 import Foundation 필수.
// MARK: - // func components(separatedBy separator: String) -> [String]
// MARK: - // separator를 기준으로 나누고 새로운 배열에 담아 반환

import Foundation

var test_str = "Hello World!"
var test_result = test_str.components(separatedBy: " ")
// " "로 나눈 결과를 Array<String> 타입에 담아 반환.
print(test_result)             // components를 실행한 결과 -> ["Hello", "World!"]
print(type(of: test_result))   // 결과의 타입 -> Array<String>
print(test_str)                // "Hello World!"
