package authentication;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/checkOTP")
public class CheckOTP extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void service(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException
	{
		HttpSession session = req.getSession();
		String sysOtpString = session.getAttribute("otp").toString();
		String userotp = req.getParameter("otp");
		String newPasswordString = req.getParameter("newpassword");
		if(userotp.compareTo(sysOtpString)==0)
		{
			Connection connection = null;
			PreparedStatement statement = null;
			String usernameString = (String) session.getAttribute("username");
			
			try {
				//loading the drivers
				Class.forName("com.mysql.cj.jdbc.Driver");
				//establishment of Connection 
				connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
				//create statement
				statement = connection.prepareStatement("update users set password = ? where username = ?");
				//setting variable in prepared statement
				statement.setString(1,newPasswordString);
				statement.setString(2, usernameString);
				int updatedRows = statement.executeUpdate();
				if(updatedRows == 1)
				{
					session.setAttribute("password", newPasswordString);
					RequestDispatcher rDispatcher = req.getRequestDispatcher("home.jsp");
					rDispatcher.forward(req, res);
				}
				else {
					req.setAttribute("errorHeading", "Cant Update Password");
					req.setAttribute("errorMessage", "Something wrong happened");
					RequestDispatcher rDispatcher = req.getRequestDispatcher("autherror.jsp");
					rDispatcher.forward(req, res);
				}
			}
			catch (Exception e) {
				// TODO: handle exception
			}
			
		}
		else {
			req.setAttribute("errorHeading", "OTP Does Not Match");
			req.setAttribute("errorMessage", "You Have Entered Wrong OTP, Check Your OTP again and retry.");
			RequestDispatcher rDispatcher = req.getRequestDispatcher("autherror.jsp");
			rDispatcher.forward(req, res);
		}
	}
}