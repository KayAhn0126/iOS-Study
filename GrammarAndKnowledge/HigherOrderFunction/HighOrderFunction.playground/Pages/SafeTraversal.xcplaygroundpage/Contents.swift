// MARK: - // 배열의 요소수 만큼 안전하게 순회하기
// MARK: - // enumerated(), indices, count를 이용해 인덱스와 값 출력하기
import Foundation

// 주어진 배열
let nums: [Int] = [1, 2, 3, 4]

// MARK: - // for in 과 같이 사용하는 예제
for (index, num) in nums.enumerated() {
    print("(index: \(index) num: \(num))")
}
// (index: 0 num: 1)
// (index: 1 num: 2)
// (index: 2 num: 3)
// (index: 3 num: 4)

for index in nums.indices {
    print("(index: \(index) num: \(nums[index]))")
}
// 결과는 위와 같다.

for index in 0..<nums.count {
    print("(index: \(index) num: \(nums[index]))")
}
// 결과는 위와 같다.


// MARK: - // forEach와 같이 사용하는 예제
nums.enumerated().forEach {
    print("(index: \($0) num: \($1))")
    // (index: 0 num: 1)
    // (index: 1 num: 2)
    // (index: 2 num: 3)
    // (index: 3 num: 4)
}

nums.indices.forEach {
    print("(index: \($0) num: \(nums[$0]))")
}
// 결과는 위와 같다.



// MARK: - for in과 forEach의 차이점
/*
 애플 공식문서에서는 for - in과 for - Each를 사용할 때 다른점 2가지를 보여주고 있다.
    continue / break
        for - in으로 구현된 반복문에서만 사용가능. 왜? continue or break는 반복문에서만 사용 가능.
        그럼 for - Each는??
        애플 공식문서에 따르면 "Calls the given closure on each element in the sequence in the same order as a for-in loop."라고 한다. 즉, 주어진 클로져를 각각의 요소마다 부르는것.
    return
        for - in으로 구현된 반복문에서 return은 해당 반복문을 빠져나온다(종료)
        하지만 클로져 내에서 return은 현재 클로져만 종료시킨다. -> 즉, 다음 클로져는 그대로 실행.
 */
