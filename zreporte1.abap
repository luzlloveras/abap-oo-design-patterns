REPORT zreporte1.

INCLUDE: zreporte1_gd,  "Global declarations
         zreporte1_sel, "Selection screen
         zreporte1_cd,  "Class definitions
         zreporte1_ci.  "Class implementation

START-OF-SELECTION.
  go_flight_report = NEW #( ).
  go_flight_report->get_data( ).
  go_flight_report->display_alv( ).
