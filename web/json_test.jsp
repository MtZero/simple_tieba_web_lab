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
    DatabaseAccess.EstablishConnection();
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