<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
</head>
<body>
<h1>Main Page</h1>
<sec:authorize access="isAnonymous()">
	<a href="/member/login">로그인</a>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<form action="/member/logout" method="post">
		<button>로그아웃</button>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	</form>
</sec:authorize>
</body>
</html>