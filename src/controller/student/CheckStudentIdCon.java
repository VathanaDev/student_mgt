package controller.student;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import controller.ActionForward;
import model.dao.StudentDAO;

public class CheckStudentIdCon implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		StudentDAO dao = new StudentDAO();
		
		String id = req.getParameter("stu_id");
		if(dao.checkStudentId(id))
			resp.getWriter().write(id);
		
		
		return null;
	}

}
