<%@ page contentType="text/html; charset=utf-8" import="java.util.*"%>
<% request.setCharacterEncoding("utf-8"); %>

	
<%
	Cookie[] loginSuccess = request.getCookies();//取loginSuccess为Cookie数组的名字，取得所有Cookie		
	if(loginSuccess != null ){	//如果Cookie存在的话
	int loginSuccessLength = loginSuccess.length;//取得Cookie数组的存放数量，用length方法，并且把值给定义为INT型的loginSuccessLength
	for(int i=0; i<loginSuccessLength;i++){		//循环比对所有Cookie的名称
	
	loginSuccess[i].setMaxAge(0);//将名称为loginSuccess的Cookie的生命周期生为0
	response.addCookie(loginSuccess[i]);//将已经定义好的生命周期给loginSuccess，用response物件的addCookie（）方法
	 
	}
	

}	
	out.println("<script>window.location.href='LoginPage.html';</script>");
	%>
