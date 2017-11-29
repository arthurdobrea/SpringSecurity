<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>--%>
<%--<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>--%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description">
    <meta name="author">

    <title>show event</title>

    <link href="${contextPath}/resources/css/autocomplete.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Oswald:300' rel='stylesheet' type='text/css'>
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/event.css" rel="stylesheet">
    <script src="${contextPath}/resources/js/ui-bootstrap-tpls-2.5.0.min.js"></script>
    <script src="${contextPath}/resources/js/bootstrapmodal.js"></script>
    <script src="${contextPath}/resources/jquery/jquery.js"></script>
    <script src="${contextPath}/resources/jquery/jquery-ui.js"></script>
    <link href="${contextPath}/resources/jquery/jquery-ui.css" rel="stylesheet">
    <script src="${contextPath}/resources/scripts/jquery.autocomplete.min.js"></script>

    <script>

    </script>
</head>
<body>


    <div class=" modal-dialog modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" onclick="window.location.href='/index'" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">EVENT</h4>
            </div>
            <div class="modal-body">
                <form action="${contextPath}/showEvent" method="POST">
                    <div class="event-form">

                        <div class="row" id="leftblock" style="padding-right: 15px">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    MAIN INFO
                                    <%--Name: ${event.title} <br>--%>
                                    <%--Type: ${event.eventType}<br>--%>
                                    <%--Location: ${event.location}<br>--%>
                                    <%--Start time: ${event.start}<br>--%>
                                    <%--End time: ${event.end}<br>--%>
                                    <%--Description:${event.description}<br>--%>
                                    <%--Created at: ${event.eventCreated}<br>--%>
                                    <%--Created by: ${event.author.fullName}<br>--%>
                                    Title: ${event.title}
                                </div>
                                <div class="form-group">
                                    Location: ${event.location}
                                </div>
                                <div class="form-group">
                                    Type: ${event.eventType}
                                </div>
                                <div class="form-group">
                                    When start: ${event.start.toString().replace("T"," ")} <br>
                                    When end:&nbsp; ${event.end.toString().replace("T"," ")}
                                </div>

                                <div class="form-group">
                                    Author: ${event.author.fullName}
                                </div>

                            </div>


                            <div class="row" id="rightblock">
                                <div class="col-sm-6">
                                    <div class="form-group textarea-group">
                                        <label for="ev-show-description">DESCRIPTION</label>
                                        <textarea name="description" class="form-control" rows="3"
                                                  id="ev-show-description" required="true" value="${event.description}">${event.description}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                            <div class="row" id="bottomblock">
                                <div class="col-sm-12">
                                    <label for="t-show-participants" id="label-show-participants">PARTICIPANTS [<span style="color: #d2322d">${event.participants.size()}</span>]</label>
                                    <div class="form-group participant-group" id="t-show-participants">
                                            <c:forEach items="${event.participants}" var="user">
                                                     ${user.fullName} ||  ${user.position}
                                            </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                </form>
            </div>
        </div>
    </div>

    <script src="${contextPath}/resources/js/jquery.datetimepicker.full.min.js"></script>
    <script src="${contextPath}/resources/js/eventValidator.js"></script>



</body>
</html>
