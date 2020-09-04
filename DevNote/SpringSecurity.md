# Spring Security 관련 정리

# AuthenticationManager
- 스프링 시큐리티에서 가장 중요한 역할이며 인증을 담당
- 다양한 방식의 인증을 처리

## 구조
```
    AuthenticationManager   <-----  ProviderManager
    ProdviderManager        <---->  AuthenticationProvider
```
- ProviderManager는 인증에 대한 처리를 AuthenticationManager라는 타입의 객체를 이용해서 처리를 위임
- AuthenticationProvider는 실제 인증 작업을 진행한다.
- 인증된 정보에는 권한에 대한 정보를 같이 전달하는데 이 처리는 UserDetailsService와 관련이 있다.

### UserDetailsService
- UserDetailsService 인터페이스의 구현체는 실제로 사용자의 정보와 사용자가 가진 권한의 정보를 처리해서 반환

## 개발자가 스프링 시큐리티를 커스터마이징 하는 방식
1. AuthenticationProvider를 직접 구현하는 방식
   - 새로운 프로토코리나 인증 구현 방식을 직접 구현하는 경우에는 AuthenticationProvider 인터페이스를 직접 구현해서 사용
1. 실제 처리를 담당하는 UserDetailsService를 구현하는 방식
   - 대부분 UserDetailsService를 구현하는 형태를 사용

# 접근제한 설정
## security-context.xml
```xml
<security:http>
    <security:intercept-url pattern="/url" access="permitAll">
    <security:intercept-url pattern="/autenticated" access="hasRole('ROLE MEMBER')">
</security:http>
```
- 특정한 URI에 접근할 때 인터셉터를 이용해서 제한하는 설정은 \<security:intercept-url>을 사용한다.

### \<security:intercept-url>
- pattern 속성 : URI의 패턴을 의미
- access 속성 : 권한을 체크한다.
   - access 속성값으로 사용되는 문자열은 표현식과 권한명을 의미하는 문자열을 이용

## 스프링 시큐리티에서 명심해야 하는 사항 중 하나
- username이나 User라는 용어의 의미가 일반적인 시스템에서의 의미와 차이가 있다는 점이다.
- 일반 시스템에서 userid는 스프링 시큐리티에서는 username에 해당한다.
- 일반적으로 사용자의 이름을 username이라고 처리하는 것과 혼동하면 안 된다.

### 스프링 시큐리티의 User는 인증 정보와 권한을 가진 객체
- 일반적인 경우에 사용하는 사용자 정보와는 다른 의미


## 인증과 권한에 대한 실제 처리는 UserDetailsService라는 것을 이용해서 처리
```xml
<!-- security-context.xml 일부 -->
<security:http>
    ...
</security:http>

<security:authentication-manager>
    <security:authentication-provider>
        <security:user-service>
            <security:user user="member" password="member" authorities="ROME_MEMBER"/>
        </security:user-service>
    </security:authentication-provider>
</security:authentication-manager>
```
- 정상적으로 실행되지 않음.
- 스프링 시큐리티 5버전부터 반드시 PasswordEncoder라는 존재를 이용하도록 변경되었다.
- 스프링 시큐리티 4버전까지는 PasswordEncoder의 지정이 없이도 동작했다.

#### 접근 제한 메시지의 처리
- 스프링 시큐리티에서는 접근 제한에 대해서 AccessDeniedHandler를 직접 구현하거나 특정한 URI를 지정할 수 있다.
    ```xml
        <security:access-denied-handler error-page="/accessError"/>
    ```
    - <security:access-denied-handler>는 org.springframework.security.web.access.AccessDeniedHandler 인터페이스의 구현체를 지정하거나
    - error-page를 직접 지정할 수 있다.
    - 실제 Controller에서 error-page에 대한 처리를 하도록 지정해야 함.

##### ErrorController Class
```java
    @Controller
    @Log4j
    public class ErrorController {
        @GetMapping("/accessError")
        public void accessDenied(Authentication auth, Model model){
            model.addAttribute("msg", "Access Denied");
        }
    }
```
- Authentication 타입의 파라미터를 받도록 설계해서 필요한 경우에 사용자의 정보를 확인

