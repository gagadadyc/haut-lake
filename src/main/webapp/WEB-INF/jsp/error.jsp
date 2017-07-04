<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>错误信息页面</title>
</head>
<body>
<%String errMsg = (String)request.getAttribute("errMsg"); %>

<%if (errMsg != null) {%>
很抱歉,<%=errMsg %>
<%} else {%>
发生了未知的异常!
<%} %>
</body>
</html>