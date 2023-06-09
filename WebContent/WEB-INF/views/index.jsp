<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="layout/header.jsp" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberVO.authList" var="authList"/>
	<script>
	let memberType = [];
	<c:forEach items="${authList}" var="auth">
		memberType.push("${auth.memberType}");	
	</c:forEach>
	</script>
</sec:authorize>

<div class="container">
	<h1>메인</h1>
	
	
	<sec:authorize access="isAnonymous()"><!-- 권한이 없는 경우  -->
		<a href="${contextPath}/member/join">회원가입</a><br>
		<a href="${contextPath}/member/login">로그인</a><br>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()"> <!-- 권한이 있는 경우  -->
		<p>로그인 중 : <sec:authentication property="principal.username"/></p> <!-- 로그인 id-->
		<form action="${contextPath}/member/logout" method="post"> <!-- 기본값 : /logout -->
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<button class="btn btn-primary">로그아웃</button>
		</form> 
	</sec:authorize>
	<a href="${contextPath}/member/all">모든 사용자 접근 가능</a><br>
	<sec:authorize access="hasAnyRole('ROLE_REGULAR_MEMBER','ROLE_ASSOCIATE_MEMBER')">
		<a href="${contextPath}/member/mypage">나의정보보기</a><br>
	</sec:authorize>
	
	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_SUB_ADMIN')">
		<a href="${contextPath}/member/admin">관리자만 접근 가능</a><br>
	</sec:authorize>
</div>
<%@ include file="layout/footer.jsp" %>

<script>
let loginOn = "${loginOn}"
if(loginOn!='') alert(loginOn);

</script>
