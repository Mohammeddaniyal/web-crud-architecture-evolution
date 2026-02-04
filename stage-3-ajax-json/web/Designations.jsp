<jsp:include page='/MasterPageTopSection.jsp' />

<script>
function getModule()
{
return 'DESIGNATION';
}
function populateDesignations()
{
var xmlHttpRequest=new XMLHttpRequest();
xmlHttpRequest.onreadystatechange=function()
{
if(this.readyState==4)
{
if(this.status==200)
{
var response=JSON.parse(this.responseText);
var designations=response.result;
var designationTable=document.getElementById('designationTable');

var designationTableBody=designationTable.getElementsByTagName('tbody')[0];

var designationTableBodyRowTemplate=designationTableBody.getElementsByTagName("tr")[0];

designationTableBodyRowTemplate.remove();
var designationTableColumnsTemplateCollection=designationTableBodyRowTemplate.getElementsByTagName("td");


var cellTemplate;
var dynamicRow;
var dynamicRowCells;
var placeHolderFor;
var k;
var sno;
for(k=0,sno=0;k<designations.length;k++,sno++)
{
dynamicRow=designationTableBodyRowTemplate.cloneNode(true);
designationTableBody.appendChild(dynamicRow);
dynamicRowCells=dynamicRow.getElementsByTagName("td");
for(var i=0;i<dynamicRowCells.length;i++)
{
cellTemplate=dynamicRowCells[i];
placeHolderFor=cellTemplate.getAttribute("placeHolderId");
if(placeHolderFor==null) continue;
if(placeHolderFor=='serialNumber') cellTemplate.innerHTML=(sno+1)+'.';
if(placeHolderFor=='designation') cellTemplate.innerHTML=designations[k].title;
if(placeHolderFor=='editOption') cellTemplate.innerHTML="<a href='${pageContext.request.contextPath}/DesignationEditForm.jsp?code="+designations[k].code+"'>Edit</a>"
if(placeHolderFor=='deleteOption') cellTemplate.innerHTML="<a href='${pageContext.request.contextPath}/ConfirmDeleteDesignation.jsp?code="+designations[k].code+"'>Delete</a>"
}
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
		          
window.addEventListener('load',populateDesignations);
</script>

<h2>Designations</h2>
<table border='1' id='designationTable'>
<thead>
<tr>
<th colspan='4' style='text-align:right;padding:5px'>
<a href='${pageContext.request.contextPath}/DesignationAddForm.jsp'>Add new Designation</a>
</th>
</tr>
<tr>
<th style='width:60px;text-align:center'>S.No</th>
<th style='width:200px;text-align:center'>Designation</th>
<th style='width:100px;text-align:center'>Edit</th>
<th style='width:100px;text-align:center'>Delete</th>
</tr>
</thead>
<tbody>
<tr>
<td placeHolderId='serialNumber' style='text-align:right'></td>
<td placeHolderId='designation'></td>
<td placeHolderId='editOption' style='text-align:center'></td>
<td placeHolderId='deleteOption' style='text-align:center'></td>
</tr>
</tbody>
</table>
<jsp:include page='/MasterPageBottomSection.jsp' />