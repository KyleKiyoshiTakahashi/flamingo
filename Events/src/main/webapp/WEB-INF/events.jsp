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
<title>Events</title>
<link rel="stylesheet" href="../events.css" />
</head>
<body>
	<div class="container">
	
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
		  <a class="nav-item nav-link active" >Events <span class="sr-only">(current)</span></a> 
		   <a  class="nav-item nav-link active" href="/photos" >Photos</a>
		  <a class="nav-item nav-link active" href="/chat">Buddy Chat</a>
		  <a class="nav-item nav-link active" href="/logout">Logout</a>
	     </div>
  	   </div>

	</nav>
	<div class="welcome-block">
		<h1 class="user-name" >Welcome, <c:out value="${user.firstName}"/></h1>
		<p class="user-avatar"><c:if test="${user.userImages.avatar == null}"> <a href="/userProfile/${user.id}"><img src="https://i.imgur.com/NCQS39H.png" height="55" width="55"/> </a></c:if></p>
		<c:if test="${user.userImages.avatar != null}"> 
		<p class="user-avatar"> <a href="/userProfile/${user.id}"> <img class="rounded-circle" src="<c:out value="${user.userImages.avatar}"/> " height="55" width="55" /></a> </p>
		</c:if> 
	</div>
	<div class="instate">
		<h2>Here are some of the events in your state:</h2>
		<c:if test="${instate.size() == 0}"><h5>There are currently no events in your area...</h5></c:if>
        <c:if test="${instate.size() > 0}">
			<table  class="table">
				<thead>
	  				<tr>
	    				<th scope="col">Name</th>
					    <th  scope="col">Date</th>
					    <th  scope="col">Location</th>
					    <th  scope="col">Host</th>
					    <th  scope="col">Action/Status</th>
	  				</tr>
				</thead>
				<tbody>
					<c:forEach items="${instate}" var="in">
	  				<tr>
	  					<td><a href="/events/${in.id}"><c:out value="${in.name}"/></a></td>
	  					<!-- How to use fmt:formatDate. Requires you to add code to top of file to use it. https://www.tutorialspoint.com/jsp/jstl_format_formatdate_tag.htm -->
					    <td><fmt:formatDate pattern ="MMMM dd, yyyy" value ="${in.date}"/></td>
					    <td><c:out value="${in.location}"/></td>
					    <td><c:out value="${in.user.firstName}"/></td>
					    <!-- Info on "choose when and otherwise" https://www.tutorialspoint.com/jsp/jstl_core_choose_tag.htm  -->
					    <!-- Info on " set"  https://beginnersbook.com/2013/11/jstl-cchoose-cwhen-cotherwise-core-tags/ -->
                        <c:choose>
                        <c:when test="${in.user == user}">
                            <td>*Attending* | <a href="/events/${in.id}/edit">Edit</a> | <a href="events/${in.id}/delete">Delete</a></td>
                        </c:when>
                        <c:otherwise>
                            <c:set var="attending" value="${false}"/>
                            <c:forEach items="${in.getJoinedUsers()}" var="attendee">
                            	<!-- info on "if and test" https://www.tutorialspoint.com/jsp/jstl_core_if_tag.htm  -->
                                <c:if test="${attendee == user}">
                                    <c:set var="attending" value="${true}"/>
                                </c:if>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${attending == false}">
                                    <td><a href="/events/${in.id}/join">Join</a></td>
                                </c:when>
                                <c:otherwise>
                                    <td>*Attending* | <a href="events/${in.id}/cancel">Cancel</a></td>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                        </c:choose>  
	  				</tr>
	  				</c:forEach>
				</tbody>
			</table>
			</div>
		</c:if>
		<div class="outState">
		<h2>Here are some of the events in other states:</h2>
		<c:if test="${outofstate.size() == 0}"><h5>There are currently no events in other states...</h5></c:if>
		<c:if test="${outofstate.size() > 0}">
		
		<table class="table">
			<thead>
  				<tr>
    				<th scope="col">Name</th>
				    <th scope="col">Date</th>
				    <th scope="col">Location</th>
				    <th scope="col">State</th>
				    <th scope="col">Host</th>
				    <th scope="col">Action</th>
  				</tr>
			</thead>
			<tbody>
				<c:forEach items="${outofstate}" var="out">
  				<tr>
  					<td><a href="/events/${out.id}"><c:out value="${out.name}"/></a></td>
				    <td><fmt:formatDate pattern ="MMMM dd, yyyy" value ="${out.date}"/></td>
				    <td><c:out value="${out.location}"/></td>
				    <td><c:out value="${out.state}"/></td>
				    <td><c:out value="${out.user.firstName}"/></td>
					<c:choose>
                        <c:when test="${out.user == user}">
                            <td>*Attending* | <a href="/events/${out.id}/edit">Edit</a> | <a href="events/${out.id}/delete">Delete</a></td>
                        </c:when>
                        <c:otherwise>
                            <c:set var="attending" value="${false}"/>
                            <c:forEach items="${out.getJoinedUsers()}" var="goer">
                                <c:if test="${goer == user}">
                                    <c:set var="attending" value="${true}"/>
                                </c:if>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${attending == false}">
                                    <td><a href="/events/${out.id}/join">Join</a></td>
                                </c:when>
                                <c:otherwise>
                                    <td>*Attending* | <a href="events/${out.id}/cancel">Cancel</a></td>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
  				</tr>
  				</c:forEach>
			</tbody>
		</table>
		</c:if>
		</div>
		<div class="create-event-block">
			<h2>Create an Event:</h2>
			<form:form method="post" action="/addevent" modelAttribute="eventObj">
			<div class="form-group">
				<h4>
					<form:label path="name">Name:</form:label>
					<form:input type="text"  class="form-control"  path="name"/>
				</h4>
				<h4>
					<form:label path="date">Date:</form:label>
					<form:input type="date" class="form-control"  path="date"/>
				</h4>
				<h4>
					<form:label path="location">Location:</form:label>
					<form:select  path="state">
						<c:forEach items="${states}" var="state">
							<form:option value="${state}"><c:out value="${state}"/></form:option>
						</c:forEach>
					</form:select>
					<form:input type="text"  class="form-control"  path="location"/>
				</h4>
				<!-- by using a hidden input you are able to pass the user id. user Id is required to create a new event -->
				<form:hidden path="user" value="${user.id}"/>
				<input type="submit" value="Create"/>
				</div>
			</form:form>
			<form:errors  path="eventObj.*"/>
		</div>
		<div>
		</div>
	</div>
</body>
</html>