// MARK: - flatMap / compactMap 공통점 -> 1차원 배열에서 nil제거 옵셔널 바인딩
// MARK: - 차이점 -> flatMap는 2차원 배열을 1차원으로 flatten하게 만들어준다.
import Foundation

let array1 = [1, nil, 3, nil, 5, 6, 7]  // [Int?] 타입
let flatMapTest1 = array1.flatMap{ $0 }
let compactMapTest1 = array1.compactMap { $0 }

print("flatMapTest1 :", flatMapTest1)
print("compactMapTest1 :", compactMapTest1)

// <출력>
// flatMapTest1 : [1, 3, 5, 6, 7]
// compactMapTest1 : [1, 3, 5, 6, 7]

// MARK: - 2차원 배열을 1차원으로 만들어주는 flatMap
// MARK: - 2차원 배열일때 flatMap을 사용하면 다른것 안하고 1차원으로만 flatten하게 해준다.
let array2: [[Int?]] = [[1, 2, 3], [nil, 5], [6, nil], [nil, nil]]
let flatMapTest2 = array2.flatMap { $0 }
let compactMapTest2 = array2.compactMap { $0 }

print("flatMapTest2 :",flatMapTest2)
print("compactMapTest2 :",compactMapTest2)

// <출력>
// flatMapTest2 : [Optional(1), Optional(2), Optional(3), nil, Optional(5), Optional(6), nil, nil, nil]
// compactMapTest2 : [[Optional(1), Optional(2), Optional(3)], [nil, Optional(5)], [Optional(6), nil], [nil, nil]]

// MARK: - // flatMap과 compactMap을 같이 사용하는 경우
let array2: [[Int?]] = [[1, 2, 3], [nil, 5], [6, nil], [nil, nil]]
let flatMapTest2 = array2.flatMap { $0 }.compactMap{ $0 }

// <출력>
// flatMapTest2 : [1, 2, 3, 5, 6]
