<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Thông tin cá nhân</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

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

.btn-block {
	width: 100%;
}
</style>

</head>

<body>

	<div class="auth-page">

		<div class="auth-box profile-box">

			<div class="auth-logo">
				<div class="logo-icon">👤</div>

				<h2>Thông tin cá nhân</h2>

				<p>Quản lý thông tin tài khoản của bạn</p>
			</div>


			<c:if test="${not empty sessionScope.success}">
				<div class="success-message">${sessionScope.success}</div>

				<c:remove var="success" scope="session" />
			</c:if>


			<c:if test="${not empty message}">
				<div class="success-message">${message}</div>
			</c:if>


			<c:if test="${not empty error}">
				<div class="error-message">${error}</div>
			</c:if>


			<form method="post"
				action="${pageContext.request.contextPath}/profile"
				enctype="multipart/form-data" class="needs-validation" novalidate>


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
						</label> <input type="file" id="avatar" name="avatar" class="form-control"
							accept=".jpg,.jpeg,.png,.gif,.webp">

						<div class="avatar-note">JPG, JPEG, PNG, GIF, WEBP - tối đa
							5MB</div>

						<div class="invalid-feedback">Chỉ được chọn JPG, JPEG, PNG,
							GIF hoặc WEBP và dung lượng không quá 5MB.</div>

					</div>

				</div>


				<div class="form-group">

					<label for="username"> Username </label> <input type="text"
						id="username" name="username" class="form-control"
						value="${user.username}" readonly>

				</div>


				<div class="form-group">

					<label for="email"> Email </label> <input type="email" id="email"
						name="email" class="form-control" value="${user.email}" readonly>

				</div>


				<div class="form-group">

					<label for="fullname"> Họ và tên <span class="required">*</span>
					</label> <input type="text" id="fullname" name="fullname"
						class="form-control" value="${user.fullname}"
						placeholder="Nhập họ và tên" minlength="2" maxlength="100"
						required>

					<div class="invalid-feedback">Họ và tên phải từ 2 đến 100 ký
						tự.</div>

				</div>


				<div class="form-group">

					<label for="phone"> Số điện thoại <span class="required">*</span>
					</label> <input type="tel" id="phone" name="phone" class="form-control"
						value="${user.phone}" placeholder="Nhập số điện thoại"
						pattern="^(0|\+84)(3|5|7|8|9)[0-9]{8}$" required>

					<div class="invalid-feedback">Số điện thoại không hợp lệ. Ví
						dụ: 0912345678 hoặc +84912345678.</div>

				</div>


				<button type="submit" class="btn btn-primary btn-block">

					Cập nhật thông tin</button>

			</form>


			<div class="auth-footer">

				<a href="${pageContext.request.contextPath}/home"> ← Quay lại
					trang chủ </a>

			</div>

		</div>

	</div>


	<script>

document.addEventListener("DOMContentLoaded", function () {

    const form = document.querySelector(".needs-validation");

    const avatarInput = document.getElementById("avatar");

    const fullnameInput = document.getElementById("fullname");

    const phoneInput = document.getElementById("phone");

    const avatarPreview = document.getElementById("avatarPreview");

    const avatarDefault = document.getElementById("avatarDefault");


    /*
     * VALIDATION AVATAR
     */

    avatarInput.addEventListener("change", function () {

        const file = this.files[0];

        if (!file) {

            this.classList.remove("is-invalid");

            return;
        }


        if (file.size > 5 * 1024 * 1024) {

            this.classList.add("is-invalid");

            alert("Ảnh không được vượt quá 5MB.");

            this.value = "";

            return;
        }


        const allowedTypes = [
            "image/jpeg",
            "image/png",
            "image/gif",
            "image/webp"
        ];


        if (!allowedTypes.includes(file.type)) {

            this.classList.add("is-invalid");

            alert(
                "Chỉ được chọn JPG, JPEG, PNG, GIF hoặc WEBP."
            );

            this.value = "";

            return;
        }


        this.classList.remove("is-invalid");


        avatarPreview.src = URL.createObjectURL(file);

        avatarPreview.style.display = "block";


        if (avatarDefault) {

            avatarDefault.style.display = "none";
        }

    });


    /*
     * VALIDATION HỌ TÊN
     */

    fullnameInput.addEventListener("input", function () {

        const value = this.value.trim();


        if (value.length < 2 || value.length > 100) {

            this.setCustomValidity(
                "Họ và tên phải từ 2 đến 100 ký tự."
            );

        } else {

            this.setCustomValidity("");

        }

    });


    /*
     * VALIDATION SỐ ĐIỆN THOẠI
     */

    phoneInput.addEventListener("input", function () {

        const value = this.value.trim();

        const phoneRegex =
            /^(0|\+84)(3|5|7|8|9)[0-9]{8}$/;


        if (!phoneRegex.test(value)) {

            this.setCustomValidity(
                "Số điện thoại không hợp lệ."
            );

        } else {

            this.setCustomValidity("");

        }

    });


    /*
     * SUBMIT FORM
     */

    form.addEventListener("submit", function (event) {

        const file = avatarInput.files[0];


        /*
         * KIỂM TRA AVATAR
         */

        if (file) {

            const allowedTypes = [
                "image/jpeg",
                "image/png",
                "image/gif",
                "image/webp"
            ];


            if (file.size > 5 * 1024 * 1024) {

                event.preventDefault();

                avatarInput.classList.add("is-invalid");

            }


            if (!allowedTypes.includes(file.type)) {

                event.preventDefault();

                avatarInput.classList.add("is-invalid");

            }

        }


        /*
         * KIỂM TRA FORM HTML5
         */

        if (!form.checkValidity()) {

            event.preventDefault();

            event.stopPropagation();

        }


        form.classList.add("was-validated");

    });

});

</script>

</body>

</html>