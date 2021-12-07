@isTest
public class TestFormController {
    
    public static testMethod void testMyController(){
        FormController con = new FormController();
        List<SelectOption> selOpts=con.getgender();
        //con.isChecked=true;
        con.upload();    
        con.saveaction();
    
        
    }
       public static testMethod void testMyController2(){
        FormController con = new FormController();
        List<SelectOption> selOpts=con.getgender();
        con.isChecked=false;
        con.resume.body=null;
        con.upload();    
        con.saveaction();
    
        
    }
           public static testMethod void testMyController3(){
        FormController con = new FormController();
        List<SelectOption> selOpts=con.getgender();
               con.isChecked=true;
        con.resume.body=null;
        con.upload();    
        con.saveaction();
    
        
    }


}