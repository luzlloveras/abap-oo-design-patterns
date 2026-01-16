DATA go_flight_report TYPE REF TO lcl_flight_report.
CLASS lcl_flight_report IMPLEMENTATION.

  METHOD get_data.

    "Join carrier, flight schedule, and bookings for report output
    SELECT scarr~carrid, scarr~carrname, scarr~currcode,
    spfli~connid, spfli~countryfr, spfli~cityfrom, spfli~countryto, spfli~cityto,
            sflight~fldate, sflight~price, sflight~planetype, sflight~seatsmax, sflight~seatsocc,
      sbook~bookid, sbook~customid, sbook~custtype, sbook~smoker, sbook~luggweight
      FROM scarr
      INNER JOIN spfli ON spfli~carrid = scarr~carrid
    INNER JOIN sflight ON sflight~carrid = spfli~carrid
      AND sflight~connid = spfli~connid
    INNER JOIN sbook ON sbook~carrid = sflight~carrid
      AND sbook~connid = sflight~connid
      AND sbook~fldate = sflight~fldate
      WHERE carrname = @p_name
      INTO TABLE @DATA(lt_join).

    gt_alv = lt_join.

  ENDMETHOD.

  METHOD display_alv.
    TYPE-POOLS: slis.

    DATA: lt_fieldcat TYPE slis_t_fieldcat_alv,
          ls_layout   TYPE slis_layout_alv.

    lt_fieldcat = VALUE #( ( fieldname = 'Carrid' seltext_l = 'Carrier ID' outputlen = '15' )
                           ( fieldname = 'Carrname' seltext_l = 'Carrier' outputlen = '15' )
                           ( fieldname = 'Currcode' seltext_l = 'Currency' outputlen = '15' )
                           ( fieldname = 'Connid' seltext_l = 'Connection' outputlen = '15' )
                           ( fieldname = 'Countryfr' seltext_l = 'From Country' outputlen = '15' )
                           ( fieldname = 'Cityfrom' seltext_l = 'From City' outputlen = '15' )
                           ( fieldname = 'Countryto' seltext_l = 'To Country' outputlen = '15' )
                           ( fieldname = 'Cityto' seltext_l = 'To City' outputlen = '15' )
                           ( fieldname = 'Fldate' seltext_l = 'Flight Date' outputlen = '15' )
                           ( fieldname = 'Price' seltext_l = 'Price' outputlen = '15' )
                           ( fieldname = 'Planetype' seltext_l = 'Aircraft' outputlen = '15' )
                           ( fieldname = 'Seatsmax' seltext_l = 'Seats Max' outputlen = '15' )
                           ( fieldname = 'Seatsocc' seltext_l = 'Seats Occ' outputlen = '15' )
                           ( fieldname = 'Bookid' seltext_l = 'Booking ID' outputlen = '15' )
                           ( fieldname = 'Customid' seltext_l = 'Customer ID' outputlen = '15' )
                           ( fieldname = 'Custtype' seltext_l = 'Customer Type' outputlen = '15' )
                           ( fieldname = 'Smoker' seltext_l = 'Smoker' outputlen = '15' )
                           ( fieldname = 'Luggweight' seltext_l = 'Luggage Weight' outputlen = '15' ) ).

    CLEAR ls_layout.
    ls_layout-zebra = abap_true.
    ls_layout-colwidth_optimize = abap_true.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program = sy-repid
        is_layout          = ls_layout
        it_fieldcat        = lt_fieldcat
      TABLES
        t_outtab           = gt_alv
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
    ENDIF.

  ENDMETHOD.


ENDCLASS.
