<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/12/12
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>森破贴吧 - 关于</title>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/global.css">
    <script src="assets/js/sizzle.min.js"></script>
    <script src="assets/js/global.js"></script>
</head>
<body>
<!-- header begin -->
<%@ include file="templates/header.jsp"%>
<!-- header end -->

<!-- wrapper start -->
<div id="wrapper" class="wrapper">
    <div id="content" class="content">

    </div>
    <%@ include file="templates/sidebar.jsp"%>
</div>
<!-- wrapper end -->

<!-- footer begin -->
<%@ include file="templates/footer.jsp"%>
<!-- footer end -->
</body>
<script>
    Sizzle("#nav_about")[0].classList.add("menu-button-activate");
</script>
</html>
