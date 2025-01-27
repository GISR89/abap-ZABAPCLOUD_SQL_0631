CLASS zcl_lab_08_sqlexpressions_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_08_sqlexpressions_0631 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*1. MIN/MAX

    SELECT FROM zproducts_0631
         FIELDS MIN( price ) AS MinPrice,
                MAX( price ) AS MaxPrice
         INTO @DATA(ls_min_max_price).

    IF sy-subrc EQ 0.

      out->write( ls_min_max_price ).
    ENDIF.

*2. AVG/SUM

    SELECT FROM zproducts_0631
         FIELDS AVG( price ) AS avgPrice,
                SUM( price ) AS sumPrice
         INTO ( @DATA(lv_avg_price), @DATA(lv_sum_price) ).

    IF sy-subrc EQ 0.

      out->write( |avg price: { lv_avg_price }; sum price: { lv_sum_price }| ).
    ENDIF.

*3. DISTINCT

    SELECT FROM zproducts_0631
         FIELDS AVG( DISTINCT price ) AS avgPrice,
                SUM( DISTINCT price ) AS sumPrice
         INTO ( @lv_avg_price, @lv_sum_price ).

    IF sy-subrc EQ 0.

      out->write( |DISTINCT avg price : { lv_avg_price }; DISTINCT sum price: { lv_sum_price }| ).
    ENDIF.

*4. COUNT

    SELECT FROM zproducts_0631
           FIELDS COUNT( * ) AS countAll
           INTO @DATA(lv_countAll).

    IF sy-subrc EQ 0.

      out->write( |CountAll: { lv_countAll }| ).
    ENDIF.

* 5. GROUP BY y HAVING

    SELECT FROM zproducts_0631
         FIELDS category_id,
             CAST( AVG( price ) AS DEC( 10,2 ) ) AS avgPrice
         GROUP BY category_id
         HAVING AVG( price ) ge 120
         INTO TABLE @DATA(lt_products).

    IF sy-subrc EQ 0.

      out->write( lt_products ).
    ENDIF.

*6. ORDER BY y OFFSET

    SELECT FROM zproducts_0631
    fields *
    order by price DESCENDING
    into table @DATA(lt_products2)
    offset 2.

    IF sy-subrc EQ 0.

      out->write( lt_products2 ).
    ENDIF.


  ENDMETHOD.

ENDCLASS.
