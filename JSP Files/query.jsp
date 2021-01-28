<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : response
    Created on : Apr 18, 2020, 11:39:45 PM
    Author     : darod
--%>

<% String selectedTable = session.getAttribute("table").toString();%>
<sql:query var="currentTable" dataSource="jdbc/thedreamcompany">
    SELECT * FROM <%=selectedTable%>  
</sql:query>

    <%String selectedOperation = session.getAttribute("operation").toString();%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>query jsp</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
         <table border="0">
            <thead>
                <tr>
                    <th>Query Page</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Currently working with <%=selectedTable%> table to perform a(n) <%=selectedOperation%> operation</td>
                </tr>
                <tr>
                    <td>
                        <form action="queryResult.jsp">                           
                            <strong>Select an attribute:</strong>
                            <select name="attribute">
                                <c:forEach var="columnName" items="${currentTable.columnNames}">
                                <option value="${columnName}">${columnName}</option>
                                </c:forEach>
                            </select>
                            
                            <table border="0"></table>
                            
                            <label for="attributeValue">Attribute value:</label><br>
                            <input type="text" id="attributeValue" name="attributeValue" value="" />

                            <table border="0"></table>
                            
                            <input type="checkbox" id="selectAll" name="selectAll" value="true">
                            <label for="selectAll">View All </label><br>
                            
                            <table border="0"></table>
                            
                            <input type="submit" value="submit" name="submit" />

                            </form>
                        <table border="0"></table>
                        <table border="0"></table>
                        <form action="start.jsp">
                            <input type="submit" value="home" name="home" />
                        </form>
                        
                
                    </td>
                </tr>
            </tbody>
        </table>

    </body>
</html>
