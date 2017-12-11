<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/12/10
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.io.BufferedReader" %>
<%@ include file="DatabaseAccess.jsp" %>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        Gson gson = new Gson();

        // 获得 post 的数据
        StringBuffer stringBuffer = new StringBuffer();
        String line = null;
        try {
            BufferedReader bufferedReader = request.getReader();
            while ((line = bufferedReader.readLine()) != null) {
                stringBuffer.append(line);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String data = stringBuffer.toString();
        // 获得客户端的操作意图
        String intent = request.getParameter("intent");
        // 获得客户端的 token（如果有）
        String token_json = request.getHeader("token");

        Json.Token token = null;
        Json.User user = null;
        Json.Post post = null;
        Json.Comment comment = null;

        if (token_json != null) {
            token = gson.fromJson(token_json, Json.Token.class);
        }
        if (intent != null && !data.equals("")) {
            DatabaseAccess.establishConnection();
            switch (intent) {
                case "register":  // 注册新用户
                    user = gson.fromJson(data, Json.User.class);
                    Long uid = DatabaseAccess.addUser(user.username, user.password);
                    if (uid == null) {
                        out.print(gson.toJson(new Json.Message("1", "Maybe you can try another username. null")));
                    } else if (uid <= 0) {
                        out.print(gson.toJson(new Json.Message("1", "Maybe you can try another username. <=0")));
                    } else {
                        out.print(gson.toJson(new Json.Message()));
                    }
                    break;

                case "modify_user":  // 修改用户
                    user = gson.fromJson(data, Json.User.class);
                    if (DatabaseAccess.checkToken(token)) {
                        if (DatabaseAccess.getLevel(token.username) > 1 || token.username.equals(user.username)) {
                            Long _uid = DatabaseAccess.getUidByUsername(user.username);
                            Json.User oldUser = DatabaseAccess.getUserByUid(_uid);
                            if (user.password != null) oldUser.password = user.password;
                            if (user.avatar != null) oldUser.avatar = user.avatar;
                            Boolean state = DatabaseAccess.modifyUser(oldUser);
                            if (state) {
                                out.print(gson.toJson(new Json.Message()));
                            } else {
                                out.print(gson.toJson(new Json.Message("1", "Something went wrong when updating profile.")));
                            }
                        } else {
                            out.print(gson.toJson(new Json.Message("1", "You are not able to modify this user!")));
                        }
                    } else {
                        out.print(gson.toJson(new Json.Message("1", "Bad token!")));
                    }
                    break;

                case "delete_user":  // 删除用户
                    user = gson.fromJson(data, Json.User.class);
                    if (DatabaseAccess.checkToken(token)) {
                        if (DatabaseAccess.getLevel(token.username) > 10) {
                            Boolean state = DatabaseAccess.deleteUser(user.username);
                            if (state) {
                                out.print(gson.toJson(new Json.Message()));
                            } else {
                                out.print(gson.toJson(new Json.Message("1", "Failed to delete!")));
                            }
                        } else {
                            out.print(gson.toJson(new Json.Message("1", "You are not able to delete users!")));
                        }
                    } else {
                        out.print(gson.toJson(new Json.Message("1", "Bad token!")));
                    }
                    break;

                case "sign_in":  // 登录
                    user = gson.fromJson(data, Json.User.class);
                    Json.Token newToken = DatabaseAccess.getNewToken(user.username,
                            user.password,
                            SiteUtils.getTimeStamp() + 86400 * 30);  // 30 天有效期
                    if (newToken != null) {
//                        String newTokenJson = gson.toJson(newToken);
//                        response.setHeader("token", newTokenJson);
                        out.print(gson.toJson(new Json.Message("0", "", newToken)));
                    } else {
                        out.print(gson.toJson(new Json.Message("1", "Invalid username or password!")));
                    }
                    break;

                case "new_post":  // 发新帖
                    if (DatabaseAccess.checkToken(token)) {
                        post = gson.fromJson(data, Json.Post.class);
                        Long pid = DatabaseAccess.newPost(token.username, post.p_title, post.p_content);
                        if (pid != null) {
                            out.print(gson.toJson(new Json.Message()));
                        } else {
                            out.print(gson.toJson(new Json.Message("1", "Failed to add new post!")));
                        }
                    } else {
                        out.print(gson.toJson(new Json.Message("1", "Bad token!")));
                    }
                    break;

                case "delete_post":
                    if (DatabaseAccess.checkToken(token)) {
                        post = gson.fromJson(data, Json.Post.class);
                        if (DatabaseAccess.getLevel(token.username) > 10) {
                            Boolean state = DatabaseAccess.deletePost(post.pid);
                            if (state) {
                                out.print(gson.toJson(new Json.Message()));
                            } else {
                                out.print(gson.toJson(new Json.Message("1", "Failed to delete!")));
                            }
                        }
                    } else {
                        out.print(gson.toJson(new Json.Message("1", "Bad token!")));
                    }
                    break;

                case "add_comment":
                    if (DatabaseAccess.checkToken(token)) {
                        comment = gson.fromJson(data, Json.Comment.class);
                        Long cid = DatabaseAccess.addComment(comment);
                        if (cid != null) {
                            out.print(gson.toJson(new Json.Message()));
                        } else {
                            out.print(gson.toJson(new Json.Message("1", "Failed to add comment!")));
                        }
                    } else {
                        out.print(gson.toJson(new Json.Message("1", "Bad token!")));
                    }
                    break;

                case "delete_comment":
                    if (DatabaseAccess.checkToken(token)) {
                        comment = gson.fromJson(data, Json.Comment.class);
                        if (DatabaseAccess.getLevel(token.username) > 10) {
                            Boolean state = DatabaseAccess.deleteCommentByCid(comment.cid);
                            if (state) {
                                out.print(gson.toJson(new Json.Message()));
                            } else {
                                out.print(gson.toJson(new Json.Message("1", "Failed to delete comment!")));
                            }
                        }
                    }
                    break;

                default:
                    break;
            }
            DatabaseAccess.killConnection();
        } else {
            out.print(gson.toJson(new Json.Message("1", "Empty payload!")));
        }
    }
%>