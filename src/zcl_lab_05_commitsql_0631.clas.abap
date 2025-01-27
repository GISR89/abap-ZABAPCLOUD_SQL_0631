CLASS zcl_lab_05_commitsql_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_05_commitsql_0631 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA ls_products TYPE zproducts_0631.

*    ls_products = VALUE #(  product_id   = '20'
*                            product_name = 'One Plus'
*                            category_id  = '10'
*                            quantity     = '200'
*                            price        = '25.99' ).

*    INSERT zproducts_0631 FROM @ls_products.

*    IF sy-subrc EQ 0.

*      COMMIT WORK.

*      SELECT SINGLE FROM zproducts_0631
*      FIELDS *
*      WHERE product_id EQ '20'
*      INTO @ls_products.

*      IF sy-subrc EQ 0.
*        out->write( ls_products ).
*      ENDIF.

*    ENDIF.

    UPDATE zproducts_0631
    SET price = '20.99'
    WHERE product_id EQ '10'.

    IF sy-subrc EQ 0.

      SELECT SINGLE FROM zproducts_0631
      FIELDS *
      WHERE product_id EQ '10'
      INTO @ls_products.

      IF sy-subrc EQ 0.
        out->write( ls_products ).
      ENDIF.

      ROLLBACK WORK.

    ENDIF.


  ENDMETHOD.

ENDCLASS.
