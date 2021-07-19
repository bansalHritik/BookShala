<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<!-- A meta tag that redirects after 5 seconds -->
<meta http-equiv="Refresh" content="1;url=/bookShare/<%=request.getAttribute("target_page")%>">
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<title>Oops..</title>
</head>
<body style="background-color: blue">
<h1 align="center" style="color: white;margin-top: 50px">${message}</h1><br>
<h1 align="center" style="color: white;margin-top: 50px">Taking You To ${page}</h1><br>
<div align="center" style="background-color: skyblue;margin-left: 250px;margin-right: 250px;padding-top:30px;padding-bottom: 30px">
</div>
</body>
</html>
