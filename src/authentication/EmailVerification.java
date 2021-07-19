package authentication;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
	@WebServlet("/verification")
	public class EmailVerification extends HttpServlet 
	{
		private static final long serialVersionUID = 1L;
		public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException
		{
			String toemailString = req.getParameter("email");
			String nameString  = req.getParameter("name");
			String usernameString = req.getParameter("username");
			String passwordString = req.getParameter("password");
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
				session.setAttribute("password", passwordString);
				session.setAttribute("otp",OTPsent);
				session.setAttribute("username", usernameString);
				session.setAttribute("name", nameString);
				session.setAttribute("email", toemailString);
				RequestDispatcher rDispatcher = req.getRequestDispatcher("OTP.html");
				rDispatcher.forward(req, res);
			}		
	}
}