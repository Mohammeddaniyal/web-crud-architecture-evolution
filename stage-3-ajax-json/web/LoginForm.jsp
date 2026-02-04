<!DOCTYPE HTML>
<html lang='en'>
<head>
<meta charset='utf-8'>
<title>HR Application</title>
<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/styles.css'>
<script>
function authentication()
{
var username=document.getElementById('username').value.trim();
var password=document.getElementById('password').value.trim();
var administrator={
"username" : username,
"password" : password
};
var errorSection=document.getElementById('errorSection');
errorSection.innerHTML='';

var xmlHttpRequest=new XMLHttpRequest();
xmlHttpRequest.onreadystatechange=function(){
if(this.readyState==4)
{
if(this.status==200)
{
var response=JSON.parse(this.responseText);
if(response.success==true)
{
window.location.href='${pageContext.request.contextPath}/index.jsp';
return;
}
else if(response.success==false)
{
errorSection.innerHTML=response.error;
}
}else
{
alert('some problem');
}
}
};
xmlHttpRequest.open('POST','login',true);
xmlHttpRequest.setRequestHeader("Content-Type","application/json");
xmlHttpRequest.send(JSON.stringify(administrator));
}
</script>
</head>
<body>
<!-- Main container starts here-->
<div class='main-container'>
<!-- header starts here -->
<div class='header'>
<a href='${pageContext.request.contextPath}/index.jsp'><img src='${pageContext.request.contextPath}/images/logo.png' class='logo'></a><div class='brand-name'>&nbspThinking Machines</div>
</div>
<!-- header ends here -->
<!-- content-section starts here -->
<div class='content'>
<!-- login form section starts here -->
<div class='loginForm'>
<table border='0'>
<tr>
<td colspan='2' align='center'>
<span id='errorSection' class='error'></span><br>
</td>
</tr>
<tr>
<td>Username</td>
<td><input type='text' id='username' name='username' maxlength='15'></td>
</tr>
<tr>
<td>Password</td>
<td><input type='password' id='password' name='password' maxlength='15'>
</td>
</tr>
<tr>
<td colspan='2' align='center'>
<button type='button' onclick='authentication()'>Login</button>
</td>
</tr>
</table>
</div>
<!-- login form section ends here -->
</div>
<!-- content-section ends here -->
<!-- footer starts here -->
<div class='footer'>
&copy; Thinking Machines 2024
<!-- footer ends here -->
</div>
</div>
<!-- Main container ends here-->
</body>
</html>
