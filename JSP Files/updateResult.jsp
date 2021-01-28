<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : response
    Created on : Apr 18, 2020, 11:39:45 PM
    Author     : darod
--%>

<% String attribute = session.getAttribute("attribute").toString();%>
<% String attributeValue = request.getParameter("attributeValue");%>
<% String selectedTable = session.getAttribute("table").toString();%>

<% String pass = "true";%>
<% String query;%>
<%
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/thedreamcompany?useSSL=false", "root", "*Ta408Q0u3o@~wb");
    PreparedStatement pStatement = con.prepareStatement("initialize");
%>

<%if (selectedTable.equalsIgnoreCase("employee")) {%>
<%
    query = "SELECT * FROM employee WHERE ssn = ?";
    pStatement = con.prepareStatement(query);
    pStatement.setString(1, request.getParameter("ssn"));
%>
<%} else if (selectedTable.equalsIgnoreCase("department")) {%>
<%
    query = "SELECT * FROM department WHERE deptNum = ?";
    pStatement = con.prepareStatement(query);
    pStatement.setString(1, request.getParameter("attributeValue"));
%>
<%} else if (selectedTable.equalsIgnoreCase("project")) {%>
<%
    if (attribute.equalsIgnoreCase("projName")) {
        query = "SELECT * FROM project WHERE projName = ?";
        pStatement = con.prepareStatement(query);
        pStatement.setString(1, request.getParameter("attributeValue"));
    } else if (attribute.equalsIgnoreCase("projNum")) {
        query = "SELECT * FROM project WHERE projNum = ?";
        pStatement = con.prepareStatement(query);
        pStatement.setString(1, request.getParameter("attributeValue"));
    }
%>
<%} else if (selectedTable.equalsIgnoreCase("works")) {%>
<%
    query = "SELECT * FROM works WHERE ssn = ? AND projNum = ? AND deptNum = ?";
    pStatement = con.prepareStatement(query);
    pStatement.setString(1, request.getParameter("ssn"));
    pStatement.setString(2, request.getParameter("projNum"));
    pStatement.setString(3, request.getParameter("deptNum"));
%> <%}%>
<%
    ResultSet result = pStatement.executeQuery();
    String unique = "true";
    if (result.next() == true) {
        unique = "false";
    }
%>

