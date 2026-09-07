<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html lang="vi">

<head>

<meta charset="UTF-8">

<title>Đăng ký</title>

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

			<h2>Đăng ký tài khoản</h2>


			<!-- =========================
                 THÔNG BÁO LỖI
                 ========================= -->

			<%
			if (request.getAttribute("error") != null) {
			%>

			<div class="alert alert-danger" role="alert">

				<%=request.getAttribute("error")%>

			</div>

			<%
			}
			%>


			<!-- =========================
                 FORM REGISTER
                 ========================= -->

			<form method="post"
				action="${pageContext.request.contextPath}/register"
				class="needs-validation" novalidate>


				<!-- EMAIL -->

				<div class="form-group mb-3">

					<label for="email"> Email </label> <input type="email" id="email"
						name="email" class="form-control" maxlength="100"
						placeholder="Nhập email" required>

					<div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>

				</div>


				<!-- USERNAME -->

				<div class="form-group mb-3">

					<label for="username"> Tài khoản </label> <input type="text"
						id="username" name="username" class="form-control" maxlength="50"
						pattern=".{3,50}" placeholder="Nhập tài khoản" required>

					<div class="invalid-feedback">Tài khoản phải có từ 3 đến 50
						ký tự.</div>

				</div>


				<!-- FULLNAME -->

				<div class="form-group mb-3">

					<label for="fullname"> Họ tên </label> <input type="text"
						id="fullname" name="fullname" class="form-control" maxlength="100"
						pattern=".{2,100}" placeholder="Nhập họ tên" required>

					<div class="invalid-feedback">Họ tên phải từ 2 đến 100 ký tự.
					</div>

				</div>


				<!-- PHONE -->

				<div class="form-group mb-3">

					<label for="phone"> Số điện thoại </label> <input type="tel"
						id="phone" name="phone" class="form-control"
						pattern="^(0|\+84)(3|5|7|8|9)[0-9]{8}$"
						placeholder="Nhập số điện thoại" required>

					<div class="invalid-feedback">Số điện thoại không hợp lệ. Ví
						dụ: 0912345678</div>

				</div>


				<!-- PASSWORD -->

				<div class="form-group mb-3">

					<label for="password"> Mật khẩu </label> <input type="password"
						id="password" name="password" class="form-control" maxlength="50"
						pattern=".{6,50}" placeholder="Nhập mật khẩu" required>

					<div class="invalid-feedback">Mật khẩu phải có từ 6 đến 50 ký
						tự.</div>

				</div>


				<!-- BUTTON -->

				<button type="submit" class="btn btn-primary btn-block w-100">

					Đăng ký</button>

			</form>


			<!-- =========================
                 LOGIN
                 ========================= -->

			<div class="auth-footer mt-3">

				Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">
					Đăng nhập </a>

			</div>

		</div>

	</div>


	<!-- =========================
         BOOTSTRAP VALIDATION
         ========================= -->

	<script>

        (() => {

            'use strict';

            const forms =
                document.querySelectorAll('.needs-validation');

            Array.from(forms).forEach(form => {

                form.addEventListener('submit', event => {

                    if (!form.checkValidity()) {

                        event.preventDefault();
                        event.stopPropagation();

                    }

                    form.classList.add('was-validated');

                }, false);

            });

        })();

    </script>

</body>

</html>