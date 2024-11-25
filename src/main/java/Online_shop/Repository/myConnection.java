package Online_shop.Repository;

import java.sql.Connection;
import java.sql.DriverManager;

public class myConnection {

	public static Connection getConnection() {
		Connection con = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Online_shop", "root", "pizza4428");

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return con;
	}
}
