@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View For Student'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
                        serviceQuality: #X,
                        sizeCategory: #S,
                        dataClass: #MIXED
                        }
define root view entity ZC_AP_P_Student
  as projection on ZAP_I_STUDENT as Student
{
      @EndUserText.label: 'Student ID'
  key ID,
      @EndUserText.label: 'First Name'
      Firstname,
      @EndUserText.label: 'Last Name'
      Lastname,
      @EndUserText.label: 'Age'
      Age,
      @EndUserText.label: 'Course'
      Course,
      @EndUserText.label: 'Courseduration'
      Courseduration,
      @EndUserText.label: 'Status'
      Status,
      @EndUserText.label: 'Gender'
      Gender,
      @EndUserText.label: 'DOB'
      DOB,
      @EndUserText.label: 'Lastchangedat'
      Lastchangedat,
      @EndUserText.label: 'Locallastchangedat'
      Locallastchangedat
      
      
}
