public class FormController { 
    
    public Candidate__c cand{get;set;}
    public Job_Application__c jobapp{get;set;}
    public Job_Application__c jobapp1{get;set;}
    public Boolean isChecked{ get; set; }
    public string caList;
    public string cid;
    string posid;
    public Attachment adddoc {
        get {
            if (adddoc == null)
                adddoc = new Attachment();
            return adddoc;
        }
        set;
    }
    public Attachment resume {
        get {
            if (resume == null)
                resume = new Attachment();
            return resume;
        }
        set;
    }
    
    
    public FormController(){
        cand= new Candidate__c();
        jobapp= new Job_Application__c();
        jobapp1= new Job_Application__c();
    }
    
    public Pagereference saveaction(){
        system.debug(cand);
        
        if(isChecked==false && resume.body==null ){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Resume is required! And please ensure that you agree our policy'));
            return null;   
        }
        else if(isChecked==false && resume.body!=null){
            return null;   
        }
        else if(isChecked==true && resume.body==null){
            return null;   
        }
        else {
            posid= ApexPages.currentPage().getParameters().get('positionId');
            string url='/apex/thankYou';
            Pagereference newpage=new Pagereference(url);
            newpage.setRedirect(true);  
            system.debug(posid);
            caList = string.valueof([SELECT Id FROM Candidate__c WHERE Email__c = :cand.Email__c limit 1]);
            system.debug(caList);
            if(caList!='()') {
                cid= caList.substringBetween('=', ',');
                system.debug(cid);
                
            }
            else{
                cand.Name= cand.First_Name__c+' '+cand.Last_Name__c;
                insert cand;
                system.debug(caList);
                cid= string.valueof(cand.id);
            }
            system.debug(cand);
            jobapp1.Candidate__c=cid;
            jobapp1.Job_Position__c=posid;
            jobapp1.Status__c='New';
            jobapp1.Current_Employer__c=cand.Current_Company__c;
            jobapp1.Mobility__c=cand.Ready_to_relocate__c;
            jobapp1.Currently_Employed__c= jobapp.Currently_Employed__c;
            jobapp1.Sub_Channel__c='SpringFive Website';
            system.debug(jobapp);
            system.debug(jobapp1);
            try{ insert jobapp1;}
            finally{
                upload();
                return newpage;
            }
            
            return null;
            
        }        
        
    }
    public PageReference upload() {
        system.debug('eneterd');
        
        resume.OwnerId = UserInfo.getUserId();
        resume.ParentId = jobapp1.Id;//Record Id the file is attached to
        resume.ContentType = 'document/pdf';
        adddoc.OwnerId = UserInfo.getUserId();
        adddoc.ParentId = jobapp1.Id;//Record Id the file is attached to
        adddoc.ContentType = 'document/pdf';
        
        
        try {
            insert resume;
            insert adddoc;
            
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
            return null;
        } finally {
            resume = new Attachment();      
            adddoc = new Attachment();
            
        }       
        return null;
    }
    
    public List<SelectOption> getgender(){
        List<SelectOption> listgender = new list<SelectOption>();
        List<Schema.PicklistEntry> getGenderlist=Candidate__c.Gender__c.getDescribe().getPickListValues();
        for(Schema.PicklistEntry Gendervalue: getGenderlist){
            
            listgender.add(new SelectOption(Gendervalue.getValue(),Gendervalue.getLabel()));	
        }
        return listgender;
    }
    
}