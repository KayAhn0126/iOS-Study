// MARK: - // 필터링 또는 추출
// MARK: - // 기존 컨테이너의 요소를 하나하나 판별하고 조건에 맞는 요소는 새로운 컨테이너에 담아 반환한다.
// MARK: - // func filter(_ isIncluded: (Self.Element) throws -> Bool) rethrows -> [Self.Element]

import Foundation

var filter_str = "Hello World!"
var filter_result = filter_str.filter { $0.asciiValue! >= 97 }
print(filter_result)                     // 문자열에 filter를 사용한 결과 -> elloorld

var filter_str_arr = ["A", "B", "C", "D", "E"]
var filter_str_arr_result = filter_str_arr.filter( { $0 == "B"} )
print(filter_str_arr_result)             // 문자열 배열에 filter를 사용한 결과 -> ["B"]

var filter_int_arr = [100, 300, 500, 700, 900]
var filter_int_arr_result = filter_int_arr.filter( { $0 >= 500 } )
print(filter_int_arr_result)            // 정수형 배열에 filter를 사용한 결과 -> [500, 700, 900]
