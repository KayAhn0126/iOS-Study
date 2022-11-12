# Cocoapods / Alamofire 설치

## 🍎 순서
- terminal 열고 Desktop에서 "sudo gem install cocoapods" 입력 -> cocoapods 설치 완료

## 🍎 Cocoapods를 통한 alamofire 설치
- terminal로 alamofire를 설치하고 싶은 폴더까지 들어간다.
    - **중요한점은 something.xcodeproj 파일이 있는 위치까지 들어가야 한다.**
- 프로젝트 파일 경로의 상위에서 pod 파일 설치 시도
    - ![](https://i.imgur.com/MjrwPmH.jpg)
- 정상적으로 설치되었을때 나타나는 Pod file
    - ![](https://i.imgur.com/wHF8PDD.jpg)
- 이제 Podfile을 열고 alamofire github에서 가져온 코드를 작성한다.
    - Alamofire Github내 cocoaPods를 통해 설치할때 코드
    - ![](https://i.imgur.com/OCsWF9u.jpg)
- pod file을 열고 아래와 같이 입력
    - ![](https://i.imgur.com/9nRomHT.png)
- 저장하고 터미널에서 pod install로 설치
    - ![](https://i.imgur.com/6OYw4RG.png)
- M1에서만 발생하는 오류 직면
    - ![](https://i.imgur.com/FytkRSI.png)
- [블로그](https://es1015.tistory.com/506)를 통해 해결
    - ![](https://i.imgur.com/JxxkrAB.png)

## 🍎 Citation
- [블로그](https://es1015.tistory.com/506)
