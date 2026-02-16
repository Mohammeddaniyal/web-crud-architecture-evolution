class DesignationService
{
constructor()
{
this.url='/api/designations';
}

async getAll()
{
const response=await fetch(this.url);
if(!response.ok) throw new Error('Failed to fetch designations');
return await response.json();
}

async getByCode(code)
{
const response=await fetch(`${this.url}/${code}`);
if(!response.ok) throw new Error('Designation not found');
return await response.json();
}

async add(designation)
{
const response=await fetch(this.url,{
method:'POST',
headers:{
'Content-Type':'application/json'
},
body:JSON.stringify(designation)
});
if(!response.ok)
{
const errorBody=await response.text();
throw new Error(`Server error ${response.status} : ${errorBody}`);
}
return await response.json();
}


async update(designation)
{
const response=await fetch(`${this.url}/${designation.code}`,{
method:'PUT',
headers:{
'Content-Type':'application/json'
},
body:JSON.stringify(designation)
});
if(!response.ok) throw new Error('Failed to update designations');
return await response.json();
}

async delete(code)
{
const response=await fetch(`${this.url}/code`,{
method:'DELETE'
});
if(!response.ok) throw new Error('Failed to delete designations');
return await response.json();
}

}

const designationService=new DesignationService();