package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class JDBCConnection {
	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinfo","root","aditya8308307728");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}