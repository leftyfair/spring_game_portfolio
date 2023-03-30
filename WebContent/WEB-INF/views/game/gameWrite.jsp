<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>

<div class="container">
	<h1>글쓰기</h1>
	<form action="${contextPath}/game/write?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
	<%-- <form action="${contextPath}/game/write" method="post" enctype="multipart/form-data"> --%>
		<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> --%>
		<select name="category.cid" class="form-control">
			<c:forEach items="${cateList}" var="c">
				<option value="${c.cid }">${c.cname}</option>
			</c:forEach>
		</select>
		<input type="text" name="title" placeholder="제목" class="form-control">
		<textarea rows="" cols="" name="content" placeholder="내용" class="form-control"></textarea>
		<input type="text" name="price" placeholder="가격" class="form-control">
		<input type="text" name="volSize" placeholder="용량" class="form-control">
		<input type="text" name="developer" placeholder="개발사" class="form-control">
		<input type="file" name="attachFile" class="form-control">
		<button class="btn btn-info">등록</button>
	</form>		

</div>

<%@ include file="../layout/footer.jsp" %>
