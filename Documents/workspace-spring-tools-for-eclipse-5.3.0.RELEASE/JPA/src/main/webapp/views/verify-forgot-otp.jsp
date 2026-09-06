<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="vi">

<head>

<meta charset="UTF-8">

<title>Xác nhận OTP - Shopping MVC</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

	<div class="auth-page">

		<div class="auth-box">

			<!-- LOGO -->
			<div class="auth-logo">

				<div class="logo-icon">🔐</div>

				<h2>Xác nhận OTP</h2>

				<p>Nhập mã OTP để khôi phục mật khẩu</p>

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


			<!-- MÔ TẢ -->
			<div
				style="text-align: center; color: #777; font-size: 14px; margin-bottom: 20px;">

				Mã OTP đã được gửi đến email của bạn. <br> Mã có hiệu lực trong
				5 phút.

			</div>


			<!-- FORM -->
			<form method="post"
				action="${pageContext.request.contextPath}/verify-forgot-otp">

				<div class="form-group">

					<label for="otp"> Nhập mã OTP </label> <input type="text" id="otp"
						name="otp" class="form-control" placeholder="Nhập mã OTP 6 số"
						maxlength="6" pattern="[0-9]{6}" inputmode="numeric"
						autocomplete="one-time-code" required>

				</div>


				<button type="submit" class="btn btn-primary btn-block">

					Xác nhận OTP</button>

			</form>


			<!-- QUAY LẠI -->
			<div class="auth-footer">

				<a href="${pageContext.request.contextPath}/forgot-password"> ←
					Nhập lại email </a>

			</div>


			<div class="auth-footer">

				<a href="${pageContext.request.contextPath}/login"> Quay lại
					đăng nhập </a>

			</div>

		</div>

	</div>

</body>

</html>