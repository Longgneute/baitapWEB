<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">

<head>
<meta charset="UTF-8">

<title>Quản lý sản phẩm</title>

<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: Arial, sans-serif;
	background: #f5f7fb;
	color: #1f2937;
}

.container {
	padding: 40px 34px;
}

.page-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.page-header h1 {
	margin: 0;
	font-size: 30px;
}

.page-header p {
	margin-top: 8px;
	color: #6b7280;
}

.btn-add {
	text-decoration: none;
	background: #667eea;
	color: white;
	padding: 14px 22px;
	border-radius: 10px;
	font-weight: bold;
	display: inline-block;
}

.btn-add:hover {
	background: #5568d9;
}

.card {
	background: white;
	border-radius: 16px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
	overflow: hidden;
}

.card-header {
	padding: 25px;
	border-bottom: 1px solid #e5e7eb;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.card-header h2 {
	margin: 0;
	font-size: 22px;
}

.card-header span {
	color: #6b7280;
}

.table-wrapper {
	overflow-x: auto;
	padding: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 1000px;
}

th {
	background: #f8fafc;
	text-align: left;
	padding: 16px;
	color: #475569;
	font-size: 14px;
	border-bottom: 1px solid #e5e7eb;
}

td {
	padding: 16px;
	border-bottom: 1px solid #e5e7eb;
	vertical-align: middle;
}

tr:hover {
	background: #fafafa;
}

.product-image {
	width: 70px;
	height: 70px;
	object-fit: cover;
	border-radius: 10px;
	border: 1px solid #e5e7eb;
}

.no-image {
	width: 70px;
	height: 70px;
	border-radius: 10px;
	background: #f1f5f9;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #94a3b8;
	font-size: 12px;
}

.product-name {
	font-weight: bold;
	color: #111827;
}

.description {
	max-width: 250px;
	color: #6b7280;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.price {
	font-weight: bold;
	color: #667eea;
}

.quantity {
	font-weight: bold;
}

.category {
	display: inline-block;
	padding: 6px 10px;
	background: #eef2ff;
	color: #4f46e5;
	border-radius: 8px;
	font-size: 13px;
}

.actions {
	display: flex;
	gap: 8px;
}

.btn-edit, .btn-delete {
	border: none;
	text-decoration: none;
	color: white;
	padding: 9px 14px;
	border-radius: 8px;
	font-size: 14px;
	cursor: pointer;
}

.btn-edit {
	background: #f59e0b;
}

.btn-edit:hover {
	background: #d97706;
}

.btn-delete {
	background: #ef4444;
}

.btn-delete:hover {
	background: #dc2626;
}

.empty {
	text-align: center;
	padding: 60px 20px;
	color: #6b7280;
}

.empty-icon {
	font-size: 50px;
	margin-bottom: 15px;
}

.alert {
	padding: 14px 18px;
	margin-bottom: 20px;
	border-radius: 10px;
	background: #dcfce7;
	color: #166534;
}

@media ( max-width : 900px) {
	.container {
		padding: 20px;
	}
	.page-header {
		flex-direction: column;
		align-items: flex-start;
		gap: 20px;
	}
}
</style>
</head>

<body>

	<div class="container">

		<!-- HEADER -->
		<div class="page-header">
			<div>
				<h1>Quản lý sản phẩm</h1>
				<p>Quản lý danh sách sản phẩm trong cửa hàng</p>
			</div>

			<div class="header-actions">

				<a href="${pageContext.request.contextPath}/admin/categories" class="btn-back">
					← Quay lại menu </a> <a
					href="${pageContext.request.contextPath}/admin/product/add"
					class="btn-add"> + Thêm sản phẩm </a>

			</div>
		</div>


		<!-- ALERT -->
		<c:if test="${not empty alert}">

			<div class="alert">${alert}</div>

		</c:if>


		<!-- PRODUCT TABLE -->
		<div class="card">

			<div class="card-header">

				<div>
					<h2>Danh sách sản phẩm</h2>

					<span> Quản lý thông tin sản phẩm </span>
				</div>

				<span>Tổng số: <strong>${listProduct.size()}</strong></span>

			</div>


			<div class="table-wrapper">

				<c:choose>

					<c:when test="${not empty listProduct}">

						<table>

							<thead>

								<tr>

									<th>ID</th>

									<th>Hình ảnh</th>

									<th>Tên sản phẩm</th>

									<th>Mô tả</th>

									<th>Giá</th>

									<th>Số lượng</th>

									<th>Danh mục</th>

									<th>Thao tác</th>

								</tr>

							</thead>


							<tbody>

								<c:forEach var="p" items="${listProduct}">

									<tr>

										<!-- ID -->
										<td>${p.productId}</td>


										<!-- IMAGE -->
										<td><c:choose>

												<c:when test="${not empty p.image}">

													<img
														src="${pageContext.request.contextPath}/images/${p.image}"
														class="product-image" alt="${p.productName}">

												</c:when>

												<c:otherwise>

													<div class="no-image">No image</div>

												</c:otherwise>

											</c:choose></td>


										<!-- NAME -->
										<td>

											<div class="product-name">${p.productName}</div>

										</td>


										<!-- DESCRIPTION -->
										<td>

											<div class="description" title="${p.description}">

												${p.description}</div>

										</td>


										<!-- PRICE -->
										<td><span class="price"> ${p.price} VNĐ </span></td>


										<!-- QUANTITY -->
										<td><span class="quantity"> ${p.quantity} </span></td>


										<!-- CATEGORY -->
										<td><c:choose>

												<c:when test="${not empty p.category}">

													<span class="category"> ${p.category.cateName} </span>

												</c:when>

												<c:otherwise>

													<span class="category"> Chưa có danh mục </span>

												</c:otherwise>

											</c:choose></td>


										<!-- ACTION -->
										<td>

											<div class="actions">

												<a
													href="${pageContext.request.contextPath}/admin/product/edit?id=${p.productId}"
													class="btn-edit"> ✏ Sửa </a> <a
													href="${pageContext.request.contextPath}/admin/product/delete?id=${p.productId}"
													class="btn-delete"
													onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này không?');">

													🗑 Xóa </a>

											</div>

										</td>

									</tr>

								</c:forEach>

							</tbody>

						</table>

					</c:when>


					<c:otherwise>

						<div class="empty">

							<div class="empty-icon">🛍️</div>

							<h3>Chưa có sản phẩm nào</h3>

							<p>Hãy thêm sản phẩm đầu tiên của cửa hàng.</p>

							<br>
		
						</div>

					</c:otherwise>

				</c:choose>

			</div>

		</div>

	</div>

</body>

</html>