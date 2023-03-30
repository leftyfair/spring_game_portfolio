<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="../layout/header.jsp" %>
<link rel="stylesheet" href="${contextPath}/resources/css/errorMessage.css">

<div class="container">
	<div class="jumbotron">
		<h1>회원 가입</h1>
	</div>
	<!-- 이름, 아이디, 비밀번호, 비밀번호확인, 이메일, 휴대폰번호 -->
	<form action="${contextPath	}/member/join" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<spring:hasBindErrors name="memberDTO" /> <!-- name속성 : 커맨드객체 이름 -->
		<div class="form-group">
			<label for="memberName">이름</label>
			<input type="text" class="form-control" id="memberName" name="memberName" value="${memberDTO.memberName}">
			<form:errors path="memberDTO.memberName" element="div" class="input_errors" />
		</div>
		<div class="form-group">
			<label for="memberId">아이디</label>
			<input type="text" class="form-control" id="memberId" name="memberId" value="${memberDTO.memberId}">
			<form:errors path="memberDTO.memberId" element="div" class="input_errors" />
		</div>
		<div class="form-group">
			<label for="password">비밀번호</label>
			<input type="text" class="form-control" id="password" name="password" value="${memberDTO.password}">
			<form:errors path="memberDTO.password" element="div" class="input_errors" />
		</div>
		<div class="form-group">
			<label for="confirmPassword">비밀번호확인</label>
			<input type="text" class="form-control" id="confirmPassword" name="confirmPassword" value="${memberDTO.confirmPassword}">
			<form:errors path="memberDTO.confirmPassword" element="div" class="input_errors" />
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input type="text" class="form-control" id="email" name="email" value="${memberDTO.email}" >
			<form:errors path="memberDTO.email" element="div" class="input_errors" />
		</div>
		<div class="form-group">
			<label for="phoneNumber">휴대폰번호</label>
			<input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${memberDTO.phoneNumber}">
			<form:errors path="memberDTO.phoneNumber" element="div" class="input_errors" />
		</div>
		<button class="btn btn-primary">가입</button>
	</form>
</div>

<script>
	$(function() {
		let error_form = $('.input_errors');
		console.log(error_form.length);
		if(error_form.length > 0 ) {
			error_form.prev().addClass('error_on');
		}
	});
</script>
<%@ include file="../layout/footer.jsp" %>
