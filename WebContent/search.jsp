<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<title>Search</title>
</head>
<body style="background-color: blue">
<h1 align="center" style="color: white;margin-top: 100px">Search</h1><br>
<div align="center" style="background-color: skyblue;margin-left: 250px;margin-right: 250px;padding-top:30px;padding-bottom: 30px">
<h2>Search Book:</h2>
<form action="searchresult2.jsp">
	<input type="text" name ="query" id="field" placeholder="Enter Title, Author, Publisher, Subject" size="50">
	<input type="submit" value="Search">
</form>
<div>
</div>
</div>
</body>
</html>