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

<d>
<jsp:include page="/products.jsp" />
</d>

<body>
		
	<%
		String action = request.getParameter("action");
		/* String cate = null; */
		if (action != null && action.equals("list")) {
			session.setAttribute("cate", request.getParameter("cate"));
			if (!((String)(session.getAttribute("cate"))).equals("no")){
				session.setAttribute("realcate", request.getParameter("cate"));
			
			}
		}
	%>
            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            PreparedStatement pstmtL = null; 
            PreparedStatement pstmtU = null; 
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
            
            <%-- -------- UPDATE Code -------- --%>
            <%
            	
                // Check if an update is requested
                if (action != null && action.equals("update")) {
                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // UPDATE student values in the Students table.
                    pstmt = conn
                        .prepareStatement("UPDATE products SET name = ?, sku = ?, category = ?, price = ? WHERE id = ?");

                    pstmt.setString(1, request.getParameter("name"));
                    pstmt.setInt(2, Integer.parseInt(request.getParameter("sku")));
                    pstmt.setString(3, request.getParameter("category"));
                    pstmt.setFloat(4, Float.parseFloat(request.getParameter("price")));                    
                    pstmt.setInt(5, Integer.parseInt(request.getParameter("id")));

                    %>
                    	Welcome<%= session.getAttribute("cate") %>
                    <% 
                    int rowCount = pstmt.executeUpdate();
					
                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                    if (session.getAttribute("cate").equals("All")) {
                    	pstmtU = conn.prepareStatement("SELECT * FROM products");
     					rsC = pstmtU.executeQuery(); 

                    } else {
                    	pstmtU = conn.prepareStatement("SELECT * FROM products WHERE products.category = ?");
 						pstmtU.setString(1, (String) (session.getAttribute("cate")));     
 	 					rsC = pstmtU.executeQuery(); 

                    }
                    /* session.setAttribute("cate", request.getParameter("category"));  */
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
                        .prepareStatement("DELETE FROM products WHERE id = ?");

                    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                    if (session.getAttribute("cate").equals("All")) {
                    	pstmtU = conn.prepareStatement("SELECT * FROM products");
     					rsC = pstmtU.executeQuery(); 

                    } else {
                    	pstmtU = conn.prepareStatement("SELECT * FROM products WHERE products.category = ?");
 						pstmtU.setString(1, (String) (session.getAttribute("cate")));     
 	 					rsC = pstmtU.executeQuery(); 

                    } 
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
					}
                }
             %>
             
<div class="container">
<div class="row">
<div class="col-lg-12">
        
	<table>
	<tr><h4>
		Category:
		<%
		if((session.getAttribute("realcate")==null)) {
		%>
			All
		<% 
		} else {
		%>
		<%=session.getAttribute("realcate") %>
		<% 
		}
		%></h4>
	</tr>
    <tr>
        <td>
             
             <% 
                if(!(rsC.next())|| ((String)(session.getAttribute("cate"))).equals("no") && (request.getParameter("search").equals("")))
                { %>
                    <p class="text-danger">No products in this category!</p>
             <% } else {
                // Iterate over the ResultSet
             %>
           	<table class="table table-bordered table-hover">
            <thead>    
            <tr>
            	<th>ID</th>
                <th>Name</th>
                <th>SKU</th>
                <th>Category</th>
                <th>Price</th>
                <th colspan="2">Action</th>
            </tr></thead>
            
            <tbody>
                <% 
                rsC = pstmtL.executeQuery(); 
                while (rsC.next()) {
            	%>

            <tr>
                <form action="product-search.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id" value="<%=rsC.getInt("id")%>"/>

                <%-- Get the id --%>
					<td><%=rsC.getInt("id")%></td>
                    <td><input class="form-control" value="<%=rsC.getString("name")%>" name="name" size="15"/></td>
                	<td><input class="form-control" value="<%=rsC.getInt("sku")%>" name="sku" size="10"/></td>               	
                    <td><select name="category" class="form-control">
                    	<option selected="<%=rsC.getString("category")%>"><%=rsC.getString("category")%></option>
			 			<%	
			 			rsCate = statement.executeQuery("SELECT name FROM categories"); 
			 			while(rsCate.next()) {
			 				if (!rsC.getString("category").equals(rsCate.getString("name"))){
			  			%>
			  				<option value=<%= rsCate.getString("name") %>><%= rsCate.getString("name")%></option>
			  				<%
			  				}
			 			}
			   			%>
						</select>
					</td>
                    <td><input class="form-control" value="<%=rsC.getFloat("price")%>" name="price" size="10"/></td>

	                <%-- Button --%>
	                <td><button type="submit" class="btn btn-primary btn-sm"><i class="icon-repeat"></i> Update</td>
                </form>
                
                <form action="product-search.jsp" method="POST">
                	<input type="hidden" name="action" value="delete"/>
                	<input type="hidden" value="<%=rsC.getInt("id")%>" name="id"/>
          			<td><button type="submit" class="btn btn-danger btn-sm"><i class="icon-trash"></i> Delete</button></td>
                </form>
           
            </tr>
            <% } %>
            </tbody>
         <% } %>
            </table>
            </td>
            </tr>
            </table>        
            </div>
            </div>
            </div>

            
            <%-- -------- Close Connection Code -------- --%>
            <%
                conn.close();
            
            } catch (SQLException e) {

                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
            %>
            	<h2>Sorry</h2>
            	Failure to change the product.
            <%
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
