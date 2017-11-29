<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/11/29
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="com.sun.deploy.config.Config" %>
<%@ include file="Config.jsp"%>
<%@ include file="Utils.jsp"%>
<%!
    public static class DatabaseAccess {
        private static String connectString = "jdbc:mysql://" + Config.db_host + ":" + Config.db_port + "/" + Config.db_name
                + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

        private static Connection connection;

        // 建立数据库连接
        public static Boolean EstablishConnection() {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(connectString, Config.db_user, Config.db_pass);
                return true;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        // TODO 各功能模块

        // 添加用户
        public static Integer addUser(String username, String password) {
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("INSERT INTO `users` (username, password) VALUES (?, ?)");
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, Utils.MD5(password + Config.passwd_salt));
                int effectedRows = preparedStatement.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return -1;
        }

    }
%>
<%
    request.setCharacterEncoding("utf-8");
%>
