CLASS zcl_ap_20260701 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ap_20260701 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA : lt_employees TYPE TABLE OF zap_employees.

    lt_employees = VALUE #(
    (
      client       = sy-mandt
      empid        = 'E0001'
      fname        = 'Lionel'
      lname        = 'Messi'
      currencycode = 'USD'
      salary       = 20000
      dob          = '19870624'
    )
    (
      client       = sy-mandt
      empid        = 'E0002'
      fname        = 'Christiano'
      lname        = 'Ronaldo'
      currencycode = 'USD'
      salary       = 20000
      dob          = '19860624'
    )
  ).

    LOOP AT lt_employees INTO DATA(ls_employees).
      INSERT zap_employees FROM @ls_employees.
    ENDLOOP.


  ENDMETHOD.
ENDCLASS.
