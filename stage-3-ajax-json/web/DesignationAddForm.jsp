<jsp:include page='/MasterPageTopSection.jsp' />
<script src='${pageContext.request.contextPath}/js/DesignationAddForm.js'></script>
<script>
function getModule()
{
return 'DESIGNATION';
}
function addDesignation()
{
var frm=document.getElementById('addDesignationForm');
var designationAddModule=document.getElementById('designationAddModule');
var designationAddModuleInnerHTML;
var notification=document.getElementById('notification');

var errorSection=document.getElementById('errorSection');
errorSection.innerHTML='';
notification.innerHTML=''
if(validateForm(frm)==false) return;
var title=frm.title.value.trim();
var code=0;
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
var yesButton=document.createElement('button');
yesButton.innerHTML='Yes';
yesButton.type='button';
yesButton.addEventListener("click",function(){
notification.innerHTML='';
designationAddModule.innerHTML=designationAddModuleInnerHTML;
});
var noButton=document.createElement('button');
noButton.innerHTML='No';
noButton.type='button';
noButton.addEventListener("click",function(){
window.location.href="${pageContext.request.contextPath}/Designations.jsp";
return;
});
if(response.success==false)
{
errorSection.innerHTML=response.error;
}
if(response.success==true)
{
errorSection.innerHTML='';
designationAddModuleInnerHTML=designationAddModule.innerHTML;
designationAddModule.innerHTML='';
var h3=document.createElement("h3");
var br=document.createElement("br");
h3.textContent="Notification";
notification.appendChild(h3);
var responseDataNode=document.createTextNode("Designation added, add more?");
notification.appendChild(responseDataNode);
notification.appendChild(br);
var table=document.createElement("table");
var tr=document.createElement("tr");
var td1=document.createElement("td");
var td2=document.createElement("td");
td1.appendChild(yesButton);
td2.appendChild(noButton);
tr.appendChild(td1);
tr.appendChild(td2);
table.appendChild(tr);
notification.appendChild(table);
}	
}
else
{
alert('some problem');
}
}
};
xmlHttpRequest.open('POST','addDesignation',true);
xmlHttpRequest.setRequestHeader("Content-Type","application/json");
xmlHttpRequest.send(JSON.stringify(designation));
}
</script>
<b><span id='notification'></span></b>
<span id='designationAddModule'>
<h2>Designation (Add Module)</h2>
<span class='error' id='errorSection'></span>
<form id='addDesignationForm'>
Designation
<input type='text' id='title' name='title' maxlength='35' size='36'>
<span id='titleErrorSection' class='error'></span>
<br>
<table>
<tr>
<td><button type='button' onclick='addDesignation()' >Add</button></td>
<td><button type='button' onclick='cancelAddition()'>Cancel</button></td>
</tr>
</table>
</form>
<form id='cancelAdditionForm' action='${pageContext.request.contextPath}/Designations.jsp'></form>
</span>
<jsp:include page='/MasterPageBottomSection.jsp' />