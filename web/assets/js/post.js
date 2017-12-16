async function load_pid_post(pid) {
    let r = await fetch("functions/Interface.jsp?intent=get_post_by_pid", {
        method: "POST",
        body: JSON.stringify({"pid": pid})
    });
    let j = await r.json();

    if (j.state === "0") {
        let data = j.data;
        Sizzle("#content")[0].innerHTML += format_post(data);
    }

    r = await fetch("functions/Interface.jsp?intent=get_comments_desc", {
        method: "POST",
        body: JSON.stringify({"pid": pid})
    });
    j = await r.json();
    if (j.state === "0") {
        let data = j.data.comments;
        let len = data.length;
        for (let i = 0; i < len; i++) {
            Sizzle("#content")[0].innerHTML += format_comment(data[i]);
        }
    }

}

function format_post(data) {
    let id = data.id;
    let username = data.username;
    let r_datetime = data.r_datetime;
    let title = data.p_title;
    let content = bbcode_translate(data.p_content);
    let floor = data.p_floor;
    let ret =
        '    <div id="post_outer_' + id + '" class="post-outer panel">\n' +
        '        <div id="post_title_' + id + '" class="post-title">\n' +
        '            ' + title + '\n' +
        '        </div>\n' +
        '        <div class="dash"></div>\n' +
        '        <div id="post_content_' + id + '" class="post-content-in-page">\n' +
        '            <p>' + content + '</p>\n' +
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

function format_comment(data) {
    let cid = data.cid;
    let pid = data.pid;
    let uid = data.uid;
    let c_floor = data.c_floor;
    let r_floor = data.r_floor;
    let c_content = bbcode_translate(data.c_content);
    let c_datetime = data.c_datetime;
    let c_state = data.c_state;
    let username = data.username;
    let return_html = "";
    // 管理员删除功能，很不优雅的实现
    if (token !== undefined) if (token.username !== undefined) if (token.username === "admin") {
        return_html = "<span class='delete-comment' onclick='delete_comment("+cid+")'><i class='fa fa-trash'></i></span>"
    }
    if (r_floor === 0) {
        return_html += '<span class="comment-floor">' + '#' + c_floor + '</span>&nbsp;&nbsp;\n';
    } else {
        return_html += '<span class="comment-floor">' + '#' + c_floor + ' → #' + r_floor + '</span>&nbsp;&nbsp;\n';
    }
    let ret =
        '    <div id="comment_outer_' + cid + '" class="comment-outer panel">\n' +
        '        <div id="comment_content_' + cid + '" class="comment-content">\n' +
        '            <a id="comment_content_link_' + cid + '" class="comment-content-link" >\n' +
        '                ' + c_content + '\n' +
        '            </a>\n' +
        '        </div>\n' +
        '        <div id="comment_footer_' + cid + '" class="comment-footer">\n' +
        '            <i class="fa fa-user"></i>\n' +
        '            <span id="comment_author_' + uid + '">' + username + '</span>&nbsp;&nbsp;\n' +
        '            <i class="fa fa-calendar"></i>\n' +
        '            <span id="comment_last_reply_' + cid + '">' + c_datetime + '</span>&nbsp;&nbsp;\n' +
        '            <i class="fa fa-reply comment-reply" onclick="write_new_comment_modal(' + pid + ',' + c_floor + ')"></i>\n' +
        return_html +
        '        </div>\n' +
        '    </div>\n';

    return ret;
}

function write_new_comment_modal(pid = null, r_floor = null) {
    if (check_login()) {
        let modal = Sizzle("#write_new_comment_modal")[0];
        Sizzle("#post_title_input")[0].setAttribute("hidden", "");
        if (r_floor !== null) {
            Sizzle("#write_new_comment_title")[0].innerHTML = "回复 #" + r_floor;
            Sizzle("#write_new_comment_submit")[0].setAttribute("onclick", "write_new_comment_submit(" + pid + ", " + r_floor + ")");
        } else {
            Sizzle("#write_new_comment_title")[0].innerHTML = "发表回复";
            Sizzle("#write_new_comment_submit")[0].setAttribute("onclick", "write_new_comment_submit(" + pid + ")");
        }
        modal.removeAttribute("hidden");
    } else {
        alert("请登录！");
    }
}

async function write_new_comment_submit(pid = null, r_floor = null) {
    let c_content = Sizzle("#comment_input_content")[0].value;
    let body = {"pid": pid, "c_content": c_content};
    if (r_floor !== null || r_floor !== undefined) body.r_floor = r_floor;
    let r = await fetch("functions/Interface.jsp?intent=add_comment", {
        method: "POST",
        headers: {"token": JSON.stringify(token)},
        body: JSON.stringify(body)
    });
    let j = await r.json();
    if (j.state === "0") {
        Sizzle("#write_new_comment_modal")[0].setAttribute("hidden", "");
        Sizzle("#comment_input_content")[0].value = "";
        location.reload(true);
    } else {
        alert("回复失败！");
    }
}

async function delete_comment(cid) {
    if (confirm("确认要删除评论吗？")) {
        let r = await fetch("functions/Interface.jsp?intent=delete_comment", {
            method: "POST",
            headers: {"token": JSON.stringify(token)},
            body: JSON.stringify({"cid": cid})
        });
        let j = await r.json();
        if (j.state === "0") {
            location.reload(true);
        } else {
            alert("删除失败！");
        }
    }
}