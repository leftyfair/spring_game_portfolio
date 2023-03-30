<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>

<div class="container">
	<h1>파일업로드</h1>
	<form action="${contextPath}/sample/upload" enctype="multipart/form-data" method="post">
		제목 : <input type="text" name="title"><br>
		첨부파일 : <input type="file" name="attachFile"><br>
		<button>전송</button>
	</form>	
	
	<div>
		<img src="${contextPath}/imgDisplay?fileName=꿀벌오소리.jpg">	
	</div>	

</div>

<%@ include file="../layout/footer.jsp" %>
