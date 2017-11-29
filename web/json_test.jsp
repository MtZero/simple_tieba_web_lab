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
<%@ include file="functions/Json.jsp" %>
<%@ include file="functions/DatabaseAccess.jsp" %>
<%!
    public class json_class {
        public String data;
        public String message;
        public int de;
    }
%>
<%
    request.setCharacterEncoding("utf-8");
    Message json = new Message();
    Gson gson = new Gson();
    String json_string = gson.toJson(json);
    Message new_json = gson.fromJson(json_string, Message.class);
    out.print(json_string);
    out.print("<br>");
    out.print(new_json.state);
    out.print(new_json.message);
    out.print("<br>");
    out.print(new Date().getTime() / 1000);
    out.print("<br>");
    DatabaseAccess.EstablishConnection();
//    Long uid = DatabaseAccess.addUser("blablaaa", "1");
//    out.print("uid: " + uid);
    Long exp = SiteUtils.getTimeStamp();
    String tok1 = DatabaseAccess.getNewToken("blabla", "1", exp + 100);
    String tok2 = DatabaseAccess.getNewToken("blabla", "1", exp - 100);
    out.print(tok1 + "<br>" + tok2 + "<br>");
    out.print(DatabaseAccess.checkToken("blabla", tok1, exp + 100));
    out.print(DatabaseAccess.checkToken("blabla", tok2, exp - 100));
    out.print("<br>");
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String datetime = simpleDateFormat.format(new Date());
    out.print(datetime + "<br>");

    DatabaseAccess.killConnection();

    out.print(SiteUtils.MD5("1"));
%>