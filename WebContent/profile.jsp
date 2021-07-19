<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<body style="background-color:#f0e7d8">
<!-- since it is a nav bar it is in the class of nav bar  -->
	<!-- navbar-expand-sm means that when the navbar should expend  -->
	<!-- others are only for colour purpose -->
<nav class="navbar navbar-expand-lg navbar-static-top  navbar-dark bg-dark">
  <a class="navbar-brand" href="home.jsp">BookShala</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
  	 <form class="form-inline my-2 my-lg-0 ml-auto" method="post" action="searchresult2.jsp">
      <input class="form-control mr-sm-2" type="search" placeholder="Search a book here .." aria-label="Search" size="60" name="query">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
    <ul class="navbar-nav ml-auto">
      <li class="nav-item ">
        <a class="nav-link" href="home.jsp">Home<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="newBook.jsp">New Book</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="asset.jsp">Asset</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="logout.jsp">Logout</a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="profile.jsp"><%=session.getAttribute("username")%>
    	<img src="display.jsp" width="30" height="30" class="d-inline-block align-top" alt="">
    	<span class="sr-only">(current)</span>
    </a>
      </li>
    </ul>
  </div>
</nav>
<!-- navigation ends here -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<%
	String username = (String)session.getAttribute("username");
	if((username==null)|| username=="")
	{
		request.setAttribute("message", "Invalid Access ");
		request.setAttribute("next_page", "login.html");
		RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
		rd.forward(request, response);
	}
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
	PreparedStatement statement = con.prepareStatement("Select * from users where username = ? ");
	statement.setString(1, username);
	ResultSet rsetResultSet = statement.executeQuery();
	String name="",institute="",Address="",city="",contact="",mailString="";
	while(rsetResultSet.next())
	{
	name = rsetResultSet.getString("name");
	institute  = rsetResultSet.getString("institute");
	Address  = rsetResultSet.getString("address");
	city  = rsetResultSet.getString("city");
	contact  = rsetResultSet.getString("contactno");
	mailString  = rsetResultSet.getString("email");
	}
	%>
	<div class="container border border-dark mt-3" style="background-color:#ece5a6">
		<div class="row border border-secondary">
			<div class="col" style="background-color:#f0c78f">
				<p class="display-4 text-center">Profile Info</p>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-5 border border-warning order-sm-2" style="overflow: auto" align="center">
					<img src="display.jsp?username=<%=username%>" alt="Ritik Bansal" class="rounded-circle img-fluid">
			</div>
			<div class="col-sm-7 border border-danger align-items-sm-start order-sm-1 text-center" style="padding-top: 10%;overflow: auto" >
					<h4><strong>Name : </strong><%out.print(name); %><br> </h4>
					<h4><strong>User-name : </strong><%out.print(username); %><br> </h4>
					<h4><strong>Institute : </strong><%out.print(institute); %><br> </h4>
					<h4><strong>Address : </strong><%out.print(Address); %><br></h4>
					<h4><strong>Mobile Number : </strong><%out.print(name); %><br></h4>
					<h4><strong>E-mail : </strong><%out.print(mailString); %><br></h4>
			</div>
		</div>
	</div>
</body>
</html>