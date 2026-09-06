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

@WebServlet("/verify-otp")
public class OTPController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final IUserService userService = new UserServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String otp = req.getParameter("otp");

		HttpSession session = req.getSession(false);

		if (session == null) {

			resp.sendRedirect(req.getContextPath() + "/register");

			return;
		}

		Integer userId = (Integer) session.getAttribute("VERIFY_USER_ID");

		if (userId == null) {

			resp.sendRedirect(req.getContextPath() + "/register");

			return;
		}

		User user = userService.findById(userId);

		if (user == null) {

			req.setAttribute("error", "Không tìm thấy tài khoản");

			doGet(req, resp);

			return;
		}

		if (user.getOtp() == null || !user.getOtp().equals(otp)) {

			req.setAttribute("error", "OTP không chính xác");

			doGet(req, resp);

			return;
		}

		if (user.getOtpExpiry() == null || user.getOtpExpiry().isBefore(LocalDateTime.now())) {

			req.setAttribute("error", "OTP đã hết hạn");

			doGet(req, resp);

			return;
		}

		userService.activateUser(userId);

		session.removeAttribute("VERIFY_USER_ID");

		resp.sendRedirect(req.getContextPath() + "/login?activated=1");
	}
}