<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/11/29
  Time: 16:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public static class SiteConfig {
        public static String db_host = "172.18.187.234";
        public static String db_port = "53306";
        public static String db_name = "15352443_simple_tieba";
        public static String db_user = "user";
        public static String db_pass = "123";
        public static String site_url = "localhost:8080";
        public static String passwd_salt = "KmZn?yQ67^u=2ccvIaQ-4<PIe9HqBK*,";
        public static String token_salt = "SL,uVbwl{!!9/_:J/W2sF{@Xc.NTG*Mk";
        public static String avatar_path = "uploads/avatar/";
        public static String file_path = "uploads/files/";
    }
%>
<%
    request.setCharacterEncoding("utf-8");
%>