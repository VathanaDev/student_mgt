package util;

import java.sql.*;

public class Conn {
	private Connection con=null;
	
	/**
	 * Get connection.
	 * @throws ClassNotFoundException
	 * @throws SQLException 
	 * */
	public Connection getConnection() throws ClassNotFoundException, SQLException{
		Class.forName("org.postgresql.Driver");
		con = DriverManager.getConnection("jdbc:postgresql://localhost/5432/student", "postgres", "7778");
		return con;
	}
}
