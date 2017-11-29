<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/11/29
  Time: 08:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*, java.sql.*, com.google.gson.Gson" %>
<%@include file="functions/Utils.jsp"%>
<%!
    public class json_class {
        public String data;
        public String message;
        public int de;
    }
%>
<%
    request.setCharacterEncoding("utf-8");
    if (request.getParameter("data") != null) {
//        Class.forName("com.google.gson");
        json_class json = new json_class();
        json.data = "sdfasdfa";
        json.message = "asfa";
        json.de = 3;
        Gson gson = new Gson();
        String json_string = gson.toJson(json);
        out.print(json_string);
    }
    out.print(Utils.MD5("1"));
%>