CLASS zap_15062026_001 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

*  Attribute of class

    DATA : ms_flight TYPE /dmo/flight.   "*workarea as attribute*"
    DATA : mv_text TYPE string.
    CONSTANTS : gc_text TYPE string VALUE 'Constructor is Called'.

    METHODS:
      constructor,
      display_flight.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zap_15062026_001 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*  Declaring refrence variable of the class

    DATA : lo_obj TYPE REF TO zap_15062026_001.
*Instantiating object of the class
    lo_obj = NEW zap_15062026_001(  ).

*Calling Method Of the class
    lo_obj->display_flight( ).
    out->write(
EXPORTING
data = lo_obj->mv_text
    ).
    out->write(
    EXPORTING
    data = lo_obj->ms_flight
    ).


  ENDMETHOD.


  METHOD display_flight.

*SELECT single is to read the single row from the database table keep into the work area directly.

    SELECT SINGLE *
    FROM /dmo/flight
    INTO @me->ms_flight.   "Me is the self referencing system defined reference variable(object of a class)
    IF sy-subrc = 0.
    ENDIF.
  ENDMETHOD.



  METHOD constructor.

    mv_text = gc_text.

  ENDMETHOD.

ENDCLASS.
