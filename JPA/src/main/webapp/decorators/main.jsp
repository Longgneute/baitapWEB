<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>

<html lang="vi">

<head>

<meta charset="UTF-8">

<title><sitemesh:write property="title" /></title>

<sitemesh:write property="head" />

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

.navbar {
	height: 70px;
	background: white;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 50px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, .08);
}

.logo {
	font-size: 22px;
	font-weight: bold;
}

.nav-right {
	display: flex;
	align-items: center;
	gap: 15px;
}

.nav-link {
	text-decoration: none;
	color: #667eea;
	font-weight: 600;
}

.logout {
	text-decoration: none;
	color: #667eea;
	border: 1px solid #667eea;
	padding: 8px 15px;
	border-radius: 7px;
}

.logout:hover {
	background: #667eea;
	color: white;
}
</style>

</head>

<body>

	<header class="navbar">

		<div class="logo">🛒 Shopping</div>

		<div class="nav-right">

			<a href="${pageContext.request.contextPath}/profile" class="nav-link">
				Profile </a> <a href="${pageContext.request.contextPath}/logout"
				class="logout"> Đăng xuất </a>

		</div>

	</header>

	<main>

		<sitemesh:write property="body" />

	</main>

</body>

</html>