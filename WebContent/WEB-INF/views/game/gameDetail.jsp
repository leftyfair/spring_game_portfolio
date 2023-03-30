<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>
<link rel="stylesheet" href="${contextPath}/resources/css/gameDetail.css">
<div class="container">
	<h1>${gd.title}</h1>
	<div class="row">
		<div class="col-8">
			<img src="${contextPath}/gameImgDisplay?fileName=${gd.gno}/${gd.fileName}" style="width: 300px">
			<h3>${gd.title}</h3>
			<p>게임 소개</p>
			<p>${gd.content}</p>
		</div>
			
		<div class="col-4">
			<div class="ml-5">
				<table class="table">
					<div class="d-flex justify-content-between">
						<tr>
							<td>가격</td>
							<td class="text-right">₩${gd.price}</td>
						</tr>
						<tr>
							<td>용량</td>
							<td class="text-right">${gd.volSize}</td>
						</tr>
						<tr>
							<td>개발사</td>
							<td class="text-right">${gd.developer}</td>	
						</tr>
					</div>
				</table>
				
				<sec:authorize access="isAnonymous()"> <!-- 권한이 없는 경우  -->
					<form action="${contextPath}/member/login" method="get"> <!-- 기본값 : /logout -->
						<button class="btn btn-danger buyBtn mb-2">지금 구매</button><br>
						<button class="btn btn-light basketBtn">장바구니</button>
					</form> 
				</sec:authorize>
				<sec:authorize access="isAuthenticated()"> <!-- 권한이 있는 경우  -->
						<button class="btn btn-light basketBtn">장바구니</button>
						<a href="${contextPath}/order/payment?gno=${gd.gno}"><button class="btn btn-danger buyBtn mb-2">지금 구매</button></a><br>
					<!-- </form> --> 
				</sec:authorize>
			</div>
		</div>
	</div>
	
		<tr>
			<td colspan="2">
				<button class="btn btn-danger delBoard">삭제</button>
				<a href="${contextPath}/game/modify?gno=${gd.gno}" class="btn btn-warning">수정</a>
			</td>
		</tr>
</div>

<%@ include file="../layout/footer.jsp" %>

<script>
	$(function() {
		$('.delBoard').click(function() {
			let form = $('<form/>');
			form.attr({
				'action' : '${contextPath}/game/remove?gno=${gd.gno}',
				'method' : 'post'
			}).appendTo('body').submit();
		});

		// 구매하기 버튼
		$('.buyBtn').click(function() {
			let form = $('<form/>');
			form.attr({
				'action' : '${contextPath}/order/payment?gno=${gd.gno}',
				'method' : 'post'
			}).appendTo('body').submit();
		});
		
	});
</script>

 

