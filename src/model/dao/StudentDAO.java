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
	 * Get class list
	 * @throws SQLException 
	 * */
	public ArrayList<String> getClassList() throws SQLException{
		ps = con.prepareStatement("SELECT DISTINCT stu_class FROM hrd_students");
		ArrayList<String> list = new ArrayList<String>();
		rs = ps.executeQuery();
		
		while(rs.next()){
			// add class to arraylist
			list.add(rs.getString("stu_class"));
		}
		
		rs.close();
		ps.close();
		con.close();
		return list;
	}
	
	/**
	 * Get Student List
	 * @throws SQLException 
	 * */
	public ArrayList<Student> viewStudent() throws SQLException{
		ArrayList<Student> arr = new ArrayList<Student>();
		ps = con.prepareStatement("SELECT * FROM hrd_students ORDER by cast(replace(stu_id, '131N', '') as INTEGER) DESC");
		rs = ps.executeQuery();
		// loop from result set and add object student to arraylist
		while(rs.next()){
			arr.add(new Student(rs.getString("stu_id"), 
					rs.getString("stu_name"), 
					rs.getString("stu_gender"), 
					rs.getString("stu_university"), 
					rs.getString("stu_class"), 
					rs.getString("stu_status")));
		}
		
		rs.close();
		ps.close();
		con.close();
		return arr;
	}
	
	/**
	 * View By Id
	 * @param id is the id of student
	 * @throws SQLException
	 * */
	public Student viewStudentById(String id) throws SQLException{
		Student stu = null;
		ps = con.prepareStatement("SELECT * FROM hrd_students WHERE stu_id=?");
		ps.setString(1, id);
		rs = ps.executeQuery();
		// loop from result set and add object student to arraylist
		while(rs.next()){
			stu = new Student(rs.getString("stu_id"), 
					rs.getString("stu_name"), 
					rs.getString("stu_gender"), 
					rs.getString("stu_university"), 
					rs.getString("stu_class"), 
					rs.getString("stu_status"));
		}
		
		rs.close();
		ps.close();
		con.close();
		return stu;
		
	}
	
	/**
	 * Get Student List
	 * @throws SQLException 
	 * 
	 * */
	public ArrayList<Student> searchStudent(String stu_name, String class_status) throws SQLException{
		ArrayList<Student> arr = new ArrayList<Student>();
		ps = con.prepareStatement("SELECT * FROM hrd_students WHERE stu_name ~* CONCAT('.*', ?, '.*')" + class_status + " ORDER by cast(replace(stu_id, '131N', '') as INTEGER) DESC");
		ps.setString(1, stu_name);
		rs = ps.executeQuery();
		// loop from result set and add object student to arraylist
		while(rs.next()){
			arr.add(new Student(rs.getString("stu_id"), 
					rs.getString("stu_name"), 
					rs.getString("stu_gender"), 
					rs.getString("stu_university"), 
					rs.getString("stu_class"), 
					rs.getString("stu_status")));
		}
		return arr;
	}
	
	/**
	 * Update Status
	 * @param id
	 * @param status
	 * @throws SQLException 
	 * */
	public boolean updateStatus(String id, String status) throws SQLException{
		ps = con.prepareStatement("UPDATE hrd_students SET stu_status=? WHERE stu_id=?");
		ps.setString(1, status);
		ps.setString(2, id);
		
		if(ps.executeUpdate() > 0){
			ps.close();
			con.close();
			return true;
		}
		
		ps.close();
		con.close();
		return false;
	}
	
	/**
	 * Check if student id is exist.
	 * @param id is the string of id to check
	 * @throws SQLException 
	 * */
	public boolean checkStudentId(String id) throws SQLException{
		ps = con.prepareStatement("SELECT stu_id FROM hrd_students WHERE stu_id=?");
		ps.setString(1, id);
		rs = ps.executeQuery();
		if(rs.next()){
			// check if id is exist or not
			if(rs.getString("stu_id").equals(id)){
				// close object and return true
				rs.close();
				ps.close();
				con.close();
				return true;
			}
		}
		// close object and return false
		rs.close();
		ps.close();
		con.close();
		return false;
	}
	
	/**
	 * Add Student.
	 * @param stu is the student object.
	 * @throws SQLException 
	 * */
	public boolean addStudent(Student stu) throws SQLException{
		ps = con.prepareStatement("INSERT INTO hrd_students VALUES(?, ?, ?, ?, ?, ?)");
		ps.setString(1, stu.getStu_id());
		ps.setString(2, stu.getStu_name());
		String gender = stu.getStu_gender();
		// change gender value
		if(gender.equals("male"))
			gender = "1";
		else
			gender = "0";
		
		ps.setString(3, gender);
		ps.setString(4, stu.getStu_university());
		ps.setString(5, stu.getStu_class());
		ps.setString(6, "1");
		
		if(ps.executeUpdate()>0){
			ps.close();
			con.close();
			return true;
		}
		
		ps.close();
		con.close();
		return false;
	}

	/**
	 * Update Student Info
	 * @param stu is the student object.
	 * @throws SQLException 
	 * */
	public boolean updateStudent(Student stu) throws SQLException{
		ps = con.prepareStatement("UPDATE hrd_students SET stu_name=?, stu_gender=?, stu_university=?, stu_class=? WHERE stu_id=?");
		
		ps.setString(1, stu.getStu_name());
		String gender = stu.getStu_gender();
		// change gender value
		if(gender.equals("male"))
			gender = "1";
		else
			gender = "0";
		
		ps.setString(2, gender);
		ps.setString(3, stu.getStu_university());
		ps.setString(4, stu.getStu_class());
		ps.setString(5, stu.getStu_id());
		
		if(ps.executeUpdate()>0){
			ps.close();
			con.close();
			return true;
		}
		
		ps.close();
		con.close();
		return false;
	}
	
	/**
	 * Delete Student
	 * @param id
	 * @throws SQLException 
	 * */
	public boolean deleteStudent(String id) throws SQLException{
		ps = con.prepareStatement("DELETE FROM hrd_students WHERE stu_id=?");
		ps.setString(1, id);
		if(ps.executeUpdate()>0){
			ps.close();
			con.close();
			return true;
		}
		
		ps.close();
		con.close();
		return false;
	}
	
}
