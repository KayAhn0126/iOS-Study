# UICollectionViewDiffableDataSource 그리고 UICollectionViewCompositional Layout의 등장
- 2019 WWDC에서 발표한 DiffableDataSource 그리고 Compositional Layout
## 🍎 Modern CollectionView로 구현한 프로젝트
- [AppleFrameworkWithCompositionalLayout](https://github.com/KayAhn0126/AppleFrameworkWithCompositionalLayout)
- [MeditationContentsList](https://github.com/KayAhn0126/MeditationContentsList)
- [SpotifyPayWall](https://github.com/KayAhn0126/SpotifyPayWall)

## 🍎 먼저 기존 Table View / Collection View 다시 공부
- [기본 Table View / Collection View 정리](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/TableViewAndCollectionView)

## 🍎 UICollectionViewDiffableDataSource란?
- **기존 UICollectionViewDataSource를 사용할때 생기는 문제점을 보완, 개선**.
    - ex) collectionView의 데이터 구성하기 위해 Controller에게 numberOfSection을 묻는다. controller는 데이터를 채우기 위해 API통신을 요청하고 응답을 받으면 collectionView에게 변화를 알린다. 하지만 controller에서 받아온 numberOfSection의 수와 현재 UI가 가지고 있는 numberOfSection수가 다르다면 **앱이 강제로 종료되는 경우**가 있다.
    - 데이터가 변경 될때마다 수동으로collectionView.reloadData()를 이용해 위의 문제를 해결할수 있다. 하지만 뚝뚝 끊기는 UI는 **사용자에게 좋은 경험(UX)을 가져다 주지 못한다.**
    - [DataSource](https://github.com/KayAhn0126/iOS-Study/blob/main/GrammarAndKnowledge/ModernCollectionView/WithDataSource.gif)와 [Diffable DataSource](https://github.com/KayAhn0126/iOS-Study/blob/main/GrammarAndKnowledge/ModernCollectionView/WithDiffableDataSource.gif) GIF 비교.(Diffable DataSource를 사용한 GIF가 **새로운 값들을 표현할 때 훨씬 부드럽다.**)
    - **DataSource와 달리 DiffableDataSource를 사용하면 snapshot을 이용해 달라진 부분을 추적하여 자연스럽게 UI를 업데이트 한다. (새로운 부분만 다시 그린다.)**
    
## 🍎 DiffableDataSource가 DataSource보다 좋은 점
- DiffableDataSource는 collectionView.reloadData()메서드 없이 UI를 업데이트(with animation) 하고, 업데이트 과정에서 생기는 crash를 예방한다. 
- collectionView.reloadData() 메서드를 사용했을때 단점은 reloadData() 메서드는 필요한것만 지우고 필요한것만 생성하는것이 아니라, "**전체를 지우고 전체를 생성한다**"고 한다.
- .reloadData() 메서드에 대한 출처 [블로그](https://yoojin99.github.io/app/Diff-원리/)
- snapshot 적용을 통해 추가적인 코드없이 퀄리티 있는 애니메이션을 사용할 수 있고 DataSource와 달리 동기적으로 데이터를 처리 할 때 생기는 버그, 충돌 상황을 완벽하게 통제한다.
    - indexPath 사용 안함.
    - 섹션 및 아이템에 대해서 Unique ID 사용
    - Unique + Hashable

## 🍎 Compositional Layout의 등장과 layout 구성시 사이즈 관련 헷갈리는 item, group, section 분석.
- **Layout > Section > Group >Item**
![](https://i.imgur.com/UmMXBDU.png)

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
```swift
let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
```
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

### 레이아웃
- 아이템, 그룹, 섹션을 다 구성한 후 layout 상수로 만들어 반환.
```swift
let layout = UICollectionViewCompositionalLayout(section: section)
```

## 🍎 DiffableDataSource + Compositional Layout을 사용한 예제
```swift
import UIKit

enum Section {
    case main
}

class DiaryViewController: UIViewController {
    typealias Item = Diary
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var diaryList = [Diary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let wrietDiaryViewController = segue.destination as? WriteDiaryViewController {
            wrietDiaryViewController.delegate = self
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCollectionViewCell", for: indexPath) as? DiaryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(diary: item)
            return cell
        })
        collectionView.collectionViewLayout = configureLayout()
    }
    
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension DiaryViewController: WriteDiaryDelegateProtocol {
    func didSelectRegister(diary: Diary) {
        self.diaryList.append(diary)
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(diaryList, toSection: .main)
        dataSource.apply(snapshot)
    }
}
```

## 🍎 Modern collectionView를 Data, Layout, Presentation로 나눠보기
- **Data -> snapshot(데이터만 관리)**
    - 위의 코드에서 didSelectRegister 메서드 내 snapshot을 dataSource에 적용하는 부분이다.
    - 이전 snapshot과 현재 snapshot의 차이점을 애니메이션으로 적용할 수 있다.
    ```swift
    func didSelectRegister(diary: Diary) {
        self.diaryList.append(diary)
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(diaryList, toSection: .main)
        dataSource.apply(snapshot)
    }
    ```
    - snapshot은 말 그대로 데이터를 가지고 있는 통을 의미한다.
    - **항상 신경써야 할 점은 collection view에 나타날 데이터가 변동될 때마다 코드와 같이 Snapshot을 업데이트 해줘야한다는 점!**
- **Presentation -> diffable datasource (데이터를 셀로 어떻게 보여줄지만 관리)**
    ```swift
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    ```
    - 먼저 Diffable Data Source는 Hashable 프로토콜을 따르는 제네릭 타입 SectionIdentifierType, ItemIdentifierType을 파라미터로 넣어 선언한다.
    ```swift
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCollectionViewCell", for: indexPath) as? DiaryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(diary: item)
            return cell
        })
        collectionView.collectionViewLayout = configureLayout()
    }
    ```
    - UICollectionViewDiffableDataSource 클래스의 생성자를 통해 인스턴스를 생성하고 초기화 해주는 코드.
        - [WWDC 2019 Advances in UI Data Sources](https://developer.apple.com/videos/play/wwdc2019/220)의 14:46초부터 DiffableDataSource 인스턴스를 생성할 때 필요한 매개변수 collectionView: collectionView에 대해서 아래와 같이 이야기 하고 있다.
            - "pass it a pointer to the CollectionView that we want to work with. Now DiffableDataSource will take that pointer and automatically wire itself up as the data source of that CollectionView so there's nothing else for us to do."
        - 생성자의 collectionView 매개변수에 우리가 사용하려는 collectionView의 포인터를 넘겨준다. 그럼 DiffableDataSource는 해당 포인터를 가져와 포인터가 가르키고있는 CollectionView의 data source 역할을 자신과 연결해 개발자가 다른것은 신경 쓰지 않아도 되게끔 해준다. 위의 코드에서는 configureDataSource() 메서드를 viewDidLoad()메서드에서 불러주고 있다. -> combine의 pipe line을 만드는것처럼 한번만 실행하면 dataSource에 snapshot이 apply될때마다 dateSource에 연결된 collectionView를 가져와 생성자 매개변수로 있는 후행 클로져의 매개변수로 넘겨줘 실행시켜준다.
        - **15:00 부터는 cell provider 클로져에 대해서 아래와 같이 설명하고 있다.**
            - "you would normally have to write if you were implementing your own data source from scratch, you would implement the cellForItemAt IndexPath method. That's data source callback method, where you're expected to do exactly what we do here"
            - "We call back to our CollectionView and ask it for a cell of the appropriate type to display the data we want to, and we populate that cell with what we want to show, and then we return it back"
            - "so this is just taking that cellForItemAt IndexPath code and conveniently transplanting it into a nice closure encapsulation that we pass when we instantiate the data source"
        - 대략적으로 클로져의 내용이 기존 data source를 사용했을때 작성해야 했던 cellForItemAt IndexPath 메서드를 대신해준다는 이야기.
        - **클로져 안에있는 dequeReusableCell(withIdentifier:)는 어떻게 작동할까?**
        - [dequeueReusableCell(withReuseIdentifier:for:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618063-dequeuereusablecell)의 Discussion에 대한 설명이 있다.
            - Call this method from your data source object when asked to provide a new cell for the collection view. This method dequeues an existing cell if one is available or creates a new one based on the class or nib file you previously registered.
        - 큐에 셀이 있다면 dequeue를 해서 셀을 사용하고, 사용할 수 있는 셀이 없다면 withReuseIdentifier 매개변수에 등록되어있는 클래스로 셀을 만든다.
    
- **Layout -> compositional Layout (셀들을 어떻게 보여줄지 관리)**
    ```swift
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    ```
    - fractionalWidth(), estimated(), absolute() 메서드는 위에서 다뤘다.
    - group.interItemSpacing은 아이템간 간격, NSCollectionLayoutSpacing 클래스를 사용해야한다. -> 그룹의 interItemSpacing 프로퍼티가 NSCollectionLayoutSpacing 타입.
    - 하지만 그룹간 사이에 간격을 넣어주는 프로퍼티는 CGFloat.
    ```swift
    group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
    ...
    section.interGroupSpacing = 10
    ```
    - contentInset은 자신을 감싸고 있는 범위에서 얼만큼 떨어질것인지 정해주는 프로퍼티이다.
    ```swift
    item.contentInset = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

    group.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    ```
    - item은 group안에 있으니 그룹으로부터 top,bottom,leading,trailing을 10만큼씩 줘 간격을 띄우겠다는 의미.
    - group은 section안에 있으니 섹션으로부터 top,bottom,leading,trailing을 20만큼씩 줘 간격을 띄우겠다는 의미.

## 🍎 Citation
- [출처](https://velog.io/@ellyheetov/UI-Diffable-Data-Source)에서 많은 부분을 공부 및 인용.
- [Advances in Collection View Layout](https://developer.apple.com/videos/play/wwdc2019/215/)
- [Compositional Layout 사용 예제](https://ios-development.tistory.com/718)
- [Kodeco](https://www.kodeco.com/8241072-ios-tutorial-collection-view-and-diffable-data-source)
- [WWDC 2019 Advances in UI Data Sources](https://developer.apple.com/videos/play/wwdc2019/220)
- [dequeueReusableCell(withReuseIdentifier:for:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618063-dequeuereusablecell)
