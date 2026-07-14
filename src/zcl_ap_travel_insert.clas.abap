CLASS zcl_ap_travel_insert DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ap_travel_insert IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DELETE FROM zap_travel.
    COMMIT WORK.




    INSERT zap_travel FROM ( SELECT
    Travel_id,
    Agency_id,
    Customer_id,
    Begin_date,
    End_date,
    Booking_fee,
    Total_price,
    Currency_code,
    Description,
    Status
    FROM /dmo/travel ).

    COMMIT WORK.
    out->write( 'Data Insert Done!' ).



  ENDMETHOD.
ENDCLASS.
