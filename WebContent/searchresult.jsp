<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
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
<title>Insert title here</title>
</head>
<body>
<%
Connection connection = null;
ResultSet rSetTitle  = null;
ResultSet rsetAuthor = null;
ResultSet rsetPublisher = null;
ResultSet rsetCategory = null;
ResultSet rsetSubject = null;
String sql = "";
String message = "";
String string = request.getParameter("query");
Statement statement = null;
int title_count = 0;
int author_count = 0;
int publisher_count = 0;
int subject_count = 0;
int category_count = 0;
try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	System.out.println("Driver loaded");
	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
	System.out.println("Connection Established");
	statement = connection.createStatement();
	sql = String.format("select * from books where title = '%s'",string);
	rSetTitle = statement.executeQuery(sql);
	statement = connection.createStatement();
	sql = String.format("select * from books where author = '%s'",string);
	rsetAuthor = statement.executeQuery(sql);
	statement = connection.createStatement();
	sql = String.format("select * from books where publisher = '%s'",string);
	rsetPublisher = statement.executeQuery(sql);
	statement = connection.createStatement();
	sql = String.format("select * from books where category = '%s'",string);
	rsetCategory = statement.executeQuery(sql);
	statement = connection.createStatement();
	sql = String.format("select * from books where subject = '%s'",string);
	rsetSubject = statement.executeQuery(sql);

}
catch(Exception e)
{
	message = "Error : "+e.getMessage();
	System.out.println(message);
	e.printStackTrace();
}

%>
<%
if(rSetTitle.next())
{
	out.println("<h2 align =\"center\">");
	out.print("Books By "+string+" Title ");
	out.print("<h2><div align =\"center\"");
	do
	{
		out.println("<p style=\"color:brown\">");
		out.println("Author : "+rSetTitle.getString("title")+" | Subject : "+rSetTitle.getString("subject")+" | Price : "+rSetTitle.getString("price")+" | By User : "+rSetTitle.getString("username")+" | Publisher : "+rSetTitle.getString("publisher"));
		out.println("<p>");
	}
	while(rSetTitle.next());
}
if(rsetAuthor.next())
{
	out.println("<h2 align =\"center\">");
	out.print("Books By "+string+" Author ");
	out.print("<h2><div align =\"center\"");
	do
	{
		out.println("<p style=\"color:brown\">");
		out.println("Title : "+rsetAuthor.getString("title")+" | Subject : "+rsetAuthor.getString("subject")+" | Price : "+rsetAuthor.getString("price")+" | By User : "+rsetAuthor.getString("username")+" | Publisher : "+rsetAuthor.getString("publisher"));
		out.println("<p>");
	}
	while(rsetAuthor.next());
}
if(rsetPublisher.next())
{
	out.println("<h2 align =\"center\">");
	out.print("Books By "+string+" Publisher ");
	out.print("<h2><div align =\"center\"");
	do
	{
		out.println("<p style=\"color:brown\">");
		out.println("Title : "+rsetPublisher.getString("title")+" | Subject : "+rsetPublisher.getString("subject")+" | Price : "+rsetPublisher.getString("price")+" | By User : "+rsetPublisher.getString("username")+" | Authpr : "+rsetPublisher.getString("author"));
		out.println("<p>");
	}
	while(rsetAuthor.next());
}
%>
</body>
</html>