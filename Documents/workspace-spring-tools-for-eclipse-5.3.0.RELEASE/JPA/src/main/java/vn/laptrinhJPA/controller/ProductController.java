package vn.laptrinhJPA.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.laptrinhJPA.entity.Category;
import vn.laptrinhJPA.entity.Product;
import vn.laptrinhJPA.service.ICategoryService;
import vn.laptrinhJPA.service.IProductService;
import vn.laptrinhJPA.service.impl.CategoryServiceImpl;
import vn.laptrinhJPA.service.impl.ProductServiceImpl;
import vn.laptrinhJPA.util.Constant;

@WebServlet({ "/product", "/product/detail",

		"/admin/products", "/admin/product/add", "/admin/product/edit", "/admin/product/insert",
		"/admin/product/update", "/admin/product/delete" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class ProductController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final IProductService productService = new ProductServiceImpl();

	private final ICategoryService categoryService = new CategoryServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String uri = req.getRequestURI();

		// ==========================================
		// PUBLIC: DANH SÁCH PRODUCT
		// ==========================================

		if (uri.endsWith("/product")) {

			int page = 1;

			try {
				String pageParam = req.getParameter("page");

				if (pageParam != null) {
					page = Integer.parseInt(pageParam);
				}

			} catch (NumberFormatException e) {
				page = 1;
			}

			if (page < 1) {
				page = 1;
			}

			int pageSize = 6;

			int totalProduct = productService.count();

			int totalPage = (int) Math.ceil((double) totalProduct / pageSize);

			if (totalPage == 0) {
				totalPage = 1;
			}

			if (page > totalPage) {
				page = totalPage;
			}

			/*
			 * Controller dùng page bắt đầu từ 1. DAO dùng page bắt đầu từ 0.
			 */
			List<Product> listProduct = productService.findAll(page - 1, pageSize);

			req.setAttribute("listProduct", listProduct);

			req.setAttribute("currentPage", page);

			req.setAttribute("totalPage", totalPage);

			req.getRequestDispatcher("/views/product-list.jsp").forward(req, resp);

			return;
		}

		// ==========================================
		// PUBLIC: CHI TIẾT PRODUCT
		// ==========================================

		if (uri.endsWith("/product/detail")) {

			String idParam = req.getParameter("id");

			if (idParam == null || idParam.trim().isEmpty()) {

				resp.sendRedirect(req.getContextPath() + "/product");

				return;
			}

			try {

				int id = Integer.parseInt(idParam);

				Product product = productService.findById(id);

				if (product == null) {

					resp.sendRedirect(req.getContextPath() + "/product");

					return;
				}

				req.setAttribute("product", product);

				req.getRequestDispatcher("/views/product-detail.jsp").forward(req, resp);

			} catch (NumberFormatException e) {

				resp.sendRedirect(req.getContextPath() + "/product");
			}

			return;
		}

		// ==========================================
		// ADMIN: LIST PRODUCT
		// ==========================================

		if (uri.endsWith("/admin/products")) {
			List<Product> listProduct = productService.findAll();

			req.setAttribute("listProduct", listProduct);

			req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);

			return;
		}

		// ==========================================
		// ADMIN: ADD PRODUCT
		// ==========================================

		if (uri.endsWith("/admin/product/add")) {

			req.setAttribute("listCategory", categoryService.findAll());

			req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);

			return;
		}

		// ==========================================
		// ADMIN: EDIT PRODUCT
		// ==========================================

		if (uri.endsWith("/admin/product/edit")) {

			String idParam = req.getParameter("id");

			try {

				int id = Integer.parseInt(idParam);

				Product product = productService.findById(id);

				if (product == null) {

					resp.sendRedirect(req.getContextPath() + "/admin/products");

					return;
				}

				req.setAttribute("product", product);

				req.setAttribute("listCategory", categoryService.findAll());

				req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);

			} catch (Exception e) {

				e.printStackTrace();

				resp.sendRedirect(req.getContextPath() + "/admin/products");
			}

			return;
		}

		// ==========================================
		// ADMIN: DELETE
		// ==========================================

		if (uri.endsWith("/admin/product/delete")) {

			try {

				int id = Integer.parseInt(req.getParameter("id"));

				productService.delete(id);

			} catch (Exception e) {

				e.printStackTrace();
			}

			resp.sendRedirect(req.getContextPath() + "/admin/products");

			return;
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String uri = req.getRequestURI();

		// ==========================================
		// INSERT
		// ==========================================

		if (uri.endsWith("/admin/product/insert")) {

			try {

				Product product = new Product();

				product.setProductName(req.getParameter("productName"));

				product.setDescription(req.getParameter("description"));

				product.setPrice(new BigDecimal(req.getParameter("price")));

				product.setQuantity(Integer.parseInt(req.getParameter("quantity")));

				// Category
				int cateId = Integer.parseInt(req.getParameter("cateId"));

				Category category = categoryService.findById(cateId);

				if (category == null) {

					throw new Exception("Category không tồn tại");
				}

				product.setCategory(category);

				// ==================================
				// UPLOAD IMAGE
				// ==================================

				String imageName = uploadImage(req);

				if (imageName != null) {

					product.setImage(imageName);
				}

				product.setCreatedDate(LocalDateTime.now());

				productService.insert(product);

				resp.sendRedirect(req.getContextPath() + "/admin/products");

			} catch (Exception e) {

				e.printStackTrace();

				req.setAttribute("error", e.getMessage());

				req.setAttribute("listCategory", categoryService.findAll());

				req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
			}

			return;
		}

		// ==========================================
		// UPDATE
		// ==========================================

		if (uri.endsWith("/admin/product/update")) {

			try {

				int productId = Integer.parseInt(req.getParameter("productId"));

				Product product = productService.findById(productId);

				if (product == null) {

					resp.sendRedirect(req.getContextPath() + "/admin/products");

					return;
				}

				product.setProductName(req.getParameter("productName"));

				product.setDescription(req.getParameter("description"));

				product.setPrice(new BigDecimal(req.getParameter("price")));

				product.setQuantity(Integer.parseInt(req.getParameter("quantity")));

				// Category
				int cateId = Integer.parseInt(req.getParameter("cateId"));

				Category category = categoryService.findById(cateId);

				if (category == null) {

					throw new Exception("Category không tồn tại");
				}

				product.setCategory(category);

				// ==================================
				// ẢNH MỚI
				// ==================================

				String imageName = uploadImage(req);

				/*
				 * Nếu người dùng không chọn ảnh mới thì giữ nguyên ảnh cũ.
				 */
				if (imageName != null && !imageName.isEmpty()) {

					product.setImage(imageName);
				}

				productService.update(product);

				resp.sendRedirect(req.getContextPath() + "/admin/products");

			} catch (Exception e) {

				e.printStackTrace();

				req.setAttribute("error", e.getMessage());

				req.setAttribute("listCategory", categoryService.findAll());

				req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
			}

			return;
		}
	}

	// ==============================================
	// UPLOAD IMAGE
	// ==============================================

	private String uploadImage(HttpServletRequest req) throws IOException, ServletException {

		Part part = req.getPart("image");

		if (part == null || part.getSize() == 0) {

			return null;
		}

		String fileName = part.getSubmittedFileName();

		if (fileName == null || fileName.trim().isEmpty()) {

			return null;
		}

		fileName = new File(fileName).getName();

		/*
		 * Sử dụng thư mục ảnh hiện tại của project thông qua Constant.DIR.
		 */
		File uploadDir = new File(Constant.DIR);

		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		File destination = new File(uploadDir, fileName);

		part.write(destination.getAbsolutePath());

		return fileName;
	}
}