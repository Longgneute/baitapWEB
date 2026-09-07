<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Đăng nhập - Shopping MVC</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="auth-page">
		<div class="auth-box">
			<!-- LOGO -->
			<div class="auth-logo">
				<div class="logo-icon">🛒</div>
				<h2>Shopping MVC</h2>
				<p>Đăng nhập vào hệ thống</p>
			</div>
			<!-- THÔNG BÁO LỖI TỪ CONTROLLER -->
			<%
			if (request.getAttribute("alert") != null) {
			%>
			<div class="alert alert-danger" role="alert">
				<%=request.getAttribute("alert")%>
			</div>
			<%
			}
			%>
			<!-- FORM LOGIN -->
			<form method="post" action="${pageContext.request.contextPath}/login"
				class="needs-validation" novalidate>
				<!-- USERNAME -->
				<div class="form-group mb-3">
					<label for="username"> Tài khoản </label> <input type="text"
						id="username" name="username" class="form-control"
						placeholder="Nhập tài khoản" maxlength="50" pattern=".{3,50}"
						value="<%=request.getParameter("username") != null ? request.getParameter("username") : ""%>"
						required>
					<div class="invalid-feedback">Vui lòng nhập tài khoản từ 3
						đến 50 ký tự.</div>
				</div>
				<!-- PASSWORD -->
				<div class="form-group mb-3">
					<label for="password"> Mật khẩu </label> <input type="password"
						id="password" name="password" class="form-control"
						placeholder="Nhập mật khẩu" maxlength="50" pattern=".{6,50}"
						required>
					<div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký
						tự.</div>
				</div>
				<!-- REMEMBER -->
				<div style="margin-bottom: 20px;">
					<label> <input type="checkbox" name="remember" value="true">
						Ghi nhớ đăng nhập
					</label>
				</div>
				<!-- BUTTON -->
				<button type="submit" class="btn btn-primary btn-block w-100">
					Đăng nhập</button>
			</form>
			<!-- REGISTER -->
			<div class="auth-footer">
				Chưa có tài khoản? <a
					href="${pageContext.request.contextPath}/register"> Đăng ký
					ngay </a>
			</div>
			<!-- FORGOT PASSWORD -->
			<div class="auth-footer">
				<a href="${pageContext.request.contextPath}/forgot-password">
					Quên mật khẩu? </a>
			</div>
		</div>
	</div>
	<!-- ========================= BOOTSTRAP VALIDATION ========================= -->
	<script> (() => { 'use strict'; const forms = document.querySelectorAll('.needs-validation'); Array.from(forms).forEach(form => { form.addEventListener('submit', event => { if (!form.checkValidity()) { event.preventDefault(); event.stopPropagation(); } form.classList.add('was-validated'); }, false); }); })(); </script>
</body>
</html>