# Basic_required init

## 🍎 required init 사용법
- **(제일 중요!)생성을 하는 시점에는 프로퍼티에 항상 값이 있어야한다.**
- required 수식어를 클래스의 이니셜라이저 앞에 명시해주면 이 클래스를 상속 받은 자식 클래스에서 반드시 해당 이니셜라이저를 구현해주어야 한다.
    - 단, 자식 클래스 내 모든 프로퍼티가 기본 값을 가지고 있어서 지정 생성자를 따로 작성하지 않으면 부모 클래스의 모든 지정 생성자 상속 받는다.
- 자식 클래스 내 프로퍼티가 기본 값을 가지고 있지 않아서 지정 생성자를 구현해 자식 클래스의 프로퍼티에 값을 넣어주게 될 경우 반드시 부모 클래스의 required init을 구현해주어야 한다.
- 부모 클래스에 required init에 매개변수가 있던지 없던지 똑같이 써줘야 한다!

## 🍎 예제
- 상속 받는 클래스(Student)의 프로퍼티에 기본 값을 지정해 부모 클래스의 required init을 자동으로 상속 받는 경우
```swift
class Human {
    var name: String
    
    required init() {
        self.name = "Kay"
    }
}

class Student: Human {
    var grade: Int = 6
}
```
- 자식 클래스에서 지정생성자를 만들면 required init을 구현해주는 예제
```swift
class Human {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

class Student: Human {
    var grade: Int
    
    init(name: String, grade: Int) {
        self.grade = grade
        super.init(name: name)
    }
    
    required init(name: String) {
        self.grade = 5
        super.init(name: name)
    }
}
```

## 🍎 Citation
- [required init?(coder: NSCoder) 에 대해서](https://medium.com/@b9d9/required-init-coder-nscoder-%EC%97%90-%EB%8C%80%ED%95%B4%EC%84%9C-b67ddfc628)
