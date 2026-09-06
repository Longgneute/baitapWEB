<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>

<html lang="vi">

<head>

<meta charset="UTF-8">

<title>Đăng ký</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

	<div class="auth-page">

		<div class="auth-box">

			<h2>Đăng ký tài khoản</h2>

			<%
			if (request.getAttribute("error") != null) {
			%>

			<div class="alert alert-danger">
				<%=request.getAttribute("error")%>
			</div>

			<%
			}
			%>

			<form method="post"
				action="${pageContext.request.contextPath}/register">

				<div class="form-group">

					<label>Email</label> <input type="email" name="email"
						class="form-control" required>

				</div>

				<div class="form-group">

					<label>Tài khoản</label> <input type="text" name="username"
						class="form-control" required>

				</div>

				<div class="form-group">

					<label>Họ tên</label> <input type="text" name="fullname"
						class="form-control" required>

				</div>

				<div class="form-group">

					<label>Số điện thoại</label> <input type="text" name="phone"
						class="form-control" required>

				</div>

				<div class="form-group">

					<label>Mật khẩu</label> <input type="password" name="password"
						class="form-control" required>

				</div>

				<button type="submit" class="btn btn-primary btn-block">

					Đăng ký</button>

			</form>

			<div class="auth-footer">

				Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">
					Đăng nhập </a>

			</div>

		</div>

	</div>

</body>

</html>