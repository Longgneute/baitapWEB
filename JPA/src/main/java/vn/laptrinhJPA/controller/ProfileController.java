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

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {

			resp.sendRedirect(req.getContextPath() + "/login");

			return;
		}

		User sessionUser = (User) session.getAttribute(Constant.SESSION_ACCOUNT);

		User user = userService.findById(sessionUser.getId());

		req.setAttribute("user", user);

		req.getRequestDispatcher(Constant.PROFILE).forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {

			resp.sendRedirect(req.getContextPath() + "/login");

			return;
		}

		User sessionUser = (User) session.getAttribute(Constant.SESSION_ACCOUNT);

		int id = sessionUser.getId();

		String fullname = req.getParameter("fullname");

		String phone = req.getParameter("phone");

		Part imagePart = req.getPart("image");

		String avatar = null;

		try {

			if (imagePart != null && imagePart.getSize() > 0) {

				String submittedFileName = imagePart.getSubmittedFileName();

				if (submittedFileName == null || submittedFileName.isEmpty()) {

					throw new RuntimeException("File ảnh không hợp lệ");
				}

				String fileName = new File(submittedFileName).getName();

				String lowerName = fileName.toLowerCase();

				if (!lowerName.endsWith(".jpg") && !lowerName.endsWith(".jpeg") && !lowerName.endsWith(".png")
						&& !lowerName.endsWith(".gif") && !lowerName.endsWith(".webp")) {

					throw new RuntimeException("Chỉ cho phép JPG, JPEG, PNG, GIF hoặc WEBP");
				}

				String extension = "";

				int dotIndex = fileName.lastIndexOf(".");

				if (dotIndex >= 0) {
					extension = fileName.substring(dotIndex);
				}

				avatar = "user_" + id + "_" + System.currentTimeMillis() + extension;

				File uploadDir = new File(Constant.DIR);

				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}

				String filePath = uploadDir.getAbsolutePath() + File.separator + avatar;

				imagePart.write(filePath);
			}

			userService.updateProfile(id, fullname, phone, avatar);

			User updatedUser = userService.findById(id);

			session.setAttribute(Constant.SESSION_ACCOUNT, updatedUser);

			resp.sendRedirect(req.getContextPath() + "/profile?success=1");

		} catch (Exception e) {

			e.printStackTrace();

			User user = userService.findById(id);

			req.setAttribute("user", user);

			req.setAttribute("error", e.getMessage());

			req.getRequestDispatcher(Constant.PROFILE).forward(req, resp);
		}
	}
}