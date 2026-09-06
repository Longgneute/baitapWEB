package vn.laptrinhJPA.controller;

import java.io.IOException;
import java.time.LocalDateTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.laptrinhJPA.service.IUserService;
import vn.laptrinhJPA.service.impl.UserServiceImpl;
import vn.laptrinhJPA.util.Constant;
import vn.laptrinhJPA.util.EmailUtil;
import vn.laptrinhJPA.util.OTPUtil;
import vn.laptrinhJPA.entity.User;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final IUserService userService = new UserServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String email = req.getParameter("email");
		String username = req.getParameter("username");
		String fullname = req.getParameter("fullname");
		String phone = req.getParameter("phone");
		String password = req.getParameter("password");

		try {

			// 1. Tạo tài khoản
			boolean result = userService.register(email, password, username, fullname, phone);

			if (!result) {
				req.setAttribute("error", "Đăng ký thất bại.");

				req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);

				return;
			}

			// 2. Lấy user vừa đăng ký
			User user = userService.findByEmail(email);

			if (user == null) {
				req.setAttribute("error", "Không tìm thấy tài khoản vừa đăng ký.");

				req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);

				return;
			}

			// 3. Tạo OTP
			String otp = OTPUtil.generateOTP();

			// OTP có hiệu lực 5 phút
			LocalDateTime expiry = LocalDateTime.now().plusMinutes(5);

			// 4. Lưu OTP vào database
			userService.updateOtp(user.getId(), otp, expiry);

			// 5. Gửi OTP qua email
			EmailUtil.sendOTP(email, otp);

			// 6. Lưu ID user vào session
			HttpSession session = req.getSession(true);

			session.setAttribute("VERIFY_USER_ID", user.getId());

			// 7. Chuyển sang trang nhập OTP
			resp.sendRedirect(req.getContextPath() + "/verify-otp");

		} catch (Exception e) {

			e.printStackTrace();

			req.setAttribute("error", e.getMessage());

			req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
		}
	}
}