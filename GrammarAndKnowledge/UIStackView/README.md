# UIStackView 속성

## 🍎 OverView
![](https://i.imgur.com/JlZ0HKx.png)

## 🍎 Axis
- Stack View내 subview들이 놓일 방향을 결정
    - horizontal
    - vertical

## 🍎 Alignment
- Stack View의 sub view들을 어떤식으로 정렬할지 결정하는 속성
- 즉, Stack View내에서 아이템들을 어디에 놓을것입니까?
- Fill
![](https://i.imgur.com/CgojqlK.png)
    - stack view의 방향이
        - Horizontal
            - 위 아래 공간을 채우기 위해 sub view들을 늘린다.
        - Vertical
            - 좌 우 공간을 채우기 위해 sub view들을 늘린다.
- Top
![](https://i.imgur.com/gyzQFg5.png)
    - Horizontal stack view에서 sub view들을 top에 맞춰 정렬한다.
- Bottom
![](https://i.imgur.com/CbYAaRl.png)
    - Horizontal stack view에서 스택뷰의 아랫쪽에 맞춰 정렬한다.
- Center
![](https://i.imgur.com/Kij2Hy1.png)
    - 스택뷰 방행에 따라서 sub view들의 센터를 스택뷰의 센터에 정렬한다.
- Leading
![](https://i.imgur.com/Qg1BTnu.png)
    - Vertical stack view에서 sub view들이 스택뷰의 Leading에 맞춰 정렬한다.
- Trailing
![](https://i.imgur.com/74tLeCc.png)
    - Vertical stack view에서 sub view들이 스택뷰의 Trailing에 맞춰 정렬 한다.

- First Baseline
![](https://i.imgur.com/H3pyvoZ.png)
    - sub view들이 first baseline에 맞춰 정렬 한다. (오직 horizontal stack view에서만 사용 가능)
- Last Baseline
![](https://i.imgur.com/LvGkVdB.png)
    - sub view들이 last baseline에 맞춰 정렬한다. (오직 horizontal stack view에서만 사용가능)
    
## 🍎 Distribution
- Stack View안에 들어가는 sub view들의 사이즈를 어떻게 분배할지 설정하는 속성
- 즉, Stack View안에서 아이템들간 간격을 어떻게 할것입니까?
- Fill
![](https://i.imgur.com/XzAC1BG.png)
    - stack view의 방향에 따라 가능한 공간을 모두 채우기 위해 sub view들의 사이즈를 재조정한다. 
    - sub view들의 크기가 줄어들어야 할 때는 각 sub view들의 compression resistance priority를 비교해 우선순위가 낮은 sub view부터 크기를 감소시킨다.
    - 반대로 sub view들의 크기가 늘어나야 할 때는 각 sub view들의 hugging priority를 비교해 우선순위가 낮은 sub view부터 크기를 증가시킨다.
- Fill Equally
![](https://i.imgur.com/TrwzhQ0.png)
    - 모든 sub view들의 사이즈를 동일하게 한다. 
    - axis가 Horizontal
        - 모든 sub view들의 넓이가 일정
    - axis가 Vertical
        - 모든 sub view들의 높이가 일정
- Fill Proportionally
![](https://i.imgur.com/FoathZz.png)
    - stack view의 방향에 따라 sub view가 가지고 있던 크기에 비례하여 공간을 차지하게 만들어 준다.
- Equal Spacing
![](https://i.imgur.com/c63QXjJ.png)
    - stack view의 방향에 따라서 sub view들의 공간을 균등하게 배치하는 옵션.
    - 뷰 사이에 간격이 일정하게 된다.
- Equal Centering
![](https://i.imgur.com/5pUS1FU.png)
    - stack view의 방향에 따라서 각 sub view들의 center와 center간의 길이를 동일하게 맞추는 옵션. 
