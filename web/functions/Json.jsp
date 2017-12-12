<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/11/29
  Time: 17:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.security.MessageDigest, java.sql.*" %>
<%@ include file="SiteConfig.jsp" %>
<%!

    static class Json {
        // 消息模板类
        static class Message {
            public String state;
            public String message;
            public Object data;

            public Message() {
                state = "0";
                message = "No news is the best news.";
            }

            public Message(String state, String message) {
                this.state = state;
                this.message = message;
                this.data = null;
            }

            public Message(String state, String message, Object data) {
                this.state = state;
                this.message = message;
                this.data = data;
            }
        }

        // just for test
        static class Messages {
            public ArrayList<String> states = new ArrayList<>();
            public ArrayList<String> messages = new ArrayList<>();
        }

        // 用户模板类
        static class User {
            public Long uid;
            public String username;
            // 密码为原文或密文，取决于数据来自客户端或数据库
            public String password;
            public Integer role;
            public String avatar;

            public User() {
                uid = null;
                username = null;
                password = null;
                role = null;
                avatar = null;
            }

            public User(Long uid, String username, String password, Integer role) {
                this.uid = uid;
                this.username = username;
                this.password = password;
                this.role = role;
                this.avatar = SiteConfig.avatar_path + "default.png";
            }

            public User(Long uid, String username, String password, Integer role, String avatar) {
                this.uid = uid;
                this.username = username;
                this.password = password;
                this.role = role;
                this.avatar = SiteConfig.avatar_path + avatar;
            }
        }

        // 帖子模板类
        static class Post {
            public Long pid;
            public Long uid;
            public String username;
            public String p_title;
            public String p_content;
            public String p_datetime;
            public Long p_floor;
            // r_uid and r_datetime should be se value manually
            public Long r_uid;
            public String r_datetime;
            public Integer state;

            public Post() {
                pid = null;
                uid = null;
                username = null;
                p_title = null;
                p_content = null;
                p_datetime = null;
                p_floor = null;
                r_uid = null;
                r_datetime = null;
                state = null;
            }

            public Post(Long pid, Long uid, String username, String p_title, String p_content, String p_datetime, Long p_floor, Long r_uid, String r_datetime, Integer state) {
                this.pid = pid;
                this.uid = uid;
                this.username = username;
                this.p_title = p_title;
                this.p_content = p_content;
                this.p_datetime = p_datetime;
                this.p_floor = p_floor;
                this.r_uid = r_uid;
                this.r_datetime = r_datetime;
                this.state = state;
            }
        }

        // 多篇帖子模板类
        static class Posts {
            public ArrayList<Post> posts = new ArrayList<>();
        }

        // Token 模板类
        static class Token {
            public String username;
            public String token;
            public Long expiration;

            public Token() {
                username = null;
                token = null;
                expiration = null;
            }

            public Token(String username, String token, Long expiration) {
                this.username = username;
                this.token = token;
                this.expiration = expiration;
            }
        }

        // 评论模板类
        static class Comment {
            public Long cid;
            public Long pid;
            public Long uid;
            public String username;
            public Long c_floor;
            public Long r_floor;
            public String c_content;
            public String c_datetime;
            public Integer state;

            public Comment() {
                cid = null;
                pid = null;
                uid = null;
                username = null;
                c_floor = null;
                r_floor = null;
                c_content = null;
                c_datetime = null;
                state = null;
            }

            public Comment(Long cid, Long pid, Long uid, String username, Long c_floor, Long r_floor,
                           String c_content, String c_datetime, Integer state) {
                this.cid = cid;
                this.pid = pid;
                this.uid = uid;
                this.username = username;
                this.c_floor = c_floor;
                this.r_floor = r_floor;
                this.c_content = c_content;
                this.c_datetime = c_datetime;
                this.state = state;
            }
        }

        // 多条评论模板类
        static class Comments {
            public ArrayList<Comment> comments = new ArrayList<>();
        }

        // 多条帖子请求模板类
        static  class PostsRequest {
            public String datetime;
            public Integer limit;
        }
    }
%>
<%
    request.setCharacterEncoding("utf-8");
%>