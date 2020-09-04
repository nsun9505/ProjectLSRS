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