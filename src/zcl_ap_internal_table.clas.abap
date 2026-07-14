CLASS zcl_ap_internal_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ap_internal_table IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES : BEGIN OF ty_output,
              travel_id     TYPE /dmo/travel_id,
              booking_id    TYPE /dmo/booking_id,
              carrier_id    TYPE /dmo/carrier_id,
              customer_id   TYPE /dmo/customer_id,
              connection_id TYPE /dmo/connection_id,
              airport_from  TYPE /dmo/airport_from_id,
              customer_name TYPE string,
              phone_number  TYPE /dmo/phone_number,
              status        TYPE /dmo/travel_status,
            END OF ty_output.

    DATA : lt_output TYPE SORTED  TABLE OF ty_output WITH UNIQUE KEY travel_id
                                                                     booking_id
                                                                     carrier_id
                                                                     customer_id.
    DATA: ls_output TYPE ty_output.

    DATA(today) = cl_abap_context_info=>get_system_date(  ).
    DATA: lt_flight TYPE TABLE OF /dmo/flight.
    SELECT * FROM /dmo/flight INTO TABLE @lt_flight.
    SELECT * FROM /dmo/carrier INTO TABLE @DATA(lt_carrier).
    SELECT * FROM /dmo/connection ORDER BY carrier_id, connection_id INTO TABLE @DATA(lt_connection).


    SELECT  FROM /dmo/travel AS a JOIN /dmo/customer AS b ON a~customer_id = b~customer_id
                                   JOIN /dmo/booking AS c ON b~customer_id = c~customer_id


                                 FIELDS a~travel_id,
                                 b~customer_id,
                                 b~first_name && b~last_name AS customer_name,
                                 b~phone_number,
                                 c~booking_id,
                                 c~carrier_id,
                                 c~connection_id,
                                 a~status

                                 INTO TABLE @DATA(lt_cust).
    IF sy-subrc EQ 0.

      SORT lt_flight BY carrier_id connection_id.
      LOOP AT lt_cust INTO DATA(ls_cust).

        ls_output-travel_id = ls_cust-travel_id.
        ls_output = CORRESPONDING #( ls_cust ).
        APPEND ls_output TO lt_output.
      ENDLOOP.

    ENDIF.


    out->write(
EXPORTING
data = lt_output
).
  ENDMETHOD.
ENDCLASS.
