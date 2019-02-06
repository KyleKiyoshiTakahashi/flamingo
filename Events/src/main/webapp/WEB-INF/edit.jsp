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
<title><c:out value="${event.name}"/></title>
</head>
<body>
	<div class="container">

<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="/home">
	    <img src="https://i.imgur.com/NvKioan.png" width="30" height="30" class="d-inline-block align-top" alt="">
	    Ibis
	  </a>
	   <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
    	 <div class="navbar-nav">
    	  <a class="nav-item nav-link active" href="/events">Home</a>
    	  <a class="nav-item nav-link active" href="/userProfile/${user.id}">Profile</a>
    	  <a class="nav-item nav-link active" href="/events" >Events</a> 
		  <a  class="nav-item nav-link active" href="/photos" >Photos</a>
		  <a class="nav-item nav-link active" href="/chat">Buddy Chat</a>
		  <a class="nav-item nav-link active" href="/logout">Logout</a>
	     </div>
  	   </div>

	</nav>
		<h1><c:out value="${event.name}"/></h1>
	
		<div>
			<h3>Edit Event</h3>
			<form:form method="post" action="/events/${id}/edit" modelAttribute="event">
			<!-- this is called Method Spoofing check out: https://stackoverflow.com/questions/8054165/using-put-method-in-html-form  -->
			<!-- more info  https://laravel.com/docs/5.4/routing#form-method-spoofing -->
			<!-- HTML forms do not support PUT, PATCH or DELETE actions. So, when defining PUT, PATCH or  DELETE routes that are called from an HTML form, you will need to add a hidden _method field to the form. The value sent with the _method field will be used as the HTTP request method:  -->
				<input type="hidden" name="_method" value="put">
				<h4>
					<form:label path="name">Name:</form:label>
					<form:input  type="text" path="name"/>
				</h4>
				<h4>
					<form:label path="date">Date:</form:label>
					<form:input type="date" path="date"/>
				</h4>
				<h4>
					<form:label path="location">Location:</form:label>
					<form:select  path="state">
						<c:forEach items="${states}" var="state">
							<form:option value="${state}"><c:out value="${state}"/></form:option>
						</c:forEach>
					</form:select>
					<form:input  type="text" path="location"/>
				</h4>
				<form:hidden path="user" value="${user.id}"/>
				<input class="btn" type="submit" value="Edit"/>
			</form:form>
			<form:errors  path="event.*"/>
		</div>
		<div >
		</div>
	</div>
</body>
</html>