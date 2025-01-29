CLASS zcl_lab_09_dinamicsql_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_09_dinamicsql_0631 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
** 1. Especificación dinámica de la fuente, columnas y filtros
*    TYPES: BEGIN OF ty_products,
*             product_name TYPE zproducts_0631-product_name,
*             price        TYPE zproducts_0631-price,
*           END OF ty_products.
*
*    DATA: lt_products         TYPE STANDARD TABLE OF ty_products,
*          lv_datasourse_name  TYPE string,
*          lv_selected_columns TYPE string,
*          lv_where_conditions type string.
*
*    DATA lx_dynamic_osql TYPE REF TO cx_root.
*
*    lv_datasourse_name = 'zproducts_0631'.
*
*    IF lv_datasourse_name EQ 'zproducts_0631'.
*       lv_selected_columns = |product_name,price|.
*       lv_where_conditions = |price ge '100'|.
*    ELSE.
*      RETURN.
*    ENDIF.
*
*    TRY.
*
*        SELECT FROM (lv_datasourse_name)
*        FIELDS (lv_selected_columns)
*        where (lv_where_conditions)
*        INTO TABLE @lt_products.
*
*      CATCH cx_sy_dynamic_osql_syntax
*            cx_sy_dynamic_osql_semantics
*            cx_sy_dynamic_osql_error INTO lx_dynamic_osql.
*        out->write( lx_dynamic_osql->get_text(  ) ).
*    ENDTRY.
*
*    IF sy-subrc EQ 0.
*      out->write( lt_products ).
*    ELSE.
*      out->write( 'No data' ).
*    ENDIF.
*
*2. Programación dinámica para ABAP SQL

    DATA lo_generic_data TYPE REF TO data.

    FIELD-SYMBOLS <lt_itab> TYPE STANDARD TABLE.

    DATA: lt_products         TYPE string,
          lv_datasourse_name  TYPE string,
          lv_selected_columns TYPE string,
          lv_where_conditions TYPE string.

    DATA lx_dynamic_osql TYPE REF TO cx_root.

    lv_datasourse_name = 'zproducts_0631'.

    IF lv_datasourse_name EQ 'zproducts_0631'.
      lv_selected_columns = |product_name,price|.
      lv_where_conditions = |price ge '100'|.
    ELSE.
      RETURN.
    ENDIF.

    TRY.

        DATA(lo_comp_table) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_name( lv_datasourse_name ) )->get_components(  ).

        DATA(lo_struct_type) = cl_abap_structdescr=>create( lo_comp_table ).

        DATA(lo_table_type) = cl_abap_tabledescr=>create( lo_struct_type ).

        CREATE DATA lo_generic_data TYPE HANDLE lo_table_type.

        ASSIGN lo_generic_data->* TO <lt_itab>.

        SELECT FROM (lv_datasourse_name)
        FIELDS * "(lv_selected_columns)
        WHERE (lv_where_conditions)
        INTO TABLE @<lt_itab>.

      CATCH cx_sy_dynamic_osql_syntax
            cx_sy_dynamic_osql_semantics
            cx_sy_dynamic_osql_error INTO lx_dynamic_osql.
        out->write( lx_dynamic_osql->get_text(  ) ).
    ENDTRY.

    IF sy-subrc EQ 0.
      out->write( <lt_itab> ).
    ELSE.
      out->write( 'No data' ).
    ENDIF.





  ENDMETHOD.

ENDCLASS.
