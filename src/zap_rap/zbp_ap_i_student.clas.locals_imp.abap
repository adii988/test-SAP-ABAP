CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Student RESULT result.
    METHODS setadmitted FOR MODIFY
      IMPORTING keys FOR ACTION student~setadmitted RESULT result.

ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD setAdmitted.


  MODIFY ENTITIES OF zap_i_student IN LOCAL MODE
  ENTITY Student
  UPDATE
  FIELDS ( Status )
  WITH VALUE #( FOR key in keys ( %tky = key-%tky Status = abap_true ) )

  FAILED failed
  REPORTED reported.

  "Get the response Update the Record

  READ ENTITIES OF zap_i_student IN LOCAL MODE
  ENTITY Student
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(studentdata).
  result = VALUE #( FOR studentrec in studentdata
  ( %tky = studentrec-%tky %param = studentrec ) ).


  ENDMETHOD.

ENDCLASS.
