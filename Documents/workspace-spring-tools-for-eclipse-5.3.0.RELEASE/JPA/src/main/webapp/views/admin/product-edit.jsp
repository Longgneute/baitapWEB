<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Sửa sản phẩm</title>

<!-- Bootstrap 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

<style>
.form-box {
	max-width: 800px;
	background: white;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, .08);
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	font-weight: 600;
	margin-bottom: 8px;
}

.current-image {
	width: 180px;
	height: 180px;
	object-fit: cover;
	border-radius: 10px;
	border: 1px solid #ddd;
}

.required {
	color: red;
}

.error {
	background: #fee2e2;
	color: #b91c1c;
	padding: 12px;
	border-radius: 7px;
	margin-bottom: 20px;
}
</style>

</head>

<body>

	<div class="admin-layout">

		<!-- =========================
         SIDEBAR
         ========================= -->

		<aside class="sidebar">

			<div class="sidebar-logo">
				🛒 <span>Shopping MVC</span>
			</div>

			<div class="sidebar-menu">

				<div class="menu-title">QUẢN LÝ</div>

				<a href="${pageContext.request.contextPath}/admin/home"
					class="menu-item"> 📊 <span>Trang chủ</span>

				</a> <a href="${pageContext.request.contextPath}/admin/categories"
					class="menu-item"> 📁 <span>Danh mục</span>

				</a> <a href="${pageContext.request.contextPath}/admin/products"
					class="menu-item active"> 📦 <span>Products</span>

				</a>


				<div class="menu-title">HỆ THỐNG</div>

				<a href="${pageContext.request.contextPath}/logout"
					class="menu-item"> 🚪 <span>Đăng xuất</span>

				</a>

			</div>

		</aside>


		<!-- =========================
         MAIN
         ========================= -->

		<main class="main-area">

			<header class="topbar">

				<div class="topbar-title">Sửa sản phẩm</div>

				<a href="${pageContext.request.contextPath}/profile"
					class="user-profile">

					<div class="avatar">A</div> <span> Administrator </span>

				</a>

			</header>


			<section class="content">

				<!-- PAGE TITLE -->

				<div class="page-title">

					<div>

						<h1>Sửa sản phẩm</h1>

						<p>Cập nhật thông tin sản phẩm</p>

					</div>

				</div>


				<!-- =========================
                 FORM BOX
                 ========================= -->

				<div class="form-box">

					<!-- ERROR FROM CONTROLLER -->

					<c:if test="${not empty error}">

						<div class="alert alert-danger" role="alert">${error}</div>

					</c:if>


					<!-- =========================
                     UPDATE FORM
                     ========================= -->

					<form method="post"
						action="${pageContext.request.contextPath}/admin/product/update"
						enctype="multipart/form-data" class="needs-validation" novalidate>


						<!-- PRODUCT ID -->

						<input type="hidden" name="productId" value="${product.productId}">


						<!-- =========================
                         TÊN SẢN PHẨM
                         ========================= -->

						<div class="form-group">

							<label for="productName"> Tên sản phẩm <span
								class="required">*</span>

							</label> <input type="text" id="productName" name="productName"
								class="form-control" value="${product.productName}"
								maxlength="100" pattern=".{2,100}" required>

							<div class="invalid-feedback">Tên sản phẩm phải từ 2 đến
								100 ký tự.</div>

						</div>


						<!-- =========================
                         MÔ TẢ
                         ========================= -->

						<div class="form-group">

							<label for="description"> Mô tả </label>

							<textarea id="description" name="description"
								class="form-control" maxlength="1000" rows="5">${product.description}</textarea>

							<div class="invalid-feedback">Mô tả không được vượt quá
								1000 ký tự.</div>

						</div>


						<!-- =========================
                         GIÁ
                         ========================= -->

						<div class="form-group">

							<label for="price"> Giá <span class="required">*</span>

							</label> <input type="number" id="price" name="price"
								class="form-control" value="${product.price}" step="0.01"
								min="0" required>

							<div class="invalid-feedback">Giá phải lớn hơn hoặc bằng 0.

							</div>

						</div>


						<!-- =========================
                         SỐ LƯỢNG
                         ========================= -->

						<div class="form-group">

							<label for="quantity"> Số lượng <span class="required">*</span>

							</label> <input type="number" id="quantity" name="quantity"
								class="form-control" value="${product.quantity}" min="0"
								step="1" required>

							<div class="invalid-feedback">Số lượng phải là số nguyên
								lớn hơn hoặc bằng 0.</div>

						</div>


						<!-- =========================
                         DANH MỤC
                         ========================= -->

						<div class="form-group">

							<label for="cateId"> Danh mục <span class="required">*</span>

							</label> <select id="cateId" name="cateId" class="form-select" required>

								<option value="">-- Chọn danh mục --</option>

								<c:forEach var="c" items="${listCategory}">

									<option value="${c.cateId}"
										<c:if test="${c.cateId == product.category.cateId}">
                                        selected
                                    </c:if>>

										${c.cateName}</option>

								</c:forEach>

							</select>

							<div class="invalid-feedback">Vui lòng chọn danh mục.</div>

						</div>


						<!-- =========================
                         ẢNH HIỆN TẠI
                         ========================= -->

						<c:if test="${not empty product.image}">

							<div class="form-group">

								<label> Ảnh hiện tại </label> <br> <img
									src="${pageContext.request.contextPath}/image?fname=${product.image}"
									class="current-image" alt="${product.productName}">

							</div>

						</c:if>


						<!-- =========================
                         CHỌN ẢNH MỚI
                         ========================= -->

						<div class="form-group">

							<label for="image"> Chọn ảnh mới </label> <input type="file"
								id="image" name="image" class="form-control" accept="image/*">

							<div class="form-text">Nếu không chọn ảnh mới thì ảnh hiện
								tại được giữ nguyên.</div>

							<div class="invalid-feedback">File được chọn phải là hình
								ảnh.</div>

						</div>


						<!-- =========================
                         BUTTON
                         ========================= -->

						<div class="mt-4">

							<button type="submit" class="btn btn-primary">💾 Cập
								nhật</button>


							<a href="${pageContext.request.contextPath}/admin/products"
								class="btn btn-secondary"> Quay lại </a>

						</div>

					</form>

				</div>

			</section>

		</main>

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