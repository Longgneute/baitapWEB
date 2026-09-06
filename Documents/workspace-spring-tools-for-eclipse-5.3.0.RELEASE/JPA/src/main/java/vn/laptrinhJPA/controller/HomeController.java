package vn.laptrinhJPA.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.laptrinhJPA.service.IProductService;
import vn.laptrinhJPA.service.impl.ProductServiceImpl;

@WebServlet("/home")
public class HomeController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final IProductService productService = new ProductServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setAttribute("latestProducts", productService.findLatest(10));

		req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
	}
}