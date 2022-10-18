*&---------------------------------------------------------------------*
*& Report z182_02_mfse213
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z182_02_mfse213.

SELECT FROM sflight
    FIELDS carrid, connid, fldate
    INTO TABLE @DATA(gt_flights).

DATA(gv_carrid) = 'AA'.

SELECT FROM sflight
    FIELDS carrid, connid, fldate
    WHERE carrid EQ @gv_carrid
    INTO TABLE @gt_flights.

READ TABLE gt_flights INTO DATA(gs_new_flights1) INDEX 1.

TRY.
    DATA(gs_new_flights2) = gt_flights[ 1 ].
    gs_new_flights2 = gt_flights[ carrid = 'AA' connid = '1017' ].
    DATA(gv_carrid2) = gt_flights[ 3 ]-carrid.
  CATCH cx_sy_itab_line_not_found INTO DATA(gx_exc).
    gx_exc->get_text( ).
ENDTRY.

APPEND INITIAL LINE TO gt_flights ASSIGNING FIELD-SYMBOL(<gs_new_flight>).
<gs_new_flight>-carrid = 'LH'.

DATA: gv_value1 TYPE f VALUE '10',
      gv_value2 TYPE f VALUE '1.9'.

DATA(gv_final) = gv_value1 + gv_value2.

SELECT FROM sflight
    FIELDS carrid, connid, fldate
    INTO TABLE @DATA(gt_new_flights).

SELECT FROM sflight
    FIELDS carrid, connid, fldate
    INTO TABLE @DATA(gt_airlines).

DATA: gt_final TYPE TABLE OF sflight,
      gs_final TYPE sflight.

LOOP AT gt_new_flights ASSIGNING FIELD-SYMBOL(<gs_old_flights>)
        WHERE carrid EQ 'LH'.
  LOOP AT gt_airlines INTO DATA(gs_old_airlines)
          WHERE connid EQ <gs_old_flights>-connid.
    gs_final-carrid = <gs_old_flights>-carrid.
    gs_final-connid = gs_old_airlines-connid.
    APPEND gs_final TO gt_final.
  ENDLOOP.
ENDLOOP.

gt_final = VALUE #( FOR <gs_new_flights> IN gt_new_flights WHERE ( carrid EQ 'LH' )
                    FOR gs_new_airlines IN gt_airlines WHERE ( connid EQ <gs_new_flights>-connid )
                    ( carrid = <gs_new_flights>-carrid
                      connid = gs_new_airlines-connid ) ).
