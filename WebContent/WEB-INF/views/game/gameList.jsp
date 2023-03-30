<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>

<input type="hidden" value="${cri.page}" name="page" class="page">
<div class="container">
	<h1 class="my-5">스토어</h1>
  	<div class="row  d-flex justify-content-between">
		<ul class="d-flex">
			<li class="list-group-item">
				<a href="${contextPath}/game/list">전체</a>
			</li>
			<c:forEach items="${cateList}" var="c">
				<li class="list-group-item">
					<a href="${contextPath}/game/list/${c.cid}">${c.cname}</a>
				</li>
			</c:forEach>
		</ul>
			<div class="my-3">
				<form class="form-inline searchForm">
					<select class="form-control mr-2 category">
						<option value="">전체</option>
						<c:forEach items="${cateList}" var="c">
							<option value="${c.cid}" ${cid == c.cid? 'selected' : ''}>${c.cname}</option>
						</c:forEach>
					</select>
					<select name="type" class="form-control mr-2">
						<option value="T" ${cri.type == 'T' ? 'selected' : ''}>제목</option>
						<option value="C" ${cri.type == 'C' ? 'selected' : ''}>내용</option>
						<option value="W" ${cri.type == 'W' ? 'selected' : ''}>작성자</option>
					</select>
					<div class="form-group mr-2">
						<input type="search" class="form-control" name="keyword" value="${cri.keyword}">
					</div>
					<div class="form-group mr-2">
						<button type="button" class="btn btn-primary">검색</button>
					</div>
				</form>	
			</div>
		</div>
  		
	<c:choose>
		<c:when test="${!empty game}">
			<div class="row my-5">
				<c:forEach  begin="0" end="7" items="${game}" var="g">
					<div class="col-md-3 mb-2">
							<a href="${contextPath}/game/detail?gno=${g.gno}">
								<img src="${contextPath}/gameImgDisplay?fileName=${g.gno}/${g.fileName}" style="width: 200px">
								<p>${g.title}<br>
									<span>
										<strike style="color: gray">
											₩<fmt:formatNumber value="${g.price * 0.8}" maxFractionDigits="0" />
										</strike>&nbsp;
											₩<fmt:formatNumber value="${g.price}" maxFractionDigits="0" />
									</span>

								</p>
							</a>
					</div>
				</c:forEach>
      		</div>
		</c:when>
		<c:otherwise>
			<h1 class="text-center jumbotron bg-light">검색한 게임이 없습니다.</h1>
		</c:otherwise>
	</c:choose>
	<ul class="pagination justify-content-center">
		<c:if test="${p.prev}">
			<li class="page-item">
				<a class="page-link" href="${p.startPage - 1}">Prev</a>
			</li>
		</c:if>
		
		<c:forEach begin="${p.startPage}" end="${p.endPage}" var="pageNum">
			<li class="page-item ${cri.page == pageNum ? 'active' : ''}">
				<a class="page-link" href="${pageNum}">${pageNum}</a>
			</li>
		</c:forEach>
		
		<c:if test="${p.next}">
			<li class="page-item">
				<a class="page-link" href="${p.endPage + 1}">Next</a>
			</li>
		</c:if>
	</ul>
	<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_SUB_ADMIN')" >
		<a href="${contextPath}/game/write" class="btn btn-primary">글쓰기</a>
	</sec:authorize>
</div>

<%@ include file="../layout/footer.jsp" %>
