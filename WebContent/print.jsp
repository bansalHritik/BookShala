<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<title>Try</title>
</head>
<body>
	<%
Connection connection = null;
ResultSet rSet = null;
try
{
	Class.forName("com.mysql.cj.jdbc.Driver");
	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
	String sql = "select name from users";
	PreparedStatement preparedStatement = connection.prepareStatement(sql);
	rSet = preparedStatement.executeQuery();
	while(rSet.next())
	{
		out.println("<h2 style = \"color:blue\">");
		out.print(rSet.getString(1));
		out.println("</h2>");
	}
}
catch(Exception e)
{
	
}
%>
</body>
</html>