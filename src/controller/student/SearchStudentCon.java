package controller.student;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import controller.Action;
import controller.ActionForward;
import model.dao.StudentDAO;
import model.dto.Student;

public class SearchStudentCon implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		StudentDAO dao = new StudentDAO();
		
		// get value from request
		String stu_name = "";
		String stu_class = "";
		String stu_status = "";
		
		if(req.getParameter("stu_name") != null)
			stu_name = req.getParameter("stu_name");
		
		if(req.getParameter("stu_class") != "")
			stu_class = req.getParameter("stu_class");
		
		if(req.getParameter("stu_status") != "")
			stu_status = req.getParameter("stu_status");
		
		String class_status = "";
		if(!stu_class.equals("all"))
			class_status += " AND stu_class='"+stu_class+"'";
		
		if(!stu_status.equals("all"))
				class_status += " AND stu_status='"+stu_status+"'";
		
		ArrayList<Student> arr = dao.searchStudent(stu_name, class_status);
		
		// get convert data to json
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		
		String article = new Gson().toJson(arr);
		resp.getWriter().write(article);
		return null;
	}

}
