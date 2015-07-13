package controller.student;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import controller.ActionForward;
import model.dao.StudentDAO;

public class DeleteStudentCon implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {

		StudentDAO dao = new StudentDAO();
		if(dao.deleteStudent(req.getParameter("stu_id")))
			resp.getWriter().write("success");
		return null;
	}

}
