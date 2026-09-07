<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="vi">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Thêm danh mục - Shopping MVC</title>

<!-- Bootstrap 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

<style>
.form-card {
	max-width: 800px;
}

.form-group {
	margin-bottom: 20px;
}

.form-hint {
	display: block;
	margin-top: 6px;
	color: #6b7280;
}

.preview-image {
	width: 150px;
	height: 150px;
	object-fit: cover;
	border-radius: 10px;
	border: 1px solid #ddd;
}

.preview-label {
	font-weight: 600;
	margin-bottom: 8px;
}

.required {
	color: red;
}
</style>

</head>

<body>

	<div class="admin-layout">


		<!-- ================= SIDEBAR ================= -->

		<aside class="sidebar">

			<div class="sidebar-logo">

				🛒 <span>Shopping MVC</span>

			</div>

			<div class="sidebar-menu">

				<div class="menu-title">QUẢN LÝ</div>


				<!-- TRANG CHỦ -->

				<a href="${pageContext.request.contextPath}/admin/home"
					class="menu-item"> 📊 <span>Trang chủ</span>

				</a>


				<!-- DANH MỤC -->

				<a href="${pageContext.request.contextPath}/admin/categories"
					class="menu-item active"> 📁 <span>Danh mục</span>

				</a>


				<div class="menu-title">HỆ THỐNG</div>


				<!-- LOGOUT -->

				<a href="${pageContext.request.contextPath}/logout"
					class="menu-item"> 🚪 <span>Đăng xuất</span>

				</a>

			</div>

		</aside>


		<!-- ================= MAIN ================= -->

		<main class="main-area">


			<!-- TOPBAR -->

			<header class="topbar">

				<div class="topbar-title">Thêm danh mục</div>

				<div class="user-info">

					<div class="avatar">A</div>

					<span> Administrator </span>

				</div>

			</header>


			<!-- ================= CONTENT ================= -->

			<section class="content">


				<!-- PAGE TITLE -->

				<div class="page-title">

					<div>

						<h1>Thêm danh mục</h1>

						<p>Tạo một danh mục mới cho hệ thống</p>

					</div>


					<a href="${pageContext.request.contextPath}/admin/categories"
						class="btn btn-secondary"> ← Quay lại </a>

				</div>


				<!-- ================= ERROR ================= -->

				<%
				if (request.getAttribute("error") != null) {
				%>

				<div class="alert alert-danger" role="alert">

					<%=request.getAttribute("error")%>

				</div>

				<%
				}
				%>


				<!-- ================= FORM CARD ================= -->

				<div class="card form-card">


					<!-- HEADER -->

					<div class="card-header">

						<div>

							<h3>Thông tin danh mục</h3>

							<span> Nhập thông tin và chọn icon cho danh mục </span>

						</div>

					</div>


					<!-- BODY -->

					<div class="card-body">


						<!-- ================= FORM ================= -->

						<form method="post"
							action="${pageContext.request.contextPath}/admin/category/insert"
							enctype="multipart/form-data" class="needs-validation" novalidate>


							<!-- ================= NAME ================= -->

							<div class="form-group">

								<label for="cateName"> Tên danh mục <span
									class="required">*</span>
								</label> <input type="text" id="cateName" name="cateName"
									class="form-control" placeholder="Ví dụ: Điện thoại" required>

								<div id="cateName-error" class="invalid-feedback">Tên danh
									mục phải từ 2 đến 100 ký tự.</div>

							</div>


							<!-- ================= IMAGE ================= -->

							<div class="form-group">

								<label for="icon"> Icon danh mục </label> <input type="file"
									id="icon" name="icon" class="form-control"
									accept="image/jpeg,image/png,image/gif"
									onchange="previewImage(event)"> <small
									class="form-hint"> Chọn ảnh từ máy tính. Định dạng hỗ
									trợ: JPG, JPEG, PNG, GIF. </small>


								<!-- FILE VALIDATION -->

								<div id="image-error" class="invalid-feedback">Chỉ được
									chọn file JPG, JPEG hoặc PNG/GIF.</div>


								<!-- PREVIEW -->

								<div id="preview-container"
									style="display: none; margin-top: 15px;">

									<p class="preview-label">Xem trước:</p>

									<img id="preview" class="preview-image" alt="Ảnh xem trước">

								</div>

							</div>


							<!-- ================= BUTTON ================= -->

							<div class="form-actions">

								<button type="submit" class="btn btn-primary">✓ Thêm
									danh mục</button>


								<a href="${pageContext.request.contextPath}/admin/categories"
									class="btn btn-secondary"> Hủy </a>

							</div>


						</form>

					</div>

				</div>

			</section>

		</main>

	</div>


	<!-- ==================================================
     JAVASCRIPT
     ================================================== -->


	<script>


    // =========================
    // PREVIEW IMAGE
    // =========================

    function previewImage(event) {

        const file = event.target.files[0];

        const preview =
            document.getElementById("preview");

        const container =
            document.getElementById("preview-container");

        const input =
            document.getElementById("icon");

        const error =
            document.getElementById("image-error");


        if (!file) {

            preview.src = "";

            container.style.display = "none";

            input.classList.remove("is-invalid");

            return;
        }


        // =========================
        // CHECK FILE TYPE
        // =========================

        const allowedTypes = [
            "image/jpeg",
            "image/png",
            "image/gif"
        ];


        if (!allowedTypes.includes(file.type)) {

            input.classList.add("is-invalid");

            preview.src = "";

            container.style.display = "none";

            return;
        }


        // FILE HỢP LỆ

        input.classList.remove("is-invalid");


        // =========================
        // SHOW PREVIEW
        // =========================

        preview.src =
            URL.createObjectURL(file);

        container.style.display = "block";

    }


    // =========================
    // BOOTSTRAP FORM VALIDATION
    // =========================

    (() => {

        'use strict';


        const forms =
            document.querySelectorAll('.needs-validation');


        Array.from(forms).forEach(form => {


            form.addEventListener('submit', event => {


                const imageInput =
                    document.getElementById("icon");


                // =========================
                // CHECK IMAGE
                // =========================

                if (imageInput.files.length > 0) {

                    const file =
                        imageInput.files[0];


                    const allowedTypes = [
                        "image/jpeg",
                        "image/png",
                        "image/gif"
                    ];


                    if (!allowedTypes.includes(file.type)) {

                        imageInput.classList.add("is-invalid");

                        event.preventDefault();

                        event.stopPropagation();

                    } else {

                        imageInput.classList.remove("is-invalid");

                    }

                }


                // =========================
                // CHECK FORM
                // =========================

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