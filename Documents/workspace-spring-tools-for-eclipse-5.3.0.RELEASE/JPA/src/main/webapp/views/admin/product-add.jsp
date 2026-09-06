<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Thêm sản phẩm</title>

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
	max-width: 900px;
	margin: 40px auto;
	padding: 0 20px;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px;
}

.header h1 {
	margin: 0;
	font-size: 30px;
	color: #111827;
}

.back {
	text-decoration: none;
	color: #667eea;
	font-weight: 600;
}

.card {
	background: white;
	border-radius: 15px;
	padding: 30px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
}

.form-group {
	margin-bottom: 20px;
}

label {
	display: block;
	margin-bottom: 8px;
	font-weight: 600;
	color: #374151;
}

input, textarea, select {
	width: 100%;
	padding: 11px 13px;
	border: 1px solid #d1d5db;
	border-radius: 8px;
	font-size: 15px;
	font-family: Arial, sans-serif;
}

input:focus, textarea:focus, select:focus {
	outline: none;
	border-color: #667eea;
	box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.12);
}

textarea {
	min-height: 130px;
	resize: vertical;
}

.row {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.image-box {
	border: 2px dashed #d1d5db;
	border-radius: 10px;
	padding: 20px;
	text-align: center;
	background: #fafafa;
}

.image-box input {
	border: none;
	padding: 5px;
	background: transparent;
}

.error {
	margin-bottom: 20px;
	padding: 12px 15px;
	background: #fee2e2;
	color: #b91c1c;
	border-radius: 8px;
}

.actions {
	display: flex;
	gap: 12px;
	margin-top: 25px;
}

.btn {
	display: inline-block;
	padding: 11px 22px;
	border-radius: 8px;
	text-decoration: none;
	border: none;
	cursor: pointer;
	font-size: 15px;
	font-weight: 600;
}

.btn-primary {
	background: #667eea;
	color: white;
}

.btn-primary:hover {
	background: #5568d9;
}

.btn-secondary {
	background: #e5e7eb;
	color: #374151;
}

.btn-secondary:hover {
	background: #d1d5db;
}

.required {
	color: red;
}

@media ( max-width : 700px) {
	.row {
		grid-template-columns: 1fr;
	}
	.container {
		margin: 20px auto;
	}
	.card {
		padding: 20px;
	}
	.header {
		align-items: flex-start;
		gap: 15px;
		flex-direction: column;
	}
}
</style>
</head>

<body>

	<div class="container">

		<div class="header">
			<h1>Thêm sản phẩm</h1>

			<a href="${pageContext.request.contextPath}/admin/products"
				class="back"> ← Quay lại danh sách </a>
		</div>

		<div class="card">

			<!-- Hiển thị lỗi nếu thêm sản phẩm thất bại -->
			<c:if test="${not empty error}">
				<div class="error">${error}</div>
			</c:if>

			<!--
            QUAN TRỌNG:
            Controller nhận POST tại /admin/product/insert
            và upload ảnh nên phải có enctype multipart/form-data
        -->
			<form
				action="${pageContext.request.contextPath}/admin/product/insert"
				method="post" enctype="multipart/form-data">

				<!-- Tên sản phẩm -->
				<div class="form-group">
					<label for="productName"> Tên sản phẩm <span
						class="required">*</span>
					</label> <input type="text" id="productName" name="productName"
						placeholder="Nhập tên sản phẩm" required>
				</div>

				<!-- Mô tả -->
				<div class="form-group">
					<label for="description"> Mô tả </label>

					<textarea id="description" name="description"
						placeholder="Nhập mô tả sản phẩm"></textarea>
				</div>

				<!-- Giá + Số lượng -->
				<div class="row">

					<div class="form-group">
						<label for="price"> Giá <span class="required">*</span>
						</label> <input type="number" id="price" name="price" step="0.01" min="0"
							placeholder="Nhập giá" required>
					</div>

					<div class="form-group">
						<label for="quantity"> Số lượng <span class="required">*</span>
						</label> <input type="number" id="quantity" name="quantity" min="0"
							placeholder="Nhập số lượng" required>
					</div>

				</div>

				<!-- Category -->
				<div class="form-group">
					<label for="cateId"> Danh mục <span class="required">*</span>
					</label> <select id="cateId" name="cateId" required>

						<option value="">-- Chọn danh mục --</option>

						<c:forEach var="category" items="${listCategory}">

							<option value="${category.cateId}">${category.cateName}
							</option>

						</c:forEach>

					</select>
				</div>

				<!-- Hình ảnh -->
				<div class="form-group">

					<label for="image"> Hình ảnh </label>

					<div class="image-box">

						<input type="file" id="image" name="image" accept="image/*">

						<p>Chọn hình ảnh sản phẩm</p>

					</div>

				</div>

				<!-- Buttons -->
				<div class="actions">

					<button type="submit" class="btn btn-primary">+ Thêm sản
						phẩm</button>

					<a href="${pageContext.request.contextPath}/admin/products"
						class="btn btn-secondary"> Hủy </a>

				</div>

			</form>

		</div>

	</div>

</body>
</html>