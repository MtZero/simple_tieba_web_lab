<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/11/29
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ include file="SiteConfig.jsp" %>
<%@ include file="SiteUtils.jsp" %>
<%!
    public static class DatabaseAccess {
        private static String connectString = "jdbc:mysql://" + SiteConfig.db_host + ":" + SiteConfig.db_port + "/" + SiteConfig.db_name
                + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

        private static Connection connection;

        // 建立数据库连接
        public static Boolean EstablishConnection() {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(connectString, SiteConfig.db_user, SiteConfig.db_pass);
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
                        connection.prepareStatement("INSERT INTO `users` (`username`, `password`) VALUES (?, ?)");
                preparedStatement.setString(1, SiteUtils.HtmlFilter(username));
                preparedStatement.setString(2, SiteUtils.MD5(password + SiteConfig.passwd_salt));
                int effectedRows = preparedStatement.executeUpdate();
                if (effectedRows > 0) {
                    preparedStatement =
                            connection.prepareStatement("SELECT `uid` FROM `users` WHERE `username` = ?");
                    preparedStatement.setString(1, username);
                    ResultSet resultSet = preparedStatement.executeQuery();
                    if (resultSet.next()) {
                        return resultSet.getInt("uid");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        // 删除用户（伪删除）
        public static Boolean deleteUser(String username) {
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("UPDATE `users` SET `role` = -1 WHERE `username` = ?");
                preparedStatement.setString(1, username);
                int effectedRows = preparedStatement.executeUpdate();
                return effectedRows > 0;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        // 获取新 token
        public static String getNewToken(String username, String password, Long expiration) {
            try {
                String encryptedPassword = SiteUtils.MD5(password + SiteConfig.passwd_salt);
                PreparedStatement preparedStatement =
                        connection.prepareStatement("SELECT * FROM `users` WHERE `username` = ? AND `password` = ? AND `role` >= 0");
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, encryptedPassword);
                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    return SiteUtils.MD5(username + expiration + SiteConfig.token_salt);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return "";
        }

        // 检验 Token 有效性
        public static Boolean checkToken(String username, String token, Long expiration) {
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("SELECT * FROM `users` WHERE `username` = ? AND `role` >= 0");
                preparedStatement.setString(1, username);
                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    return token.equals(SiteUtils.MD5(username + expiration + SiteConfig.token_salt))
                            && (expiration > SiteUtils.getTimeStamp());
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

    }
%>
<%
    request.setCharacterEncoding("utf-8");
%>
