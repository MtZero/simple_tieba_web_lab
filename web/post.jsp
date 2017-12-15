<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/12/13
  Time: 03:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    String pid = request.getParameter("pid");
%>
<html>
<head>
    <title>森破贴吧 - 看贴</title>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/global.css">
    <link rel="stylesheet" href="assets/css/emoticons.css">
    <script src="assets/js/sizzle.min.js"></script>
    <script src="assets/js/global.js"></script>
</head>
<body>
<!-- header begin -->
<%@ include file="templates/header.jsp" %>
<!-- header end -->

<!-- wrapper start -->
<div id="wrapper" class="wrapper">
    <div id="content" class="content">


    </div>
    <%@ include file="templates/sidebar.jsp" %>
</div>
<!-- wrapper end -->

<!-- footer begin -->
<%@ include file="templates/footer.jsp" %>
<!-- footer end -->

<!-- modal begin -->
<%@ include file="templates/modal.jsp" %>
<div id="reload_page" class="bottom-button reload-page">
    <a onclick="location.reload(true)">
        <i class="fa fa-refresh fa-3x"></i>
    </a>
</div>

<div id="go_to_top" class="bottom-button go-to-top">
    <a href="#">
        <i class="fa fa-arrow-up fa-3x"></i>
    </a>
</div>

<div id="new_post" class="bottom-button new-post">
    <a onclick="write_new_comment_modal(<%=pid%>)">
        <i class="fa fa-pencil fa-3x"></i>
    </a>
</div>
<!-- modal end -->
</body>
<script src="assets/js/post.js"></script>
<script>
    let pid =<%=pid%>;
    init();
    load_pid_post(pid);
</script>
</html>
