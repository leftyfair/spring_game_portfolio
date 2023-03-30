<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>

<div class="container">
	<h1>게시글 상세</h1>
	<table class="table">
		<tr>
			<td>제목</td>
			<td>${b.title}</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${b.content}</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${b.writer}</td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td>
				<c:if test="${empty b.fileName}">
					<b>첨부파일 없음</b>
				</c:if>
				<c:if test="${not empty b.fileName and b.fileType eq 'IMAGE'}">
					<a href="${contextPath}/download?fileName=${b.bno}/${b.fileName}">
						<img src="${contextPath}/imgDisplay?fileName=${b.bno}/${b.fileName}" style="width: 200px">
					</a>
				</c:if>
				<c:if test="${not empty b.fileName and b.fileType eq 'OTHER'}">
					<a href="${contextPath}/download?fileName=${b.bno}/${b.fileName}">
						${b.fileName}
					</a>
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button class="btn btn-danger delBoard">삭제</button>
				<a href="${contextPath}/board/modify?bno=${b.bno}" class="btn btn-warning">수정</a>
			</td>
		</tr>
	</table>


	<!-- 댓글 -->
	
	<div class="replyForm">
		<table class="table">
			
			<tr>
				<th colspan="2">
					<ul class="d-flex justify-content-between">
						<li>댓글을 작성해주세요</li>
						<li class="form-inline">작성자 : <input type="text" class="reply_writer form-control ml-2" value="${auth.id}" readonly="readonly"></li>
					</ul>
				</th>
			</tr>
			
			<tr>
				<td class="col-1 text-center">내용</td>
				<td>
					<textarea rows="5" class="form-control reply_content"></textarea>
				</td>
			</tr>
			
			<tr class="text-right">
				<td colspan="2"><button class="btn btn-primary reply_write">댓글등록</button></td>
			</tr>
			
		</table>
	</div>
	<div class="replyList">
		<div class="card">
			<div class="card-header bg-warning text-white">댓글목록</div>
			<div class="card-body">
			
			</div>
		</div>
	</div>

	<!-- The Modal -->
	<div class="modal fade" id="feedback">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">댓글 등록</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
					<h4>댓글등록성공</h4>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			
			</div>
		</div>
	</div>
</div>



<%@ include file="../layout/footer.jsp" %>

<script>
	$(function() {
		$('.delBoard').click(function() {
			let form = $('<form/>');
			form.attr({
				'action' : '${contextPath}/board/remove?bno=${b.bno}',
				'method' : 'post'
			}).appendTo('body').submit();
		});
	});
</script>

 

