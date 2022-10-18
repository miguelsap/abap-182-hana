*&---------------------------------------------------------------------*
*& Report z182_03_mfse213
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z182_03_mfse213.

TYPES: BEGIN OF ty_structure,
         col1 TYPE i,
         col2 TYPE i,
         col3 TYPE i,
       END OF ty_structure,
       tt_table TYPE STANDARD TABLE OF ty_structure WITH EMPTY KEY.

DATA: gt_table TYPE tt_table,
      gv_index TYPE i.

FIELD-SYMBOLS <gs_tab> TYPE ty_structure.
gv_index = 1.

DO.
  gv_index += 10.
  IF gv_index > 40.
    EXIT.
  ENDIF.
  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_tab>.
  <gs_tab>-col1 = gv_index.
  <gs_tab>-col2 = gv_index + 1.
  <gs_tab>-col3 = gv_index + 2.
ENDDO.

DATA(gt_itab_new) = VALUE tt_table( FOR i = 11 THEN i + 10 UNTIL i > 40
                                    ( col1 = i
                                      col2 = i + 1
                                      col3 = i + 2 ) ).

WRITE:/ 'OLD'.
LOOP AT gt_table ASSIGNING <gs_tab>.
  WRITE:/ <gs_tab>-col1, <gs_tab>-col2, <gs_tab>-col3.
ENDLOOP.

WRITE:/ 'NEW'.
LOOP AT gt_itab_new ASSIGNING <gs_tab>.
  WRITE:/ <gs_tab>-col1, <gs_tab>-col2, <gs_tab>-col3.
ENDLOOP.
