<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>회원가입</title>

  <!-- Custom fonts for this template-->
  <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
</head>

<body>

<div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-lg-6">
        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-12">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h2 text-gray-900 mb-4">회원가입</h1>
                  </div>
                  <form class="user" action="/login" method="post">
                  	   <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" name="username" placeholder="아이디" required>
                    </div>
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" name="password" placeholder="비밀번호" required>
                    </div>
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" name="password" placeholder="비밀번호 확인" required>
                    </div>
					  <div class="form-group">
                      <input type="text" class="form-control form-control-user" name="name" placeholder="이름" required>
                    </div>
                    <div class="form-group row">
                  		<div class="col-sm-6 mb-3 mb-sm-0">
                    			<input type="text" class="form-control form-control-user" id="phoneNumber" name="phoneNumber" placeholder="휴대폰 번호 : -없이 입력">
                  		</div>
                  		<div class="col-sm-6">
                    			<input type="button" class="btn btn-primary btn-user btn-block" id="reqAuth" value="인증">
                  		</div>
                		</div>
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" name="address" placeholder="주소" required>
                    </div>
                    <br>
                    <button class="btn btn-primary btn-user btn-block">회원가입</button>
                  </form>
                  <hr>	
                  <div class="text-center">
                  	<a class="small" href="forgot-password.html">이미 계정이 있는 경우</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="/resources/vendor/jquery/jquery.min.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/resources/js/sb-admin-2.min.js"></script>


	<script>
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		$(document).ready(function(){
			$("#reqAuth").on("click", function(e){
				var phNum = {"phNum": document.getElementById("phoneNumber").value};				
				
				$.ajax({
					url: '/sms/request',
					contentType: "application/json; charset=utf-8;",
					data: JSON.stringify(phNum),
					type: 'POST',
					dataType: 'json',
					success: function(result){
						alert(result);
					}
				})
			})
		})
	</script>
</body>
</html>