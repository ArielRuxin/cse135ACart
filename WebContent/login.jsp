<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ACart: Login</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">
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
                    <li><a href="signup.jsp">New User? Sign up here!</a></li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
    </nav>
    <!-- end of nav bar -->
    
	<div class="container">
	<div class="row">	
	<form class="form-horizontal" role="form" action="login-res.jsp" method="GET">
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<p></p>
			</div>
		</div>
	   <div class="form-group">
	      <label for="firstname" class="col-sm-2 control-label">User Name</label>
	      <div class="col-sm-10">
	         <input name="username" type="text" class="form-control" id="firstname" placeholder="Please Enter Your User Name">
	         <span class="help-block">no password required</span>
	      </div>
	   </div>
	   <div><input type="hidden" name ="action" value="checkuser"/></div>
	   <div class="form-group">
	      <div class="col-sm-offset-2 col-sm-10">
	         <div class="checkbox">
	            <label>
	               <input type="checkbox"> Remember me
	            </label>
	         </div>
	      </div>
	   </div>
	   <div class="form-group">
	      <div class="col-sm-offset-2 col-sm-10">
	         <button type="submit" class="btn btn-default">Login</button>
	      </div>
	   </div>
	</form>
	</div>
	</div>
	
	
	
	
	
	
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
</body>
</html>