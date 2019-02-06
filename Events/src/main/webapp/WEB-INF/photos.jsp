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
<title>Photos</title>
<link rel="stylesheet" href="../photos.css" />
</head>
<body>
<div class="container">
	<div>
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
		  <a  class="nav-item nav-link active" >Photos<span class="sr-only">(current)</span></a>
		  <a class="nav-item nav-link active" href="/chat">Buddy Chat</a>
		  <a class="nav-item nav-link active" href="/logout">Logout</a>
	     </div>
  	   </div>
	</nav>
	</div>
	<div class="photo-upload-block">
		<h2>Upload An Image</h2>
			
                <form:form method="post" action="/addPhoto" modelAttribute="imageObj">
                	<div class="form-group">
                	<h5 class="text-area-form-input">
                		<form:input class="form-control"  rows="4" type="textarea"  path="image"/>
					</h5>
					<form:hidden path="user" value="${user.id}"/>
			   		<input class="btn btn-primary" type="submit" value="Upload">  
					</div>
                </form:form>
               	<form:errors  path="imageObj.*"/>
	</div>
 
<%--  <div class="my-images-block">
 <h4 class="photo-wall">My Photos</h4>
 <div class="my-image-bg">
 	
	 <c:forEach items="${photos }" var="img">
	 	
		 <c:if test="${ img.user == user}">
		 	
		 	<p> <img class="img-thumbnail"  src="${img.image}"/> </p>
		 </c:if> 
		 
	 </c:forEach>
	 </div>
 </div>
  --%>
<div class="all-my-photos">

	<h4 class="photo-wall">Photo Wall</h4>
    <div class="thumbnail">
    	
     <c:forEach items="${photos }" var="img">
      <div class="image-content">
        <p> <img class="all-img" src="${img.image}"/> </p>
        <div class="caption">
         	<p class="photo-user"><a  href="/userProfile/${img.user.id}"><img class="rounded" src="${img.user.userImages.avatar}"  height="50" width="50"  ></a> ${img.user.firstName} ${img.user.lastName} </p>
        	<p class="photo-like"> <a class="heart-img" href="/photo/${img.id}/like"> <img  src="https://i.imgur.com/Qs8ipRB.png" height="20" width="20"/> </a>  ${img.likedPhoto.size()}  </p>
        </div>
         </div>
      </c:forEach>
     

  </div>

 </div>




</div>
</body>
</html>