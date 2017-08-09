<%@ page contentType="text/html; charset=utf-8" import="java.sql.*, javax.sql.*, javax.naming.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="utf-8">
<head charset=utf-8>
<style>
.bg-1 { 
    background-color: #1abc9c; /* Green */
    color: #ffffff;
    width: 96%;
}
</style>
<link rel="stylesheet" type="text/css" href="../LoginPage.css">
<title>ManagerPage</title>
<link rel="stylesheet" href="../../shoeForDunk/bootstrap/css/bootstrap.min.css">
</head>
<body>
	<!--取得登入信息的COOKIE-->
	<%
		Cookie[] loginSuccessOfManager = request.getCookies();//取loginSuccess为Cookie数组的名字，取得所有Cookie
		String noUserName="您还未登录";//没有登入的话，就显示这个提醒		
		String loginNameOfManager = "";//Cookie中存放的是登入者的信息，先定义一个String来存放
		if(loginSuccessOfManager != null ){	//如果Cookie存在的话
		 int loginSuccessOfManagerLength = loginSuccessOfManager.length;//取得Cookie数组的存放数量，用length方法，并且把值给定义为INT型的loginSuccessLength
		 for(int i=0; i<loginSuccessOfManagerLength;i++){	//循环比对所有Cookie的名称
		 	if(loginSuccessOfManager[i].getName().equals("loginSuccessOfManager")){	//用getName（）的方法，取得Cookie的名称，然后用equals（）的方法比对登入成功的Cookie名称
		 	loginNameOfManager = loginSuccessOfManager[i].getValue();	//将比对成功的Cookie值传给初始定义的loginNameCookie
		 	break; //跳出循环
		 	}
		 	loginNameOfManager  = noUserName;		 	
		 } 			
	}
		else{	//如果电脑中没有任何Cookie信息的话
		    loginNameOfManager  = noUserName;
	}
	    if(loginNameOfManager.equals(noUserName)){
            out.println("<script>window.location.href='LoginPage.html';</script>");
	}
	
  
  Context ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/Invigilation");
  Connection con = ds.getConnection();
  Statement stmt = con.createStatement();
  ResultSet rs;
 
%>
            
	<!--district one导航条-->
  <div style="border :30px solid Cyan;"></div>
  <div class="header">    
      <div class="container">
            <a href="Manager.jsp"><h1><div style="color:white;">ManagerPage</div></h1></a>
        <div class="row">
          <div class="col-lg-3"></div>
          <div class="col-lg-3"></div>
          <div class="col-lg-1 "><font color="green"  style="font-size:25px; color:Orange;"><%=loginNameOfManager%></font></div></a>          
          <div class="col-lg-1"></div>
          <a href="http://localhost:8080/SystemForInvigilation/Quit.jsp"><div class="col-lg-1" style="font-size:20px; color:Cyan;">登出</div></a>
          <a href="http://localhost:8080/SystemForInvigilation/manager/TheArrangementResult.jsp"><div class="col-lg-1" style="font-size:20px; color:Cyan;">监考信息</div></a>
          <a href="http://localhost:8080/SystemForInvigilation/manager/EmailSystemInterface.jsp"><div class="col-lg-1" style="font-size:20px; color:Cyan;">邮件通知</div></a>   
          <div class="col-lg-1"></div>        
        </div>
      </div>  
  </div>
  <br><br><br><br> 
  <div class="sectionOne">	
  <%
   String ChangeTheStateOfTeacherForOrder = " SELECT TheArrangement.Classroom, TheArrangement.TheSubject, " +
  " TheArrangement.ExamDate,TheArrangement.NameOfTeacher " +
" FROM TeacherInfo " + 
" INNER JOIN TheArrangement " + 
" ON TheArrangement.NameOfTeacher=TeacherInfo.NameOfTeacher ";
rs = stmt.executeQuery(ChangeTheStateOfTeacherForOrder);
%>
  <div class="container">
  <h2></h2>
  <p></p>  
         
  <table class="table">
    <thead>
      <tr style="color:Cyan; font-size:22px;">
        <th>TeacherName</th>
        <th>ClassRoom</th>
        <th>Date</th>
        <th>Subject</th>
      </tr>
    </thead>
     <%
    while(rs.next()){
     %>
    <tbody>
      <tr class="success">
        <td><%=rs.getString("NameOfTeacher")%></td>
        <td><%=rs.getString("Classroom")%></td>
        <td><%=rs.getString("TheSubject")%></td>
        <td><%=rs.getString("ExamDate")%></td>
      </tr>
    </tbody>
    <%
    }
    %>
  </table>
</div>


	</div>
	</body>
	</html>
