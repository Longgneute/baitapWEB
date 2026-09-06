package vn.laptrinhJPA.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.laptrinhJPA.entity.User;
import vn.laptrinhJPA.service.IUserService;
import vn.laptrinhJPA.service.impl.UserServiceImpl;

@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final IUserService userService = new UserServiceImpl();

	// Hiển thị trang đặt lại mật khẩu
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("RESET_USER_ID") == null) {
			resp.sendRedirect(req.getContextPath() + "/forgot-password");
			return;
		}

		req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
	}

	// Xử lý đặt lại mật khẩu
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("RESET_USER_ID") == null) {
			resp.sendRedirect(req.getContextPath() + "/forgot-password");
			return;
		}

		int userId = (Integer) session.getAttribute("RESET_USER_ID");

		String password = req.getParameter("password");
		String confirmPassword = req.getParameter("confirmPassword");

		// Kiểm tra mật khẩu
		if (password == null || password.trim().isEmpty()) {
			req.setAttribute("error", "Mật khẩu không được để trống");
			req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
			return;
		}

		if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
			req.setAttribute("error", "Vui lòng nhập lại mật khẩu");
			req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
			return;
		}

		if (!password.equals(confirmPassword)) {
			req.setAttribute("error", "Mật khẩu nhập lại không khớp");
			req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
			return;
		}

		// Kiểm tra user
		User user = userService.findById(userId);

		if (user == null) {
			req.setAttribute("error", "Không tìm thấy tài khoản");
			req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
			return;
		}

		// Cập nhật mật khẩu
		userService.updatePassword(userId, password);

		// Xóa session reset password
		session.removeAttribute("RESET_USER_ID");

		// Chuyển về đăng nhập
		resp.sendRedirect(req.getContextPath() + "/login?reset=1");
	}
}