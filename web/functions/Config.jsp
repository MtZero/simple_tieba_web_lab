<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/11/29
  Time: 16:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public class Config {
        public static String db_host = "localhost";
        public static String db_port = "3306";
        public static String db_name = "tieba";
        public static String db_user = "root";
        public static String db_pass = "";
        public static String site_url = "localhost:8080";
        public static String passwd_salt = "1alSSFGBco5%g_EEm^ns})+";
    }
%>
<%
    request.setCharacterEncoding("utf-8");
%>