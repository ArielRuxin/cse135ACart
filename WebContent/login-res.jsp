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

            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            if((session.getAttribute("username")==null) || (!(session.getAttribute("username")==null) && !((String)(session.getAttribute("username"))).equals(request.getParameter("username")))) {
            	session.setAttribute("cartitem", null);
                session.setAttribute("itemnumber", null);
            }
            	
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rsUser = null;
            
            String loginuser = null;
            
            try {
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");

                // Open a connection to the database using DriverManager
                conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost/cse135?" +
                    "user=postgres&password=Hh_2010");
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
            loginuser = request.getParameter("username");

            // Create the statement
            pstmt = conn.prepareStatement("SELECT name, role FROM users WHERE users.name = ?");
        	pstmt.setString(1, loginuser);    
        	// Use the created statement to SELECT
            // the student attributes FROM the Student table.
         
            rsUser = pstmt.executeQuery();
            
            rsUser.next();
            
        	if( !rsUser.getString("name").equals(null) ) {
        		
        		session.setAttribute("username", rsUser.getString("name"));
        		session.setAttribute("role", rsUser.getString("role"));
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
		        <!-- /.container -->
		    </nav>
           
            <div class="container">
	        		<div class="row">
	            		<div class="col-lg-12">
							<h5>Hello <%= loginuser %>.<br> You have successfully login! </h5>
						</div>
					</div>
					<div class="col-sm-offset-2 col-sm-10">
		         		<a href="home.jsp"><button class="btn btn-success" type="button" onclick="home.jsp">OK</button></a>
		      		</div>
				</div>
            
			<%-- -------- Close Connection Code -------- --%>
            <% }
                // Close the ResultSet
                rsUser.close();     	

                // Close the Statement
                pstmt.close();

                // Close the Connection
                conn.close();
                
            } catch (SQLException e) {
			
                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
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
						<%		if((session.getAttribute("username")) == null) { %>
             						<p>Please login first</p>
             			<% 		} else if (((String)(session.getAttribute("username"))).equals("")){ %>
             						<p>The provided name cannot be empty</p>
             			<%		} else {%>
									<p>The provided name <%=loginuser %> doesn't exist</p>
						<% 		} %>
						</div>
					</div>
				   <div class="form-group">
				      <label class="col-sm-2 control-label">User Name</label>
				      <div class="col-sm-10">
				         <input name="username" type="text" class="form-control" id="inputError" placeholder="Please Enter Your User Name">
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
            <%
            }
            finally {
                // Release resources in a finally block in reverse-order of
                // their creation
				if (rsUser != null) {
                    try {
                    	rsUser.close();
                    } catch (SQLException e) { } // Ignore
                    rsUser = null;
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