#### AccessDeniedHandler 인터페이스를 구현하는 경우
- 접근제한이 된 경우에 다양한 처리를 하고 싶다면 직접 AccessDeniedHandler 인터페이스를 구현하는 편이 좋다.
```java
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
    @Override
    public void handle(HttpServletRequest request, 
        HttpServletResponse response, AccessDeniedException accessException)
        throws IOException, ServletException {
            response.sendRedirect("/accessError");
        }
}
```
- AccessDeniedHandler 인터페이스를 직접 구현
- 접근 제한에 걸리는 경우 리다이렉트 하는 방식으로 동작하도록 지정되어 있다.

##### security-context.xml에서는 error-page 속성 대신에 CustomAccessDeniedHandler를 빈으로 등록해서 사용
[security-context.xml 일부]
```xml
<bean id="customAccessDenied" class="package.CustomAccessDeniedHandler" />

<security:http>
    ...
    <security:access-denied-handler ref="customAccessDenied" />
</security:http>
```

## 커스텀 로그인 페이지
[security-context.xml]
```xml
<security:http>
    ...
    <security:form-login login-page="/loginPage"/>
</security:http>
```
- login-page 속성의 URI는 반드시 GET 방식으로 접근하는 URI를 지정한다.
- 위와 같이 login-page 속성값을 "/loginPage"와 같이 정의했다면 해당 JSP를 views 아래에 있어야 한다.

### loginPage.jsp
```jsp
<div class="container">
	<form class="user" method="post" action="/login">
		<div class="form-group">
			<input type="text" class="form-control form-control-user" name="username" placeholder="ID">
		</div>
			<div class="form-group">
				<input type="password" class="form-control form-control-user" name="password" placeholder="Password">
			</div>
			<div class="form-group">
				<input type="submit" class="btn btn-user btn-block">
			</div>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	</form>
</div>
```
- action="/login" : 실제 로그인의 처리 작업이 이루어지며 반드시 POST로 전송해야함.
- name 속성은 username, password가 기본이다.
<br><br>

# JDBC를 이용한 간편 인증/권한 관리
인증과 권한에 대한 처리는 크게 Authentication Manager에 의해 처리된다.
- 인증이나 권한 정보를 제공하는 존재(Provider)가 필요
- 다시 이를 위해서 UserDetailsService라는 인터페이스를 구현한 존재를 활요

## JDBC를 이용하기 위한 테이블 설정
JDBC를 이용해서 인증/권한을 체크하는 방식
1. 지정된 형식으로 테이블을 생성해서 사용하는 방식
1. 기존에 작성된 데이터베이스를 이용하는 방식

### JdbcUserDetailsManager 클래스
스프링 시큐리티가 JDBC를 이용하는 경우에 사용하는 클래스

## 기존의 테이블을 이용하는 경우
JDBC를 이용하고 기존에 테이블이 있다면 약간의 지정된 결과를 반환하는 쿼리를 작성해 주는 작업으로도 처리 가능

\<security:jdbc-user-service> 태그 속성
- users-by-username-query, authorities-by-username-query 속성에 적당한 쿼리문을 지정해 주면 JDBC를 이용하는 설정을 그대로 사용 가능

-------------------------------------------------------------------------------------------------------------

# Spring Security를 JSP에서 사용하기
JDBC와 약간의 쿼리를 이용하는 것만으로도 데이터베이스를 이용해서 스프링 시큐리티를 사용 가능
[security-context.xml]
```
<security:authentication-manager>
		<security:authentication-provider>
			<security:jdbc-user-service data-source-ref="dataSource"
				users-by-username-query="select userid, userpw, enabled from tbl_user where userid=?"
				authorities-by-username-query="select userid, authType from tbl_user_auth ua, tbl_auth auth
													where ua.userid=? and ua.authId=auth.authId"/>
			<security:password-encoder ref="bcryptPasswordEncoder"/>
		</security:authentication-provider>
	</security:authentication-manager>
```

굳이 CustomUserDetailsService와 같이 별도의 인증/권한 체크를 하는 가장 큰 이유
- JSP 등에서 단순히 사용자의 아이디(스프링 시큐리티에서는 username) 정도가 아닌 사용자의 이름이나 이메일과 같은 추가적인 정보를 이용하기 위함.
- LSRS 프로젝트에서는 사용자의 이름, 핸드폰 번호 등이 필요하기 때문에 스프링 시큐리티의 User를 CustomUser로 상속받아서 사용한다.

