@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Student'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
                        serviceQuality: #X,
                        sizeCategory: #S,
                        dataClass: #MIXED
                        }
define root view entity ZAP_I_STUDENT
  as select from zap_student
{
  key id             as ID,
      firstname      as Firstname,
      lastname       as Lastname,
      age            as Age,
      course         as Course,
      courseduration as Courseduration,
      status         as Status,
      gender         as Gender,
      dob            as DOB,
      lastchangedat as Lastchangedat,
      locallastchangedat as Locallastchangedat


}
