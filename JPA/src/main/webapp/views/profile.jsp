<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<title>Profile - Shopping</title>

 <div>
	<div class="profile-card">

		<div class="profile-title">
			<h1>Thông tin cá nhân</h1>
			<p>Cập nhật thông tin tài khoản của bạn</p>
		</div>

		<c:if test="${param.success == '1'}">
			<div class="alert success">Cập nhật thông tin thành công!</div>
		</c:if>

		<c:if test="${not empty error}">
			<div class="alert error">${error}</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/profile"
			method="post" enctype="multipart/form-data">

			<div class="avatar-section">

				<c:choose>

					<c:when test="${not empty user.avatar}">

						<img
							src="${pageContext.request.contextPath}/images/${user.avatar}"
							class="avatar" alt="Avatar">

					</c:when>

					<c:otherwise>

						<div class="avatar default-avatar">👤</div>

					</c:otherwise>

				</c:choose>

				<label class="upload-label"> Chọn ảnh đại diện <input
					type="file" name="image" accept="image/*">
				</label> <small> JPG, JPEG, PNG, GIF, WEBP - tối đa 5MB </small>

			</div>

			<div class="form-group">

				<label>Username</label> <input type="text" value="${user.username}"
					readonly>

			</div>

			<div class="form-group">

				<label>Email</label> <input type="email" value="${user.email}"
					readonly>

			</div>

			<div class="form-group">

				<label>Họ và tên</label> <input type="text" name="fullname"
					value="${user.fullname}" required>

			</div>

			<div class="form-group">

				<label>Số điện thoại</label> <input type="text" name="phone"
					value="${user.phone}" required>

			</div>

			<button type="submit" class="btn-update">Cập nhật thông tin

			</button>

		</form>

	</div>

</div>