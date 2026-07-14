@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Define Projection View For Travelitem'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_AP_P_TravelItem as projection on ZR_AP_I_TRAVELITEM
{
    key ItemUuid,
    AgencyId,
    TravelId,
    
    @Consumption.valueHelpDefinition: [
      { entity: { name:    '/DMO/I_Carrier_StdVH',
                   element: 'AirlineID' } } ]
    
    CarrierId,
    ConnectionId,
    FlightDate,
    BookingId,
    PassengerFirstName,
    PassengerLastName,
    Lastchangedat,
    /* Associations */
    _Travel : redirected to parent ZC_AP_P_Travel
}
