<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description">
    <meta name="author">

    <title>Log in with your account</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/serghei.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Oswald:300' rel='stylesheet' type='text/css'>
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">

    <script src="<c:url value="/resources/js/lib/sockjs-0.3.4.min.js"/>"></script>
    <script src="<c:url value="/resources/js/lib/stomp.js"/>"></script>
    <script src="<c:url value="/resources/js/lib/jquery-1.10.2.min.js"/>"></script>
    <script src="<c:url value="/resources/bootstrap/js/bootstrap.min.js"/>"></script>
    <script src="<c:url value="/resources/js/lib/knockout-3.0.0.js"/>"></script>
    <script src="<c:url value="/resources/js/connectToServer.js"/>"></script>
    <script src="${contextPath}/resources/js/lib/jquery.min.js"></script>
    <script src="${contextPath}/resources/js/lib/bootstrap.min.js"></script>
    <script src="${contextPath}/resources/js/lib/jquery.ui.widget.js"></script>
    <script src="${contextPath}/resources/js/lib/jquery.iframe-transport.js"></script>
    <script src="${contextPath}/resources/js/lib/jquery.fileupload.js"></script>
    <script src="${contextPath}/resources/js/myuploadfunction.js"></script>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
</head>
<body>
<div class=" row login_form for_shadow">
    <form method="POST" action="${contextPath}/login">
        <div align="center" class="login_header">
            <img src="/resources/icons/Endava_Logo.png" class="endava_logo"/>
            <div style="margin-left: 50px;">${message}</div>
        </div>
        <div class="login_body ${error != null ? 'has-error' : ''}">
            <input autocomplete="false" name="username" id="username_input" type="text" placeholder="USERNAME"
                   autofocus="true"/>
            <input autocomplete="false" name="password" id="password_input" type="password" placeholder="PASSWORD"/>
            <span class="error_text" style="margin: 0;">${error}</span>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div style="margin-top: 40px">
                <div style="float: left"><label id="remember_me" class="modal-header edit_profile_header"><input
                        id="remember_me_checkbox" type="checkbox" name="remember-me"/>
                    <span class="endava_grey_text"> Remember me</span></label>
                </div>
                <div style="float: right; margin-right: 35px"><span class="endava_red_text cursor_link"
                                                                    onclick="window.location.href='/wrongSide'"
                                                                    style="margin-right: -33px;">Forgot password?</span>
                </div>
            </div>
            <button type="submit" class="btn_login_submit">LOG IN</button>
            <div align="center" style="padding-top: 15px">
                <span class="endava_grey_text">Don't have an account?</span>
                <span class="endava_red_text cursor_link"
                      onclick="window.location.href='/registration' "> Register</span>
            </div>
        </div>
    </form>
</div>
</body>
</html>