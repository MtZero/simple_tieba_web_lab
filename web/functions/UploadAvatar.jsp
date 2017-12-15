<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 17/12/15
  Time: 01:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="DatabaseAccess.jsp" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.*,java.util.*, org.apache.commons.io.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%
    // check request method
    if (request.getMethod().equalsIgnoreCase("post")) {
        Boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        // check if is multipart
        if (isMultipart) {
            String token_json = request.getHeader("token");
            // check token
            if (token_json != null) {
                Gson gson = new Gson();
                Json.Token token = gson.fromJson(token_json, Json.Token.class);
                DatabaseAccess.establishConnection();
                // check token
                if (DatabaseAccess.checkToken(token)) {
                    FileItemFactory factory = new DiskFileItemFactory();
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    try {
                        List item = upload.parseRequest(request);
                        Integer i = 0;
                        while (i < item.size()) {
                            FileItem fi = (FileItem) item.get(i);
                            if (fi.isFormField()) {
                                // nothing to do
                            } else {
                                String whole_filename = fi.getName();
                                Integer dot_position = whole_filename.lastIndexOf(".");
                                String filename = whole_filename.substring(0, dot_position);
                                String extend = whole_filename.substring(dot_position);
                                DiskFileItem dfi = (DiskFileItem) fi;
                                if (!fi.getName().trim().equals("")) {
                                    String file_name = FilenameUtils.getName(dfi.getName());
                                    if (file_name.endsWith(".jpg") | file_name.endsWith(".png") | file_name.endsWith(".jpeg")) {
                                        String new_file_name = SiteUtils.MD5(filename + new Date()) + extend;
                                        String path = application.getRealPath("uploads/avatar")
                                                + System.getProperty("file.separator")
                                                + new_file_name;
                                        System.out.println(path);
                                        dfi.write(new File(path));
                                        Long _uid = DatabaseAccess.getUidByUsername(token.username);
                                        Json.User oldUser = DatabaseAccess.getUserByUid(_uid);
                                        oldUser.avatar = new_file_name;
                                        Boolean state = DatabaseAccess.modifyAvatar(oldUser);
                                        if (state) {
                                            out.print(gson.toJson(new Json.Message("0", "", new Json.File(new_file_name))));
                                        } else {
                                            out.print(gson.toJson(new Json.Message("1", "Modifying failed!")));
                                        }
                                    } else {
                                        out.print(gson.toJson(new Json.Message("1", "Wrong type")));
                                    }
                                } else {
                                    out.print(gson.toJson(new Json.Message("1", "No image detected!")));
                                }
                            }
                            i++;
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.print(gson.toJson(new Json.Message("1", "Upload failed!")));
                    }
                }
                DatabaseAccess.killConnection();
            }
        }
    }
%>

