let cookie_prefix = "simple_tieba_";
let avatar_prefix = "uploads/avatar/";

function close_modal() {
    let modals = Sizzle(".modal-background");
    for (let i = 0; i < modals.length; i++) {
        modals[i].setAttribute("hidden", "");
    }
}

function register_modal() {
    let modal = Sizzle("#register_modal")[0];
    modal.removeAttribute("hidden");
}

async function register_submit() {
    let username = Sizzle("#register_username")[0].value.toString();
    let password = Sizzle("#register_password")[0].value.toString();
    let password2 = Sizzle("#register_password_2")[0].value.toString();
    if (password !== password2) {
        alert("两次输入的密码不一致！");
    } else {
        let r = await fetch("functions/Interface.jsp?intent=register", {
            method: "POST",
            body: JSON.stringify({"username": username, "password": password})
        });
        let j = await r.json();
        if (j.state === "0") {
            alert("注册成功！");
            Sizzle("#register_modal")[0].setAttribute("hidden", "");
        } else {
            alert("用户名被占用！");
        }
    }
}

function getCookie(name) {
    let cookies = document.cookie.split(";");
    for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i].trim().split("=");
        if (cookie[0].trim() === cookie_prefix + name) return cookie[1].trim();
    }
    return null;
}

function setCookie(name, value) {
    document.cookie = cookie_prefix + name + "=" + value;
}

let token_json = getCookie("token");
let token;
if (token_json !== undefined && token_json !== null && token_json !== "" && token_json !== "undefined") {
    token = JSON.parse(getCookie("token"));
} else {
    token = undefined;
}

async function init() {
    if (token != null && token !== "" && token !== undefined) {
        let date = new Date();
        let timestamp = date.getTime();
        if (timestamp / 1000 > token.expiration ||
            token.expiration == null ||
            token.username == null ||
            token.token == null) {
            setCookie("token", "");
            setCookie("avatar_path", "default-avatar.jpg");
        } else {
            Sizzle("#when_guest")[0].setAttribute("style", "display: none;");
            Sizzle("#when_login")[0].removeAttribute("style");
            Sizzle("#user_name")[0].innerHTML = token.username;
        }
    } else {
        setCookie("avatar_path", "default-avatar.jpg");
    }
    Sizzle("#user_avatar")[0].setAttribute("src", avatar_prefix + getCookie("avatar_path"));
    Sizzle("#user_avatar")[0].setAttribute("style", "cursor: pointer;");
}

function check_login() {
    return (token != null && token !== "" && token !== undefined);

}

function logout() {
    if (confirm("确定要注销吗？")) {
        setCookie("token", undefined);
        setCookie("avatar_path", "default-avatar.jpg");
        setCookie("role", "-1");
        token = undefined;
        Sizzle("#when_login")[0].setAttribute("style", "display: none;");
        Sizzle("#when_guest")[0].removeAttribute("style");
        Sizzle("#user_avatar")[0].setAttribute("src", avatar_prefix + getCookie("avatar_path"));
        Sizzle("#user_name")[0].innerHTML = "未登录";
        Sizzle("#user_avatar")[0].removeAttribute("style");
        // 刷新一下
        location.reload(true);
    }
}

async function login(username = undefined, password = undefined) {
    if (username === undefined) {
        username = Sizzle("#login_username")[0].value;
    }
    if (password === undefined) {
        password = Sizzle("#login_password")[0].value;
    }
    let r = await fetch("functions/Interface.jsp?intent=sign_in", {
        method: "POST",
        body: JSON.stringify({"username": username, "password": password})
    });
    let j = await r.json();
    if (j.state === "0") {
        token = j.data;
        setCookie("token", JSON.stringify(token));
        let ur = await fetch("functions/Interface.jsp?intent=get_user", {
            method: "POST",
            headers: {
                "token": JSON.stringify(token)
            },
            body: JSON.stringify({"username": username})
        });
        let uj = await ur.json();
        let avatar_path = uj.data.avatar;
        let role = uj.data.role;
        setCookie("avatar_path", avatar_path);
        setCookie("role", role);
        Sizzle("#when_guest")[0].setAttribute("style", "display: none;");
        Sizzle("#when_login")[0].removeAttribute("style");
        Sizzle("#user_name")[0].innerHTML = token.username;
        Sizzle("#user_avatar")[0].setAttribute("src", avatar_prefix + getCookie("avatar_path"));
        Sizzle("#login_modal")[0].setAttribute("hidden", "");
        Sizzle("#login_username")[0].value = "";
        Sizzle("#login_password")[0].value = "";
        Sizzle("#user_avatar")[0].setAttribute("style", "cursor: pointer;");
        // 刷新一下
        location.reload(true);
    } else {
        alert("帐号或密码不正确！");
    }
}

function login_modal() {
    let modal = Sizzle("#login_modal")[0];
    modal.removeAttribute("hidden");
}

function change_password_modal() {
    if (check_login()) {
        let modal = Sizzle("#change_password_modal")[0];
        modal.removeAttribute("hidden");
    } else {
        alert("请登录！");
    }
}

