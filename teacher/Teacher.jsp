<%@ page contentType="text/html; charset=utf-8" import="java.sql.*, javax.sql.*, javax.naming.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="utf-8">
<head charset=utf-8>
<style> 
#play{
    width: 100px;
    height: 100px;
    background-color: red;
    position: relative;
    -webkit-animation-name: example; /* Chrome, Safari, Opera */
    -webkit-animation-duration: 4s; /* Chrome, Safari, Opera */
    -webkit-animation-iteration-count: infinite; /* Chrome, Safari, Opera */
    animation-name: example;
    animation-duration: 4s;
    animation-iteration-count: infinite;
}

/* Chrome, Safari, Opera */
@-webkit-keyframes example {
    0%   {background-color:#F5F5DC; left:0px; top:0px;}
    25%  {background-color:#F0FFFF; left:100px; top:0px;}
    50%  {background-color:#FFE4C4; left:300px; top:0px;}
    75%  {background-color:#FAEBD7; left:400px; top:0px;}
    100% {background-color:#00FFFF; left:500px; top:0px;}
}

/* Standard syntax */
@keyframes example {
     0%   {background-color:#F5F5DC; left:0px; top:0px;}
    25%  {background-color:#F0FFFF; left:200px; top:0px;}
    50%  {background-color:#FFE4C4; left:300px; top:0px;}
    75%  {background-color:#FAEBD7; left:400px; top:0px;}
    100% {background-color:#00FFFF; left:500px; top:0px;}
}
</style>
<title>TeacherPage</title>
<link rel="stylesheet" href="../../shoeForDunk/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../LoginPage.css">
</head>
<body>
	<!--取得登入信息的COOKIE-->
	<%
		Cookie[] loginSuccessOfTeacher = request.getCookies();//取loginSuccess为Cookie数组的名字，取得所有Cookie
		String noUserName="您还未登录";//没有登入的话，就显示这个提醒		
		String loginNameOfTeacher = "";//Cookie中存放的是登入者的信息，先定义一个String来存放
		if(loginSuccessOfTeacher != null ){	//如果Cookie存在的话
		 int loginSuccessOfTeacherLength = loginSuccessOfTeacher.length;//取得Cookie数组的存放数量，用length方法，并且把值给定义为INT型的loginSuccessLength
		 for(int i=0; i<loginSuccessOfTeacherLength;i++){	//循环比对所有Cookie的名称
		 	if(loginSuccessOfTeacher[i].getName().equals("loginSuccessOfTeacher")){	//用getName（）的方法，取得Cookie的名称，然后用equals（）的方法比对登入成功的Cookie名称
		 	loginNameOfTeacher = loginSuccessOfTeacher[i].getValue();	//将比对成功的Cookie值传给初始定义的loginNameCookie
		 	break; //跳出循环
		 	}
		 	loginNameOfTeacher  = noUserName;		 	
		 } 			
	}
		else{	//如果电脑中没有任何Cookie信息的话
		    loginNameOfTeacher  = noUserName;
	}
	    if(loginNameOfTeacher.equals(noUserName) ){
            out.println("<script>window.location.href='LoginPage.html';</script>");
	}
	Context ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/Invigilation");
    Connection con = ds.getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs;
	%>
	<!--district one导航条-->
	<div class="header">	
		
			<div class="container">
				    <h1 style="color:white;">TeacherPage</h1>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-5"></div>
					<div class="col-lg-1 "><font color="green"  style="font-size:25px; color:Orange;" ><%=loginNameOfTeacher%></font></div></a>					
					<div class="col-lg-1"></div>
					<a href="http://localhost:8080/SystemForInvigilation/Quit.jsp"><div class="col-lg-1" style="font-size:20px; color:Cyan;">登出</div></a>
					<a href="http://localhost:8080/SystemForInvigilation/teacher/Teacher.jsp"><div class="col-lg-1" style="font-size:20px; color:Cyan;">监考信息</div></a>
					<div class="col-lg-1"></div>		
					<div class="col-lg-1"></div>				
				</div>
			</div>
		
	</div>
	<br><br><br><br><br>
	<%
   String ChangeTheStateOfTeacherForOrder = " SELECT * " +
" FROM TheArrangement " + 
" where NameOfTeacher = '"+loginNameOfTeacher+"' ";
rs = stmt.executeQuery(ChangeTheStateOfTeacherForOrder);
%>
  <div class="container">
  <h2></h2>
  <p></p>  
  <%
  if (!rs.next()) {
  %>
   <div class="panel panel-warning">
      <div class="panel-heading">老师，你没有被安排参与监考，好好享受周末吧</div>
      <div class="panel-body" id="play">JUST PLAY FOR FUN</div>
    </div>
  <% 
    }
    else{
  %>  
    <div class="panel panel-warning">
      <div class="panel-heading">老师，你被安排参与了监考任务，我绝对相信你的大眼睛</div>
      <div class="panel-body" id="play">GO GO GO GO</div>
    </div>
  <table class="table">
    <thead>
      <tr>
        <th style="font-size:20px; color:Cyan;">TeacherName</th>
        <th style="font-size:20px; color:Cyan;">ClassRoom</th>
        <th style="font-size:20px; color:Cyan;">Date</th>
        <th style="font-size:20px; color:Cyan;">Subject</th>
      </tr>
    </thead>
      <tr class="success">
        <td><%=rs.getString("NameOfTeacher")%></td>
        <td><%=rs.getString("Classroom")%></td>
        <td><%=rs.getString("TheSubject")%></td>
        <td><%=rs.getString("ExamDate")%></td>
      </tr>
    <%
   while(rs.next()){
    %>
    <tr class="success">
        <td><%=rs.getString("NameOfTeacher")%></td>
        <td><%=rs.getString("Classroom")%></td>
        <td><%=rs.getString("TheSubject")%></td>
        <td><%=rs.getString("ExamDate")%></td>
      </tr>
  </table>
</div>
<%
}
}
%>
	</body>
	</html>