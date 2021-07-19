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
<meta http-equiv="Refresh" content="2;url=index.html">
<title>Insert title here</title>
</head>
<body>
<%
session.invalidate();
%>
<div>
<h1>Logging You Out </h1>
</div>
</body>
</html>