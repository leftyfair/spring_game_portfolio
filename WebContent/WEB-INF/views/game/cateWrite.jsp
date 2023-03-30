<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>

<div class="container">
	<div class="jumbotron">
		<h1>관리자페이지</h1>
	</div>
	
	<div class="row">
		<div class="col-6">
			<h3>게시판 현황</h3>
			<table class="table">
				<tr>
					<th>아이디</th>
					<th colspan="2">이름</th>
				</tr>
				<c:forEach items="${cateList}" var="c">
					<tr>
						<td>${c.cid}</td>
						<td>${c.cname}</td>
						<td><a href="${c.cid}" class="delCate">삭제</a></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	
		<div class="col-6">
			<h3>게시판 추가</h3>
			<form action="${contextPath}/game/addCate" method="post">
				<table>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="cid" class="form-control"></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="cname" class="form-control"></td>
					</tr>
				</table>
				<button class="btn btn-primary">등록</button>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>
		</div>
	</div>
</div>

<%@ include file="../layout/footer.jsp" %>

<script>
	$(function () {
		let form = $('<form/>');
		
		$('.delCate').on('click', function(e) {
			e.preventDefault();
			let cid = $(this).attr('href');
			form.attr({
				'action' : '${contextPath}/admin/delCate?cid='+cid,
				'method' : 'post'	
			}).appendTo('body').submit();
				
		});
	});
</script>