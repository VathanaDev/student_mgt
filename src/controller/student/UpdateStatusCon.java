package controller.student;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import controller.Action;
import controller.ActionForward;
import model.dao.StudentDAO;
import model.dto.Student;

public class UpdateStatusCon implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		StudentDAO dao = new StudentDAO();
		
		// update
		dao.updateStatus(req.getParameter("stu_id"), req.getParameter("stu_status"));
		
		
		return null;
	}

}
