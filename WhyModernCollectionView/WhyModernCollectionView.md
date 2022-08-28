# UICollectionViewDiffableDataSource 그리고 UICollectionViewCompositional Layout의 등장

## 🍎 2019 WWDC에서 발표한 DiffableDataSource 그리고 Compositional Layout
- 왜 나왔을까?
- 먼저 [출처](https://velog.io/@ellyheetov/UI-Diffable-Data-Source)에서 많은 부분을 공부 및 인용.
## 🍎 UICollectionViewDiffableDataSource란?
- 기존 UICollectionViewDataSource를 사용할때 생기는 문제점을 보완, 개선하기 위해.
    - ex) collectionView의 데이터 구성하기 위해 Controller에게 numberOfSection을 묻는다. controller는 데이터를 채우기 위해 API통신을 요청하고 응답을 받으면 collectionView에게 변화를 알린다. 하지만 controller에서 받아온 numberOfSection의 수와 현재 UI가 가지고 있는 numberOfSection수가 다르다면 **앱이 강제로 종료되는 경우**가 있다.
- 데이터가 변경 될때마다 수동으로 collectionView.reloadData()를 이용해 위의 문제를 해결할수 있다. 하지만 뚝뚝 끊기는 UI는 **사용자에게 좋은 경험(UX)을 가져다 주지 못한다.**
    |              DataSource              |         Diffable DataSource          |
    |:------------------------------------:|:------------------------------------:|
    | ![](https://i.imgur.com/HbPwdJe.gif) | ![](https://i.imgur.com/AM0I71f.gif) |
- **collectionView를 그리기 위한 데이터를 관리하고 UI를 업데이트 하는 역할.**
- **DataSource와 달리 데이터가 달라진 부분을 추적하여 자연스럽게 UI를 업데이트 한다. (새로운 부분만 다시 그린다.)**
- 즉, DiffableDataSource는 collectionView.reloadData()메서드 없이 UI를 업데이트(with animation) 하고, 업데이트 과정에서 생기는 crash를 예방한다.
- 장점 :
    - 추가적인 코드없이 퀄리티 있는 애니메이션을 사용할 수 있다.
    - DataSource와 달리 동기적으로 데이터를 처리 할 때 생기는 버그, 충돌 상황을 완벽하게 통제한다.
- **Snapshot의 도입.**
    - indexPath 사용 안함.
    - 섹션 및 아이템에 대해서 Unique ID 사용
    - Unique + Hashable
## 🍎 Compositional Layout의 등장
- **Layout > Section > Group >Item**
![](https://i.imgur.com/UmMXBDU.png)


## 🍎 요약
- **기존 UICollectionView 에서 Data, Presentation 구현 방법은 에러가 생길수 있음**
    - AS-IS : UICollectionViewDataSource
    - TO-BE : UICollectionViewDiffableDataSource

- **기존 UICollectionView 에서 Flowlayout으로 복잡한 화면 구현시, 난이도가 갑자기 올라감**
    - AS-IS : UICollectionViewFlowLayout
    - TO-BE : UICollectionViewCompositionalLayout


- **점점 복잡한 UI구현이 생기면서 기존 방식을 사용했을때 Controller이 가지고 있는 데이터와 UI에서 보이는 데이터가 일치하지 않는 경우가 발생.**
    - 예를들어, Controller는 값을 받아왔지만 UI에서는 이전 값을 보여주고 있는 경우.
