<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ACart: Products Browsing</title>

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
        			       					
        			
        			<%}%>
        					<li><a href="product-browse.jsp">Shopping</a></li>
        					<li><a href="login.jsp">Log out</a></li>
        				</ul>
                    </li>
            	<% }
            
            %>                
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

<% 
	/* } */
	String action = request.getParameter("action");
	/* String cate = null; */
	if (action != null && action.equals("list")) {
		session.setAttribute("cate", request.getParameter("cate"));
		if (!((String)(session.getAttribute("cate"))).equals("no")){
			session.setAttribute("realcate", request.getParameter("cate"));
		
		}
	}	
%>
	<%-- Initialization of students and nextPID --%>
<% 	if(session.getAttribute("cartitem")==null) 
		session.setAttribute("cartitem", new LinkedHashMap<String, Cartitem>());
	if(session.getAttribute("itemnumber")==null)
		session.setAttribute("itemnumber", 1);
	if(session.getAttribute("totalprice")==null)
		session.setAttribute("totalprice", 0.0);
%>    
    
<%-- -------- Retrieval code (already initialized students and nextPID) -------- --%>
<% 
	// retrieves student data from session scope
	LinkedHashMap<String, Cartitem> cartitem = (LinkedHashMap<String, Cartitem>)session.getAttribute("cartitem");
	
	// retrieves the latest pid
	Integer itemnumber = (Integer)(session.getAttribute("itemnumber"));
%>



<%-- Import the java.sql package --%>
<%@ page import="java.sql.*, cartitem.*, java.util.*"%>
<%-- -------- Open Connection Code -------- --%>
<%
	Connection conn = null;
	
	PreparedStatement pstmt = null; 
	PreparedStatement pstmtL = null; 
	
	ResultSet rsCate = null;
	ResultSet rsC = null;
	
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

	<div class="container">
	<div class="row">
	<div class="col-lg-12">
	
	<div>
		<span style="float:right">
			<a href="buyshoppingcart.jsp"><button class="btn btn-success" type="button" onclick="product-browse.jsp"><i class="icon-money icon-large"></i> Pay shopping cart</button></a>
		</span>
	</div>
	<div>
		<br /><br />
	<div>
	
	
	<table class="table">
		<tr>
			<!-- Category table -->
			<td rowspan="3">
		        <table class="table table-bordered table-hover">
		        <thead><tr>
		                <th> Categories	</th>
		        </tr></thead>
		        <tbody>
			        	<%
			        	while(rsCate.next()) {
			        	String cur = rsCate.getString("name");
			        	%>
			        <tr>
			        	<form action="product-browse.jsp" method="POST">
			        			<input type="hidden" name="action" value="list"/> 
			        			<input type="hidden" name="cate" value="<%=rsCate.getString("name")%>"/>
			                    <td><button type="submit" class="btn btn-link"><%=rsCate.getString("name")%></button></td>
			        	</form>
			        </tr>
			        <%
			        	}
			        %>
		        </tbody>
		        <tfoot>	        
			        <tr>
			        	<form action="product-browse.jsp" method="POST">
			        		<input type="hidden" name="action" value="list"/> 
			        		<input type="hidden" name="cate" value="All"/>
			                <td><button type="submit" class="btn btn-default btn-sm">Show all</button></td>
			        	</form>
			        </tr>
		        </tfoot>		        
		        </table>		        
	     	</td>
	     	<!-- Search -->
	     	<td><div style="float:right">
		     	<form action="product-browse.jsp" method="POST">
                   <input type="hidden" name="action" value="list"/>
                   <input type="hidden" name="cate" value="no"/>
                   <div class="input-group">
				   <input type="text" class="form-control" placeholder="Search" size="30"/>
   						<span class="input-group-btn">
     						<button class="btn btn-default" type="submit"><i class="icon-search"></i> Search</button>
   						</span>
   					</div>
               	</form></div>	
	    	</td>
	    </tr>
		<tr>
			<td><h4>Category: 
				<% if((session.getAttribute("realcate")==null)) {
				%> null <% 
				} else {
				%> <%=session.getAttribute("realcate") %> <% 
				}
				%>  
			</h4></td>
		</tr>
			
    		<%-- -------- ADD TO CARD Code -------- --%>
		    <%       
		       // Check if an insertion is requested
		       if (action != null && action.equals("addtocart")) {
		                    
		          // make new student to add to students map
		       		 Cartitem newCartitem = new Cartitem(); 
		          	
		          	 if (!(cartitem.get(request.getParameter("itemname"))==null)){
		       				newCartitem = cartitem.get(request.getParameter("itemname"));
		     		       	newCartitem.setAmount( (cartitem.get(request.getParameter("itemname"))).getAmount()+ Integer.parseInt(request.getParameter("amount")));                   
		     		       	itemnumber--;
		          	 } else {
			          // add the attributes from the request object to new student
			           newCartitem.setId(Integer.parseInt(request.getParameter("id")));                   
					   newCartitem.setNo(Integer.parseInt(request.getParameter("no")));                   
			           newCartitem.setItemname(request.getParameter("itemname"));
			           newCartitem.setPrice(Float.parseFloat(request.getParameter("price")));
				       newCartitem.setAmount(Integer.parseInt(request.getParameter("amount")));                   
			          // add new student to the map
		       		  } cartitem.put(request.getParameter("itemname"), newCartitem);
			           itemnumber++;
			           session.setAttribute("itemnumber", itemnumber);
		         }
		     %>
          
            <%-- -------- LIST Code -------- --%>
            <%
