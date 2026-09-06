<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="vi">

<head>

<meta charset="UTF-8">

<title>Quên mật khẩu - Shopping MVC</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

	<div class="auth-page">

		<div class="auth-box">

			<!-- LOGO -->
			<div class="auth-logo">

				<div class="logo-icon">🔑</div>

				<h2>Quên mật khẩu</h2>

				<p>Khôi phục mật khẩu tài khoản</p>

			</div>


			<!-- THÔNG BÁO LỖI -->
			<%
			if (request.getAttribute("error") != null) {
			%>

			<div class="alert alert-danger">
				<%=request.getAttribute("error")%>
			</div>

			<%
			}
			%>


			<!-- FORM -->
			<form method="post"
				action="${pageContext.request.contextPath}/forgot-password">

				<div class="form-group">

					<label for="email">Email</label> <input type="email" id="email"
						name="email" class="form-control"
						placeholder="Nhập email đã đăng ký"
						value="<%=request.getParameter("email") != null ? request.getParameter("email") : ""%>"
						required>

				</div>


				<button type="submit" class="btn btn-primary btn-block">

					Gửi OTP</button>

			</form>


			<!-- QUAY LẠI ĐĂNG NHẬP -->
			<div class="auth-footer">

				<a href="${pageContext.request.contextPath}/login"> ← Quay lại
					đăng nhập </a>

			</div>

		</div>

	</div>

</body>

</html>