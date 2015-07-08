package controller.student;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import controller.Action;
import controller.ActionForward;
import model.dao.StudentDAO;
import model.dto.Student;

public class ViewStudentCon implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		StudentDAO dao = new StudentDAO();
		ArrayList<Student> arr = null;
		
		// get data from dao
		if(req.getParameter("search_by") == null){
			arr = dao.viewStudent();
		}else{
			arr = dao.searchStudent(req.getParameter("search_by"), "keyword");
		}
		
		// get convert data to json
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		
		String article = new Gson().toJson(arr);
		resp.getWriter().write(article);
		
		return null;
	}

}
