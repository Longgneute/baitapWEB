package vn.laptrinhJPA.controller;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import vn.laptrinhJPA.entity.User;
import vn.laptrinhJPA.service.IUserService;
import vn.laptrinhJPA.service.impl.UserServiceImpl;
import vn.laptrinhJPA.util.Constant;

@WebServlet("/profile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class ProfileController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final IUserService userService = new UserServiceImpl();

	// =========================
	// GET /profile
	// =========================
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		// Chưa đăng nhập
		if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {

			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		try {

			// Lấy User đang đăng nhập
			User sessionUser = (User) session.getAttribute(Constant.SESSION_ACCOUNT);

			// Lấy lại User mới nhất từ database
			User user = userService.findById(sessionUser.getId());

			if (user == null) {

				session.invalidate();

				resp.sendRedirect(req.getContextPath() + "/login");
				return;
			}

			// Đưa user sang profile.jsp
			req.setAttribute("user", user);

			// Hiển thị profile
			req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);

		} catch (Exception e) {

			e.printStackTrace();

			req.setAttribute("error", "Không thể tải thông tin cá nhân: " + e.getMessage());

			req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
		}
	}

	// =========================
	// POST /profile
	// =========================
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession(false);

		// Chưa đăng nhập
		if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {

			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		User sessionUser = (User) session.getAttribute(Constant.SESSION_ACCOUNT);

		int id = sessionUser.getId();

		String fullname = req.getParameter("fullname");
		String phone = req.getParameter("phone");

		// =====================================================
		// QUAN TRỌNG:
		// profile.jsp dùng name="avatar"
		// nên Controller cũng phải dùng getPart("avatar")
		// =====================================================
		Part avatarPart = req.getPart("avatar");

		String avatar = null;

		try {

			// =========================
			// VALIDATE FULLNAME
			// =========================

			if (fullname == null) {
				throw new RuntimeException("Họ và tên không được để trống.");
			}

			fullname = fullname.trim();

			if (fullname.length() < 2 || fullname.length() > 100) {
				throw new RuntimeException("Họ và tên phải từ 2 đến 100 ký tự.");
			}

			// =========================
			// VALIDATE PHONE
			// =========================

			if (phone == null) {
				throw new RuntimeException("Số điện thoại không được để trống.");
			}

			phone = phone.trim();

			if (!phone.matches("^(0|\\+84)(3|5|7|8|9)[0-9]{8}$")) {
				throw new RuntimeException("Số điện thoại không hợp lệ.");
			}

			// =========================
			// XỬ LÝ AVATAR
			// =========================

			if (avatarPart != null && avatarPart.getSize() > 0) {

				String submittedFileName = avatarPart.getSubmittedFileName();

				if (submittedFileName == null || submittedFileName.trim().isEmpty()) {

					throw new RuntimeException("File ảnh không hợp lệ.");
				}

				// Chỉ lấy tên file
				String fileName = new File(submittedFileName).getName();

				String lowerName = fileName.toLowerCase();

				// =========================
				// KIỂM TRA ĐUÔI FILE
				// =========================

				if (!lowerName.endsWith(".jpg") && !lowerName.endsWith(".jpeg") && !lowerName.endsWith(".png")
						&& !lowerName.endsWith(".gif") && !lowerName.endsWith(".webp")) {

					throw new RuntimeException("Chỉ cho phép JPG, JPEG, PNG, GIF hoặc WEBP.");
				}

				// =========================
				// KIỂM TRA DUNG LƯỢNG
				// =========================

				if (avatarPart.getSize() > 5 * 1024 * 1024) {

					throw new RuntimeException("Ảnh không được vượt quá 5MB.");
				}

				// =========================
				// LẤY EXTENSION
				// =========================

				String extension = "";

				int dotIndex = fileName.lastIndexOf(".");

				if (dotIndex >= 0) {
					extension = fileName.substring(dotIndex).toLowerCase();
				}

				// =========================
				// TẠO TÊN FILE MỚI
				// =========================

				avatar = "user_" + id + "_" + System.currentTimeMillis() + extension;

				// =========================
				// TẠO THƯ MỤC UPLOAD
				// =========================

				File uploadDir = new File(Constant.DIR);

				if (!uploadDir.exists()) {

					boolean created = uploadDir.mkdirs();

					if (!created) {

						throw new RuntimeException("Không thể tạo thư mục upload ảnh.");
					}
				}

				// =========================
				// LƯU FILE
				// =========================

				String filePath = uploadDir.getAbsolutePath() + File.separator + avatar;

				avatarPart.write(filePath);
			}

			// =========================
			// UPDATE DATABASE
			// =========================

			userService.updateProfile(id, fullname, phone, avatar);

			// =========================
			// LẤY USER MỚI NHẤT
			// =========================

			User updatedUser = userService.findById(id);

			// =========================
			// UPDATE SESSION
			// =========================

			session.setAttribute(Constant.SESSION_ACCOUNT, updatedUser);

			// =========================
			// THÔNG BÁO
			// =========================

			session.setAttribute("success", "Cập nhật thông tin thành công!");

			// =========================
			// REDIRECT
			// =========================

			resp.sendRedirect(req.getContextPath() + "/profile");

		} catch (Exception e) {

			e.printStackTrace();

			// Lấy lại user
			User user = userService.findById(id);

			req.setAttribute("user", user);

			req.setAttribute("error", e.getMessage());

			req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
		}
	}
}