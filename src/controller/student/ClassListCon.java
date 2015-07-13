package controller.student;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import controller.Action;
import controller.ActionForward;
import model.dao.StudentDAO;

public class ClassListCon implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		StudentDAO dao = new StudentDAO();
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		
		String list = new Gson().toJson(dao.getClassList());
		// write
		resp.getWriter().write(list);
		
		return null;
	}

}
