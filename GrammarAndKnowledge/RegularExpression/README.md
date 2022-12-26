# Regular Expression
- [정규식 연습 사이트](https://regex101.com

## 🍎 정규식은 크게 2가지로 만들 수 있다.
- **NSRegularExpression**
    - 유니코드 문자열에 적용되는 정규식의 표현 -> 정규식
    - 문자열 관련 문제를 풀 때 정규 표현식은 NSRegularExpression
- **NSPredicate**
    - 메모리 내 필터링이나 검색을 통한 패치 -> Collection안의 내용을 검색 혹은 필터하는 용도
    - NSPredicate는 코드가 간결해 사용하기 편하지만, 같은 패턴으로 NSPredicate를 사용하면 맞는데 틀리다고 나오는경우가 있다고 한다.
- **아직 NSPredicate와 NSRegularExpression을 각각 언제 사용해야하는지 확실하지 않지만, 지금은 같은 패턴이 주어졌을때 정확도가 높은 NSRegularExpression을 사용하자**
```swift
func caseSensitive(_ text: String) -> Bool {
    let desirePattern = "Hello"
    
    let regex = try? NSRegularExpression(pattern: desirePattern)
    let range = NSRange(location: 0, length: text.count)
    
    if regex?.firstMatch(in: text, range: range) != nil {
        return true
    } else {
        return false
    }
    if regex?.matches(in: text, range: range) != Optional([]) {
        return true
    } else {
        return false
    }
}
```
- firstMatch 메서드의 반환형은 NSTextCheckingResult? 그래서 nil인지 확인
- matches 메서드의 반환형은 [NSTextCheckingResult] 하지만 regex?.matches(..)의 옵셔널 때문에 매치하는것이 없다면 Optional([])을  반환한다. regex!.matches를 사용하고 매치하는것이 없다면 []을 반환한다.


## 🍎 정규식 문법 알아보기
- 시작하기전 알아두기
    - firstMatch: 여러개의 데이터가 해당 정규표현식에 매치된다면 그 중 가장 첫번째를 반환. (앞으로 나올 이미지에서는 First match:)
    - matches: 해당 정규표현식에 매치되는 모든것을 보여준다. (앞으로 나올 이미지에서는 All Matches:)
### 📖 0. 찾고싶은 문자열이 있다면 그대로 써준다.
- 만약 문자열 "Hello"를 찾고싶다면 RegEx도 "Hello"를 써준다.
### 📖 1. 정규 표현식은 대소문자 구분 해야한다.
![](https://i.imgur.com/19TYgj5.png)

### 📖 2. 공백, 탭, 줄바꿈도 정규표현식에서는 하나의 표현이다. (의미없는 공백, 탭 줄바꿈 사용 금지)
![](https://i.imgur.com/LMopPzf.png)

### 📖 3. ^ 과 $ 사용법
![](https://i.imgur.com/jpNiN53.png)
- ^ : 시작 (캐럿)
- $ : 종료 (달러사인)
- case1에서 ^who가 의미하는것은 소스상에서 시작 위치에 who라는 텍스트가 있어야 매치가 가능하다는 이야기
- case2에서 who$가 의미하는것은 소스상에서 텍스트가 끝나기 who가 있어야 매치가 가능하다는 이야기

### 📖 4. 캐럿이나 달러싸인이 소스에 포함되어 있을때의 매칭
![](https://i.imgur.com/EqzsORz.png)
- case1에서 ^$는 시작을 $로 하는 텍스트를 구하고 싶었지만 실제로는 ^(시작)과 $(끝)으로 읽기 때문에 아무것도 매칭하지 못한다. 더 정확히는 매칭할 것이 없다.
- case2에서 \(백슬래쉬)는 기호 뒤에 따라오는 문자를 정규 표현식에서 의미있는 문자가 아닌 단순한 문자로 바꿔주는 역할을 한다. 즉, \$는 문자 $이다.
- case3에서 ^\$은 문자열의 시작에 등장하는 문자 $를 매칭한다.
- case4에서 \$$ 은 문자열의 끝에 위치한 문자 $를 매칭한다.
- case5에서  \\ 은 특수문자 \를 단순한 문자로 바꿔주는 역슬래쉬를 앞에 붙여줘 역슬래쉬를 매칭하는 RegEx이다.

### 📖 5. .(point)는 모든 문자와 매칭된다.
![](https://i.imgur.com/UOhQ6HL.png)
- case1에서 점 하나는 어떤 문자든 상관없이 매칭한다.
- case2에서 점 6개는 first match에서는 첫 6글자를 매치하고 all matches에서는 처음부터 6개씩 끊어 매칭한다. 마지막에 6개가 되지 않으면 매칭하지 않는다.

### 📖 6. .(point)를 단순한 문자로 사용하려면 escape을 사용하자
![](https://i.imgur.com/xf5zftk.png)
- .(point)는 어떤 문자든 상관없이 매칭한다고 했다.
- case1에서는 말 그대로 매칭되는 모든것 매칭
- case2에서는 이스케이프 코드를 써 .(point)만 잡아냈다.
- case3에서 \..\.은 아래와 같이 읽어야 한다.
    - \.   .   \.
    - 점   문자  점
    - 그래서 .K.이 매칭된것이다.

### 📖 7. 대괄호 안에 있는 문자 또는 문자들은 사용할 수 있는 후보군이다.
![](https://i.imgur.com/qZbbOhb.png)
- case1에서는 o,y,u 셋 중 하나라도 같다면 매칭.
- case2에서는 d,H 다음에 .(point)가 있으므로 d. 또는 H.이 되어서 d뒤에 어떤문자든지 올 수 있고, H뒤에 어떤문자든지 올 수 있고 해당 문자열을 매칭.
- case3에서는 o,w,y 셋 중에서 하나, y,o,w에서 하나를 매칭 할 수 있다. 총 두글자여야 한다.

### 📖 8. -(dash)로 범위 지정하기
![](https://i.imgur.com/N7OBO52.png)
- case1은 C부터 K까지
- case2도 마찬가지로 C부터 K까지. 위와 차이 없음
- 나머지도 비슷하다.

### 📖 9. 대괄호 안에 ^(캐럿)의 역할
![](https://i.imgur.com/jknm7SH.png)
- case1에서 [^CDghi45]는 not[CDghi45]이다.
    - 즉, CDghi45중 하나라면 매칭이 안된다. 나머지는 매칭.
- case2에서 [^W-Z]는 not[W-Z]이다.

### 📖 10. 여러개 중 하나 고르기 서브패턴(X|Y|Z)
![](https://i.imgur.com/XDlVaQu.png)
- case1에서 on이나 ues나 rida 중 하나라도 같다면 매칭
- case2에서는 Mon이나 Tues나 Fri 중 하나 그리고 뒤에 day가 오는 문자열 매칭
- case3에서는 ..(어떤 두글자)(id|esd|nd)중 하나 그리고 뒤에 ay가 오는 문자열 매칭

### 📖 11. 수량을 알려주는 수량자
![](https://i.imgur.com/tY8ZTE1.png)
- case1 내 a*b에서 *의 역할은 b앞에 있는 a가 없을수도 여러개 있을 수도 있다는 이야기
- case2 내 a+b에서 +의 역할은 b앞에 있는 a가 적어도 1개 또는 여러개 있을 수도 있다는 이야기
- case3 내 a?b에서 ?의 역할은 b앞에 있는 a가 없거나 최대 1개 있을수 있다는 이야기

### 📖 12. 수량자 *의 다양한 예제 (중요!)
![](https://i.imgur.com/BWTAiQk.png)
- case1에서 .*의 의미는 .이 없을수도 있고 여러개 있을수도 있는데 .(point)는 모든 문자를 매칭 할 수 있으니 전체가 매칭이 된다.
- case2에서 -A*-는 보기에 어려워 보이지만 앞 -와 뒤 -는 필수로 들어가야하고 A*를 보면 A는 없을수도 여러개일수도 있다는 이야기다.
- case3내 [-@]*에서 대괄호의 의미는 후보군이였다.
- **즉, - 또는 @이 없거나 여러개 있을 수 있다는 이야기.** 


### 📖 13. 수량자 +의 다양한 예제 (중요!)
![](https://i.imgur.com/0bRqar5.png)
- case1에서 \*+는 문자 *이 1개 이상이면 매칭이 된다는 이야기.
- case2에서 -@+-은 앞 -와 뒤 -은 고정 가운데 문자 @가 1개 이상 오면 매칭이 된다.
- case3에서 [^ ]는 자세히 보면 공백이 있다.
- 즉, not[공백] -> 공백이 아니면 모두 매칭이 된다. 

### 📖 14. 수량자 ?의 다양한 예제 (중요!)
![](https://i.imgur.com/tDWhibM.png)
- case1번에서 -X?XX?X 분석하기!
    - -는 고정
    - X? -> X가 없을수도 최대 1개 있을수도
    - X는 고정
    - X? -> X가 없을수도 최대 1개 있을수도
    - X는 고정
    - 총 가능한 경우 -XX, -XXX, -XXXX 가능
- case2번에서 -@?@?@?- 분석하기!
    - -는 고정
    - @? -> @가 없을수도 최대 1개 있을수도
    - @? -> @가 없을수도 최대 1개 있을수도
    - @? -> @가 없을수도 최대 1개 있을수도
    - -는 고정
    - 총 가능한 경우 --, -@-, -@@-, -@@@- 가능

### 📖 15. 원하는 만큼 수량 지정하기
- 중괄호 "{" 와 "}"안에 들어오는 것이 수량을 의미한다.
![](https://i.imgur.com/VFBXpoc.png)
- case1번에서 .{5} 분석하기!
    - .은 모든문자 가능!
    - 중괄호 안에있는 5는 수량 5를 의미
    - All matches를 보면 5개씩 끊었을때 m이 하나 남는다.
    - .이 5개 있다고 생각하기 (위로 올라가 5번을 보자!)
- case2번에서 [els]{1,3} 분석하기!
    - e 또는 l 또는 s 문자가 최소 1개에서 3개 이하
- case3번에서 [a-z]{3,} 분석하기!
    - a부터 z까지 문자 중 3개 이상

### 📖 16. 수량자 * + ?와 지정 수량자 알아보기
![](https://i.imgur.com/kjjVp4k.png)
- 설명에서 하는 이야기
    - *는 {0,}
    - +는 {1,}
    - ?는 {0,1}과 같다고 한다.
- case1 내 AB*A 분석하기!
    - A는 고정
    - B*는 B가 없을수도 여러개일수도 있다.
    - A는 고정
- case2 내 AB{0,}A는 위와 같다.
- case3 내 AB+A 분석하기!
    - A는 고정
    - B는 적어도 1개 이상
    - A는 고정
- case4 내 AB{1,}A는 위와 같다.
- case5 내 AB?A 분석하기!
    - A는 고정
    - B?는 없거나 최대 1개
    - A는 고정
- case6 내 AB{0,1}A는 위와 같다.

### 📖 17. *, +, 수량자 뒤에 ?를 붙이면 다른 역할을 한다.(탐욕적인 수량자들을 lazy하게 만들어준다)
![](https://i.imgur.com/6zm7vwD.png)
- case1번 내 r.*을 분석하기!
    - r은 고정
    - .*은 .이 없거나 여러개 매칭 가능
- case2번 내 r.*? 분석하기!
    - r은 고정
    - .*? 에서 *은 0,1,또는 여러개를 뜻하는 수량자이지만 뒤에 ?가 붙는다면 *에서 가장 작은 범위인 0이 된다.
    - 즉, *?은 0과 같다.
    - .*? 은 결국 .0과 같고 이 케이스에서는 r만 매칭 가능.
- case3번 내 r.+ 분석하기!
    - r은 고정
    - .+는 .이 적어도 하나 이상!
- case4번 내 r.+? 분석하기!
    - r은 고정
    - .+? 에서 +는 1 또는 여러개를 뜻하는 수량자이지만 뒤에 ?가 붙는다면 +에서 가장 작은 범위인 1이 된다.
    - .+?는 .(point) 1개와 같다.
    - 즉, 이 케이스에서는 r과 바로 뒤 1글자까지 매칭 가능.
- case5번 내 r.? 분석하기!
    - r은 고정
    - .? 에서 ?는 0 또는 1을 뜻하는 수량자.
- case6번 내 r.?? 분석하기!
    - r은 고정
    - .??에서 ?는 0 또는 1을 뜻하는 수량자 이지만 뒤에 ?가 붙는다면 ?에서 가장 작은 범위인 0이 된다.
    - 즉, 이 케이스에서는 .0이 되어서 r 한글자만 매칭된다.

### 18. 📖 \w 사용법 ( alphanumeric plus _ )
![](https://i.imgur.com/0JL8Q1R.png)
- case1 내 \w 분석하기!
    - alphanumeric plus _가 합쳐진것이다.
    - 즉, 대,소문자, 숫자, _ 만 가능한것
- case2 내 \w* 분석하기!
    - \w가 0개 또는 여러개 올수 있다. 공백 불가!
- case3 내 [a-z]\w* 분석하기!
    - 소문자가 한글자 고정 그리고 뒤에는 (대소문자|숫자|) 올 수 있다.
- case4 내 \w{5} 분석하기!
    - 대소문자+숫자+_ 최소 5자 매치!
- case5 내 [A-z0-9_]은 case1번과 같다.

### 📖 19. \W 사용법 !( alphanemeric plus _)
- everything but alphanemeric plus _
![](https://i.imgur.com/DnuM65g.png)
- case1 내 \W 분석하기!
    - verything but alphanemeric plus _
- case2 내 \w 분석하기!
    - only alphanemeric plus _
- case3는 case1과 같다!

### 📖 20. \s, \S 사용법
- \s -> all whitespace chars.
    - ex) space, new line and tab
- \S -> any non-whitespace chars.
![](https://i.imgur.com/jQy0v2t.png)


### 📖 21. \d 사용법 -> [0-9]
![](https://i.imgur.com/rGp67Rw.png)
- case1 내 \d 분석하기!
    - [0-9]
- case2 내 \D 분석하기!
    - [0-9]를 제외한 모든것!
- case3은 case1과 같다.

### 📖 22. word boundary 패턴
![](https://i.imgur.com/X0KIhc7.png)
- case1 내 \b. 분석하기!
    - 먼저 알아둘것은 \b는 혼자서는 쓰일수 없다.
    - \b. 뜻은 단어의 시작이 매칭된다.
- case2 내 .\b 분석하기!
    - .\b 단어의 끝 부분이 매칭된다.
- 궁금한 점.
    - 그럼 단어들을 매칭하고 싶으면 \b\w\b 이렇게 하면 되겠다 생각했지만. 이 경우는 한 글자만 가능하다.
    - 즉, 문자가 하나 이상인 것을 매칭하기 위해 \b\w+\b로 작성해야 한다.

### 📖 23. non word boundary 패턴
![](https://i.imgur.com/o6b6NXx.png)
- word boundary의 반대라고 생각하면된다.
- \B.라면 단어의 첫 글자 배제
- .\B 라면 단어의 마지막 글자 배제

### 📖 24. \A, \Z 패턴
![](https://i.imgur.com/M8wSZub.png)
- 설명을 토대로 실험해보았지만 강의와 조금 다른점이 있어서 삭제

### 📖 25. ?=의 의미
![](https://i.imgur.com/8FNPuWf.png)
- case1내 \w+(?=X) 분석하기!
    - \w+는 대소문자 또는 숫자 또는 _ 가 1개 이상 올수있다는 이야기
    - ?=X는 문자열을 검색하는데는 X를 사용하지만 문자열을 선택할때는 포함하지 않는다라는 뜻이다.
    - 즉 \w+(?=X)는 X가 나오기 전까지만 매칭한다는 의미!
- case2내 \w+ 분석하기!
    - \w+는 대소문자 또는 숫자 또는 _ 가 1개 이상 올수있다는 이야기
- case3내 \w+(?=\w) 분석하기!
    - 1번과 비슷하지만 X가 아닌 대소문자,숫자,_ 중하나만 오면, 해당 문자가 나오기 전까지 매칭하겠다는 의미!

### 📖 26. ?!\<pattern>
- 패턴이 있는지 미리 찾아보는 것.
- 나중에 다시 공부하기.


## 🍎 바로 예제를 통해 알아보자 (천천히 읽어보기)
### 📖 예제 1 (NSRegularExpression)
```swift
private func emailValidateThroughNSRegularExpression(_ email: String) -> Bool {
    let emailPattern = #"^[A-Z0-9a-z]{5,}@[A-Z0-9a-z.-]{5,}\.[A-Za-z]{2,4}$"#
    let regex = try? NSRegularExpression(pattern: emailPattern)
    let range = NSRange(location: 0, length: email.count)
    if regex?.firstMatch(in: email, range: range) != nil {
        return true
    } else {
        return false
    }
}
```

### 📖 예제 2 (NSPredicate)
```swift
private func emailValidateThroughNSPredicate(_ email: String) -> Bool {
    let pattern = #"^[A-Z0-9a-z]{5,}@[A-Z0-9a-z.-]{5,}\.[A-Za-z]{2,4}$"#
    return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
```
- NSPredicate를 사용해 문자열이 이메일 형태인지 확인하는 메서드.

## 🍎 NSRegularExpression 객체 만드는 과정에서 생긴 궁금증.
- NSRegularExpression(pattern: pattern)으로 객체를 생성.
- [pattern을 이용해 객체를 만드는 NSRegularExpression 생성자](https://developer.apple.com/documentation/foundation/nsregularexpression/1410900-init)내 Declaration을 보면,
    ```swift
    init(
    pattern: String,
    options: NSRegularExpression.Options = []
    ) throws
    ```
    - 에러를 반환할 수 있는 생성자이므로, try를 사용해 에러 핸들링을 해주어야 한다.
- 아래 예제는 NSRegularExpression 객체를 만들어 firstMatch 메서드를 실행하는 코드.
```swift
let pattern = "^[A-Za-z0-9~!@#$%^&*]{0,}$"
let regex = try? NSRegularExpression(pattern: pattern)
if let _ = regex?.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count)) {
        // 있는경우            
}
```
- 여기서 regex 상수와 상수에 대입할 값을 보면 try가 아닌 try?를 사용하고 있다.
```swift
let regex = try? NSRegularExpression(pattern: pattern)
```
- **왜 try가 아닌 try?를 왜 사용할까?**
    - try를 사용하려면 do-catch문이 필요하다. 여기서는 간단하게 알아보기 위해 try? 사용.
    - try 복습
        - try -> do-catch 필요 / 에러가 발생하지 않으면 일반 값
        - try? -> do-catch 필요 x / 에러가 발생하지 않으면 옵셔널, 발생하면 nil
        - try! -> do-catch 필요 x / 에러가 발생하지 않으면 일반값, 발생하면 crash

## 🍎 Citation
- [Easy REGEX in Swift](https://www.youtube.com/watch?v=_3-uWtTO_Sc)
- [NSRegularExpression](https://developer.apple.com/documentation/foundation/nsregularexpression/1410900-init)
- [김종권의 iOS](https://ios-development.tistory.com/591)
- [NamS의 iOS일기](https://nsios.tistory.com/139)




