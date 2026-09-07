<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="vn.laptrinhJPA.entity.Category"%>

<%
Category category = (Category) request.getAttribute("category");
%>

<!DOCTYPE html>
<html lang="vi">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Chỉnh sửa danh mục</title>

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

.form-group label {
	display: block;
	font-weight: 600;
	margin-bottom: 8px;
}

.preview-image {
	width: 150px;
	height: 150px;
	object-fit: cover;
	border-radius: 10px;
	border: 1px solid #ddd;
	margin-top: 10px;
}

.no-image {
	width: 150px;
	height: 150px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #f3f4f6;
	border-radius: 10px;
	color: #6b7280;
	text-align: center;
}

.form-hint {
	display: block;
	margin-top: 6px;
	color: #6b7280;
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


				<a href="${pageContext.request.contextPath}/admin/home"
					class="menu-item"> 📊 <span>Trang chủ</span>

				</a> <a href="${pageContext.request.contextPath}/admin/categories"
					class="menu-item active"> 📁 <span>Danh mục</span>

				</a> <a href="${pageContext.request.contextPath}/admin/videos"
					class="menu-item"> 🎬 <span>Video</span>

				</a>


				<div class="menu-title">HỆ THỐNG</div>


				<a href="${pageContext.request.contextPath}/logout"
					class="menu-item"> 🚪 <span>Đăng xuất</span>

				</a>

			</div>

		</aside>


		<!-- ================= MAIN ================= -->

		<main class="main-area">


			<!-- TOPBAR -->

			<header class="topbar">

				<div class="topbar-title">Chỉnh sửa danh mục</div>

			</header>


			<!-- ================= CONTENT ================= -->

			<section class="content">


				<!-- PAGE TITLE -->

				<div class="page-title">

					<div>

						<h1>Chỉnh sửa danh mục</h1>

						<p>Cập nhật thông tin danh mục</p>

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

							<span> Cập nhật thông tin bên dưới </span>

						</div>

					</div>


					<!-- BODY -->

					<div class="card-body">


						<!-- ================= FORM ================= -->

						<form method="post"
							action="${pageContext.request.contextPath}/admin/category/update"
							enctype="multipart/form-data" class="needs-validation" novalidate>


							<!-- ================= ID ================= -->

							<div class="form-group">

								<label> ID </label> <input type="text" class="form-control"
									value="<%=category.getCateId()%>" disabled> <input
									type="hidden" name="cateId" value="<%=category.getCateId()%>">

							</div>


							<!-- ================= NAME ================= -->

							<div class="form-group">

								<label for="cateName"> Tên danh mục <span
									class="required">*</span>

								</label> <input type="text" id="cateName" name="cateName"
									class="form-control" value="<%=category.getCateName()%>"
									required>

								<div class="invalid-feedback">Tên danh mục không được để
									trống.</div>

							</div>

							<!-- ================= OLD IMAGE ================= -->

							<div class="form-group">

								<label> Icon hiện tại </label>


								<div>

									<%
									if (category.getIcons() != null && !category.getIcons().isEmpty()) {
									%>

									<img
										src="${pageContext.request.contextPath}/image?fname=<%= category.getIcons() %>"
										class="preview-image" alt="Icon hiện tại">

									<%
									} else {
									%>

									<div class="no-image">📁 Chưa có icon</div>

									<%
									}
									%>

								</div>

							</div>


							<!-- ================= NEW IMAGE ================= -->

							<div class="form-group">

								<label for="icon"> Chọn icon mới </label> <input type="file"
									id="icon" name="icon" class="form-control"
									accept="image/jpeg,image/png,image/gif"
									onchange="previewImage(event)">


								<div class="form-text">Nếu không chọn ảnh mới, icon hiện
									tại sẽ được giữ nguyên.</div>


								<!-- FILE ERROR -->

								<div id="image-error" class="invalid-feedback">Chỉ được
									chọn file JPG, JPEG, PNG hoặc GIF.</div>


								<!-- NEW IMAGE PREVIEW -->

								<img id="preview" class="preview-image" style="display: none;"
									alt="Icon mới">

							</div>


							<!-- ================= BUTTON ================= -->

							<div class="form-actions mt-4">

								<button type="submit" class="btn btn-primary">💾 Lưu
									thay đổi</button>


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

        const file =
            event.target.files[0];

        const preview =
            document.getElementById("preview");

        const input =
            document.getElementById("icon");


        if (!file) {

            preview.src = "";

            preview.style.display = "none";

            input.classList.remove("is-invalid");

            return;

        }


        // =========================
        // ALLOWED FILE TYPES
        // =========================

        const allowedTypes = [
            "image/jpeg",
            "image/png",
            "image/gif"
        ];


        // =========================
        // CHECK FILE TYPE
        // =========================

        if (!allowedTypes.includes(file.type)) {

            input.classList.add("is-invalid");

            preview.src = "";

            preview.style.display = "none";

            return;

        }


        // =========================
        // FILE VALID
        // =========================

        input.classList.remove("is-invalid");


        // =========================
        // SHOW PREVIEW
        // =========================

        preview.src =
            URL.createObjectURL(file);

        preview.style.display = "block";

    }


    // =========================
    // BOOTSTRAP VALIDATION
    // =========================

    (() => {

        'use strict';


        const forms =
            document.querySelectorAll('.needs-validation');


        Array.from(forms).forEach(form => {


            form.addEventListener('submit', event => {


                // =========================
                // CHECK FORM
                // =========================

                if (!form.checkValidity()) {

                    event.preventDefault();

                    event.stopPropagation();

                }


                // =========================
                // CHECK IMAGE
                // =========================

                const imageInput =
                    document.getElementById("icon");


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


                form.classList.add('was-validated');


            }, false);

        });


    })();

</script>


</body>

</html>