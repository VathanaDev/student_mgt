package model.dto;

public class Student {
	
	private String stu_id;
	private String stu_name;
	private String stu_gender;
	private String stu_university;
	private String stu_class;
	private String stu_status;
	
	public Student(String stu_id, String stu_name, String stu_gender, String stu_university, String stu_class,
			String stu_status) {
		this.stu_id = stu_id;
		this.stu_name = stu_name;
		this.stu_gender = stu_gender;
		this.stu_university = stu_university;
		this.stu_class = stu_class;
		this.stu_status = stu_status;
	}
	
	public String getStu_id() {
		return stu_id;
	}
	public void setStu_id(String stu_id) {
		this.stu_id = stu_id;
	}
	public String getStu_name() {
		return stu_name;
	}
	public void setStu_name(String stu_name) {
		this.stu_name = stu_name;
	}
	public String getStu_gender() {
		return stu_gender;
	}
	public void setStu_gender(String stu_gender) {
		this.stu_gender = stu_gender;
	}
	public String getStu_university() {
		return stu_university;
	}
	public void setStu_university(String stu_university) {
		this.stu_university = stu_university;
	}
	public String getStu_class() {
		return stu_class;
	}
	public void setStu_class(String stu_class) {
		this.stu_class = stu_class;
	}
	public String getStu_status() {
		return stu_status;
	}
	public void setStu_status(String stu_status) {
		this.stu_status = stu_status;
	}
	
	
}
