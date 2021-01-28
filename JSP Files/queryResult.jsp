<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.net.URL"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : response
    Created on : Apr 18, 2020, 11:39:45 PM
    Author     : darod
--%>

<% String attribute = request.getParameter("attribute");%>
<% String attributeValue = request.getParameter("attributeValue");%>
<% String selectedTable = session.getAttribute("table").toString();%>
<% String checkBox = "";
    if (request.getParameter("selectAll") != null) {
        checkBox = request.getParameter("selectAll");
    }
%>
<% String query = "";%>


<%if (selectedTable.equalsIgnoreCase("employee")) {
        if (attribute.equalsIgnoreCase("ssn")) {
            query = "SELECT * FROM employee WHERE ssn = ?";
        } else if (attribute.equalsIgnoreCase("fname")) {
            query = "SELECT * FROM employee WHERE fName = ?";
        } else if (attribute.equalsIgnoreCase("mInit")) {
            query = "SELECT * FROM employee WHERE mInit = ?";
        } else if (attribute.equalsIgnoreCase("LName")) {
            query = "SELECT * FROM employee WHERE LName = ?";
        } else if (attribute.equalsIgnoreCase("address_street")) {
            query = "SELECT * FROM employee WHERE address_street = ?";
        } else if (attribute.equalsIgnoreCase("address_city")) {
            query = "SELECT * FROM employee WHERE address_city = ?";
        } else if (attribute.equalsIgnoreCase("address_zipCode")) {
            query = "SELECT * FROM employee WHERE address_zipCode = ?";
        } else if (attribute.equalsIgnoreCase("address_state")) {
            query = "SELECT * FROM employee WHERE address_state = ?";
        } else if (attribute.equalsIgnoreCase("dob_month")) {
            query = "SELECT * FROM employee WHERE dob_month = ?";
        } else if (attribute.equalsIgnoreCase("dob_day")) {
            query = "SELECT * FROM employee WHERE dob_day = ?";
        } else if (attribute.equalsIgnoreCase("dob_year")) {
            query = "SELECT * FROM employee WHERE dob_year = ?";
        }
    } else if (selectedTable.equalsIgnoreCase("department")) {
        if (attribute.equalsIgnoreCase("deptNum")) {
            query = "SELECT * FROM department WHERE deptNum = ?";
        } else if (attribute.equalsIgnoreCase("deptName")) {
            query = "SELECT * FROM department WHERE deptName = ?";
        } else if (attribute.equalsIgnoreCase("managerSSN")) {
            query = "SELECT * FROM department WHERE managerSSN = ?";
        }
    } else if (selectedTable.equalsIgnoreCase("project")) {
        if (attribute.equalsIgnoreCase("projName")) {
            query = "SELECT * FROM project WHERE projName = ?";
        } else if (attribute.equalsIgnoreCase("projNum")) {
            query = "SELECT * FROM project WHERE projNum = ?";
        } else if (attribute.equalsIgnoreCase("projDesc")) {
            query = "SELECT * FROM project WHERE projDesc = ?";
        }
    } else if (selectedTable.equalsIgnoreCase("works")) {
        if (attribute.equalsIgnoreCase("projName")) {
            query = "SELECT * FROM works WHERE projName = ?";
        } else if (attribute.equalsIgnoreCase("projNum")) {
            query = "SELECT * FROM works WHERE projNum = ?";
        } else if (attribute.equalsIgnoreCase("ssn")) {
            query = "SELECT * FROM works WHERE ssn = ?";
        } else if (attribute.equalsIgnoreCase("deptNum")) {
            query = "SELECT * FROM works WHERE deptNum = ?";
        }
    }
%>

<%
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/thedreamcompany?useSSL=false", "root", "*Ta408Q0u3o@~wb");
    PreparedStatement pStatement = con.prepareStatement(query);
    pStatement.setString(1, request.getParameter("attributeValue"));
    //pStatement.setString(2, request.getParameter("attributeValue"));
    ResultSet results = pStatement.executeQuery();
    String isEmpty = "false";
    if (results.next() == false) {
        isEmpty = "true";
    }
%>

<sql:query var="result" dataSource="jdbc/thedreamcompany">
    SELECT * FROM <%=selectedTable%> WHERE <%=attribute%> = '<%=attributeValue%>'
</sql:query>

<sql:query var="selectAll" dataSource="jdbc/thedreamcompany">
    SELECT * FROM <%=selectedTable%> 
</sql:query>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>query result</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>

    <%if (isEmpty.equalsIgnoreCase("true") && !checkBox.equalsIgnoreCase("true")) {%>
    <body>
        <table border="0">
            <tr>
                <th>
                    Query Result using table: <%=selectedTable%> returned empty, please enter a valid attribute value or return home
                </th>
            </tr>
            <tr>
                <td>
                    <form action="start.jsp">
                        <input type="submit" value="Return to Home" />
                        <table border="0"></table>

                    </form>
                    <form action="query.jsp">
                        <input type="submit" value="Re-enter value" />
                    </form>
                </td>
            </tr>
        </table>

    </body>

    <%} else if (checkBox.equalsIgnoreCase("true")) {%>

    <body>
        <table border="0">
            <thead>
                <tr>
                    <th>Query Results</th>
                </tr>
            </thead>
            <tbody>
                <!-- column headers -->
                <tr>
                    <c:forEach var="columnName" items="${selectAll.columnNames}">
                        <th><c:out value="${columnName}"/></th>
                        </c:forEach>
                </tr>
                <!-- column data -->
                <c:forEach var="row" items="${selectAll.rowsByIndex}">
                    <tr>
                        <c:forEach var="column" items="${row}">
                            <td><c:out value="${column}"/></td>
                        </c:forEach>
                    </tr>
                </c:forEach>
            </tbody>
            <tr>
                <td>
                    <form action="start.jsp">
                        <input type="submit" value="Return to Home" />
                    </form>

                </td>
            </tr>

            <tr>
                <td>
                    <form action="query.jsp">
                        <input type="submit" value="Perform Another Search" name="home" />
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
                    <th>Query Results</th>
                </tr>
            </thead>
            <tbody>
                <!-- column headers -->
                <tr>
                    <c:forEach var="columnName" items="${result.columnNames}">
                        <th><c:out value="${columnName}"/></th>
                        </c:forEach>
                </tr>
                <!-- column data -->
                <c:forEach var="row" items="${result.rowsByIndex}">
                    <tr>
                        <c:forEach var="column" items="${row}">
                            <td><c:out value="${column}"/></td>
                        </c:forEach>
                    </tr>
                </c:forEach>
                <tr>
                    <td>
                        <form action="start.jsp">
                            <input type="submit" value="Return to Home" />
                        </form>
                    </td>
                </tr>
                <tr>
                    <td>
                        <form action="query.jsp">
                            <input type="submit" value="Perform Another Search" name="home" />
                        </form> 
                    </td>
                </tr>

            </tbody>
    </body>

    <%}%>
</html>
