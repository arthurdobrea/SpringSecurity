<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Oswald:300' rel='stylesheet' type='text/css'>

    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <title>Title</title>
</head>
<body>
<link href='http://fonts.googleapis.com/css?family=Oswald:300' rel='stylesheet' type='text/css'>

<a href="/welcome" class="btn">Home</a>
<a href="/index" class="btn">Calendar</a>
<a href="/userControlPanel" class="btn">User Panel</a>
<a href="/createEvent" class="btn">Create new event</a>
<a href="/events" class="btn">All events</a>
<a href="/logout" class="btn">Logout</a>
<p><p>
<h2>Tags:</h2>
<c:forEach items="${tags}" var="tag">
    <p>Tag: ${tag.tag} |
        <a href="/updateTag?tagId=${tag.id}"> update</a></p>|
        <a href="/delete/${tag.id}"> delete me!</a></p>
    <c:forEach items="${tag.events}" var="event">
        ${event.title}<br>
    </c:forEach>
    <br>
</c:forEach>

<h2>User By Meeting:</h2>
<c:forEach items="${UserEvents}" var="user">
        ${user.username}<br>
</c:forEach>

<h2>User By AM streeam:</h2>
<c:forEach items="${UserTags}" var="user">
    ${user.username}<br>
</c:forEach>
<a href="/create-tag" class="btn">Create new tag</a>
</body>
</html>