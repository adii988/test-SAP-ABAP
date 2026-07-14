@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'AP : Projection View on Travel'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_AP_P_Travel
  provider contract transactional_query as projection on ZR_AP_I_TRAVEL
{
    key TravelId,
    
    
    @Consumption.valueHelpDefinition: [
      { entity: { name:    'ZR_AP_I_AGENCY_VH',
                   element: 'AgencyId' } } ]
    
    
    key AgencyId,
    
    @Consumption.valueHelpDefinition: [
      { entity: { name:    '/DMO/I_Customer_StdVH',
                   element: 'CustomerID' } } ]
    
    CustomerId,
    BeginDate,
    EndDate,
    @EndUserText.label: 'Duration (days)'
    Duration,
    
    Status,
    
    @Consumption.valueHelpDefinition:
        [ { entity: { name: 'I_Currency', element: 'Currency' } } ]
    
    CurrencyCode,
    @Semantics.amount.currencyCode : 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode : 'CurrencyCode'
    TotalPrice,
    Description,
    
//    StatusCriticality, 
    ChangedAt,
    ChangedBy,
    _Item : redirected to composition child ZC_AP_P_TravelItem
}
