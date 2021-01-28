<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : index
    Created on : Apr 18, 2020, 11:12:15 PM
    Author     : darod
--%>
<% String ssn = "";%>
<% String fName = "";%>
<% String mInit = "";%>
<% String LName = "";%>
<% String address_street = "";%>
<% String address_city = "";%>
<% String address_zipCode = "";%>
<% String address_state = "";%>
<% String dob_month = "";%>
<% String dob_day = "";%>
<% String dob_year = "";%>

<% String deptNum = "";%>
<% String deptName = "";%>
<% String managerSSN = "";%>

<%String projName = "";%>
<%String projNum = "";%>
<%String projDesc = "";%>



<% String query;%>
<% String pass = "true";%>
<% String selectedTable = session.getAttribute("table").toString();%>
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
<% ssn = request.getParameter("ssn");%>
<% fName = request.getParameter("fName");%>
<% mInit = request.getParameter("mInit");%>
<% LName = request.getParameter("LName");%>
<% address_street = request.getParameter("address_street");%>
<% address_city = request.getParameter("address_city");%>
<% address_zipCode = request.getParameter("address_zipCode");%>
<% address_state = request.getParameter("address_state");%>
<% dob_month = request.getParameter("dob_month");%>
<% dob_day = request.getParameter("dob_day");%>
<% dob_year = request.getParameter("dob_year");%>
<% if (ssn.length() != 9 || ssn == null) {
        pass = "false";
    } else if (fName.length() > 15) {
        pass = "false";
    } else if (mInit.length() > 1) {
        pass = "false";
    } else if (LName.length() > 15) {
        pass = "false";
    } else if (address_street.length() > 30) {
        pass = "false";
    } else if (address_city.length() > 20) {
        pass = "false";
    } else if (address_zipCode.length() > 5) {
        pass = "false";
    } else if (address_state.length() > 20) {
        pass = "false";
    } else if (dob_month.length() > 2) {
        pass = "false";
    } else if (dob_day.length() > 2) {
        pass = "false";
    } else if (dob_year.length() > 4) {
        pass = "false";
    }
%>

<%} else if (selectedTable.equalsIgnoreCase("department")) {%>
<%
    query = "SELECT * FROM department WHERE deptNum = ?";
    pStatement = con.prepareStatement(query);
    pStatement.setString(1, request.getParameter("deptNum"));
%>
<% deptNum = request.getParameter("deptNum");%>
<% deptName = request.getParameter("deptName");%>
<% managerSSN = request.getParameter("managerSSN");%>
<% if (deptNum.length() > 10 || deptNum.isEmpty()) {
        pass = "false";
    } else if (deptName.length() > 30) {
        pass = "false";
    } else if (managerSSN.length() != 9 || managerSSN.isEmpty()) {
        pass = "false";
    }
    
%>

<%} else if (selectedTable.equalsIgnoreCase("project")) {%>
<%
    query = "SELECT * FROM project WHERE projName = ? AND projNum = ?";
    pStatement = con.prepareStatement(query);
    pStatement.setString(1, request.getParameter("projName"));
    pStatement.setString(2, request.getParameter("projNum"));
%>
<%projName = request.getParameter("projName");%>
<%projNum = request.getParameter("projNum");%>
<%projDesc = request.getParameter("projDesc");%>
<% if (projName.length() > 30 || projName.isEmpty()) {
        pass = "false";
    } else if (projNum.length() > 10 || projNum.isEmpty()) {
        pass = "false";
    } else if (projDesc.length() > 100) {
        pass = "false";
    }
%>

<%} else if (selectedTable.equalsIgnoreCase("works")) {%>
<%
    query = "SELECT * FROM works WHERE ssn = ? AND projNum = ? AND deptNum = ?";
    pStatement = con.prepareStatement(query);
    pStatement.setString(1, request.getParameter("ssn"));
    pStatement.setString(2, request.getParameter("projNum"));
    pStatement.setString(3, request.getParameter("deptNum"));
%>
<%projNum = request.getParameter("projNum");%>
<%ssn = request.getParameter("ssn");%>
<%deptNum = request.getParameter("deptNum");%>
<% if (request.getParameter("projNum").length() > 30 || request.getParameter("projNum").isEmpty()) {
        pass = "false";
    } else if (request.getParameter("ssn").length() != 9 || request.getParameter("ssn").isEmpty()) {
        pass = "false";
    } else if (request.getParameter("deptNum").length() > 10 || request.getParameter("deptNum").isEmpty()) {
        pass = "false";
    }
%>
<%}%>

<%
    ResultSet result = pStatement.executeQuery();
    String unique = "true";
    if (result.next() == true) {
        unique = "false";
    }
%>



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
        <table border="0">
            <% if (pass.equalsIgnoreCase("false") || unique.equalsIgnoreCase("false")) {%>
            <thead>
                <tr>
                    <td>
                        <p style="color:red">Please insert correct values or ensure that primary key(s) is/are unique</p>
                    </td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <jsp:include page="insert.jsp"/>
                    </td>
                </tr>
            </tbody>

            <%} else {%>
            <thead>
                <tr></th>
                </tr>
                </tr>
            </thead>
            <tbody>
                <%if (selectedTable.equalsIgnoreCase("employee")) {%>
                <jsp:include page="insertResult.jsp">
                    <jsp:param name="ssn" value="<%=ssn%>"/>
                    <jsp:param name="fName" value="<%=fName%>"/>
                    <jsp:param name="mInit" value="<%=mInit%>"/>
                    <jsp:param name="LName" value="<%=LName%>"/>
                    <jsp:param name="address_street" value="<%=address_street%>"/>
                    <jsp:param name="address_city" value="<%=address_city%>"/>
                    <jsp:param name="address_zipCode" value="<%=address_zipCode%>"/>
                    <jsp:param name="address_state" value="<%=address_state%>"/>
                    <jsp:param name="dob_month" value="<%=dob_month%>"/>
                    <jsp:param name="dob_day" value="<%=dob_day%>"/>
                    <jsp:param name="dob_year" value="<%=dob_year%>"/> 
                </jsp:include>
            </tbody>
            <%} else if (selectedTable.equalsIgnoreCase("department")) {%>
            <jsp:include page="insertResult.jsp">
                <jsp:param name="deptNum" value="<%=deptNum%>"/>
                <jsp:param name="deptName" value="<%=deptName%>"/>
                <jsp:param name="managerSSN" value="<%=managerSSN%>"/>
            </jsp:include>
            <%} else if (selectedTable.equalsIgnoreCase("project")) {%>
            <jsp:include page="insertResult.jsp">
                <jsp:param name="projName" value="<%=projName%>"/>
                <jsp:param name="projNum" value="<%=projNum%>"/>
                <jsp:param name="projDesc" value="<%=projDesc%>"/>
            </jsp:include>
            <%} else if (selectedTable.equalsIgnoreCase("works")) {%>
            <jsp:include page="insertResult.jsp">
                <jsp:param name="projNum" value="<%=projNum%>"/>
                <jsp:param name="ssn" value="<%=ssn%>"/>
                <jsp:param name="deptNum" value="<%=deptNum%>"/>
            </jsp:include>
            <%}%>
            <%}%>
            <thead>
                <tr>

                </tr>
            </thead>
            <tbody>


            </tbody>
        </table>





    </body>
</html>