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
    static class DatabaseAccess {
        private static String connectString = "jdbc:mysql://" + SiteConfig.db_host + ":" + SiteConfig.db_port + "/" + SiteConfig.db_name
                + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&useSSL=false";

        private static Connection connection;

        private static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

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
        public static Long addUser(String username, String password) {
            if (username == null || password == null) return null;
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("INSERT INTO `users` (`username`, `password`) VALUES (?, ?)",
                                Statement.RETURN_GENERATED_KEYS);
                preparedStatement.setString(1, SiteUtils.HtmlFilter(username));
                preparedStatement.setString(2, SiteUtils.MD5(password + SiteConfig.passwd_salt));
                int affectedRows = preparedStatement.executeUpdate();
                if (affectedRows > 0) {
                    ResultSet resultSet = preparedStatement.getGeneratedKeys();
                    if (resultSet.next()) {
                        Long uid = resultSet.getLong(1);
                        resultSet.close();
                        preparedStatement.close();
                        return uid;
                    } else {
                        resultSet.close();
                        preparedStatement.close();
                    }
                } else preparedStatement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        // 删除用户（伪删除）
        public static Boolean deleteUser(Object user) {
            if (user == null) return false;
            PreparedStatement preparedStatement;
            try {
                if (String.class.isInstance(user)) {
                    preparedStatement =
                            connection.prepareStatement("UPDATE `users` SET `role` = -1 WHERE `username` = ?");
                    preparedStatement.setString(1, (String) user);
                } else if (Long.class.isInstance(user)) {
                    preparedStatement =
                            connection.prepareStatement("UPDATE `users` SET `role` = -1 WHERE `uid` = ?");
                    preparedStatement.setLong(1, (Long) user);
                } else throw new Exception("The type of the argument should be String or Long.");
                int affectedRows = preparedStatement.executeUpdate();
                preparedStatement.close();
                return affectedRows > 0;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        // 从用户名得到 uid
        public static Long getUidByUsername(String username) {
            if (username == null) return null;
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("SELECT `uid` FROM `users` WHERE `username` = ?");
                preparedStatement.setString(1, username);
                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    Long uid = resultSet.getLong(1);
                    resultSet.close();
                    preparedStatement.close();
                    return uid;
                } else {
                    resultSet.close();
                    preparedStatement.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        // 从 uid 得到用户名
        public static String getUsernameByUid(Long uid) {
            if (uid == null) return null;
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("SELECT `username` FROM `users` WHERE `uid` = ?");
                preparedStatement.setLong(1, uid);
                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    String username = resultSet.getString("username");
                    resultSet.close();
                    preparedStatement.close();
                    return username;
                } else {
                    resultSet.close();
                    preparedStatement.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

//        public static Boolean deleteUser(Long uid) {
//            if (uid == null) return false;
//            try {
//                PreparedStatement preparedStatement =
//                        connection.prepareStatement("UPDATE `users` SET `role` = -1 WHERE `uid` = ?");
//                preparedStatement.setInt(1, uid);
//                int effectedRows = preparedStatement.executeUpdate();
//                preparedStatement.close();
//                return effectedRows > 0;
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//            return false;
//        }

        // 检查用户有效性
        public static Boolean validUser(Object user, Integer role) {
            if (user == null) return false;
            if (role == null) role = 0;
            PreparedStatement preparedStatement;
            ResultSet resultSet;
            try {
                if (String.class.isInstance(user)) {
                    preparedStatement =
                            connection.prepareStatement("SELECT * FROM `users` WHERE `username` = ? AND `role` >= ?");
                    preparedStatement.setString(1, (String) user);
                    preparedStatement.setInt(2, role);
                } else if (Long.class.isInstance(user)) {
                    preparedStatement =
                            connection.prepareStatement("SELECT * FROM `users` WHERE `uid` = ? AND `role` >= ?");
                    preparedStatement.setLong(1, (Long) user);
                    preparedStatement.setInt(2, role);
                } else throw new Exception("The type of the argument should be String or Long.");
                resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    resultSet.close();
                    preparedStatement.close();
                    return true;
                } else {
                    resultSet.close();
                    preparedStatement.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        // 获取用户等级（包括已删除的）
        public static Integer getLevel(Object user) {
            if (user == null) return null;
            ResultSet resultSet;
            PreparedStatement preparedStatement;
            try {
                if (String.class.isInstance(user)) {
                    preparedStatement =
                            connection.prepareStatement("SELECT `role` FROM `users` WHERE `username` = ?");
                    preparedStatement.setString(1, (String) user);
                } else if (Long.class.isInstance(user)) {
                    preparedStatement =
                            connection.prepareStatement("SELECT `role` FROM `users` WHERE `uid` = ?");
                    preparedStatement.setLong(1, (Long) user);
                } else throw new Exception("The type of the argument should be String or Long.");
                resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    Integer level = resultSet.getInt("role");
                    resultSet.close();
                    preparedStatement.close();
                    return level;
                } else {
                    resultSet.close();
                    preparedStatement.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

//        public static Boolean validUser(Long uid) {
//            if (uid == null) return false;
//            try {
//                PreparedStatement preparedStatement =
//                        connection.prepareStatement("SELECT * FROM `users` WHERE `uid` = ? AND `role` >= 0");
//                preparedStatement.setInt(1, uid);
//                ResultSet resultSet = preparedStatement.executeQuery();
//                if (resultSet.next()) {
//                    resultSet.close();
//                    preparedStatement.close();
//                    return true;
//                }
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//            return false;
//        }

        // 获取新 token
        public static Json.Token getNewToken(String username, String password, Long expiration) {
            if (username == null || password == null || expiration == null) return null;
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
                    return new Json.Token(username,
                            SiteUtils.MD5(username + expiration + SiteConfig.token_salt),
                            expiration);
                } else {
                    resultSet.close();
                    preparedStatement.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        // 检验 Token 有效性
        public static Boolean checkToken(Json.Token token) {
            if (token == null) return false;
            String username = token.username;
            String tokenStr = token.token;
            Long expiration = token.expiration;
            if (username == null || tokenStr == null || expiration == null) return false;
            if (!validUser(username, null)) return false;
            return tokenStr.equals(SiteUtils.MD5(username + expiration + SiteConfig.token_salt))
                    && (expiration > SiteUtils.getTimeStamp());
        }

        // 发新贴
        public static Long newPost(Object user, String content) {
            Long uid;
            if (String.class.isInstance(user)) uid = getUidByUsername((String) user);
            else uid = (Long) user;
            content = SiteUtils.HtmlFilter(content);
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("INSERT INTO `posts` (`uid`, `p_content`, `p_datetime`) VALUES (?, ?, ?)",
                                Statement.RETURN_GENERATED_KEYS);
                String p_datetime = simpleDateFormat.format(new Date());
                preparedStatement.setLong(1, uid);
                preparedStatement.setString(2, content);
                preparedStatement.setString(3, p_datetime);
                Integer affectedRows = preparedStatement.executeUpdate();
                if (affectedRows > 0) {
                    ResultSet resultSet = preparedStatement.getGeneratedKeys();
                    if (resultSet.next()) {
                        Long pid = resultSet.getLong(1);
                        resultSet.close();
                        preparedStatement.close();
                        return pid;
                    } else {
                        resultSet.close();
                        preparedStatement.close();
                    }
                } else {
                    preparedStatement.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return -1L;
        }

        // 获得帖子状态
        public static Integer getPostState(Long pid) {
            if (pid == null) return null;
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("SELECT `state` FROM `posts` WHERE `pid` = ?");
                preparedStatement.setLong(1, pid);
                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    Integer state = resultSet.getInt(1);
                    resultSet.close();
                    preparedStatement.close();
                    return state;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        // 删除帖子（伪删除）
        public static Boolean deletePost(Long pid) {
            if (pid == null) return false;
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("UPDATE `posts` SET `state` = 1 WHERE `pid` = ?");
                preparedStatement.setLong(1, pid);
                int affectedRows = preparedStatement.executeUpdate();
                if (affectedRows > 0) {
                    preparedStatement.close();
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        // 获得某篇帖子
        public static Json.Post getPostByPid(Long pid) {
            if (pid == null) return null;
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("SELECT * FROM `posts` WHERE `pid` = ?");
                preparedStatement.setLong(1, pid);
                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    Json.Post post = new Json.Post(pid,
                            resultSet.getLong("uid"),
                            getUsernameByUid(resultSet.getLong("uid")),
                            resultSet.getString("p_title"),
                            resultSet.getString("p_content"),
                            resultSet.getString("p_datetime"),
                            resultSet.getLong("p_floor"),
                            resultSet.getLong("r_uid"),
                            resultSet.getString("r_datetime"),
                            resultSet.getInt("state"));
                    resultSet.close();
                    preparedStatement.close();
                    return post;
                } else {
                    preparedStatement.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        // 获取某篇帖子的楼层数
        public static Long getFloorsByPid(Long pid) {
            if (pid == null) return null;
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("SELECT `p_floor` FROM `posts` WHERE `pid` = ?");
                preparedStatement.setLong(1, pid);
                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    Long floors = resultSet.getLong("p_floor");
                    resultSet.close();
                    preparedStatement.close();
                    return floors;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        // 获得早于某时间的 N 篇帖子
        public static Json.Posts getPosts(String datetime, Integer limit) {
            if (datetime == null) datetime = simpleDateFormat.format(new Date());
            if (limit == null) limit = 10;
            try {
                PreparedStatement preparedStatement =
                        connection.prepareStatement("SELECT * FROM `posts` WHERE `p_datetime` < ? AND `state` = 0 LIMIT ?");
                preparedStatement.setString(1, datetime);
                preparedStatement.setInt(2, limit);
                ResultSet resultSet = preparedStatement.executeQuery();
                Json.Posts posts = new Json.Posts();
                while (resultSet.next()) {
                    Json.Post post = new Json.Post(resultSet.getLong("pid"),
                            resultSet.getLong("uid"),
                            getUsernameByUid(resultSet.getLong("uid")),
                            resultSet.getString("p_title"),
                            resultSet.getString("p_content"),
                            resultSet.getString("p_datetime"),
                            resultSet.getLong("p_floor"),
                            resultSet.getLong("r_uid"),
                            resultSet.getString("r_datetime"),
                            resultSet.getInt("state"));
                    posts.posts.add(post);
                }
                resultSet.close();
                preparedStatement.close();
                return posts;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        // 发回复，返回 cid
        public static Long addComment(Json.Comment comment) {
            if (comment == null) return null;
            Long pid = comment.pid;
            Long uid = comment.uid;
            Long r_floor = comment.r_floor;
            String c_content = comment.c_content;
            String c_datetime = simpleDateFormat.format(new Date());
            if (pid == null || uid == null || c_content == null) return null;
            PreparedStatement preparedStatement;
            ResultSet resultSet;
            try {
                if (r_floor == null) {
                    preparedStatement =
                            connection.prepareStatement("INSERT INTO `comments` (`pid`, `uid`, `c_content`, `c_datetime`) VALUES (?, ?, ?, ?)",
                                    Statement.RETURN_GENERATED_KEYS);
                    preparedStatement.setLong(1, pid);
                    preparedStatement.setLong(2, uid);
                    preparedStatement.setString(3, c_content);
                    preparedStatement.setString(4, c_datetime);
                    Integer affectedRows = preparedStatement.executeUpdate();
                    if (affectedRows > 0) {
                        resultSet = preparedStatement.getGeneratedKeys();
                        if (resultSet.next()) {
                            Long cid = resultSet.getLong(1);
                            resultSet.close();
                            preparedStatement.close();
                            return cid;
                        }
                    } else {
                        preparedStatement.close();
                        return null;
                    }
                } else {
                    preparedStatement =
                            connection.prepareStatement("INSERT INTO `comments` (`pid`, `uid`, `c_content`, `c_datetime`, `r_floor`) VALUES (?, ?, ?, ?, ?)");
                    preparedStatement.setLong(1, pid);
                    preparedStatement.setLong(2, uid);
                    preparedStatement.setString(3, c_content);
                    preparedStatement.setString(4, c_datetime);
                    preparedStatement.setLong(5, r_floor);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }
    }
%>
<%
    request.setCharacterEncoding("utf-8");
%>
