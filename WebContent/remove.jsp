<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<% 
				String username = (String)session.getAttribute("username");
				
				if((username=="" || username==null))
				{
					request.setAttribute("message", "Invalid Access ");
					request.setAttribute("next_page", "login.html");
					RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
					rd.forward(request, response);
				}
%>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<meta http-equiv="Refresh" content="1,/bookShare/asset.jsp">
<title>Remove Book</title>
</head>
<body>
<%
Connection connection = null;
PreparedStatement statement = null;
String sql = "";
ResultSet resultSet = null;
int row=0;
String id =request.getParameter("id");
try
{
	
	String u =(String)session.getAttribute("username");
	System.out.println(u);
	System.out.println(id);
		Class.forName("com.mysql.cj.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
		sql = "delete from books where id = ? and username = ?";
		statement = connection.prepareStatement(sql);
		statement.setString(1,id);
		statement.setString(2, u);
		row = statement.executeUpdate();
		if(row==1)
		out.println("Book Removed SucessFully ");
}
catch(Exception e)
{
	System.out.println(e);
}
%>
</body>
</html>