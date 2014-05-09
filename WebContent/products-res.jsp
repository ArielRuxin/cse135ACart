<%@ page import="java.sql.*" import="java.util.*, cartitem.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Ariel&Charlie">

    <title>ACart: Add product</title>

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
               	<% 
            	if(session.getAttribute("username") == null) {
            	%>
            		<li class="dropdown">
                    <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">Hello! Login here <b class="caret"></b></a>
                    	<ul class="dropdown-menu">
							<li><a href="login.jsp"><i class="icon-user"></i> Login</a></li>
							<li><a href="signup.jsp"><i class="icon-pencil"></i> Sign up</a></li>
						</ul>
                    </li>
            	<%		
            	} else {
            	%>	
            		<li class="dropdown">
                    <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">Hello <%= session.getAttribute("username") %> <b class="caret"></b></a>
                    	<ul class="dropdown-menu">
            		
            	<% 	if(session.getAttribute("role").equals("Owner")) {
        		%>       			
							<li><a href="categories.jsp">Manage categories</a></li>
							<li><a href="products.jsp">Manage products</a></li>
					        		
        		<% 	} else { %>
        		
        			       	<li><a href="product-browse.jsp">Shopping</a></li>				
        			
        			<%}%>       					
        					<li><a href="login.jsp">Log out</a></li>
        				</ul>
                    </li>
               
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

<div class="container">
<div class="row">
<div class="col-lg-12">
		
            <%
            if (request.getParameter("action")==null) {
        		%>
        		<a href="login-res.jsp"> Please try to manage products </a>
        		<%
        	} else {
        	
        	
        		String productname = request.getParameter("name"); 
        		session.setAttribute("productname", productname); 
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rsCate = null;
            
            try {
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");

                // Open a connection to the database using DriverManager
                conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost/cse135?" +
                    "user=postgres&password=Hh_2010");
            %>
            
            <%-- -------- INSERT Code -------- --%>
            <%
                String action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("insert")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // INSERT student values INTO the students table.
                    pstmt = conn
                            .prepareStatement("INSERT INTO products (name, sku, categoryid, price) VALUES (?, ?, ?, ?)");

                    if(!request.getParameter("name").equals("")){
                    	pstmt.setString(1, request.getParameter("name"));
                    }
                    if(!request.getParameter("sku").equals("")){
                        pstmt.setString(2, request.getParameter("sku"));
                    }
                    
                 	pstmt.setInt(3, Integer.parseInt(request.getParameter("categoryid")));
                 	if(!request.getParameter("price").equals("")){
                        pstmt.setFloat(4, Float.parseFloat(request.getParameter("price")));                    
                    }
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
           	<div class="container">
        		<div class="row">
            		<div class="col-lg-12">
						<h5><i class="icon-music"></i> Congratulations! Product '<%= productname %>' has been added. </h5>
					</div>
				</div>
				<div class="col-sm-offset-2 col-sm-10">
	         		<a href="products.jsp"><button class="btn btn-success" type="button" onclick="products.jsp">Go back</button></a>
	      		</div>
			</div>
            
            <%-- -------- Close Connection Code -------- --%>
            <%
                conn.close();
            } catch (Exception e) {

                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
            %>
            	<h5>Sorry! Fail to insert new product. </h5>
            	<br>
				<br>
				<a href="products.jsp">Go back</a></li>
            <%
            }
            finally {
                // Release resources in a finally block in reverse-order of
                // their creation
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) { } // Ignore
                    pstmt = null;
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) { } // Ignore
                    conn = null;
                }
            }
        } //request.getParameter("action")!=null
     } // if username = null%>
     
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
    
</body>

</html>
