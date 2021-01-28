<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : index
    Created on : Apr 18, 2020, 11:12:15 PM
    Author     : darod
--%>

    
<%String selectedOperation = request.getParameter("opeartion");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The DreamCompany Database Interface</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <h1>Welcome</h1>
        <table border="0">
            <thead>
                <tr>
                    <th>The Dream Company Database Interface</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>This is an interface that allows the user to perform CRUD operations on the Dream Company Database</td>
                </tr>
                <tr>
                    <td>
                        <form action="option.jsp">
                            <strong>Select a table:</strong>
                            <select name="table">
                                <option value="employee">employee</option>
                                <option value="department">department</option>
                                <option value="project">project</option>
                                <option value="works">works</option>
                            </select>
                             <table border="0"></table>  
                            <strong>Select an operation:</strong>
                            <select name="operation">
                                <option value="SELECT">select</option>
                                <option value="INSERT">insert</option>
                                <option value="UPDATE">update</option>
                                <option value="DELETE">delete</option>
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
