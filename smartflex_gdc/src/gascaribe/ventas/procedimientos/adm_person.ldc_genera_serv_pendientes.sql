CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_GENERA_SERV_PENDIENTES (
    /**************************************************************************
      Autor       : HORBART TECHNOLOGIES
      Fecha       : 2019-01-14
      Descripcion : Generacion de los servicios pendientes

      Parametros Entrada
        nuano A?o
        numes Mes

      Valor de salida
        sbmen  mensaje
        error  codigo del error

     HISTORIA DE MODIFICACIONES
       FECHA        AUTOR   DESCRIPCION
     06-05-2021    EDMLAR   CA-744 Se adapta el proceso de servicios cumplidos para descontarlo por orden legalizada,
                            Se ajustan las notas del mes para Constructoras y para Migrados.
     25/01/2022    EDMLAR   CA-954 Se corrige el proceso de servicios cumplidos para que solo contemple la causal 9944
                            para reportar el ingreso en la certificacion previa
     22/10/2023    EDMLAR   OSF-1779 Se cambia la logica de generar los servicios pendientes, se reportara por solicitud,
                            ya no se hara por producto.
    ***************************************************************************/
    nupano    IN     NUMBER,
    nupmes    IN     NUMBER,
    sbmensa      OUT VARCHAR2,
    error        OUT NUMBER)
