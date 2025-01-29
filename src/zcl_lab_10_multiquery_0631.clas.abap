CLASS zcl_lab_10_multiquery_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
   "12.FULL [OUTER] JOIN
  INTERFACES if_amdp_marker_hdb.

  types: BEGIN OF ty_structure,
           id         type c length 2,
*           id2         type c length 2,
           name       type c LENGTH 10,
*           name2       type c LENGTH 10,
           datasource1 type c LENGTH 15,
           datasource2 type c LENGTH 15,
         END OF ty_structure,
         ty_table type table of ty_structure.

    class-METHODS get_full_join AMDP OPTIONS cds session client DEPENDENT
      EXPORTING value(et_results) type ty_table.
 "12.FULL [OUTER] JOIN

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_lab_10_multiquery_0631 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
"12.FULL [OUTER] JOIN
   zcl_lab_10_multiquery_0631=>get_full_join( IMPORTING et_results = data(lt_results) ).

   out->write( lt_results ).
   "12.FULL [OUTER] JOIN

*1.  AS – Nombre alternativo
*    SELECT FROM /dmo/carrier
*    FIELDS carrier_id AS carrier,
*           name AS carrier_name
*    INTO TABLE @DATA(lt_carrier).
*
*    IF sy-subrc EQ 0.
*      out->write( lt_carrier ).
*    ENDIF.
*2. Subquery
*
*    SELECT FROM /dmo/flight
*    FIELDS plane_type_id
*    WHERE price GT ( SELECT FROM /dmo/flight
*                            FIELDS MIN( price ) )
*    INTO TABLE @DATA(lt_flights_cost).
*
*    IF sy-subrc EQ 0.
*      out->write( lines( lt_flights_cost ) ).
*      out->write( lt_flights_cost ).
*    ENDIF.
*    out->write( cl_abap_char_utilities=>newline ).
*3. Subquery ALL
*
*    SELECT FROM /dmo/flight
*           FIELDS connection_id
*           WHERE seats_occupied GT ALL ( SELECT FROM /dmo/flight
*                                                FIELDS seats_occupied
*                                                WHERE currency_code EQ 'EUR' )
*           INTO TABLE @DATA(lt_flight).
*
*    IF sy-subrc EQ 0.
*      out->write(  |Numero de registros consultados: { sy-dbcnt } | ).
*    ENDIF.

*4. Subquery ANY/SOME

*    SELECT FROM /dmo/flight
*           FIELDS connection_id
*           WHERE seats_max GT ANY ( SELECT FROM /dmo/flight
*                                            FIELDS seats_max
*                                            WHERE carrier_id EQ 'AA' )
*           INTO TABLE @DATA(lt_flight2).
*
*    IF sy-subrc EQ 0.
*      out->write( LINES( lt_flight2 )  ).
*      out->write( lt_flight2  ).
*    ENDIF.

    " 5. Subquery EXISTS
*
*    SELECT FROM /dmo/carrier AS carrier
*           FIELDS *
*           WHERE EXISTS ( SELECT FROM /dmo/flight
*               FIELDS *
*               WHERE carrier_id EQ carrier~carrier_id )
*           INTO TABLE @DATA(lt_carrier).
*
*    IF sy-subrc EQ 0.
*      out->write( lt_carrier ).
*    ELSE.
*      out->write( 'No data' ).
*    ENDIF.
    " 6. Subquery IN

*      SELECT FROM /dmo/flight as flight
*             fields connection_id
*             where carrier_id in ( select from /dmo/flight
*                                          fields carrier_id
*                                          where carrier_id eq 'AA'
*                                          or    carrier_id eq 'DL' )
*             INTo table @data(lt_flights).
*
*    IF sy-subrc EQ 0.
*      out->write( lt_flights ).
*    ELSE.
*      out->write( 'No data' ).
*    ENDIF.

    " 7. INNER JOIN
*
*    SELECT FROM /dmo/flight AS flight
*           INNER JOIN /dmo/carrier AS carrier ON flight~carrier_id EQ carrier~carrier_id
*           FIELDS flight~connection_id,
*                  flight~flight_date,
*                  carrier~name
*           INTO TABLE @DATA(lt_flights).
*
*    IF sy-subrc EQ 0.
*      out->write( lt_flights ).
*    ENDIF.

    "  8. LEFT [OUTER] JOIN

*    SELECT FROM /dmo/flight AS flight
*           LEFT JOIN /dmo/carrier AS carrier ON flight~carrier_id EQ carrier~carrier_id
*           FIELDS flight~connection_id,
*                  flight~flight_date,
*                  carrier~name
*           INTO TABLE @DATA(lt_flights).
*
*    IF sy-subrc EQ 0.
*      out->write( lt_flights ).
*    ENDIF.

*    " 9. RIGHT [OUTER] JOIN
*    SELECT FROM /dmo/flight AS flight
*           RIGHT JOIN /dmo/carrier AS carrier ON flight~carrier_id EQ carrier~carrier_id
*           FIELDS flight~connection_id,
*                  flight~flight_date,
*                  carrier~name
*           INTO TABLE @DATA(lt_flights).
*
*    IF sy-subrc EQ 0.
*      out->write( lt_flights ).
*    ENDIF.

    " 10.LEFT | RIGHT EXCLUDING INNER JOIN
    " vuelos que no tienen aeropuerto asociado en la tabla/dmo/carrier
*     SELECT FROM /dmo/flight AS flight
*            fields flight~connection_id,
*                   flight~flight_date
*            where flight~carrier_id not in ( SELECT FROM /dmo/carrier as carrier
*                                             fields carrier~carrier_id
*                                             where carrier~carrier_id = flight~carrier_id )
*           INTO TABLE @DATA(lt_flights).
*
*    IF sy-subrc EQ 0.
*      out->write( lt_flights ).
*    ENDIF.

    " aeropuertos que no tienen vuelos asociados a la tabla /dmo/flight
*     SELECT FROM /dmo/carrier AS carrier
*            fields carrier~name
*            where carrier~carrier_id
*             not in ( SELECT FROM /dmo/flight as flight
*                                             fields flight~carrier_id
*                                             where flight~carrier_id = carrier~carrier_id )
*           INTO TABLE @DATA(lt_flights).
*
*    IF sy-subrc EQ 0.
*      out->write( lt_flights ).
*    ENDIF.

    " 11. CROSS JOIN

*    SELECT FROM /dmo/flight AS flight
*           CROSS JOIN /dmo/carrier AS carrier
*           FIELDS flight~connection_id,
*                  flight~flight_date,
*                  carrier~name
*           INTO TABLE @DATA(lt_flight).
*
*    IF sy-subrc EQ 0.
*      out->write( lines( lt_flight ) ).
*      out->write( lt_flight ).
*    ENDIF.


 "12.FULL [OUTER] JOIN
  ENDMETHOD.

  METHOD get_full_join BY DATABASE PROCEDURE FOR HDB
                       LANGUAGE SQLSCRIPT
                       OPTIONS READ-ONLY
                       USING z_i_datasource1_lgl
                             z_i_datasource2_lgl.

        et_results = select coalesce(ds1.id, ds2.id ) as id,
*                            ds2.id as id2,
                             coalesce(ds1.name1, ds2.name2 ) as name,
*                            ds1.name1,
*                            ds2.name2,
                            ds1.datasource1,
                            ds2.datasource2
                     from z_i_datasource1_lgl as ds1
                     full JOIN z_i_datasource2_lgl as ds2 on ds1.id = ds2.id;

  ENDMETHOD.

ENDCLASS.
