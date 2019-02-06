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

<link rel="stylesheet" href="../details.css" />
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
    	   <a  class="nav-item nav-link active" href="/photos" >Photos</a>
		  <a class="nav-item nav-link active" href="/chat">Buddy Chat</a>
		  <a class="nav-item nav-link active" href="/logout">Logout</a>
	     </div>
  	   </div>

	</nav>
<!-- 	let string = "San Francisco"
	let replaced = (string as NSString).stringByReplacingOccurrencesOfString(" ", withString: "+"); -->
	
	<div class="header">
		<h1><c:out value="${event.name}"/></h1>
	
	</div>
	<div class="main-block">
		<div class="event-info">
			<dl class="row">
			  <dt class="col-sm-3">Host</dt>
			  <dd class="col-sm-9">  <c:out value="${event.user.firstName}"/> <c:out value="${event.user.lastName}"/> <a href="/userProfile/${event.user.id}"> <img class="rounded-circle" src="<c:out value="${event.user.userImages.avatar}"/> " height="50" width="50" /> </a> </dd>
			  <dt class="col-sm-3">Date</dt>
			  <dd class="col-sm-9">   <fmt:formatDate pattern ="MMMM dd, yyyy" value ="${event.date}"/> </dd>
			  <dt class="col-sm-3">Location</dt>
			  <dd class="col-sm-9"> <c:out value="${event.location}"/>, <c:out value="${event.state}"/> </dd>
			  <dt class="col-sm-3">Number of people who are attending this event</dt>
			  <dd class="col-sm-9">   <c:out value="${event.joinedUsers.size()}"/> </dd>
				
			</dl>
		</div>
		
		
	</div>
	<c:if test="${event.joinedUsers.size()>0}">
	<div class="PWAA">
		<div class="attending-block">
			<h4>People Who Are Attending</h4>
			<table class="table">
				<thead>
	  				<tr>
	    				<th scope="col">Name</th>
					    <th scope="col">Location of Attendee</th>
	  				</tr>
				</thead>
				<tbody>
  					<c:forEach items="${attendees}" var="attendee">
		  				<tr>
					    	<td> <a href="/userProfile/${attendee.id}"><c:out value="${attendee.firstName}"/> <c:out value="${attendee.lastName}"/></a> </td>
					    	<td><c:out value="${attendee.location}"/>, <c:out value="${attendee.state}"/></td>
						<tr>
					</c:forEach>
				</tbody>
			</table>
		
		</div>
	</div>
	</c:if>
		<div class="message-wall">
			<h2>Message Wall</h2>
			<div>
                <c:forEach items="${messages}" var="msg">
                    <p class="message-border"> <a  href="/userProfile/${msg.user.id}"><img class="rounded-circle" src="${msg.user.userImages.avatar}"  height="50" width="50"  ></a> ${msg.user.firstName} says: ${msg.message}</p>
                	
                </c:forEach>
            </div>
                <form:form method="post" action="/events/addmsg" modelAttribute="messageObj">
                	<h5>
                		<form:input type="textarea" rows="4" cols="50" path="message"/>
					</h5>
					<form:hidden path="user" value="${user.id}"/>
					<form:hidden path="event" value="${event.id}"/>
			   		<input class="btn btn-primary" type="submit" value="Submit">   
                </form:form>
               	<form:errors  path="message.*"/>
		</div>
	</div>
	</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.simpleWeather/3.1.0/jquery.simpleWeather.min.js"></script>
<script src="../weather.js"></script>
</body>
</html>