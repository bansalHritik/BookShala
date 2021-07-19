package book;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
@WebServlet("/Newbook")
@MultipartConfig(maxFileSize = 1677711610)
public class NewBook extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		String name = "";
		String author = "";
		String publisher = "";
		int price=0,edition=1;
		String category = "";
		String description = "";
		String subject = "";
		HttpSession session = request.getSession();
		String username = (String)session.getAttribute("username");
		try {
			name = request.getParameter("Title").trim().toLowerCase();
		
			author = request.getParameter("Author").trim().toLowerCase();
			
			publisher = request.getParameter("Publisher").trim().toLowerCase();
			 
			category = request.getParameter("Category").trim().toLowerCase().toLowerCase();
			
			if(request.getParameter("Description")!=null)
				description = request.getParameter("Description").trim().toLowerCase();
			
			 subject = request.getParameter("Subject").trim().toLowerCase();
			 
			price = Integer.parseInt(request.getParameter("Price").trim());
			
			edition = Integer.parseInt(request.getParameter("Edition").trim());
			
			if(price<=0 && edition<=0 )
				throw (new Exception() );
		} catch (Exception e) {
			request.setAttribute("message", "Invalid price Or Edition ");
			request.setAttribute("next_page","newBook.jsp");
			RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
			rd.forward(request, response);
		}
		if (name!="" && author!="" && publisher!="" && category!="" && subject!="") {
		int updated_rows =0;
		
		try {
		
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
			
			//taking image as input i.e PART type(file type for form image)
			PreparedStatement statement2 = connection.prepareStatement("Insert into books(title,author,publisher,edition,subject,category,description,price,username,bookpic) values (?,?,?,?,?,?,?,?,?,?)");
			statement2.setString(1, name);
			statement2.setString(2, author);
			statement2.setString(3, publisher);
			statement2.setInt(4, edition);
			statement2.setString(5, subject);
			statement2.setString(6, category);
			statement2.setString(7, description);
			statement2.setInt(8, price);
			statement2.setString(9, username);
			Part part = request.getPart("bookpic");
			if(part.getSize()==0)
			{
				File image  = new File("C:\\Users\\sites\\NewWorkspace\\bookShare\\images\\defaultImage.jpg");
				FileInputStream inputStream = new FileInputStream(image);
	            statement2.setBinaryStream(10, (InputStream) inputStream, (int)(image.length()));
	            updated_rows = statement2.executeUpdate();
			}
			else {
				InputStream inputStream = part.getInputStream();
				statement2.setBlob(10, inputStream);
				updated_rows = statement2.executeUpdate();
			}
			if(updated_rows==0)
			{
				request.setAttribute("next_page", "newBook.jsp");
				request.setAttribute("message","Can't Insert Your Book due to some internal failure ");
				RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
				rd.forward(request, response);
			}
			else {
				request.setAttribute("next_page", "home.jsp");
				request.setAttribute("message","Sucessfully Published Your Book");
				RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
				rd.forward(request, response);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
			request.setAttribute("next_page", "newBook.jsp");
			request.setAttribute("message","Some Thing Went Wrong");
			RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
			rd.forward(request, response);
		}
	}
	}
}