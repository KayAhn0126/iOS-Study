import UIKit





// 일반 숫자를 세자리마다 "," 추가해서 나타내고 싶을때

//let numberFormatter = NumberFormatter()
//numberFormatter.numberStyle = .decimal
//let testNumber = 12345678
//let result = numberFormatter.string(for: testNumber)
//print(result) // Optional(12,345,678)





// 소수를 세자리마다 "," 추가해서 나타내고 싶을때

//let numberFormatter = NumberFormatter()
//numberFormatter.numberStyle = .decimal
//
//let result = numberFormatter.string(for: 12345678.12345678)
//print(result)  // Optional(12,345,678.123)





// 소수를 세자리마다 "," 추가해서 나타내고 싶을때 + maximumFractionDigits 프로퍼티 사용

//let numberFormatter = NumberFormatter()

//numberFormatter.numberStyle = .decimal
//numberFormatter.maximumFractionDigits = 8
//
//let testNumber = 12345678.12345678
//let result = numberFormatter.string(for: testNumber)
//print(result) // Optional(12,345,678.12345678)





// 소수를 세자리마다 "," 추가해서 나타내고 싶을때 + maximumFractionDigits 반올림 케이스

//let numberFormatter = NumberFormatter()
//
//numberFormatter.numberStyle = .decimal
//numberFormatter.maximumFractionDigits = 7
//
//let testNumber = 12345678.12345678
//let result = numberFormatter.string(for: testNumber)
//print(result) // Optional(12,345,678.1234568) -> 7자리 까지 끊고 마지막 자리 반올림


// roundingMode 프로퍼티 사용으로 소수점 처리

// ceiling + without maximumSignificantDigits -> 무조건 정수로 나옴
//let numberFormatter = NumberFormatter()
//numberFormatter.roundingMode = .ceiling
//let result = numberFormatter.string(for: 1234567.123456)
//print(result) // Optional("1234568") -> 소수 부분이 1 이상이면 소수를 모두 버리고 정수 + 1
//let result2 = numberFormatter.string(for: 1234567.0)
//print(result2) // Optional("1234567") -> 소수 부분이 0이기 때문에 정수 그대로 출력




// ceiling + maximumSignificantDigits -> 자릿수에 맞춰 올림

//let numberFormatter = NumberFormatter()
//numberFormatter.roundingMode = .ceiling
//numberFormatter.maximumFractionDigits = 2
//let result = numberFormatter.string(for: 1234567.123456)
//print(result) // Optional("1234568") -> 소수 부분이 1 이상이면 소수를 모두 버리고 정수 + 1
//let result2 = numberFormatter.string(for: 1234567.654321)
//print(result2) // Optional("1234567") -> 소수 부분이 0이기 때문에 정수 그대로 출력