## JSP에서 로그인한 사용자 정보 보여주기
스프링 시큐리티 관련 태그 라이브러리 선언
- \<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec">
- \<sec:authentication> 태그와 principal이라는 이름의 속성을 사용

[test.jsp]
```html
...
<body>
<h1>/member/admin page</h1>

<p> principal : <sec:authentication property="principal"/></p>
<p> UserVO : <sec:authentication property="principal.user"/></p>
<p> 사용자 이름 : <sec:authentication property="principal.user.username"/></p>
<p> 사용자 ID : <sec:authentication property="principal.username"/>
<p> 사용자 휴대폰 번호 : <sec:authentication property="principal.user.phnum"/>
<p> 사용자 권한 리스트 : <sec:authentication property="principal.user.authList"/></p>
...
</body>

```
- \<sec:authentication property="principal"/> : UserDetailsService에서 반환된 객체
   - CustomUserDetailsService를 이용했다면 loadUserByUsername()에서 반환된 CustomUser 객체가 된다.
- principal : CustomUser를 의미하므로, principal.user는 CustomUser 객체의 getUser()를 호출한다.
   ```java
   // CustomUser.java
    @Getter
    public class CustomUser extends User{
    	private static final long serialVersionUID = 1L;
	
	    private UserVO user;
	
	    public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		    super(username, password, authorities);
	    }
	
	    public CustomUser(UserVO vo) {
    		super(vo.getUserid(), vo.getUserpw(), vo.getAuthList().stream()
				    .map(auth -> new SimpleGrantedAuthority(auth.getAuthId().toString()))
				    .collect(Collectors.toList()));
		    this.user = vo;
	    }
    }
   ```

## 표현식을 이용하는 동적 화면 구성
특정한 페이지에서 로그인한 사용자의 경우에는 특정한 내용을 보여주고, 그렇지 않은 경우에는 다른 내용을 보여주는 경우가 있다.
- 예를 들어 /member/login은 로그인한 사용자에게는 로그인 페이지를 보여주고, 로그인한 사용자에게는 접근하지 못하도록 하는 처리를 할 수 있다.
- 이때 유용한 것이 스프링 시큐리티의 expression이다.
- 스프링 시큐리티 표현식은 security-context.xml에서도 사용된다.

### 스프링 시큐리티에서 주로 사용되는 표현식
|표현식|설명|
|:---|:---|
|hasRole([role]), hasAuthority([authority])|해당 권한이 있으면 True|
|hasAnyRole([role, role2]), hasAnyAuthority([authority])|여러 권한들 중에서 하나라도 해당하는 권한이 있으면 true|
|principal|현재 사용자 정보|
|permitAll|모든 사용자 허용|
|denyAll|모든 사용자 거부|
|isAnonymous()|익명의 사용자의 경우(로그인을 하지 않은 경우에도 해당)|
|isAuthenticated()|인증된 사용자면 true, 인증된 사용자만 접근 가능|
|isFullyAuthenticated()|Remember-me로 인증된 것이 아닌 인증된 사용자인 경우 true|
- 표현식은 거의 대부분 참(true)/거짓(false)를 리턴하기에 조건문을 사용하는 것처럼 사용

## Login 페이지를 작성할 때 신경 써야 할 부분들
- JSTL이나 스프링 시큐리티의 태그를 사용할 수 있도록 선언
- CSS 파일이나 JS 파일의 링크는 절대 경로를 쓰도록 수정
- \<form> 태그 내의 \<input> 태그의 name 속성을 스프링 시큐리티에 맞게 작성
   - 가장 신경 써야 할 부분
- CSRF 토큰 항목 추가
- JavaScript를 통한 로그인 전송

### 스프링 시큐리티 로그인 처리
- 스프링 시큐리티는 기본적으로 로그인 후 처리를 SavedRequestAwareAuthenticationSuccessHandler라는 클래스를 이용
- 해당 클래스는 사용자가 원래 보려고 했던 페이지의 정보를 유지해서 로그인 후에 다시 원했던 페이지로 이동하는 방식

