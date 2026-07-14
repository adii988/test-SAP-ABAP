CLASS lhc_ZR_AP_I_TRAVEL DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_ap_i_travel RESULT result.

    METHODS cancel_travel FOR MODIFY
      IMPORTING keys FOR ACTION zr_ap_i_travel~cancel_travel.

    METHODS validatebegindate FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validateBeginDate.

    METHODS validatecustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validatecustomer.

    METHODS validatedescription FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validatedescription.

    METHODS validateenddate FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validateenddate.



    METHODS determinestatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR travel~determinestatus.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR travel RESULT result.

    METHODS validatedatesequence FOR VALIDATE ON SAVE
      IMPORTING keys FOR travel~validatedatesequence.

    METHODS determineduration FOR DETERMINE ON SAVE
      IMPORTING keys FOR travel~determineduration.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE travel.



ENDCLASS.

CLASS lhc_ZR_AP_I_TRAVEL IMPLEMENTATION.

  METHOD get_global_authorizations.

    result-%create           = if_abap_behv=>auth-allowed.
    result-%update           = if_abap_behv=>auth-allowed.
    result-%delete           = if_abap_behv=>auth-allowed.

  ENDMETHOD.

  METHOD cancel_travel.

    READ ENTITIES OF zr_ap_i_travel
        ENTITY Travel
          ALL FIELDS
          WITH CORRESPONDING #( keys )
          RESULT DATA(travels).

    LOOP AT travels INTO DATA(travel).
      IF travel-status <> 'C'.
        MODIFY ENTITIES OF zr_ap_i_travel IN LOCAL MODE
          ENTITY zr_ap_i_travel
            UPDATE
            FIELDS ( status )
            WITH VALUE #( ( %tky   = travel-%tky
                             status = 'C' ) ).
      ELSE.
        APPEND VALUE #( %tky = travel-%tky )
          TO failed-Travel.

        APPEND VALUE #(
          %tky = travel-%tky
          %msg = NEW zcm_ap_travel(
             textid =
               zcm_ap_travel=>already_canceled )  )
      TO reported-travel.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validateBeginDate.

    READ ENTITIES OF zr_ap_i_travel IN LOCAL MODE
      ENTITY Travel
        FIELDS ( BeginDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(travels).
    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).
      IF <travel>-BeginDate IS INITIAL.
        APPEND VALUE #(  %tky = <travel>-%tky )
          TO failed-travel.
        APPEND VALUE #( %tky               = <travel>-%tky
                        %msg               = NEW zcm_ap_travel(
                                   textid = zcm_ap_travel=>field_empty )
                        %element-BeginDate = if_abap_behv=>mk-on )
          TO reported-travel.
      ELSEIF <travel>-begindate <
                        cl_abap_context_info=>get_system_date(  ).
        APPEND VALUE #(  %tky = <travel>-%tky )
          TO failed-travel.
        APPEND VALUE #( %tky               = <travel>-%tky
                        %msg               = NEW zcm_ap_travel(
                               textid = zcm_ap_travel=>begin_date_past )
                        %element-Begindate = if_abap_behv=>mk-on )
          TO reported-travel.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateCustomer.
  CONSTANTS c_area TYPE string value 'CUST'.

    READ ENTITIES OF zr_ap_i_travel IN LOCAL MODE
      ENTITY Travel
        FIELDS ( CustomerId )
        WITH CORRESPONDING #( keys )
        RESULT DATA(travels).
    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).
      IF <travel>-CustomerId IS INITIAL.
        APPEND VALUE #(  %tky = <travel>-%tky )
          TO failed-travel.
        APPEND VALUE #( %tky                = <travel>-%tky
                        %msg                = NEW zcm_ap_travel(
                                    textid = zcm_ap_travel=>field_empty )
                        %element-CustomerId = if_abap_behv=>mk-on )
          TO reported-travel.
      ELSE.
        SELECT SINGLE FROM /dmo/i_customer
          FIELDS CustomerID
          WHERE CustomerID = @<travel>-CustomerId
          INTO @DATA(dummy).
        IF sy-subrc <> 0.
          APPEND VALUE #(  %tky = <travel>-%tky )
            TO failed-travel.
          APPEND VALUE #( %tky                = <travel>-%tky
                          %msg                = NEW zcm_ap_travel(
                   textid     = zcm_ap_travel=>customer_not_exist
                   customerid = <travel>-CustomerId )
                          %element-CustomerId = if_abap_behv=>mk-on
                          %state_area = c_area )
            TO reported-travel.
        ENDIF.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.

  METHOD validateDescription.

    CONSTANTS c_area TYPE string VALUE `DESC`.

    READ ENTITIES OF zr_ap_i_travel IN LOCAL MODE
    ENTITY Travel
      FIELDS ( Description )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).

      " Step 1: clear any old DESC-area messages for this record first
      APPEND VALUE #( %tky        = <travel>-%tky
                      %state_area = c_area )
        TO reported-travel.

      " Step 2: now do the actual check
      IF <travel>-Description IS INITIAL.
        APPEND VALUE #( %tky = <travel>-%tky )
          TO failed-travel.

        APPEND VALUE #( %tky                 = <travel>-%tky
                        %msg                 = NEW zcm_ap_travel(
                                    textid = zcm_ap_travel=>field_empty )
                        %element-Description = if_abap_behv=>mk-on
                        %state_area          = c_area )
          TO reported-travel.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateEndDate.

    READ ENTITIES OF zr_ap_i_travel IN LOCAL MODE
     ENTITY Travel
       FIELDS ( EndDate )
       WITH CORRESPONDING #( keys )
       RESULT DATA(travels).
    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).

      IF <travel>-EndDate IS INITIAL.
        APPEND VALUE #(  %tky = <travel>-%tky )
          TO failed-travel.
        APPEND VALUE #( %tky             = <travel>-%tky
                        %msg             = NEW zcm_ap_travel(
                                 textid = zcm_ap_travel=>field_empty )
                        %element-EndDate = if_abap_behv=>mk-on )
          TO reported-travel.
      ELSEIF <travel>-EndDate <
                      cl_abap_context_info=>get_system_date(  ).
        APPEND VALUE #(  %tky = <travel>-%tky )
          TO failed-travel.

        APPEND VALUE #( %tky             = <travel>-%tky
                        %msg             = NEW zcm_ap_travel(
                               textid = zcm_ap_travel=>end_date_past )
                        %element-EndDate = if_abap_behv=>mk-on )
          TO reported-travel.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.

  METHOD earlynumbering_create.

    SELECT SINGLE MAX( travel_id ) FROM zap_travel INTO @DATA(lv_travelid).
    mapped-travel = CORRESPONDING #( entities ).
    LOOP AT mapped-travel ASSIGNING FIELD-SYMBOL(<mapping>).

      <mapping>-TravelId = lv_travelid + 1.

    ENDLOOP.

