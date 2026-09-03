package vn.laptrinhJPA.config;

import jakarta.persistence.EntityManager;

import jakarta.persistence.EntityTransaction;

import vn.laptrinhJPA.entity.Category;

public class Test {

	public static void main(String[] args) {

		EntityManager enma = JPAConfig.getEntityManager();

		EntityTransaction trans = enma.getTransaction();

		Category cate = new Category();

		cate.setCateName("Iphone");

		cate.setIcons("abc.jpg");

		try {

			trans.begin();

			enma.persist(cate);

			trans.commit();

		} catch (Exception e) {

			e.printStackTrace();

			trans.rollback();

			throw e;

		} finally {

			enma.close();

		}

	}

}