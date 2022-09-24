# App Practices

|이름|설명|이유|
|:-:|:-:|:-:|
| [스토리보드 없이 프로젝트 시작하기](https://github.com/KayAhn0126/AppPractice/blob/main/HowToRemoveStoryboard/HowToRemoveStoryboard.md) | 스토리보드 삭제 방법| 코드로 UI를 구성시 불필요한 스토리보드 삭제 방법 메모 |
| [화면 전환 방법](https://github.com/KayAhn0126/AppPractice/tree/main/ScreenTransition) | 직접 호출, 내비게이션 컨트롤러를 이용한 호출 | 화면 전환에 대해 직접 실험 및 정리 |
| [화면간 데이터 전달 방법](https://github.com/KayAhn0126/AppPractice/tree/main/DataTransferBetweenScreens)| 화면간 데이터 전달 방법 정리| 양방향으로 전달하는 방법 공부 |
| [AppDelegate / UserDefaults](https://github.com/KayAhn0126/AppPractice/tree/main/HowToStoreData)| AppDelegate와 UserDefaults를 사용한 데이터 저장 및 전달 방법 정리| 개인 프로젝트에 사용 예정|
| [Alert 띄우기](https://github.com/KayAhn0126/AppPractice/tree/main/Alert)| HIG과 스타일에 대한 정리 | Notification Center 구현 중 공부 후 정리 |
| [ScrollView / StackView](https://github.com/KayAhn0126/AppPractice/tree/main/StackViewAndScrollView) | 스크롤뷰와 스택뷰를 스토리보드와 코드로 구현 | UI구현에서 가장 많이 사용되어 연습 |
| [Delegate Pattern](https://github.com/KayAhn0126/AppPractice/tree/main/DelegatePattern) | PartyDirector가 PartyWorker에게 일을 위임하는 코드 구현 | delegate 패턴이 자주 사용되어 테스트 및 정리 |
| [Delegate Pattern With Role Play](https://github.com/KayAhn0126/AppPractice/tree/main/DelegatePatternWithRolePlay)| 보스가 비서에게 해야할 일을 위임하는 코드 구현| Delegate Pattern 연습|
| [Modern Collection View](https://github.com/KayAhn0126/AppPractice/tree/main/ModernCollectionView)| 복잡한 뷰 및 데이터 일관성을 위한 Compositional Layout 공부| 기존 FlowLayout과 다른점 정리 |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |


# Grammar & knowledge
| 제목 | 설명|
|:-:|:-:|
| [Associated Type](https://github.com/KayAhn0126/AppPractice/tree/main/AssociatedType)| associatedtype 정리|
| [Closure](https://github.com/KayAhn0126/AppPractice/tree/main/Closure)| 기본 클로저 정리|
| [Combine](https://github.com/KayAhn0126/Combine)| [Publisher에서 Subscriber까지 기본 프로세스 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Publisher%20%26%20Subscriber%20%26%20Subscription.xcplaygroundpage/Contents.swift) / [Just, .publisher, .assign 기본 사용법 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Publisher%20%26%20Subscriber.xcplaygroundpage/Contents.swift) / [PassthroughSubject, CurrentValueSubject 퍼블리셔 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Subject.xcplaygroundpage/Contents.swift) / [Subscription 특징 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Subscription.xcplaygroundpage/Contents.swift) / [@Published property wrapper 사용법 정리](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Published.xcplaygroundpage/Contents.swift) / [dataTaskPublisher, Notification, KeyPath, Timer를 통한 Combine 예제](https://github.com/KayAhn0126/Combine/blob/main/Hello%20Combine.playground/Pages/Foundation%20and%20Combine.xcplaygroundpage/Contents.swift)|
| [Network](https://github.com/KayAhn0126/Network)| 네트워크 정리 및 실습|
| [Metatype](https://github.com/KayAhn0126/AppPractice/tree/main/Metatype)| 메타 타입 정리|
| [Generic](https://github.com/KayAhn0126/AppPractice/tree/main/Generic)| 제네릭 정리|
| | |
| | |
| | |
| | |
| | |
| | |

# Clone Projects

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
| | |
| | |
| | |
| | |
| | |
| | |
| | |
| | |

