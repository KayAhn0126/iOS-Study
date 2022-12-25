//
//  main.swift
//  Basic_RegularExpression
//
//  Created by Kay on 2022/12/25.
//

import Foundation

// MARK: - 정규표현식은 대소문자 구분!
caseSensitive("Hello") // pass
print("")
caseSensitive("hello") // fail
print("")


// MARK: - 정규표현식은 공백 구분!
whiteSpaceSensitive("Hello World!") // pass
print("")
whiteSpaceSensitive("Hello   World!") // fail
print("")


// MARK: - ^(carrot)뒤 문자열은 해당 문자열로 시작해야함!
textStartsWith("who is who") // pass
print("")
textStartsWith("what is who") // fail
print("")


// MARK: - $(dollar sign)앞 문자열은 해당 문자열로 끝나야함!
textEndsWith("who is who") // pass
print("")
textEndsWith("who is what") // fail


// MARK: - ^$ -> 시작(^)과 끝($) 사이에 아무것도 없음!
specialCharacter(#"$12$ \-\ $25$"#, 1) // 아무것도 매치 되는것 없음

// MARK: - \$ -> 특수문자 앞에 붙이는 \ 기호와 $가 만나 \$ 되는데, $ 기호들만 매칭
specialCharacter(#"$12$ \-\ $25$"#, 2)

// MARK: - ^\$ -> 맨 앞 달러 싸인만 매칭
specialCharacter(#"$12$ \-\ $25$"#, 3)

// MARK: - \$$ -> 끝에 있는 달러싸인만 매칭
specialCharacter(#"$12$ \-\ $25$"#, 4)

// MARK: - \\ -> 역 슬래쉬만 매칭
specialCharacter(#"$12$ \-\ $25$"#, 5)