<%if (selectedTable.equalsIgnoreCase("employee")) {%>
<%
    if (attribute.equalsIgnoreCase("fname")) {
        if (attributeValue.length() > 15 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("mInit")) {
        if (attributeValue.length() > 1 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("LName")) {
        if (attributeValue.length() > 15 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("address_street")) {
        if (attributeValue.length() > 30 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("address_city")) {
        if (attributeValue.length() > 20 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("address_zipCode")) {
        if (attributeValue.length() != 5 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("address_state")) {
        if (attributeValue.length() > 20 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("dob_month")) {
        if (attributeValue.length() > 2 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("dob_day")) {
        if (attributeValue.length() > 2 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("dob_year")) {
        if (attributeValue.length() > 4 || attributeValue.isEmpty()) {
            pass = "false";
        }
    }
%>
<%} else if (selectedTable.equalsIgnoreCase("department")) {%>
<%   if (attribute.equalsIgnoreCase("deptNum")) {
        if (attributeValue.length() > 10 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("deptName")) {
        if (attributeValue.length() > 30 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("managerSSN")) {
        if (attributeValue.length() != 9 || attributeValue.isEmpty()) {
            pass = "false";
        }
    }
%>

<%} else if (selectedTable.equalsIgnoreCase("project")) {%>
<%   if (attribute.equalsIgnoreCase("projName")) {
        if (attributeValue.length() > 30 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("projNum")) {
        if (attributeValue.length() > 10 || attributeValue.isEmpty()) {
            pass = "false";
        }
    } else if (attribute.equalsIgnoreCase("projDesc")) {
        if (attributeValue.length() > 100 || attributeValue.isEmpty()) {
            pass = "false";
        }
    }
%>

<%}%>


<sql:query var="result" dataSource="jdbc/thedreamcompany">
    SELECT * FROM <%=selectedTable%> WHERE <%=attribute%> = '<%=attributeValue%>'
</sql:query>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>update result</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <table border="0">

            <%if (pass.equalsIgnoreCase("false") || unique.equalsIgnoreCase("false")) {%>
            <body>
                <table border="0">
                    <tr>
                        <th>
                            <p style="color:red"> Unable to update because input is invalid, please restart update or return home</p>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <form action="start.jsp">
                                <input type="submit" value="Return to Home" />
                                <table border="0"></table>

                            </form>
                            <form action="update.jsp">
                                <input type="submit" value="Restart" />
                            </form>
                        </td>
                    </tr>
                </table>

            </body>
            <%} else {%>
            <body>
                <table border="0">
                    <thead>
                        <tr>
                            <th>Update Results</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (selectedTable.equalsIgnoreCase("employee")) { %>
                        <% String employeeSSN = session.getAttribute("ssn").toString();%>
                        <sql:update var="update" dataSource="jdbc/thedreamcompany">
                            UPDATE <%=selectedTable%>
                            SET <%=attribute%> = '<%=attributeValue%>'
                            WHERE ssn = '<%=employeeSSN%>'
                        </sql:update>
                        <sql:query var="updateResult" dataSource="jdbc/thedreamcompany">
                            SELECT *  FROM <%=selectedTable%> WHERE ssn = '<%=employeeSSN%>'
                        </sql:query>


                        <%} else if (selectedTable.equalsIgnoreCase("department")) { %>
                        <% String deptNum = session.getAttribute("deptNum").toString();%>
                        <sql:update var="update" dataSource="jdbc/thedreamcompany">
                            UPDATE <%=selectedTable%>
                            SET <%=attribute%> = '<%=attributeValue%>'
                            WHERE deptNum = '<%=deptNum%>'
                        </sql:update>
                        <%if (attribute.equalsIgnoreCase("deptNum")) {%>
                        <sql:query var="updateResult" dataSource="jdbc/thedreamcompany">
                            SELECT *  FROM <%=selectedTable%> WHERE deptNum = '<%=attributeValue%>'
                        </sql:query>
                        <%} else {%>
                        <sql:query var="updateResult" dataSource="jdbc/thedreamcompany">
                            SELECT *  FROM <%=selectedTable%> WHERE deptNum = '<%=deptNum%>'
                        </sql:query>
                        <%}%>



                        <%} else if (selectedTable.equalsIgnoreCase("project")) { %>
                        <% String projNum = session.getAttribute("projNum").toString();%>
                        <% String projName = session.getAttribute("projName").toString();%>
                        <sql:update var="update" dataSource="jdbc/thedreamcompany">
                            UPDATE <%=selectedTable%>
                            SET <%=attribute%> = '<%=attributeValue%>'
                            WHERE projNum = '<%=projNum%>' AND projName = '<%=projName%>'
                        </sql:update>
                        <%if (attribute.equalsIgnoreCase("projName")) {%>
                        <sql:query var="updateResult" dataSource="jdbc/thedreamcompany">
                            SELECT *  FROM <%=selectedTable%> WHERE projNum = '<%=projNum%>' AND projName = '<%=attributeValue%>'
                        </sql:query>
                        <%} else if (attribute.equalsIgnoreCase("projNum")) {%>
                        <sql:query var="updateResult" dataSource="jdbc/thedreamcompany">
                            SELECT *  FROM <%=selectedTable%> WHERE projNum = '<%=attributeValue%>' AND projName = '<%=projName%>'
                        </sql:query>
                        <%} else {%>
                        <sql:query var="updateResult" dataSource="jdbc/thedreamcompany">
                            SELECT *  FROM <%=selectedTable%> WHERE projNum = '<%=projNum%>' AND projName = '<%=projName%>'
                        </sql:query>
                        <%}%>



                        <%} else if (selectedTable.equalsIgnoreCase("works")) { %>
                        <% String employeeSSN = session.getAttribute("ssn").toString();%>
                        <% String projNum = session.getAttribute("projNum").toString();%>
                        <% String projName = session.getAttribute("projName").toString();%>
                        <% String deptNum = session.getAttribute("deptNum").toString();%>
                        <sql:update var="update" dataSource="jdbc/thedreamcompany">
                            UPDATE <%=selectedTable%>
                            SET <%=attribute%> = '<%=attributeValue%>'
                            WHERE ssn = '<%=employeeSSN%>' AND projNum = '<%=projNum%>' AND projName = '<%=projName%>' AND deptNum = '<%=deptNum%>'
                        </sql:update>
                        <%if (attribute.equalsIgnoreCase("ssn")) {%>
                        <sql:query var="updateResult" dataSource="jdbc/thedreamcompany">
                            SELECT *  FROM <%=selectedTable%> WHERE ssn = '<%=attributeValue%>' AND projNum = '<%=projNum%>' AND projName = '<%=projName%>' AND deptNum = '<%=deptNum%>'
                        </sql:query>
                        <%} else if (attribute.equalsIgnoreCase("deptNum")) {%>
                        <sql:query var="updateResult" dataSource="jdbc/thedreamcompany">
                            SELECT *  FROM <%=selectedTable%> WHERE ssn = '<%=employeeSSN%>' AND projNum = '<%=projNum%>' AND projName = '<%=projName%>' AND deptNum = '<%=attributeValue%>'
                        </sql:query>
                        <%}%>
                        <%}%>

                    <table border="1">
                        <!-- column headers -->
                        <tr>
                            <c:forEach var="columnName" items="${updateResult.columnNames}">
                                <th><c:out value="${columnName}"/></th>
                                </c:forEach>
                        </tr>
                        <!-- column data -->
                        <c:forEach var="row" items="${updateResult.rowsByIndex}">
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
</table>
</body>
</html>
