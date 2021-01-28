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
        <title>Dependent Info</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <table border="0">
            <thead>
                <tr>
                    <th>Update Page</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Currently working with <%=selectedTable%> table to perform a(n) <%=selectedOperation%> operation</td>
                </tr>
                <tr>
                    <td>
                        <form action="attributeValue.jsp">
                            <% if (selectedTable.equalsIgnoreCase("employee")) { %>
                            <label for="ssn">Enter employee ssn:</label><br>
                            <input type="text" id="ssn" name="ssn" value="" />
                            <%} else if (selectedTable.equalsIgnoreCase("department")) { %>
                            <label for="deptNum">Enter department number:</label><br>
                            <input type="text" id="deptNum" name="deptNum" value="" />
                            <%} else if (selectedTable.equalsIgnoreCase("project")) { %>
                            <label for="projNum">Enter project number:</label><br>
                            <input type="text" id="projNum" name="projNum" value="" />
                            <table border="0"></table>
                            <label for="projName">Enter project name:</label><br>
                            <input type="text" id="projName" name="projName" value="" />
                            <%} else if (selectedTable.equalsIgnoreCase("Works")) { %>
                            <label for="ssn">Enter employee ssn:</label><br>
                            <input type="text" id="ssn" name="ssn" value="" />
                            <table border="0"></table>
                            <label for="projNum">Enter project number:</label><br>
                            <input type="text" id="projNum" name="projNum" value="" />
                            <table border="0"></table>
                            <label for="projName">Enter project name:</label><br>
                            <input type="text" id="projName" name="projName" value="" />
                            <table border="0"></table>
                            <label for="deptNum">Enter department number:</label><br>
                            <input type="text" id="deptNum" name="deptNum" value="" />
                            <%}%>

                            <table border="0"></table>

                            <strong>Select an attribute to update:</strong>
                            <select name="attribute">
                                <% if (selectedTable.equalsIgnoreCase("employee")) { %>
                                <option value="fName">First Name</option>
                                <option value="mInit">Middle Initial</option>
                                <option value="LName">Last Name</option>
                                <option value="address_street">street</option>
                                <option value="address_city">city</option>
                                <option value="address_zipcode">Zip Code</option>
                                <option value="dob_month">Birth Month</option>
                                <option value="dob_day">Birth Day</option>
                                <option value="dob_year">Birth Year</option>
                                <%} else if (selectedTable.equalsIgnoreCase("department")) { %>
                                <option value="deptNum">Department Number</option>
                                <option value="deptName">Department Name</option>
                                <option value="managerSSN">Manager SSN</option>
                                <%} else if (selectedTable.equalsIgnoreCase("project")) { %>
                                <option value="projName">Project Name</option>
                                <option value="projNum">Project Number</option>
                                <option value="projDesc">Project Description</option>
                                <%} else if (selectedTable.equalsIgnoreCase("Works")) { %>
                                <option value ="ssn">Employee SSN</option>
                                <option value ="deptNum">Department Number</option>
                                <%}%>
                            </select>

                            <table border="0"></table>
                            <input type="submit" value="submit" name="submit" />
                            
                            
                        </form>
                    </td>
                </tr>
            </tbody>
        </table>

    </body>
</html>