/*                  action = request.getParameter("action");
 */                // Check if an insertion is requested
                if (action != null && action.equals("list")) {                	
                	
                	if (((String) (session.getAttribute("cate"))).equals("All")) {
						 pstmtL = conn.prepareStatement("SELECT * FROM products");
                 	     rsC = pstmtL.executeQuery(); 
					} else if (((String) (session.getAttribute("cate"))).equals("no")) {
                    // Create the prepared statement and use it to
                    // INSERT student values INTO the students table.
                    	if (session.getAttribute("realcate")==null || ((String) (session.getAttribute("realcate"))).equals("All")) {
                    		pstmtL = conn.prepareStatement("SELECT * FROM products WHERE name ILIKE ?");
 	                    	pstmtL.setString(1, "%" + request.getParameter("search") + "%");
                        	rsC = pstmtL.executeQuery(); 
                    	} else {
                    		pstmtL = conn.prepareStatement("SELECT * FROM products WHERE name ILIKE ? AND category = ?");
 	                    	pstmtL.setString(1, "%" + request.getParameter("search") + "%");
 	                    	pstmtL.setString(2, (String) (session.getAttribute("realcate"))); 
							rsC = pstmtL.executeQuery(); 
                    	}
					} else {
                        pstmtL = conn.prepareStatement("SELECT * FROM products WHERE products.category = ?");
 						pstmtL.setString(1, (String) (session.getAttribute("cate")));                    
                        rsC = pstmtL.executeQuery(); 
					} %>
					
		<tr>
			<td>	<%
	               	if(!(rsC.next()) || ((String)(session.getAttribute("cate"))).equals("no") && (request.getParameter("search").equals("")))
	               	{%>
	               	<p class="text-danger">No products in this category!</p>                  
	           		<%} else { // Iterate over the ResultSet %>                

			           	<table class="table table-bordered table-hover">
			            <thead>    
			            <tr>
			            	<th>ID</th>
			                <th>Name</th>
			                <th>SKU</th>
			                <th>Category</th>
			                <th>Price</th>
			                <th>Action</th>
		          		</tr>
		          		</thead>
		          		<tbody>	<% 
		          		 		rsC = pstmtL.executeQuery(); 
							while (rsC.next()) {  %>
						<tr>
			                <form action="product-order.jsp" method="POST">
			                    <input type="hidden" name="action" value="preaddtocart"/>
			                    <input type="hidden" name="preitemname" value="<%=rsC.getString("name")%>"/>
			                    <input type="hidden" name="preprice" value="<%=rsC.getInt("price")%>"/>
								<input type="hidden" name="preid" value="<%=rsC.getInt("id")%>"/>
		
								<td><%=rsC.getInt("id")%></td>
			                    <td><%=rsC.getString("name")%></td>
			                	<td><%=rsC.getInt("sku")%></td>
			                	<td><%=rsC.getString("category")%></td>
			                    <td>$ <%=rsC.getFloat("price")%></td>
			                    <%-- Button --%>
			                    <td><button type="submit" class="btn btn-primary btn-sm"><i class="icon-shopping-cart icon-large"></i> Buy</td>
		
		               		</form>
		               	</tr>
		               	<% } %>
		               	</tbody>
		               	</table>
            	<% } %>
			</td>              
		</tr>
        <% } %>
	</table>
			
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
            } finally {
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

	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	
</body>

</html>
