<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Trang chủ - Shopping</title>

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Bootstrap Icons -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css"
	rel="stylesheet">

<style>
body {
	background: linear-gradient(135deg, #667eea, #764ba2);
	min-height: 100vh;
}

/* MAIN */
.home-container {
	padding: 60px 15px;
}

/* WELCOME CARD */
.welcome-card {
	background: rgba(255, 255, 255, 0.98);
	border-radius: 28px;
	padding: 55px 50px;
	box-shadow: 0 25px 60px rgba(0, 0, 0, 0.20);
}

/* ICON */
.welcome-icon {
	width: 90px;
	height: 90px;
	margin: 0 auto 25px;
	border-radius: 24px;
	background: linear-gradient(135deg, #667eea, #764ba2);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 42px;
	box-shadow: 0 10px 25px rgba(102, 126, 234, 0.35);
}

/* TITLE */
.welcome-title {
	font-size: 36px;
	font-weight: 800;
	color: #1f2937;
	margin-bottom: 12px;
}

.welcome-subtitle {
	color: #6b7280;
	font-size: 17px;
	line-height: 1.7;
}

/* PRODUCT SECTION */
.product-section {
	margin-top: 50px;
}

.product-title {
	font-size: 28px;
	font-weight: 750;
	color: #1f2937;
	margin-bottom: 30px;
}

/* PRODUCT CARD */
.product-card {
	border: none;
	border-radius: 18px;
	overflow: hidden;
	height: 100%;
	background: white;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
	transition: all 0.25s ease;
}

.product-card:hover {
	transform: translateY(-7px);
	box-shadow: 0 18px 35px rgba(0, 0, 0, 0.15);
}

/* IMAGE */
.product-image {
	width: 100%;
	height: 210px;
	object-fit: cover;
	display: block;
	background: #f3f4f6;
}

.product-image-placeholder {
	width: 100%;
	height: 210px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #f3f4f6;
	color: #9ca3af;
	font-size: 50px;
}

/* PRODUCT BODY */
.product-body {
	padding: 20px;
}

.product-name {
	font-size: 17px;
	font-weight: 700;
	color: #1f2937;
	min-height: 48px;
	margin-bottom: 10px;
}

.product-price {
	color: #667eea;
	font-size: 19px;
	font-weight: 800;
}

/* BUTTON */
.explore-btn {
	border: none;
	border-radius: 12px;
	padding: 13px 28px;
	font-size: 16px;
	font-weight: 600;
	background: linear-gradient(135deg, #667eea, #764ba2);
	color: white;
	box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
	transition: 0.2s;
}

.explore-btn:hover {
	transform: translateY(-2px);
	color: white;
	box-shadow: 0 12px 25px rgba(102, 126, 234, 0.4);
}

/* FOOTER */
.footer-text {
	color: #9ca3af;
	font-size: 13px;
	margin-top: 35px;
}

/* MOBILE */
@media ( max-width : 768px) {
	.home-container {
		padding: 30px 12px;
	}
	.welcome-card {
		padding: 35px 20px;
	}
	.welcome-title {
		font-size: 28px;
	}
	.product-title {
		font-size: 24px;
	}
	.product-image, .product-image-placeholder {
		height: 190px;
	}
}
</style>

</head>

<body>

	<!-- CONTENT -->
	<main class="home-container">

		<div class="container">

			<div class="welcome-card">

				<!-- ICON -->
				<div class="welcome-icon">🛍️</div>


				<!-- WELCOME -->
				<h1 class="welcome-title text-center">Chào mừng bạn đến
					Shopping!</h1>

				<p class="welcome-subtitle text-center mb-0">
					Xin chào 👋 <br> Chúc bạn có một trải nghiệm mua sắm thật
					tuyệt vời.
				</p>


				<!-- PRODUCTS -->
				<section class="product-section">

					<h2 class="product-title text-center">
						<i class="bi bi-stars"></i> 10 sản phẩm mới nhất
					</h2>


					<div class="row g-4">

						<c:choose>

							<c:when test="${not empty latestProducts}">

								<c:forEach var="p" items="${latestProducts}">

									<div class="col-12 col-sm-6 col-lg-4 col-xl-3">

										<div class="product-card">

											<a
												href="${pageContext.request.contextPath}/product/detail?id=${p.productId}"
												class="text-decoration-none"> <c:choose>

													<c:when test="${not empty p.image}">

														<img
															src="${pageContext.request.contextPath}/images/${p.image}"
															alt="${p.productName}" class="product-image">

													</c:when>

													<c:otherwise>

														<div class="product-image-placeholder">
															<i class="bi bi-image"></i>
														</div>

													</c:otherwise>

												</c:choose>

											</a>

											<div class="product-body">

												<div class="product-name">${p.productName}</div>

												<div class="product-price">${p.price} VNĐ</div>

											</div>

										</div>

									</div>

								</c:forEach>

							</c:when>

							<c:otherwise>

								<div class="col-12">

									<div class="alert alert-info text-center rounded-4">
										<i class="bi bi-info-circle"></i> Hiện chưa có sản phẩm nào.
									</div>

								</div>

							</c:otherwise>

						</c:choose>

					</div>

				</section>


				<!-- BUTTON -->
				<div class="text-center mt-5">

					<a href="${pageContext.request.contextPath}/product"
						class="explore-btn text-decoration-none"> <i
						class="bi bi-cart3"></i> &nbsp; Khám phá sản phẩm

					</a>

				</div>


				<!-- FOOTER -->
				<div class="footer-text text-center">Shopping MVC &copy; 2026

				</div>

			</div>

		</div>

	</main>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
		
	</script>

</body>

</html>