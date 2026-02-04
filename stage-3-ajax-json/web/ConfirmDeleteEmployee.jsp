<jsp:include page='MasterPageTopSection.jsp' />
<script src='${pageContext.request.contextPath}/js/ConfirmDeleteEmployee.js'></script>
<link rel='stylesheet' type='text/css' url='${pageContext.request.contextPath}/css/employees.css' />
<script>
function getModule()
{
return 'EMPLOYEE';
}
var employeeId;
function getEmployee()
{
var url=new URLSearchParams(window.location.search);
employeeId=url.get('employeeId');
var employeeDeleteForm=document.getElementById('employeeDeleteForm');
var employeeDataModule=document.getElementById('employeeDataModule');

var xmlHttpRequest=new XMLHttpRequest();
xmlHttpRequest.onreadystatechange=function(){
if(this.readyState==4)
{
if(this.status==200)
{
var response=JSON.parse(this.responseText);
if(response.success==false)
{
window.location.href='${pageContext.request.contextPath}/Employees.jsp';
return;
}

var employee=response.result;

var name=document.createElement('b');
name.textContent=employee.name;
var nameTextNode=document.createTextNode("Name : ");
var designation=document.createElement('b');
designation.textContent=employee.designation;
var designationTextNode=document.createTextNode("Designation : ");

var date=new Date(employee.dateOfBirth);
var year=date.getUTCFullYear();
var month=String(date.getUTCMonth()+1).padStart(2,'0');
var day=String(date.getUTCDate()+1).padStart(2,'0');
var dateOfBirth=document.createElement('b');
dateOfBirth.textContent=day+"/"+month+"/"+year;
var dateOfBirthTextNode=document.createTextNode("Date Of Birth : ");



var gender=document.createElement('b');
gender.textContent=(employee.gender=='M')?'Male':'Female';
var genderTextNode=document.createTextNode("Gender : ");
var isIndian=document.createElement('b');
var isIndianTextNode;
if(employee.isIndian==true)
{
isIndian.textContent="Indian";
}
else
{
isIndian.textContent="Not an Indian";
}
isIndianTextNode=document.createTextNode("Nationality Indian : ");

var basicSalary=document.createElement('b');
basicSalary.textContent=employee.basicSalary;

var basicSalaryTextNode=document.createTextNode("Basic Salary : ");
var panNumber=document.createElement('b');
panNumber.textContent=employee.panNumber;
var panNumberTextNode=document.createTextNode("PAN number : ");
var aadharCardNumber=document.createElement('b');
aadharCardNumber.textContent=employee.aadharCardNumber;
var aadharCardNumberTextNode=document.createTextNode("Aadhar card number : ");
var br1=document.createElement('br');
var br2=document.createElement('br');
var br3=document.createElement('br');
var br4=document.createElement('br');
var br5=document.createElement('br');
var br6=document.createElement('br');
var br7=document.createElement('br');
var br8=document.createElement('br');

employeeDataModule.appendChild(nameTextNode);
employeeDataModule.appendChild(name);
employeeDataModule.appendChild(br1);

employeeDataModule.appendChild(designationTextNode);
employeeDataModule.appendChild(designation);
employeeDataModule.appendChild(br2);

employeeDataModule.appendChild(dateOfBirthTextNode);
employeeDataModule.appendChild(dateOfBirth);
employeeDataModule.appendChild(br3);

employeeDataModule.appendChild(genderTextNode);
employeeDataModule.appendChild(gender);
employeeDataModule.appendChild(br4);

employeeDataModule.appendChild(isIndianTextNode);
employeeDataModule.appendChild(isIndian);
employeeDataModule.appendChild(br5);

employeeDataModule.appendChild(basicSalaryTextNode);
employeeDataModule.appendChild(basicSalary);
employeeDataModule.appendChild(br6);

employeeDataModule.appendChild(panNumberTextNode);
employeeDataModule.appendChild(panNumber);
employeeDataModule.appendChild(br7);


employeeDataModule.appendChild(aadharCardNumberTextNode);
employeeDataModule.appendChild(aadharCardNumber);
employeeDataModule.appendChild(br8);
}else
{
}
}
};
var requestURL="getEmployee?employeeId="+encodeURI(employeeId);
xmlHttpRequest.open('GET',requestURL,true);
xmlHttpRequest.send();
}
function deleteEmployee()
{
var employeeDeleteForm=document.getElementById('employeeDeleteForm');

var notificationSection=document.getElementById('notificationSection');


var xmlHttpRequest=new XMLHttpRequest();
xmlHttpRequest.onreadystatechange=function(){
if(this.readyState==4)
{
if(this.status==200)
{
var response=JSON.parse(this.responseText);

if(response.success==true)
{
employeeDeleteModule.innerHTML='';

var h3=document.createElement('h3');
h3.textContent='Notification';
var responseDataNode=document.createTextNode("Employee deleted");
var br=document.createElement('br');
var okButton=document.createElement('button');
okButton.innerHTML='Ok';
okButton.type='button';
okButton.addEventListener("click",function(){
window.location.href='${pageContext.request.contextPath}/Employees.jsp';
});
notificationSection.appendChild(h3);
notificationSection.appendChild(responseDataNode);
notificationSection.appendChild(br);
notificationSection.appendChild(okButton);
}
else
{
alert('error section');
}
}
else
{
alert('some problem');
}
}
};


xmlHttpRequest.open('POST','deleteEmployee',true);
xmlHttpRequest.setRequestHeader("Content-Type","application/json");
xmlHttpRequest.send(JSON.stringify(employeeId));
}
window.addEventListener('load',getEmployee);
</script>
<span id='notificationSection'></span>
<span id='employeeDeleteModule' >
<h2>Employee (Delete Module)</h2>
<span id='employeeDataModule'></span><br>
Are you sure you want to delete this employee ?<br>
<tr colspan='2'>
<td><button type='button' onclick='deleteEmployee()'>Yes</button>
&nbsp;
<button type='button' onclick='cancelDeletion()'>No</button></td>
</tr>
</table>
</form>
<form id='cancelDeletionForm' action='${pageContext.request.contextPath}/Employees.jsp'></form>
</span>
<jsp:include page='MasterPageBottomSection.jsp' />