@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Define Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_AP_I_EMPLOYEES
provider contract transactional_query as projection on ZR_AP_I_EMPLOYYES
{
    key EmpUuid,
    key Empid,
    Fname,
    Lname,
    Currencycode,
    @Semantics.amount.currencyCode: 'Currencycode'
    Salary,
    Dob,
    Age,
    Changedby,
    Lastchangedat
}
