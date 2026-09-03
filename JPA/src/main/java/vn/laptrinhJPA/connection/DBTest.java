package vn.laptrinhJPA.connection;

import java.sql.Connection;

public class DBTest {

	public static void main(String[] args) {

		try {

			Connection conn = new DBConnection().getConnection();

			System.out.println("Ket noi MySQL thanh cong!");

			conn.close();

		} catch (Exception e) {

			e.printStackTrace();

		}
	}
}