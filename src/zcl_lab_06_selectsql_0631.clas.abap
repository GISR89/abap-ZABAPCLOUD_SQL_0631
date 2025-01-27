CLASS zcl_lab_06_selectsql_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_lab_06_selectsql_0631 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*1. Select Single

*    SELECT SINGLE FROM zproducts_0631
*    FIELDS *
*    INTO @DATA(ls_products)
*    BYPASSING BUFFER.
*
*    IF sy-subrc EQ 0.
*      out->write( |Nombre del producto: { ls_products-product_name }| ).
*    ENDIF.

*    SELECT FROM zproducts_0631
*    FIELDS *
*    WHERE category_id EQ '2'
*    INTO TABLE @DATA(lt_products).
*
*    IF sy-subrc EQ 0.
*      out->write( |cantidad de registros recuperados: { sy-dbcnt }| ).
*    ENDIF.

*    TYPES : BEGIN OF ty_products,
*              product_id   TYPE i,
*              product_name TYPE string,
*              category_id  TYPE i,
*            END OF ty_products.
*
*    DATA lt_products TYPE STANDARD TABLE OF ty_products.
*
*    SELECT FROM zproducts_0631
*    FIELDS *
*    WHERE category_id EQ '2'
*    INTO CORRESPONDING FIELDS OF TABLE @lt_products.
*
*    IF sy-subrc EQ 0.
*
*     out->write( |cantidad de registros recuperados: { sy-dbcnt }| ).
*      out->write( lt_products ).
*    ENDIF.

*    SELECT FROM zproducts_0631
*    FIELDS *
*   WHERE category_id EQ '2'
*    INTO TABLE @DATA(lt_products)
*    UP TO 3 ROWS.
*
*    IF sy-subrc EQ 0.
*      out->write( |cantidad de registros recuperados: { sy-dbcnt }| ).
*      out->write( lt_products ).
*    ENDIF.

*    TYPES : BEGIN OF ty_products,
*              product_name TYPE string,
*              price        TYPE p LENGTH 10 DECIMALS 2,
*            END OF ty_products.

*    DATA lt_products TYPE TABLE OF ty_products.
*    DATA ls_products TYPE ty_products.

*    SELECT FROM zproducts_0631
*    FIELDS product_name, price
*    WHERE price GE '100'
*    INTO  @ls_products.


*   APPEND ls_products TO lt_products.

*    ENDSELECT.

*    IF sy-subrc EQ 0.
*      out->write( lt_products ).
*    ENDIF.

    SELECT FROM zproducts_0631
    FIELDS product_name, price
    WHERE price GE '100'
    INTO TABLE @DATA(lt_products)
    PACKAGE SIZE 2.

      LOOP AT lt_products ASSIGNING FIELD-SYMBOL(<lfs_product>).
        out->write( |{ <lfs_product>-product_name } { <lfs_product>-price }| ).
      ENDLOOP.
      out->write( cl_abap_char_utilities=>newline ).

    ENDSELECT.

  ENDMETHOD.

ENDCLASS.
