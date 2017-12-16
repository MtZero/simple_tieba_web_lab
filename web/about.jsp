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
    <link rel="stylesheet" href="assets/css/emoticons.css">
    <link rel="stylesheet" href="assets/css/csshake.min.css">
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
        <div class="comment-outer panel">
            <div class="comment-content">
                <h1 class="shake shake-constant--hover">使用说明</h1>
                <p>为了获得最好的使用体验，建议您使用<b class="shake shake-constant shake-little">Safari 10+</b>（Mac）或者<b class="shake shake-constant shake-little">Chrome 49+</b>（Windows & Linux）并开启<span class="shake shake-constant shake-little">试验性功能</span>。</p>
                <h2>为 Chrome 开启试验性功能</h2>
                <p>首先使用 Chrome 打开本站<b class="shake shake-little shake-constant"><a>点击这里</a></b></p>
            </div>
        </div>
    </div>
    <%@ include file="templates/sidebar.jsp"%>
</div>
<!-- wrapper end -->

<!-- footer begin -->
<%@ include file="templates/footer.jsp"%>
<!-- footer end -->

<!-- modal begin -->
<%@ include file="templates/modal.jsp"%>
<!-- modal end -->
</body>
<script>
    Sizzle("#nav_about")[0].classList.add("menu-button-activate");
    init();
</script>
</html>
