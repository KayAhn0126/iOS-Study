# ToDoList에서 사용한 UIAlertController

## 🍎 구현 화면
![](https://i.imgur.com/O4xsisH.png)
- 숫자는 아래 코드와 매칭되는 영역
![](https://i.imgur.com/V0Te1j8.png)

## 🍎 코드 설명
- 2번에서 등록 버튼 후 나오는 클로져는 해당 버튼이 클릭 되었을때 실행될 클로져.
    - 옵셔널 바인딩을 하는 alert.textFields?[0]은 첫번째 텍스트 필드.
    - 만약 텍스트 필드가 여러개이면, alert.textFields?[1]..[2] 이런 방식으로 값을 가져오면 된다.
- 3번에서 스타일에 .destructive는 글 색상을 빨간색으로 변경
- 4번에서 addTextField(configurationHandler:)메서드는 UIAlertController에 Textfield를 하나 추가하는것. configurationHandler 클로져는 클로져 안에서 해당 텍스트 필드를 구현(구성)하면 된다.
