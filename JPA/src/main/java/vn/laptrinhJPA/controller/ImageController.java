package vn.laptrinhJPA.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.laptrinhJPA.util.Constant;

@WebServlet("/images/*")
public class ImageController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String fileName = req.getPathInfo();

		if (fileName == null || fileName.equals("/")) {

			resp.sendError(HttpServletResponse.SC_NOT_FOUND);

			return;
		}

		fileName = new File(fileName).getName();

		File file = new File(Constant.DIR, fileName);

		if (!file.exists() || !file.isFile()) {

			resp.sendError(HttpServletResponse.SC_NOT_FOUND);

			return;
		}

		String contentType = getServletContext().getMimeType(file.getName());

		if (contentType == null) {
			contentType = "application/octet-stream";
		}

		resp.setContentType(contentType);

		resp.setContentLengthLong(file.length());

		try (OutputStream output = resp.getOutputStream()) {

			Files.copy(file.toPath(), output);
		}
	}
}