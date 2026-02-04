<jsp:include page='MasterPageTopSection.jsp' />
<script src='${pageContext.request.contextPath}/js/EmployeeEditForm.js'></script>
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
var employeeEditForm=document.getElementById('employeeEditForm');

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
employeeEditForm.name.value=employee.name;
employeeEditForm.designationCode.value=employee.designationCode;
var date=new Date(employee.dateOfBirth);

var year=date.getUTCFullYear();
var month=String(date.getUTCMonth()+1).padStart(2,'0');
var day=String(date.getUTCDate()).padStart(2,'0');
var dateOfBirth=year+"-"+month+"-"+day;
employeeEditForm.dateOfBirth.value=dateOfBirth;

if(employee.gender=='M')
{
employeeEditForm.gender[0].checked=true;
}
else
{
employeeEditForm.gender[1].checked=true;
}
if(employee.isIndian==true)
{
employeeEditForm.isIndian.checked=true;
}
employeeEditForm.basicSalary.value=employee.basicSalary;
employeeEditForm.panNumber.value=employee.panNumber;
employeeEditForm.aadharCardNumber.value=employee.aadharCardNumber;

}else
{
alert('some problem');
}
}
};
var requestURL="getEmployee?employeeId="+encodeURI(employeeId);
xmlHttpRequest.open('GET',requestURL,true);
xmlHttpRequest.send();
}
function updateEmployee()
{
var employeeEditForm=document.getElementById('employeeEditForm');

if(validateForm(employeeEditForm)==false) return;

var employeeEditModule=document.getElementById('employeeEditModule');

var notificationSection=document.getElementById('notificationSection');
var designationCodeErrorSection=document.getElementById('designationCodeErrorSection');
var panNumberErrorSection=document.getElementById('panNumberErrorSection');
var aadharCardNumberErrorSection=document.getElementById('aadharCardNumberErrorSection');
designationCodeErrorSection.innerHTML='';
panNumberErrorSection.innerHTML='';
aadharCardNumberErrorSection.innerHTML='';


var xmlHttpRequest=new XMLHttpRequest();
xmlHttpRequest.onreadystatechange=function(){
if(this.readyState==4)
{
if(this.status==200)
{
var response=JSON.parse(this.responseText);

if(response.success==true)
{
designationCodeErrorSection.innerHTML='';
panNumberErrorSection.innerHTML='';
aadharCardNumberErrorSection.innerHTML='';
employeeEditModule.innerHTML='';

var h3=document.createElement('h3');
h3.textContent='Notification';
var responseDataNode=document.createTextNode("Employee updated");
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
var errorsArray=Object.entries(response.errors);
var key;
var value;
for(var entry of errorsArray)
{
key=entry[0];
value=entry[1];
if(key=='designationCode')
{
designationCodeErrorSection.innerHTML='';
designationCodeErrorSection.innerHTML=value;
}
if(key=='panNumber')
{
panNumberErrorSection.innerHTML='';
panNumberErrorSection.innerHTML=value;
}
if(key=='aadharCardNumber')
{
aadharCardNumberErrorSection.innerHTML='';
aadharCardNumberErrorSection.innerHTML=value;
}
}

}
}
else
{
alert('some problem');
}
}
};
var name=employeeEditForm.name.value.trim();
var designationCode=employeeEditForm.designationCode.value;
var dateOfBirth=employeeEditForm.dateOfBirth.value;
var gender=employeeEditForm	.gender.value;

var isIndian;
if(employeeEditForm.isIndian.checked==true) isIndian=true;
else isIndian=false;

var basicSalary=employeeEditForm.basicSalary.value.trim();
var panNumber=employeeEditForm.panNumber.value.trim();
var aadharCardNumber=employeeEditForm.aadharCardNumber.value.trim();

var employee={
"employeeId" : employeeId,
"name" : name,
"designationCode" : designationCode,
"designation" : "",
"dateOfBirth" : dateOfBirth,
"gender" : gender,
"isIndian" : isIndian,
"basicSalary" : basicSalary,
"panNumber" : panNumber,
"aadharCardNumber" : aadharCardNumber
};
xmlHttpRequest.open('POST','updateEmployee',true);
xmlHttpRequest.setRequestHeader("Content-Type","application/json");
xmlHttpRequest.send(JSON.stringify(employee));
}
function populateComboBox()
{
var xmlHttpRequest=new XMLHttpRequest();
xmlHttpRequest.onreadystatechange=function(){
if(this.readyState==4)
{
if(this.status==200)
{
var response=JSON.parse(this.responseText);
var designations=response.result;
var designationCombo=document.getElementById('designationCode');
var option;
for(var k=0;k<designations.length;k++)
{
option=document.createElement('option');
option.value=designations[k].code;
option.text=designations[k].title;
designationCombo.appendChild(option);
}
getEmployee();
}
else
{
alert('some problem');
}
}
};
xmlHttpRequest.open('GET','getDesignations',true);
xmlHttpRequest.send();
}
window.addEventListener('load',populateComboBox);
//window.addEventListener('load',getEmployee);
</script>
<span id='notificationSection'></span>
<span id='employeeEditModule' >
<h2>Employee (Edit Module)</h2>
<form id='employeeEditForm'>
<table>
<tr>
<td>Name</td>
<td><input type='text' id='name' name='name' maxlength='50' size='51'>
<span id='nameErrorSection' style='color:red'></span></td>
</tr>
<tr>
<td>Designation</td>
<td><select id='designationCode' name='designationCode'>
<option value='-1'>&lt;Select Designation&gt;</option>
</select><span id='designationCodeErrorSection' style='color:red'></span></td>
</td>
</tr>
<tr>
<td>Date Of Birth</td>
<td><input type='Date' id='dateOfBirth' name='dateOfBirth' value='1970-01-01'>
<span id='dateOfBirthErrorSection' style='color:red'></span></td>
</tr>


<tr>
<td>Gender</td>
<td>
<input type='radio' id='male' name='gender' value='M'>Male
&nbsp;&nbsp;&nbsp;&nbsp;
<input type='radio' id='female' name='gender' value='F'>Female
<span id='genderErrorSection' style='color:red'></span></td>
</tr>

<tr>
<td>Indian ?</td>
<td><input type='checkbox' id='isIndian' name='isIndian' value='Y'>
<td><span id='isIndianErrorSection' style='color:red'></span></td>
</tr>

<td>Basic Salary</td>
<td><input type='text' style='text-align:right' id='basicSalary' name='basicSalary'>
<span id='basicSalaryErrorSection' style='color:red'></span></td>
</tr>

<td>PAN Number</td>
<td><input type='text' id='panNumber' name='panNumber' maxlength='10' size='11'>
<span id='panNumberErrorSection' style='color:red'></span></td>
</tr>

<td>Aadhar Card Number</td>
<td><input type='text' id='aadharCardNumber' name='aadharCardNumber' maxlength='10' size='11'>
<span id='aadharCardNumberErrorSection' style='color:red'></span></td>
</tr>

<tr colspan='2'>
<td><button type='button' onclick='updateEmployee()'>Update</button>
&nbsp;&nbsp;
<button type='button' onclick='cancelUpdation()'>Cancel</button></td>
</tr>
</table>
</form>
<form id='cancelUpdationForm' action='${pageContext.request.contextPath}/Employees.jsp'></form>
</span>
<jsp:include page='MasterPageBottomSection.jsp' />