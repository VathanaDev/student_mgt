package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.dto.Student;
import util.Conn;

public class StudentDAO {
	
	private Connection con = null;
	private ResultSet rs = null;
	private PreparedStatement ps = null;
	
	public StudentDAO() throws ClassNotFoundException, SQLException{
		con = new Conn().getConnection();
	}
	
	/**
	 * Get Student List
	 * @throws SQLException 
	 * */
	public ArrayList<Student> viewStudent() throws SQLException{
		ArrayList<Student> arr = new ArrayList<Student>();
		Student st = null;
		
		ps = con.prepareStatement("SELECT * FROM htd_students");
		rs = ps.executeQuery();
		// loop from result set and add object student to arraylist
		while(rs.next()){
			arr.add(new Student(rs.getString("stu_id"), 
					rs.getString("stu_name"), 
					rs.getString("stu_gender").charAt(0), 
					rs.getString("stu_university"), 
					rs.getString("stu_class"), 
					rs.getString("stu_status").charAt(0)));
		}
		return arr;
	}
	
	/**
	 * Get Student List
	 * @throws SQLException 
	 * */
	public ArrayList<Student> searchStudent(String field, String keyword) throws SQLException{
		ArrayList<Student> arr = new ArrayList<Student>();
		Student st = null;
		
		ps = con.prepareStatement("SELECT * FROM htd_students WHERE " + field + " ~* CONCAT('.*', ?, '.*')");
		ps.setString(1, keyword);
		rs = ps.executeQuery();
		// loop from result set and add object student to arraylist
		while(rs.next()){
			arr.add(new Student(rs.getString("stu_id"), 
					rs.getString("stu_name"), 
					rs.getString("stu_gender").charAt(0), 
					rs.getString("stu_university"), 
					rs.getString("stu_class"), 
					rs.getString("stu_status").charAt(0)));
		}
		return arr;
	}
	
}
