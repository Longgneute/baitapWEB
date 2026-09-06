<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="vi">

<head>

<meta charset="UTF-8">

<title>Đặt lại mật khẩu</title>

<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: Arial, sans-serif;
	background: linear-gradient(135deg, #667eea, #764ba2);
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
}

.container {
	width: 420px;
	background: white;
	padding: 35px;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
}

h2 {
	text-align: center;
	margin-bottom: 10px;
	color: #333;
}

.description {
	text-align: center;
	color: #777;
	margin-bottom: 25px;
}

.form-group {
	margin-bottom: 18px;
}

label {
	display: block;
	margin-bottom: 7px;
	font-weight: bold;
	color: #444;
}

input {
	width: 100%;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 8px;
	font-size: 15px;
	outline: none;
}

input:focus {
	border-color: #667eea;
}

button {
	width: 100%;
	padding: 13px;
	border: none;
	border-radius: 8px;
	background: #667eea;
	color: white;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
}

button:hover {
	background: #5568d8;
}

.error {
	background: #ffe5e5;
	color: #d60000;
	padding: 10px;
	border-radius: 7px;
	margin-bottom: 15px;
	text-align: center;
}
</style>

</head>

<body>

	<div class="container">

		<h2>Đặt lại mật khẩu</h2>

		<p class="description">Nhập mật khẩu mới cho tài khoản của bạn</p>

		<%
		if (request.getAttribute("error") != null) {
		%>

		<div class="error">
			<%=request.getAttribute("error")%>
		</div>

		<%
		}
		%>

		<form method="post"
			action="${pageContext.request.contextPath}/reset-password">

			<div class="form-group">

				<label>Mật khẩu mới</label> <input type="password" name="password"
					placeholder="Nhập mật khẩu mới" required>

			</div>

			<div class="form-group">

				<label>Nhập lại mật khẩu</label> <input type="password"
					name="confirmPassword" placeholder="Nhập lại mật khẩu" required>

			</div>

			<button type="submit">Đặt lại mật khẩu</button>

		</form>

	</div>

</body>

</html>