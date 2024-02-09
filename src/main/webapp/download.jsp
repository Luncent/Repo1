<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Reports"%>
<%
	Reports.printReport();
    String fileName = "List1VP.pdf";
    String filePath = getServletContext().getRealPath("/downloads/" + fileName);
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
    try (java.io.FileInputStream fileInputStream = new java.io.FileInputStream(filePath);
         java.io.OutputStream outputStream = response.getOutputStream();) {
        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = fileInputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
    }
%>