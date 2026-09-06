<%@ page contentType="text/html;charset=UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html lang="vi">

<head>

<meta charset="UTF-8">

<title>Sản phẩm</title>

<style>
.product-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 25px;
}

.product-card {
	background: white;
	padding: 20px;
	border-radius: 12px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, .1);
}

.product-card img {
	width: 100%;
	height: 220px;
	object-fit: cover;
}

.product-card a {
	text-decoration: none;
	color: #222;
}

.pagination {
	margin-top: 30px;
	text-align: center;
}

.pagination a {
	display: inline-block;
	padding: 8px 14px;
	margin: 3px;
	border: 1px solid #ddd;
	text-decoration: none;
}

.pagination .active {
	background: #667eea;
	color: white;
}
</style>

</head>

<body>

	<div class="container">

		<h1>Tất cả sản phẩm</h1>

		<div class="product-grid">

			<c:forEach var="p" items="${listProduct}">

				<div class="product-card">

					<a
						href="${pageContext.request.contextPath}/product/detail?id=${p.productId}">
						<img src="${pageContext.request.contextPath}/images/${p.image}"
						alt="${p.productName}">
					</a>

					<h3>${p.productName}</h3>

					<p>
						Giá: <strong>${p.price} VNĐ</strong>
					</p>

					<p>Số lượng: ${p.quantity}</p>

				</div>

			</c:forEach>

		</div>

		<div class="pagination">

			<c:forEach begin="1" end="${totalPage}" var="i">

				<a href="${pageContext.request.contextPath}/product?page=${i}"
					class="${i == currentPage ? 'active' : ''}"> ${i} </a>

			</c:forEach>

		</div>

	</div>

</body>

</html>