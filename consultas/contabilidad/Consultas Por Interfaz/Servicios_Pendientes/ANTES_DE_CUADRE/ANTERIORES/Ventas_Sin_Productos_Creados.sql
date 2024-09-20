-- VENTAS SIN PRODUCTOS CREADOS
select CEBE, (select g.geo_loca_father_id from open.ge_geogra_location g where g.geograp_location_id = loca) DEPA,
       LOCA, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
       cargnuse NUSE, CATE, -1 EST_TECNICO, DES_TECNICO,
       decode(cargconc,19,'C_X_C',
                       30,'INT_RES', 
                       291,'INT_INDUS',
                       674,'REV_PREVIA','NO_EXISTE') concdesc,
       cargvalo VR_INGRESO, TIPO_SOLICITUD, 0 REPORTADA
  from (
        select (select l.celocebe
                  from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
                 where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi)
                   and t.geo_loca_father_id = l.celodpto
                   and t.geograp_location_id = celoloca) CEBE,
               (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
               cargnuse, -1 CATE, 'SIN CREAR PRODUCTOS' DES_TECNICO, cargconc, cargvalo, package_type_id TIPO_SOLICITUD
          from open.cargos, open.servsusc, open.suscripc, open.mo_packages mo
         where /*cargnuse = 50887326
           and */cargnuse = sesunuse
           and sesuserv = 6121
           and sesususc = susccodi
           and cargfecr >= '09-02-2015'
           and cargfecr <  '01-05-2015'
           and substr(cargdoso,1,3) = 'PP-'
           and cargconc in (19,30,674,291)
           and substr(cargdoso, 4, 8) not in (select act.package_id from open.or_order_activity act, open.mo_packages m
                                               where act.package_id = substr(cargdoso, 4, 8)
                                                 and act.task_type_id in (12149, 12150, 12151, 12152, 12153)
                                                 and act.package_id = m.package_id
                                                 and m.package_type_id in (323, 100229))
           and substr(cargdoso, 4, 8) = mo.package_id
           and mo.package_type_id in (323, 100229)
       )
