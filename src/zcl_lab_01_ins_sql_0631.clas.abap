CLASS zcl_lab_01_ins_sql_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_lab_01_ins_sql_0631 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DELETE FROM zproducts_0631.

    DATA ls_products TYPE zproducts_0631.

    ls_products = VALUE #(  product_id   = '0001'
                            product_name = 'Ordenador'
                            category_id  = '0001'
                            quantity     = '0100'
                            price        = '1200.10' ).

    INSERT zproducts_0631 FROM @ls_products.

    IF sy-subrc EQ 0.
      out->write( 'Record inserted correctly' ).
    ELSE.
      out->write( 'The record was NOT inserted' ).
    ENDIF.


    DATA lt_products TYPE STANDARD TABLE OF zproducts_0631.

    lt_products = VALUE #( ( product_id   = '0002'
                             product_name = 'Teclado'
                             category_id  = '0003'
                             quantity     = '0150'
                             price        = '130.50' )

                           ( product_id   = '0003'
                             product_name = 'Mouse'
                             category_id  = '0002'
                             quantity     = '0090'
                             price        = '99.10' )

                           ( product_id   = '0004'
                             product_name = 'Auriculares'
                             category_id  = '0004'
                             quantity     = '0200'
                             price        = '110.90' )

                           ( product_id   = '0005'
                             product_name = 'Mouse inal.'
                             category_id  = '0002'
                             quantity     = '0100'
                             price        = '125.10' )

                           ( product_id   = '0006'
                             product_name = 'Teclado Inal.'
                             category_id  = '0005'
                             quantity     = '0300'
                             price        = '150.30' ) ).

    INSERT zproducts_0631 FROM TABLE @lt_products.

    IF sy-subrc EQ 0.
      out->write( 'Record inserted correctly' ).
    ELSE.
      out->write( 'The record was NOT inserted' ).
    ENDIF.


    lt_products = VALUE #( ( product_id   = '0001'
                             product_name = 'Ordenador'
                             category_id  = '1010'
                             quantity     = '0100'
                             price        = '1200.10' ) ).

    IF sy-subrc EQ 0.
      TRY.

          INSERT zproducts_0631 FROM TABLE @lt_products.

        CATCH cx_sy_open_sql_db INTO DATA(lx_sql_db).
          out->write( lx_sql_db->get_text(  ) ).
          RETURN.
      ENDTRY.

      IF sy-subrc EQ 0.
        out->write( 'Record inserted correctly' ).
      ELSE.
        out->write( 'The record was NOT inserted' ).
      ENDIF.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
