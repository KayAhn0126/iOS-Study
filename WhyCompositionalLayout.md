# UICollectionViewFlowLayout의 한계 및 대체재

![](https://i.imgur.com/DZr1ULB.jpg)

**- 위의 화면들은 기존 UICollectionViwFlowLayout으로는 구현하기 어려웠다. 이에 애플이 내놓은 개선책.**

```swift
extension StockRankViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StockModel.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCollectionViewCell", for: indexPath) as? StockRankCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let stock = stockList[indexPath.item]
        cell.configure(stock)
        return cell
    }
}

extension StockRankViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
}
```

- **점점 복잡한 UI구현이 생기면서 기존 방식을 사용했을때 Controller이 가지고 있는 데이터와 UI에서 보이는 데이터가 일치하지 않는 경우가 발생.**
    - 예를들어, Controller는 값을 받아왔지만 UI에서는 이전 값을 보여주고 있는 경우.

- **기존 구현 방식에서 이러한 문제점이 발생하자 데이터를 하나만 두도록 하는 해결방식 도입 -> Diffable Datasource**

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
