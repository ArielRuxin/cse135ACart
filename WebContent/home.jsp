<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="indexpage for ACart">
    <meta name="author" content="Ariel&Charlie">

    <title>ACart: Online Shopping</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">

    <!-- Add custom CSS here -->
    <link href="css/navbarstyle.css" rel="stylesheet">
    <style>
    body {
        margin-top: 60px;
    }
    </style>

</head>
 <body>
 
     <!-- nav bar -->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="home.jsp"><i class="icon-home"></i> Home</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav">
               	<% 
            	if(session.getAttribute("username") == null) {
            	%>
            		<li class="dropdown">
                    <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">Hello! Login here <b class="caret"></b></a>
                    	<ul class="dropdown-menu">
							<li><a href="login.jsp"><i class="icon-group"></i> Login</a></li>
							<li><a href="signup.jsp"><i class="icon-pencil"></i> Sign up</a></li>
						</ul>
                    </li>
            	<%		
            	} else {
            		if(session.getAttribute("role").equals("Owner")) {
        		%>
        			<li class="dropdown">
                    <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">Hello <%= session.getAttribute("username") %> <b class="caret"></b></a>
                    	<ul class="dropdown-menu">
							<li><a href="categories.jsp">Manage categories</a></li>
							<li><a href="products.jsp">Manage products</a></li>
						</ul>
                    </li>
        		
        		<% 	} else { %>
        			
        			<li><a href="#">Hello <%= session.getAttribute("username") %></a></li>
        			
        			<%}
            	}
            
            %>                
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h2>Welcome to ACart online shopping!</h2>
            </div>
        </div>

    </div>
    <!-- /.container -->
    
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
 </body>
</html>