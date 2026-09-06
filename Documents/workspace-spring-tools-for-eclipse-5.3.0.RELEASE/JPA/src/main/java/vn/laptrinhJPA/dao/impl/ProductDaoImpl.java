package vn.laptrinhJPA.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import vn.laptrinhJPA.config.JPAConfig;
import vn.laptrinhJPA.dao.IProductDao;
import vn.laptrinhJPA.entity.Product;

public class ProductDaoImpl implements IProductDao {

	@Override
	public void insert(Product product) {

		EntityManager em = JPAConfig.getEntityManager();
		EntityTransaction transaction = em.getTransaction();

		try {

			transaction.begin();

			/*
			 * Category được lấy từ CategoryDao ở một EntityManager khác nên đã trở thành
			 * detached entity.
			 *
			 * Lấy lại Category reference bằng EntityManager hiện tại trước khi persist
			 * Product.
			 */
			if (product.getCategory() != null) {

				int cateId = product.getCategory().getCateId();

				product.setCategory(em.getReference(vn.laptrinhJPA.entity.Category.class, cateId));
			}

			em.persist(product);

			transaction.commit();

		} catch (Exception e) {

			if (transaction.isActive()) {
				transaction.rollback();
			}

			e.printStackTrace();

			throw e;

		} finally {

			em.close();
		}
	}

	@Override
	public void update(Product product) {

		EntityManager em = JPAConfig.getEntityManager();
		EntityTransaction transaction = em.getTransaction();

		try {

			transaction.begin();

			/*
			 * Khi update cũng lấy Category reference từ EntityManager hiện tại.
			 */
			if (product.getCategory() != null) {

				int cateId = product.getCategory().getCateId();

				product.setCategory(em.getReference(vn.laptrinhJPA.entity.Category.class, cateId));
			}

			em.merge(product);

			transaction.commit();

		} catch (Exception e) {

			if (transaction.isActive()) {
				transaction.rollback();
			}

			e.printStackTrace();

			throw e;

		} finally {

			em.close();
		}
	}

	@Override
	public void delete(int productId) throws Exception {

		EntityManager em = JPAConfig.getEntityManager();
		EntityTransaction transaction = em.getTransaction();

		try {

			transaction.begin();

			Product product = em.find(Product.class, productId);

			if (product == null) {
				throw new Exception("Không tìm thấy sản phẩm");
			}

			em.remove(product);

			transaction.commit();

		} catch (Exception e) {

			if (transaction.isActive()) {
				transaction.rollback();
			}

			e.printStackTrace();

			throw e;

		} finally {

			em.close();
		}
	}

	@Override
	public Product findById(int productId) {

		EntityManager em = JPAConfig.getEntityManager();

		try {

			String jpql = "SELECT p FROM Product p " + "JOIN FETCH p.category " + "WHERE p.productId = :id";

			return em.createQuery(jpql, Product.class).setParameter("id", productId).getSingleResult();

		} catch (Exception e) {

			e.printStackTrace();

			return null;

		} finally {

			em.close();
		}
	}

	@Override
	public List<Product> findAll() {

		EntityManager em = JPAConfig.getEntityManager();

		try {

			String jpql = "SELECT p FROM Product p " + "JOIN FETCH p.category " + "ORDER BY p.productId DESC";

			return em.createQuery(jpql, Product.class).getResultList();

		} finally {

			em.close();
		}
	}

	@Override
	public List<Product> findLatest(int limit) {

		EntityManager em = JPAConfig.getEntityManager();

		try {

			String jpql = "SELECT p FROM Product p " + "JOIN FETCH p.category " + "ORDER BY p.createdDate DESC";

			TypedQuery<Product> query = em.createQuery(jpql, Product.class);

			query.setMaxResults(limit);

			return query.getResultList();

		} finally {

			em.close();
		}
	}

	@Override
	public List<Product> findAll(int page, int pageSize) {

		EntityManager em = JPAConfig.getEntityManager();

		try {

			String jpql = "SELECT p FROM Product p " + "JOIN FETCH p.category " + "ORDER BY p.createdDate DESC";

			TypedQuery<Product> query = em.createQuery(jpql, Product.class);

			query.setFirstResult(page * pageSize);
			query.setMaxResults(pageSize);

			return query.getResultList();

		} finally {

			em.close();
		}
	}

	@Override
	public int count() {

		EntityManager em = JPAConfig.getEntityManager();

		try {

			Long count = em.createQuery("SELECT COUNT(p) FROM Product p", Long.class).getSingleResult();

			return count.intValue();

		} finally {

			em.close();
		}
	}
}