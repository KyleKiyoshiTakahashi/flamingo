<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>   
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<title>Welcome</title>
</head>
<body>
	<div class="container">
		<div>
	<!-- Image and text -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="/home">
	    <img src="https://i.imgur.com/7FRJRxX.png" width="30" height="30" class="d-inline-block align-top" alt="">
	    Flamingo
	  </a>
	   <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
    	 <div class="navbar-nav">
    	  <a class="nav-item nav-link active" href="/home">Home </a>
		  <a class="nav-item nav-link active" href="/userProfile/${user.id}" >Profile</a> 
		  <a class="nav-item nav-link active" href="/events" >Events</a> 
		  <a  class="nav-item nav-link active" href="/photos" >Photos</a>
		  <a class="nav-item nav-link active" href="/chat">Buddy Chat</a>
		  

	     </div>
  	   </div>
	
	</nav>
	</div>
		<div class="col">
	
		<div class="jumbotron">
		  <h1 class="display-4">Welcome to Flamingo</h1>
		  <p class="lead">Connect with friends and family</p>
		  <hr class="my-4">
		  <a class="btn btn-primary btn-lg" href="/login">Already Have An Account?</a>
		 
	    </div>
			<h1>Register</h1>
			<form:form method="post" action="/register" modelAttribute="userObj">
			<div class="form-group">
				<h4>
					<form:label path="firstName">First Name:</form:label>
					<form:input  type="text"  class="form-control"  path="firstName"/>
				</h4>
			 </div>
			<div class="form-group">
				<h4>
					<form:label path="lastName">Last Name:</form:label>
					<form:input type="text"  class="form-control"  path="lastName"/>
				</h4>
			 </div>
			<div class="form-group">
				<h4>
					<form:label path="email">Email:</form:label>
					<form:input type="email"  class="form-control"  path="email"/>
				</h4>
			 </div>
			<div class="form-group">
				<h4>
					<form:label path="location">Location:</form:label>
					<form:select path="state">
						<c:forEach items="${states}" var="state">
							<form:option value="${state}"><c:out value="${state}"/></form:option>
						</c:forEach>
					</form:select>
					<form:input type="text"  class="form-control"  path="location"/>
				</h4>
			 </div>
			<div class="form-group">
				<h4 >
					<form:label path="password">Password:</form:label>
					<form:password  class="form-control"  path="password"/>
				</h4>
			 </div>
			<div class="form-group">
				<h4>
					<form:label path="confirmPassword">Confirm Password:</form:label>
					<form:password  class="form-control"  path="confirmPassword"/>
				</h4>
			 </div>
				<input type="submit" class="btn btn-primary btn-lg" value="Register"/>
			</form:form>			
			<form:errors path="userObj.*"/>
			
		</div>
		<hr>
			
	</div>
</body>
</html>