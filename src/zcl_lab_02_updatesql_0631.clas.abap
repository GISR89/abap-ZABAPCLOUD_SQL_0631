CLASS zcl_lab_02_updatesql_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_02_updatesql_0631 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*    DATA ls_products TYPE zproducts_0631.
*
*    SELECT SINGLE FROM zproducts_0631
*    FIELDS *
*    WHERE product_id EQ '1'
*    INTO @ls_products.
*
*    IF sy-subrc EQ 0.
*      out->write( |Quantity = { ls_products-quantity } price = { ls_products-price }| ).
*    ENDIF.
*
*    ls_products-quantity = '75'.
*    ls_products-price = '899.99'.
*
*    UPDATE zproducts_0631 FROM @ls_products.
*
*    IF sy-subrc EQ 0.
*      out->write( |Update: Quantity = { ls_products-quantity } price = { ls_products-price } | ).
*    ENDIF.

*   2. Actualizar Múltiples Registros
*
*    CONSTANTS lc_quantity TYPE i VALUE '120'.
*
*    SELECT FROM zproducts_0631
*    FIELDS *
*    WHERE category_id = '2'
*    INTO TABLE @DATA(lt_products).
*
*    IF sy-subrc EQ 0.
*
*      LOOP AT lt_products ASSIGNING FIELD-SYMBOL(<lfs_products>).
*        <lfs_products>-quantity = lc_quantity.
*      ENDLOOP.
*
*      UPDATE zproducts_0631 FROM TABLE @lt_products.
*
*      IF sy-subrc EQ 0.
*        out->write( |multiples registros se han actualizado | ).
*      ENDIF.
*
*
*    ENDIF.

* 3. Actualizar Columnas
*
*    CONSTANTS lc_price TYPE p DECIMALS 2 VALUE '50.00'.
*
*    update zproducts_0631
*    set price = @lc_price
*    where category_id eq '2'.
*
*    if sy-subrc eq 0.
*    out->write( | registros actualizados: { sy-dbcnt } | ).
*    else.
*     out->write( | no se han actualizado los registros| ).
*     endif.


* 4. Actualizar Columnas

    update zproducts_0631
            set price = price + 50
            where product_id ge '1'.



    if sy-subrc eq 0.
    out->write( | registros actualizados: { sy-dbcnt } | ).
    else.
     out->write( | no se han actualizado los registros| ).
     endif.



  ENDMETHOD.

ENDCLASS.
