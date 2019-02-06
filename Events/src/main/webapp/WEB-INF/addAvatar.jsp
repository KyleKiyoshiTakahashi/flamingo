<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
<title>Change Your Profile Picture</title>
</head>
<body>
<div class="container">
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="/home">
	    <img src="https://i.imgur.com/7FRJRxX.png" width="30" height="30" class="d-inline-block align-top" alt="">
	    Flamingo
	  </a>
	   <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
    	 <div class="navbar-nav">
    	  <a class="nav-item nav-link active" href="/home">Home</a>
    	  <a class="nav-item nav-link active" href="/userProfile/${user.id}">Profile</a>
    	   <a class="nav-item nav-link active" href="/events" >Events</a> 
		  <a class="nav-item nav-link active" href="/chat">Buddy Chat</a>
		  <a class="nav-item nav-link active" href="/logout">Logout</a>
	     </div>
  	   </div>

	</nav>
	<div class="form-block">
	<h4>Upload a Profile Picture</h4>
		<form:form method="post" action="/avatar" modelAttribute="userAvtr">
					
						<h4>
							<form:label path="avatar"></form:label>
							<form:input  type="text" path="avatar"/>
						</h4>
						<form:hidden path="user" value="${user.id}"/> 
						<input  type="submit" class="btn btn-primary" value="Upload"/>
		</form:form>
					<form:errors  path="userAvtr.*"/>
			</div>
</div>
</body>
</html>