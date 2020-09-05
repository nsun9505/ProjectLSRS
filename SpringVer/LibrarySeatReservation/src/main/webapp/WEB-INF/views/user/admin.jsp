<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
<h1>/member/admin page</h1>

<p> principal : <sec:authentication property="principal"/></p>
<p> UserVO : <sec:authentication property="principal.user"/></p>
<p> 사용자 이름 : <sec:authentication property="principal.user.username"/></p>
<p> 사용자 ID : <sec:authentication property="principal.username"/>
<p> 사용자 휴대폰 번호 : <sec:authentication property="principal.user.phnum"/>
<p> 사용자 권한 리스트 : <sec:authentication property="principal.user.authList"/></p>

<a href="/customLogout">Logout</a>


</body>
</html>