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
                <p>为了获得最好的使用体验，建议您使用<b class="shake shake-constant shake-little">Safari 10+</b>（Mac）或者<b class="shake shake-constant shake-little">Chrome 49+</b>（Windows & Linux）并开启<span class="shake shake-constant shake-little">试验性功能</span>。请注意，本站并不对 <span style="color: red"><s>IE</s></span> 和 <span style="color: red"><s>Edge</s></span> 的兼容性进行保证，若您在使用上述两款浏览器浏览本站时发现功能或样式上的问题，不妨先使用 <b>Safari</b> 或者 <b>Chrome</b> 试一试。</p>
                <h2>为 Chrome 开启试验性功能</h2>
                <p>首先使用 Chrome 打开本站，然后复制地址并打开 <b class="shake shake-little shake-constant">chrome://flags/</b>，在新打开的页面找到 <b>Experimental Web Platform features</b> 并启用，重启浏览器即可。</p>
                <h2>测试帐号</h2>
                <p>测试用的帐号密码：管理员 admin:123，普通用户 user:123，也可以自行注册新用户来测试。普通用户具有修改自己的头像和修改自己的密码权限，管理员除了普通用户的权限还具有删除发帖和回复的权限。所有用户都可以发帖、发回复并上传图片。</p>
            </div>
        </div>
        <div class="comment-outer panel">
            <div class="comment-content">
                <h1>感谢</h1>
                <ul>
                    <li>gson: <a href="https://github.com/google/gson" target="_blank">https://github.com/google/gson</a></li>
                    <li>sizzle: <a href="https://github.com/jquery/sizzle" target="_blank">https://github.com/jquery/sizzle</a></li>
                    <li>csshake: <a href="https://github.com/elrumordelaluz/csshake" target="_blank">https://github.com/elrumordelaluz/csshake</a></li>
                </ul>
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
