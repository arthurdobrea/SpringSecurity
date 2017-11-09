<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>set user tag</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Oswald:300' rel='stylesheet' type='text/css'>

    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</head>
<body>
<a href="/welcome" class="btn">Home</a>
<a href="/index" class="btn">Calendar</a>
<a href="/userControlPanel" class="btn">User Panel</a>
<a href="/createEvent" class="btn">Create new event</a>
<a href="/userPage" class="btn">User Page</a>
<a href="/events" class="btn">All events</a>
<a href="/logout" class="btn">Logout</a>

    <form action="usersTag" method="post">
       <c:forEach items="${usersList}" var="user">
           <p>${user.username}||</p>
            <c:forEach items="${tagsList}" var="tag">
                ${tag.view()}
                <c:set var="checked" value="0"/>
                    <c:forEach items="${user.getTagsAsEnums()}" var="userTag">
                       <c:if test = "${tag==userTag}">
                           <c:set var="checked" value="1"/>
                        </c:if>
                    </c:forEach>
                    <c:if test = "${checked==1}">
                        <input type="checkbox" name="checkboxName" value="${tag}" checked/>
                    </c:if>
                    <c:if test = "${checked==0}">
                         <input type="checkbox" name="checkboxName" value="${tag}"/>
                    </c:if>
               </c:forEach>
           </p>
        </c:forEach>
           <p>
        <input type="submit">
    </form>

</div>
</body>
</html>