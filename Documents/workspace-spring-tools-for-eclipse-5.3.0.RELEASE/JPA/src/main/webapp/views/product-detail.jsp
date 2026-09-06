<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>

<html lang="vi">

<head>

<meta charset="UTF-8">

<title>${product.productName}</title>

<style>
.detail-container {
	max-width: 1000px;
	margin: 40px auto;
	background: white;
	padding: 30px;
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 40px;
}

.detail-image {
	width: 100%;
	height: 400px;
	object-fit: cover;
}

.detail-info h1 {
	font-size: 32px;
}

.price {
	color: #e63946;
	font-size: 25px;
	font-weight: bold;
}
</style>

</head>

<body>

	<div class="detail-container">

		<div>

			<img class="detail-image"
				src="${pageContext.request.contextPath}/images/${product.image}"
				alt="${product.productName}">

		</div>

		<div class="detail-info">

			<h1>${product.productName}</h1>

			<p class="price">${product.price} VNĐ</p>

			<p>Số lượng: ${product.quantity}</p>

			<p>Category: ${product.category.cateName}</p>

			<h3>Mô tả</h3>

			<p>${product.description}</p>

			<a href="${pageContext.request.contextPath}/product"> ← Quay lại
				sản phẩm </a>

		</div>

	</div>

</body>

</html>