### SavedRequestAwareAuthenticationSuccessHandler 이용하는 설정
- XML이나 Java 설정에서 authentication-success-handler-ref 속성이나 successHandler() 메서드를 삭제하고 관련 스프링 빈의 설정도 사용하지 않도록 설정해야 한다.
```xml
<!-- security-context.xml -->
...
\<security:from-login login-page="/member/login"/>
...
```

### 컨트롤러에서 스프링 시큐리티 처리
#### @PreAuthorize("표현식")
- 예시
   ```java
        @Controller
        public class example{
            @GetMapping("/register")
            @PreAuthorize("isAuthenticated()")
            public void register(){

            }

            @PostMapping("/register")
            @PreAuthorize("isAuthenticated()")
            public String register(...){
                //......
            }
        }
   ```
   - @PreAuthorize : isAuthenticated()로 어떠한 사용자든 로그인이 성공한 사용자만이 해당 기능을 사용할 수 있도록 처리

## CSRF 토큰 설정
스프링 시큐리티를 사용할 떄 POST 방식의 전송은 반드시 **CSRF 토큰**을 사용하도록 추가해야 한다.
- 보통 form 태그 내에 CSRF 토큰 값을 input 태그의 hidden 타입으로 추가한다.
    ```html
        <form role="form" action="/board/register" method="post">
            <input type="hidden" name="${_csrf.parametername}" 
                    value="${_csrf.token}">
        </form>
    ```

## 스프링 시큐리티 한글 처리
한글 처리는 web.xml을 이용해서 스프링의 CharacterEncodingFiletr를 이용
- 시큐리티를 필터로 적용할 때에는 필터의 순서에 주의해야 한다.
    ```xml
    <!-- web.xml 일부 -->
    <!-- 인코딩 설정, 스프링 시큐리티 적용 순서로 한다. -->
    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-name>
        </init-param>
    </filter>

    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <filter>
        스프링 시큐리티
    </filter>
    <filter-mapping>
        스프링 시큐리티 매핑
    </filter-mapping>
    ```
    - 필터 순서가 바뀌면 한글이 깨져서 컨트롤러로 전달된다.

## 현재 로그인한 사용자만이 수정/삭제 작업하는 기능 구현
JSP에서 spring security 관련 태그를 사용
```html
    <sec:authentication property="principal" val="pinfo">

    <sec:authorize access="isAuthenticated()">
        <c:if test="${pinfo.username eq reserv.userId}">
            <button data-oper="modify" class="btn">Modify</btn>
        </c:if>
    </sec:authorize>
```
- \<sec:authentication> 태그를 매번 이용하는 것은 불편하기에 로그인과 관련된 정보인 principal을 아예 JSP 내에서 pinfo라는 이름의 변수로 사용
- \<sec:authorize>는 인증받은 사용자만이 영향을 받기 위해 지정
- 내부에서는 username과 예약한 사용자 userId가 일치하는지를 확인해서 Modify 버튼 활성화 및 비활성화


## 컨트롤러에서의 제어
컨트롤러에서 메서드를 실행하기 전에 로그인한 사용자와 현재 파라미터로 전달되는 작성자가 일치하는지 체크
- @PreAuthorize의 경우 문자열로 표현식을 지정할 수 있는데
- 컨트롤러에 전달되는 파라미터를 같이 사용할 수 있으므로 유용하다.
    ```java
        @PreAuthorize("principal.username == #reservationUser")
        @PostMapping("/remove")
        public String remove(@RequestMapping("rno") Long rno, RedirectAttributes rttr, String reservationUser){
            log.info("remove....");

            if(service.remove(rno)){
                rttr.addFlashAttribute("result", "success");
            }
            return "redirect:/reserv/info";
        }
    ```

## Ajax와 스프링 시큐리티 처리
스프링 시큐리티가 적용되면 POST, PUT, PATCH, DELETE와 같은 방식으로 데이터를 전송하는 경우
- 반드시 추가적으로 **X-CSRF-TOKEN**와 같은 헤더 정보를 추가해서 CSRF 토큰값을 전달하도록 수정해야 한다.
- Ajax는 JavaScript를 이용하기에 브라우저에서는 CSRF 토큰과 관련된 값을 변수로 선언하고, 전송 시 포함시켜주는 방식으로 수정하면 될 것이다.

<br><br>

## 이제 회원관련 기능을 구현해보자.