<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">

<head>

<meta charset="UTF-8">

<title>Thông tin cá nhân</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

<style>
.profile-box {
	width: 520px;
	max-width: 95%;
}

.profile-avatar-area {
	text-align: center;
	margin-bottom: 25px;
}

.profile-avatar {
	width: 150px;
	height: 150px;
	border-radius: 50%;
	object-fit: cover;
	border: 4px solid #eee;
	display: block;
	margin: 0 auto 15px;
}

.avatar-default {
	width: 150px;
	height: 150px;
	border-radius: 50%;
	background: #f1f1f1;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 60px;
	margin: 0 auto 15px;
}

.avatar-upload {
	margin-top: 10px;
}

.avatar-upload input[type="file"] {
	width: 100%;
	margin-top: 8px;
}

.avatar-note {
	font-size: 12px;
	color: #777;
	margin-top: 8px;
}

.profile-box .form-group {
	margin-bottom: 18px;
}

.profile-box input[readonly] {
	background-color: #f3f3f3;
	cursor: not-allowed;
}

.success-message {
	background: #d4edda;
	color: #155724;
	border: 1px solid #c3e6cb;
	padding: 12px 15px;
	border-radius: 6px;
	margin-bottom: 20px;
	text-align: center;
}

.error-message {
	background: #f8d7da;
	color: #721c24;
	border: 1px solid #f5c6cb;
	padding: 12px 15px;
	border-radius: 6px;
	margin-bottom: 20px;
	text-align: center;
}
</style>

</head>

<body>

	<div class="auth-page">

		<div class="auth-box profile-box">

			<!-- ================= HEADER ================= -->

			<div class="auth-logo">

				<div class="logo-icon">👤</div>

				<h2>Thông tin cá nhân</h2>

				<p>Quản lý thông tin tài khoản của bạn</p>

			</div>


			<!-- ================= THÔNG BÁO THÀNH CÔNG ================= -->

			<c:if test="${not empty sessionScope.success}">

				<div class="success-message">${sessionScope.success}</div>

				<c:remove var="success" scope="session" />

			</c:if>


			<!-- ================= THÔNG BÁO THÀNH CÔNG REQUEST ================= -->

			<c:if test="${not empty message}">

				<div class="success-message">${message}</div>

			</c:if>


			<!-- ================= THÔNG BÁO LỖI ================= -->

			<c:if test="${not empty error}">

				<div class="error-message">${error}</div>

			</c:if>


			<!-- ================= PROFILE ================= -->

			<form method="post"
				action="${pageContext.request.contextPath}/profile"
				enctype="multipart/form-data">


				<!-- ================= AVATAR ================= -->

				<div class="profile-avatar-area">

					<c:choose>

						<c:when test="${not empty user.avatar}">

							<img id="avatarPreview" class="profile-avatar"
								src="${pageContext.request.contextPath}/images/${user.avatar}"
								alt="Ảnh đại diện">

						</c:when>

						<c:otherwise>

							<div id="avatarDefault" class="avatar-default">👤</div>

							<img id="avatarPreview" class="profile-avatar" src=""
								alt="Ảnh đại diện" style="display: none;">

						</c:otherwise>

					</c:choose>


					<div class="avatar-upload">

						<label for="avatar"> <strong>Chọn ảnh đại diện</strong>
						</label> <input type="file" id="avatar" name="avatar"
							accept=".jpg,.jpeg,.png,.gif,.webp">

						<div class="avatar-note">JPG, JPEG, PNG, GIF, WEBP - tối đa
							5MB</div>

					</div>

				</div>


				<!-- ================= USERNAME ================= -->

				<div class="form-group">

					<label for="username"> Username </label> <input type="text"
						id="username" name="username" class="form-control"
						value="${user.username}" readonly>

				</div>


				<!-- ================= EMAIL ================= -->

				<div class="form-group">

					<label for="email"> Email </label> <input type="email" id="email"
						name="email" class="form-control" value="${user.email}" readonly>

				</div>


				<!-- ================= HỌ TÊN ================= -->

				<div class="form-group">

					<label for="fullname"> Họ và tên </label> <input type="text"
						id="fullname" name="fullname" class="form-control"
						value="${user.fullname}" placeholder="Nhập họ và tên" required>

				</div>


				<!-- ================= SỐ ĐIỆN THOẠI ================= -->

				<div class="form-group">

					<label for="phone"> Số điện thoại </label> <input type="text"
						id="phone" name="phone" class="form-control" value="${user.phone}"
						placeholder="Nhập số điện thoại">

				</div>


				<!-- ================= BUTTON ================= -->

				<button type="submit" class="btn btn-primary btn-block">

					Cập nhật thông tin</button>

			</form>


			<!-- ================= FOOTER ================= -->

			<div class="auth-footer">

				<a href="${pageContext.request.contextPath}/home"> ← Quay lại
					trang chủ </a>

			</div>

		</div>

	</div>


	<!-- ================= PREVIEW ẢNH ================= -->

	<script>
		document.getElementById("avatar").addEventListener(
				"change",
				function() {

					const file = this.files[0];

					if (!file) {
						return;
					}

					// Kiểm tra dung lượng
					if (file.size > 5 * 1024 * 1024) {

						alert("Ảnh không được vượt quá 5MB.");

						this.value = "";

						return;
					}

					// Kiểm tra loại file
					const allowedTypes = [ "image/jpeg", "image/png",
							"image/gif", "image/webp" ];

					if (!allowedTypes.includes(file.type)) {

						alert("Chỉ được chọn JPG, JPEG, PNG, GIF hoặc WEBP.");

						this.value = "";

						return;
					}

					// Preview
					const preview = document.getElementById("avatarPreview");

					const defaultAvatar = document
							.getElementById("avatarDefault");

					preview.src = URL.createObjectURL(file);

					preview.style.display = "block";

					if (defaultAvatar) {
						defaultAvatar.style.display = "none";
					}

				});
	</script>

</body>

</html>