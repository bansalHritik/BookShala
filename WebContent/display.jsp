<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Blob"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <% 
				String username = (String)session.getAttribute("username");
				
				String password = (String)request.getAttribute("password");
				if((username=="" || username==null)&&( password=="" || password==null))
				{
					request.setAttribute("next_page", "login.html");
					request.setAttribute("message", "Invalid Access ");
					RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
					rd.forward(request, response);
				}
%>
	<%
	OutputStream oStream = null;
	//byte string for image
	byte[] image = null;//because arrays are implemented as objects
	//to recieve data from mysql
	Blob blob = null;
	//Connection object
	Connection connection = null;
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
		String sql = String.format("select profile from users where username = '%s'",username);
		
		Statement statement = connection.createStatement();
		ResultSet rSet = statement.executeQuery(sql);
		if(rSet.next())
		{
			blob = rSet.getBlob(1);
			
			if(blob!=null)
			{
				image= blob.getBytes(1, (int)blob.length());
			
				response.setContentType("image/jpg");
				
				oStream = response.getOutputStream();
				
				oStream.write(image);
				
				oStream.flush();
				
				oStream.close();
				return;
			}
			else
			{
				System.out.println(username+" has not provided Profile Photo ");
			}
			
		}
		else{
			System.out.println("Image Not Found");
		}
	}
	catch(Exception e)
	{
		System.out.println(e.getMessage());
		e.printStackTrace();
	}
	%>
</body>
</html>