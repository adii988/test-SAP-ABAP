CLASS zcm_ap_travel DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .

    DATA customerid TYPE /dmo/customer_id .

    CONSTANTS:
      BEGIN OF already_canceled,
        msgid TYPE symsgid VALUE 'ZAP_TRAVEL',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'Travel is already Canceled',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF already_canceled,

      BEGIN OF field_empty,
        msgid TYPE symsgid VALUE 'ZAP_TRAVEL',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'Please Enter the Value',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF field_empty,



      BEGIN OF customer_not_exist,
        msgid TYPE symsgid VALUE 'ZAP_TRAVEL',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'Please Give the Valid Customer_ID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF customer_not_exist,


      BEGIN OF begin_date_past,
        msgid TYPE symsgid VALUE 'ZAP_TRAVEL',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'Please Valid the Date',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF begin_date_past,



       BEGIN OF end_date_past,
        msgid TYPE symsgid VALUE 'ZAP_TRAVEL',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'Please Valid the Date',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF end_date_past,



      BEGIN OF dates_wrong_sequence,
        msgid TYPE symsgid VALUE 'ZAP_TRAVEL',
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE 'Please Enter the Correct Date',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF dates_wrong_sequence.






    METHODS constructor
      IMPORTING
        !textid    LIKE if_t100_message=>t100key OPTIONAL
        severity   LIKE if_abap_behv_message~m_severity OPTIONAL
        customerid TYPE /dmo/customer_id OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcm_ap_travel IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    CALL METHOD super->constructor.

    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    IF severity IS INITIAL.
      if_abap_behv_message~m_severity = if_abap_behv_message~severity-error.
    ELSE.
      if_abap_behv_message~m_severity = severity.
    ENDIF.

*    IF customerid IS INITIAL.
*      if_abap_behv_message~m_severity = if_abap_behv_message~severity-error.
*    ELSE.
*      if_abap_behv_message~m_severity = severity.
*    ENDIF.


  ENDMETHOD.
ENDCLASS.
