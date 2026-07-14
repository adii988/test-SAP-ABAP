@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'AP : Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.extensibility.extensible: true
define root view entity ZR_AP_I_TRAVEL
  as select from zap_travel
  composition [0..*]  of ZR_AP_I_TRAVELITEM as _Item
{
  key travel_id      as TravelId,
  key agency_id      as AgencyId,
      customer_id    as CustomerId,
      begin_date     as BeginDate,
      end_date       as EndDate,
      currency_code  as CurrencyCode,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      booking_fee    as BookingFee,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      total_price    as TotalPrice,
      description    as Description,
 
      
      dats_days_between( begin_date,end_date ) as Duration,
      
      status         as Status,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat  as ChangedAt,
      @Semantics.user.lastChangedBy: true
      localchangedby as ChangedBy,
      //
      _Item // Make association public
}
