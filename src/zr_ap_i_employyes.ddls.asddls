@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee root view entity (Interface)'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_AP_I_EMPLOYYES as select from zap_employees
//composition of target_data_source_name as _association_name
{
    key emp_uuid as EmpUuid,
    key empid as Empid,
    fname as Fname,
    lname as Lname,
    currencycode as Currencycode,
    @Semantics.amount.currencyCode: 'Currencycode'
    salary as Salary,
    dob as Dob,
    age as Age,
    changedby as Changedby,
    lastchangedat as Lastchangedat
    //_association_name // Make association public
}
