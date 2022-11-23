// MARK: - // 결합
// MARK: - // 주어진 클로져를 사용해 연속된 요소들을 합친 결과를 반환하는 메서드
/*
 
 func reduce<Result>(
     _ initialResult: Result,
     _ nextPartialResult: (Result, Self.Element) throws -> Result
 ) rethrows -> Result
 
 */
// MARK: - // initialResult : 값이 누적될 초기값. initialResult 매개변수는 첫 클로져가 실행될때 nextPartialResult로 넘겨진다.
// MARK: - // nextPartialResult : 누적값을 계속 결합시킬 클로져.

import Foundation

var reduce_int = [1,2,3,4,5]
var reduce_int_result = reduce_int.reduce(0, +)
print(reduce_int_result)
