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
	@WebServlet("/forgotpassword")
	public class ForgotPassword extends HttpServlet 
	{
		private static final long serialVersionUID = 1L;
		public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException
		{
			Connection connection = null;
			PreparedStatement statement = null;
			String toemailString = req.getParameter("email");
			String nameString = "";
			String usernameString = "";
			try {
				//loading the drivers
				Class.forName("com.mysql.cj.jdbc.Driver");
				//establishment of Connection 
				connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
				//create statement
				statement = connection.prepareStatement("select * from users where email= ?");
				//setting variable in prepared statement
				statement.setString(1,toemailString);
				ResultSet rSet = statement.executeQuery();
				if (rSet.next()) {
					nameString = rSet.getString("name");
					usernameString = rSet.getString("username");
					int OTPsent = sendOTP.sendOTPto(nameString,usernameString, toemailString);
					HttpSession session = req.getSession();
					//if not sent
					if(OTPsent==0)
					{
						req.setAttribute("errorHeading", "OTP Not Sent!!!");
						req.setAttribute("errorMessage", "Something went wrong. Kindly check again in some time.");
						RequestDispatcher rDispatcher = req.getRequestDispatcher("autherror.jsp");
						rDispatcher.forward(req, res);
					}
					//if sent
					else {
						session.setAttribute("otp",OTPsent);
						session.setAttribute("username", usernameString);
						session.setAttribute("name", nameString);
						session.setAttribute("email", toemailString);
						RequestDispatcher rDispatcher = req.getRequestDispatcher("verifyOtp.html");
						rDispatcher.forward(req, res);
					}		
				}
				else {
					String messString = "No user with this mail.";
					req.setAttribute("message",messString);
					req.setAttribute("target_page","signup.html");
					RequestDispatcher dispatcher = req.getRequestDispatcher("autherror.jsp");
					dispatcher.forward(req, res);
				}
				
			}
			catch (Exception e) {
				// TODO: handle exception
				String messString = "Something Went Wrong.\nCan't Insert Data.";
				req.setAttribute("message",messString);
				req.setAttribute("target_page","signup.html");
				RequestDispatcher dispatcher = req.getRequestDispatcher("autherror.jsp");
				dispatcher.forward(req, res);
			}
	}
}