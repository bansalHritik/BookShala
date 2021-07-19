package authentication;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/photo")
@MultipartConfig(maxFileSize = 16777316)
public class Imgupload extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {

		//variable initialization
		String nameString= request.getParameter("name");
		//for message
		String messageString = "";
		//for image 
		InputStream inputStream = null;  //input stream just means that you are receiving data that is in either format
		//get input file as part 
		Part part = request.getPart("pic"); //Part is a Interface that is used to store form data or files
		//if file is not null
		if(part!=null)
		{
			//just for fun
			System.out.println(part.getName());
			System.out.println(part.getContentType());
			System.out.println(part.getSubmittedFileName());
			
			//assigning input Stream
			inputStream = part.getInputStream();
			
			//
			try {
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
				
				String sql = "insert into photo values (?,?)";
				
				PreparedStatement statement = connection.prepareStatement(sql);
				
				statement.setString(1, nameString);
				statement.setBlob(2, inputStream);
				
				int result = statement.executeUpdate();
				if(result==1)
				{
					messageString = "SucessFully Inserted";
				}
				else {
					messageString = "Data Not Inserted";
				}
				} 
				catch (Exception e) {
					// TODO: handle exception
					messageString = "ERROR : "+e.getMessage();
				}
			finally {
				System.out.println(messageString);
			}
		}
	}
}
