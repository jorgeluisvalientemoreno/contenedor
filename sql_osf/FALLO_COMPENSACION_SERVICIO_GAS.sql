SELECT /*+ index(PR_TIMEOUT_COMPONENT IDX_PR_TIMEOUT_COMPONENT04 ) */
 timeout_component_id,
 component_id,
 initial_date,
 final_date,
 package_id,
 element_id,
 authorization_date,
 suspended_time,
 compensated_time
  FROM open.pr_timeout_component
/* pr_bcTimeoutComponent.GetDownTimeOfService */
 WHERE pr_timeout_component.authorization_date >=
       TO_DATE(&idtDateIni, 'DD/MM/YYYY HH24:MI:SS')
   AND pr_timeout_component.authorization_date <
       trunc(TO_DATE(&idtDateFin, 'DD/MM/YYYY HH24:MI:SS')) + 1
   AND pr_timeout_component.authorization_date is not null
   AND pr_timeout_component.component_id =
       nvl(&inuComponent, pr_timeout_component.component_id);

---ORM 40
SELECT CASE equiva.servicioexclu
         WHEN 'S' THEN
          'ASE'
         WHEN 'N' THEN
          'ASNE'
       END ASE_ASNE,
       equiva.departamento Departamento_SSPD,
       (SELECT ge.description
          FROM Open.ge_geogra_location ge
         WHERE ge.geograp_location_id = geo.geo_loca_father_id) Desc_Departamento,
       CASE equiva.poblacion
         WHEN '000' THEN
          equiva.municipio
         ELSE
          equiva.municipio || equiva.poblacion
       END Localidad_SSPD,
       (SELECT ge.description
          FROM Open.ge_geogra_location ge
         WHERE ge.geograp_location_id = geo.geograp_location_id) Desc_Localidad,
       susc.susccodi contrato,
       serv.sesunuse producto,
       (SELECT sub.subscriber_name || ' ' || sub.subs_last_name || ' ' ||
               sub.subs_second_last_name
          FROM Open.ge_subscriber sub
         WHERE sub.subscriber_id = susc.suscclie
           AND ROWNUM = 1) Nombre_suscriptor,
       serv.sesucate Sector_consumo,
       cuenc.cucofact factura,
       TO_CHAR(pr_timeout_component.initial_date,
               'month',
               'NLS_DATE_LANGUAGE=SPANISH') periodo_interrupcion,
       TO_CHAR(pr_timeout_component.initial_date, 'YYYY') Ano,
       floor(carg.cargunid) || ':' || trunc(mod(carg.cargunid * 60, 60)) || ':' ||
       trunc(mod(carg.cargunid * 60 * 60, 60)) DES,
       (SELECT vitcvalo
          FROM Open.ta_vigetaco vige
         WHERE vige.vitctaco(+) = carg.cargtaco
           AND pr_timeout_component.authorization_date BETWEEN vitcfein AND
               vitcfefi
           AND ROWNUM = 1) Tarifa,
       CASE
         WHEN carg.cargdoso IS NULL THEN
          NULL --TRUNC( ORM.fnuConsumo(sesunuse, pr_timeout_component.INITIAL_DATE),2 )
         ELSE
          trunc(carg.cargvalo /
                ((SELECT vitcvalo
                    FROM Open.ta_vigetaco vige
                   WHERE vige.vitctaco(+) = carg.cargtaco
                     AND pr_timeout_component.authorization_date BETWEEN
                         vitcfein AND vitcfefi
                     AND ROWNUM = 1) * (carg.cargunid)),
                5)
       END Demanda,
       carg.cargvalo Valor_compensado,
       serv.sesucico Ciclo_de_consumo,
       or_order_activity.order_id Orden,
       OR_order.created_date Fecha_registro_orden,
       fact.factfege Fecha_facturacion,
       pr_timeout_component.package_id Falla,
       CASE
         WHEN carg.cargdoso IS NULL THEN
          serv.sesuesco
         ELSE
          NULL
       END ESTA_CORT_AL_COMPENSAR,
       CASE
         WHEN carg.cargdoso IS NULL THEN
          (SELECT escodesc
             FROM Open.estacort ec
            WHERE ec.escocodi = serv.sesuesco)
         ELSE
          NULL
       END DESC_ESTA_CORT_AL_COMPENSAR,
       CASE
         WHEN carg.cargdoso IS NULL THEN
          (SELECT coecfact
             FROM Open.confesco ce
            WHERE ce.coecserv = serv.sesuserv
              AND ce.coeccodi = serv.sesuesco)
         ELSE
          NULL
       END ESTA_CORT_FACTURABLE
  FROM Open.pr_timeout_component,
       Open.cargos               carg,
       Open.servsusc             serv,
       Open.pr_product           prod,
       Open.suscripc             susc,
       Open.cuencobr             cuenc,
       Open.pericose             perio,
       Open.factura              fact,
       Open.pr_component,
       Open.tt_damage,
       Open.or_order_activity,
       Open.OR_order,
       Open.ab_address           addr,
       Open.ge_geogra_location   geo,
       Open.ldc_equiva_localidad equiva
 WHERE pr_timeout_component.initial_date >=
       to_Date(&FechaIni, 'dd/mm/yyyy')
   AND pr_timeout_component.initial_date <
       to_Date(&FechaFin, 'dd/mm/yyyy') + 1
   and AUTHORIZATION_DATE is not null
   AND carg.cargdoso(+) =
       'TFS-D-' || pr_timeout_component.timeout_component_id
   AND pr_component.component_id = pr_timeout_component.component_id
   AND serv.sesunuse = pr_component.product_id
   and prod.product_id = serv.sesunuse
   AND susc.susccodi = serv.sesususc
   AND cuenc.cucocodi(+) = carg.cargcuco
   AND perio.pecscons(+) = carg.cargpeco
   AND fact.factcodi(+) = cuenc.cucofact
   AND tt_damage.package_id = pr_timeout_component.package_id
   AND or_order_activity.order_activity_id = tt_damage.order_activity_id
   AND OR_order.order_id = or_order_activity.order_id
   And addr.Address_id = prod.address_id
   AND Geo.geograp_location_id = addr.geograp_location_id
   AND equiva.geograp_location_id(+) = geo.geograp_location_id
