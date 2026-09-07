package vn.laptrinhJPA.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.laptrinhJPA.entity.User;
import vn.laptrinhJPA.util.Constant;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;

		HttpServletResponse resp = (HttpServletResponse) response;

		HttpSession session = req.getSession(false);

		// Chưa đăng nhập
		if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {

			resp.sendRedirect(req.getContextPath() + "/login");

			return;
		}

		User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);

		// Không phải ADMIN
		if (user.getRoleId() != 1) {

			resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập!");

			return;
		}

		// ADMIN
		chain.doFilter(request, response);
	}
}