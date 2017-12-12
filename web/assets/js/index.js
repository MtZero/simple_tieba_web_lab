let earliest_datetime = null;
async function load_new_post(datetime = earliest_datetime, limit = null) {
    // if (datetime === null) {
    //     const myDate = new Date();
    //     datetime = myDate.getFullYear() + "-" +
    //         myDate.getMonth() + "-" +
    //         myDate.getDay() + " " +
    //         myDate.getHours() + ":" +
    //         myDate.getMinutes() + ":" +
    //         myDate.getSeconds();
    // }
    let r = await fetch("functions/Interface.jsp?intent=get_posts_by_time", {
        method: "POST",
        body: JSON.stringify({"datetime": datetime, "limit": limit})
    });
    let j = await r.json();
    if (j.state === "0") {
        console.log("reading posts");
        let data = j.data.posts;
        let len = data.length;
        console.log(data);
        console.log(len);
        for (let i = 0; i < len; i++) {
            Sizzle("#posts")[0].innerHTML += format_post_node(data[i]);
        }
        console.log(earliest_datetime);
        if (len > 0) earliest_datetime = data[len-1].r_datetime;
        console.log(earliest_datetime);
    }
}

function format_post_node(data) {
    let id = data.pid;
    let username = data.username;
    let r_datetime = data.r_datetime;
    let title = data.p_title;
    let content = data.p_content;
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