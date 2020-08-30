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