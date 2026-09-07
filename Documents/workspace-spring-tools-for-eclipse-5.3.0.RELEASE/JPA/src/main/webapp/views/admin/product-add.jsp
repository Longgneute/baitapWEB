<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">

<head>

<meta charset="UTF-8">

<title>Thêm sản phẩm</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

<style>
.container {
	max-width: 900px;
	margin: 40px auto;
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
}

.back {
	text-decoration: none;
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

.image-box {
	border: 2px dashed #d1d5db;
	border-radius: 10px;
	padding: 20px;
	text-align: center;
	background: #fafafa;
}

.image-box input {
	border: none;
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

.required {
	color: red;
}

@media ( max-width : 700px) {
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

		<!-- HEADER -->

		<div class="header">

			<h1>Thêm sản phẩm</h1>

			<a href="${pageContext.request.contextPath}/admin/products"
				class="back"> ← Quay lại danh sách </a>

		</div>


		<div class="card">

			<!-- ERROR FROM CONTROLLER -->

			<c:if test="${not empty error}">

				<div class="alert alert-danger" role="alert">${error}</div>

			</c:if>


			<!-- =========================
             FORM THÊM SẢN PHẨM
             ========================= -->

			<form
				action="${pageContext.request.contextPath}/admin/product/insert"
				method="post" enctype="multipart/form-data" class="needs-validation"
				novalidate>


				<!-- TÊN SẢN PHẨM -->

				<div class="form-group">

					<label for="productName"> Tên sản phẩm <span
						class="required">*</span>

					</label> <input type="text" id="productName" name="productName"
						class="form-control" placeholder="Nhập tên sản phẩm"
						maxlength="100" pattern=".{2,100}" required>

					<div class="invalid-feedback">Tên sản phẩm phải từ 2 đến 100
						ký tự.</div>

				</div>


				<!-- MÔ TẢ -->

				<div class="form-group">

					<label for="description"> Mô tả </label>

					<textarea id="description" name="description" class="form-control"
						maxlength="1000" placeholder="Nhập mô tả sản phẩm"></textarea>

					<div class="invalid-feedback">Mô tả không được vượt quá 1000
						ký tự.</div>

				</div>


				<!-- GIÁ + SỐ LƯỢNG -->

				<div class="row">

					<!-- GIÁ -->

					<div class="col-md-6">

						<div class="form-group">

							<label for="price"> Giá <span class="required">*</span>

							</label> <input type="number" id="price" name="price"
								class="form-control" step="0.01" min="0" placeholder="Nhập giá"
								required>

							<div class="invalid-feedback">Giá phải lớn hơn hoặc bằng 0.

							</div>

						</div>

					</div>


					<!-- SỐ LƯỢNG -->

					<div class="col-md-6">

						<div class="form-group">

							<label for="quantity"> Số lượng <span class="required">*</span>

							</label> <input type="number" id="quantity" name="quantity"
								class="form-control" min="0" step="1"
								placeholder="Nhập số lượng" required>

							<div class="invalid-feedback">Số lượng phải là số nguyên
								lớn hơn hoặc bằng 0.</div>

						</div>

					</div>

				</div>


				<!-- CATEGORY -->

				<div class="form-group">

					<label for="cateId"> Danh mục <span class="required">*</span>

					</label> <select id="cateId" name="cateId" class="form-select" required>

						<option value="">-- Chọn danh mục --</option>

						<c:forEach var="category" items="${listCategory}">

							<option value="${category.cateId}">${category.cateName}

							</option>

						</c:forEach>

					</select>

					<div class="invalid-feedback">Vui lòng chọn danh mục.</div>

				</div>


				<!-- IMAGE -->

				<div class="form-group">

					<label for="image"> Hình ảnh </label>

					<div class="image-box">

						<input type="file" id="image" name="image" class="form-control"
							accept="image/*">

						<p class="mt-2 mb-0">Chọn hình ảnh sản phẩm</p>

					</div>

					<div class="invalid-feedback">Vui lòng chọn file hình ảnh hợp
						lệ.</div>

				</div>


				<!-- BUTTONS -->

				<div class="actions">

					<button type="submit" class="btn btn-primary">+ Thêm sản
						phẩm</button>

					<a href="${pageContext.request.contextPath}/admin/products"
						class="btn btn-secondary"> Hủy </a>

				</div>

			</form>

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