CLASS zcl_lab_03_modifysql_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_lab_03_modifysql_0631 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*    DATA(ls_products) = VALUE zproducts_0631( product_id   = '1'
*                                              product_name = 'Ordenador'
*                                              category_id  = '1'
*                                              quantity     = '60'
*                                              price        = '850.99' ).
*
*    MODIFY zproducts_0631 FROM @ls_products.
*
*    IF sy-subrc EQ 0.
*      out->write( 'El registro se ha modificado' ).
*    ELSE.
*      out->write( 'El registro NO se ha modificado' ).
*    ENDIF.

    CONSTANTS lc_quantity TYPE i VALUE '90'.

    SELECT FROM zproducts_0631
    FIELDS *
    WHERE product_id EQ '1'
    INTO TABLE @DATA(lt_products).

    IF sy-subrc EQ 0.

      LOOP AT lt_products ASSIGNING FIELD-SYMBOL(<fs_prodructs>).
        <fs_prodructs>-quantity = lc_quantity.
      ENDLOOP.

      APPEND VALUE #( product_id   = '10'
                      product_name = 'MSI'
                      category_id  = '1'
                      quantity     = '90'
                      price        = '850.99' ) TO lt_products.

      MODIFY zproducts_0631 FROM TABLE @lt_products.

      IF sy-subrc EQ 0.
        out->write( |Registros Modificados: { sy-dbcnt }| ).
      ELSE.
        out->write( 'Los registros NO se han modificado' ).
      ENDIF.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
