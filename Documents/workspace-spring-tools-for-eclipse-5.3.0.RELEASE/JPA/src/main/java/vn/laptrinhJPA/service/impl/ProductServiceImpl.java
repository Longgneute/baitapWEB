package vn.laptrinhJPA.service.impl;

import java.util.List;

import vn.laptrinhJPA.dao.IProductDao;
import vn.laptrinhJPA.dao.impl.ProductDaoImpl;
import vn.laptrinhJPA.entity.Product;
import vn.laptrinhJPA.service.IProductService;

public class ProductServiceImpl implements IProductService {

	private final IProductDao productDao = new ProductDaoImpl();

	@Override
	public void insert(Product product) {

		if (product.getProductName() == null || product.getProductName().trim().isEmpty()) {

			throw new RuntimeException("Tên sản phẩm không được để trống");
		}

		productDao.insert(product);
	}

	@Override
	public void update(Product product) {
		productDao.update(product);
	}

	@Override
	public void delete(int productId) throws Exception {

		productDao.delete(productId);
	}

	@Override
	public Product findById(int productId) {
		return productDao.findById(productId);
	}

	@Override
	public List<Product> findAll() {
		return productDao.findAll();
	}

	@Override
	public List<Product> findLatest(int limit) {
		return productDao.findLatest(limit);
	}

	@Override
	public List<Product> findAll(int page, int pageSize) {

		return productDao.findAll(page, pageSize);
	}

	@Override
	public int count() {
		return productDao.count();
	}
}