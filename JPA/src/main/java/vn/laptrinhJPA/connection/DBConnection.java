package vn.laptrinhJPA.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

	private final String serverName = "localhost";
	private final String portNumber = "3306";
	private final String databaseName = "laptrinhJPA";
	private final String userID = "root";
	private final String password = "Hoanglong2006@";

	private final String url = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + databaseName + "?useUnicode=true"
			+ "&characterEncoding=UTF-8" + "&useSSL=false" + "&allowPublicKeyRetrieval=true"
			+ "&serverTimezone=Asia/Ho_Chi_Minh";

	public Connection getConnection() throws Exception {

		Class.forName("com.mysql.cj.jdbc.Driver");

		return DriverManager.getConnection(url, userID, password);
	}
}