<jsp:include page='/MasterPageTopSection.jsp' />
<script src='${pageContext.request.contextPath}/js/DesignationEditForm.js'></script>
<script>
var code;
function getModule()
{
return 'DESIGNATION';
}
function updateDesignation()
{
var frm=document.getElementById('updateDesignationForm');
if(validateForm(frm)==false) return;
var notification=document.getElementById('notification');
var errorSection=document.getElementById('errorSection');
var designationEditModule=document.getElementById('designationEditModule');
notification.innerHTML='';
errorSection.innerHTML='';

var title=frm.title.value.trim();
var designation={
"code" : code,
"title" : title
};
var xmlHttpRequest=new XMLHttpRequest();
xmlHttpRequest.onreadystatechange=function(){
if(this.readyState==4)
{
if(this.status==200)
{
var response=JSON.parse(this.responseText);

if(response.success==false)
{
errorSection.innerHTML=response.error;
}
if(response.success==true)
{
designationEditModule.innerHTML='';
var h3=document.createElement('h3');
h3.textContent='Notification';
var br=document.createElement('br');
var responseDataNode=document.createTextNode("Designation Updated");
var okButton=document.createElement('button');
okButton.innerHTML='Ok';
okButton.type='button';
okButton.addEventListener("click",function(){
window.location.href='${pageContext.request.contextPath}/Designations.jsp';
});
notification.appendChild(h3);
notification.appendChild(responseDataNode);
notification.appendChild(br);
notification.appendChild(okButton);
}
}
else
{
alert('some problem');
}
}
};
xmlHttpRequest.open('POST','updateDesignation',true);
xmlHttpRequest.setRequestHeader("Content-Type","application/json");
xmlHttpRequest.send(JSON.stringify(designation));
}

function getDesignation()
{
var url=new URLSearchParams(window.location.search);
code=url.get('code');


var title=document.getElementById('title');
var xmlHttpRequest=new XMLHttpRequest();
xmlHttpRequest.onreadystatechange=function(){
if(this.readyState==4)
{
if(this.status==200)
{
var response=JSON.parse(this.responseText);

if(response.success==false)
{
window.location.href="${pageContext.request.contextPath}/Designations.jsp";
return;
}
title.value=response.result.title;
}
else
{
alert('some problem');
}
}
};
var requestURL="getDesignation?code="+encodeURI(code);
xmlHttpRequest.open('GET',requestURL,true);
xmlHttpRequest.send();
}
window.addEventListener('load',getDesignation);
</script>
<span id='notification'></span>

<span id='designationEditModule'>
<h2>Designation (Edit Module)</h2>
<span class='error' id='errorSection'></span>
<form id='updateDesignationForm'>
Designation
<input type='text' id='title' name='title' maxlength='35' size='36'>
<span id='titleErrorSection' class='error'></span>
<br>
<table>
<td><button type='button' onclick='updateDesignation()' >Update</button></td>
<td><button type='button' onclick='cancelUpdate()'>Cancel</button></td>
</table>
</form>
<form id='cancelUpdateForm' action='${pageContext.request.contextPath}/Designations.jsp'></form>
</span>
<jsp:include page='/MasterPageBottomSection.jsp' />