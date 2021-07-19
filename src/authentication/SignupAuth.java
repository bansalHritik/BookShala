package authentication;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/signup")
@MultipartConfig(maxFileSize = 1677731600)
public class SignupAuth extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException
	{
		
		Connection connection = null;
		PreparedStatement preparedStatement1 = null;
		PreparedStatement preparedStatement = null;
		ResultSet rSet = null;
		int count = 0;
		InputStream inputStream = null;
		//variable assignment respective to their parameter
		//can use hash map
		HttpSession session = req.getSession();
		String usernameString="",nameString="",passwordString="",emailString="",instituteString="",addressString="",cityString="",contactnoString="",branchString="";
		try {
			usernameString= session.getAttribute("username").toString().trim().toLowerCase();
			nameString = session.getAttribute("name").toString().trim().toLowerCase();
			passwordString = session.getAttribute("password").toString().trim().toLowerCase();
			emailString = session.getAttribute("email").toString().trim().toLowerCase();
			instituteString = req.getParameter("institute").toString().trim().toLowerCase();
			addressString = req.getParameter("address").toString().trim().toLowerCase();
			cityString = req.getParameter("city").toString().trim().toLowerCase();
			contactnoString = req.getParameter("phoneno").toString().trim().toLowerCase();
			branchString = req.getParameter("specialization").toString().trim().toLowerCase();
		} catch (Exception e) {
			String messString = "Something Went Wrong..";
			req.setAttribute("message",messString);
			req.setAttribute("target_page","signup.html");
			RequestDispatcher dispatcher = req.getRequestDispatcher("autherror.jsp");
			dispatcher.forward(req, res);
		}
		
		if(!nameString.isEmpty() && !passwordString.isEmpty() &&!instituteString.isEmpty()  && !addressString.isEmpty() && !cityString.isEmpty() &&!contactnoString.isEmpty()  &&!emailString.isEmpty() && !usernameString.isEmpty() && !branchString.isEmpty())
		{
			//Checking in database
			try {
					//loading the drivers
					Class.forName("com.mysql.cj.jdbc.Driver");
					
					//establishment of Connection 
					connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
					
					//create statement
					preparedStatement1= connection.prepareStatement("select * from users where username = ? and email = ?");
					preparedStatement1.setString(1,usernameString);
					preparedStatement1.setString(2,emailString );
					
					//execute query
					rSet = preparedStatement1.executeQuery();
					
					//number of rows in result set
					while(rSet.next()){count++;	}
					Part part = req.getPart("pic");
					//if no user name with the provided user name then register the provided user name
					if(count==0)
					{
						preparedStatement = connection.prepareStatement("insert into users values(?,?,?,?,?,?,?,?,?,?)");
						preparedStatement.setString(1, nameString);
						preparedStatement.setString(2,usernameString);
						preparedStatement.setString(3, passwordString);
						preparedStatement.setString(4, branchString);
						preparedStatement.setString(5, instituteString);
						preparedStatement.setString(6, addressString);
						preparedStatement.setString(7, cityString);
						preparedStatement.setString(8, contactnoString);
						preparedStatement.setString(9, emailString);
						if(part.getSize()!=0)
						{
							inputStream= part.getInputStream();
							preparedStatement.setBlob(10, inputStream);
						}
						else 
						{
							
									File image  = new File("C:\\Users\\sites\\NewWorkspace\\bookShare\\images\\noprofile.jpg");
									
									inputStream = new FileInputStream(image);
									
									preparedStatement.setBinaryStream(10, (InputStream) inputStream, (int)(image.length()));
						}
						
						//no_of_updated rows
						int updated_rows = preparedStatement.executeUpdate();
						System.out.println(updated_rows+"new user added");
						if(updated_rows ==1)
						{
							//success and redirect to home page with the particular user
							session.setAttribute("username",usernameString);
							RequestDispatcher dispatcher = req.getRequestDispatcher("home.jsp");
							dispatcher.forward(req, res);
						}
						else 
						{
							//redirect to error page
							String messString = "Something Went Wrong.\nCan't Insert Data.";
							req.setAttribute("message",messString);
							req.setAttribute("target_page","signup.html");
							RequestDispatcher dispatcher = req.getRequestDispatcher("autherror.jsp");
							dispatcher.forward(req, res);
						}
					}
					
					//error due to an existing user..
					else 
					{
						req.setAttribute("message","A User Exist With This Username.");
						req.setAttribute("target_page", "signup.html");
						RequestDispatcher dispatcher = req.getRequestDispatcher("autherror.jsp");
						dispatcher.forward(req, res);
					}
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				System.out.print(e.getMessage());
			}		
	}
	else
	{
			req.setAttribute("message","Something Tricky Just Happened.");
			req.setAttribute("target_page", "signup.html");
			RequestDispatcher dispatcher = req.getRequestDispatcher("autherror.jsp");
			dispatcher.forward(req, res);
	}		
	}
}