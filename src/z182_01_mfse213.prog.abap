*&---------------------------------------------------------------------*
*& Report z182_01_mfse213
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z182_01_mfse213.

CLASS lcl_invoice DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_invoice,
             base_amount TYPE i,
             vat         TYPE i,
           END OF ty_invoice,
           tt_invoice TYPE TABLE OF ty_invoice.
    METHODS:
      add_item IMPORTING is_item TYPE ty_invoice,
      add_items IMPORTING it_items TYPE tt_invoice.
ENDCLASS.

CLASS lcl_invoice IMPLEMENTATION.
  METHOD add_item.

  ENDMETHOD.

  METHOD add_items.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA go_invoice_old TYPE REF TO lcl_invoice.
  CREATE OBJECT go_invoice_old.

  DATA go_invoice_new1 TYPE REF TO lcl_invoice.
  go_invoice_new1 = NEW #( ).

  DATA(go_invoice_new2) = NEW lcl_invoice( ).

  go_invoice_new1->add_item( is_item = VALUE #( base_amount = 10 vat = 2 ) ).

  go_invoice_new1->add_items( it_items = VALUE #( ( base_amount = 10 vat = 2 )
                                                  ( base_amount = 20 vat = 2 ) ) ).

  DATA gt_invoices TYPE TABLE OF lcl_invoice=>ty_invoice.

  gt_invoices = VALUE #( ( base_amount = 10 vat = 2 )
                         ( base_amount = 20 vat = 2 ) ).

  go_invoice_new1->add_items( it_items = gt_invoices ).
