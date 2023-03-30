<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>

<!-- Section: Design Block -->
<section class="text-center">
  <!-- Background image -->
  <div class="p-5 bg-image" style="
        background-image: url('https://mdbootstrap.com/img/new/textures/full/171.jpg');
        height: 300px;
        "></div>
  <!-- Background image -->

  <div class="card mx-4 mx-md-5 shadow-5-strong" style="
        margin-top: -100px;
        background: hsla(0, 0%, 100%, 0.8);
        backdrop-filter: blur(30px);
        ">
    <div class="card-body py-5 px-md-5">

      <div class="row d-flex justify-content-center">
        <div class="col-lg-8">
          <h2 class="fw-bold mb-5">로그인</h2>
          <form action="${contextPath}/member/login" method="post">
            <!-- 2 column grid layout with text inputs for the first and last names -->
            <div class="row">
              <div class="col-md-6 mb-4">
                <div class="form-outline">
                  <input type="text" id="loginId" name="loginId" class="form-control" value="${loginId }"/>
                  <label class="form-label" for="loginId">아이디</label>
                </div>
              </div>
              <div class="col-md-6 mb-4">
                <div class="form-outline">
                  <input type="text" id="loginPwd" name="loginPwd" class="form-control" />
                  <label class="form-label" for="loginPwd">비밀번호</label>
                </div>
                <c:if test="${not empty errorMessage }">
					<div class="alert alert-danger">
						<strong>${errorMessage}</strong>
					</div>
				</c:if>
              </div>
            </div>

            <!-- Submit button -->
            로그인상태 유지 : <input type="checkbox" name="remember-me"><br>
            <button class="btn btn-primary btn-block mb-4">
              Sign up
            </button>
            <p>아직 가입하지 않으셨다면 <a href="${contextPath}/member/join">회원가입</a></p>
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
          </form>
        </div>
      </div>
    </div>
  </div>
</section>
<!-- Section: Design Block -->

<%@ include file="../layout/footer.jsp" %>
