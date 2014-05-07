<%@ page language="java" import="java.util.*, cartitem.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ACart: Shopping Cart</title>

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
   
	<%-- -------- Retrieval code (already initialized students and nextPID) -------- --%>
    <% 
        // retrieves student data from session scope
        LinkedHashMap<String, Cartitem> cartitem = (LinkedHashMap<String, Cartitem>)session.getAttribute("cartitem");
    
        // retrieves the latest pid
        Integer itemnumber = (Integer)(session.getAttribute("itemnumber"));
    %>
    
    <% String action = request.getParameter("action"); %>

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
            		if(session.getAttribute("role").equals("Owner")) {
        		%>
        			<li class="dropdown">
                    <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">Hello <%= session.getAttribute("username") %> <b class="caret"></b></a>
                    	<ul class="dropdown-menu">
							<li><a href="categories.jsp">Manage categories</a></li>
							<li><a href="products.jsp">Manage products</a></li>
							<li><a href="login.jsp">Log out</a></li>
						</ul>
                    </li>
        		
        		<% 	} else { %>        			
        			<li><a href="#">Hello <%= session.getAttribute("username") %></a></li>       			
        			<%}
            	}%>                
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>


<div class="container">
<div class="row">
<div class="col-lg-12">
	<div>
		<span style="float:right">
			<a href="buyshoppingcart.jsp"><button class="btn btn-success" type="button" onclick="product-browse.jsp"><i class="icon-money icon-large"></i> Proceed to checkout</button></a>
		</span>
	</div>
	<div>
		<br /><br />
	<div>
	<!-- Add an HTML table header row to format the results -->
	<table class="table table-bordered table-hover">
        <thead>
	        <tr>
	        	<th>Product ID</th>
	            <th>Name</th>
	            <th>Price</th>
	            <th>Quantity</th>
	            <th>Total</th>
	            <!-- <th>Total</th> -->
	        </tr>
        </thead>

		<tbody>
		<%-- -------- Iteration Code -------- --%>
        <%
            // loop through the student data
            Iterator it = cartitem.entrySet().iterator();
            while(it.hasNext()){
                // current element pair
                Map.Entry pair = (Map.Entry)it.next();
        	%>
		        <tr>
		        	<td><%=((Cartitem)pair.getValue()).getNo()%></td>
		            <td><%=((Cartitem)pair.getValue()).getItemname() %></td>
		            <td><%=((Cartitem)pair.getValue()).getPrice()%></td>
		            <td><%=((Cartitem)pair.getValue()).getAmount()%></td>
		            <td><%=((Cartitem)pair.getValue()).getPrice() * ((Cartitem)pair.getValue()).getAmount()%></td>
		        </tr>
        <% }
            
		if (action != null && action.equals("preaddtocart")) { %>
	        <tr>
	            <form action="product-browse.jsp" method="POST">
	                <input type="hidden" name="action" value="addtocart"/>
	                <input type="hidden" name="itemname" value="<%=request.getParameter("preitemname")%>"/>
	                <input type="hidden" name="price" value="<%=Integer.parseInt(request.getParameter("preprice"))%>"/>
	                <input type="hidden" name="no" value="<%=(Integer)(session.getAttribute("itemnumber"))%>"/>
	                <input type="hidden" name="id" value="<%=request.getParameter("preid")%>"/>
	                
	                
	                <td><%= session.getAttribute("itemnumber") %></td>
	                <td><%= request.getParameter("preitemname") %></td>
	                <td><%= Integer.parseInt(request.getParameter("preprice")) %></td>                    
	                <td><input class="form-control" value="" name="amount" size="10"/></td>
	                <td><button type="submit" class="btn btn-primary btn-sm"><i class="icon-shopping-cart icon-large"></i> Add to Cart</td>
	            </form>
	        </tr>
		<% } %>
		</tbody>		
	</table></div>
	<div><a href="product-browse.jsp"><button class="btn btn-default" type="button" onclick="product-browse.jsp"><i class="icon-reply"></i> Continue Shopping</button></a></div>
</div>
</div>
</div>

	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>

</body>

</html>

