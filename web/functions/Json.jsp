<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/11/29
  Time: 17:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.security.MessageDigest, java.sql.*" %>
<%--<%@ include file="SiteConfig.jsp" %>--%>
<%!

    static class Json {
        // 消息模板类
        static class Message {
            public String state;
            public String message;

            public Message() {
                state = "0";
                message = "No news is the best news.";
            }

            public Message(String state, String message) {
                this.state = state;
                this.message = message;
            }
        }

        // just for test
        static class Messages {
            public ArrayList<String> states = new ArrayList<>();
            public ArrayList<String> messages = new ArrayList<>();

//            public Messages() {
//                states.add("0");
//                messages.add("No news is the best news.");
//            }
//
//            public Messages(String state, String message) {
//                this.states.add(state);
//                this.messages.add(message);
//            }
        }

        // 帖子模板类
        static class Post {
            public Long pid;
            public Long uid;
            public String username;
            public String p_content;
            public String p_datetime;
            public Long p_floor;
            public Integer state;

            public Post() {
                pid = null;
                uid = null;
                username = null;
                p_content = null;
                p_datetime = null;
                p_floor = null;
                state = null;
            }

            public Post(Long pid, Long uid, String username, String p_content, String p_datetime, Long p_floor, Integer state) {
                this.pid = pid;
                this.uid = uid;
                this.username = username;
                this.p_content = p_content;
                this.p_datetime = p_datetime;
                this.p_floor = p_floor;
                this.state = state;
            }
        }

        // 多篇帖子模板类
        static class Posts {
            public List<Long> pids;
        }

        // 用户模板类
        static class User {
            public Long uid;
            public String username;
            // 密码为原文或密文，取决于数据来自客户端或数据库
            public String password;
            public Integer role;

            public User() {
                uid = null;
                username = null;
                password = null;
                role = null;
            }

            public User(Long uid, String username, String password, Integer role) {
                this.uid = uid;
                this.username = username;
                this.password = password;
                this.role = role;
            }
        }
    }
%>
<%
    request.setCharacterEncoding("utf-8");
%>