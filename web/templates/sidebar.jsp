<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/12/12
  Time: 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>

<%--<div id="side_bar_outer" class="side-bar-outer side-bar">--%>

<%--</div>--%>

<div id="user_panel_outer" class="user-panel-outer user-panel panel">
    <div id="user_panel_inner" class="user-panel-inner user-panel">
        <div id="user_profile" class="user-profile">
            <span class="user-avatar-outer">
                <img id="user_avatar" class="user-avatar" src="assets/images/default-avatar.jpg" alt="avatar">
            </span>
            <span class="user-name">
                未登录
            </span>
        </div>
        <div class="dash"></div>
        <div class="when-guest">
            <a href="#" onclick="newuser()">注册</a>&nbsp;&nbsp;
            <a href="#" onclick="login()">登录</a>
        </div>
        <div class="when-login" hidden>
            <a href="#" onclick="logout()">注销</a>
        </div>
    </div>
</div>

</body>
</html>
