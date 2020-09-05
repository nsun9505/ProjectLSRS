# User 관련 호출 방식
|Task|URL|Method|Parameter|From|URL이동|
|:--:|:--:|:--:|:--:|:--:|:--:|
|로그인|/login|POST|userid, password|입력화면 필요|main이동|
|회원가입|/member/register|POST|모든 항목|입력화면 필요|main이동 or login이동|
|조회|/member/read|GET|principal.username|-|-|
|수정|/member/modify|POST|수정되는 항목|입력화면 필요|조회 이동|
|탈퇴|/member/remove|POST|principal|입력화면 필요|main으로 이동|

## 각 페이지
- 로그인 : login.jsp
- 회원가입 : register.jsp
- 조회 : read.jsp
- 수정 : modify.jsp
- 탈퇴 : remove.jsp

# 회원가입을 위한 SMS 인증
네이버 클라우드 SENS에서 제공하는 서비스를 이용
- 가입 방법 : https://www.ncloud.com/product/applicationService/sens
- 위 URL로 가면 자세하게 설명이 되어 있고, API 사용법도 있다.
- 자료가 더 필요하다면 구글링!

## 메시지 발송에 앞서..
SMS를 전송하기 위해서 먼저 LSRS 서버가 클라이언트가 되어야 한다.<br>
즉, spring이 client가 되어야 한다.<br>
그래서 관련 자료를 찾아보니 필요한 두 개의 라이브러리가 있다.
- 중요한 것은 RestTemplet 라이브러리인 것 같다.
```xml
<dependency>
    <groupId>org.apache.httpcomponents</groupId>
    <artifactId>httpclient</artifactId>
    <version>4.5.12</version>
</dependency>

<!-- https://mvnrepository.com/artifact/com.google.code.gson/gson -->
<dependency>
    <groupId>com.google.code.gson</groupId>
    <artifactId>gson</artifactId>
    <version>2.8.5</version>
</dependency>
```

## 메시지 발송
### SMS 인증 과정
1. 사용자는 휴대폰 번호를 입력하고, **인증요청**버튼을 클릭한다.
1. 서버에서 휴대폰 번호에 인증문자를 보내기 전에 6자리 난수를 생성한다.
   - 난수를 생성하면 데이터베이스에 기록한다.
   - 난수의 유효기간은 3분으로 정한다.
1. 생성한 난수를 사용자가 입력한 휴대폰 번호로 메시지를 전송한다.
1. 사용자는 자신의 휴대폰에 도착한 SMS의 인증번호를 입력폼에 입력하고 **인증**버튼을 클릭한다.
1. 서버에서는 사용자가 입력한 인증번호를 데이터베이스에서 검색하여 있으면 인증완료, 없다면 다시 입력하라는 메시지 전송
   - 3분 안에만 성공하면 된다.
1. 인증을 완료한 사용자는 다음 작업을 이어가면 된다.