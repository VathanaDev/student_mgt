package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
			case "/view_student.ktv":
				action = new ViewStudentCon();
				try{
					forward = action.execute(req, resp);
				}catch(Exception e){
					e.printStackTrace();
				}
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
