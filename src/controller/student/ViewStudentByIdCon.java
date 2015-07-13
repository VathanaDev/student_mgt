package controller.student;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import controller.Action;
import controller.ActionForward;
import model.dao.StudentDAO;
import model.dto.Student;

public class ViewStudentByIdCon implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		StudentDAO dao = new StudentDAO();
		Student stu = dao.viewStudentById(req.getParameter("stu_id"));
		
		// get convert data to json
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		
		String article = new Gson().toJson(stu);
		resp.getWriter().write(article);
		return null;
	}

}
