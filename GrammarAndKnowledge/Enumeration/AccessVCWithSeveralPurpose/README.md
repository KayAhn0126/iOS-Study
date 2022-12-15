# 열거형을 이용해 하나의 View Controller에 다른 목적으로 접근하기

## 🍎 화면의 구성
| 첫 화면(DiaryVC) | 일기 상세 화면(DiaryDetailVC) |
|:-:|:-:|
| ![](https://i.imgur.com/ooXiKZy.png) | ![](https://i.imgur.com/ikEGuPk.png) |
| 신규 일기 작성 화면(WriteDiaryVC) | 기존 일기 수정 화면(WriteDiaryVC) |
| ![](https://i.imgur.com/GUIcgQ3.png) | ![](https://i.imgur.com/I61qHDB.png) |
- 첫화면에서 + 를 클릭했을때 나오는 신규 일기 작성 화면과 일기 상세 화면에서 수정 버튼을 클릭했을때 나오는 화면은 동일하게 WriteViewController로 만든 VC 객체이다.
- 전체적인 구성은 똑같지만 다른 목적으로 화면에 진입 했을때 달라야 하는 점이 두 가지 있다.
    - 등록 / 수정 버튼의 이름
    - 등록 / 수정 버튼이 눌렸을 때의 행동
- 더 자세히 설명하면, 신규 일기 작성 일때는 등록 버튼을 누르면 새로 입력된 일기가 diaryList에 추가되는 작업을 수행 해야하고, 기존 일기를 수정하는 화면에서는 등록 버튼이 수정으로 바뀌고 수정 버튼을 누르면 변경된 일기를 기존 diaryList의 알맞은 위치로 들어가 수정 되도록 수행 해야한다.
- 이것을 열거형으로 쉽게 나눌수 있다.

## 🍎 간단하게 알아보는 순서
| 분류를 위한 열거형 생성 |
|:-:|
| ![](https://i.imgur.com/Qh7Sthq.png) |
| 일기 상세 화면에서 수정 버튼을 누를때 생성 될 화면에 모드 프로퍼티(diaryMode)에 </br>케이스(.edit)과 연관값(indexPath, diary)과 함께 할당 |
| ![](https://i.imgur.com/vgB6NLb.png) |
| WriteDiaryVC에서 등록 / 수정 버튼이 눌렸을 때 모드에 따라 분기 처리 |
| ![](https://i.imgur.com/7i0SR3D.png) |
