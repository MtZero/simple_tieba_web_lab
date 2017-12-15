<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/12/13
  Time: 03:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>

<div id="register_modal" class="modal modal-background" hidden>
    <div class="modal modal-outer">
        <div class="modal modal-title">
            <span>注册</span>
            <span class="modal-close">
                <a onclick="close_modal()"><i class="fa fa-times"></i></a>
            </span>
        </div>
        <div class="dash"></div>
        <div class="modal modal-content">
            <form id="register_form" class="register-form">
                <label><span>帐　　号：</span><input id="register_username" type="text"></label>
                <label><span>密　　码：</span><input id="register_password" type="password"></label>
                <label><span>重复密码：</span><input id="register_password_2" type="password"></label>
                <div onclick="register_submit()">提交</div>
            </form>
        </div>
    </div>
</div>


<div id="login_modal" class="modal modal-background" hidden>
    <div class="modal modal-outer">
        <div class="modal modal-title">
            <span>登录</span>
            <span class="modal-close">
                <a onclick="close_modal()"><i class="fa fa-times"></i></a>
            </span>
        </div>
        <div class="dash"></div>
        <div class="modal modal-content">
            <form id="login_form" class="register-form">
                <label><span>帐　　号：</span><input id="login_username" type="text"></label>
                <label><span>密　　码：</span><input id="login_password" type="password"></label>
                <div onclick="login()">登录</div>
            </form>
        </div>
    </div>
</div>


<div id="change_password_modal" class="modal modal-background" hidden>
    <div class="modal modal-outer">
        <div class="modal modal-title">
            <span>修改密码</span>
            <span class="modal-close">
                <a onclick="close_modal()"><i class="fa fa-times"></i></a>
            </span>
        </div>
        <div class="dash"></div>
        <div class="modal modal-content">
            <form id="change_password_form" class="register-form">
                <label><span>旧密码：</span><input id="change_password_old" type="password"></label>
                <label><span>新密码：</span><input id="change_password_new" type="password"></label>
                <label><span>新密码：</span><input id="change_password_new_2" type="password"></label>
                <div onclick="change_password_submit()">提交</div>
            </form>
        </div>
    </div>
</div>


<div id="change_avatar_modal" class="modal modal-background" hidden>
    <div class="modal modal-outer">
        <div class="modal modal-title">
            <span>修改头像</span>
            <span class="modal-close">
                <a onclick="close_modal()"><i class="fa fa-times"></i></a>
            </span>
        </div>
        <div class="dash"></div>
        <div class="modal modal-content">
            <form id="change_avatar_form" class="register-form">
                <label><span>新头像：</span><input id="change_avatar" type="file" accept="image/*"></label>
                <div onclick="change_avatar_submit()">上传</div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
