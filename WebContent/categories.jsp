<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ACart: Manage Categories</title>

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
    
            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            PreparedStatement pstmtNP = null;
            ResultSet rs = null;
            ResultSet rsNP = null;
            
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
                    .prepareStatement("INSERT INTO categories (name, description) VALUES (?, ?)");

                    pstmt.setString(1, request.getParameter("name"));
                    pstmt.setString(2, request.getParameter("description"));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            
            <%-- -------- UPDATE Code -------- --%>
            <%
                // Check if an update is requested
                if (action != null && action.equals("update")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // UPDATE student values in the Students table.
                    pstmt = conn
                        .prepareStatement("UPDATE categories SET name = ?, description = ? WHERE id = ?");

                    pstmt.setString(1, request.getParameter("name"));
                    pstmt.setString(2, request.getParameter("description"));
                    pstmt.setInt(3, Integer.parseInt(request.getParameter("id")));
                    
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            
            <%-- -------- DELETE Code -------- --%>
            <%
                // Check if a delete is requested
                if (action != null && action.equals("delete")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // DELETE students FROM the Students table.
                    pstmt = conn
                        .prepareStatement("DELETE FROM categories WHERE id = ?");

                    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                Statement statement = conn.createStatement();
            	
                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rs = statement.executeQuery("SELECT * FROM categories");
                
                pstmtNP = conn.prepareStatement("SELECT categories.name FROM categories WHERE categories.name NOT IN(SELECT category FROM products)");
                rsNP = pstmtNP.executeQuery();
             %>
            
  
		<div class="container">
		<div class="row">          
            <!-- Add an HTML table header row to format the results -->
            <table class="table  table-bordered table-hover">     
            <thead>
            <tr>
                <th>Name</th>
                <th>Description</th>
                <th>Action</th>
            </tr>
			</thead>
			<tbody>
			<form action="categories.jsp" method="POST">
            <input type="hidden" name="action" value="insert"/>
            <tr>
            	<td><input class="form-control" value="" name="name" size="15"/></td>
            	<td><input class="form-control" value="" name="description" size="30"/></td>
            	<td><button type="submit" class="btn btn-default">Insert</button></td>
            </tr>
            </form>
            </tbody>
            </table>

			<table class="table table-hover table-condensed">
			<thead>
            <tr>
            	<th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th colspan=2>Action</th>
            </tr>
			</thead>
			
			<tbody>
            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
            while (rs.next()) {
            %>
            <tr>	
            	<form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id" value="<%=rs.getInt("id")%>"/>

                <%-- Get the id --%>
                <td><%=rs.getInt("id")%></td>
                <%-- Get the name --%>           
                <td><input class="form-control" value="<%=rs.getString("name")%>" name="name" size="15"/></td>
				<td><input class="form-control" value="<%=rs.getString("description")%>" name="description" size="30"/></td>
				<%-- Button --%>
                <td><button type="submit" class="btn btn-primary">Update</button></td>
                </form>

                	<% 
                	while (rsNP.next()) {
                		if (rsNP.getString("name").equals(rs.getString("name"))) {
                	%>
	                		<form action="categories.jsp" method="POST">
	                		<input type="hidden" name="action" value="delete"/>
	                		<input type="hidden" value="<%=rs.getInt("id")%>" name="id"/>
               	 			<td><button type="submit" class="btn btn-danger">Delete</button></td></form>   
               	 	<% 
                			break;
                		}
                		rsNP = pstmtNP.executeQuery();
                	}
               	 	%>
            </tr>
            <% } %>
            </tbody>
            </table>
		</div>
		</div>

            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close the ResultSet
                rs.close(); 
            	rsNP.close();

                // Close the Statement
                statement.close();

                // Close the Connection
                conn.close();
                
            } catch (SQLException e) {

                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
                //throw e;
            %>
            	<div class="container">
	        		<div class="row">
	            		<div class="col-lg-12">
							<h2><i class="icon-exclamation-sign"></i> Oh, Sorry! Something went wrong.</h2>
						</div>
					</div>
					<div class="col-sm-offset-2 col-sm-10">
		         		<a href="categories.jsp"><button class="btn btn-default" type="button">Go back</button></a>
		      		</div>
				</div>
            <%
            
            	/* The requested data modification failed.
             */
            }
            finally {
                // Release resources in a finally block in reverse-order of
                // their creation

                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) { } // Ignore
                    rs = null;
                }
                
                if (rsNP != null) {
                    try {
                        rsNP.close();
                    } catch (SQLException e) { } // Ignore
                    rsNP = null;
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
            
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster 
	<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>-->

</body>

</html>

