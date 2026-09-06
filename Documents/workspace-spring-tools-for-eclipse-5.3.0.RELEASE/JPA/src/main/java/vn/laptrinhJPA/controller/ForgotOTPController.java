package vn.laptrinhJPA.controller;

import java.io.IOException;
import java.time.LocalDateTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.laptrinhJPA.entity.User;
import vn.laptrinhJPA.service.IUserService;
import vn.laptrinhJPA.service.impl.UserServiceImpl;

@WebServlet("/verify-forgot-otp")
public class ForgotOTPController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private IUserService userService = new UserServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.getRequestDispatcher("/views/verify-forgot-otp.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String otp = req.getParameter("otp");

		HttpSession session = req.getSession(false);

		if (session == null) {
			resp.sendRedirect(req.getContextPath() + "/forgot-password");
			return;
		}

		Integer userId = (Integer) session.getAttribute("FORGOT_USER_ID");

		if (userId == null) {
			resp.sendRedirect(req.getContextPath() + "/forgot-password");
			return;
		}

		User user = userService.findById(userId);

		if (user == null) {
			req.setAttribute("error", "Không tìm thấy tài khoản");

			doGet(req, resp);
			return;
		}

		// Kiểm tra OTP
		if (otp == null || otp.trim().isEmpty()) {

			req.setAttribute("error", "Vui lòng nhập mã OTP");

			doGet(req, resp);
			return;
		}

		if (user.getOtp() == null || !user.getOtp().equals(otp.trim())) {

			req.setAttribute("error", "OTP không chính xác");

			doGet(req, resp);
			return;
		}

		// Kiểm tra thời gian
		if (user.getOtpExpiry() == null || user.getOtpExpiry().isBefore(LocalDateTime.now())) {

			req.setAttribute("error", "OTP đã hết hạn");

			doGet(req, resp);
			return;
		}

		// OTP đúng
		session.setAttribute("RESET_USER_ID", userId);

		session.removeAttribute("FORGOT_USER_ID");

		// Sang trang đổi mật khẩu
		resp.sendRedirect(req.getContextPath() + "/reset-password");
	}
}