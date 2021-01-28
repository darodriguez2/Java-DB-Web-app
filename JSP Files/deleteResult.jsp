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

<% String selectedTable = session.getAttribute("table").toString();%>
<% String query = "";%>
    <%if (selectedTable.equalsIgnoreCase("employee")) {
        query = "SELECT * FROM employee WHERE ssn = ?";
    } else if (selectedTable.equalsIgnoreCase("department")) {
        query = "SELECT * FROM department WHERE deptNum = ?";
    } else if (selectedTable.equalsIgnoreCase("project")) {
        query = "SELECT * FROM project WHERE projName = ? AND projNum = ?";
    } else if (selectedTable.equalsIgnoreCase("works")) {
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
        pStatement.setString(1, request.getParameter("projName"));
        pStatement.setString(2, request.getParameter("projNum"));
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
        <title>delete result</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
         <table border="0">
            <thead>
                <tr>
                </tr>
            </thead>
            
            <%if (isEmpty.equalsIgnoreCase("true")) {%>
    <body>
        <table border="0">
            <tr>
                <th>
                   <p style="color:red"> Unable to delete because input is invalid, please enter a valid input or return home</p>
                </th>
            </tr>
            <tr>
                <td>
                    <form action="start.jsp">
                        <input type="submit" value="Return to Home" />
                        <table border="0"></table>

                    </form>
                    <form action="delete.jsp">
                        <input type="submit" value="Re-enter value" />
                    </form>
                </td>
            </tr>
        </table>

    </body>
    <%} else {%>
            <tbody>
                
                 <% if (selectedTable.equalsIgnoreCase("employee")) { %>
                    <% String employeeSSN = request.getParameter("ssn");%>
                    <sql:update var="deleteVar" dataSource="jdbc/thedreamcompany">
                        DELETE FROM <%=selectedTable%>
                        WHERE ssn = <%=employeeSSN%>
                    </sql:update>

                    <sql:query var="deleteResult" dataSource="jdbc/thedreamcompany">
                        SELECT *  FROM <%=selectedTable%> WHERE ssn = '<%=employeeSSN%>'
                    </sql:query>

                    <%} else if (selectedTable.equalsIgnoreCase("department")) { %>
                    <% String deptNum = request.getParameter("deptNum");%>
                    <sql:update var="deletVar" dataSource="jdbc/thedreamcompany">
                        DELETE FROM <%=selectedTable%>
                        WHERE deptNum = '<%=deptNum%>'
                    </sql:update>
                        
                    <sql:query var="deleteResult" dataSource="jdbc/thedreamcompany">
                        SELECT *  FROM <%=selectedTable%> WHERE deptNum = '<%=deptNum%>'
                    </sql:query>
                        
                    <%}else if (selectedTable.equalsIgnoreCase("project")) {%>
                    <%String projName = request.getParameter("projName");%>
                    <%String projNum = request.getParameter("projNum");%>
                    <sql:update var="deleteVar" dataSource="jdbc/thedreamcompany">
                        DELETE FROM <%=selectedTable%>
                        WHERE projName = '<%=projName%>' AND projNum = <%=projNum%>
                    </sql:update>
                        
                    <sql:query var="deleteResult" dataSource="jdbc/thedreamcompany">
                        SELECT *  FROM <%=selectedTable%> WHERE projName = '<%=projName%>' AND projNum = <%=projNum%>
                    </sql:query>
                        
                    <%}else if (selectedTable.equalsIgnoreCase("works")) {%>
                    <%String projName = request.getParameter("projName");%>
                    <%String projNum = request.getParameter("projNum");%>
                    <%String ssn = request.getParameter("ssn");%>
                    <%String deptNum = request.getParameter("deptNum");%>
                    <sql:update var="deleteVar" dataSource="jdbc/thedreamcompany">
                        DELETE FROM <%=selectedTable%>
                        WHERE projName = '<%=request.getParameter("projName")%>' AND projNum = <%=request.getParameter("projNum")%> AND ssn = <%=request.getParameter("ssn")%> AND deptNum = <%=request.getParameter("deptNum")%>
                    </sql:update>
                        
                    <sql:query var="deleteResult" dataSource="jdbc/thedreamcompany">
                        SELECT *  FROM <%=selectedTable%> WHERE projName = '<%=projName%>' AND projNum = <%=projNum%> AND deptNum = <%=deptNum%> AND ssn = <%=ssn%>
                    </sql:query> 
                    <%}%>



                <table border="1">
                    <!-- column headers -->
                    <tr>
                        <c:forEach var="columnName" items="${deleteResult.columnNames}">
                            <th><c:out value="${columnName}"/></th>
                            </c:forEach>
                    </tr>
                    <!-- column data -->
                    <c:forEach var="row" items="${deleteResult.rowsByIndex}">
                        <tr>
                            <c:forEach var="column" items="${row}">
                                <td><c:out value="${column}"/></td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </table>

            </table>
            <form action="start.jsp">
                <input type="submit" value="Return to Home" />
            </form>
                
            </tbody>
        </table>

    </body>
    <%}%>
</html>
