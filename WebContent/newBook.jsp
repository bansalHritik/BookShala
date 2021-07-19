<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
	/* Connection connection = null;
	Statement statement = null;
	ResultSet rSet = null; */
	String sql= "";
	try{
		String username = (String)session.getAttribute("username");
		if((username==null)|| username=="")
			{
				request.setAttribute("next_page", "login.html");
				request.setAttribute("message", "Invalid Access ");
				RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
				rd.forward(request, response);
			}
	}
	catch(Exception e)
	{
		System.out.println(e);
	}
%>
<html>
<head>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width initial-scale=1.0">
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<title>New Book</title>
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
        <a class="nav-link" href="home.jsp">Home</a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="newBook.jsp">New Book<span class="sr-only">(current)</span></a>
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
<div class="container mb-4">
    <form class="form-horizontal" role="form" method="POST" action="Newbook" enctype="multipart/form-data">
        <div class="row">
            <!-- <div class="col-md-1"></div> -->
            <div class="col-md-12">
                <h2 class="text-center display-3">Add New Book</h2>
                <hr>
                <p class="text-center">All <strong style="color: red">*</strong> are Required</p>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 field-label-responsive">
                <label for="name" style="float: right;">Title <strong style="color: red">*</strong></label>
            </div>
            <div class="col-md-10">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-user"></i></div>
                        <input type="text" name="Title" class="form-control" placeholder="Enter Book Title" required autofocus>
                             
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 field-label-responsive">
                <label for="email" style="float: right;">Author <strong style="color: red">*</strong></label>
            </div>
            <div class="col-md-10">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-at"></i></div>
                        <input type="text" name="Author" class="form-control" placeholder="Enter Book Author" required autofocus>
                    </div>
                </div>
            </div>
        </div>
         <div class="row">
            <div class="col-md-2 field-label-responsive">
                <label for="email" style="float: right;">Publisher <strong style="color: red">*</strong></label>
            </div>
            <div class="col-md-10">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-at"></i></div>
                        <input type="text" name="Publisher" class="form-control" placeholder="Enter Book Publisher" required autofocus>
                              
                    </div>
                </div>
            </div>
        </div>
         <div class="row">
            <div class="col-md-2 field-label-responsive">
                <label for="email" style="float: right;">Edition <strong style="color: red">*</strong> </label>
            </div>
            <div class="col-md-10">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-at"></i></div>
                        <input type="number" name="Edition" class="form-control" min="1" placeholder="Enter Edition " required autofocus>
                               
                    </div>
                </div>
            </div>
        </div>
         <div class="row">
            <div class="col-md-2 field-label-responsive">
                <label for="email" style="float: right;">Branch <strong style="color: red">*</strong></label>
            </div>
            <div class="col-md-10">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-at"></i></div>
                        <input type="text" name="Subject" class="form-control" placeholder="Enter Book Subject" required autofocus>        
                    </div>
                </div>
            </div>
        </div>
         <div class="row">
            <div class="col-md-2 field-label-responsive">
                <label for="email" style="float: right;">Category <strong style="color: red">*</strong></label>
            </div>
            <div class="col-md-10">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-at"></i></div>
                        <input type="text" name="Category" class="form-control" placeholder="Enter Book Category" required autofocus>
                              
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 field-label-responsive">
                <label for="password" style="float: right;">Price <strong style="color: red">*</strong></label>
            </div>
            <div class="col-md-10">
                <div class="form-group has-danger">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-key"></i></div>
                        <input type="number" name="Price" class="form-control" placeholder="Enter Price" min ="0" required>          
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 field-label-responsive">
                <label for="password" style="float: right;">Description(max 100 words)</label>
            </div>
            <div class="col-md-10">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem">
                            <i class="fa fa-repeat"></i>
                        </div>
                        <textarea  name="Description" class="form-control" placeholder="Enter Description here"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 field-label-responsive">
                <label for="password" style="float: right;">Image</label>
            </div>
            <div class="col-md-10">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem">
                            <i class="fa fa-repeat"></i>
                        </div>
                        <input type="file" accept="image/*" name="bookpic">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-10">
                <button type="submit" class="btn btn-success btn-block"><i class="fa fa-user-plus"></i>Add Book</button>
            </div>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>