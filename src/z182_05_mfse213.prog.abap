*&---------------------------------------------------------------------*
*& Report z182_05_mfse213
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z182_05_mfse213.

PARAMETERS: pa_page TYPE i,
            pa_reg  TYPE i.

DATA gv_offset TYPE int8.

SELECT FROM sflight
       FIELDS *
       WHERE carrid EQ 'AA'
       ORDER BY carrid, connid, fldate ASCENDING
       INTO TABLE @DATA(gt_results)
       OFFSET @gv_offset
       UP TO @pa_reg ROWS.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_results ).
ENDIF.
