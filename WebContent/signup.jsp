<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ACart: Sign up</title>

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
                    <li><a href="login.jsp">Already have an account? Login here!</a></li>
                </ul>
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
	
		<%-- -------- SELECT Statement and Role Code -------- --%>
		<%
	                      
	                // Create the statement
	                Statement statement = conn.createStatement();
	            	Statement statement1 = conn.createStatement();
	                // Use the created statement to SELECT
	                // the student attributes FROM the Student table.
	                rsState = statement.executeQuery("SELECT name FROM states"); 
	                rsRole = statement1.executeQuery("SELECT name FROM roles");
	             
	                
		%>
	 
		<div class="container">
	    <div class="row">		
				<form class="form-horizontal" role="form" action="signup-res.jsp" method="POST">          
				<div><input type="hidden" name="action" value="insert"/></div>
	            <div class="form-group">
	            	<label class="col-sm-2 control-label" for="inputusername">User Name</label>
	            	<div class="col-sm-10">
	            		<input name="name" type="text" class="form-control" id="inputusername" placeholder="Enter Name You Want to Register as User Name">
	            	</div>
	            </div>
				<div class="form-group">
	            	<label class="col-sm-2 control-label" for="chooserole">Role</label>
					<div class="col-sm-2">
				 		<%
				 			while(rsRole.next()) {
				  		%>
				  		<label class="radio inline">
				  		<input name="role" type="radio" id="chooserole" value=<%= rsRole.getString("name") %>><%= rsRole.getString("name")%>
				  		</label>
				  		<%
				  		}
				   			%>
				   	</div>
				</div>
	            <div class="form-group">
	            	<label class="col-sm-2 control-label" for="inputage">Age</label>
	            	<div class="col-sm-10">
	            		<input name="age" type="text" class="form-control" id="inputage" placeholder="Enter Your Age">
	            	</div>
	            </div>
	            <br>
	            <div class="form-group">
	            	<label class="col-sm-2 control-label" for="inputstate">State</label>
	            	<div class="col-sm-10">
						<select name="state" class="form-control" id="inputstate">
				 		<%
				 			while(rsState.next()) {
				  		%>
				  		<option><%= rsState.getString("name")%></option>
				  		<%
				  		}
				   			%>
						</select>
	            	</div>
	            </div>      
	   			<div class="form-group">
	      			<div class="col-sm-offset-2 col-sm-10">
						<button class="btn btn-default" type="submit">Register</button>
					</div>
				</div>
				</form>
			</div></div>

	            <%-- -------- Close Connection Code -------- --%>
	            <%
	                // Close the ResultSet
	                rsRole.close();
	            	rsState.close();
	
	                // Close the Statement
	                //pstmt.close();
	
	                // Close the Connection
	                conn.close();
	            } catch (SQLException e) {
	
	                // Wrap the SQL exception in a runtime exception to propagate
	                // it upwards
	                throw new RuntimeException(e);
	            }
	            finally {
	                // Release resources in a finally block in reverse-order of
	                // their creation
					if (rsRole != null) {
	                    try {
	                    	rsRole.close();
	                    } catch (SQLException e) { } // Ignore
	                    rsRole = null;
	                }
	                
	                if (rsState != null) {
	                    try {
	                    	rsState.close();
	                    } catch (SQLException e) { } // Ignore
	                    rsState = null;
	                }
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