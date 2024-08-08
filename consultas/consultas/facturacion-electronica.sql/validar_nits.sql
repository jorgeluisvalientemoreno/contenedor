with insumos as (select subs.subscriber_id,
                        subs.identification identification_original,
                        REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(subs.identification, '0 '), ' ', ''), '-', ''), ',', ''), '.', '') identification,
                        length(REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(subs.identification, '0 '), ' ', ''), '-', ''), ',', ''), '.', '')) as longitud,
                        subs.subscriber_name,
                        subs.e_mail,
                        (select count(1) from open.suscripc sc where sc.suscclie = subs.subscriber_id) num_contratos
                 from open.ge_subscriber subs
                 where subs.ident_type_id = 110
                   and (select count(1) from open.suscripc sc where sc.suscclie = subs.subscriber_id) > 0),
    hoja1_long_invalida as (
        select * from insumos where longitud <= 8 or longitud > 10
    ),
    longitud_valida as (
        select * from insumos where longitud in (9, 10)
    ),
    validos_con_dv_sinmod as (
        select lv.*,
            MOD(CAST(SUBSTR(identification, 1, 1) AS NUMBER) * 41 +
            CAST(SUBSTR(identification, 2, 1) AS NUMBER) * 37 +
            CAST(SUBSTR(identification, 3, 1) AS NUMBER) * 29 +
            CAST(SUBSTR(identification, 4, 1) AS NUMBER) * 23 +
            CAST(SUBSTR(identification, 5, 1) AS NUMBER) * 19 +
            CAST(SUBSTR(identification, 6, 1) AS NUMBER) * 17 +
            CAST(SUBSTR(identification, 7, 1) AS NUMBER) * 13 +
            CAST(SUBSTR(identification, 8, 1) AS NUMBER) * 7 +
            CAST(SUBSTR(identification, 9, 1) AS NUMBER) * 3, 11) mod_dv
        from longitud_valida lv
    ),
    validos_con_dv as (
        select d.subscriber_id
             , d.identification_original
             , d.identification
             , d.longitud
             , d.subscriber_name
             , d.e_mail
             , d.num_contratos
             , case when mod_dv in (0, 1) then mod_dv else 11 - mod_dv end dv
        from validos_con_dv_sinmod d
    ),
    parseados as (select dv.*
                       , SUBSTR(identification, 1, 9) || dv        calculado
                       , SUBSTR(identification, 1, 9) || '-' || dv calculado_con_formato
                       , CASE
                             WHEN SUBSTR(identification, 1, 9) || dv = identification_original THEN 'Cuadran los NIT'
                             ELSE 'No cuadran los NIT' end
                  from validos_con_dv dv)
select * from parseados