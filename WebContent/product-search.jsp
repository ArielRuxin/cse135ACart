<%@ page import="java.sql.*" language="java" contentType="text/html; charset=ISO-8859-1"
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
		if (action != null && action.equals("list")) {
			session.setAttribute("cate", request.getParameter("cate"));
			session.setAttribute("cateid", request.getParameter("cateid"));
			
			if (!((String)(session.getAttribute("cate"))).equals("no")){
				session.setAttribute("realcate", request.getParameter("cate"));
				session.setAttribute("realcateid", request.getParameter("cateid"));
				session.setAttribute("search", null);

			} else{
				session.setAttribute("search", request.getParameter("search"));
			}
		}
	%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            PreparedStatement pstmtL = null; 
            PreparedStatement pstmtU = null; 
            PreparedStatement pstmtCID = null;             
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
                rsCate = statement.executeQuery("SELECT name, id FROM categories");                 
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
                        .prepareStatement("UPDATE products SET name = ?, sku = ?, categoryid = ?, price = ? WHERE id = ?");

                    pstmt.setString(1, request.getParameter("name"));
                    pstmt.setString(2, request.getParameter("sku"));
                    pstmt.setInt(3, Integer.parseInt(request.getParameter("categoryid")));                    
                    pstmt.setFloat(4, Float.parseFloat(request.getParameter("price")));                    
                    pstmt.setInt(5, Integer.parseInt(request.getParameter("id")));

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
                        .prepareStatement("DELETE FROM products WHERE id = ?");

                    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            
            <%-- -------- LIST Code -------- --%>
            <%
	            if (((String) (session.getAttribute("cate"))).equals("All")) {
					 pstmtL = conn.prepareStatement("SELECT * FROM products");
					 rsC = pstmtL.executeQuery(); 
				} else if (((String) (session.getAttribute("cate"))).equals("no")) {
					
	               	if (session.getAttribute("realcate")==null || ((String) (session.getAttribute("realcate"))).equals("All")) {
	               		pstmtL = conn.prepareStatement("SELECT * FROM products WHERE name ILIKE ?");
	                    	pstmtL.setString(1, "%" + (String)(session.getAttribute("search")) + "%");
	                   		rsC = pstmtL.executeQuery(); 
	               	} else {
	               		pstmtL = conn.prepareStatement("SELECT * FROM products WHERE name ILIKE ? AND categoryid = ?");
	                    	pstmtL.setString(1, "%" + (String)(session.getAttribute("search")) + "%");
	                        pstmtL.setInt(2, Integer.parseInt((String)(session.getAttribute("realcateid"))));
							rsC = pstmtL.executeQuery(); 
	               	}
				} else {
	              pstmtL = conn.prepareStatement("SELECT * FROM products WHERE products.categoryid = ?");
	              pstmtL.setInt(1, Integer.parseInt((String)(session.getAttribute("cateid"))));
	              rsC = pstmtL.executeQuery(); 
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
			if(!(rsC.next())|| ((String)(session.getAttribute("cate"))).equals("no") && ((String)(session.getAttribute("search"))).equals(""))
			{ %>
			    <p class="text-danger">No products in this category!</p>
			    <% session.setAttribute("realcate", "All");                   
             } else {
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
                	<td><input class="form-control" value="<%=rsC.getString("sku")%>" name="sku" size="10"/></td>               	
                    <td><select name="categoryid" class="form-control">
			 			<%	
			 			rsCate = statement.executeQuery("SELECT name, id FROM categories");
			 			String curcate = null;
			 			while(rsCate.next()) {
			 				if (rsC.getInt("categoryid") == rsCate.getInt("id")){
			 					curcate = rsCate.getString("name");
			  				%>
			  					<option value="<%=(rsCate.getInt("id"))%>" selected="<%=(rsCate.getInt("id"))%>"><%=rsCate.getString("name")%></option>
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
