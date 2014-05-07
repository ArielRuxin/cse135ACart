<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ACart: New user</title>

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

	<%
		String username = request.getParameter("name"); 
		String role = request.getParameter("role");
	%>
	            
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
		            <!-- /.navbar-collapse -->
		        </div>
		    </nav>
		    <!-- end of nav bar -->


            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rsState = null;
            ResultSet rsRole = null;
            
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
                    .prepareStatement("INSERT INTO users (name, role, age, state) VALUES (?, ?, ?, ?)");

                    pstmt.setString(1, request.getParameter("name"));
                    pstmt.setString(2, request.getParameter("role"));
                    pstmt.setInt(3, Integer.parseInt(request.getParameter("age")));                    
                    pstmt.setString(4, request.getParameter("state"));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            
            <%-- -------- Close Connection Code -------- --%>
            <% conn.close(); %>
		    
		    <%-- -------- Sign up successfully -------- --%>
		    <% 	session.setAttribute("username", username); 
		    	session.setAttribute("role", role); %>
		    
			    <div class="container">
	        		<div class="row">
	            		<div class="col-lg-12">
							<h5><i class="icon-music"></i> Congratulations! <%= username %>.<br> You have successfully signed up! </h5>
						</div>
					</div>
					<div class="col-sm-offset-2 col-sm-10">
		         		<a href="home.jsp"><button class="btn btn-success" type="button" onclick="home.jsp">Thanks</button></a>
		      		</div>
				</div>
            <%
            } catch (Exception e) {

                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
            %>
			    <div class="container">
	        		<div class="row">
	            		<div class="col-lg-12">
							<h2><i class="icon-exclamation-sign"></i> Oh, Sorry! Registration failed.</h2>
						</div>
					</div>
					<div class="col-sm-offset-2 col-sm-10">
		         		<a href="signup.jsp"><button class="btn btn-default" type="button">Go back</button></a>
		      		</div>
				</div>
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
            %>

</body>

</html>
