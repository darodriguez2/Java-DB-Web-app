<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : response
    Created on : Apr 18, 2020, 11:39:45 PM
    Author     : darod
--%>

<% String attribute = request.getParameter("attribute");%>
<% String selectedTable = session.getAttribute("table").toString();%>


<% String query = "";%>

<%
    if (selectedTable.equals("employee")) {
        query = "SELECT * FROM employee WHERE ssn = ?";
    } else if (selectedTable.equals("department")) {
        query = "SELECT * FROM department WHERE deptNum = ?";
    } else if (selectedTable.equals("project")) {
        query = "SELECT * FROM project WHERE projNum = ? AND projName = ?";
    } else if (selectedTable.equals("works")) {
        query = "SELECT * FROM works WHERE ssn = ? AND projNum = ? AND projName = ? AND deptNum = ?";
    }
%>

<%
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/thedreamcompany?useSSL=false", "root", "*Ta408Q0u3o@~wb");
    PreparedStatement pStatement = con.prepareStatement(query);
%>

<%if (selectedTable.equalsIgnoreCase("employee")) {
        pStatement.setString(1, request.getParameter("ssn"));
    } else if (selectedTable.equalsIgnoreCase("department")) {
        pStatement.setString(1, request.getParameter("deptNum"));
    } else if (selectedTable.equalsIgnoreCase("project")) {
        pStatement.setString(1, request.getParameter("projNum"));
        pStatement.setString(2, request.getParameter("projName"));
    } else if (selectedTable.equalsIgnoreCase("works")) {
        pStatement.setString(1, request.getParameter("ssn"));
        pStatement.setString(2, request.getParameter("projNum"));
        pStatement.setString(3, request.getParameter("projName"));
        pStatement.setString(4, request.getParameter("deptNum"));
    }
%>
<%
    ResultSet result = pStatement.executeQuery();
    String isEmpty = "false";
    if (result.next() == false) {
        isEmpty = "true";
    }
%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Attribute value</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <%if (isEmpty.equalsIgnoreCase("true")) {%>
    <body>
        <table border="0">
            <tr>
                <th>
                    <p style="color:red"> Unable to update because input is invalid, please enter a valid input or return home</p>
                </th>
            </tr>
            <tr>
                <td>
                    <form action="start.jsp">
                        <input type="submit" value="Return to Home" />
                        <table border="0"></table>

                    </form>
                    <form action="update.jsp">
                        <input type="submit" value="Re-enter value" />
                    </form>
                </td>
            </tr>
        </table>

    </body>
    <%} else {%>
    <table border="0">
        <tbody>
            <tr>
                <td>
                    <%if (attribute.equalsIgnoreCase("managerSSN")) {%>
                    <sql:query var="deciderResult" dataSource="jdbc/thedreamcompany">
                        SELECT ssn FROM salariedEMP 
                    </sql:query>
                    <form action="updateResult.jsp">                           
                        <strong>Select a SSN:</strong>
                        <select name="attributeValue">
                            <c:forEach var="row" items="${deciderResult.rows}">
                                <option value="${row.ssn}">${row.ssn}</option>
                            </c:forEach>
                        </select>   

                        <%session.setAttribute("attribute", request.getParameter("attribute"));%>
                        <%session.setAttribute("deptNum", request.getParameter("deptNum"));%>
                        <input type="submit" value="submit" name="submit" />
                    </form>




                    <%} else if (selectedTable.equalsIgnoreCase("works")) {%>
                    <%if (attribute.equalsIgnoreCase("ssn")) {%>
                    <sql:query var="deciderResult" dataSource="jdbc/thedreamcompany">
                        SELECT ssn FROM employee 
                    </sql:query>
                    <form action="updateResult.jsp">                           
                        <strong>Select a SSN to update to:</strong>
                        <select name="attributeValue">
                            <c:forEach var="row" items="${deciderResult.rows}">
                                <option value="${row.ssn}">${row.ssn}</option>
                            </c:forEach>
                        </select>  
                        <%session.setAttribute("attribute", request.getParameter("attribute"));%>
                        <%session.setAttribute("ssn", request.getParameter("ssn"));%>
                        <%session.setAttribute("projNum", request.getParameter("projNum"));%>
                        <%session.setAttribute("projName", request.getParameter("projName"));%>
                        <%session.setAttribute("deptNum", request.getParameter("deptNum"));%>
                        <input type="submit" value="submit" name="submit" />
                    </form>
                    <%} else if (attribute.equalsIgnoreCase("deptNum")) {%>
                    <sql:query var="deciderResult" dataSource="jdbc/thedreamcompany">
                        SELECT deptNum FROM department 
                    </sql:query>
                    <form action="updateResult.jsp">                           
                        <strong>Select a department number to update to:</strong>
                        <select name="attributeValue">
                            <c:forEach var="row" items="${deciderResult.rows}">
                                <option value="${row.deptNum}">${row.deptNum}</option>
                            </c:forEach>
                        </select>
                        <%session.setAttribute("attribute", request.getParameter("attribute"));%>
                        <%session.setAttribute("ssn", request.getParameter("ssn"));%>
                        <%session.setAttribute("projNum", request.getParameter("projNum"));%>
                        <%session.setAttribute("projName", request.getParameter("projName"));%>
                        <%session.setAttribute("deptNum", request.getParameter("deptNum"));%>
                        <input type="submit" value="submit" name="submit" />
                    </form>
                    <%}%>




                    <%} else {%>
                    <form action="updateResult.jsp"> 
                        <label for="attributeValue">New value for attribute:</label><br>
                        <input type="text" id="attributeValue" name="attributeValue" value="" />

                        <%session.setAttribute("attribute", request.getParameter("attribute"));%>
                        <%session.setAttribute("ssn", request.getParameter("ssn"));%>
                        <%session.setAttribute("deptNum", request.getParameter("deptNum"));%>
                        <%session.setAttribute("projNum", request.getParameter("projNum"));%>
                        <%session.setAttribute("projName", request.getParameter("projName"));%>

                        <input type="submit" value="submit" name="submit" />
                    </form>
                    <%}%>
                </td>
            </tr>


            <tr>
                <td>
                    <form action="start.jsp">
                        <input type="submit" value="Return to Home" />
                    </form>
                </td>
            </tr>
        </tbody>
    </table>
    <%}%>

</body>
</html>
