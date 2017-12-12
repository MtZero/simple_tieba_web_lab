<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/11/29
  Time: 08:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>森破贴吧 - 首页</title>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/global.css">
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
        <!-- posts begin -->
        <div id="posts" class="posts">
            <!-- contents -->
        </div>
        <!-- posts end -->
        <div id="get_more_content_outer"
             class="get-more-content-outer get-more-content panel">
            <a id="get_more_content_link"
               class="get-more-content-link get-more-content"
               style="cursor: pointer" onclick="">
                加载更多
            </a>
        </div>
    </div>
    <%@ include file="templates/sidebar.jsp" %>
</div>
<!-- wrapper end -->

<!-- footer begin -->
<%@ include file="templates/footer.jsp" %>
<!-- footer end -->
</body>
<script src="assets/js/index.js"></script>
<script>
    Sizzle("#nav_index")[0].classList.add("menu-button-activate");
    load_new_post();
</script>
</html>
