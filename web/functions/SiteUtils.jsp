<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/11/29
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*, java.security.MessageDigest" %>
<%@ page import="java.util.Date" %>
<%!
    static class SiteUtils {

        // 获得 MD5 值，32 位小写
        public static String MD5(String input) {
            try {
                MessageDigest messageDigest = MessageDigest.getInstance("MD5");
                messageDigest.update(input.getBytes("UTF-8"));
                byte[] b = messageDigest.digest();
                int i;
                StringBuilder buf = new StringBuilder("");
                for (byte aB : b) {
                    i = aB;
                    if (i < 0) {
                        i += 256;
                    }
                    if (i < 16) {
                        buf.append("0");
                    }
                    buf.append(Integer.toHexString(i));
                }
                return buf.toString();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return "";
        }

        // 获取当前时间戳
        public static Long getTimeStamp() {
            return new Date().getTime() / 1000;
        }

        // HTML 特殊符号过滤
        public static String HtmlFilter(String input) {
            return input.replaceAll("&", "&amp;")
                    .replaceAll("<", "&lt;")
                    .replaceAll(">", "&gt;")
                    .replaceAll("\"", "&quot;")
                    .replaceAll("'", "&apos;")
                    .replaceAll(" ", "&nbsp;")
                    .replaceAll("\n", "<br>");
        }

    }
%>
<%
    request.setCharacterEncoding("utf-8");
%>