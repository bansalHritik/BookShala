<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <% 
        		String booknameString = (String)request.getParameter("query").trim().toLowerCase();
				String username = (String)session.getAttribute("username");
				if((username.isBlank() || username==null))
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
	<title>Search Result | <%=booknameString %></title>
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
  	 <form class="form-inline my-2 my-lg-0 ml-auto">
      <input class="form-control mr-sm-2" type="search" placeholder="Search a book here .." aria-label="Search" size="60" name="query">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
    <ul class="navbar-nav ml-auto">
     <li class="nav-item active">
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
	ResultSet rSet  = null;
	String sql = "";
	String message = "";
	PreparedStatement statement = null;
	if(!booknameString.isBlank())
	{
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
			statement = connection.prepareStatement("select * from books where title like ? or author like ? or subject like ? or publisher like ?  ");
			statement.setString(1,"%"+booknameString+"%");
			statement.setString(2, "%"+booknameString+"%");
			statement.setString(3, "%"+booknameString+"%");
			statement.setString(4, "%"+booknameString+"%");
			rSet = statement.executeQuery();
			if(rSet.next())
			{
			out.println("<div class=\"container \">");
			out.println("<h3 class=\"mt-3\">Books Related To "+booknameString+" :</h3>");
			out.println("<hr>");
			out.println("</div>");
				int id = rSet.getInt("id");
				out.println("<div class=\"container\">");
				out.println("<div class=\"row\">");
				do
				{
					String titleString = rSet.getString("title"); 
					int idbook = rSet.getInt("id");
					out.println("<div class=\"col-md-4\">");
					out.println("<div class=\"card mb-4 box-shadow\">");
					out.println("<a class=\"link\" href=\"bookdetails.jsp?id="+id+"\"><img class=\"img-responsive fit-image\" src=\"disbook.jsp?id="+idbook+"\" alt=\"Book Image \" width=\"100%\"></a>");
					out.println("<div class=\"card-body\">");
					out.println("<a class=\"card-link\" href=\"bookdetails.jsp?id="+id+"\"><p class=\"card-text\">"+titleString+"</p></a>");
					out.println("<div class=\"d-flex justify-content-between align-items-center\">");
					
					out.println("</div>");
					out.println("</div>");
					out.println("</div>"); 
					out.println("</div>");
				}
				while(rSet.next());
				out.println("</div>"); 
				out.println("</div>");
			}
			else
			{
				out.println("<div class=\"container\">");
				out.println("<h3>No Books With This Keyword</h3>");
				out.println("</div>");
				response.setHeader("refresh", "5,home.jsp");
			}
		}
		catch(Exception e)
		{
			message = "Error : "+e.getMessage();
			System.out.println(message);
			e.printStackTrace();
		}
	}
	else
	{
		request.setAttribute("message", "Enter A Valid KeyWord");
		request.setAttribute("next_page", "home.jsp");
		RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
		rd.forward(request, response);
	}
	%>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>