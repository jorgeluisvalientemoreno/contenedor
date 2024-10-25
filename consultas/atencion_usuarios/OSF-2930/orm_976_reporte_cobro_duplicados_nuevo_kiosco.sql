--orm_976_reporte_cobro_duplicados_nuevo_kiosco
select (select de.geograp_location_id ||' - '|| de.description desc_departamento
        from   open.ge_geogra_location de
        where  lo.geo_loca_father_id = de.geograp_location_id) Departamento, 
       lo.geograp_location_id ||' - '||     lo.description Localidad,
       pa.package_id Solicitud,
       pa.request_date fecha_registro,
       (select mr.reception_type_id || ' - ' || mr.description
        from   open.ge_reception_type mr
        where  mr.reception_type_id = pa.reception_type_id) medio_recepcion,
       mo.subscription_id,
       (select nvl(sum(car.cargvalo), 0)
        from   open.cargos car, open.pr_product k
        where  car.cargnuse =  k.product_id
         and   car.cargcuco != -1
         and   car.cargconc = 24         
 --        and   (substr(car.cargdoso, 1, 3) = 'DP-' OR
 --               substr(car.cargdoso, 1, 3) = 'PP-' OR
 --               substr(car.cargdoso, 1, 4) = 'PP-0')
         and   (substr(car.cargdoso, 1, 3) = 'DP-' OR
                car.cargdoso = 'PP-' || pa.package_id OR
                substr(car.cargdoso, 1, 4) = 'PP-0')                
        and    trunc(car.cargfecr) = trunc(pa.attention_date)
        and    k.subscription_id = mo.subscription_id
        and    rownum = 1) valor_duplicado,
       pa.user_id || ' - ' ||
       (select fu.name_
        from   open.ge_person fu
        where  fu.person_id = pa.person_id) funcionario_registra,
       (select ca.causal_id || ' - ' || ca.description
        from   open.cc_causal ca
        where  ca.causal_id = mo.causal_id) causal,
       pa.terminal_id terminal,
       OPEN.daps_package_type.fsbgetdescription(OPEN.damo_packages.fnugetpackage_type_id(pa.package_id,NULL),NULL) nombre_solicitud,
       pa.comment_ observacion
from   open.mo_packages pa,
       open.mo_motive   mo,
       open.suscripc           su,
       open.ab_address         di,
       open.ge_geogra_location lo
where  pa.package_id = mo.package_id
and    mo.subscription_id = su.susccodi
and    su.susciddi = di.address_id
and    di.geograp_location_id = lo.geograp_location_id
--and    pa.package_type_id = 100342
and    pa.package_type_id In (100342,100006,100212)
and    pa.request_date >= to_date(:fecha_inicial||' 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
and    pa.request_date <= to_date(:fecha_final||' 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
