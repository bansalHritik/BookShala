<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width initial-scale=1.0">
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<title> Asset| </title>
<style>
		.fit-image{
					width: 100%;
					object-fit: cover;
					height: 200px; /* only if you want fixed height */
				  }
	</style>
</head>
<body>
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
        <a class="nav-link" href="home.jsp">Home</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="newBook.jsp">New Book</a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="asset.jsp">Asset<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="logout.jsp">Logout</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="profile.jsp"><%=session.getAttribute("username")%>
    	<img src="display.jsp" width="30" height="30" class="d-inline-block align-top" alt="">
    </a>
      </li>
    </ul>
  </div>
</nav>
<!-- navigation ends here -->
	<%
	Connection connection = null;
	PreparedStatement statement = null;
	ResultSet rSet = null;
	String sql= "";
	try{
		String username = (String)session.getAttribute("username");
		//to prevent invalid entry
		if((username==null)|| username=="")
			{
				request.setAttribute("message", "Invalid Access ");
				request.setAttribute("next_page", "login.html");
				RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
				rd.forward(request, response);
			}
		//database connection
		Class.forName("com.mysql.cj.jdbc.Driver");
		connection =  DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
		statement = connection.prepareStatement("Select * from books where username = ? ");
		statement.setString(1, username);
		rSet = statement.executeQuery();
		int count = 0;
		if(rSet.next())
		{	
			out.println("<div class=\"container mt-4\">");
			out.println("<h3>You Have Shared These Books</h3><hr>");
			out.println("<div class=\"row\">");
			do
			{
				count++;
				String titleString = rSet.getString("title"); 
				titleString = titleString.toUpperCase();
				int idbook = rSet.getInt("id");
				out.println("<div class=\"col-md-4\">");
				out.println("<div class=\"card mb-4 box-shadow\">");
				out.println("<a class=\"link\" href=\"bookdetails.jsp?id="+idbook+"\"><img class=\"img-responsive fit-image\" src=\"disbook.jsp?id="+idbook+"\" alt=\"Book Image \" width=\"100%\"></a>");
				out.println("<div class=\"card-body\">");
				out.println("<a class=\"card-link text-center mb-2\" href=\"bookdetails.jsp?id="+idbook+"\"><p class=\"card-text\" style=\"text-align:left\">"+titleString+"</p></a>");
				out.println("<div class=\"d-flex justify-content-between align-items-center\">");
				out.println("<div>");
				out.println("<a href=\"remove.jsp?id="+idbook+"\" class = \"card-link btn btn-primary btn-center mt-3 \" align=\"center\" >Remove Book</a>");
				out.println("</div>");
				out.println("</div>");
				out.println("</div>");
				out.println("</div>"); 
				out.println("</div>");
			}
			while(rSet.next());
			out.println("</div>"); 
			out.println("</div>");
		}
		
		
		/* out.println("<div class=\"container\">");
		out.println("<h1 class=\"display-3 text-center\">Your Assets</h1>");
		out.println("<hr class=\"h-100 mr-2\">");
		out.println("<div class=\"table-responsive\">");
		out.println("<table class=\"table table-striped table-bordered table-hover\">");
		out.println("<thead class=\"thead-dark\">");
		out.println("<tr>");	
		out.println("<th>Title</th>");		
		out.println("<th>Subject</th>");	
		out.println("<th>Author</th>");	
		out.println("<th>Category</th>");	
		out.println("<th>Edition</th>");
		out.println("<th>Price</th>");		
		out.println("<th>Remove Book</th>");		
		out.println("</tr>");	
		out.println("</thead>");	
		do
		{
			count++;
			out.println("<tr class=\"table-info\">");
			out.println("<td>"+rSet.getString("title")+"</td>");	
			out.println("<td>"+rSet.getString("subject")+"</td>");	
			out.println("<td>"+rSet.getString("author")+"</td>");	
			out.println("<td>"+rSet.getString("category")+"</td>");	
			out.println("<td>"+rSet.getInt("edition")+"</td>");	
			out.println("<td>"+rSet.getInt("price")+"</td>");	
			out.println("<td><form method=\"post\"  action =\"remove.jsp?id="+rSet.getInt("id")+"\" ><input type = \"submit\" value =\"Remove Book\"></form></td>");	
			out.println("</tr>");
		}
		while(rSet.next());
		out.println("</table>");
		out.println("</div>");
		out.println("</div>"); */
		if(count==0)
		{
			request.setAttribute("next_page", "home.jsp");
			request.setAttribute("message","You Have Not Provided Any Books ");
			RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
			rd.forward(request, response);
		}
			
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
 
 </body>
</html>