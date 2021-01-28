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
        <title>insert</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <table border="0">
            <thead>
                <tr>
                    <th>Insert Page</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Currently working with <%=selectedTable%> table to perform a(n) <%=selectedOperation%> operation</td>
                </tr>
                <tr>
                    <td>
                        <form action="checkInput.jsp">  
                            <%if (selectedTable.equalsIgnoreCase("employee")) {%>
                            <label for="ssn">Please enter ssn (primary key):</label><br>
                            <input type="text" id="ssn" name="ssn" value="" size="9" />
                            <table border="0"></table>
                            <label for="fName">Please enter first name:</label><br>
                            <input type="text" id="fName" name="fName" value="" size="15" />
                            <table border="0"></table>
                            <label for="mInit">Please enter middle initial:</label><br>
                            <input type="text" id="mInit" name="mInit" value="" size="1" />
                            <table border="0"></table>
                            <label for="LName">Please enter last name:</label><br>
                            <input type="text" id="LName" name="LName" value="" size="15" />
                            <table border="0"></table>
                            <label for="address_street">Please enter street name:</label><br>
                            <input type="text" id="address_street" name="address_street" value="" size="30" />
                            <table border="0"></table>
                            <label for="address_city">Please enter city:</label><br>
                            <input type="text" id="address_city" name="address_city" value="" size="20" />
                            <table border="0"></table>
                            <label for="address_zipCode">Please enter zipcode:</label><br>
                            <input type="text" id="address_zipCode" name="address_zipCode" value="" size="5" />
                            <table border="0"></table>
                            <label for="address_state">Please enter state:</label><br>
                            <input type="text" id="address_state" name="address_state" value="" size="20" />
                            <table border="0"></table>
                            <label for="dob_month">Please enter birth month (number):</label><br>
                            <input type="text" id="dob_month" name="dob_month" value="" size="2" />
                            <table border="0"></table>
                            <label for="dob_day">Please enter birth day (number):</label><br>
                            <input type="text" id="dob_day" name="dob_day" value="" size="2" />
                            <table border="0"></table>
                            <label for="dob_year">Please enter birth year (number):</label><br>
                            <input type="text" id="dob_year" name="dob_year" value="" size="4" />


                            <%} else if (selectedTable.equalsIgnoreCase("department")) {%>
                            <label for="deptNum">Please enter department number (primary key): </label><br>
                            <input type="text" id="deptNum" name="deptNum" value="" size="10" />
                            <table border="0"></table>
                            <label for="deptName">Please enter department name:</label><br>
                            <input type="text" id="deptName" name="deptName" value="" size="30" />
                            <table border="0"></table>

                            <strong>Select a manager SSN:</strong>
                            <sql:query var="manager" dataSource="jdbc/thedreamcompany">
                                SELECT ssn FROM salariedEMP 
                            </sql:query>
                            <select name="managerSSN">
                                <c:forEach var="row" items="${manager.rows}">
                                    <option value="${row.ssn}">${row.ssn}</option>
                                </c:forEach>
                            </select>


                            <%} else if (selectedTable.equalsIgnoreCase("project")) {%>
                            <label for="projName">Please enter Project Name (primary key):</label><br>
                            <input type="text" id="projName" name="projName" value="" size="30" />
                            <table border="0"></table>
                            <label for="projNum">Please enter Project Number (primary key):</label><br>
                            <input type="text" id="projNum" name="projNum" value="" size="10" />
                            <table border="0"></table>
                            <label for="projDesc">Please enter Project Description:</label><br>
                            <input type="text" id="projDesc" name="projDesc" value="" size="100" />


                            <%} else if (selectedTable.equalsIgnoreCase("works")) {%>
                            <label for="ssn">Enter employee ssn (primary key):</label><br>
                            <input type="text" id="ssn" name="ssn" value="" />
                            <table border="0"></table>

                            <strong>Select a project number:</strong>
                            <sql:query var="projectNumbers" dataSource="jdbc/thedreamcompany">
                                SELECT projNum FROM project 
                            </sql:query>
                            <select name="projNum">
                                <c:forEach var="row" items="${projectNumbers.rows}">
                                    <option value="${row.projNum}">${row.projNum}</option>
                                </c:forEach>
                            </select>
                            <table border="0"></table>

                            <strong>Select a department number:</strong>
                            <sql:query var="departmentNumbers" dataSource="jdbc/thedreamcompany">
                                SELECT deptNum FROM department 
                            </sql:query>
                            <select name="deptNum">
                                <c:forEach var="row" items="${departmentNumbers.rows}">
                                    <option value="${row.deptNum}">${row.deptNum}</option>
                                </c:forEach>
                            </select>
                            <%}%>

                            <table border="0"></table>
                            <input type="submit" value="submit" name="submit" />
                        </form>
                    </td>
                </tr>
                <tr>
                    <td>
                        <form action="start.jsp">
                            <input type="submit" value="Home" name="home" />
                        </form>
                    </td>
                </tr>
            </tbody>
        </table>

    </body>
</html>
