* Snippet 1: new supplier enters review
DATA(lo_flow) = NEW lcl_supplier_flow( ).
DATA(ls_input) = VALUE ty_supplier_input(
  supplier_id = 'S-100'
  status      = 'NEW'
  risk_score  = 10 ).

DATA(ls_result) = lo_flow->execute( ls_input ).
IF ls_result-success = abap_true.
  WRITE: / ls_result-next_status.
ELSE.
  WRITE: / ls_result-message.
ENDIF.

* Snippet 2: review approves supplier
DATA(lo_flow_2) = NEW lcl_supplier_flow( ).
DATA(ls_input_2) = VALUE ty_supplier_input(
  supplier_id = 'S-200'
  status      = 'REVIEW'
  risk_score  = 55 ).

DATA(ls_result_2) = lo_flow_2->execute( ls_input_2 ).
IF ls_result_2-success = abap_true.
  WRITE: / ls_result_2-next_status.
ELSE.
  WRITE: / ls_result_2-message.
ENDIF.

* Snippet 3: unknown status returns an error
DATA(lo_flow_3) = NEW lcl_supplier_flow( ).
DATA(ls_input_3) = VALUE ty_supplier_input(
  supplier_id = 'S-300'
  status      = 'ARCHIVED'
  risk_score  = 10 ).

DATA(ls_result_3) = lo_flow_3->execute( ls_input_3 ).
WRITE: / ls_result_3-message.
