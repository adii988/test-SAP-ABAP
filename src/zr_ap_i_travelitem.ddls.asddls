@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Interface for Travel Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_AP_I_TRAVELITEM as select from ZAP_TRAVELITEM
association to parent ZR_AP_I_TRAVEL as _Travel
    on $projection.TravelId = _Travel.TravelId and $projection.AgencyId = _Travel.AgencyId
{
    key item_uuid as ItemUuid,
    agency_id as AgencyId,
    travel_id as TravelId,
    carrier_id as CarrierId,
    connection_id as ConnectionId,
    flight_date as FlightDate,
    booking_id as BookingId,
    passenger_first_name as PassengerFirstName,
    passenger_last_name as PassengerLastName,
    lastchangedat as Lastchangedat,
    _Travel // Make association public
}
