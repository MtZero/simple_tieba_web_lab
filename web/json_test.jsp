<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/11/29
  Time: 08:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*, java.sql.*, com.google.gson.Gson" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%--<%@ include file="functions/Json.jsp" %>--%>
<%@ include file="functions/DatabaseAccess.jsp" %>
<%!
//    public class json_class {
//        public String data;
//        public String message;
//        public int de;
//    }
%>
<%
    request.setCharacterEncoding("utf-8");
    Json.Message json1 = new Json.Message("0", null);
    Json.Message json2 = new Json.Message("2", "haha\nha");
    Gson gson = new Gson();
    String json_string = gson.toJson(json1);
    Json.Message new_json = gson.fromJson(json_string, Json.Message.class);
    out.print(json_string);
    out.print("<br>");
    out.print(json2.state);
    out.print(json2.message.replaceAll("\n", "<br>"));
    out.print("<br>");
    out.print(new Date().getTime() / 1000);
    out.print("<br>");
    DatabaseAccess.establishConnection();
//    Long uid = DatabaseAccess.addUser("blablaaaaaa", "1");
//    out.print("uid: " + uid);
    Long exp = SiteUtils.getTimeStamp();
    Json.Token tok1 = DatabaseAccess.getNewToken("blabla", "1", exp + 10000000);
    Json.Token tok2 = DatabaseAccess.getNewToken("blabla", "1", exp - 100);
    out.print(tok1.token + "<br>" + tok2.token + "<br>");
    out.print(DatabaseAccess.checkToken(new Json.Token("blabla", tok1.token, exp + 10000000)));
    out.print(DatabaseAccess.checkToken(new Json.Token("blabla", tok2.token, exp - 100)));
    out.print("<br>");
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String datetime = simpleDateFormat.format(new Date());
    out.print(datetime + "<br>");

    DatabaseAccess.killConnection();

    out.print(SiteUtils.MD5("1")+"<br>");

    Json.Messages jsons = new Json.Messages();
    jsons.states.add("0");
    jsons.states.add("1");
    jsons.messages.add("012");
    jsons.messages.add("123");
    String jsons_string = gson.toJson(jsons);
    out.print(jsons_string + "<br>");
    Json.Messages new_jsons = gson.fromJson(jsons_string, Json.Messages.class);
    out.print(new_jsons+"<br>");
    Gson gson2 = new GsonBuilder().create();
    out.print(gson2.toJson(new Json.Message("0", "", tok1)));

%>

<script>
    // var data;
    // fetch("functions/Interface.jsp?intent=get_posts_by_time",{
    //     method: "POST",
    //     headers: {
    //         //"token": "{\"username\":\"blabla\",\"token\":\"d8896ac38cae4e9a04e7a53f6a3685f2\",\"expiration\":1522981462}"
    //     },
    //     body: "{\"datetime\": \"2017-12-31 00:00:00\", \"limit\": 10}"
    // }).then(function(response) {
    //     if (response.ok) {
    //         console.log("response ok!");
    //         console.log(response);
    //         data = response.json();
    //         console.log(data.posts);
    //     } else if (response.status === 401) {
    //         console.log("Authorization failed.");
    //     }
    // }, function(e) {
    //     console.log("error!");
    //     console.log(e);
    // })
    async function load() {
        let r = await fetch("functions/Interface.jsp?intent=new_post", {
            method: "POST",
            headers: {
                "token": "{\"username\":\"blabla\",\"token\":\"d8896ac38cae4e9a04e7a53f6a3685f2\",\"expiration\":1522981462}"
            },
            body: "{\"p_title\": \"2017-12-31 00:00:00\", \"p_content\": 10}"
        });
        let j = await r.json();
        console.log(j);
        console.log(JSON.stringify(j));
    }
    load();
</script>