let cookie_prefix = "simple_tieba_";

function close_modal(){
    let modals = Sizzle(".modal-background");
    for (let i=0; i<modals.length; i++){
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
    for (let i=0; i<cookies.length; i++) {
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
        console.log(timestamp, token.expiration);
        if (timestamp / 1000 > token.expiration ||
            token.expiration == null ||
            token.username == null ||
            token.token == null) {
            setCookie("token", "");
            setCookie("avatar_path", "assets/images/default-avatar.jpg");
        } else {
            Sizzle("#when_guest")[0].setAttribute("style", "display: none;");
            Sizzle("#when_login")[0].removeAttribute("style");
            // Sizzle("#when_login")[0].classList.remove("hidden");
            // Sizzle("#when_guest")[0].classList.add("hidden");
            Sizzle("#user_name")[0].innerHTML = token.username;
        }
    } else {
        setCookie("avatar_path", "assets/images/default-avatar.jpg");
    }
    Sizzle("#user_avatar")[0].setAttribute("src", getCookie("avatar_path"));
}

function logout() {
    setCookie("token", undefined);
    setCookie("avatar_path", "assets/images/default-avatar.jpg");
    Sizzle("#when_login")[0].setAttribute("style", "display: none;");
    Sizzle("#when_guest")[0].removeAttribute("style");
    // Sizzle("#when_login")[0].classList.remove("hidden");
    // Sizzle("#when_guest")[0].classList.add("hidden");
    Sizzle("#user_avatar")[0].setAttribute("src", getCookie("avatar_path"));
    Sizzle("#user_name")[0].innerHTML = "未登录";
}

async function login(username=undefined, password=undefined) {
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
    console.log(j);
    if (j.state === "0") {
        token = j.data;
        console.log("new token: ", token);
        setCookie("token", JSON.stringify(token));
        let ur = await fetch("functions/Interface.jsp?intent=get_user", {
            method: "POST",
            headers: {
                "token": JSON.stringify(token)
            },
            body: JSON.stringify({"username": username})
        });

        Sizzle("#when_guest")[0].setAttribute("style", "display: none;");
        Sizzle("#when_login")[0].removeAttribute("style");
        Sizzle("#user_name")[0].innerHTML = token.username;
        Sizzle("#user_avatar")[0].setAttribute("src", getCookie("avatar_path"));
        Sizzle("#login_modal")[0].setAttribute("hidden", "");
    } else {
        alert("帐号或密码不正确！");
    }
}

function login_modal() {
    let modal = Sizzle("#login_modal")[0];
    modal.removeAttribute("hidden");
}