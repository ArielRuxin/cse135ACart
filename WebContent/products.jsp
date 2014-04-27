<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ACart: Manage Products</title>

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

			<%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            
            PreparedStatement pstmt = null; 
            ResultSet rsCate = null;
            ResultSet rsC = null;
            String action = null;
            
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
            
            
                // Create the statement
                Statement statement = conn.createStatement();
                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rsCate = statement.executeQuery("SELECT name FROM categories"); 
             
                
            %>

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
	
	
	<table>
	           	<form action="product-search.jsp" method="POST">
                    <input type="hidden" name="action" value="list"/>
                    <input type="hidden" name="cate" value="no"/>
                    <input value="" name="search" size="30"/>
                    <input type="submit" value="Search"/>
                </form>
	    <tr>
	        
	        
	        <td>
		        <table border="1">
		        <tr>
		                <th>Categories</th>
		        </tr>
		        <tr>
		        	<%
		        	while(rsCate.next()) {
		        	String cur = rsCate.getString("name");
		        	%>
		        
		        	<form action="product-search.jsp" method="POST">
		        			<input type="hidden" name="action" value="list"/> 
		        			<input type="hidden" name="cate" value="<%=rsCate.getString("name")%>"/>
		                    <th><input type="submit" value="<%=rsCate.getString("name")%>"/></th>
		        	</form>
		        </tr>
		        <%
		        	}
		        %>
		        
		        <tr>
		        	<form action="product-search.jsp" method="POST">
		        			<input type="hidden" name="action" value="list"/> 
		        			<input type="hidden" name="cate" value="All"/>
		                    <th><input type="submit" value="All"/></th>
		        	</form>
		        </tr>
		        
		        </table>
	        </td>
	        
	        <td>
            
            
            
            
            
            <!-- Add an HTML table header row to format the results -->
            
            <table border="1">
            <tr>
            	<th>ID</th>
                <th>Name</th>
                <th>SKU</th>
                <th>Category</th>
                <th>Price</th>
            </tr>

            <tr>
                <form action="products-res.jsp" method="POST">
                    <input type="hidden" name="action" value="insert"/>
                    <th>&nbsp;</th>
                    <th><input value="" name="name" size="20"/></th>
                    <th><input value="" name="sku" size="10"/></th>
                    <th><select name="category">
			 		<%	
			 			rsCate = statement.executeQuery("SELECT name FROM categories"); 
			 			while(rsCate.next()) {
			  		%>
			  		<option value=<%= rsCate.getString("name") %>><%= rsCate.getString("name")%></option>
			  		<%
			  		}
			   			%>
					</select>
					</th>
                    <th><input value="" name="price" size="10"/></th>
                    <th><input type="submit" value="New Product"/></th>
                </form>
            </tr>
            
            </table>
        </td>
    </tr>
            
             
       		
       		
            

            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close the ResultSet
                rsCate.close();
            	/* rsC.close(); */
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
				if (rsCate != null) {
                    try {
                    	rsCate.close();
                    } catch (SQLException e) { } // Ignore
                    rsCate = null;
                }
				if (rsC != null) {
                    try {
                    	rsC.close();
                    } catch (SQLException e) { } // Ignore
                    rsC = null;
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) { } // Ignore
                    conn = null;
                }
            }
            %>
        
</table>

	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
</body>

</html>
