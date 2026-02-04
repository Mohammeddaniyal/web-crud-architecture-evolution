<!DOCTYPE HTML>
<html lang='en'>
<head>
<meta charset='utf-8'>
<title>HR Application</title>
<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/styles.css'>
<script>
function guard()
{
var xmlHttpRequest=new XMLHttpRequest();
xmlHttpRequest.onreadystatechange=function(){
if(this.readyState==4)
{
if(this.status==200)
{
var response=JSON.parse(this.responseText);
if(response.success==true)
{
document.getElementById('username').innerHTML=splits[1];
}else
if(response.success==false)
{
window.location.href='${pageContext.request.contextPath}/LoginForm.jsp';
return;
}
}
else
{
alert('some problem');
}
}
};
xmlHttpRequest.open('GET','getUsernameInSession',true);
xmlHttpRequest.send();
}
function generateNavigationPanel()
{
var module=getModule();
var navigationPanel=document.getElementById('navigationPanel');

var designationsLink=document.createElement('a');
designationsLink.href='${pageContext.request.contextPath}/Designations.jsp';
designationsLink.textContent='Designations';

var employeesLink=document.createElement('a');
employeesLink.href='${pageContext.request.contextPath}/Employees.jsp';
employeesLink.textContent='Employees';

var boldDesignations=document.createElement('b');
var designationsText=document.createTextNode('Designations');
boldDesignations.appendChild(designationsText);

var boldEmployees=document.createElement('b');
var employeesText=document.createTextNode('Employees');
boldEmployees.appendChild(employeesText);

var homeLink=document.createElement('a');
homeLink.href='${pageContext.request.contextPath}/index.jsp';
homeLink.textContent='Home';

var br1=document.createElement('br');
var br2=document.createElement('br');

if(module=='DESIGNATION')
{
navigationPanel.appendChild(boldDesignations);
navigationPanel.appendChild(br1);
navigationPanel.appendChild(employeesLink);
navigationPanel.appendChild(br2);
navigationPanel.appendChild(homeLink);
}else if(module=='EMPLOYEE')
{
navigationPanel.appendChild(designationsLink);
navigationPanel.appendChild(br1);
navigationPanel.appendChild(boldEmployees);
navigationPanel.appendChild(br2);
navigationPanel.appendChild(homeLink);
}else if(module=='HOME')
{
navigationPanel.appendChild(designationsLink);
navigationPanel.appendChild(br1);
navigationPanel.appendChild(employeesLink);
}
}
function logout()
{
var xmlHttpRequest=new XMLHttpRequest();
xmlHttpRequest.onreadystatechange=function(){
if(this.readyState==4)
{
if(this.status==200)
{
window.location.href='${pageContext.request.contextPath}/LoginForm.jsp';
}
else
{
alert('some problem');
}
}
};
xmlHttpRequest.open('POST','logout',true);
xmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
xmlHttpRequest.send();
}
window.addEventListener('load',generateNavigationPanel);
guard();
</script>
</head>
<body>
<!-- Main container starts here-->
<div class='main-container'>
<!-- header starts here -->
<div class='header'>
<a href='${pageContext.request.contextPath}/index.jsp'><img src='${pageContext.request.contextPath}/images/logo.png' class='logo'></a>
<div class='brand-name'>&nbsp;HR Core</div>
<div class='username'>
<img src='${pageContext.request.contextPath}/images/user.png'/>
<span id='username'></span>&nbsp;
<a href='#' onclick='logout()'>Logout</a>
</div>
</div><!-- header ends here -->
<!-- content-section starts here -->
<div class='content'>
<!-- left panel starts here -->
<div id='navigationPanel' class='content-left-panel'>
</div>
<!-- left panel ends here -->
<!-- right panel starts here -->
<div class='content-right-panel'>