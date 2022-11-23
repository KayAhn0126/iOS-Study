// MARK: - // split이란 말 그대로 separator를 기준으로 나누는것.
// MARK: - // swift 표준 라이브러리에 들어있어 Foundation을 import하지 않아도 된다.
// MARK: - // Array<Substring>으로 반환

import Foundation

var split_str = "Hello World!"
var split_result = split_str.split(separator: " ")
// 위와 같이 split만 사용하면 split_result은 Array<Substring> 타입이다.
print(split_result) // ["Hello", "World!"] -> 헷갈리지 말자 Array<String> 같지만 Array<Substring>이다.
print(type(of: split_result)) // Array<Substring>

// 아무래도 Substring 형태로 나오면 불편하다..
// 마지막에 map을 사용해서 Array<String> 타입으로 만들어주자!
// String 타입으로 바꿔주자!
var split_arr2 = split_str.split(separator: " ").map({ String($0) })
print(split_arr2) // ["Hello", "World!"] -> Array<String> 타입.
print(type(of: split_arr2)) // Array<String>
