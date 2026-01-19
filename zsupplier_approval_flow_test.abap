CLASS ltc_supplier_flow DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA mo_flow TYPE REF TO lcl_supplier_flow.
    METHODS setup.
    METHODS:
      test_new_supplier_ok FOR TESTING,
      test_new_supplier_missing_id FOR TESTING,
      test_review_approve_ok FOR TESTING,
      test_unknown_status FOR TESTING,
      test_factory_selection FOR TESTING.
ENDCLASS.

CLASS ltc_supplier_flow IMPLEMENTATION.
  METHOD setup.
    mo_flow = NEW lcl_supplier_flow( ).
  ENDMETHOD.

  METHOD test_new_supplier_ok.
    DATA(ls_input) = VALUE ty_supplier_input(
      supplier_id = 'S-100'
      status      = 'NEW'
      risk_score  = 10 ).

    DATA(ls_result) = mo_flow->execute( ls_input ).

    cl_abap_unit_assert=>assert_true( ls_result-success = abap_true ).
    cl_abap_unit_assert=>assert_equals( exp = 'REVIEW' act = ls_result-next_status ).
  ENDMETHOD.

  METHOD test_new_supplier_missing_id.
    DATA(ls_input) = VALUE ty_supplier_input(
      supplier_id = ``
      status      = 'NEW'
      risk_score  = 10 ).

    DATA(ls_result) = mo_flow->execute( ls_input ).

    cl_abap_unit_assert=>assert_true( ls_result-success = abap_false ).
    cl_abap_unit_assert=>assert_equals( exp = `` act = ls_result-next_status ).
  ENDMETHOD.

  METHOD test_review_approve_ok.
    DATA(ls_input) = VALUE ty_supplier_input(
      supplier_id = 'S-200'
      status      = 'REVIEW'
      risk_score  = 65 ).

    DATA(ls_result) = mo_flow->execute( ls_input ).

    cl_abap_unit_assert=>assert_true( ls_result-success = abap_true ).
    cl_abap_unit_assert=>assert_equals( exp = 'APPROVED' act = ls_result-next_status ).
  ENDMETHOD.

  METHOD test_unknown_status.
    DATA(ls_input) = VALUE ty_supplier_input(
      supplier_id = 'S-300'
      status      = 'ARCHIVED'
      risk_score  = 10 ).

    DATA(ls_result) = mo_flow->execute( ls_input ).

    cl_abap_unit_assert=>assert_true( ls_result-success = abap_false ).
    cl_abap_unit_assert=>assert_equals( exp = 'Unknown status' act = ls_result-message ).
  ENDMETHOD.

  METHOD test_factory_selection.
    DATA(lo_factory) = NEW lcl_strategy_factory( ).
    DATA(lo_strategy) = lo_factory->get_strategy( 'NEW' ).

    cl_abap_unit_assert=>assert_true(
      lo_strategy IS INSTANCE OF lcl_new_supplier_strategy ).
  ENDMETHOD.
ENDCLASS.
