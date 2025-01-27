CLASS zcl_lab_07_filtersql_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_07_filtersql_0631 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*1. Operadores relacionales binarios
*    SELECT FROM zproducts_0631
*    FIELDS product_name, price
*    WHERE price GE '100'
*    INTO TABLE @DATA(lt_products).
*
*    IF sy-subrc EQ 0.
*
*      out->write( lt_products ).
*    ENDIF.

*2. BETWEEN
*
*    SELECT FROM zproducts_0631
*    FIELDS product_name, price
*    WHERE price between '100' and '1000'
*    INTO TABLE @DATA(lt_products).
*
*    IF sy-subrc EQ 0.
*
*      out->write( lt_products ).
*    ENDIF.

*3. Caracteres comodines con LIKE

*    SELECT FROM zproducts_0631
*    FIELDS product_name
*    WHERE price between '100' and '1000'
*    INTO TABLE @DATA(lt_products).
*
*    IF sy-subrc EQ 0.
*
*      out->write( lt_products ).
*    ENDIF.


*3. Caracteres comodines con LIKE
*
*    DATA lv_search_criteria TYPE string VALUE '%s%'.
*
*    SELECT FROM zproducts_0631
*    FIELDS product_name
*    WHERE product_name LIKE @lv_search_criteria
*    INTO TABLE @DATA(lt_products).
*
*    IF sy-subrc EQ 0.
*
*      out->write( lt_products ).
*    ENDIF.

*4. Caracteres de escape

*DATA(ls_products) = VALUE zproducts_0631( product_id   = '5'
*                                          product_name = 'Mouse_inal.'
*                                          category_id  = '2'
*                                          quantity     = '100'
*                                          price        = '125.10' ).
*
* MODIFY zproducts_0631 FROM @ls_products.
*
*    CONSTANTS cv_escape TYPE c LENGTH 1 VALUE '#'.
*
*    SELECT FROM zproducts_0631
*    FIELDS product_name
*    WHERE product_name LIKE '%#_%' ESCAPE @cv_escape
*    INTO TABLE @DATA(lt_products).
*
*    IF sy-subrc EQ 0.
*
*      out->write( lt_products ).
*    ENDIF.

* 5. IN

*SELECT FROM zproducts_0631
*    FIELDS product_name, category_id
*    WHERE category_id in ( '1', '2', '4'  )
*    INTO TABLE @DATA(lt_products).
*
*    IF sy-subrc EQ 0.
*      out->write( lt_products ).
*    ENDIF.

*6. IN con tabla de rangos

*    DATA lr_price TYPE RANGE OF zproducts_0631-category_id.
*
*    lr_price = VALUE #(  (  sign = 'I'
*                            option = 'BT'
*                            low = 1
*                            high = 3 ) ).
*
*    SELECT FROM zproducts_0631
*        FIELDS product_name, category_id
*        WHERE category_id IN @lr_price
*        INTO TABLE @DATA(lt_products).
*
*    IF sy-subrc EQ 0.
*      out->write( lt_products ).
*    ENDIF.

*7. NULL
*
*    SELECT FROM zproducts_0631
*       FIELDS product_name
*       WHERE product_name IS NOT NULL
*       INTO TABLE @DATA(lt_products).
*
*    IF sy-subrc EQ 0.
*      out->write( lt_products ).
*    ENDIF.

* 8. AND/OR/NOT

    SELECT FROM zproducts_0631
        FIELDS product_name, category_id, price
        WHERE ( category_id EQ '2'
               OR category_id EQ '10' )

        AND price GE '100'
       INTO TABLE @DATA(lt_products).

    IF sy-subrc EQ 0.
      out->write( lt_products ).
    ENDIF.



  ENDMETHOD.

ENDCLASS.
