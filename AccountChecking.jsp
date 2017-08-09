<%@ page contentType="text/html; charset=utf-8" import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%  request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<title>AccountChecking</title>
</head>
<body>
<%
String occupation = request.getParameter("occupation");
String IDNumber = request.getParameter("IDNumber");
String Password = request.getParameter("Password");
Context ic = new InitialContext();
DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/Invigilation");
Connection con = ds.getConnection();
Statement stmt = con.createStatement();
ResultSet rs;
if (occupation.equals("teacher") ) {
    rs=stmt.executeQuery("Select NameOfTeacher,PasswordOfTeacher from TeacherInfo where NameOfTeacher='"+IDNumber+"'");
	if(!rs.next()){
			out.println("<script language='javascript'>window.alert('账号不存在');window.location.href='LoginPage.html';</script>");
			}
	else{
			if(Password.equals(rs.getString("PasswordOfTeacher"))){
			Cookie loginSuccessOfTeacher = new Cookie("loginSuccessOfTeacher",IDNumber);
			String path = "/SystemForInvigilation/";
			loginSuccessOfTeacher.setPath(path);	
			response.addCookie(loginSuccessOfTeacher);
			loginSuccessOfTeacher.setMaxAge(0);
			out.println("<script language='javascript'>window.alert('登入成功');window.location.href='http://localhost:8080/SystemForInvigilation/teacher/Teacher.jsp';</script>");
		}
			else{
			out.println("<script language='javascript'>window.alert('密码错误');window.location.href='LoginPage.html';</script>");
			}	
		}		
}
if (occupation.equals("manager") ) {
	 rs=stmt.executeQuery("Select NameOfManager,PasswordOfManager from ManagerInfo where NameOfManager='"+IDNumber+"'");
	if(!rs.next()){
			out.println("<script language='javascript'>window.alert('账号不存在');window.location.href='LoginPage.html';</script>");
			}
	else{
			if(Password.equals(rs.getString("PasswordOfManager"))){
			Cookie loginSuccessOfManager = new Cookie("loginSuccessOfManager",IDNumber);
			String path = "/SystemForInvigilation/";
			loginSuccessOfManager.setPath(path);	
			response.addCookie(loginSuccessOfManager);
			loginSuccessOfManager.setMaxAge(0);
			out.println("<script language='javascript'>window.alert('登入成功');window.location.href='http://localhost:8080/SystemForInvigilation/manager/Manager.jsp';</script>");
		}
			else{
			out.println("<script language='javascript'>window.alert('密码错误');window.location.href='LoginPage.html';</script>");
			}	
		}		
}
%>
</body>
</html>