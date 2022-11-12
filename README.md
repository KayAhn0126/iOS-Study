# iOS-Study

# UI
|이름|설명|이유|
|:-:|:-:|:-:|
| [스토리보드 없이 프로젝트 시작하기](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/HowToRemoveStoryboard) | 스토리보드 삭제 방법| 코드로 UI를 구성시 불필요한 스토리보드 삭제 방법 메모 |
| [main이 아닌 스토리보드에서 앱 시작하기](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/HowToStartWithOtherStoryboard)| main이 아닌 다른 스토리보드에서 앱 시작하기 방법 정리| 특정 화면 구현시 앱 실행 후 바로 테스트 하기 위함|
| [화면 전환 방법](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/ScreenTransition) | 직접 호출, 내비게이션 컨트롤러를 이용한 호출 | 화면 전환에 대해 직접 실험 및 정리 |
| [화면간 데이터 전달 방법](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/DataTransferBetweenScreens)| 화면간 데이터 전달 방법 정리| 양방향으로 전달하는 방법 공부 |
| [Alert 띄우기](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/Alert)| HIG과 스타일에 대한 정리 | Notification Center 구현 중 공부 후 정리 |
| [ClipsToBounds & MasksToBounds](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/ClipsToBounds-MasksToBounds)| 두 프로퍼티가 어떻게 사용되는지 공부| 자주 사용되지만 정확한 개념 확립을 위해 공부|
| [UIView와 CALayer](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/CALayer)| layer 사용 중 개념 정리 | 자주 사용되지만 정확한 개념 확립을 위해 공부|
| [Assets에 Custom Color Set 추가하기](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/HowToAddCustomColorSet)| 프로젝트 중 자주 사용되는 색상을 추가해 사용하는 방법 정리| 많이 사용되는 컬러를 간단하게 접근해 작업을 쉽게 만듦|
| [@IBInspectable & @IBDesignable](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/IBInspectable)| 프로젝트 중 여러 버튼의 속성을 수정하는 계기로 공부 | 스토리보드의 inspector에서 속성 추가 방법 정리|
| [버튼이 클릭 되었을때 다른 이미지로 변경하기](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/WhenButtonIsSelected)| 프로젝트 중 버튼 클릭시 다른 이미지로 변경 정리 | 버튼의 State config 설정에 따른 변화 정리 |
| [버튼에 새로운 속성 적용하기](https://github.com/KayAhn0126/iOS-Study/tree/main/UI/ApplyingAttributeToButton)| 버튼 label에 새로운 속성 적용 방법 정리| 구간에 따라 사이즈, 폰트, 색상이 바뀌는 방법을 배움|

# Grammar & knowledge
| 제목 | 설명|
|:-:|:-:|
| [AppDelegate / UserDefaults](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/HowToStoreData)| AppDelegate와 UserDefaults를 사용한 데이터 저장 및 전달 방법 정리|
| [Associated Type](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/AssociatedType)| associatedtype 정리|
| [Closure](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/Closure)| 기본 클로저 정리|
| [Notification Center](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/NotificationCenter)| Notification Center 정리|
| [Higher Order Functions](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/HigherOrderFunction)| 고차함수 정리|
| [Metatype](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/Metatype)| 메타 타입 정리|
| [Generic](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/Generic)| 제네릭 정리|
| [Number Formatter](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/NumberFormatter)| NumberFormatter 정리|
| [Date Formatter](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/DateFormatter)| DateFormatter 정리|
| [ARC / Capture List](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/ARC_and_CaptureList)| ARC와 Capture List 정리|
| [ScrollView & StackView](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/StackViewAndScrollView) | 스크롤뷰와 스택뷰를 스토리보드와 코드로 구현 |
| [Basic TableView & Collection View](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/TableViewAndCollectionView)| 기본 TableView 및 CollectionView 구조 정리와 CollectionView의 FlowLayout과 CompositionalLayout 비교|
| [Modern Collection View](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/ModernCollectionView)| 복잡한 뷰 및 데이터 일관성을 위한 Compositional Layout 공부|
| [@propertyWrapper](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/PropertyWrapper)| [기본 propertyWrapper 사용법 정리](https://github.com/KayAhn0126/iOS-Study/blob/main/GrammarAndKnowledge/PropertyWrapper/PropertyWrapper.playground/Pages/Basic%20PropertyWrapper.xcplaygroundpage/Contents.swift) <br> [wrapped된 property에 초기값 넣는 방법 정리](https://github.com/KayAhn0126/iOS-Study/blob/main/GrammarAndKnowledge/PropertyWrapper/PropertyWrapper.playground/Pages/PropertyWrapper%20%26%20Initializer.xcplaygroundpage/Contents.swift) <br> [projectedValue를 통해 새로운 값을 저장하기 전, 조정이 있었는지 확인하기](https://github.com/KayAhn0126/iOS-Study/blob/main/GrammarAndKnowledge/PropertyWrapper/PropertyWrapper.playground/Pages/ProjectedValue.xcplaygroundpage/Contents.swift)|
| [@Sendable](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/SendableKeyword)| [Error 열거형 선언 / 데이터 수신 여부에 따른 프로세스(escaping)](https://github.com/KayAhn0126/Network/blob/main/Network%20in%20iOS.playground/Pages/Fetch%20Method.xcplaygroundpage/Contents.swift)에서 URLSession내 dataTask 메서드 분석 중 발견한 @Sendable 키워드 정리|
| [Error Handling](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/ErrorHandling)| Error Handling 정리 & TBU|
| [Self vs self](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/Self_vs_self) | Self와 self에 대한 정리|
| [Regular Expression](https://github.com/KayAhn0126/iOS-Study/tree/main/GrammarAndKnowledge/RegularExpression)| 정규식 정리|

# Design Pattern
| 제목 | 설명|
|:-:|:-:|
| [Delegate Pattern](https://github.com/KayAhn0126/iOS-Study/tree/main/DesignPattern/DelegatePattern) | PartyDirector가 PartyWorker에게 일을 위임하는 패턴을 코드로 구현 | 
| [Delegate Pattern With Role Play](https://github.com/KayAhn0126/iOS-Study/tree/main/DesignPattern/DelegatePatternWithRolePlay)| 보스가 비서에게 해야할 일을 위임하는 코드 구현|
| [MVVM](https://github.com/KayAhn0126/iOS-Study/tree/main/DesignPattern/MVVM)| MVVM 공부 및 정리|

# SwiftUI
| 제목 | 설명 |
|:-:|:-:|
| [SwiftUI](https://github.com/KayAhn0126/SwiftUI)| SwiftUI 정리| 

# Combine & Network
| 제목 | 설명|
|:-:|:-:|
| [Combine](https://github.com/KayAhn0126/Combine)| [Publisher에서 Subscriber까지 기본 프로세스 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Publisher%20%26%20Subscriber%20%26%20Subscription.xcplaygroundpage/Contents.swift) <br> [Just, .publisher, .assign 기본 사용법 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Publisher%20%26%20Subscriber.xcplaygroundpage/Contents.swift) <br> [PassthroughSubject, CurrentValueSubject 퍼블리셔 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Subject.xcplaygroundpage/Contents.swift) <br> [Subscription 특징 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Subscription.xcplaygroundpage/Contents.swift) <br> [@Published property wrapper 사용법 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Published.xcplaygroundpage/Contents.swift) <br> [dataTaskPublisher, Notification, KeyPath, Timer를 통한 Combine 예제](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Foundation%20and%20Combine.xcplaygroundpage/Contents.swift) <br> [Scheduler 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Scheduler.xcplaygroundpage/Contents.swift) <br> [Operator - map & filter 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Operator%20-%20map%20%26%20filter.xcplaygroundpage/Contents.swift) <br> [Operator - combineLatest, merge 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Operator%20-%20combineLatest.xcplaygroundpage/Contents.swift) <br> [Operator - removeDuplicaes(), compactMap, ignoreOutput(), prefix 사용 예제](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Operator%20-%20removeDup%20%26%20compactMap.xcplaygroundpage/Contents.swift)|
| [Network](https://github.com/KayAhn0126/Network)| [기초 네트워크 예제](https://github.com/KayAhn0126/Network/blob/main/Network%20in%20iOS.playground/Pages/URLSession.xcplaygroundpage/Contents.swift) <br> [데이터를 받아 모델 형식으로 Decode 프로세스](https://github.com/KayAhn0126/Network/blob/main/Network%20in%20iOS.playground/Pages/Decode%20Data.xcplaygroundpage/Contents.swift) <br> [Error 열거형 선언 / 데이터 수신 여부에 따른 프로세스(escaping)](https://github.com/KayAhn0126/Network/blob/main/Network%20in%20iOS.playground/Pages/Fetch%20Method.xcplaygroundpage/Contents.swift) <br> [Combine을 활용한 네트워크](https://github.com/KayAhn0126/Network/blob/main/Network%20in%20iOS.playground/Pages/Using%20Combine.xcplaygroundpage/Contents.swift)|
| | |
| | |

# Clone Projects & Research
| 프로젝트 | 설명 |
|:-:|:-:|
| [Simple Weather](https://github.com/KayAhn0126/SimpleWeather)| 이미지뷰와 레이블, 스택뷰를 사용한 랜덤 날씨 제조 앱 |
| [Stock Rank](https://github.com/KayAhn0126/StockRank)| 로컬 데이터를 기반, UICollectionView를 사용한 주식 순위 앱 |
| [Chat List](https://github.com/KayAhn0126/ChatList)| UICollectionView, DateFormatter, sort를 사용한 채팅 리스트 앱 |
| [Apple FrameWork](https://github.com/KayAhn0126/AppleFramework)| UICollectionView, Navigation Controller를 사용한 애플의 프레임 워크 |
| [Insta Search](https://github.com/KayAhn0126/InstaSearch)| UICollectionView, Navigation Controller, 탭 바 컨트롤러, 서치 컨트롤러를 사용한 SNS 앱 |
| [Nike Running Club](https://github.com/KayAhn0126/NRC)| UICollectionView, Page Controller를 사용한 운동 앱|
| [Apple FrameWork With Compositional Layout](https://github.com/KayAhn0126/AppleFrameworkWithCompositionalLayout)| DiffableDataSource, Snapshot, Compositional Layout을 사용한 애플 프레임 워크|
| [MeditationContentsList](https://github.com/KayAhn0126/MeditationContentsList)| DiffableDataSource, Snapshot, Compositional Layout 및 Snapshot의 활용, Bool 타입의 toggle() 메서드를 사용한 명상 컨텐츠 리스트|
| [SpotifyPayWall](https://github.com/KayAhn0126/SpotifyPayWall)| DiffableDataSource, Snapshot, Compositional Layout, Page Control, NSCollectionLayoutSection 사용한 음악앱 및 orthogonalScrollingBehavior 사용법|
| [Apple Framework With Modal](https://github.com/KayAhn0126/AppleFrameworkWithModal)| DiffableDataSource, Snapshot, Compositional Layout, Modal-presentation, SafariServices를 사용한 애플 프레임 워크 설명 앱|
| [Meditation Contents List With Navigation](https://github.com/KayAhn0126/MeditationContentsListWithNavigation)| DiffableDataSource, Snapshot with two sections, Compositional Layout, Navigation Controller, UICollectionReusableView를 사용한 명상 컨텐츠 리스트 (상세 뷰 포함)|
| [Apple Framework With Modal & Combine](https://github.com/KayAhn0126/AppleFrameworkWithModalAndCombine)| DiffableDataSource, Snapshot, Compositional Layout, Modal-presentation, SafariServices 및 Combine으로 파이프라인 구축|
| [GithubUserProfile](https://github.com/KayAhn0126/GithubUserProfile)| Navigation Controller, UISearchController, Combine, Kingfisher, Xcode Package Manager를 사용한 Github 사용자 프로필 검색|
| [GithubUserSearch](https://github.com/KayAhn0126/GithubUserSearch)| UICollectionView, DiffableDataSource, Snapshot, Compositional Layout, Navigation Controller, UISearchController, Combine, Kingfisher, Xcode package Manager를 사용한 Github사용자 아이디 검색 및 프로필 제공|
| [AppleFrameworkWithMVVM](https://github.com/KayAhn0126/AppleFrameworkWithMVVM) | [기존 프로젝트](https://github.com/KayAhn0126/AppleFrameworkWithModalAndCombine)내 'Model 데이터를 받아 처리하는 로직'을 ViewModel로 이전, View Controller의 역할 분담 및 추후 유지/보수 목적으로 MVVM 패턴 적용|
| [GithubUserProfileWithMVVM](https://github.com/KayAhn0126/GithubUserProfileWithMVVM)| Combine을 사용한 [기존 프로젝트](https://github.com/KayAhn0126/GithubUserProfile)에 유지/보수 목적으로 MVVM 패턴 적용|
| [GithubUserSearchWithMVVM](https://github.com/KayAhn0126/GithubUserSearchWithMVVM)| [기존 프로젝트](https://github.com/KayAhn0126/GithubUserSearch)에 유지/보수 목적으로 MVVM 패턴 적용|
| [Toss Benefit Tab](https://github.com/KayAhn0126/TossBenefit)| Section별 다른 구조의 cell을 보여주는 토스 혜택 탭 |
| [Catstagram](https://github.com/KayAhn0126/Catstagram) | | |
