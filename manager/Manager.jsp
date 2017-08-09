<%@ page contentType="text/html; charset=utf-8"%>
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
<title>ManagerPage</title>
<link rel="stylesheet" type="text/css" href="../LoginPage.css">
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
	<div class="sectionOne">	
	           <h3></h3>	
             
               <h3></h3> 
             </div>
             <div class="container">
               <br>
               <br>
               <br><br><br><br><br>
               <form class="form-inline" role="form" name="formOne" action="ds.jsp" onsubmit="ChangeTheStateOfTeacher(event)" >
                 <div class="form-group">
                   <label ><div style="color:orange; font-size:20px;">考试科目:</div></label>
                   <input type="text" class="form-control" name="TheSubject"  required>
                 </div>
                 <div class="form-group">
                   <label><div style="color:orange; font-size:20px;">考试时间:</div></label>
                   <input type="text" class="form-control" name="ExamTime" required >
                 </div>
                 <div class="form-group">
                   <label><div style="color:orange; font-size:20px;">考试教室:</div></label>
                   <input type="text" class="form-control" name="Classroom" required >
                 </div>
                 <input type="submit" class="btn btn-default" value="确认" name="SubmitOfManager" >
               </form>
             </div>
             <script>
               var TheSubject = document.forms["formOne"]["TheSubject"].value;
               var ExamTime = document.forms["formOne"]["ExamTime"].value;
               var Classroom = document.forms["formOne"]["Classroom"].value;
               function ChangeTheStateOfTeacher(event) {
                 event.preventDefault();
                if (window.XMLHttpRequest) {
                // code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();

                } else {
                // code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
               
             }
                xmlhttp.onreadystatechange = function() { 	
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                document.getElementById("JustForCheck").innerHTML = xmlhttp.responseText;
             }
         };
                xmlhttp.open("GET","ChangeTheStateOfTeacher.jsp?TheSubject="+document.forms["formOne"]["TheSubject"].value+"&&ExamTime="+document.forms["formOne"]["ExamTime"].value+"&&Classroom="+document.forms["formOne"]["Classroom"].value,false);
                xmlhttp.send();

    }

            </script>
    <div style="color:Cyan;text-align:center;font-size:30px;margin-right:590px;margin-top:50px;">若分配成功，分配信息将会出现在下面：</div>
    <div id="JustForCheck" ></div>
	</div>
	</body>
	</html>