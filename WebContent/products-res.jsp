<html>

<body>

	<%
		String productname = request.getParameter("name"); 
		session.setAttribute("productname", productname); 
	%>


<table>
    <tr>
        <td>
            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
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
                    .prepareStatement("INSERT INTO products (name, sku, category, price) VALUES (?, ?, ?, ?)");

                    pstmt.setString(1, request.getParameter("name"));
                    pstmt.setInt(2, Integer.parseInt(request.getParameter("sku")));                    
                    pstmt.setString(3, request.getParameter("category"));
                    pstmt.setFloat(4, Float.parseFloat(request.getParameter("price")));                    
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            <h2>Congratulations</h2>
			<%= productname %> has been added
			<br>
			<br>
			<a href="products.jsp">Go back</a></li>
            
            <%-- -------- Close Connection Code -------- --%>
            <%
                conn.close();
            } catch (Exception e) {

                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
            %>
            	<h2>Sorry</h2>
            	Failure to insert new product.
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
            %>
        </table>
        </td>
    </tr>
</table>
</body>

</html>
