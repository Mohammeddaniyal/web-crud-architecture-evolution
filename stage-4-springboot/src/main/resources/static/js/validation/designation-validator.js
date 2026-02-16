const designationValidator={

    validate : function(frm)
    {
        var nn=frm.title.value.trim();
        var titleErrorSection=document.getElementById('titleErrorSection');
        titleErrorSection.innerHTML='';
        if(nn.length==0)
        {
        titleErrorSection.innerHTML='required';
        frm.title.focus();
        return false;
        }
        return true;
    }

};