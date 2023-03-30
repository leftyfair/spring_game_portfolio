<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js" integrity="sha512-XtmMtDEcNz2j7ekrtHvOVR4iwwaD6o/FUJe6+Zq+HgcCsk3kj4uSQQR8weQ2QVj1o0Pk6PwYLohm206ZzNfubg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script>const contextPath = '${contextPath}';</script> 
<link rel="stylesheet" href="${contextPath}/resources/css/style.css">

<script src="${contextPath}/resources/js/main.js"></script>
<script src="${contextPath}/resources/js/list.js"></script>
<style>
	nav a {color: white;}
</style>
</head>
<body>

<nav class="navbar navbar-expand-sm bg-dark d-flex justify-content-between">
	<div class="container">
	  <!-- Links -->
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link mx-3" href="${contextPath}/"><img src="${contextPath}/resources/images/logo/game_site_logo.png" style="width:30px"></a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${contextPath}/game/list">스토어</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${contextPath}/board/list">커뮤니티</a>
			</li>
		</ul>
		<ul class="navbar-nav">
			<sec:authorize access="isAnonymous()"><!-- 권한이 없는 경우  -->
				<li class="nav-item">
					<a class="nav-link mx-3" href="${contextPath}/member/login">로그인</a>
				</li>
				<li class="nav-item">
					<a class="nav-link mx-3" href="${contextPath}/member/join">회원가입</a>
				</li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()"> <!-- 권한이 있는 경우  -->
				<p style="color: white; margin: 0 10px 0 0; line-height: 40px"><b><sec:authentication property="principal.username"/></b>님</p> <!-- 로그인 id-->
				<form action="${contextPath}/member/logout" method="post"> <!-- 기본값 : /logout -->
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<button class="btn btn-primary">로그아웃</button>
				</form> 
			</sec:authorize>
		</ul>
	</div>
</nav>

