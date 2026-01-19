REPORT zsupplier_approval_flow.

TYPES: BEGIN OF ty_supplier_input,
         supplier_id TYPE string,
         status      TYPE string,
         risk_score  TYPE i,
       END OF ty_supplier_input.

TYPES: BEGIN OF ty_flow_result,
         success     TYPE abap_bool,
         message     TYPE string,
         next_status TYPE string,
       END OF ty_flow_result.

INTERFACE if_supplier_strategy.
  METHODS validate
    IMPORTING is_input         TYPE ty_supplier_input
    RETURNING VALUE(rs_result) TYPE ty_flow_result.
ENDINTERFACE.

CLASS lcl_new_supplier_strategy DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_supplier_strategy.
ENDCLASS.

CLASS lcl_review_strategy DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_supplier_strategy.
ENDCLASS.

CLASS lcl_strategy_factory DEFINITION.
  PUBLIC SECTION.
    METHODS get_strategy
      IMPORTING iv_status        TYPE string
      RETURNING VALUE(ro_result) TYPE REF TO if_supplier_strategy.
ENDCLASS.

CLASS lcl_supplier_flow DEFINITION.
  PUBLIC SECTION.
    METHODS execute
      IMPORTING is_input         TYPE ty_supplier_input
      RETURNING VALUE(rs_result) TYPE ty_flow_result.
ENDCLASS.

CLASS lcl_new_supplier_strategy IMPLEMENTATION.
  METHOD if_supplier_strategy~validate.
    rs_result-success = abap_false.
    rs_result-next_status = ``.

    IF is_input-supplier_id IS INITIAL.
      rs_result-message = 'Supplier ID is required'.
      RETURN.
    ENDIF.

    rs_result-success = abap_true.
    rs_result-message = 'Supplier validated for review'.
    rs_result-next_status = 'REVIEW'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_review_strategy IMPLEMENTATION.
  METHOD if_supplier_strategy~validate.
    rs_result-success = abap_false.
    rs_result-next_status = ``.

    IF is_input-risk_score > 70.
      rs_result-message = 'Risk score is too high'.
      RETURN.
    ENDIF.

    rs_result-success = abap_true.
    rs_result-message = 'Supplier approved'.
    rs_result-next_status = 'APPROVED'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_strategy_factory IMPLEMENTATION.
  METHOD get_strategy.
    CASE iv_status.
      WHEN 'NEW'.
        CREATE OBJECT ro_result TYPE lcl_new_supplier_strategy.
      WHEN 'REVIEW'.
        CREATE OBJECT ro_result TYPE lcl_review_strategy.
      WHEN OTHERS.
        CLEAR ro_result.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_supplier_flow IMPLEMENTATION.
  METHOD execute.
    DATA(lo_factory) = NEW lcl_strategy_factory( ).
    DATA(lo_strategy) = lo_factory->get_strategy( is_input-status ).

    IF lo_strategy IS INITIAL.
      rs_result-success = abap_false.
      rs_result-message = 'Unknown status'.
      rs_result-next_status = ``.
      RETURN.
    ENDIF.

    rs_result = lo_strategy->validate( is_input ).
  ENDMETHOD.
ENDCLASS.

INCLUDE zsupplier_approval_flow_test.
