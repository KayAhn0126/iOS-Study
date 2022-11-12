# Table View / Collection View

## 🍎 기본
- Table View / Collection View는 데이터 관리는 직접 하지 않고 cell을 보여주는 역할만 한다.
- 데이터를 관리하는 역할을 하는 DataSource
- 화면에 어떻게 배치 할지 정하는 Delegate or DelegateFlowLayout 

## 🍎 UITableViewDataSource / UICollectionViewDataSource
- UITableViewDataSource 또는 UICollectionViewDataSource 프로토콜 채택 후 필수 구현 메소드 2개
    - UITableViewDataSource
        - numberOfRowsInSection()
        - cellForRowAt()
        - 사용 예제
        ![](https://i.imgur.com/SEXErDs.png)
    - UICollectionViewDataSource
        - numberOfItemsInSection()
        - cellForItemAt()
        - 사용 예제
        ![](https://i.imgur.com/Qwc0JDb.png)

    - Section이 두개 이상 일때는
        - numberOfSections()

## 🍎 UITableViewDelegate / UICollectionViewDelegateFlowLayout
- UITableViewDelegate 또는 UICollectionViewDelegateFlowLayout 프로토콜 채택 후 구현 메소드 1개
- Table View의 넓이는 화면의 가로 길이로 정해져있다.
    - UITableViewDelegate
        - heightForRowAt
        ![](https://i.imgur.com/iOklfoa.png)

- 하지만 Collection View는 넓이와 높이 둘 다 정해 주어야 한다.
    - UICollectionViewDelegateFlowLayout
        - sizeForItemAt
        ![](https://i.imgur.com/aeT00wn.png)

## 🍎 Citation
[ellyheetov](https://velog.io/@ellyheetov/DataSource)


