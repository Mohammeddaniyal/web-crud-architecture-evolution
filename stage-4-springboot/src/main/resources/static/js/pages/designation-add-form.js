window.pages.designationAddForm={
    save: async function()
    {
        const frm=document.getElementById('addDesignationForm');
        const notification=document.getElementById('notification');
        const errorSection=document.getElementById('errorSection');
        const designationAddModule=document.getElementById('designationAddModule');
        notification.innerHTML='';
        errorSection.innerHTML='';
        if(!designationValidator.validate(frm)) return;


        const title=frm.title.value.trim();

        const designation={
        'code':0,
        'title':title
        };
        try
        {
            const response=await designationService.add(designation);
            alert(`Designation ${response.title} added with code ${response.code}`);
            designationAddModule.innerHTML='';
            notification.innerHTML=`
            <h3>Notification</h3><br>
            Designation added, add more ?<br>
            <table>
            <tr>
            <td>
            <button type="button" onclick="loadModule('designation-add-form')">Yes</button>
            </td>
            <td>
            <button type="button" onclick="loadModule('designations')">No</button>
            </td>
            </tr>
            </table>
            `;
        }catch(error)
        {
            alert(error);
        }

    }
};