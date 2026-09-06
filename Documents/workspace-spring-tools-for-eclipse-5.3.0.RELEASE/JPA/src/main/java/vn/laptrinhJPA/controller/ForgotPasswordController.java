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
import vn.laptrinhJPA.util.EmailUtil;
import vn.laptrinhJPA.util.OTPUtil;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final IUserService userService = new UserServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");

		User user = userService.findByEmail(email);

		if (user == null) {

			req.setAttribute("error", "Email không tồn tại");

			doGet(req, resp);

			return;
		}

		String otp = OTPUtil.generateOTP();

		LocalDateTime expiry = LocalDateTime.now().plusMinutes(5);

		userService.updateOtp(user.getId(), otp, expiry);

		EmailUtil.sendOTP(email, otp);

		HttpSession session = req.getSession(true);

		session.setAttribute("FORGOT_USER_ID", user.getId());

		resp.sendRedirect(req.getContextPath() + "/verify-forgot-otp");
	}
}