<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : response
    Created on : Apr 18, 2020, 11:39:45 PM
    Author     : darod
--%>

<% String selectedTable = session.getAttribute("table").toString();%>

<%String selectedOperation = session.getAttribute("operation").toString();%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>delete</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
         <table border="0">
            <thead>
                <tr>
                    <th>Delete Page</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Currently working with <%=selectedTable%> table to perform a(n) <%=selectedOperation%> operation</td>
                </tr>
                <tr>
                    <td>
                        <form action="deleteResult.jsp">  
                        <%if (selectedTable.equalsIgnoreCase("employee")) {%>
                            <label for="ssn">Please enter ssn to delete record:</label><br>
                            <input type="text" id="ssn" name="ssn" value="" size="9" />
                        <%} else if(selectedTable.equalsIgnoreCase("department")){%>
                            <label for="deptNum">Please enter department number to delete record:</label><br>
                            <input type="text" id="deptNum" name="deptNum" value="" size="10" />
                        <%} else if(selectedTable.equalsIgnoreCase("project")) {%>
                            <label for="projName">Please enter Project Name to delete record:</label><br>
                            <input type="text" id="projName" name="projName" value="" size="30" />
                            <table border="0"></table>
                            <label for="projNum">Please enter Project Number to delete record:</label><br>
                            <input type="text" id="projNum" name="projNum" value="" size="10" />
                        <%} else if(selectedTable.equalsIgnoreCase("works")) {%>
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
                        <input type="submit" value="submit" name="submit" />
                        </form>
                        
                    </td>
                </tr>
            </tbody>
        </table>

    </body>
</html>
