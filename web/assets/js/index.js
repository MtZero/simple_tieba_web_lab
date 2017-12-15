let earliest_datetime = null;

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function load_new_post(datetime = earliest_datetime, limit = null) {
    let r = await fetch("functions/Interface.jsp?intent=get_posts_by_time", {
        method: "POST",
        body: JSON.stringify({"datetime": datetime, "limit": limit})
    });
    let j = await r.json();
    if (j.state === "0") {
        let data = j.data.posts;
        let len = data.length;
        for (let i = 0; i < len; i++) {
            Sizzle("#posts")[0].innerHTML += format_post_node(data[i]);
        }
        if (len > 0) earliest_datetime = data[len-1].r_datetime;
    }
}

function format_post_node(data) {
    let id = data.pid;
    let username = data.username;
    let r_datetime = data.r_datetime;
    let title = data.p_title;
    let content = bbcode_translate_without_img(data.p_content);
    let floor = data.p_floor;
    let ret =
        '    <div id="post_outer_' + id + '" class="post-outer panel">\n' +
        '        <div id="post_title_' + id + '" class="post-title">\n' +
        '            <a id="post_title_link_' + id + '" class="post-title-link" href="post.jsp?pid=' + id + '">\n' +
        '                ' + title + '\n' +
        '            </a>\n' +
        '        </div>\n' +
        '        <div class="dash"></div>\n' +
        '        <div id="post_content_' + id + '" class="post-content">\n' +
        '            <a id="post_content_link_' + id + '" class="post-content-link" href="post.jsp?pid=' + id + '">\n' +
        '                ' + content + '\n' +
        '            </a>\n' +
        '        </div>\n' +
        '        <div id="post_footer_' + id + '" class="post-footer">\n' +
        '            <i class="fa fa-user"></i>\n' +
        '            <span id="post_author_' + id + '">' + username + '</span>&nbsp;&nbsp;\n' +
        '            <i class="fa fa-calendar"></i>\n' +
        '            <span id="post_last_reply_' + id + '">' + r_datetime + '</span>&nbsp;&nbsp;\n' +
        '            <i class="fa fa-comments"></i>\n' +
        '            <span id="post_floor_' + id + '">' + floor + '</span>\n' +
        '        </div>\n' +
        '    </div>\n';
    return ret;
}

function write_new_post_modal() {
    if (check_login()) {
        Sizzle("#post_title_input")[0].removeAttribute("hidden");
        Sizzle("#write_new_comment_modal")[0].removeAttribute("hidden");
        Sizzle("#write_new_comment_title")[0].innerHTML = "发表新帖";
        Sizzle("#write_new_comment_submit")[0].setAttribute("onclick", "write_new_post_submit()");
    } else {
        alert("请登录！");
    }
}

async function write_new_post_submit() {
    let p_title = Sizzle("#post_title_input")[0].value;
    let p_content = Sizzle("#comment_input_content")[0].value;
    let r = await fetch("functions/Interface.jsp?intent=new_post", {
        method: "POST",
        headers: {"token": JSON.stringify(token)},
        body: JSON.stringify({"p_title": p_title, "p_content": p_content})
    });
    let j = await r.json();
    if (j.state === "0") {
        Sizzle("#post_title_input")[0].setAttribute("hidden", "");
        Sizzle("#write_new_comment_modal")[0].setAttribute("hidden", "");
        sleep(100);
        location.reload(true);
    } else {
        alert("发表失败！");
    }
}