<%@ page contentType="text/html; charset=utf-8" import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%  request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../shoeForDunk/bootstrap/css/bootstrap.min.css">
<title></title>
</head>
<%
String Classroom = request.getParameter("Classroom");
String ExamTime = request.getParameter("ExamTime");
String TheSubject = request.getParameter("TheSubject"); 
if(TheSubject == null){
	out.println("window.location.href='LoginPage.html';</script>");
}
Context ic = new InitialContext();
DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/Invigilation");
Connection con = ds.getConnection();
Statement stmt = con.createStatement();
ResultSet rs;
String ChangeTheStateOfTeacherForOrder = " Select * from TeacherInfo "+
" order by InvigilationNumber ";
rs = stmt.executeQuery(ChangeTheStateOfTeacherForOrder);
rs.next();
String NameOfTeacher = rs.getString("NameOfTeacher");
String InvigilationNumber = rs.getString("InvigilationNumber");
String ChangeTheStateOfTeacherForChange = "INSERT INTO TheArrangement (Classroom,ExamDate,TheSubject,"+
 		" NameOfTeacher) "+
" VALUES ('"+Classroom+"','"+ExamTime+"','"+TheSubject+"','"+NameOfTeacher+"')";
stmt.executeUpdate(ChangeTheStateOfTeacherForChange);
int InvigilationNumberIncrease =  Integer.parseInt(InvigilationNumber)+1;
String InvigilationNumberIncreaseToDB = "UPDATE [TeacherInfo]" +
 	"SET [InvigilationNumber]="+InvigilationNumberIncrease+" WHERE [NameOfTeacher] = '"+NameOfTeacher+"'";
stmt.executeUpdate(InvigilationNumberIncreaseToDB);
%>
<body>
<div class="container">
  <h2></h2>
  <p></p>            
  <table class="table">
    <thead>
      <tr>
        <th style="color:Cyan; font-size:20px;">TeacherName</th>
        <th style="color:Cyan; font-size:20px;">ClassRoom</th>
        <th style="color:Cyan; font-size:20px;">Date</th>
        <th style="color:Cyan; font-size:20px;">Subject</th>
      </tr>
    </thead>
    <tbody>
      <tr class="success">
        <td style=" font-size:20px;"><%=NameOfTeacher%></td>
        <td style=" font-size:20px;"><%=Classroom%></td>
        <td style=" font-size:20px;"><%=ExamTime%></td>
        <td style=" font-size:20px;"><%=TheSubject%></td>
      </tr>
    </tbody>
  </table>
</div>


</body>
</html>