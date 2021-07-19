package authentication;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/otp")
public class OtpVerification extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void service(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException
	{
		HttpSession session = req.getSession();
		String sysOtpString = session.getAttribute("otp").toString();
		String userotp = req.getParameter("otp");
		if(userotp.compareTo(sysOtpString)==0)
		{
			RequestDispatcher rDispatcher = req.getRequestDispatcher("otherInfo.html");
			rDispatcher.forward(req, res);
			System.out.println("SuccessFully verified");
			
		}
		else {
			req.setAttribute("errorHeading", "OTP Does Not Match");
			req.setAttribute("errorMessage", "You Have Entered Wrong OTP, Check Your OTP again and retry.");
			RequestDispatcher rDispatcher = req.getRequestDispatcher("autherror.jsp");
			rDispatcher.forward(req, res);
		}
	}
}