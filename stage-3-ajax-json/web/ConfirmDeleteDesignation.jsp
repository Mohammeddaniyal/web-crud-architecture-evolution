<jsp:include page='/MasterPageTopSection.jsp' />
<script src='${pageContext.request.contextPath}/js/ConfirmDeleteDesignation.js'></script>
<script>
function getModule()
{
return 'DESIGNATION';
}
function deleteDesignation()
{
var deleteDesignation=document.getElementById('deleteDesignation');
var notification=document.getElementById('notification');
notification.innerHTML='';
var code=document.getElementById('code').value;
var xmlHttpRequest=new XMLHttpRequest();
xmlHttpRequest.onreadystatechange=function(){
if(this.readyState==4)
{
if(this.status==200)
{
var response=JSON.parse(this.responseText);
var h3=document.createElement('h3');
h3.textContent='Notification';
var br=document.createElement('br');
var responseDataNode;
if(response.success==true)
{
responseDataNode=document.createTextNode("Designation deleted");
}else 
if(response.success==false)
{
responseDataNode=document.createTextNode(response.error);
}
var okButton;
okButton=document.createElement("button");
okButton.type='button';
okButton.innerHTML='Ok';
okButton.addEventListener("click",function(){
window.location.href='${pageContext.request.contextPath}/Designations.jsp';
return;
});
deleteDesignation.innerHTML='';
notification.appendChild(h3);
notification.appendChild(responseDataNode);
notification.appendChild(br);
notification.appendChild(okButton);
}
else
{
alert('some problem');
}
}
};
xmlHttpRequest.open('POST','deleteDesignation',true);
xmlHttpRequest.setRequestHeader("Content-Type","application/json");
xmlHttpRequest.send(JSON.stringify(code));
}

function getDesignation()
{
var url=new URLSearchParams(window.location.search);
var _code=url.get('code');
var designationSection=document.getElementById('designationSection');
designationSection.innerHTML='';
var code=document.getElementById('code');
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
designationSection.innerHTML=response.result.title;
code.value=response.result.code;
}
else
{
alert('some problem');
}
}
};
var requestURL="getDesignation?code="+encodeURI(_code);
xmlHttpRequest.open('GET',requestURL,true);
xmlHttpRequest.send();
}
window.addEventListener('load',getDesignation);
</script>
<b><span id='notification'></span></b>
<span id='deleteDesignation'>
<h2>Designation (Delete Module)</h2>
<b>Designation : <span id='designationSection'></span></b><br>
<input type='hidden' id='code' name='code'>
<br>
Are you sure you want to delete this designation ?<br>
<table>
<td><button type='button' onclick='deleteDesignation()' >Yes</button></td>
<td><button type='button' onclick='cancelDeletion()'>No</button></td>
</table>
<form id='cancelDeletionForm' action='${pageContext.request.contextPath}/Designations.jsp'></form>
</span>
<jsp:include page='/MasterPageBottomSection.jsp' />