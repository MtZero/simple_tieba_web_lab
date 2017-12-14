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
        <!-- posts begin -->
        <div id="posts" class="posts">
            <!-- contents -->
        </div>
        <!-- posts end -->
        <div id="get_more_content_outer"
             class="get-more-content-outer get-more-content panel">
            <a id="get_more_content_link"
               class="get-more-content-link get-more-content"
               style="cursor: pointer" onclick="load_new_post()">
                加载更多
            </a>
        </div>
    </div>
    <!-- sidebar begin -->
    <%@ include file="templates/sidebar.jsp" %>
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
        <a onclick="write_new_post()">
            <i class="fa fa-pencil fa-3x"></i>
        </a>
    </div>
    <!-- sidebar end -->
</div>
<!-- wrapper end -->

<!-- footer begin -->
<%@ include file="templates/footer.jsp" %>
<!-- footer end -->

<!-- modal begin -->
<%@ include file="templates/modal.jsp"%>
<!-- modal end -->

</body>
<script src="assets/js/index.js"></script>
<script>
    Sizzle("#nav_index")[0].classList.add("menu-button-activate");
    init();
    load_new_post();
</script>
</html>
