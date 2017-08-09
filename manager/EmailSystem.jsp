<%@ page contentType="text/html; charset=utf-8" import="java.util.* , java.io.*" %>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="javax.mail.PasswordAuthentication"%>
<%@ page import="javax.activation.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
InternetAddress[] address = null ;
String mailserver = "smtp.163.com";
String From = "18816500304@163.com";
String To =  request.getParameter("To");
String Subject = request.getParameter("Subject");
String messageText = request.getParameter("Content");

%>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
<center>
	<font size="5" color="blue">mail system</font>
</center>
<hr>
<p></p>
<%
try{
	Properties props = System.getProperties();
	props.put("mail.host",mailserver);
	props.put("mail.transport.protocol","smtp");
	props.put("mail.smtp.auth","true");

	Authenticator auth = new javax.mail.Authenticator(){
	    String userName = "18816500304";
	    String password = "XXXXXXXXXX";
	    protected PasswordAuthentication getPasswordAuthentication(){
	    return new PasswordAuthentication(userName, password);
	}
};	

	Session mailSession = javax.mail.Session.getInstance(props,auth);
	mailSession.setDebug(false);
	MimeMessage msg = new MimeMessage(mailSession);
	msg.setFrom( new InternetAddress(From));
	address = InternetAddress.parse(To,false);
	msg.setRecipients(Message.RecipientType.TO, address);
	msg.setSubject(Subject);
	msg.setSentDate(new Date());
	msg.setText(messageText,"utf-8");
	Transport.send(msg);
	out.println("<font size=5 color=red>emai Ok</font>");
	out.println("<script language='javascript'>window.alert('email OK');window.location.href='EmailSystemInterface.jsp';</script>");
}
catch(MessagingException mex){
	out.println("error is "+mex.toString()+" " );
}

%>
<font color="blue">收件人：</font><%= To%><br>
<font color="blue">发送mail的服务器：</font><%= mailserver%><br>
<font color="blue">寄件人：</font><%= From%><br>
<font color="blue">信件内容：</font><%= messageText%><br>
</body>
</html>