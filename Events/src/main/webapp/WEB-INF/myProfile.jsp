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
<title>Profile</title>
<link rel="stylesheet" href="../myProfile.css" />
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
    	  <a class="nav-item nav-link active">Profile<span class="sr-only">(current)</span></a>
    	   <a class="nav-item nav-link active" href="/events" >Events</a> 
    	   <a  class="nav-item nav-link active" href="/photos" >Photos</a>
		  <a class="nav-item nav-link active" href="/chat">Buddy Chat</a>
		  <a class="nav-item nav-link active" href="/logout">Logout</a>
	     </div>
  	   </div>

	</nav>

<div class="avatar-block">


</div>
<div class="user-info">
<c:if test="${user.userImages.avatar == null}"> <img src="https://i.imgur.com/NCQS39H.png" class="img-thumbnail"/> </c:if>
		<c:if test="${user.userImages.avatar != null}"> 
		<p class="avatar"> <img class="img-thumbnail"    class="rounded float-left"  src="<c:out value="${user.userImages.avatar}"/> "  /> </p>
</c:if> 
<dl class="row">
  <dt class="col-sm-3">First Name</dt>
  <dd class="col-sm-9">  <c:out value="${user.firstName}"/> </dd>
  <dt class="col-sm-3">Last Name</dt>
  <dd class="col-sm-9">  <c:out value="${user.lastName}"/> </dd>
  <dt class="col-sm-3">Email</dt>
  <dd class="col-sm-9">  <c:out value="${user.email}"/> </dd>
  <dt class="col-sm-3">Location</dt>
  <dd class="col-sm-9">  <c:out value="${user.location}"/>, <c:out value="${user.state}"/> </dd>
  	
	
	 
</dl>
</div>
<div>
 <div class="my-images-block">
 <h4 class="photo-wall">${user.firstName}'s Photos</h4>
 <div class="my-image-bg">
 	
	 <c:forEach items="${photos }" var="img">
	 	
		 <c:if test="${ img.user == user}">
		 	
		 	<p> <img class="img-thumbnail"  src="${img.image}"/> </p>
		 </c:if> 
		 
	 </c:forEach>
	 </div>
 </div>
</div>

</div>
</body>
</html>