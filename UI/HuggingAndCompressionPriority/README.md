# Hugging Priority & Compression Resistance Priority
![](https://i.imgur.com/wU9ck7l.png)
- 빨간 화살표로 되어있는 부분은 모두 super view에서 20만큼 떨어져있다.
- 이 상태에서 상단의 Label과 하단의 Label 사이에 간격을 20으로 주게 된다면 아래와 같은 Hugging priority를 조정하라는 문구가 뜬다.
![](https://i.imgur.com/cI45J5o.png)
- 그럼 Content Hugging Priority는 뭘까?

## 🍎 Priority 사용 전 알아두어야 할것
- UIKit에서 제공되는 일부 뷰(UILabel, UIButton, UIImage)에는 컨텐츠 고유 사이즈라는 개념이 있다. 텍스트나 이미지에 따라 크기가 결정되는 view들이 있다. 이러한 view들은 다른 view들과 걸린 제약에 의해서 본래의 컨텐츠 고유 사이즈 보다 더 늘어나거나 줄어들게 된다. 이때 Hugging Priority와 Compression Resistance Priority로 어떤 컨텐츠를 늘려주고 줄여줄건지 제약을 걸어주면 된다.

## 🍎 Content Hugging Priority
- 이 프로젝트에서는 **명언을 표시하는 Label**이 **이름을 표시하는  Label** 보다 크기가 커야한다. 
- 컨텐츠가 더 늘어나는것에 대해 저항하는 제약을 Content Hugging Priority라고 한다.
- Hugging Priority의 숫자가 높으면 내 크기를 유지한다. 우선순위가 높다고 표현한다.
- 반대로 숫자가 낮으면 늘어나게 된다. 우선순위가 낮다고 표현한다.
- 즉, 두 Label 중 Content Hugging Priority내 vertical 값이 상대적으로 더 높은 쪽이 크기를 유지하고 상대적으로 낮은쪽의 크기가 늘어나게 된다.
- 우선순위는 1000(절대적), 750(높음), 500(중간), 250(낮음) 식으로 제약을 준다.
- 이제 Hugging Priority가 무엇인지 알았으니 Label 사이에 에러를 없애보자.
![](https://i.imgur.com/1hZVLv3.png)
- 명언이 들어갈 자리에 임시로 애국가를 넣어 Content Compression Resistance Priority의 제약과 그 중요성에 대해 알아보자!

## 🍎 애국가를 넣은 후 문제 발생
![](https://i.imgur.com/mjkWQdi.png)
- Label의 attributes inspector에서 Lines = 0으로 맞추고 아주 긴 명언(애국가)을 넣었더니, 문자열을 표시할 공간이 없다고 Compression resistance priority 제약에 대해 불만을 가지고 있다.
- 이제 Compression resistance priority 값을 조정해서 어떤 Label의 사이즈를 유지 시킬지 정할수 있다.
- size inspector 내 Compression resistance priority에서 제약을 걸수 있다.
![](https://i.imgur.com/CwFFW9u.png)

## 🍎 Content Compression Resistance Priority
- 반대로, 더 줄어드는것에 대해 저항하는 제약을 Content Compression Resistance Priority라고 한다.
- 마찬가지로 우선순위가 높으면 자신의 크기를 유지하고, 우선순위가 낮으면 크기가 줄어들게 된다.
- 명언을 표시하는 Label의 크기는 줄어들수 있지만, 명언을 한 사람 Label의 크기는 항상 고정되어야 한다.
- 이름 Label을 유지 해야하므로 명언 내용 Label의 Compression Resistance Priority 보다 1높은 751로 설정하면 명언 내용 Label이 아무리 길어져도 이름 Label은 그대로 유지된다!
![](https://i.imgur.com/rcK48T1.jpg)

