package controller.student;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import controller.ActionForward;
import model.dao.StudentDAO;
import model.dto.Student;

public class AddStudentCon implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		StudentDAO dao = new StudentDAO();
		
		// get value from request
		String stu_id = req.getParameter("stu_id");
		String stu_name = req.getParameter("stu_name");
		String stu_gender = req.getParameter("stu_gender");
		String stu_university = req.getParameter("stu_university").toUpperCase();
		String stu_class = req.getParameter("stu_class").toUpperCase();
		if(dao.addStudent(new Student(stu_id, stu_name, stu_gender, stu_university, stu_class, null)))
			resp.getWriter().write("success");
		
		return null;
	}

}
