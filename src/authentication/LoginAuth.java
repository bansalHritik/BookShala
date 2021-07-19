package authentication;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/login")
public class LoginAuth extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection connection = null;
	PreparedStatement statement = null;
	String quString = null;
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException
	{
		//Checking in database
		try {
			//Taking data from user form
			String usernameString= req.getParameter("username");
			String passwordString = req.getParameter("password");
			//loading the drivers
			Class.forName("com.mysql.cj.jdbc.Driver");
			//establishment of Connection 
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
			//sql String To prevent ..... you know what.. ;-) 
			quString = "select * from users where username =?";
			//create statement
			statement = connection.prepareStatement(quString);
			//setting variable in prepared statement
			statement.setString(1,usernameString);
			ResultSet rSet = statement.executeQuery();
		
			//count no of users with the corresponding user name
			int userExist=0;
			int passwordMatched = 0;
			while(rSet.next())
			{
				userExist++;	
				if(rSet.getString("password").equals(passwordString))
				{
					passwordMatched = 1;
				}
			}
			
			if(userExist==1)
			{
				if(passwordMatched==1)
				{
					HttpSession session = req.getSession();
					session.setAttribute("username", req.getParameter("username"));
					RequestDispatcher rdDispatcher  = req.getRequestDispatcher("home.jsp");
					rdDispatcher.forward(req, res);
				}
				else {
					req.setAttribute("target_page","login.html");
					req.setAttribute("page", "Login Page");
					String msgeString = "Password Is Incorrect.";
					req.setAttribute("message",msgeString);
					RequestDispatcher dispatcher = req.getRequestDispatcher("autherror.jsp");
					dispatcher.forward(req, res);
				}
			}
			else {
				req.setAttribute("target_page","login.html");
				req.setAttribute("page", "Login Page");
				String msgeString = "No User Exist With This Username.";
				req.setAttribute("message",msgeString);
				RequestDispatcher dispatcher = req.getRequestDispatcher("autherror.jsp");
				dispatcher.forward(req, res);
			}
		} catch (Exception e) {
			
			req.setAttribute("target_page","login.html");
			req.setAttribute("page", "Login Page");
			String msgeString = "Sorry! Somethong went Wrong.";
			req.setAttribute("message",msgeString);
			RequestDispatcher dispatcher = req.getRequestDispatcher("autherror.jsp");
			dispatcher.forward(req, res);
		}
	}
}