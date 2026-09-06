<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html lang="vi">

<head>

<meta charset="UTF-8">

<title>Sửa sản phẩm</title>

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

.form-control {
	width: 100%;
	padding: 11px;
	border: 1px solid #d1d5db;
	border-radius: 7px;
	font-size: 15px;
}

textarea.form-control {
	min-height: 120px;
	resize: vertical;
}

.current-image {
	width: 180px;
	height: 180px;
	object-fit: cover;
	border-radius: 10px;
	border: 1px solid #ddd;
}

.btn {
	display: inline-block;
	padding: 10px 18px;
	border-radius: 7px;
	text-decoration: none;
	border: none;
	cursor: pointer;
}

.btn-primary {
	background: #667eea;
	color: white;
}

.btn-secondary {
	background: #6b7280;
	color: white;
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

		<!-- SIDEBAR -->

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


		<!-- MAIN -->

		<main class="main-area">

			<header class="topbar">

				<div class="topbar-title">Sửa sản phẩm</div>

				<a href="${pageContext.request.contextPath}/profile"
					class="user-profile">

					<div class="avatar">A</div> <span> Administrator </span>

				</a>

			</header>


			<section class="content">

				<div class="page-title">

					<div>

						<h1>Sửa sản phẩm</h1>

						<p>Cập nhật thông tin sản phẩm</p>

					</div>

				</div>


				<div class="form-box">

					<c:if test="${not empty error}">

						<div class="error">${error}</div>

					</c:if>


					<form method="post"
						action="${pageContext.request.contextPath}/admin/product/update"
						enctype="multipart/form-data">


						<input type="hidden" name="productId" value="${product.productId}">


						<div class="form-group">

							<label> Tên sản phẩm </label> <input type="text"
								name="productName" class="form-control"
								value="${product.productName}" required>

						</div>


						<div class="form-group">

							<label> Mô tả </label>

							<textarea name="description" class="form-control">${product.description}</textarea>

						</div>


						<div class="form-group">

							<label> Giá </label> <input type="number" name="price"
								class="form-control" value="${product.price}" step="0.01"
								min="0" required>

						</div>


						<div class="form-group">

							<label> Số lượng </label> <input type="number" name="quantity"
								class="form-control" value="${product.quantity}" min="0"
								required>

						</div>


						<div class="form-group">

							<label> Danh mục </label> <select name="cateId"
								class="form-control" required>

								<c:forEach var="c" items="${listCategory}">

									<option value="${c.cateId}"
										<c:if test="${c.cateId == product.category.cateId}">
										selected
									</c:if>>

										${c.cateName}</option>

								</c:forEach>

							</select>

						</div>


						<c:if test="${not empty product.image}">

							<div class="form-group">

								<label> Ảnh hiện tại </label> <br> <img
									src="${pageContext.request.contextPath}/image?fname=${product.image}"
									class="current-image" alt="${product.productName}">

							</div>

						</c:if>


						<div class="form-group">

							<label> Chọn ảnh mới </label> <input type="file" name="image"
								class="form-control" accept="image/*"> <small>
								Nếu không chọn ảnh mới thì ảnh hiện tại được giữ nguyên. </small>

						</div>


						<button type="submit" class="btn btn-primary">💾 Cập nhật

						</button>


						<a href="${pageContext.request.contextPath}/admin/products"
							class="btn btn-secondary"> Quay lại </a>

					</form>

				</div>

			</section>

		</main>

	</div>

</body>

</html>