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
                <div class="modal-submit" onclick="register_submit()">提交</div>
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
                <div class="modal-submit" onclick="login()">登录</div>
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
                <div class="modal-submit" onclick="change_password_submit()">提交</div>
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
                <div class="modal-submit" onclick="change_avatar_submit()">上传</div>
            </form>
        </div>
    </div>
</div>


<div id="write_new_comment_modal" class="modal modal-background" hidden>
    <div class="modal modal-big-outer">
        <div class="modal modal-title">
            <span id="write_new_comment_title">发表回复</span>
            <span class="modal-close">
                <a onclick="close_modal()"><i class="fa fa-times"></i></a>
            </span>
        </div>
        <div class="dash"></div>
        <div class="modal modal-content-big">
            <div id="modal_content_inner">
                <input type="text" id="post_title_input" class="post-title-input" placeholder="标题" hidden>
                <div id="comment_toolbox" class="comment-toolbox">
                    <span id="toolbox_bold" class="tools" onclick="insert_at_cursor(field, '[b]', '[/b]')"><i class="fa fa-bold"></i></span>
                    <span id="toolbox_italic" class="tools" onclick="insert_at_cursor(field, '[i]', '[/i]')"><i class="fa fa-italic"></i></span>
                    <span id="toolbox_underline" class="tools" onclick="insert_at_cursor(field, '[u]', '[/u]')"><i class="fa fa-underline"></i></span>
                    <span id="toolbox_image" class="tools" style="cursor: default;">
                        <i class="fa fa-file-image-o"></i>
                        <span class="upload-file-panel">
                            <input id="upload_file_input" type="file" accept="image/*">
                            <span class="modal-submit" onclick="upload_file_submit()">提交</span>
                        </span>
                    </span>
                    <span id="toolbox_emoticon" class="tools" style="cursor: default;">
                        <i class="fa fa-smile-o"></i>
                        <span class="emoticon-panel">
                            <!-- insert emoticons with js -->
                        </span>
                    </span>
                </div>
                <textarea id="comment_input_content" class="comment-input-content" placeholder="内容"></textarea>
                <!-- onclick attribute is set by js -->
                <div id="write_new_comment_submit" class="modal-submit" onclick="">提交</div>
            </div>
        </div>
    </div>
</div>


<script>
    let field = Sizzle('#comment_input_content')[0];
    init_emoticons();
</script>

</body>
</html>
