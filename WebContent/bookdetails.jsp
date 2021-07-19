<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
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
<style>
		.fit-image{
					
					
					height: 300px; /* only if you want fixed height */
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
      <li class="nav-item active">
        <a class="nav-link" href="home.jsp">Home</a>
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
<!--To Prevent Invalid Actions  -->
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
<%!
Connection connection = null;
PreparedStatement statement = null;
PreparedStatement statement2 = null;
String titleString = "";
String subject = "";
String publisherString ="";
String category = "";
String details = "";
String authorString ="";
int price = 0;
int edition = 0;
int id= 0;
String bookOwner;
String emailString;
String mobNumber;
%>
<%
try
{
	id= Integer.parseInt(request.getParameter("id"));
	
	if(id>0)
	{
		Class.forName("com.mysql.cj.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
		statement = connection.prepareStatement("Select * from books where id = ? ");
		statement.setInt(1, id);
		ResultSet rSet =statement.executeQuery();
		if(rSet.next())
			{
				titleString = rSet.getString("title");
				subject = rSet.getString("subject");
				publisherString = rSet.getString("publisher");
				category = rSet.getString("category");
				price = rSet.getInt("price");
				details = rSet.getString("description");
				authorString = rSet.getString("author");
				edition = rSet.getInt("edition");
				bookOwner = rSet.getString("username");
				PreparedStatement pre = connection.prepareStatement("select * from users where username = ?");
				pre.setString(1, bookOwner);
				ResultSet set = pre.executeQuery();
				if(set.next())
				{
					emailString = set.getString("email");
					mobNumber = set.getString("contactno");
				}
				else
				{
					emailString = "No Email Provided";
					mobNumber = "No Mobile Number Provided";
				}
		}
		else
		{
			request.setAttribute("message", "No Book With This Id or title ");
			request.setAttribute("next_page", "home.jsp");
			RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
			rd.forward(request, response);
		}
	}
}
catch(Exception e)
{
	e.printStackTrace();
	System.out.println(e.getMessage());
}
		
%>

<div class="container">
 <!-- Item Heading -->
  <h1 class="my-4">
  </h1>

  <!--Item Row -->
  <div class="row">

    <div class="col-md-4">
      <img class="img-fluid mx-auto d-block " src="disbook.jsp?id=<%=id%>" alt="">
    </div>

    <div class="col-md-8">
      <h3 class="my-3"><strong><%=titleString%></strong></h3>
      <p><%=details%></p>
      <h3 class="my-3"><b>Book Details</b></h3>
       <table class="table table-borderless table-striped">
    <tbody>
      <tr>
        <td>Author</td>
        <td><%=authorString%></td>
      </tr>
      <tr>
        <td>Publication</td>
        <td><%=publisherString %></td>
      </tr>
      <tr>
        <td>Edition</td>
        <td><%=edition %></td>
      </tr>
       <tr>
        <td>Category</td>
        <td><%=category %></td>
      </tr>
      <tr>
        <td>Subject</td>
        <td><%=subject %></td>
      </tr>
      <tr>
        <td>Price</td>
        <td><b>$<%=price %></b></td>
      </tr>
      <tr>
        <td>Owner's Email :</td>
        <td><b><%=emailString %></b></td>
      </tr>
      <tr>
        <td>Owner's Contact Number :</td>
        <td><b><%=mobNumber %></b></td>
      </tr>
    </tbody>
  </table>
    </div>

  </div>
  </div>
  <!-- /.row -->
  <!-- Related Projects Row -->
   <hr><h3 class="my-4">Related Books</h3>
  <%
  try{
  	statement2 = connection.prepareStatement("select * from books where id != ? and (subject like ? or category like ?) order by RAND() LIMIT 3");
  	statement2.setInt(1, id);
  	statement2.setString(2, "%"+subject+"%");
  	statement2.setString(3, "%"+category+"%");
  	ResultSet rSet2= statement2.executeQuery();
	//img-responsive fit-image 
	if(rSet2.next())
	{
	out.println("<div class=\"container\">");
	out.println("<div class=\"row\">");
	do
	{
		int id = rSet2.getInt("id");
		String titleString = rSet2.getString("title"); 
		/* out.println("<div class=\"col-md-3 col-sm-6 mb-4\">");
		out.println("<a href=\"#\"><img class=\"img-fluid\" src=\"\" alt=\"\"></a>");
		out.println("</div>");
		out.println(); */
		out.println("<div class=\"col-md-4\">");
		out.println("<div class=\"card mb-4 box-shadow\">");
		out.println("<a class=\"link\" href=\"bookdetails.jsp?id="+id+"\"><img class=\"card-img-top fit-image\" src=\"disbook.jsp?id="+id+"\" alt=\"Book Image \" width=\"100%\"></a>");
		out.println("<div class=\"card-body\">");
		out.println("<a class=\"card-link\" href=\"bookdetails.jsp?id="+id+"\"><p class=\"card-text\">"+titleString+"</p></a>");
		out.println("<div class=\"d-flex justify-content-between align-items-center\">");
		out.println("</div>");
		out.println("</div>");
		out.println("</div>"); 
		out.println("</div>");
	}
	while(rSet2.next());
	out.println("</div>"); 
	out.println("</div>");
	}
  }
catch(Exception e)
{
	e.printStackTrace();
	System.out.println(e.getMessage());
}
  %>

</body>
</html>