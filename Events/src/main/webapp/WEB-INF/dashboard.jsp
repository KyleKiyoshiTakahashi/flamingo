<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>  
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>   
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<link rel="stylesheet" href="../dash.css" />

<title>Dashboard</title>

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
	  <div class="collapse navbar-collapse"  id="navbarNavAltMarkup">
    	 <div class="navbar-nav">
    	  <a class="nav-item nav-link active">Home <span class="sr-only">(current)</span></a>
		  <a class="nav-item nav-link active" href="/userProfile/${user.id}" >Profile</a> 
		  <a class="nav-item nav-link active" href="/events" >Events</a> 
		  <a  class="nav-item nav-link active" href="/photos" >Photos</a>
		  <a class="nav-item nav-link active" href="/chat">Buddy Chat</a>
		  <a class="nav-item nav-link active" href="/logout">Logout</a>
	     </div>
  	   </div> 

	
	</nav>
	</div>
	<div>
		<h1 class="user-name" >Welcome, <c:out value="${user.firstName}"/></h1>
		<p class="user-avatar"><c:if test="${user.userImages.avatar == null}"> <a href="/userProfile/${user.id}"><img src="https://i.imgur.com/NCQS39H.png" height="50" width="50"/> </a></c:if></p>
		<c:if test="${user.userImages.avatar != null}"> 
		<p class="user-avatar"> <a href="/userProfile/${user.id}"> <img class="rounded-circle" src="<c:out value="${user.userImages.avatar}"/> " height="50" width="50" /></a> </p>
		</c:if> 
		<button type="button" class="btn btn-outline-primary"><a href="/avatar/${user.id}" >Change Profile Picture</a></button>
	</div>
	
	<div>
	
 <div id="weather"></div>
	
	<div>
		<div class="message-wall">
			<h2>Message Wall</h2>
			
                <form:form method="post" action="/dashboard/addmsg" modelAttribute="messageObj">
                	<div class="form-group">
                	<h5 class="text-area-form-input">
                		<form:input class="form-control"  rows="4" type="textarea"  path="message"/>
					</h5>
					<form:hidden path="user" value="${user.id}"/>
			   		<input class="btn btn-primary" type="submit" value="Submit">  
					</div>
                </form:form>
               	<form:errors  path="messageObj.*"/>
		</div>	
		<div class="message-wall-all">
                <c:forEach items="${messages}" var="msg">
                    <p class="message-border"> <a  href="/userProfile/${msg.user.id}"><img class="rounded-circle" src="${msg.user.userImages.avatar}"  height="50" width="50"  ></a> ${msg.user.firstName} ${msg.user.lastName}: ${msg.message} </p>
                	<p> <a class="heart-img" href="/message/${msg.id}/like"> <img  src="https://i.imgur.com/Qs8ipRB.png" height="20" width="20"/> </a>  ${msg.likedMessage.size()}  </p>
                </c:forEach>
        </div>
	</div>
	
	</div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.simpleWeather/3.1.0/jquery.simpleWeather.min.js"></script>
<script src="../weather.js"></script>
</body>
</html>