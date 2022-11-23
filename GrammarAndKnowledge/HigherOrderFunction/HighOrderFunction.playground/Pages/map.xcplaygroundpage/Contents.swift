// MARK: - // Array, Dictionary, Set, Optional에 사용 가능
// MARK: - // 타입은 변하지 않고 값만 원하는 형태로 맵핑한다.
// MARK: - // 기존 컨테이너의 요소를 하나하나 매핑하고 새로운 배열에 담아 반환한다.
// MARK: - // func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]

import Foundation

var map_str = ["Hello", "World!"]
var map_result = map_str.map( { $0.uppercased() } )
print(map_result)               // map을 사용한 결과 -> ["HELLO", "WORLD!"]

var map_int = [1,2,3,4,5]
var map_int_result = map_int.map( { String($0) } )
print(map_int_result)           // map을 사용한 결과 -> ["1", "2", "3", "4", "5"]

var map_str_character = ["a","b","c","d","e"]
var map_str_character_result = map_str_character.map { Int($0) }
print(map_str_character_result)           // map을 사용한 결과 -> [nil, nil, nil, nil, nil]
print(type(of: map_str_character_result)) // 결과의 타입 -> Array<Optional<Int>>
