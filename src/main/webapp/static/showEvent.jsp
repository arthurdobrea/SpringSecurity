<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
    <%--<link href="${contextPath}/resources/css/style.css" rel="stylesheet">--%>
    <link href="${contextPath}/resources/css/serghei.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/event.css" rel="stylesheet">
    <script src="${contextPath}/resources/js/bootstrapmodal.js"></script>
    <script src="${contextPath}/resources/js/jquery.js"></script>
    <script src="${contextPath}/resources/js/jquery-ui.min.js"></script>
    <link href="${contextPath}/resources/css/jquery-ui.css" rel="stylesheet">
    <script src="${contextPath}/resources/scripts/jquery.autocomplete.min.js"></script>

    <script>
    </script>
</head>
<body>


<div class=" modal-dialog modal-dialog modal-lg">
    <div class="modal-content" style="border-radius: 0">
        <div class="modal-header">
            <div class="create_event_header">
                <p align="left" class="modal_topic endava_grey_text">EVENT<button type="button" class="close_modal" data-dismiss="modal" onclick="window.location.href='/index'" aria-label="Close"></button></p>
            </div>
        </div>
        <div class="modal-body">
            <form action="${contextPath}/showEvent" method="POST">
                <div class="event-form">

                    <div class="row" id="leftblock" style="padding-right: 15px">
                        <div class="col-sm-6">
                            <div class="form-group">
                                MAIN INFO
                                Title:   <span style="color: #d2322d">${event.title}</span>
                            </div>
                            <div class="form-group">
                                Location: ${event.location}
                            </div>
                            <div class="form-group">
                                Type: ${event.eventType}
                            </div>
                            <div class="form-group">
                                When start: ${start}
                            </div>
                            <div class="form-group">
                                When end:&nbsp; ${end}
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
                            <label for="t-show-participants" id="label-show-participants">PARTICIPANTS [<span
                                    style="color: #d2322d">${event.participants.size()}</span>]</label>
                            <div class="form-group participant-group" id="t-show-participants">
                                <div class="row">

                                    <c:forEach items="${event.participants}" var="user">
                                        <div class="col-md-3 col-sm-4" id="t-show-participants-row">
                                            <table style="border: none">
                                                <tr>
                                                    <td rowspan="2"><img id="avatar" src="data:image/jpeg;base64,
                                                             ${user.getImageBase64()}" alt="Your avatar"
                                                                         style="width: 40px; height: 40px; border-radius: 50%"/>
                                                    </td>
                                                    <td style="padding-left: 2px; font-size: 14px"> ${user.fullName}</td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-left: 2px; font-size: 10px"> ${user.position}</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12" style="text-align: center">
                            <input hidden name="id" value="${event.id}">
                            <%--<c:set var="isParticipant" value="0"/>--%>
                            <c:if test="${isParticipant}">
                                <input type="submit" id="sendButton" value="UNSUBSCRIBE">
                            </c:if>
                            <c:if test="${!isParticipant}">
                                <input type="submit" id="sendButton" value="SUBSCRIBE">
                            </c:if>
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