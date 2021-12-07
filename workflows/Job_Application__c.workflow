<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CTC_Rejected</fullName>
        <description>CTC Rejected</description>
        <protected>false</protected>
        <recipients>
            <recipient>yashwant.vizzappu@springfive.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CTC_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Email_Upon_Approval</fullName>
        <description>Email Upon Approval</description>
        <protected>false</protected>
        <recipients>
            <recipient>yashwant.vizzappu@springfive.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CTC_Approved</template>
    </alerts>
</Workflow>
