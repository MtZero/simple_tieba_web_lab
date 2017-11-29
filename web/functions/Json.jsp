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
    public class Message {
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
%>
<%
    request.setCharacterEncoding("utf-8");
%>