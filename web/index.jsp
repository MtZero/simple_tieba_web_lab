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
<%@ include file="templates/header.jsp"%>
<!-- header end -->

<!-- wrapper start -->
<div id="wrapper" class="wrapper">
    <div id="content" class="content">
        <!-- posts begin -->
        <div id="post_outer_id" class="post-outer panel">
            <div id="post_title_id" class="post-title">
                <a id="post_title_link_id" class="post-title-link" href="post.jsp?pid=id">
                    title
                </a>
            </div>
            <div class="dash"></div>
            <div id="post_content_id" class="post-content">
                <a id="post_content_link_id" class="post-content-link" href="post.jsp?pid=id">
                    123123123123123123123123
                </a>
            </div>
            <div id="post_footer_id" class="post-footer">
                <i class="fa fa-user"></i>
                <span id="post_author_id">admin</span>&nbsp;&nbsp;
                <i class="fa fa-calendar"></i>
                <span id="post_last_reply_id">2017-12-01 12:00:00</span>
            </div>
        </div>
        <!-- posts end -->
        <div id="get_more_content_outer"
             class="get-more-content-outer get-more-content panel">
            <a id="get_more_content_link"
               class="get-more-content-link get-more-content"
               href="#" onclick="">
                加载更多
            </a>
        </div>
    </div>
    <%@ include file="templates/sidebar.jsp"%>
</div>
<!-- wrapper end -->

<!-- footer begin -->
<%@ include file="templates/footer.jsp"%>
<!-- footer end -->
</body>
<script src="assets/js/index.js"></script>
<script>
    Sizzle("#nav_index")[0].classList.add("menu-button-activate");
    let received = load_new_post();
    let posts;
    if (received.state === 0) {
        posts = received.data.posts;
    }
</script>
</html>
