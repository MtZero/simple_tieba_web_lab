async function load_new_post(datetime = null, limit = null) {
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
    return await r.json();
}