CLASS zap_lcl_connection1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

ENDCLASS.



CLASS zap_lcl_connection1 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA:
      lv_carrier_id    TYPE /dmo/carrier_id VALUE 'LH',
      lv_connection_id TYPE /dmo/connection_id VALUE '0400',
      lv_airport_from  TYPE /dmo/airport_from_id,
      lv_airport_to    TYPE /dmo/airport_to_id.

    SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id,
             airport_to_id
      WHERE carrier_id    = @lv_carrier_id
        AND connection_id = @lv_connection_id
      INTO ( @lv_airport_from,
             @lv_airport_to ).

    IF sy-subrc = 0.

      out->write( '---------------------------' ).
      out->write( |Carrier:     { lv_carrier_id }| ).
      out->write( |Connection:  { lv_connection_id }| ).
      out->write( |Departure:   { lv_airport_from }| ).
      out->write( |Destination: { lv_airport_to }| ).

    ELSE.

      out->write( 'Connection not found' ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.