*    DATA lv_max_travelid TYPE /dmo/travel_id.
*
*    SELECT SINGLE MAX( travel_id ) FROM zap_travel INTO @lv_max_travelid.
*
*    mapped-travel = CORRESPONDING #( entities ).
*    LOOP AT mapped-travel ASSIGNING FIELD-SYMBOL(<mapping>).
*
*      lv_max_travelid = lv_max_travelid + 1.
*      <mapping>-TravelId = lv_max_travelid.
*
*    ENDLOOP.

  ENDMETHOD.

  METHOD determineStatus.
    READ ENTITIES OF zr_ap_i_travel IN LOCAL MODE
      ENTITY Travel
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(travels).

    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).
*      if <travel>-TravelId is INITIAL.
      MODIFY ENTITIES OF zr_ap_i_travel IN LOCAL MODE
      ENTITY Travel
      UPDATE FIELDS ( Status )
      WITH VALUE #( FOR key IN travels ( %tky = key-%tky
                                         Status = 'N' ) )

                    REPORTED DATA(update_reported).
      reported = CORRESPONDING #( DEEP update_reported ).
*                    ENDIF.
    ENDLOOP.

*    DELETE travels WHERE Status IS NOT INITIAL.
*    CHECK travels IS NOT INITIAL.
*    MODIFY ENTITIES OF zr_ap_i_travel IN LOCAL MODE
*      ENTITY Travel
*        UPDATE FIELDS ( Status )
*        WITH VALUE #( FOR key IN travels ( %tky   = key-%tky
*                                           Status = 'N' )  )
*        REPORTED DATA(update_reported).
*    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD get_instance_features.




    READ ENTITIES OF zr_ap_i_travel IN LOCAL MODE
    ENTITY Travel
    FIELDS ( Status BeginDate EndDate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).
      APPEND CORRESPONDING #( <travel> ) TO result
        ASSIGNING FIELD-SYMBOL(<result>).

      " ---------- NEW: handle draft vs active data ----------
      IF <travel>-%is_draft = if_abap_behv=>mk-on.

        READ ENTITIES OF zr_ap_i_travel IN LOCAL MODE
          ENTITY Travel
            FIELDS ( BeginDate EndDate )
            WITH VALUE #( ( %key = <travel>-%key ) )
            RESULT DATA(travels_active).

        IF travels_active IS NOT INITIAL.
          <travel>-BeginDate = travels_active[ 1 ]-BeginDate.
          <travel>-EndDate   = travels_active[ 1 ]-EndDate.
        ENDIF.

      ENDIF.
      " ---------- END NEW ----------

      IF <travel>-Status = 'C' OR
         ( <travel>-EndDate IS NOT INITIAL AND
           <travel>-EndDate < cl_abap_context_info=>get_system_date( ) ).

        <result>-%update               = if_abap_behv=>fc-o-disabled.
        <result>-%action-cancel_travel = if_abap_behv=>fc-o-disabled.
      ELSE.
        <result>-%update               = if_abap_behv=>fc-o-enabled.
        <result>-%action-cancel_travel = if_abap_behv=>fc-o-enabled.

      ENDIF.

      IF <travel>-BeginDate IS NOT INITIAL AND
         <travel>-BeginDate < cl_abap_context_info=>get_system_date( ).
        <result>-%field-CustomerId = if_abap_behv=>fc-f-read_only.
        <result>-%field-BeginDate  = if_abap_behv=>fc-f-read_only.
      ELSE.

        <result>-%field-CustomerId = if_abap_behv=>fc-f-mandatory.
        <result>-%field-BeginDate  = if_abap_behv=>fc-f-mandatory.

      ENDIF.

    ENDLOOP.


  ENDMETHOD.


  METHOD validateDateSequence.

    READ ENTITIES OF zr_ap_i_travel IN LOCAL MODE
      ENTITY Travel
        FIELDS ( BeginDate EndDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(travels).
    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).
      IF <travel>-EndDate < <travel>-BeginDate.
        APPEND VALUE #( %tky = <travel>-%tky )
          TO failed-travel.

        APPEND VALUE #( %tky     = <travel>-%tky
                        %msg     = NEW zcm_ap_travel(
                                 textid = zcm_ap_travel=>dates_wrong_sequence )
                        %element = VALUE #(
                                 BeginDate = if_abap_behv=>mk-on
                                 EndDate   = if_abap_behv=>mk-on ) )
          TO reported-travel.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD determineDuration.

  READ ENTITIES OF zr_ap_i_travel IN LOCAL MODE
  ENTITY Travel
  FIELDS ( BeginDate EndDate )
  WITH CORRESPONDING #( keys )
  RESULT DATA(travels).

   LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).
  <travel>-Duration = <travel>-EndDate - <travel>-BeginDate.
   ENDLOOP.

   MODIFY ENTITIES OF zr_ap_i_travel IN LOCAL MODE
   ENTITY Travel
   UPDATE
   FIELDS ( Duration )
    WITH CORRESPONDING #( travels ).


  ENDMETHOD.

ENDCLASS.
