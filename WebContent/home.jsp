<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String username = (String) session.getAttribute("username");
	String password = (String) request.getAttribute("password");
	if ((username.isBlank() || username == null) && (password.isBlank() || password == null)) {
		request.setAttribute("next_page", "login.html");
		request.setAttribute("message", "Invalid Access ");
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
<title>Home | <%=username%></title>
<style>
.fit-image {
	width: 100%;
	object-fit: cover;
	height: 200px; /* only if you want fixed height */
}
</style>
</head>
<body style="background-color: #f0e7d8">
	<nav
		class="navbar navbar-expand-lg navbar-static-top  navbar-dark bg-dark">
		<a class="navbar-brand" href="home.jsp">BookShala</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<form class="form-inline my-2 my-lg-0 ml-auto" method="post"
				action="searchresult2.jsp">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search a book here .." aria-label="Search" size="60"
					name="query">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a class="nav-link" href="#">Home<span
						class="sr-only">(current)</span></a></li>
				<li class="nav-item"><a class="nav-link" href="newBook.jsp">New
						Book</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Asset</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="#"><%=username%>
						<img src="display.jsp" width="30" height="30"
						class="d-inline-block align-top" alt=""> </a></li>
			</ul>
		</div>
	</nav>


	<!-- navigation ends here -->
	<%
		Connection connection = null;
		PreparedStatement statement = null;
		Statement statement2 = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik", "root", "7792075538");
			statement2 = connection.createStatement();
			ResultSet rSet = statement2.executeQuery("select * from users where username='" + session.getAttribute("username") + "'");
			rSet.next();
			String cityString = rSet.getString("city");
			System.out.println(cityString);
			boolean isBookAvailable = false;
			//books according to city
			statement = connection.prepareStatement("select * from (select books.id,users.city,books.title from books inner join users on books.username = users.username) as t where city = ?  ");
			statement.setString(1,cityString);
			ResultSet rSet2 = statement.executeQuery();
			if (rSet2.next()) {
				
				isBookAvailable = true;
				out.println("<div class=\"container \">");
				out.println("<h3 class=\"mt-3\">Books You Might Be Interested In:</h3>");
				out.println("<hr>");
				out.println("</div>");
				out.println("<div class=\"container\">");
				out.println("<h5>Books In Your City</h5><br>");
				out.println("<div class=\"row\">");
				do {
					int id = rSet2.getInt("id");
					String titleString = rSet2.getString("title");
					titleString = titleString.toUpperCase();
					out.println("<div class=\"col-md-4\">");
					out.println("<div class=\"card mb-4 box-shadow\" style=\"background-color:#f0e7d8\">");
					out.println("<a class=\"link\" href=\"bookdetails.jsp?id=" + id
							+ "\"><img class=\"card-img-top fit-image\" src=\"disbook.jsp?id=" + id
							+ "\" alt=\"Book Image \" width=\"100%\"></a>");
					out.println("<div class=\"card-body\">");
					out.println("<a class=\"card-link\" href=\"bookdetails.jsp?id=" + id
							+ "\"><p class=\"card-text\" style=\"text-align:left\">" + titleString + "</p></a>");
					out.println("<div class=\"d-flex justify-content-between align-items-center\">");
					out.println("</div>");
					out.println("</div>");
					out.println("</div>");
					out.println("</div>");
				} while (rSet2.next());
				out.println("</div>");
				out.println("</div>");
			}
			if (!isBookAvailable) {
				
				out.println("<div class=\"container \">");
				out.println("<h3 class=\"mt-3\">No Book According To Your Details :</h3>");
				out.println("<hr>");
				out.println("</div>");
			}
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			connection.close();
		}
	%>
</body>
</html>