async function change_password_submit() {
    let password_old = Sizzle("#change_password_old")[0].value;
    let password_new = Sizzle("#change_password_new")[0].value;
    let password_new_2 = Sizzle("#change_password_new_2")[0].value;
    if (password_old === "" || password_old === undefined) {
        alert("请输入旧密码！");
    } else if (password_old === "" || password_old === undefined || (password_new !== password_new_2)) {
        alert("两次新密码输入不相同或为空！");
    } else {
        let j = await fetch("functions/Interface.jsp?intent=modify_user", {
            method: "POST",
            headers: {"token": JSON.stringify(token)},
            body: JSON.stringify({"username": token.username, "password": password_new})
        });
        let r = await j.json();
        if (r.state === "0") {
            alert("修改成功！请重新登录。");
            Sizzle("#change_password_modal")[0].setAttribute("hidden", "");
            setCookie("token", undefined);
            setCookie("avatar_path", "default-avatar.jpg");
            setCookie("role", "-1");
            Sizzle("#when_login")[0].setAttribute("style", "display: none;");
            Sizzle("#when_guest")[0].removeAttribute("style");
            Sizzle("#user_avatar")[0].setAttribute("src", avatar_prefix + getCookie("avatar_path"));
            Sizzle("#user_name")[0].innerHTML = "未登录";
            Sizzle("#user_avatar")[0].removeAttribute("style");
        } else {
            alert("修改出错！");
        }
    }
}

function change_avatar_modal() {
    if (check_login()) {
        let modal = Sizzle("#change_avatar_modal")[0];
        modal.removeAttribute("hidden");
    } else {
        alert("请登录！");
    }
}

async function change_avatar_submit() {
    let data = new FormData();
    let file = Sizzle("#change_avatar")[0].files[0];
    data.append("file", file);
    let filename = file.name.substring(0, file.name.lastIndexOf("."));
    let extend = file.name.substring(file.name.lastIndexOf("."), file.name.length);
    let r = await fetch("functions/UploadAvatar.jsp", {
        method: "POST",
        headers: {"token": JSON.stringify(token)},
        body: data
    });
    let j = await r.json();
    if (j.state === "0") {
        let new_avatar = j.data.filename;
        setCookie("avatar_path", new_avatar);
        Sizzle("#user_avatar")[0].setAttribute("src", avatar_prefix + getCookie("avatar_path"));
        alert("修改成功！");
        Sizzle("#change_avatar")[0].value = "";
        Sizzle("#change_avatar_modal")[0].setAttribute("hidden", "");
    } else {
        alert("修改失败！");
    }
}

async function upload_file_submit() {
    let data = new FormData();
    let file = Sizzle("#upload_file_input")[0].files[0];
    data.append("file", file);
    let r = await fetch("functions/UploadFile.jsp", {
        method: "POST",
        headers: {"token": JSON.stringify(token)},
        body: data
    });
    console.log(r);
    let j = await r.json();
    console.log(j);
    if (j.state === "0") {
        let filename = j.data.filename;
        Sizzle("#upload_file_input")[0].value = "";
        insert_at_cursor(field, "[img]" + filename + "[/img]");
    } else {
        alert("上传失败！");
    }
}

function bbcode_translate(str) {
    let format_search = [
        /\[b\](.*?)\[\/b\]/ig,
        /\[i\](.*?)\[\/i\]/ig,
        /\[u\](.*?)\[\/u\]/ig,
        /\[img\](.*?)\[\/img\]/ig,
        /\[emo\](.*?)\[\/emo\]/ig
    ];
    let format_replace = [
        "<strong>$1</strong>",
        "<em>$1</em>",
        "<span style='text-decoration: underline;'>$1</span>",
        "<img src='uploads/files/$1' alt='image' class='content-image'>",
        "<span class='emoticons emo-$1'></span>"
    ];
    for (let i = 0; i < format_search.length; i++) {
        str = str.replace(format_search[i], format_replace[i]);
    }
    return str;
}

function bbcode_translate_without_img(str) {
    let format_search = [
        /\[b\](.*?)\[\/b\]/ig,
        /\[i\](.*?)\[\/i\]/ig,
        /\[u\](.*?)\[\/u\]/ig,
        /\[img\](.*?)\[\/img\]/ig,
        /\[emo\](.*?)\[\/emo\]/ig
    ];
    let format_replace = [
        "<strong>$1</strong>",
        "<em>$1</em>",
        "<span style='text-decoration: underline;'>$1</span>",
        "[图片]",
        "<span class='emoticons emo-$1'></span>"
    ];
    for (let i = 0; i < format_search.length; i++) {
        str = str.replace(format_search[i], format_replace[i]);
    }
    return str;
}

function insert_at_cursor(field, insert_value_st = "", insert_value_ed = "") {
    if (field.selectionStart || field.selectionStart == "0") {
        let start_pos = field.selectionStart;
        let end_pos = field.selectionEnd;
        if (start_pos > end_pos) {
            let t = start_pos;
            start_pos = end_pos;
            end_pos = t;
        }

        let scroll_top = field.scrollTop;

        field.value = field.value.substring(0, start_pos) +
            insert_value_st +
            field.value.substring(start_pos, end_pos) +
            insert_value_ed +
            field.value.substring(end_pos);
        if (scroll_top > 0) field.scrollTop = scroll_top;
        field.focus();
        field.selectionStart = start_pos + insert_value_st.length;
        field.selectionEnd = end_pos + insert_value_st.length;
    } else {
        field.value += insert_value_st + insert_value_ed;
        field.focus();
    }
}

function init_emoticons() {
    let panels = Sizzle(".emoticon-panel");
    for (let i = 0; i < panels.length; i++) {
        for (let j = 1; j <= 50; j++) {
            panels[i].innerHTML += "<span class='emoticons emo-" + j + "' onclick='insert_at_cursor(field, \"[emo]" + j + "[/emo]\")' style='cursor: pointer;'></span>";
        }
    }
}