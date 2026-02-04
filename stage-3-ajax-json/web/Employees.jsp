<jsp:include page='/MasterPageTopSection.jsp' />
<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/employees.css'>
<script src='${pageContext.request.contextPath}/js/Employees.js'></script>
<script>
function getModule()
{
return 'EMPLOYEE';
}
function populateEmployees()
{
var xmlHttpRequest=new XMLHttpRequest();
xmlHttpRequest.onreadystatechange=function(){
if(this.readyState==4)
{
if(this.status==200)
{
var response=JSON.parse(this.responseText);
var _employees=response.result;
var employee;
var i=0;
var k;
var date;
var year;
var month;
var day;
for(k=0;k<_employees.length;k++)
{
employee=new Employee();
employee.employeeId=_employees[k].employeeId;
employee.name=_employees[k].name;
employee.designationCode=_employees[k].designationCode;
employee.designation=_employees[k].designation;
date=new Date(_employees[k].dateOfBirth);
year=date.getUTCFullYear();
month=String(date.getUTCMonth()+1).padStart(2,'0');
day=String(date.getUTCDate()+1).padStart(2,'0');
employee.dateOfBirth=day+"/"+month+"/"+year;
employee.gender=_employees[k].gender;
if(_employees[k].isIndian==true) employee.isIndian=true;
else employee.isIndian=false;
employee.basicSalary=_employees[k].basicSalary;
employee.panNumber=_employees[k].panNumber;
employee.aadharCardNumber=_employees[k].aadharCardNumber;

employees[i++]=employee
}

populateEmployeesGridTable();

}
else
{
alert('some problem');
}
}
};
xmlHttpRequest.open('GET','getEmployees',true);
xmlHttpRequest.send();
}
window.addEventListener('load',populateEmployees);
</script>
<h4>Employees</h4>
<div class='employeeGrid'>
<table border='1' id='employeesGridTable'>
<thead>
<tr>
<th colspan='6' class='employeeGridHeader'>
<a href='${pageContext.request.contextPath}/EmployeeAddForm.jsp'>Add Employee</a>
</th>
</tr>
<tr>
<th class='employeeGridSNOColumnTitle'>S.No</th>
<th class='employeeGridIdColumnTitle'>Id.</th>
<th class='employeeGridNameColumnTitle'>Name</th>
<th class='employeeGridDesignationColumnTitle'>Designation</th>
<th class='employeeGridEditOptionColumnTitle'>Edit</th>
<th class='employeeGridDeleteOptionColumnTitle'>Delete</th>
</tr>
</thead>
<tbody>
<tr style='cursor:pointer'>
<td style='text-align:right' placeHolderId='serialNumber'></td>
<td placeHolderId='employeeId'></td>
<td placeHolderId='name'></td>
<td placeHolderId='designation'></td>
<td style='text-align:center' placeHolderId='editOption'></td>
<td style='text-align:center' placeHolderId='deleteOption'></td>
</tr>
</tbody>
</table>
</div>
<div style='height:19vh;margin-left:5.25px;margin-right:5px;margin-bottom:px;margin-top:5px;padding:5px;border:1px solid black'>
<label style='background:gray;color:white;padding-left:5px;padding-right:5px'>Details</label>

<table border='0' width='100%'>
<tr>
<td>Employee Id : <span id='detailPanel_employeeId' style='margin-right:30px'></span></td>
<td>Name : <span id='detailPanel_name' style='margin-right:30px'></span></td>
<td>Designation : <span id='detailPanel_designation' style='margin-right:30px'><span></td>
</tr>
<tr>
<td>Date of birth : <span id='detailPanel_dateOfBirth' style='margin-right:30px'></span></td>
<td>Gender : <span id='detailPanel_gender' style='margin-right:30px'></span></td>
<td>Is Indian : <span id='detailPanel_isIndian' style='margin-right:30px'></span></td>
</tr>
<tr>
<td>Basic Salary : <span id='detailPanel_basicSalary' style='margin-right:30px'></span></td>
<td>Pan Number : <span id='detailPanel_panNumber' style='margin-right:30px'></span></td>
<td>Aadhar Card Number : <span id='detailPanel_aadharCardNumber' style='margin-right:30px'></span></td>
</tr>
</table>
</div>
<jsp:include page='MasterPageBottomSection.jsp' />