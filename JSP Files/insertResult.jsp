<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : response
    Created on : Apr 18, 2020, 11:39:45 PM
    Author     : darod
--%>

<% String selectedTable = session.getAttribute("table").toString();%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert result</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <table border="0">
            <thead>
                <tr>
                </tr>
            </thead>
            <tbody>

                <% if (selectedTable.equalsIgnoreCase("employee")) { %>
                <% String ssn = request.getParameter("ssn");%>
                <% String fName = request.getParameter("fName");%>
                <% String mInit = request.getParameter("mInit");%>
                <% String LName = request.getParameter("LName");%>
                <% String address_street = request.getParameter("address_street");%>
                <% String address_city = request.getParameter("address_city");%>
                <% String address_zipCode = request.getParameter("address_zipCode");%>
                <% String address_state = request.getParameter("address_state");%>
                <% String dob_month = request.getParameter("dob_month");%>
                <% String dob_day = request.getParameter("dob_day");%>
                <% String dob_year = request.getParameter("dob_year");%>
                

                <sql:update var="insertVar" dataSource="jdbc/thedreamcompany">
                    INSERT INTO <%=selectedTable%>
                    VALUES (<%=ssn%>, '<%=fName%>', '<%=mInit%>', '<%=LName%>', '<%=address_street%>', '<%=address_city%>', '<%=address_zipCode%>', '<%=address_state%>', '<%=dob_month%>', '<%=dob_day%>', '<%=dob_year%>')
                </sql:update>

                <sql:query var="insertResult" dataSource="jdbc/thedreamcompany">
                    SELECT *  FROM <%=selectedTable%> WHERE ssn = '<%=ssn%>'
                </sql:query>

                <%} else if (selectedTable.equalsIgnoreCase("department")) { %>
                <% String deptNum = request.getParameter("deptNum");%>
                <% String deptName = request.getParameter("deptName");%>
                <% String managerSSN = request.getParameter("managerSSN");%>
                <sql:update var="insertVar" dataSource="jdbc/thedreamcompany">
                    INSERT INTO <%=selectedTable%>
                    VALUES (<%=deptNum%>, '<%=deptName%>', <%=managerSSN%>)
                </sql:update>

                <sql:query var="insertResult" dataSource="jdbc/thedreamcompany">
                    SELECT *  FROM <%=selectedTable%> WHERE deptNum = '<%=deptNum%>'
                </sql:query>

                <%} else if (selectedTable.equalsIgnoreCase("project")) {%>
                <%String projName = request.getParameter("projName");%>
                <%String projNum = request.getParameter("projNum");%>
                <%String projDesc = request.getParameter("projDesc");%>
                <sql:update var="insertVar" dataSource="jdbc/thedreamcompany">
                    INSERT INTO <%=selectedTable%>
                    VALUES ('<%=projName%>', <%=projNum%>, '<%=projDesc%>')
                </sql:update>

                <sql:query var="insertResult" dataSource="jdbc/thedreamcompany">
                    SELECT *  FROM <%=selectedTable%> WHERE projName = '<%=projName%>' AND projNum = '<%=projNum%>'
                </sql:query>

                <%} else if (selectedTable.equalsIgnoreCase("works")) {%>
                
                <%String projNum = request.getParameter("projNum");%>
                <%String ssn = request.getParameter("ssn");%>
                <%String deptNum = request.getParameter("deptNum");%>

                <sql:query var="projectNameResult" dataSource="jdbc/thedreamcompany">
                    SELECT projName FROM project
                    WHERE projNum = <%=projNum%>
                </sql:query>
                <c:set var="projName" value="${projectNameResult.rows[0]}"/>


                <sql:update var="insertVar" dataSource="jdbc/thedreamcompany">
                    INSERT INTO <%=selectedTable%>
                    VALUES (<%=ssn%>, '${projName.projName}', <%=projNum%>, <%=deptNum%>)
                </sql:update>

                <sql:query var="insertResult" dataSource="jdbc/thedreamcompany">
                    SELECT *  FROM <%=selectedTable%> WHERE projName = '${projName.projName}' AND projNum = '<%=projNum%>' AND deptNum = '<%=deptNum%>' AND ssn = '<%=ssn%>'
                </sql:query> 
                <%}%>



            <table border="1">
                <!-- column headers -->
                <tr>
                    <c:forEach var="columnName" items="${insertResult.columnNames}">
                        <th><c:out value="${columnName}"/></th>
                        </c:forEach>
                </tr>
                <!-- column data -->
                <c:forEach var="row" items="${insertResult.rowsByIndex}">
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
</html>
