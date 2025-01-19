CLASS zcl_lab_04_deletesql_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_04_deletesql_0631 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*    SELECT SINGLE FROM zproducts_0631
*    FIELDS *
*    WHERE product_id EQ '1'
*    INTO @DATA(ls_products).
*
*    IF sy-subrc EQ 0.
*
*      DELETE zproducts_0631 FROM @ls_products.
*
*      IF sy-subrc EQ 0.
*      ENDIF.
*
*    ENDIF.

*    SELECT FROM zproducts_0631
*    FIELDS *
*    WHERE product_id EQ '2'
*     OR product_id EQ '3'
*    INTO TABLE @DATA(lt_products).
*
*    IF sy-subrc EQ 0.

*      DELETE zproducts_0631 FROM TABLE @lt_products.

*      IF sy-subrc EQ 0.
*        out->write( |Registros eliminados: { sy-dbcnt }| ).
*      ENDIF.

*    ENDIF.

    DELETE FROM zproducts_0631
    WHERE quantity GT '100'.

    IF sy-subrc EQ 0.
      out->write( |Registros eliminados: { sy-dbcnt }| ).
    ENDIF.




  ENDMETHOD.

ENDCLASS.












