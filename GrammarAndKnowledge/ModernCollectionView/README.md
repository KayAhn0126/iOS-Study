# UICollectionViewDiffableDataSource 그리고 UICollectionViewCompositional Layout의 등장

## 🍎 Modern CollectionView로 구현한 프로젝트
- [AppleFrameworkWithCompositionalLayout](https://github.com/KayAhn0126/AppleFrameworkWithCompositionalLayout)
- [MeditationContentsList](https://github.com/KayAhn0126/MeditationContentsList)
- [SpotifyPayWall](https://github.com/KayAhn0126/SpotifyPayWall)

## 🍎 먼저 기존 Table View / Collection View 다시 공부
- [기본 Table View / Collection View 정리](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/TableViewAndCollectionView)

## 🍎 UICollectionViewDiffableDataSource란?
### 2019 WWDC에서 발표한 DiffableDataSource 그리고 Compositional Layout
- **기존 UICollectionViewDataSource를 사용할때 생기는 문제점을 보완, 개선**.
- ex) collectionView의 데이터 구성하기 위해 Controller에게 numberOfSection을 묻는다. controller는 데이터를 채우기 위해 API통신을 요청하고 응답을 받으면 collectionView에게 변화를 알린다. 하지만 controller에서 받아온 numberOfSection의 수와 현재 UI가 가지고 있는 numberOfSection수가 다르다면 **앱이 강제로 종료되는 경우**가 있다.
- 데이터가 변경 될때마다 수동으로collectionView.reloadData()를 이용해 위의 문제를 해결할수 있다. 하지만 뚝뚝 끊기는 UI는 **사용자에게 좋은 경험(UX)을 가져다 주지 못한다.**
    - [DataSource](https://github.com/KayAhn0126/iOS-Study/blob/main/UI/ModernCollectionView/WithDataSource.gif)와 [Diffable DataSource](https://github.com/KayAhn0126/iOS-Study/blob/main/UI/ModernCollectionView/WithDiffableDataSource.gif) GIF 비교.(Diffable DataSource를 사용한 GIF가 **새로운 값들을 표현할 때 훨씬 부드럽다.**)
- **DataSource와 달리 DiffableDataSource를 사용하면 데이터가 달라진 부분을 추적하여 자연스럽게 UI를 업데이트 한다. (새로운 부분만 다시 그린다.)**
- 즉, DiffableDataSource는 collectionView.reloadData()메서드 없이 UI를 업데이트(with animation) 하고, 업데이트 과정에서 생기는 crash를 예방한다. collectionView.reloadData()메서드를 사용했을때 단점에 대해 알아보다 [블로그](https://yoojin99.github.io/app/Diff-원리/)를 발견했고, 이 블로그에 따르면reloadData() 메서드는 필요한것만 지우고 필요한것만 생성하는것이 아니라, "**전체를 지우고 전체를 생성한다**"고 한다.
- 장점 :
    - 추가적인 코드없이 퀄리티 있는 애니메이션을 사용할 수 있다.
    - DataSource와 달리 동기적으로 데이터를 처리 할 때 생기는 버그, 충돌 상황을 완벽하게 통제한다.
- **Snapshot**
    - indexPath 사용 안함.
    - 섹션 및 아이템에 대해서 Unique ID 사용
    - Unique + Hashable

## 🍎 Compositional Layout의 등장
- **Layout > Section > Group >Item**
![](https://i.imgur.com/UmMXBDU.png)

## 🍎 사이즈 관련 헷갈리는 item, group, section 분석.

### 아이템
```swift
let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
let item = NSCollectionLayoutItem(layoutSize: itemSize)
```
- itemSize내 width와 height를 정해주는 부분에서 .fractional(width/height)는 item을 담고있는 group의 사이즈를 기반으로 배수를 의미한다.
- 즉, 위의 코드가 말하고 있는것은..
    - 아이템 하나의 가로 사이즈는 그룹의 가로 * 1, 세로 사이즈는 그룹의 세로 * 1 이다.

### 그룹
```swift
let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
```
- groupSize내 width와 height를 정해주는 부분에서 그룹의 가로는 섹션의 가로 * 0.8, .absolute(200)은 세로를 200 points로 고정하겠다는 의미.
- **그룹을 생성할때 .horizontal은 아이템을 그룹에 넣어줄때 가로로 넣을것인지 세로로 넣을것인지 정해주는것이다.**

### 섹션
- section은 기본적으로 세로 스크롤이다. 왜?
- section의 orthogonalScrollingBehavior 프로퍼티의 기본값이 .none이기 때문.
- orthogonalScrollingBehavior은 UICollectionLayoutSectionOrthogonalScrollingBehavior 타입
- UICollectionLayoutSectionOrthogonalScrollingBehavior타입은 enum
    - case none = 0
    - case continuous = 1
    - case continuousGroupLeadingBoundary = 2
    - case paging = 3
    - case groupPaging = 4
    - case groupPagingCentered = 5
- 필요에 따라 사용하면 된다.

## 🍎 Citation
- [출처](https://velog.io/@ellyheetov/UI-Diffable-Data-Source)에서 많은 부분을 공부 및 인용.
