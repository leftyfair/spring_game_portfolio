<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>

<div class="container">
	<h1 class="text-center my-5">구매창</h1>
	<div class="">
		<table class="table">
			<tr>
				<th>제목</th>
				<th>썸네일</th>
				<th>가격</th>
				<th>용량</th>
				<th>개발사</th>
			</tr>
			<tr>
				<td>${pay.title}</td>
				<td><img src="${contextPath}/gameImgDisplay?fileName=${pay.gno}/${pay.fileName}" style="width: 50px"></td>
				<td class="">₩${pay.price}</td>
				<td class="">${pay.volSize}</td>
				<td class="">${pay.developer}</td>	
			</tr>
		</table>
	</div>
	<div class="text-right">
		<button class="btn btn-primary">결제하기</button>
	</div>
</div>

<%@ include file="../layout/footer.jsp" %>