IS
    --
    -- VENTAS DEL MES
    CURSOR cu_ventas_mes (dtcurfein DATE, dtcurfefi DATE)
    IS
      SELECT 'VENTAS_MES' SALDO,
             TIPO,
             CEBE,
             DEPA,
             LOCA,
             CONSTRUCTORA NUSE,
             concclco,
             CONSTRUCTORA,
             SOLICITUD,
             TIPO_SOLICITUD,
             NULL FEC_VENTA,
             VR_INGRESO,
             NULL EST_TECNICO,
             VENTAS,
             CATE,
             CASE WHEN concclco = 4 THEN VR_INGRESO ELSE 0 END      CXC, -- CARGO POR CONEXION
             CASE WHEN concclco = 19 THEN VR_INGRESO ELSE 0 END     INTERNA, -- INTERNA
             CASE WHEN concclco = 400 THEN VR_INGRESO ELSE 0 END    CERTIFICACION -- CERTIFICACION
        FROM 
      ( 
       -- 
         select  'VENTAS' TIPO,
                 cebe,
                 (select g.geo_loca_father_id from  ge_geogra_location g
                   where g.geograp_location_id = loca) DEPA,
                 loca,
                 categoria CATE,
                 cargconc CONCEPTO, concclco,
                 cargvalo VR_INGRESO, TO_NUMBER(SOLICITUD) SOLICITUD,
                 TIPO_SOLICITUD, 
                 ventas, constructora
                 --
         from
             (
              select cargconc, concclco, cargcaca, cargvalo, ventas, 
                     SOLICITUD,
                     (select l.celocebe
                        from  ldci_centbenelocal l
                       where l.celoloca = loca) CEBE,
                     LOCA,
                     categoria, mo.package_type_id TIPO_SOLICITUD, constructora
                from
                     (
                      select cargnuse, cargconc, concclco, cargcaca, sum(cargvalo) cargvalo,
                             to_number(replace(replace(trim(cargdoso),'PP-',''),'-ADD','')) SOLICITUD,
                             sum(cargunid) VENTAS,  -- NUMERO DE APTOS
                             cargnuse constructora,
                             sesucate categoria,
                             (select GEOGRAP_LOCATION_ID from  AB_ADDRESS where address_id = susciddi) LOCA
                        from  cargos,  servsusc,  CUENCOBR,  FACTURA,  concepto o,  suscripc
                       where factfege >= dtcurfein -- '01-08-2023'
                         AND factfege <= dtcurfefi -- '31-08-2023 23:59:59'
                         AND cucofact =  factcodi
                         AND cucocodi =  cargcuco
                         AND sesunuse =  cargnuse
                         And sesuserv =  6121
                         AND cargfecr <= dtcurfefi -- '31-08-2023 23:59:59'
                         AND cargcuco >  0
                         AND cargtipr =  'A'
                         AND cargsign in ('DB','CR')
                         and cargcaca in (41,53)
                         and cargconc =  conccodi
                         and concclco in (4,19,400)
                         and sesususc = susccodi
                         and substr(cargdoso,1,3) = 'PP-' 
                      group by cargnuse, cargconc, concclco, cargcaca, sesucate, to_number(replace(replace(trim(cargdoso),'PP-',''),'-ADD','')), susciddi
                     ),  mo_packages mo
               where mo.package_id  =  solicitud 
                 AND (
                      mo.motive_status_id not in (5,26,32,40,45)
                     OR
                      (mo.motive_status_id in (5,26,32,40,45) AND
                        (select nvl(annul_date, '31-12-3000')
                           from  mo_motive mt
                          where mt.package_id  = mo.package_id
                            and mt.product_type_id = 6121) > dtcurfefi -- '31-08-2023 23:59:59' -- fecha final del mes de proceso
                      )
                     )
             ) xx
      group by cebe, loca, cargconc, cargvalo, ventas, categoria, SOLICITUD, TIPO_SOLICITUD,  concclco, CONSTRUCTORA
      );

    -- NOTAS DE CONSTRUCTORAS QUE YA TIENEN PRODUCTO MES ACTUAL
    CURSOR cu_notas_vtas_mes (dtcurfein DATE, dtcurfefi DATE)
    IS
          --<< CA-744
          --
          SELECT 'NOTA_MES'                                            TIPO,
                 cargnuse                                              construct,
                 (SELECT ge.geo_loca_father_id
                    FROM  ge_geogra_location ge
                   WHERE ge.geograp_location_id IN
                             (SELECT GEOGRAP_LOCATION_ID
                                FROM  AB_ADDRESS
                               WHERE address_id = susciddi))           DEPA,
                 (SELECT GEOGRAP_LOCATION_ID
                    FROM  AB_ADDRESS
                   WHERE address_id = susciddi)                        LOCA,
                 --<<
                 concclco,
                 -->>
                 SUM (DECODE (cargsign, 'DB', cargvalo, -cargvalo))    Total
            FROM  cargos,
                  servsusc c,
                  suscripc p,
                  concepto o
           WHERE     cargnuse = sesunuse
                 AND SESUSERV = 6121
                 AND cargfecr >= dtcurfein                      --'01-01-2020'
                 AND cargfecr < dtcurfefi                       --'31-01-2020'
                 AND cargtipr = 'P'
                 AND c.sesususc = p.susccodi
                 AND cargsign IN ('DB', 'CR')
                 AND cargconc = conccodi
                 AND concclco IN (4, 19, 400)
                 AND cargcaca NOT IN (2,
                                      20,
                                      23,
                                      45,
                                      46,
                                      50,
                                      51,
                                      56,
                                      73,
                                      84)
        GROUP BY cargnuse, susciddi,                              /*cargconc*/
                                     concclco
        --
        UNION ALL
          --
          SELECT 'FRAS_MES'                                            TIPO,
                 cargnuse                                              construct,
                 (SELECT ge.geo_loca_father_id
                    FROM  ge_geogra_location ge
                   WHERE ge.geograp_location_id IN
                             (SELECT GEOGRAP_LOCATION_ID
                                FROM  AB_ADDRESS
                               WHERE address_id = susciddi))           DEPA,
                 (SELECT GEOGRAP_LOCATION_ID
                    FROM  AB_ADDRESS
                   WHERE address_id = susciddi)                        LOCA,
                 --<<
                 concclco,
                 -->>
                 SUM (DECODE (cargsign, 'DB', cargvalo, -cargvalo))    Total
            FROM  cargos  cc,
                  cuencobr,
                  factura,
                  concepto co,
                  servsusc ss,
                  suscripc su
           WHERE     cucocodi = cargcuco
                 AND cargnuse = sesunuse
                 AND sesususc = susccodi
                 AND sesuserv = 6121
                 AND factfege >= dtcurfein                      --'01-01-2020'
                 AND factfege <= dtcurfefi                      --'31-01-2020'
                 AND cucofact = factcodi
                 AND cargfecr <= dtcurfefi                      --'31-01-2020'
                 AND cargcuco > 0
                 AND cargtipr = 'A'
                 AND cargsign IN ('DB', 'CR')
                 AND cargconc = conccodi
                 AND concclco IN (4, 19, 400)
                 AND cargcaca = 15                              -- Facturacion
        GROUP BY cargnuse, concclco, susciddi;

    --
    -- SERVICIOS CUMPLIDOS MES ACTUAL
    --
    CURSOR CU_CUM_OSF_MES (dtcurfein DATE, dtcurfefi DATE)
    IS
        --
        -- Constructoras
  with base as
        (select /*+index(ca IX_CARG_NUSE_CUCO_CONC) */
                cargcuco, cargdoso, cargconc, concdesc, cargcaca, cargsign, concclco, sum(cargvalo) cargvalo, sum(cargunid) cargunid
           from  cargos ca,  concepto o,  servsusc
          where cargnuse =  sesunuse
            and cargcuco != -1
            and cargconc = conccodi
            and sesuserv =  6121
            and cargdoso like 'PP-%' -- || a.package_id
            and cargcaca in (53)
            and concclco in (4,19,400)
            and cargfecr <  dtcurfefi
         group by cargcuco, cargdoso, cargconc, concdesc, cargcaca, cargsign, concclco
         ), 
         cargo as (
         select cargdoso, to_number(replace(replace(trim(cargdoso),'PP-',''),'-ADD','')) package_id,   cargconc, concdesc, cargcaca, cargsign, concclco, sum(cargvalo) cargvalo, sum(cargunid) cargunid
          from base      
          inner join  cuencobr c on c.cucocodi=base.cargcuco
          inner join  factura f on f.factcodi=c.cucofact and f.factfege <= dtcurfefi
          group by cargdoso, cargconc, concdesc, cargcaca, cargsign, concclco
         ),
         base2 as (
         select A.PRODUCT_ID, sesucate, cargconc, concclco clasificador, ca.package_id, o2.order_id orden, o2.task_type_id TITR,
                o2.causal_id,
                ab.geograp_location_id  LOCA,
                (SELECT db.celodpto
                   FROM  ldci_centbenelocal db
                  WHERE db.celoloca = ab.geograp_location_id) DPTO,                
                (SELECT lo.celocebe
                   FROM  ldci_centbenelocal lo
                  WHERE lo.celoloca = ab.geograp_location_id) CEBE,
                (select tt.clctclco from  ic_clascott tt where tt.clcttitr = o2.task_type_id) clasitt,
                CASE WHEN
                 concclco IN (4) THEN
                    ((ca.cargvalo/ca.cargunid)) * -1
                 ELSE
                   0
                END ING_CXC,
                CASE WHEN
                 concclco IN (19) THEN
                    ((ca.cargvalo/ca.cargunid)) * -1
                 ELSE
                   0
                END ING_INT,
                CASE WHEN
                 concclco IN (400) THEN
                    ((ca.cargvalo/ca.cargunid)) * -1
                 ELSE
                   0
                END ING_CER,
                0 ING_CXC_M,
                0 ING_INT_M,
                0 ING_CER_M,
                ((ca.cargvalo/ca.cargunid) * -1) TOT_INGRE
         from cargo ca
         inner join  mo_packages m ON m.package_id = ca.package_id and m.package_type_id = 323
         inner join  or_order_activity a ON a.package_id = m.package_id
         inner join  or_order o2 on o2.order_id=a.order_id and o2.order_status_id = 8 and trunc(o2.legalization_date) >= dtcurfein 
                                       and trunc(o2.legalization_date) <= dtcurfefi 
         inner join  ge_causal c ON c.causal_id = o2.causal_id and c.class_causal_id = 1
         inner join  or_task_type tt ON tt.task_type_id = o2.task_type_id
         inner join  servsusc sc ON sc.sesunuse = a.product_id
         inner join  suscripc su ON su.susccodi = sc.sesususc
         inner join  ab_address ab ON ab.address_id = su.susciddi
         where o2.order_id not in (select oo.related_order_id
                                     from  OR_related_order oo
                                    where oo.related_order_id = o2.order_id
                                      and oo.rela_order_type_id in (13,14)
                                  )
           AND a.product_id NOT IN (SELECT hcecnuse
                                      FROM  hicaesco h
                                     WHERE hcecfech < to_date((SELECT casevalo
                                                                 FROM  LDCI_CARASEWE C
                                                                WHERE C.CASECODI = 'FECHA_INICIO_INGRESO_X_ORDEN'))
                                       AND hcecnuse = a.product_id
                                       AND hcececan = 96
                                       AND hcececac = 1
                                       AND hcecserv = 7014)
           AND o2.task_type_id IN ( SELECT  regexp_substr(casevalo,
                                                          '[^,]+',
                                                          1,
                                                          LEVEL) AS titr
                                      from (select casevalo
                                      FROM  LDCI_CARASEWE C
                                      WHERE C.CASECODI IN ( 'TIPOS_DE_TRABAJOS_INTERNA','TIPOS_DE_TRABAJOS_C_X_C','TIPO_DE_TRABAJO_CERTIF_PREVIA'))
                                      CONNECT BY regexp_substr(casevalo, '[^,]+', 1, LEVEL) IS NOT NULL
                                  )                                       

    )        
        SELECT 'SERV_CUMPLIDO'     SALDO,
               'Ing_Osf'           Tipo,
               LOCA,
               base2.package_id    solicitud,
               dpto,
               NULL PRODUCT_ID, 
               sesucate,
               clasificador,
               CEBE,
               NULL orden,
               SUM(ING_CXC) CXC,     --ING_CXC,
               SUM(ING_INT) INTERNA, -- ING_INT,
               SUM(ING_CER) CERTIFICACION -- ING_CER
          FROM Base2
     WHERE   (
                  (base2.TITR IN (SELECT (COLUMN_VALUE)
                                         FROM TABLE ( LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo FROM  LDCI_CARASEWE C
                                                                                         WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_INTERNA'),',') )) and
                   clasificador in (19) and -- Interna
                   base2.product_id not in (select act.product_id
                                           from  or_order_activity act,  or_order oo
                                          where act.product_id = base2.product_id
                                            and oo.task_type_id in (SELECT (COLUMN_VALUE)
                                                                     FROM TABLE ( LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                                                     FROM  LDCI_CARASEWE C
                                                                                                                    WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_OT_APOYO'),',') ))
                                            and act.order_id = oo.order_id
                                            and oo.legalization_date < to_date((SELECT casevalo
                                                                                  FROM  LDCI_CARASEWE C
                                                                                 WHERE C.CASECODI = 'FECHA_FIN_ORDEN_DE_APOYO'),'DD/MM/YYYY')
                                        )
                  )

              OR
                (
                 base2.TITR IN (SELECT (COLUMN_VALUE)
                                       FROM TABLE ( LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                        FROM  LDCI_CARASEWE C
                                                                                       WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_C_X_C'),',') )) and
                 clasificador = 4 -- cxc
                )
              OR
                (
                 base2.TITR IN (SELECT (COLUMN_VALUE)
                                       FROM TABLE ( LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                        FROM  LDCI_CARASEWE C
                                                                                       WHERE C.CASECODI = 'TIPO_DE_TRABAJO_CERTIF_PREVIA'),',')) ) and
                 clasificador = 400 AND -- Cert Previa
                 base2.causal_id = 9944 
                )

              )
              GROUP BY sesucate, cargconc, clasificador, TITR, CLASITT, loca, dpto, cebe, package_id
        --
        UNION ALL
        --
        -- Consulta Servicio Cumplido Migrado
        SELECT 'SERV_CUMPLIDO'                                      SALDO,
               'Ing_Mig'                                            Tipo,
               ab.geograp_location_id                               LOCA,
               a.package_id                                         solicitud,
               (SELECT db.celodpto
                  FROM  ldci_centbenelocal db
                 WHERE db.celoloca = ab.geograp_location_id)        dpto,
               A.PRODUCT_ID,
               sesucate,
               --<<
               concclco,                              -- Clasificador contable
               -->>
                (SELECT lo.celocebe
                   FROM  ldci_centbenelocal lo
                  WHERE lo.celoloca = ab.geograp_location_id)       CEBE,
               o2.order_id                                          Orden,
               CASE WHEN concclco = 4 THEN -invmvain ELSE 0 END     CXC, -- CARGO POR CONEXION
               CASE WHEN concclco = 19 THEN -invmvain ELSE 0 END    INTERNA, -- INTERNA
               CASE WHEN concclco = 400 THEN -invmvain ELSE 0 END   CERTIFICACION
          FROM  or_order  o2
               INNER JOIN  ge_causal c
                   ON c.causal_id = o2.causal_id AND c.class_causal_id = 1
               INNER JOIN  or_order_activity a
                   ON a.order_id = o2.order_id
               INNER JOIN  mo_packages m
                   ON     m.package_id = a.package_id
                      AND m.package_type_id = 100271                    -- 323
               INNER JOIN  Ldci_Ingrevemi mi
                   ON mi.invmsesu = a.product_id
               INNER JOIN  concepto o ON conccodi = mi.invmconc
               INNER JOIN  servsusc sc ON sc.sesunuse = a.product_id
               INNER JOIN  suscripc su ON su.susccodi = sc.sesususc
               INNER JOIN  ab_address ab ON ab.address_id = su.susciddi
         WHERE     TRUNC (o2.legalization_date) >= dtcurfein   -- '01-12-2020'
               AND TRUNC (o2.legalization_date) < dtcurfefi     --'01-01-2021'
               AND o2.order_status_id = 8
               AND (   (    o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                                  FROM TABLE ( LDC_BOUTILITIES.SPLITSTRINGS (
                                                                  (SELECT casevalo
                                                                     FROM  LDCI_CARASEWE
                                                                          C
                                                                    WHERE C.CASECODI =
                                                                          'TIPOS_DE_TRABAJOS_INTERNA'),
                                                                  ',')))
                        AND concclco IN (19)
                        AND                                         -- Interna
                            a.product_id NOT IN
                                (SELECT act.product_id
                                   FROM  or_order_activity  act,
                                         or_order           oo
                                  WHERE     act.product_id = a.product_id
                                        AND oo.task_type_id IN
                                                (SELECT (COLUMN_VALUE)
                                                   FROM TABLE ( LDC_BOUTILITIES.SPLITSTRINGS (
                                                                   (SELECT casevalo
                                                                      FROM  LDCI_CARASEWE
                                                                           C
                                                                     WHERE C.CASECODI =
                                                                           'TIPOS_DE_TRABAJOS_OT_APOYO'),
                                                                   ',')))
                                        AND act.order_id = oo.order_id
                                        AND oo.legalization_date <
                                            TO_DATE (
                                                      (SELECT casevalo
                                                         FROM  LDCI_CARASEWE C
                                                        WHERE C.CASECODI = 'FECHA_FIN_ORDEN_DE_APOYO'
                                                      )
                                                      , 'DD/MM/YYYY')
                                ))
                    OR (    o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                                  FROM TABLE ( LDC_BOUTILITIES.SPLITSTRINGS (
                                                                  (SELECT casevalo
                                                                     FROM  LDCI_CARASEWE
                                                                          C
                                                                    WHERE C.CASECODI =
                                                                          'TIPOS_DE_TRABAJOS_C_X_C'),
                                                                  ',')))
                        AND concclCo = 4                                -- cxc
                                        )
                    OR (    o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                                  FROM TABLE ( LDC_BOUTILITIES.SPLITSTRINGS (
                                                                  (SELECT casevalo
                                                                     FROM  LDCI_CARASEWE
                                                                          C
                                                                    WHERE C.CASECODI =
                                                                          'TIPO_DE_TRABAJO_CERTIF_PREVIA'),
                                                                  ',')))
                        AND concclco = 400
                        AND                                     -- Cert Previa
                            o2.causal_id = 9944             -- CA - 2021021720
                                               ))
               AND o2.order_id NOT IN
                       (SELECT oo.related_order_id
                          FROM  OR_related_order oo
                         WHERE     oo.related_order_id = o2.order_id
                               AND oo.rela_order_type_id IN (13, 14))
               AND a.product_id NOT IN
                       (SELECT hcecnuse
                          FROM  hicaesco h
                         WHERE     hcecfech <
                                   TO_DATE (
                                             (SELECT casevalo
                                                FROM  LDCI_CARASEWE C
                                               WHERE C.CASECODI =
                                                     'FECHA_INICIO_INGRESO_X_ORDEN')
                                             , 'DD-MM-YYYY')
                               AND hcecnuse = a.product_id
                               AND hcececan = 96
                               AND hcececac = 1
                               AND hcecserv = 7014);

    --
    -- CURSOR NOTAS DEL MES PRODUCTOS MIGRADOS - ANULACIONES
    --
    CURSOR CU_NOTAS_MES_MIG (nuse NUMBER, dtcurfein DATE, dtcurfefi DATE)
    IS
          SELECT cargnuse,
                 cargconc,
                 SUM (
                     DECODE (cargsign,
                             'DB', cargvalo,
                             'AS', cargvalo,
                             cargvalo * -1))    valor
            FROM  cargos c,  concepto O
           WHERE     c.cargnuse = nuse
                 AND c.cargconc = conccodi
                 AND concclco IN (4, 19, 400)                   -- Serv Nuevos
                 AND c.cargfecr BETWEEN dtcurfein -- Fecha inicial del mes de proceso
                                                  AND dtcurfefi -- Fecha final del mes de proceso
                 AND CARGCUCO > 0
                 AND cargtipr = 'P'
                 AND cargsign NOT IN ('PA', 'AP')
                 AND cargsign IN ('DB', 'CR')
                 AND cargcaca = 1                   -- Anulaciones de Migrados
        GROUP BY cargnuse, cargconc;

    --
    -- CURSOR SALDO ANTERIOR DE SERVICIOS PENDIENTES
    --
    CURSOR CU_SDO_ANT_MIGRA (NUANOA NUMBER, NUMESA NUMBER)
    IS
        SELECT *
          FROM  LDC_OSF_SERV_PENDIENTE L
         WHERE     L.NUANO = NUANOA
               AND L.NUMES = NUMESA
               AND L.TIPO = 'PROD_MIGRADOS';

    --
    -- CURSOR SALDO ANTERIOR DE SERVICIOS PENDIENTES 
    --
    CURSOR CU_SDO_ANT_S_PTE (NUANOA NUMBER, NUMESA NUMBER)
    IS
        select  nuano, numes, product_id, NULL estado_tec, (select sesucate from  servsusc where sesunuse = product_id) categoria, 
                solicitud, tipo_solicitud, TIPO, cebe, departamento, localidad, 
                (select g.ident_type_id
                  from  servsusc,  suscripc,  ge_subscriber g
                  where sesunuse = product_id
                    and sesususc = susccodi
                    and g.subscriber_id = suscclie) tipo_ident,
                (select g.identification
                  from  servsusc,  suscripc,  ge_subscriber g
                  where sesunuse = product_id
                    and sesususc = susccodi
                    and g.subscriber_id = suscclie) identificacion,  
                -- 
                NULL fec_venta, concepto, 
                sum(interna) interna, sum(carg_x_conex) carg_x_conex, sum(cert_previa) cert_previa, sum(notas) notas,
                sum(ingreso_report) ingreso_report, valor_anulado, orden
        from
        (
              select nuano, numes, estado_tec, categoria, solicitud, tipo_solicitud,
                     CASE 
                       When tipo_solicitud = 100271 then
                         product_id
                       When tipo_solicitud = 323 then
                         (select m.product_id from  mo_motive m where m.package_id = solicitud and m.product_type_id = 6121 and rownum = 1)
                       Else
                         product_id
                     END product_id, 
                     CASE
                       when tipo_solicitud = 100271 then 'PROD_MIGRADOS'
                       when tipo_solicitud = 323 then 'PROD_CONSTRUC'
                         Else
                           'NOTAS'
                     END TIPO,              
                     CASE
                       when cebe is not null then 
                         cebe
                       else
                         (select lc.celocebe from  ldci_centbenelocal lc where lc.celoloca = localidad) 
                     END cebe,
                     departamento, localidad, 
                     --
                     (select g.ident_type_id
                       from  servsusc,  suscripc,  ge_subscriber g
                       where sesunuse = product_id
                         and sesususc = susccodi
                         and g.subscriber_id = suscclie) tipo_ident,
                     (select g.identification
                       from  servsusc,  suscripc,  ge_subscriber g
                       where sesunuse = product_id
                         and sesususc = susccodi
                         and g.subscriber_id = suscclie) identificacion,  
                     --              
                     fec_venta, concepto, 
                     sum(interna) interna, sum(carg_x_conex) carg_x_conex, sum(cert_previa) cert_previa, sum(notas) notas,
                     sum(ingreso_report) ingreso_report, valor_anulado, orden
                from
              (
              SELECT nuano, numes, estado_tec, NULL categoria, solicitud, cebe, departamento, localidad,
                     CASE
                       When tipo_solicitud = 100271 then tipo_solicitud
                       When tipo_solicitud = 323 then tipo_solicitud
                         Else
                           (select m.package_type_id from  mo_packages m where m.package_id = solicitud)
                     END tipo_solicitud,
                     product_id, 
                     fec_venta, 
                     CASE
                       when concepto is not null then concepto
                       when interna > 0 then 19
                       when carg_x_conex > 0 then 4
                       when cert_previa > 0 then 400
                     END concepto, 
                     interna, carg_x_conex, cert_previa, notas, ingreso_report, valor_anulado, orden
                FROM  LDC_OSF_SERV_PENDIENTE L
               WHERE     L.NUANO = NUANOA --2023 
                     AND L.NUMES = NUMESA --7
              )
              group by nuano, numes, estado_tec, categoria, solicitud, tipo_solicitud, cebe, departamento, localidad, fec_venta, concepto, valor_anulado, orden, product_id
        )
        group by nuano, numes, product_id, categoria, solicitud, tipo_solicitud, TIPO, cebe, departamento, localidad, 
                 concepto, valor_anulado, orden;

    --
    -- CURSOR MOVIMIENTO DEL MES PARA APLICAR LAS VENTAS DEL MES
    --
    CURSOR CU_MVTO_SERV_PDTE_V IS
        SELECT *
          FROM  LDC_OSF_MVTO_SERV_PDTE s
         WHERE     s.nuano = nupano
               AND s.numes = nupmes
               AND s.tipo_mvto = 'VENTAS_MES';

    --
    -- CURSOR MOVIMIENTO DEL MES PARA APLICAR LOS SERVICIOS CUMPLIDOS
    --
    CURSOR CU_MVTO_SERV_PDTE_SC IS
        SELECT *
          FROM  LDC_OSF_MVTO_SERV_PDTE s
         WHERE     s.nuano = nupano
               AND s.numes = nupmes
               AND s.tipo_mvto = 'SERV_CUMPLIDO';

    --
    -- CURSOR MOVIMIENTO NOTAS DEL MES
    --
    CURSOR CU_NOTAS_MES IS
        SELECT *
          FROM  LDC_OSF_MVTO_SERV_PDTE s
         WHERE     s.nuano = nupano
               AND s.numes = nupmes
               AND s.tipo_mvto IN ('NOTA_MES', 'FRAS_MES');

    --
    -- CURSOR SERVICIOS PENDIENTES PARA APLICAR SERVICIOS CUMPLIDOS
    --
    CURSOR CU_SERV_PTES_SC (SOLI NUMBER, CONCE NUMBER)
    IS
        SELECT '1'
          FROM  LDC_OSF_SERV_PENDIENTE L
         WHERE     L.NUANO = NUPANO
               AND L.NUMES = NUPMES
               AND L.SOLICITUD = SOLI
               AND L.CONCEPTO = CONCE
               AND ROWNUM = 1;

    --
    -- CURSOR PARA APLICAR NOTAS
    --
    CURSOR CU_SERV_NOTAS_MES (NUSE NUMBER, CONCE NUMBER)
    IS
        SELECT '1'
          FROM  LDC_OSF_SERV_PENDIENTE L
         WHERE     L.NUANO = NUPANO
               AND L.NUMES = NUPMES
               AND L.PRODUCT_ID = NUSE
               AND l.concepto = CONCE
               AND l.notas != 0;


    SBSC            VARCHAR2 (1);
    dtfefein        ldc_ciercome.cicofein%TYPE;
    dtfefefin       ldc_ciercome.cicofech%TYPE;
    pmensa          VARCHAR2 (1000);
    nuok            NUMBER (2);
    nutsess         NUMBER;
    sbparuser       VARCHAR2 (30);
    nuanoant        NUMBER (4);
    numesant        NUMBER (2);
    sbprocess       VARCHAR2 (400) := 'LDC_GENERA_SERV_PENDIENTES - ' || to_char(sysdate ,'ddmmyyyyhh24:mi:ss');
        
    csbNOMPKG       CONSTANT VARCHAR2(32) := $$PLSQL_UNIT || '.'; 
    csbMetodo       CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                              'LDC_GENERA_SERV_PENDIENTES'; --nombre del metodo
    nutotareg       number;

-----
BEGIN
  
    -- Habilitamos traza
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);    
    --
    nutotareg := 0;
    sbmensa := NULL;
    error := 0;
    --
    ldc_cier_prorecupaperiodocont (nupano,
                                   nupmes,
                                   dtfefein,
                                   dtfefefin,
                                   pmensa,
                                   nuok);
    --
    -- Borrado de datos si se repite el proceso
    --
    DELETE LDC_OSF_SERV_PENDIENTE l
     WHERE l.nuano = nupano AND l.numes = nupmes;

    COMMIT;

    DELETE LDC_OSF_MVTO_SERV_PDTE o
     WHERE o.nuano = nupano AND o.numes = nupmes;

    COMMIT;

    --
    -- Ano y mes anterior
    --
    IF nupmes = 1
    THEN
        nuanoant := nupano - 1;
        numesant := 12;
    ELSE
        nuanoant := nupano;
        numesant := nupmes - 1;
    END IF;

    --
    SELECT USERENV ('SESSIONID'), USER
      INTO nutsess, sbparuser
      FROM DUAL;

    -- Se adiciona al log de procesos
    --
    --sbprocess := 'LDC_GENERA_SERV_PENDIENTES - ' || to_char(sysdate ,'ddmmyyyyhh24:mi:ss');
    --     
    pkg_estaproc.prInsertaEstaproc(
                                   sbprocess,
                                   nutotareg
                                  );
    -- Seguimiento traza
    pkg_traza.trace('Cursor ' || 'CU_VENTAS_MES',
                    pkg_traza.cnuNivelTrzDef);

    -- RECORREMOS LAS VENTAS DEL MES
    FOR I IN CU_VENTAS_MES (dtfefein, dtfefefin)
    LOOP
        -- Insertamos registro
        INSERT INTO LDC_OSF_MVTO_SERV_PDTE (nuano,
                                            numes,
                                            product_id,
                                            tipo_mvto,
                                            solicitud,
                                            tipo_solicitud,
                                            fec_venta,
                                            tipo,
                                            departamento,
                                            localidad,
                                            estado_tec,
                                            categoria,
                                            concepto,
                                            interna,
                                            carg_x_conex,
                                            cert_previa,
                                            notas,
                                            ingreso_report,
                                            valor_anulado,
                                            apartamentos,
                                            constructora)
             VALUES (nupano,
                     nupmes,
                     i.nuse,
                     'VENTAS_MES',
                     i.solicitud,
                     i.TIPO_SOLICITUD,
                     i.fec_venta,
                     i.tipo,
                     i.depa,
                     i.loca,
                     i.EST_TECNICO,
                     i.cate,
                     i.concclco,
                     i.interna,
                     i.cxc,
                     i.certificacion,
                     0,
                     0,
                     0,
                     i.ventas,
                     i.constructora);
    --
    END LOOP;

    --
    COMMIT;

    -- Seguimiento traza
    pkg_traza.trace('Cursor ' || 'CU_NOTAS_VTAS_MES',
                    pkg_traza.cnuNivelTrzDef);
    --
    -- RECORREMOS LAS NOTAS Y FACTURACION DEL MES PARA CONSTRUCTORAS
    FOR I IN CU_NOTAS_VTAS_MES (dtfefein, dtfefefin)
    LOOP
        -- Insertamos registro
        INSERT INTO LDC_OSF_MVTO_SERV_PDTE (nuano,
                                            numes,
                                            product_id,
                                            tipo_mvto,
                                            solicitud,
                                            tipo_solicitud,
                                            fec_venta,
                                            tipo,
                                            departamento,
                                            localidad,
                                            estado_tec,
                                            categoria,
                                            concepto,
                                            interna,
                                            carg_x_conex,
                                            cert_previa,
                                            notas,
                                            ingreso_report,
                                            valor_anulado,
                                            apartamentos,
                                            constructora)
             VALUES (nupano,
                     nupmes,
                     i.construct,
                     I.TIPO,
                     NULL,
                     NULL,
                     NULL,
                     I.TIPO,
                     i.depa,
                     i.loca,
                     NULL,
                     NULL,
                     i.concclco,
                     0,
                     0,
                     0,
                     i.total,
                     0,
                     0,
                     0,
                     i.construct);
    --
    END LOOP;

    --
    COMMIT;

    --
    -- Seguimiento traza
    pkg_traza.trace('Cursor ' || 'CU_SDO_ANT_MIGRA',
                    pkg_traza.cnuNivelTrzDef);    
    -- RECORREMOS LAS NOTAS DEL PARA TIPO IN PROD_MIGRADOS'
    FOR M IN CU_SDO_ANT_MIGRA (nuanoant, numesant)
    LOOP
        --
        FOR I IN CU_NOTAS_MES_MIG (m.product_id, dtfefein, dtfefefin)
        LOOP
            -- Insertamos registro
            INSERT INTO LDC_OSF_MVTO_SERV_PDTE (nuano,
                                                numes,
                                                product_id,
                                                tipo_mvto,
                                                solicitud,
                                                tipo_solicitud,
                                                fec_venta,
                                                tipo,
                                                departamento,
                                                localidad,
                                                estado_tec,
                                                categoria,
                                                concepto,
                                                interna,
                                                carg_x_conex,
                                                cert_previa,
                                                notas,
                                                ingreso_report,
                                                valor_anulado,
                                                apartamentos,
                                                constructora)
                 VALUES (nupano,
                         nupmes,
                         i.CARGNUSE,
                         'NOTAS_MES',
                         NULL,
                         NULL,
                         NULL,
                         'NOTAS_MES',
                         M.departamento,
                         M.localidad,
                         NULL                                  --i.EST_TECNICO
                             ,
                         NULL                               --i.cate -- xxxxxx
                             ,
                         i.CARGCONC,
                         0,
                         0,
                         0,
                         i.VALOR,
                         0,
                         0,
                         0,
                         0);
        --
        END LOOP;
    --
    END LOOP;

    --
    COMMIT;

    --
    --
    -- Seguimiento traza
    pkg_traza.trace('Cursor ' || 'CU_CUM_OSF_MES',
                    pkg_traza.cnuNivelTrzDef);
    --
    -- RECORREMOS LOS SERVICIOS CUMPLIDOS osf
    FOR I IN CU_CUM_OSF_MES (dtfefein, dtfefefin)
    LOOP
        -- Insertamos registro
        INSERT INTO LDC_OSF_MVTO_SERV_PDTE (nuano,
                                            numes,
                                            product_id,
                                            tipo_mvto,
                                            solicitud,
                                            tipo_solicitud,
                                            fec_venta,
                                            tipo,
                                            departamento,
                                            localidad,
                                            estado_tec,
                                            categoria,
                                            concepto,
                                            interna,
                                            carg_x_conex,
                                            cert_previa,
                                            notas,
                                            ingreso_report,
                                            valor_anulado,
                                            apartamentos,
                                            constructora)
             VALUES (nupano,
                     nupmes,
                     i.PRODUCT_ID,
                     I.SALDO,
                     I.SOLICITUD,
                     NULL,
                     NULL,
                     I.TIPO,
                     i.DPTO,
                     i.loca,
                     NULL,
                     I.SESUCATE ,
                     i.clasificador,
                     i.interna,
                     i.cxc,
                     i.certificacion,
                     0,
                     0,
                     0,
                     0,
                     NULL);
    --
    END LOOP;

    --
    COMMIT;

    --
    --
    -- PROCESO DE GENERACION DE LOS SERVICIOS PENDIENTES DEL MES ACTUAL.
    --
    -- Seguimiento traza
    pkg_traza.trace('Cursor ' || 'CU_SDO_ANT_S_PTE',
                    pkg_traza.cnuNivelTrzDef);    
    --
    FOR I IN CU_SDO_ANT_S_PTE (nuanoant, numesant)
    LOOP
        --
        -- Insertamos registro
        INSERT INTO LDC_OSF_SERV_PENDIENTE (nuano,
                                            numes,
                                            product_id,
                                            estado_tec,
                                            categoria,
                                            solicitud,
                                            tipo_solicitud,
                                            tipo,
                                            cebe,
                                            departamento,
                                            localidad,
                                            tipo_ident          -- OJO
                                                      ,
                                            identificacion      -- OJO
                                                          ,
                                            fec_venta,
                                            concepto,
                                            interna,
                                            carg_x_conex,
                                            cert_previa,
                                            notas,
                                            ingreso_report,
                                            valor_anulado,
                                            orden)
             VALUES (nupano,
                     nupmes,
                     I.PRODUCT_ID,
                     I.ESTADO_TEC,
                     I.CATEGORIA,
                     I.SOLICITUD,
                     I.TIPO_SOLICITUD,
                     I.TIPO, 
                     I.CEBE,
                     I.departamento,
                     I.LOCALIDAD,
                     I.tipo_ident,
                     I.IDENTIFICACION,
                     I.FEC_VENTA,
                     I.CONCEPTO,
                     I.INTERNA,
                     I.carg_x_conex,
                     I.cert_previa, -- CERTIFICACION,
                     I.NOTAS,       -- 
                     I.ingreso_report,
                     0,
                     0);
      --
      END LOOP;

      COMMIT;

    --
    -- Insertamos las ventas del mes.
    --
    -- Seguimiento traza
    pkg_traza.trace('Cursor ' || 'CU_MVTO_SERV_PDTE_V',
                    pkg_traza.cnuNivelTrzDef);     
    --
    FOR A IN CU_MVTO_SERV_PDTE_V
    LOOP
        --
        -- Insertamos registro
        INSERT INTO LDC_OSF_SERV_PENDIENTE (nuano,
                                            numes,
                                            product_id,
                                            estado_tec,
                                            categoria,
                                            solicitud,
                                            tipo_solicitud,
                                            tipo,
                                            cebe,
                                            departamento,
                                            localidad--,tipo_ident     -- OJO
                                                     ,
                                            fec_venta,
                                            concepto,
                                            interna,
                                            carg_x_conex,
                                            cert_previa,
                                            notas,
                                            ingreso_report,
                                            valor_anulado,
                                            orden)
             VALUES (nupano,
                     nupmes,
                     A.PRODUCT_ID,
                     A.ESTADO_TEC,
                     A.CATEGORIA,
                     A.SOLICITUD,
                     A.TIPO_SOLICITUD,
                     A.TIPO,
                     NULL,
                     A.departamento,
                     A.LOCALIDAD,
                     A.FEC_VENTA,
                     A.CONCEPTO,
                     A.INTERNA,
                     A.CARG_X_CONEX,
                     A.CERT_PREVIA,
                     0,
                     0,
                     0,
                     0);
    END LOOP;

    --
    COMMIT;

    -- Hasta aqui ok..

    --
    -- Insertamos los registros cumplidos.
    --
    -- Seguimiento traza
    pkg_traza.trace('Cursor ' || 'CU_MVTO_SERV_PDTE_SC',
                    pkg_traza.cnuNivelTrzDef);
    --
    FOR A IN CU_MVTO_SERV_PDTE_SC
    LOOP
        --
        OPEN CU_SERV_PTES_SC (A.SOLICITUD, A.CONCEPTO);
        FETCH CU_SERV_PTES_SC INTO SBSC;
        IF CU_SERV_PTES_SC%FOUND
        THEN
            -- Actualizamos registro
            UPDATE LDC_OSF_SERV_PENDIENTE P
               SET p.ingreso_report =    NVL (ingreso_report, 0)
                                       + NVL (A.INTERNA, 0)
                                       + NVL (A.CARG_X_CONEX, 0)
                                       + NVL (A.CERT_PREVIA, 0)
             WHERE     P.NUANO = nupano
                   AND P.NUMES = nupMES
                   AND P.SOLICITUD = A.SOLICITUD -- P.PRODUCT_ID = A.PRODUCT_ID
                   --  Se hace la actualizacion por clasificador contable CAMPO CONCEPTO.
                   AND P.CONCEPTO = A.CONCEPTO
                   AND NVL (NOTAS, 0) = 0
                   AND ROWNUM = 1;

            -->>
            --
            COMMIT;
        --
        ELSE
            -- Insertamos registro
            INSERT INTO LDC_OSF_SERV_PENDIENTE (nuano,
                                                numes,
                                                product_id,
                                                estado_tec,
                                                categoria,
                                                solicitud,
                                                tipo_solicitud,
                                                tipo,
                                                cebe,
                                                departamento,
                                                localidad,
                                                fec_venta,
                                                concepto,
                                                interna,
                                                carg_x_conex,
                                                cert_previa,
                                                notas,
                                                ingreso_report,
                                                valor_anulado,
                                                orden)
                     VALUES (
                                nupano,
                                nupmes,
                                A.PRODUCT_ID,
                                A.ESTADO_TEC,
                                A.CATEGORIA,
                                A.SOLICITUD,
                                A.TIPO_SOLICITUD,
                                A.TIPO,
                                NULL,
                                A.departamento,
                                A.LOCALIDAD,
                                A.FEC_VENTA,
                                A.CONCEPTO,
                                0,
                                0,
                                0,
                                0,
                                (  NVL (A.INTERNA, 0)
                                 + NVL (A.CARG_X_CONEX, 0)
                                 + NVL (A.CERT_PREVIA, 0)),
                                0,
                                0);
        END IF;

        CLOSE CU_SERV_PTES_SC;
    END LOOP;

    --
    COMMIT;

    --
    -- Insertamos los Notas.
    --
    -- Seguimiento traza
    pkg_traza.trace('Cursor ' || 'CU_SERV_NOTAS_MES',
                    pkg_traza.cnuNivelTrzDef);    
    --
    FOR A IN CU_NOTAS_MES
    LOOP
        --
        OPEN CU_SERV_NOTAS_MES (A.PRODUCT_ID, A.CONCEPTO);

        FETCH CU_SERV_NOTAS_MES INTO SBSC;

        IF CU_SERV_NOTAS_MES%FOUND
        THEN
            -- Actualizamos registro
            UPDATE LDC_OSF_SERV_PENDIENTE P
               SET NOTAS = NOTAS + A.NOTAS
             WHERE     P.NUANO = nupano
                   AND P.NUMES = nupMES
                   AND P.PRODUCT_ID = A.PRODUCT_ID
                   --<<
                   --  Se hace la actualizacion por clasificador contable.
                   AND P.CONCEPTO = A.CONCEPTO
                   AND NVL (P.NOTAS, 0) != 0;
        -->>
        --
        ELSE
            -- Insertamos registro
            INSERT INTO LDC_OSF_SERV_PENDIENTE (nuano,
                                                numes,
                                                product_id,
                                                estado_tec,
                                                categoria,
                                                solicitud,
                                                tipo_solicitud,
                                                tipo,
                                                cebe,
                                                departamento,
                                                localidad,
                                                fec_venta,
                                                concepto,
                                                interna,
                                                carg_x_conex,
                                                cert_previa,
                                                notas,
                                                ingreso_report,
                                                valor_anulado,
                                                orden)
                 VALUES (nupano,
                         nupmes,
                         A.PRODUCT_ID,
                         A.ESTADO_TEC,
                         A.CATEGORIA,
                         A.SOLICITUD,
                         A.TIPO_SOLICITUD,
                         A.TIPO,
                         NULL,
                         A.departamento,
                         A.LOCALIDAD,
                         A.FEC_VENTA,
                         A.CONCEPTO,
                         0,
                         0,
                         0,
                         A.Notas,
                         0,
                         0,
                         0);
        END IF;

        CLOSE CU_SERV_NOTAS_MES;
    END LOOP;

    --
    COMMIT;
    --
    -- Se adiciona al log de procesos la finalizacion
    pkg_estaproc.prActualizaEstaproc(
                                     sbprocess,
                                     'Ok',
                                     'Proceso Finalizado correctamente'
                                    );
    -- Fin traza
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN); 
--
EXCEPTION
    WHEN OTHERS
    THEN
        -- Traza
        pkg_traza.trace(csbMetodo,
                  pkg_traza.cnuNivelTrzDef,
                  pkg_traza.csbFIN_ERR);
        --
        sbmensa := 'Error  ' || SQLERRM;
        pkg_estaproc.prActualizaEstaproc(
                                         sbprocess,
                                         'Error',
                                         sbmensa
                                        );
        error := -1;
--
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_GENERA_SERV_PENDIENTES', 'ADM_PERSON');
END;
/
