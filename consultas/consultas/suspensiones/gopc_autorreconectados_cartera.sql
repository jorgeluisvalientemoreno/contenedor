select 
distinct lp.proceso_id codigo_proceso,
         lp.proceso_descripcion nombre_proceso,
         susp_persec_ciclcodi ciclo,
         cicldesc descripcion_ciclo,
         susp_persec_producto producto,
         servsusc.sesuesco codigo_estado_corte,
         (select estc.escodesc 
         from open.estacort estc 
         where estc.escocodi = servsusc.sesuesco) estado_corte,
         subscriber_name || ' ' || subs_last_name nombre,
         susp_persec_salpend saldo,
         gc_bodebtmanagement.fnugetexpirdebtbyprod(susp_persec_producto) cartera_vencida,
         (select round(months_between(to_date(sysdate),max(pps.register_date)))
         from open.pr_prod_suspension pps
         where pps.product_id = susp_persec_producto) meses_suspencion,
         susp_persec_consumo consumo,
         susp_persec_act_orig actividad_origen,
         b.description descripcion_origen,
         susp_persec_activid actividad_destino,
         a.description descripcion_destino,
         susp_persec_pervari numero_periodos,
         susp_persec_persec flag_persecucion,
         ldc_reportesconsulta.fsbestadofinancieroproducto(susp_persec_producto) estado_financiero,
         susp_persec_fejproc fecha_proceso,
         susp_persec_codi consecutivo,
         (select count(*)
          from open.cuencobr
          where cucosacu > 0
          and cuconuse = susp_persec_producto) cuentas_con_saldo,
          sesucate uso,
         (select c.catedesc 
          from open.categori c 
          where c.catecodi = sesucate) descripcion_uso,
         (select max(leemleto)
          from open.pr_product, lectelme
          where product_id = leemsesu
          and leemdocu = suspen_ord_act_id
          and leemclec <> 'f'
          and product_id = susp_persec_producto) lectura_ultima_suspension,
         (select max(leemleto)
          from open.lectelme
          where leemsesu = sesunuse
          and leemclec = 'f'
          and lectelme.leemfele in
          (select max(lectelme.leemfele)
          from lectelme
          where leemsesu = sesunuse
          and leemclec = 'f')) ultima_lectura_facturacion,
         (select g.geo_loca_father_id
          from open.ge_geogra_location g
          where g.geograp_location_id = open.daab_address.fnugetgeograp_location_id(pr.address_id)) cod_departamento,
         (select g2.description 
          from open.ge_geogra_location g, ge_geogra_location g2 
          where g2.geograp_location_id = g.geo_loca_father_id 
          and g.geograp_location_id = open.daab_address.fnugetgeograp_location_id(pr.address_id)) departamento,
          open.daab_address.fnugetgeograp_location_id(pr.address_id) cod_localidad,
          (select g.description 
          from open.ge_geogra_location g 
          where g.geograp_location_id = open.daab_address.fnugetgeograp_location_id(pr.address_id)) localidad
  from open.ldc_susp_persecucion , open.ldc_proceso_actividad lpa
  inner join open.ge_items   a on a.items_id = susp_persec_activid
  inner join open.ge_items   b on b.items_id = susp_persec_act_orig
  inner join open.ciclo on ciclcico = susp_persec_ciclcodi
  inner join open.servsusc on sesunuse = susp_persec_producto
  inner join open.suscripc on sesususc = susccodi
  inner join open.ge_subscriber on subscriber_id = suscclie 
  inner join open.ldc_proceso  lp on and lp.proceso_id = lpa.proceso_id
  inner join open.pr_product  pr on pr.product_id = sesunuse
 where  sesunuse = susp_persec_producto
   and susp_persec_order_id is null
   and 0 = (select count(1)
            from open.ldc_consumo_cero lcc
            where lcc.proceso_id = lp.proceso_id
              and lcc.product_id = susp_persec_producto)
   and (b.items_id = lpa.activity_id or a.items_id = lpa.activity_id)
