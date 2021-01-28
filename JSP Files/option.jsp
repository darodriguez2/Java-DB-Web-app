<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : index
    Created on : Apr 18, 2020, 11:12:15 PM
    Author     : darod
--%>

<%String table = request.getParameter("table");%>
<%String operation = request.getParameter("operation"); %>
<%session.setAttribute("table", request.getParameter("table"));%>
<%session.setAttribute("operation", request.getParameter("operation"));%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The DreamCompany Database Interface</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <h1>Created by Diego!</h1>


                <% if (operation.equalsIgnoreCase("select")) { %>
                <jsp:include page="query.jsp">
                    <jsp:param name="table" value="<%=table%>"/>
                </jsp:include>
                <%} else if (operation.equalsIgnoreCase("delete")) { %>
                <jsp:include page="delete.jsp">
                    <jsp:param name="table" value="<%=table%>"/>
                </jsp:include>
                <%} else if (operation.equalsIgnoreCase("update")) { %>
                <jsp:include page="update.jsp">
                    <jsp:param name="table" value="<%=table%>"/>
                </jsp:include>
                <%} else if (operation.equalsIgnoreCase("insert")) { %>
                <jsp:include page="insert.jsp">
                    <jsp:param name="table" value="<%=table%>"/>
                </jsp:include>
                <%}%>
                






    </body>
</html>
