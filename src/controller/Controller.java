package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.student.AddStudentCon;
import controller.student.CheckStudentIdCon;
import controller.student.ClassListCon;
import controller.student.DeleteStudentCon;
import controller.student.SearchStudentCon;
import controller.student.UpdateStatusCon;
import controller.student.UpdateStudentCon;
import controller.student.ViewStudentByIdCon;
import controller.student.ViewStudentCon;

@WebServlet("*.ktv")
public class Controller extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req, resp);
	}
	
	protected void doAction(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException{
		// get URI
		String URI = req.getRequestURI();
		// get context path
		String contextPath = req.getContextPath();
		// get command
		String cmd = URI.substring(contextPath.length());
		// create action object
		Action action = null;
		// create action forward object
		ActionForward forward = null;
		
		switch(cmd){
			case "/getClassList.ktv":
				action = new ClassListCon();
				try{
					forward = action.execute(req, resp);
				}catch(Exception e){
					e.printStackTrace();
				}
				break;
			case "/viewStudent.ktv":
				action = new ViewStudentCon();
				try{
					forward = action.execute(req, resp);
				}catch(Exception e){
					e.printStackTrace();
				}
				break;
			case "/viewStudentById.ktv":
				action = new ViewStudentByIdCon();
				try{
					forward = action.execute(req, resp);
				}catch(Exception e){
					e.printStackTrace();
				}
				break;
			case "/searchStudent.ktv":
				action = new SearchStudentCon();
				try{
					forward = action.execute(req, resp);
				}catch(Exception e){
					e.printStackTrace();
				}
				break;
			case "/updateStatus.ktv":
				action = new UpdateStatusCon();
				try{
					forward = action.execute(req, resp);
				}catch(Exception e){
					e.printStackTrace();
				}
				break;
			case "/checkStudentId.ktv":
				action = new CheckStudentIdCon();
				try{
					forward = action.execute(req, resp);
				}catch(Exception e){
					e.printStackTrace();
				}
				break;
			case "/addStudent.ktv":
				action = new AddStudentCon();
				try{
					forward = action.execute(req, resp);
				}catch(Exception e){
					e.printStackTrace();
				}
				break;
			case "/updateStudent.ktv":
				action = new UpdateStudentCon();
				try{
					forward = action.execute(req, resp);
				}catch(Exception e){
					e.printStackTrace();
				}
				break;
			case "/deleteStudent.ktv":
				action = new DeleteStudentCon();
				try{
					forward = action.execute(req, resp);
				}catch(Exception e){
					e.printStackTrace();
				}
				break;
			default:
				forward = new ActionForward();
				forward.setPath("404.jsp");
				forward.setRedirect(false);
				break;
		}
		
		if(forward != null){
			if(forward.isRedirect()){
				resp.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher rd = req.getRequestDispatcher(forward.getPath());
				rd.forward(req, resp);
			}
		}
	}
}
