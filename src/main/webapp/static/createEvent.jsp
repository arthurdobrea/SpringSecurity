<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    <title>Create an event</title>

    <link href="${contextPath}/resources/css/autocomplete.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/serghei.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/event.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/jquery-ui.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Oswald:300' rel='stylesheet' type='text/css'>

    <script src="${contextPath}/resources/js/lib/bootstrapmodal.js"></script>
    <script src="${contextPath}/resources/js/lib/jquery-ui.min.js"></script>
    <script src="${contextPath}/resources/js/lib/jquery.autocomplete.min.js"></script>
    <script src="${contextPath}/resources/js/userProfile.js"></script>
    <script src="${contextPath}/resources/js/eventValidator.js"></script>

    <script>
        $('form').submit(function () {
            $('input[type=submit]', $(this)).prop('disabled', true);
            e.preventDefault();
        });
    </script>
</head>

<body>
<%--create event modal--%>
<div class="modal fade" id="AddEvent" role="dialog">
    <div class="modal-dialog modal-lg" align="center" style="margin-top: 60px">
        <div class="modal-content" style="border-radius: 0;">
            <div class="event_add_modal-header" style="padding-left: 40px; padding-right: 40px">
                <div class="create_event_header">
                    <p align="left" class="modal_topic endava_grey_text">ADD EVENT
                        <button type="button" class="close_modal" data-dismiss="modal"></button>
                    </p>
                </div>
            </div>
            <div class="modal-body" style="padding-left: 40px; padding-right: 40px">
                <form action="${contextPath}/createEvent" method="POST">
                    <div class="event-form">
                        <div class="row" id="leftblock" style="padding-right: 15px">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="label_add_event" for="ev-title">TITLE</label>
                                    <input type="text" name="title" class="form-control" id="ev-title"
                                           placeholder="Enter title" required="true" maxlength="60">
                                </div>
                                <div class="form-group">
                                    <label class="label_add_event" for="ev-location">LOCATION</label>
                                    <input type="text" name="location" class="form-control" id="ev-location"
                                           placeholder="Enter Location" required="true" maxlength="60">
                                </div>
                                <div class="form-group">
                                    <label class="label_add_event" for="ev-type">EVENT TYPE</label>
                                    <select class="event_add_form_type_select_box" id="ev-type" name="eventType">
                                        <option style="font-size: 14px" value="">Select event type</option>
                                        <c:forEach items="${eventTypes}" var="et">
                                            <option style="font-size: 14px" value=${et}>${et.view()}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <input type="hidden" name="start" class="form-control" id="datetimepicker1">
                                        </div>
                                        <label class="label_add_event" for="datepicker1"> START DATE</label>
                                        <input type="date" class="form-control" id="datepicker1">
                                        <input type="time" class="form-control" id="timepicker1">
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <input type="hidden" name="end" class="form-control" id="datetimepicker2">
                                        </div>
                                        <label class="label_add_event" for="datepicker2"> END DATE</label>
                                        <input type="date" class="form-control" id="datepicker2"
                                               onchange="changeColor()">
                                        <input type="time" class="form-control" id="timepicker2"
                                               onchange="changeColor()">
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group" id="alldaydiv"
                                             style="padding-bottom:5px; padding-top: 0; text-align: left;">
                                            <div align="right" style="width: 70px"><label id="alldaylabel"
                                                                                          class="modal-header edit_profile_header">
                                                <input type="checkbox" id="all-day"
                                                       onclick="if(this.checked) {allDayChecked();} else {allDayUnchecked();}">
                                                <span class="endava_red_text"
                                                      style="font-size: 12px">&nbsp;All day</span>
                                            </label></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row" id="rightblock">
                                <div class="col-sm-6">
                                    <div class="form-group textarea-group">
                                        <label for="ev-description">DESCRIPTION</label>
                                        <textarea name="description" class="form-control" rows="3"
                                                  id="ev-description" required="true" maxlength="300"></textarea>
                                    </div>
                                </div>
                                <div class="col-sm-6" style="top: 10px;">
                                    <div class="form-group participant-group">
                                        <div align="left" class="input-group" style="bottom: 15px; width: 100%">
                                            <input type="text" id="w-input-search" value=""
                                                   class="event_form_enter_name_field" placeholder="Enter name..."
                                                   onclick="autoComplete()" style="width: inherit">
                                        </div>

                                        <label for="t-participants">PARTICIPANTS</label>
                                        <textarea class="form-control" name="participants" id="t-participants"
                                                  rows="3" readonly style="background: none"></textarea>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12" style="bottom: 8px;">
                                            <div class="checkbox-group" name="end" id="subs-checkbox"
                                                 style="padding-bottom:15px">
                                                <label class="checkbox-inline">
                                                    <input type="checkbox"/>Send emails to
                                                    participants</label>
                                                <label class="checkbox-inline">
                                                    <input type="checkbox" name="checkSubscribe"/>Send emails to
                                                    subscribers
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <label for="tag-checkbox" id="tag-box-label">TAGS</label>
                                <div class="checkbox-group form-group " style="text-align: center; bottom:-10px; "
                                     id="tag-checkbox">
                                    <c:forEach items="${tags}" var="tag">
                                        <label class="checkbox-inline" style="color:${tag.tag.color()}; top: 13px;">
                                            <input type="checkbox" name="checkboxTags"
                                                   id="checkboxTag" value="${tag.tag}"/> ${tag.tag.view()}
                                        </label>
                                    </c:forEach>
                                    <label class="checkbox-inline" style="color:${tag.tag.color()}">
                                        <input type="checkbox" name="checkboxTags"
                                               hidden value="hidden" checked/>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12" style="text-align: center; bottom: 10px;">
                                <input type="submit" class="btn_login_submit" value="SUBMIT"
                                       onmousedown="eventDateTimeValidation();">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
