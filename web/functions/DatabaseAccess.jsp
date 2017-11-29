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

        // 结束数据库连接
        public static Boolean killConnection() {
            try {
                connection.close();
                return true;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        // TODO 各功能模块

        // 添加用户
        public static Integer addUser(String username, String password) {
            if (username == null || password == null) return null;
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
                        Integer uid = resultSet.getInt("uid");
                        resultSet.close();
                        preparedStatement.close();
                        return uid;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        // 删除用户（伪删除）
        public static Boolean deleteUser(String username) {
            if (username == null) return false;
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("UPDATE `users` SET `role` = -1 WHERE `username` = ?");
                preparedStatement.setString(1, username);
                int effectedRows = preparedStatement.executeUpdate();
                preparedStatement.close();
                return effectedRows > 0;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        public static Boolean deleteUser(Integer uid) {
            if (uid == null) return false;
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("UPDATE `users` SET `role` = -1 WHERE `uid` = ?");
                preparedStatement.setInt(1, uid);
                int effectedRows = preparedStatement.executeUpdate();
                preparedStatement.close();
                return effectedRows > 0;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        // 检查用户有效性
        public static Boolean validUser(String username) {
            if (username == null) return false;
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("SELECT * FROM `users` WHERE `username` = ? AND `role` >= 0");
                preparedStatement.setString(1, username);
                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    resultSet.close();
                    preparedStatement.close();
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        public static Boolean validUser(Integer uid) {
            if (uid == null) return false;
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("SELECT * FROM `users` WHERE `uid` = ? AND `role` >= 0");
                preparedStatement.setInt(1, uid);
                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    resultSet.close();
                    preparedStatement.close();
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        // 获取新 token
        public static String getNewToken(String username, String password, Long expiration) {
            if (username == null || password == null || expiration == null) return "";
            try {
                String encryptedPassword = SiteUtils.MD5(password + SiteConfig.passwd_salt);
                PreparedStatement preparedStatement =
                        connection.prepareStatement("SELECT * FROM `users` WHERE `username` = ? AND `password` = ? AND `role` >= 0");
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, encryptedPassword);
                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    resultSet.close();
                    preparedStatement.close();
                    return SiteUtils.MD5(username + expiration + SiteConfig.token_salt);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return "";
        }

        // 检验 Token 有效性
        public static Boolean checkToken(String username, String token, Long expiration) {
            if (username == null || token == null || expiration == null) return false;
            if (!validUser(username)) return false;
            return token.equals(SiteUtils.MD5(username + expiration + SiteConfig.token_salt))
                    && (expiration > SiteUtils.getTimeStamp());
        }

        // 发新贴
        public static Integer newPost(Object user, String content) {

            return -1;
        }

    }
%>
<%
    request.setCharacterEncoding("utf-8");
%>
