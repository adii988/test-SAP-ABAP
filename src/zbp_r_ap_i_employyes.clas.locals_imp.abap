CLASS lhc_ZR_AP_I_EMPLOYYES DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_ap_i_employyes RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_ap_i_employyes RESULT result.
    METHODS validatesal FOR VALIDATE ON SAVE
      IMPORTING keys FOR zr_ap_i_employyes~validatesal.

ENDCLASS.

CLASS lhc_ZR_AP_I_EMPLOYYES IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validatesal.

    READ ENTITIES OF zr_ap_i_employyes
    ENTITY zr_ap_i_employyes
    FIELDS ( Salary )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_emp).
    IF lt_emp IS NOT INITIAL.

    data(ls_emp) = value #( lt_emp[ 1 ] optional ).
    if ls_emp-Salary <= 10000.

*Every validation method will have Field and Reported internal tables which will use to shows error message

    APPEND value #( %tky = ls_emp-%tky ) to failed-zr_ap_i_employyes.
    APPEND VALUE #(
                    %tky = ls_emp-%tky
                    %msg = NEW_MESSAGE_WITH_TEXT( severity = if_abap_behv_message=>severity-error
                    text = 'Salary should be greater then 10000' )
                     ) to reported-zr_ap_i_employyes.

                     ENDIF.

    ENDIF.

  ENDMETHOD.


ENDCLASS.
