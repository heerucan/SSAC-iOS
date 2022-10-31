# iOS-Begin-Again

#### 🌱 SSAC 2기(2022.07.04 ~ 12.07) 교육을 통해 배운 내용과 프로젝트 정리 레포지토리입니다.

> 이모지를 누르면 해당 이슈로 넘어갑니다!

<hr>

### **🥳 TIL 및 데일리 과제**

> **SSAC Daily** [노션 일지](https://www.notion.so/huree-can-do-it/SSAC-4ded6b03ab7e49be94e41c8cef7d6191)

|WEEK|ISSUE|
|:-:|:-:|
|1주차|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/1)|
|2주차|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/3)|
|3주차|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/7)|
|4주차|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/8)|
|5주차|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/9)|
|6주차|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/11)|
|7주차|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/12)|
|8주차|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/14)|
|9주차|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/15)|
|10주차|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/15)|  
|15주차|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/16)|  
|16-18주차|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/17)|  

<br>

### **🥳 Mini Project**
> 구현 화면은 추후 업데이트할 예정입니다!

|PROJECT|ISSUE|DESCRIPTION|PERIOD|
|:-:|:-:|:-|:-:|
|[`Tamagotchi`](https://github.com/heerucan/SSAC-Tamagotchi)|[🛟](https://github.com/heerucan/SSAC-Tamagotchi/issues)|- **`🦋1차 평가 프로젝트🦋`** <br> - `Storyboard`를 베이스로 Layout 구현 <br> - `UserDefaults`에 값을 저장하고 삭제해서 사용자의 상태에 따라 보여주는 첫 화면을 다르게 구현 <br> - `ReuseableViewProtocol`을 사용해서 뷰컨/셀의 identifier 중복 코드 개선|`07.22 - 07.25`|
|[`TMDB`](https://github.com/heerucan/iOS-Begin-Again/tree/main/TMDB)|[🛟](https://github.com/heerucan/iOS-Begin-Again/issues/10)|- `SwiftyJSON`으로 `TMDB Open API`를 사용해서 최신 영화/배우/추천 영화/유튜브 링크 GET 서버 통신 구현  <br> - `Pagination`을 `UITableViewDataSourcePrefetching`를 사용해서 구현 <br> - `App Transport Security` 설정해서 `http` 접근 허용 <br> - `PageViewController`로 온보딩 화면 추가하고 `UserDefaults`를 통해 최초 앱 실행 시에만 온보딩 보여주도록 구현 <br> - `Custom FrameWork`와 `Access Control`을 사용해서 코드의 인터페이스 명확하게 지정하고 반복되는 코드 개선 |`-`|
|[`Weather`](https://github.com/heerucan/Huree-Weather)|[🛟](https://github.com/heerucan/Huree-Weather/issues)|- `OpenWeather API`를 사용해서 현재 날씨 정보 `GET` <br> - `info.plist`에서 사용자의 위치 접근 권한 허용 <br> - `MapKit`과 `CLLocation`, `CLGeoCoder`를 사용해서 사용자의 현재 위치를 기반으로 날씨와 위치 정보 구현 <br> - 지도에 `Pin`을 꽂아 사용자에게 보여주고, 현재 위치로 이동하는 기능 구현|`-`|
|[`Diary`](https://github.com/heerucan/Huree-Diary)|[🛟](https://github.com/heerucan/Huree-Diary/issues)|- `TableView`를 기반으로 `Unsplash Open API`를 통해 사진 검색해서 가져와 일기를 작성하고 수정하고 삭제하는 기능 구현 <br> - `PHPickerViewController`를 사용해 갤러리/카메라 접근 <br> - `Realm`을 사용해서 자체 데이터베이스로 `CRUD/정렬/필터` 기능 구현 <br> - 이미지의 경우, `FileManager`를 통해서 `Document`에 따로 저장 <br> - `Zip` 라이브러리를 사용해 압축, 백업 및 복구 기능 구현 <br> - `Repository Pattern`을 사용해서 반복되는 코드 개선 <br> - `UIMenu` 기능 구현, `FSCalendar` 맛보기 사용 <br> - `do~try~catch`구문을 사용해서 에러 핸들링 <br> - `Generic`을 사용해서 `Transition Extension` 구현해 화면 전환 시에 반복되는 코드 개선 |`-`|
|[`Memo`](https://github.com/heerucan/SSAC-MEMO)|[🛟](https://github.com/heerucan/SSAC-MEMO/issues)|- **`🦋2차 평가 프로젝트🦋`** <br> - `SnapKit`을 사용한 `Codebase UI` <br> - 애플 기본 메모앱을 클론하고, `Realm`을 활용해서 `CRUD` 기능을 구현|`08.31 - 09.05`|
|[`SSAC-Advanced`](https://github.com/heerucan/SSAC-Advanced)|[🛟](https://github.com/heerucan/SSAC-Advanced/issues)|- **`🦋심화 개념 적용 프로젝트🦋`** <br> - `Compositional Layout/DiffableDataSource`를 사용한 `Codebase UI` <br> - Unsplash API를 사용해서 서버 통신을 구현함 <br> - `Rx+MVVM`을 적용해서 코드 개선|`10/22~`|

<br>

### **🥳 개인 출시 Project**
> 서울시 책방 지도 서비스, 책갈피 [🔖 앱스토어](https://apps.apple.com/kr/app/책갈피/id1645004700)

#### 책갈피 개발 일지
- `Git` 
  - [눙물 줄줄 나는 Couldn’t load project](https://huree-can-do-it.notion.site/gitignore-feat-Couldn-t-load-Project-784231d4681043bdad3d42839935e1a7)
  
- `Feature`
  - [다채로운 네이버 지도 커스터마이징](https://huree-can-do-it.notion.site/1-c327aeb5b29a4889900b410e71dbb208)
  
- `CI/CD`
  - [fastlane을 사용한 자동배포화 적용 삽질기 *testflight에만 적용](https://huree-can-do-it.notion.site/Fastlane-3f733e4a32a5480db76c91fb594a9695)
  
- `Refactor`
  - [URLRequestConvertible을 사용해서 Network 통신 코드 개선하기](https://huree-can-do-it.notion.site/URLRequestConvertible-e118bbf9dd9640a59db13a726ac9779a)
  - [설정뷰에 처음 시도해본 MVVM + Compositional + DiffableDataSource](https://huree-can-do-it.notion.site/MVVM-a050808dee564704b9f118c25fb6eb1a)
  - [설정뷰 Rx 적용해서 개선하기 feat. 멘토님 피드백 반영](https://huree-can-do-it.notion.site/2-Rx-MVVM-70cc157972ff4dc28447a1a342b3abca)
  
- `BugFix`
  - [1기가 넘게 줄줄 새고 있던 메모리 누수 해결](https://huree-can-do-it.notion.site/ccad55aa67be4eb5a79bc6dfb93243c9)

<br>


