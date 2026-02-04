<jsp:include page='MasterPageTopSection.jsp' />
<script src='${pageContext.request.contextPath}/js/EmployeeAddForm.js'></script>
<link rel='stylesheet' type='text/css' url='${pageContext.request.contextPath}/css/employees.css' />
<script>
function getModule()
{
return 'EMPLOYEE';
}
function addEmployee()
{
var employeeAddForm=document.getElementById('employeeAddForm');

if(validateForm(employeeAddForm)==false) return;

var employeeAddModule=document.getElementById('employeeAddModule');
var employeeAddModuleInnerHTML;

var employeeAddModuleInnerHTML=employeeAddModule.innerHTML;
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
employeeAddModuleInnerHTML=employeeAddModule.innerHTML;
employeeAddModule.innerHTML='';

var h3=document.createElement('h3');
h3.textContent='Notification';
var responseDataNode=document.createTextNode("Employee added, add more ?");
var br=document.createElement('br');
var yesButton=document.createElement('button');
yesButton.innerHTML='Yes';
yesButton.type='button';
yesButton.addEventListener("click",function(){
notificationSection.innerHTML='';
employeeAddModule.innerHTML=employeeAddModuleInnerHTML;
});
var noButton=document.createElement('button');
noButton.innerHTML='No';
noButton.type='button';
noButton.addEventListener("click",function(){
window.location.href='${pageContext.request.contextPath}/Employees.jsp';
});
var table=document.createElement('table');
var td1=document.createElement('td');
var td2=document.createElement('td');
td1.appendChild(yesButton);
td2.appendChild(noButton);
table.appendChild(td1);
table.appendChild(td2);
notificationSection.appendChild(h3);
notificationSection.appendChild(responseDataNode);
notificationSection.appendChild(br);
notificationSection.appendChild(table);
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
var name=employeeAddForm.name.value.trim();

var designationCode=employeeAddForm.designationCode.value;
var dateOfBirth=new Date(employeeAddForm.dateOfBirth.value);
var gender=employeeAddForm	.gender.value;

var isIndian;
if(employeeAddForm.isIndian.checked==true) isIndian=true;
else isIndian=false;

var basicSalary=employeeAddForm.basicSalary.value.trim();
var panNumber=employeeAddForm.panNumber.value.trim();
var aadharCardNumber=employeeAddForm.aadharCardNumber.value.trim();

var employee={
"employeeId" : "",
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

xmlHttpRequest.open('POST','addEmployee',true);
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
</script>
<span id='notificationSection'></span>
<span id='employeeAddModule' >
<h2>Employee (Add Module)</h2>
<form id='employeeAddForm'>
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
<td><button type='button' onclick='addEmployee()'>Add</button>
&nbsp;&nbsp;
<button type='button' onclick='cancelAddition()'>Cancel</button></td>
</tr>
</table>
</form>
<form id='cancelAdditionForm' action='${pageContext.request.contextPath}/Employees.jsp'></form>
</span>
<jsp:include page='MasterPageBottomSection.jsp' />