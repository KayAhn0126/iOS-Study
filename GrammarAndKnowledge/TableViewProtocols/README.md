# TableView를 유용하게 만들어주는 DataSource와 Delegate 프로토콜 알아보기
- DataSource 프로토콜
    - 테이블 뷰를 생성하고 수정하는데 필요한 정보를 테이블 뷰 객체에 제공
```swift
public protocol UITableViewDataSource : NSObjectProtocol {
    // 각 섹션에 표시할 행의 갯수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    
    // 특정 인덱스 Row의 cell에 대한 정보를 넣어 Cell을 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell

    
    // 총 섹션 갯수 설정 (아무것도 설정하지 않으면 기본 1)
    optional func numberOfSections(in tableView: UITableView) -> Int

    
    // 특정 섹션의 Header에 지정한 문자열이 표시된다.
    optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different

    
    // 특정 섹션의 Footer에 지정한 문자열이 표시된다.
    optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?

    
    // 특정 위치의 행이 편집 가능한지 묻는 메서드, 가능하면 True, 그렇지 않으면 False 반환
    // 또, 가능하다면 특정 셀에 스와이프 기능을 사용할 수 있다. 
    optional func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool

    
    // 특정 위치의 행이 이동 or 재배치 가능한지 묻는 메서드 가능하면 True, 그렇지 않으면 False 반환
    // 또, 가능하다면 셀의 AccessoryType 부분에 이동 가능함을 알려주는 삼선을 표시한다.
    optional func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool

    
    // 섹션의 타이틀을 section index view로 보여주기 위해 리스트 형태로 반환한다.
    optional func sectionIndexTitles(for tableView: UITableView) -> [String]? // return list of section titles to display in section index view (e.g. "ABCD...Z#")

    
    // 인덱스에 해당하는 섹션을 알려주는 메서드
    optional func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int // tell table which section corresponds to section title/index (e.g. "B",1))
    
    
    // 스와이프 또는 편집모드에서 버튼이 선택되면 불리는 메서드. 행이 사라지거나 추가되면 행의 변경 사항을 커밋하기 위함.
    optional func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)

    
    // 행이 이동했다면 from인덱스와 to인덱스를 알려준다.
    optional func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}
```
- Delegate 프로토콜 메서드
    - 테이블 뷰의 시각적인 부분을 설정하고, 행의 액션괄리, 악세서리 뷰 지원 그리고 테이블 뷰의 개별 행 편집을 도와준다.
```swift
public protocol UITableViewDelegate : UIScrollViewDelegate {
    // 행이 선택되었을때 호출되는 메서드 
    optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)

    
    // 행이 선택 해제 되었을때 호출되는 메서드 
    optional func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    
    
    // 특정 위치 행의 높이를 묻는 메서드
    optional func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    
    
    // 지정된 섹션의 헤더 뷰 또는 푸터뷰에 표시할 View가 어떤것인지 묻는 메서드
    optional func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    optional func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    
    
    // 지정된 섹션의 헤더뷰 또는 푸터뷰의 높이를 묻는 메서드
    optional func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    optional func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    
    
    // 테이블 뷰가 편집모드에 들어갔을때 호출되는 메서드
    optional func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
    
    
    // 테이블 뷰가 편집모드에서 나올때 호출되는 메서드
    optional func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)

    
    // 테이블 뷰가 셀을 사용하여 행을 그리기 직전에 호출되는 메서드
    optional func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    
    // 화면에 셀이 사라지면 호출되는 메서드
    optional func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
```
