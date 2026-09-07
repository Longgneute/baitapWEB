<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title><sitemesh:write property="title" /></title>

<!-- Bootstrap 5.3 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Bootstrap Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<!-- CSS project -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

<!-- CSS / head từ JSP con -->
<sitemesh:write property="head" />

</head>

<body class="bg-light">

	<!-- =========================
         NAVBAR
         ========================= -->

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow">

		<div class="container">

			<!-- LOGO -->

			<a class="navbar-brand fw-bold"
				href="${pageContext.request.contextPath}/home"> <i
				class="bi bi-cart3"></i> Shopping

			</a>


			<!-- MOBILE BUTTON -->

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#mainNavbar"
				aria-controls="mainNavbar" aria-expanded="false"
				aria-label="Toggle navigation">

				<span class="navbar-toggler-icon"></span>

			</button>


			<!-- MENU -->

			<div class="collapse navbar-collapse" id="mainNavbar">

				<ul class="navbar-nav me-auto">

					<!-- TRANG CHỦ -->
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/home"> <i
							class="bi bi-house"></i> Trang chủ

					</a></li>


					<!-- SẢN PHẨM -->
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/product"> <i
							class="bi bi-shop"></i> Sản phẩm

					</a></li>


					<!-- CHỈ ADMIN MỚI THẤY -->
					<c:if
						test="${not empty sessionScope.account 
					and sessionScope.account.roleId == 1}">

						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#"
							data-bs-toggle="dropdown"> <i class="bi bi-gear"></i> Quản lý

						</a>


							<ul class="dropdown-menu">

								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/admin/products"> <i
										class="bi bi-box-seam"></i> Quản lý sản phẩm

								</a></li>


								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/admin/categories">

										<i class="bi bi-tags"></i> Quản lý danh mục

								</a></li>

							</ul></li>

					</c:if>

				</ul>


				<!-- USER MENU -->

				<ul class="navbar-nav">

					<c:choose>

						<c:when test="${not empty sessionScope.account}">

							<!-- USER NAME: chỉ hiển thị tên, không dùng dropdown -->
							<li class="nav-item d-flex align-items-center">
								<span class="navbar-user-name">
									<i class="bi bi-person-circle"></i>
									<span>${sessionScope.account.fullname}</span>
								</span>
							</li>

							<!-- PROFILE -->
							<li class="nav-item ms-lg-2 mt-2 mt-lg-0">
								<a class="navbar-action navbar-profile"
									href="${pageContext.request.contextPath}/profile">
									<i class="bi bi-person-vcard"></i>
									<span>Profile</span>
								</a>
							</li>

							<!-- LOGOUT -->
							<li class="nav-item ms-lg-2 mt-2 mt-lg-0">
								<a class="navbar-action navbar-logout"
									href="${pageContext.request.contextPath}/logout">
									<i class="bi bi-box-arrow-right"></i>
									<span>Đăng xuất</span>
								</a>
							</li>

						</c:when>


						<c:otherwise>

							<li class="nav-item"><a class="nav-link"
								href="${pageContext.request.contextPath}/login"> <i
									class="bi bi-box-arrow-in-right"></i> Đăng nhập

							</a></li>


							<li class="nav-item"><a class="nav-link"
								href="${pageContext.request.contextPath}/register"> <i
									class="bi bi-person-plus"></i> Đăng ký

							</a></li>

						</c:otherwise>

					</c:choose>

				</ul>

			</div>

		</div>

	</nav>


	<!-- =========================
         MAIN CONTENT
         ========================= -->

	<main class="container py-4">

		<sitemesh:write property="body" />

	</main>


	<!-- =========================
         FOOTER
         ========================= -->

	<footer class="bg-dark text-white mt-5">

		<div class="container py-4">

			<div class="row">

				<div class="col-md-6">

					<h5>

						<i class="bi bi-cart3"></i> Shopping

					</h5>

					<p class="text-secondary mb-0">Website quản lý và mua bán sản
						phẩm.</p>

				</div>


				<div class="col-md-6 text-md-end">

					<p class="mb-1">JPA + Hibernate + Servlet + JSP</p>

					<p class="text-secondary mb-0">© 2026 Shopping</p>

				</div>

			</div>

		</div>

	</footer>


	<!-- Bootstrap JS -->

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
		
	</script>

</body>

</html>