package vn.laptrinhJPA.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.laptrinhJPA.entity.User;
import vn.laptrinhJPA.util.Constant;

import java.io.IOException;
import java.io.Serial;

@WebServlet("/waiting")
public class WaitingController extends HttpServlet {

	@Serial
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);

		if (user == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		if (user.getId() == 1) {

			resp.sendRedirect(req.getContextPath() + "/admin/home");

		} else if (user.getId() == 2) {

			resp.sendRedirect(req.getContextPath() + "/home");

		} else {

			resp.sendRedirect(req.getContextPath() + "/home");
		}
	}
}
