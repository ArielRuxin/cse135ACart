<%-- Import the java.sql package --%>
<%@ page import="java.sql.*, java.util.*, cartitem.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ACart: Payment confirmation</title>

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
        <!-- /.navbar-collapse -->
    </div>
</nav>
	<div class="container">
	<div class="row">
	<div class="col-lg-12">
<!-- end of nav bar --> 
<%-- -------- Open Connection Code -------- --%>
<%
if (session.getAttribute("username")==null){
%>	
	<a href="login.jsp"> Please log in first </a>
<% 
} else if (request.getParameter("action")==null) {
%>
	<a href="product-browse.jsp"> Please select a product </a>
<%
} else{
// retrieves student data from session scope
LinkedHashMap<String, Cartitem> cartitem = (LinkedHashMap<String, Cartitem>)session.getAttribute("cartitem");

// retrieves the latest pid
Integer itemnumber = (Integer)(session.getAttribute("itemnumber"));
String username = (String)(session.getAttribute("username"));

session.setAttribute("cartitem", null);
session.setAttribute("itemnumber", null);
     
Connection conn = null;
PreparedStatement pstmt = null;
PreparedStatement pstmtOP = null;
PreparedStatement pstmtUID = null;
PreparedStatement pstmtPro = null;

ResultSet rs = null;
ResultSet rsuser = null; %> 

<% try {
	// Registering Postgresql JDBC driver with the DriverManager
	Class.forName("org.postgresql.Driver");
	
	// Open a connection to the database using DriverManager
	conn = DriverManager.getConnection(
	    "jdbc:postgresql://localhost/cse135?" +
	    "user=postgres&password=Hh_2010");
	
	//-- -------- PAY Code -------- --

	String action = request.getParameter("action");
	// Check if an insertion is requested
	if (action != null && action.equals("pay")) {
           	
		// Begin transaction
		conn.setAutoCommit(false);
	
		pstmtUID = conn.prepareStatement("SELECT id FROM users WHERE name = ?");
		pstmtUID.setString(1, username);
		rsuser = pstmtUID.executeQuery();
		Integer userid = 0;
		rsuser.next();
		userid = rsuser.getInt("id");
	
		// Create the prepared statement and use it to
		// INSERT student values INTO the students table.
		pstmt = conn
		.prepareStatement("INSERT INTO orders (totalprice, cardnumber, userid) VALUES (?, ?, ?)");
		
		pstmt.setDouble(1, (Double)(session.getAttribute("totalprice")) );
		pstmt.setString(2, request.getParameter("cardnumber"));
		pstmt.setInt(3, userid);
		
		int rowCount = pstmt.executeUpdate();
	
		Statement statement = conn.createStatement();
		rs = statement.executeQuery("SELECT id FROM orders");
		
		int lastorderid = 0;
		while (rs.next()) {
			lastorderid = rs.getInt("id");
		}
			
		Iterator it = cartitem.entrySet().iterator();
		
		while(it.hasNext()){
            // current element pair
            Map.Entry pair = (Map.Entry)it.next(); 
            pstmtOP = conn
                    .prepareStatement("INSERT INTO orders_products (orderid, productid, amount) VALUES (?, ?, ?)");

            pstmtOP.setInt(1, lastorderid);                    
            pstmtOP.setInt(2, ((Cartitem)pair.getValue()).getId());                    
            pstmtOP.setInt(3, ((Cartitem)pair.getValue()).getAmount());     
            int rowCountOP = pstmtOP.executeUpdate();
		}
	
		// Commit transaction
		conn.commit();
		conn.setAutoCommit(true);
	  %>	
			<h5><i class="icon-music"></i> Congratulations! You have bought: </h5>	  	
	  		<br>
	  	
	  		<table class="table table-bordered table-hover">
	  		<thead>
				<tr>
					<th>Product ID</th>
				    <th>Name</th>
				    <th>Price</th>
				    <th>Quantity</th>
				    <th>Total</th>
				</tr>
			</thead>
			<tbody>
			<%-- -------- Iteration Code -------- --%>
			<%
				// loop through the student data
				Iterator it1 = cartitem.entrySet().iterator();
				while(it1.hasNext()) {
				    // current element pair
				    Map.Entry pair = (Map.Entry)it1.next();
					%>
					<tr>
						<td><%=((Cartitem)pair.getValue()).getNo()%></td>
					    <td><%=((Cartitem)pair.getValue()).getItemname() %></td>
					    <td><%=((Cartitem)pair.getValue()).getPrice()%></td>
					    <td><%=((Cartitem)pair.getValue()).getAmount()%></td>
					    <td><%=((Cartitem)pair.getValue()).getPrice() * ((Cartitem)pair.getValue()).getAmount()%></td>
					</tr>	
				<% } %>
			</tbody>
			</table>
			<br />
			<div><h4>Subtotal: $<%=session.getAttribute("totalprice") %></h4></div>
			<div><a href="product-browse.jsp"><button class="btn btn-default" type="button" onclick="product-browse.jsp"><i class="icon-reply"></i> Continue Shopping</button></a></div>
		</div>
		</div>
		</div>	          
    <% }
	
    // Close the Connection
    conn.close();
    
} catch (SQLException e) {

    // Wrap the SQL exception in a runtime exception to propagate
    // it upwards
 %>   	
     User doesn't exist.


<% } finally {
    // Release resources in a finally block in reverse-order of
    // their creation

    if (conn != null) {
        try {
            conn.close();
        } catch (SQLException e) { } // Ignore
        conn = null;
    }
}
}
%>
</body>

</html>
