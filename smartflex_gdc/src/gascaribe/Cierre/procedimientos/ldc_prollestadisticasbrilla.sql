CREATE OR REPLACE PROCEDURE "LDC_PROLLESTADISTICASBRILLA" (nupano NUMBER,nupmes NUMBER,nuok OUT NUMBER,sberror OUT VARCHAR2) is
/**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  ldc_prollestadisticasbrilla

  Descripcion  : Estadisticas ventas brilla

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 18-01-2014

  Historia de Modificaciones

        30/10/2014    paulaag     Se crea la funcion fnuGetObjetivo para obtener el valor
                                  objetivo.
                                  Busca primero si existe una configuracion en LDC_BUDGETBYPROVIDER
                                  para la localidad que se envia en el cursor. Si existe, retorna
                                  el valor de la configuracion.
                                  Si no existe una configuracion, valida si existe una configuracion
                                  sin localidad definida para los datos enviados. Si existe, entonces
                                  retorna este valor configurado.

  30/04/2015    310957 LJL        Se modifica consulta proncipal para que tome la fecha de registro de la
                                  solicitud, con el objetivo que tenga los mismos filtros que el reporte detalle venta
                                  Tambien se quita la parte de tomar objetivo por departamento, porque se manejara directamente
                                  en el reporte.
**************************************************************/
-- Cursor ventas recibidas en el mes
  CURSOR cuventasrecibidasmes(nucano NUMBER,nucmes NUMBER) IS
   SELECT codigo_departamento
         ,localidad
         ,punto_venta
         -- Adicion paulaag
         --,idservicio
         ,SUM(valor_recibido) valor_recibido
         ,SUM(total_articulos) total_articulos
         ,SUM(no_lega_mes) total_no_lega_mes
    FROM(
         SELECT solicitud
               ,(SELECT uo.contractor_id FROM open.or_operating_unit uo WHERE uo.operating_unit_id = unid_oper_vend)  punto_venta
               ,valor_recibido
               ,departamento codigo_departamento
               ,descripcion_departamento
               ,localidad
               ,descripcion_localidad
               ,NVL((SELECT SUM((NVL(oi.amount,0)*NVL(oi.value,0))+nvl(oi.iva,0)) FROM open.or_order_activity ae,open.ld_item_work_order oi WHERE ae.package_id = solicitud AND ae.task_type_id = 10143 AND oi.state <> 'AN' AND ae.order_activity_id = oi.order_activity_id),0) total_articulos
               ,NVL((SELECT SUM((NVL(oi.amount,0)*NVL(oi.value,0))+nvl(oi.iva,0))
                       FROM open.or_order_activity ae
                           ,open.ld_item_work_order oi
                           ,open.or_order oh
                           ,open.ldc_ciercome fg
                      WHERE ae.package_id = solicitud
                        AND ae.task_type_id = 12590
                        AND oi.state <> 'AN'
                        AND fg.cicoano = nucano
                        AND fg.cicomes = nucmes
                        AND ae.order_activity_id = oi.order_activity_id
                        AND ae.order_id = oh.order_id
                        AND nvl(oh.legalization_date,to_date('01/01/1900 00:00:00','dd/mm/yyyy hh24:mi:ss')) NOT BETWEEN fg.cicofein AND fg.cicofech),0) no_lega_mes
                -- Adicion paulaag
                --,idservicio
          FROM(
               SELECT  distinct(ve.non_ba_fi_requ_id) solicitud
                      ,ac.subscription_id contrato
                      ,so.pos_oper_unit_id unid_oper_vend
                      ,nvl(ve.value_total,0) valor_recibido       -- ps_package_type    ps_prd_motiv_package mo_motive
                      ,lo.geo_loca_father_id departamento
                      ,(SELECT de.description FROM open.ge_geogra_location de WHERE de.geograp_location_id = lo.geo_loca_father_id) descripcion_departamento
                      ,lo.geograp_location_id localidad
                      ,lo.description descripcion_localidad
                      -- Adicion paulaag
                      --,mo.product_type_id idservicio
                 FROM open.ldc_ciercome ci
                     ,open.ld_non_ba_fi_requ ve
                     ,open.mo_packages so
                     ,open.or_order_activity ac
                     ,open.suscripc su
                     ,open.ab_address di
                     ,open.ge_geogra_location lo
                     --Adicion paulaag
                     --,open.mo_motive mo
                WHERE ci.cicoano = nucano
                  AND ci.cicomes = nucmes
               --   AND ve.sale_date BETWEEN ci.cicofein AND ci.cicofech SAO 310957 LJL  -- se filtra por fecha de registro de la solicitud
                  AND so.request_date BETWEEN ci.cicofein AND ci.cicofech
                  AND ve.non_ba_fi_requ_id = so.package_id
                  AND so.package_id = ac.package_id
                  --and mo.package_id = so.package_id
                  AND ac.subscription_id = su.susccodi
                  AND su.susciddi = di.address_id
                  AND di.geograp_location_id = lo.geograp_location_id))
 GROUP BY codigo_departamento
          ,localidad
          ,punto_venta
          --,idservicio
 ORDER BY codigo_departamento
          ,localidad
          ,punto_venta
          --,idservicio;
          ;
-- Cursor ventas legalizadas en el mes
 CURSOR cuventaslegalizadas(nucano NUMBER,nucmes NUMBER) IS
  SELECT  lo.geo_loca_father_id codigo_departamento
         ,lo.geograp_location_id localidad
         ,ou.contractor_id punto_venta
         -- Adicion paulaag
         --,mo.product_type_id idservicio
         ,NVL(sum((nvl(i.amount,0)*nvl(i.value,0))+nvl(i.iva,0)),0) total_legalizado
    FROM  open.ldc_ciercome ce
         ,open.or_order_activity oa
         ,open.or_order ot
         ,open.ge_causal ca
         ,open.ld_item_work_order i
         ,open.mo_packages pk
         ,open.or_operating_unit ou
         ,open.suscripc su
         ,open.ab_address di
         ,open.ge_geogra_location lo
         -- Adicion paulaag
         --,open.mo_motive mo
   WHERE ce.cicoano = nucano
     AND ce.cicomes = nucmes
     AND oa.task_type_id = 12590
     AND ot.order_status_id = 8
     AND ca.class_causal_id = 1
     AND i.state <> 'AN'
     --AND nvl(ot.legalization_date,to_date('01/01/1900 00:00:00','dd/mm/yyyy hh24:mi:ss')) BETWEEN ce.cicofein AND ce.cicofech SAO 310957 LJL  -- se filtra por fecha de registro de la solicitud
     AND  nvl(pk.request_date,to_date('01/01/1900 00:00:00','dd/mm/yyyy hh24:mi:ss')) BETWEEN ce.cicofein AND ce.cicofech
     AND oa.order_id = ot.order_id
     AND ot.causal_id = ca.causal_id
     AND oa.order_activity_id = i.order_activity_id
     AND oa.package_id = pk.package_id
     AND pk.pos_oper_unit_id = ou.operating_unit_id
     -- Adicion paulaag
     --and mo.package_id = pk.package_id
     AND oa.subscription_id = su.susccodi
     AND su.susciddi = di.address_id
     AND di.geograp_location_id = lo.geograp_location_id
  GROUP BY lo.geo_loca_father_id
          ,lo.geograp_location_id
          ,ou.contractor_id;
          --,mo.product_type_id
-- Cursor ventas no legalizadas otros meses
CURSOR cuventnolegotrosmeses(nucano NUMBER,nucmes NUMBER) IS
  SELECT codigo_departamento
       ,codigo_localidad
       ,punto_venta
       ,NVL(SUM(VALOR),0) total_no_leg_otromes
       -- Adicion paulaag
       --, idservicio
   FROM(
        SELECT distinct(ll.non_ba_fi_requ_id)
              ,loc.geo_loca_father_id codigo_departamento
              ,loc.geograp_location_id codigo_localidad
              ,uu.contractor_id punto_venta
              ,nvl(ii.amount*ii.value,0) VALOR
              -- Adicion paulaag
              --,mo.product_type_id idservicio
          FROM open.ldc_ciercome ff
              ,open.or_order oo
              ,open.or_order_activity aa
              ,open.ld_item_work_order ii
              ,open.ld_non_ba_fi_requ ll
              ,open.suscripc ss,open.ab_address dd
              ,open.ge_geogra_location loc
              ,open.mo_packages pp
              ,open.or_operating_unit uu
              -- Adicion paulaag
              --,open.mo_motive mo
         WHERE ff.cicoano = nucano
           AND ff.cicomes = nucmes
           AND oo.task_type_id = 12590
           AND oo.order_status_id  NOT IN(8,12)
           AND ii.state <> 'AN'
           AND ll.sale_date NOT BETWEEN ff.cicofein AND ff.cicofech
           AND oo.order_id  = aa.order_id
           AND aa.order_activity_id = ii.order_activity_id
           AND aa.package_id = ll.non_ba_fi_requ_id
           AND ll.non_ba_fi_requ_id = pp.package_id
           -- Adicion paulaag
           --and mo.package_id = pp.package_id
           AND aa.subscription_id = ss.susccodi
           AND ss.susciddi = dd.address_id
           AND dd.geograp_location_id = loc.geograp_location_id
           AND ll.non_ba_fi_requ_id = pp.package_id
           AND pp.pos_oper_unit_id = uu.operating_unit_id)
 GROUP BY codigo_departamento
         ,codigo_localidad
         ,punto_venta;
         --, idservicio

-- Cursor Entregadas mes con Revisión de documentos Aprobada
 CURSOR cuentregadasrevdocapr(nucano NUMBER,nucmes NUMBER) IS
  SELECT  lo.geo_loca_father_id codigo_departamento
         ,lo.geograp_location_id localidad
         ,ou.contractor_id punto_venta
         ,NVL(sum((nvl(i.amount,0)*nvl(i.value,0))+nvl(i.iva,0)),0) total_legalizado
    FROM  open.ldc_ciercome ce
         ,open.or_order_activity oa
         ,open.or_order ot
         ,open.ge_causal ca
         ,open.ld_item_work_order i
         ,open.mo_packages pk
         ,open.or_operating_unit ou
         ,open.suscripc su
         ,open.ab_address di
         ,open.ge_geogra_location lo
   WHERE ce.cicoano = nucano
     AND ce.cicomes = nucmes
     AND oa.task_type_id = 12590
     AND ot.order_status_id = 8
     AND ca.class_causal_id = 1
     AND i.state <> 'AN'
     AND  nvl(pk.request_date,to_date('01/01/1900 00:00:00','dd/mm/yyyy hh24:mi:ss')) BETWEEN ce.cicofein AND ce.cicofech
     AND oa.order_id = ot.order_id
     AND ot.causal_id = ca.causal_id
     AND oa.order_activity_id = i.order_activity_id
     AND oa.package_id = pk.package_id
     AND pk.pos_oper_unit_id = ou.operating_unit_id
     AND oa.subscription_id = su.susccodi
     AND su.susciddi = di.address_id
     AND di.geograp_location_id = lo.geograp_location_id
	 and exists(select 'x'
			    from open.or_order_activity oa1,
					 open.or_order o1,
					 open.ge_causal ca1
				where oa1.package_id = oa.package_id
          and oa1.task_type_id = 10130
				  and oa1.order_id = o1.order_id
          and o1.order_status_id = 8
				  and o1.causal_id = ca1.causal_id
				  and ca1.class_causal_id = 1)
  GROUP BY lo.geo_loca_father_id
          ,lo.geograp_location_id
          ,ou.contractor_id;

-- Cursor Entregadas mes con Revisión de documentos Rechazada
 CURSOR cuentregadasrevdocrec(nucano NUMBER,nucmes NUMBER) IS
  SELECT  lo.geo_loca_father_id codigo_departamento
         ,lo.geograp_location_id localidad
         ,ou.contractor_id punto_venta
         ,NVL(sum((nvl(i.amount,0)*nvl(i.value,0))+nvl(i.iva,0)),0) total_legalizado
    FROM  open.ldc_ciercome ce
         ,open.or_order_activity oa
         ,open.or_order ot
         ,open.ge_causal ca
         ,open.ld_item_work_order i
         ,open.mo_packages pk
         ,open.or_operating_unit ou
         ,open.suscripc su
         ,open.ab_address di
         ,open.ge_geogra_location lo
   WHERE ce.cicoano = nucano
     AND ce.cicomes = nucmes
     AND oa.task_type_id = 12590
     AND ot.order_status_id = 8
     AND ca.class_causal_id = 1
     AND i.state <> 'AN'
     AND  nvl(pk.request_date,to_date('01/01/1900 00:00:00','dd/mm/yyyy hh24:mi:ss')) BETWEEN ce.cicofein AND ce.cicofech
     AND oa.order_id = ot.order_id
     AND ot.causal_id = ca.causal_id
     AND oa.order_activity_id = i.order_activity_id
     AND oa.package_id = pk.package_id
     AND pk.pos_oper_unit_id = ou.operating_unit_id
     AND oa.subscription_id = su.susccodi
     AND su.susciddi = di.address_id
     AND di.geograp_location_id = lo.geograp_location_id
	 and exists(select 'x'
			    from open.or_order_activity oa1,
					 open.or_order o1,
					 open.ge_causal ca1
				where oa1.package_id = oa.package_id
				  and oa1.task_type_id = 10130
				  and oa1.order_id = o1.order_id
				  and o1.order_status_id = 8
				  and o1.causal_id = ca1.causal_id
				  and ca1.class_causal_id = 2)
	 and not exists(select 'x'
          from open.or_order_activity oa1,
           open.or_order o1
        where oa1.package_id = oa.package_id
          and oa1.task_type_id = 10130
          and oa1.order_id = o1.order_id
          and o1.order_status_id in (0,5)
          )
     and not exists(select 'x'
          from open.or_order_activity oa1,
           open.or_order o1,
           open.ge_causal ca1
        where oa1.package_id = oa.package_id
          and oa1.task_type_id = 10130
          and oa1.order_id = o1.order_id
          and o1.order_status_id = 8
          and o1.causal_id = ca1.causal_id
          and ca1.class_causal_id = 1)
  GROUP BY lo.geo_loca_father_id
          ,lo.geograp_location_id
          ,ou.contractor_id;

-- Cursor Entregadas mes con Revisión de documentos Registrada
 CURSOR cuentregadasrevdocreg(nucano NUMBER,nucmes NUMBER) IS
  SELECT  lo.geo_loca_father_id codigo_departamento
         ,lo.geograp_location_id localidad
         ,ou.contractor_id punto_venta
         ,NVL(sum((nvl(i.amount,0)*nvl(i.value,0))+nvl(i.iva,0)),0) total_legalizado
    FROM  open.ldc_ciercome ce
         ,open.or_order_activity oa
         ,open.or_order ot
         ,open.ge_causal ca
         ,open.ld_item_work_order i
         ,open.mo_packages pk
         ,open.or_operating_unit ou
         ,open.suscripc su
         ,open.ab_address di
         ,open.ge_geogra_location lo
   WHERE ce.cicoano = nucano
     AND ce.cicomes = nucmes
     AND oa.task_type_id = 12590
     AND ot.order_status_id = 8
     AND ca.class_causal_id = 1
     AND i.state <> 'AN'
     AND  nvl(pk.request_date,to_date('01/01/1900 00:00:00','dd/mm/yyyy hh24:mi:ss')) BETWEEN ce.cicofein AND ce.cicofech
     AND oa.order_id = ot.order_id
     AND ot.causal_id = ca.causal_id
     AND oa.order_activity_id = i.order_activity_id
     AND oa.package_id = pk.package_id
     AND pk.pos_oper_unit_id = ou.operating_unit_id
     AND oa.subscription_id = su.susccodi
     AND su.susciddi = di.address_id
     AND di.geograp_location_id = lo.geograp_location_id
	 and exists(select 'x'
			    from open.or_order_activity oa1,
					 open.or_order o1
				where oa1.package_id = oa.package_id
          and oa1.task_type_id = 10130
				  and oa1.order_id = o1.order_id
				  and o1.order_status_id = 0)
  GROUP BY lo.geo_loca_father_id
          ,lo.geograp_location_id
          ,ou.contractor_id;

-- Cursor Entregadas mes con Revisión de documentos Asignada
 CURSOR cuentregadasrevdocasi(nucano NUMBER,nucmes NUMBER) IS
  SELECT  lo.geo_loca_father_id codigo_departamento
         ,lo.geograp_location_id localidad
         ,ou.contractor_id punto_venta
         ,NVL(sum((nvl(i.amount,0)*nvl(i.value,0))+nvl(i.iva,0)),0) total_legalizado
    FROM  open.ldc_ciercome ce
         ,open.or_order_activity oa
         ,open.or_order ot
         ,open.ge_causal ca
         ,open.ld_item_work_order i
         ,open.mo_packages pk
         ,open.or_operating_unit ou
         ,open.suscripc su
         ,open.ab_address di
         ,open.ge_geogra_location lo
   WHERE ce.cicoano = nucano
     AND ce.cicomes = nucmes
     AND oa.task_type_id = 12590
     AND ot.order_status_id = 8
     AND ca.class_causal_id = 1
     AND i.state <> 'AN'
     AND  nvl(pk.request_date,to_date('01/01/1900 00:00:00','dd/mm/yyyy hh24:mi:ss')) BETWEEN ce.cicofein AND ce.cicofech
     AND oa.order_id = ot.order_id
     AND ot.causal_id = ca.causal_id
     AND oa.order_activity_id = i.order_activity_id
     AND oa.package_id = pk.package_id
     AND pk.pos_oper_unit_id = ou.operating_unit_id
     AND oa.subscription_id = su.susccodi
     AND su.susciddi = di.address_id
     AND di.geograp_location_id = lo.geograp_location_id
	 and exists(select 'x'
			    from open.or_order_activity oa1,
					 open.or_order o1
				where oa1.package_id = oa.package_id
          and oa1.task_type_id = 10130
				  and oa1.order_id = o1.order_id
				  and o1.order_status_id = 5)
  GROUP BY lo.geo_loca_father_id
          ,lo.geograp_location_id
          ,ou.contractor_id;

-- Cursor Ventas Registradas mes Aprobadas sin Entregar
 CURSOR cuaprobadasnoentregadas(nucano NUMBER,nucmes NUMBER) IS
  SELECT  lo.geo_loca_father_id codigo_departamento
         ,lo.geograp_location_id localidad
         ,ou.contractor_id punto_venta
         ,NVL(sum((nvl(i.amount,0)*nvl(i.value,0))+nvl(i.iva,0)),0) total_legalizado
    FROM  open.ldc_ciercome ce
         ,open.or_order_activity oa
         ,open.or_order ot
         ,open.ld_item_work_order i
         ,open.mo_packages pk
         ,open.or_operating_unit ou
         ,open.suscripc su
         ,open.ab_address di
         ,open.ge_geogra_location lo
   WHERE ce.cicoano = nucano
     AND ce.cicomes = nucmes
     AND oa.task_type_id = 12590
     AND ot.order_status_id = 5
     AND i.state <> 'AN'
     AND  nvl(pk.request_date,to_date('01/01/1900 00:00:00','dd/mm/yyyy hh24:mi:ss')) BETWEEN ce.cicofein AND ce.cicofech
     AND oa.order_id = ot.order_id
     AND oa.order_activity_id = i.order_activity_id
     AND oa.package_id = pk.package_id
     AND pk.pos_oper_unit_id = ou.operating_unit_id
     AND oa.subscription_id = su.susccodi
     AND su.susciddi = di.address_id
     AND di.geograp_location_id = lo.geograp_location_id
   and exists(select 'x'
          from open.or_order_activity oa1,
           open.or_order o1,
           open.ge_causal ca
        where oa1.package_id = oa.package_id
          and oa1.task_type_id = 10130
          and oa1.order_id = o1.order_id
          AND o1.causal_id = ca.causal_id
          and o1.order_status_id = 8
          AND ca.class_causal_id = 1)
   and not exists(select 'x'
          from open.or_order_activity oa1,
           open.or_order o1,
           open.ld_item_work_order i
        where oa1.package_id = oa.package_id
          and oa1.task_type_id = 12590
          and oa1.order_activity_id = i.order_activity_id
          and oa1.order_id = o1.order_id
          and o1.order_status_id <> 5)
  GROUP BY lo.geo_loca_father_id
          ,lo.geograp_location_id
          ,ou.contractor_id;

 nuobjetivo open.ldc_budgetbyprovider.budget_value%TYPE;
 nucontareg NUMBER(13,2);
 /**************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : GetnuObjetivo
      Descripcion    : Obtiene el valor objetivo
      Autor          : paulaag
      Fecha          : 30/10/2014

      Parametros              Descripcion
      ============         ===================
      inuanio               A?o
      inumes                Mes
      inudepto              Identificador del departamento
      inulocalida           Identificador de la localidad
      inuptoventa           Identificador del punto de venta

      Fecha             Autor             Modificacion
      =========       =========           ====================
      30/10/2014        paulaag             Creacion
    ******************************************************************/
    function fnuGetObjetivo(inuanio      number,
                            inumes       number,
                            inudepto     number,
                            inulocalida  number,
                            inuptoventa  number)
                            --inuservicio  number
    return number
    is
        onuObjetivo number:=0;
        nuConfigLocaNULO number:=0;
        nuConfigLocaOk  number :=0;
    begin

       /* ut_trace.init;
        ut_trace.setlevel(99);
        ut_trace.setoutput(ut_trace.fntrace_output_db);
        */

        -- Si existe una configuracion con la localidad enviada, entonces tome el valor de la configuracion
        --SELECT NVL(SUM(pr.budget_value),0) INTO onuObjetivo
        begin
            SELECT NVL(SUM(pr.budget_value),0) INTO onuObjetivo
            FROM open.ldc_budgetbyprovider pr
            WHERE pr.budget_year = inuanio
                AND pr.budget_month = inumes
                AND pr.dept_id = inudepto
                AND pr.location_id = inulocalida
                AND pr.provider_id = inuptoventa;
                --and pr.component_id = inuservicio -- La referencia del component_id apunta a SERVICIO
        exception
            when others then
            onuObjetivo :=0;
        end ;

        if onuObjetivo != 0 then
            return onuObjetivo;
        end if;
      --  SAO 310957 LJL  -- se quita buscar objetivo por departamento porque esto se manejara en reporte
      /*  -- Si existe configuracion sin localidad, aplique el valor configurado a la config.
        if onuObjetivo = 0 then
            select NVL(SUM(pr.budget_value),0) into onuObjetivo
            from open.ldc_budgetbyprovider pr
            where pr.budget_year = inuanio
                    AND pr.budget_month = inumes
                    AND pr.dept_id = inudepto
                    AND pr.provider_id = inuptoventa
                    and pr.location_id is null;
                    --and pr.component_id = inuservicio  -- La referencia del component_id apunta a SERVICIO;

            return onuObjetivo;
        end if;*/
          return onuObjetivo;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            rollback;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            rollback;
            raise ex.CONTROLLED_ERROR;
    end fnuGetObjetivo;
    ----------------------------------------------------------------------------
BEGIN

    /*ut_trace.init;
    ut_trace.setlevel(99);
    ut_trace.setoutput(ut_trace.fntrace_output_db);*/

    nuok := 0;
    sberror := NULL;
    nucontareg := 0;

    DELETE ldc_osf_estad_ventas_brilla l WHERE l.ano = nupano AND l.mes = nupmes;
    COMMIT;

    ut_trace.trace('LDRVEMEMET INICIO',2);

    -- Ventas brilla recibidas en el mes
    FOR i IN cuventasrecibidasmes(nupano,nupmes) LOOP
        BEGIN
            /*ut_trace.trace('LDRVEMEMET fnuGetObjetivo1 '||
                            '1:nupano'||nupano||
                            '-mes:'||nupmes||
                            '-i.codigo_departamento:'||i.codigo_departamento||
                            '-i.localidad:'||i.localidad||
                            '-i.punto_venta:'||i.punto_venta,2);*/

            --nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta, i.idservicio);
            nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta);

            --ut_trace.trace('LDRVEMEMET nuobjetivo1:'||nuobjetivo,2);

        /*SELECT NVL(SUM(pr.budget_value),0) INTO nuobjetivo
          FROM open.ldc_budgetbyprovider pr
         WHERE pr.budget_year = nupano
           AND pr.budget_month = nupmes
           AND pr.dept_id = i.codigo_departamento
           AND pr.location_id = i.localidad
           AND pr.provider_id = i.punto_venta;*/


        EXCEPTION
        --WHEN no_data_found THEN
            when others then
                nuobjetivo := 0;
                --ut_trace.trace('LDRVEMEMET nuobjetivo when others',2);
        END;

        INSERT INTO ldc_osf_estad_ventas_brilla
                                            (
                                              ano
                                             ,mes
                                             ,cod_departamento
                                             ,cod_localidad
                                             ,vendedor
                                             ,objetivo
                                             ,total_recibido
                                             ,total_recibidos_sin_anuladas
                                             ,total_legalizado
                                             ,total_no_leg_mes
                                             ,total_no_leg_o_mes
                                             )
                                       VALUES
                                             (
                                              nupano
                                             ,nupmes
                                             ,i.codigo_departamento
                                             ,i.localidad
                                             ,i.punto_venta
                                             ,nuobjetivo
                                             ,nvl(i.valor_recibido,0)
                                             ,nvl(i.total_articulos,0)
                                             ,0
                                             ,nvl(i.total_no_lega_mes,0)
                                             ,0
                                             );
        nucontareg := nucontareg + 1;
        COMMIT;
    END LOOP;

    -- Ventas legalizadas en el mes
    FOR i IN cuventaslegalizadas(nupano,nupmes) LOOP
        UPDATE ldc_osf_estad_ventas_brilla l
        SET l.total_legalizado = nvl(i.total_legalizado,0)
        WHERE l.ano = nupano
        AND l.mes = nupmes
        AND l.cod_departamento = i.codigo_departamento
        AND l.cod_localidad = i.localidad
        AND l.vendedor = i.punto_venta;

        IF SQL%NOTFOUND THEN

            BEGIN
                /*ut_trace.trace('LDRVEMEMET fnuGetObjetivo2 '||
                            '1:nupano'||nupano||
                            '-mes:'||nupmes||
                            '-i.codigo_departamento:'||i.codigo_departamento||
                            '-i.localidad:'||i.localidad||
                            '-i.punto_venta:'||i.punto_venta,2);*/

                --nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta, i.idservicio);
                nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta);

                --ut_trace.trace('LDRVEMEMET nuobjetivo2:'||nuobjetivo,2);

                /*SELECT NVL(SUM(pr.budget_value),0) INTO nuobjetivo
                  FROM open.ldc_budgetbyprovider pr
                 WHERE pr.budget_year = nupano
                   AND pr.budget_month = nupmes
                   AND pr.dept_id = i.codigo_departamento
                   AND pr.location_id = i.localidad
                   AND pr.provider_id = i.punto_venta;*/

            EXCEPTION
                --WHEN no_data_found THEN
                when others then
                    nuobjetivo := 0;
                    --ut_trace.trace('LDRVEMEMET others2',2);
            END;

            INSERT INTO ldc_osf_estad_ventas_brilla
                                                  (
                                                    ano
                                                   ,mes
                                                   ,cod_departamento
                                                   ,cod_localidad
                                                   ,vendedor
                                                   ,objetivo
                                                   ,total_recibido
                                                   ,total_recibidos_sin_anuladas
                                                   ,total_legalizado
                                                   ,total_no_leg_mes
                                                   ,total_no_leg_o_mes
                                                   )
                                             VALUES
                                                   (
                                                    nupano
                                                   ,nupmes
                                                   ,i.codigo_departamento
                                                   ,i.localidad
                                                   ,i.punto_venta
                                                   ,nuobjetivo
                                                   ,0
                                                   ,0
                                                   ,nvl(i.total_legalizado,0)
                                                   ,0
                                                   ,0
                                                   );
            nucontareg := nucontareg + 1;
        END IF;
        COMMIT;
    END LOOP;

    -- Ventas no entregadas cuyas ventas fueron recibidas en otros meses diferente al evaluado
    FOR i IN cuventnolegotrosmeses(nupano,nupmes) LOOP
        UPDATE ldc_osf_estad_ventas_brilla l
        SET l.total_no_leg_o_mes = nvl(i.total_no_leg_otromes,0)
        WHERE l.ano = nupano
        AND l.mes = nupmes
        AND l.cod_departamento = i.codigo_departamento
        AND l.cod_localidad = i.codigo_localidad
        AND l.vendedor = i.punto_venta;

        IF SQL%NOTFOUND THEN
            BEGIN
                /*ut_trace.trace('LDRVEMEMET fnuGetObjetivo3 '||
                                '1:nupano'||nupano||
                                '-mes:'||nupmes||
                                '-i.codigo_departamento:'||i.codigo_departamento||
                                '-i.codigo_localidad:'||i.codigo_localidad||
                                '-i.punto_venta:'||i.punto_venta,2);*/

                --nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.codigo_localidad, i.punto_venta, i.idservicio);
                nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.codigo_localidad, i.punto_venta);

                --ut_trace.trace('LDRVEMEMET nuobjetivo3:'||nuobjetivo,2);

                /*SELECT NVL(SUM(pr.budget_value),0) INTO nuobjetivo
                FROM open.ldc_budgetbyprovider pr
                WHERE pr.budget_year = nupano
                AND pr.budget_month = nupmes
                AND pr.dept_id = i.codigo_departamento
                AND pr.location_id = i.codigo_localidad
                AND pr.provider_id = i.punto_venta;*/

            EXCEPTION
                --WHEN no_data_found THEN
                when others then
                    nuobjetivo := 0;
            END;

            INSERT INTO ldc_osf_estad_ventas_brilla
                                                  (
                                                    ano
                                                   ,mes
                                                   ,cod_departamento
                                                   ,cod_localidad
                                                   ,vendedor
                                                   ,objetivo
                                                   ,total_recibido
                                                   ,total_recibidos_sin_anuladas
                                                   ,total_legalizado
                                                   ,total_no_leg_mes
                                                   ,total_no_leg_o_mes
                                                   )
                                             VALUES
                                                   (
                                                    nupano
                                                   ,nupmes
                                                   ,i.codigo_departamento
                                                   ,i.codigo_localidad
                                                   ,i.punto_venta
                                                   ,nuobjetivo
                                                   ,0
                                                   ,0
                                                   ,0
                                                   ,0
                                                   ,nvl(i.total_no_leg_otromes,0)
                                                   );
            nucontareg := nucontareg + 1;
        END IF;
        COMMIT;
    END LOOP;

    -- Entregadas mes con Revisión de documentos Aprobada
    FOR i IN cuentregadasrevdocapr(nupano,nupmes) LOOP
        UPDATE ldc_osf_estad_ventas_brilla l
        SET l.entreg_mes_rev_doc_apro = nvl(i.total_legalizado,0)
        WHERE l.ano = nupano
        AND l.mes = nupmes
        AND l.cod_departamento = i.codigo_departamento
        AND l.cod_localidad = i.localidad
        AND l.vendedor = i.punto_venta;

        IF SQL%NOTFOUND THEN

            BEGIN
                /*ut_trace.trace('LDRVEMEMET fnuGetObjetivo2 '||
                            '1:nupano'||nupano||
                            '-mes:'||nupmes||
                            '-i.codigo_departamento:'||i.codigo_departamento||
                            '-i.localidad:'||i.localidad||
                            '-i.punto_venta:'||i.punto_venta,2);*/

                --nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta, i.idservicio);
                nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta);

                --ut_trace.trace('LDRVEMEMET nuobjetivo2:'||nuobjetivo,2);

                /*SELECT NVL(SUM(pr.budget_value),0) INTO nuobjetivo
                  FROM open.ldc_budgetbyprovider pr
                 WHERE pr.budget_year = nupano
                   AND pr.budget_month = nupmes
                   AND pr.dept_id = i.codigo_departamento
                   AND pr.location_id = i.localidad
                   AND pr.provider_id = i.punto_venta;*/

            EXCEPTION
                --WHEN no_data_found THEN
                when others then
                    nuobjetivo := 0;
                    --ut_trace.trace('LDRVEMEMET others2',2);
            END;

            INSERT INTO ldc_osf_estad_ventas_brilla
                                                  (
                                                    ano
                                                   ,mes
                                                   ,cod_departamento
                                                   ,cod_localidad
                                                   ,vendedor
                                                   ,objetivo
                                                   ,total_recibido
                                                   ,total_recibidos_sin_anuladas
                                                   ,entreg_mes_rev_doc_apro
                                                   ,total_no_leg_mes
                                                   ,total_no_leg_o_mes
                                                   )
                                             VALUES
                                                   (
                                                    nupano
                                                   ,nupmes
                                                   ,i.codigo_departamento
                                                   ,i.localidad
                                                   ,i.punto_venta
                                                   ,nuobjetivo
                                                   ,0
                                                   ,0
                                                   ,nvl(i.total_legalizado,0)
                                                   ,0
                                                   ,0
                                                   );
            nucontareg := nucontareg + 1;
        END IF;
        COMMIT;
    END LOOP;

    -- Entregadas mes con Revisión de documentos Rechazada
    FOR i IN cuentregadasrevdocrec(nupano,nupmes) LOOP
        UPDATE ldc_osf_estad_ventas_brilla l
        SET l.entreg_mes_rev_doc_rech = nvl(i.total_legalizado,0)
        WHERE l.ano = nupano
        AND l.mes = nupmes
        AND l.cod_departamento = i.codigo_departamento
        AND l.cod_localidad = i.localidad
        AND l.vendedor = i.punto_venta;

        IF SQL%NOTFOUND THEN

            BEGIN
                /*ut_trace.trace('LDRVEMEMET fnuGetObjetivo2 '||
                            '1:nupano'||nupano||
                            '-mes:'||nupmes||
                            '-i.codigo_departamento:'||i.codigo_departamento||
                            '-i.localidad:'||i.localidad||
                            '-i.punto_venta:'||i.punto_venta,2);*/

                --nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta, i.idservicio);
                nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta);

                --ut_trace.trace('LDRVEMEMET nuobjetivo2:'||nuobjetivo,2);

                /*SELECT NVL(SUM(pr.budget_value),0) INTO nuobjetivo
                  FROM open.ldc_budgetbyprovider pr
                 WHERE pr.budget_year = nupano
                   AND pr.budget_month = nupmes
                   AND pr.dept_id = i.codigo_departamento
                   AND pr.location_id = i.localidad
                   AND pr.provider_id = i.punto_venta;*/

            EXCEPTION
                --WHEN no_data_found THEN
                when others then
                    nuobjetivo := 0;
                    --ut_trace.trace('LDRVEMEMET others2',2);
            END;

            INSERT INTO ldc_osf_estad_ventas_brilla
                                                  (
                                                    ano
                                                   ,mes
                                                   ,cod_departamento
                                                   ,cod_localidad
                                                   ,vendedor
                                                   ,objetivo
                                                   ,total_recibido
                                                   ,total_recibidos_sin_anuladas
                                                   ,entreg_mes_rev_doc_rech
                                                   ,total_no_leg_mes
                                                   ,total_no_leg_o_mes
                                                   )
                                             VALUES
                                                   (
                                                    nupano
                                                   ,nupmes
                                                   ,i.codigo_departamento
                                                   ,i.localidad
                                                   ,i.punto_venta
                                                   ,nuobjetivo
                                                   ,0
                                                   ,0
                                                   ,nvl(i.total_legalizado,0)
                                                   ,0
                                                   ,0
                                                   );
            nucontareg := nucontareg + 1;
        END IF;
        COMMIT;
    END LOOP;


    -- Entregadas mes con Revisión de documentos Registrada
    FOR i IN cuentregadasrevdocreg(nupano,nupmes) LOOP
        UPDATE ldc_osf_estad_ventas_brilla l
        SET l.entreg_mes_rev_doc_regi = nvl(i.total_legalizado,0)
        WHERE l.ano = nupano
        AND l.mes = nupmes
        AND l.cod_departamento = i.codigo_departamento
        AND l.cod_localidad = i.localidad
        AND l.vendedor = i.punto_venta;

        IF SQL%NOTFOUND THEN

            BEGIN
                /*ut_trace.trace('LDRVEMEMET fnuGetObjetivo2 '||
                            '1:nupano'||nupano||
                            '-mes:'||nupmes||
                            '-i.codigo_departamento:'||i.codigo_departamento||
                            '-i.localidad:'||i.localidad||
                            '-i.punto_venta:'||i.punto_venta,2);*/

                --nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta, i.idservicio);
                nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta);

                --ut_trace.trace('LDRVEMEMET nuobjetivo2:'||nuobjetivo,2);

                /*SELECT NVL(SUM(pr.budget_value),0) INTO nuobjetivo
                  FROM open.ldc_budgetbyprovider pr
                 WHERE pr.budget_year = nupano
                   AND pr.budget_month = nupmes
                   AND pr.dept_id = i.codigo_departamento
                   AND pr.location_id = i.localidad
                   AND pr.provider_id = i.punto_venta;*/

            EXCEPTION
                --WHEN no_data_found THEN
                when others then
                    nuobjetivo := 0;
                    --ut_trace.trace('LDRVEMEMET others2',2);
            END;

            INSERT INTO ldc_osf_estad_ventas_brilla
                                                  (
                                                    ano
                                                   ,mes
                                                   ,cod_departamento
                                                   ,cod_localidad
                                                   ,vendedor
                                                   ,objetivo
                                                   ,total_recibido
                                                   ,total_recibidos_sin_anuladas
                                                   ,entreg_mes_rev_doc_regi
                                                   ,total_no_leg_mes
                                                   ,total_no_leg_o_mes
                                                   )
                                             VALUES
                                                   (
                                                    nupano
                                                   ,nupmes
                                                   ,i.codigo_departamento
                                                   ,i.localidad
                                                   ,i.punto_venta
                                                   ,nuobjetivo
                                                   ,0
                                                   ,0
                                                   ,nvl(i.total_legalizado,0)
                                                   ,0
                                                   ,0
                                                   );
            nucontareg := nucontareg + 1;
        END IF;
        COMMIT;
    END LOOP;

    -- Entregadas mes con Revisión de documentos Asignada
    FOR i IN cuentregadasrevdocasi(nupano,nupmes) LOOP
        UPDATE ldc_osf_estad_ventas_brilla l
        SET l.entreg_mes_rev_doc_asig = nvl(i.total_legalizado,0)
        WHERE l.ano = nupano
        AND l.mes = nupmes
        AND l.cod_departamento = i.codigo_departamento
        AND l.cod_localidad = i.localidad
        AND l.vendedor = i.punto_venta;

        IF SQL%NOTFOUND THEN

            BEGIN
                /*ut_trace.trace('LDRVEMEMET fnuGetObjetivo2 '||
                            '1:nupano'||nupano||
                            '-mes:'||nupmes||
                            '-i.codigo_departamento:'||i.codigo_departamento||
                            '-i.localidad:'||i.localidad||
                            '-i.punto_venta:'||i.punto_venta,2);*/

                --nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta, i.idservicio);
                nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta);

                --ut_trace.trace('LDRVEMEMET nuobjetivo2:'||nuobjetivo,2);

                /*SELECT NVL(SUM(pr.budget_value),0) INTO nuobjetivo
                  FROM open.ldc_budgetbyprovider pr
                 WHERE pr.budget_year = nupano
                   AND pr.budget_month = nupmes
                   AND pr.dept_id = i.codigo_departamento
                   AND pr.location_id = i.localidad
                   AND pr.provider_id = i.punto_venta;*/

            EXCEPTION
                --WHEN no_data_found THEN
                when others then
                    nuobjetivo := 0;
                    --ut_trace.trace('LDRVEMEMET others2',2);
            END;

            INSERT INTO ldc_osf_estad_ventas_brilla
                                                  (
                                                    ano
                                                   ,mes
                                                   ,cod_departamento
                                                   ,cod_localidad
                                                   ,vendedor
                                                   ,objetivo
                                                   ,total_recibido
                                                   ,total_recibidos_sin_anuladas
                                                   ,entreg_mes_rev_doc_asig
                                                   ,total_no_leg_mes
                                                   ,total_no_leg_o_mes
                                                   )
                                             VALUES
                                                   (
                                                    nupano
                                                   ,nupmes
                                                   ,i.codigo_departamento
                                                   ,i.localidad
                                                   ,i.punto_venta
                                                   ,nuobjetivo
                                                   ,0
                                                   ,0
                                                   ,nvl(i.total_legalizado,0)
                                                   ,0
                                                   ,0
                                                   );
            nucontareg := nucontareg + 1;
        END IF;
        COMMIT;
    END LOOP;

    -- Ventas Registradas mes Aprobadas sin Entregar
    FOR i IN cuaprobadasnoentregadas(nupano,nupmes) LOOP
        UPDATE ldc_osf_estad_ventas_brilla l
        SET l.vta_reg_mes_no_entreg = nvl(i.total_legalizado,0)
        WHERE l.ano = nupano
        AND l.mes = nupmes
        AND l.cod_departamento = i.codigo_departamento
        AND l.cod_localidad = i.localidad
        AND l.vendedor = i.punto_venta;

        IF SQL%NOTFOUND THEN

            BEGIN
                /*ut_trace.trace('LDRVEMEMET fnuGetObjetivo2 '||
                            '1:nupano'||nupano||
                            '-mes:'||nupmes||
                            '-i.codigo_departamento:'||i.codigo_departamento||
                            '-i.localidad:'||i.localidad||
                            '-i.punto_venta:'||i.punto_venta,2);*/

                --nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta, i.idservicio);
                nuobjetivo := fnuGetObjetivo(nupano, nupmes, i.codigo_departamento, i.localidad, i.punto_venta);

                --ut_trace.trace('LDRVEMEMET nuobjetivo2:'||nuobjetivo,2);

                /*SELECT NVL(SUM(pr.budget_value),0) INTO nuobjetivo
                  FROM open.ldc_budgetbyprovider pr
                 WHERE pr.budget_year = nupano
                   AND pr.budget_month = nupmes
                   AND pr.dept_id = i.codigo_departamento
                   AND pr.location_id = i.localidad
                   AND pr.provider_id = i.punto_venta;*/

            EXCEPTION
                --WHEN no_data_found THEN
                when others then
                    nuobjetivo := 0;
                    --ut_trace.trace('LDRVEMEMET others2',2);
            END;

            INSERT INTO ldc_osf_estad_ventas_brilla
                                                  (
                                                    ano
                                                   ,mes
                                                   ,cod_departamento
                                                   ,cod_localidad
                                                   ,vendedor
                                                   ,objetivo
                                                   ,total_recibido
                                                   ,total_recibidos_sin_anuladas
                                                   ,vta_reg_mes_no_entreg
                                                   ,total_no_leg_mes
                                                   ,total_no_leg_o_mes
                                                   )
                                             VALUES
                                                   (
                                                    nupano
                                                   ,nupmes
                                                   ,i.codigo_departamento
                                                   ,i.localidad
                                                   ,i.punto_venta
                                                   ,nuobjetivo
                                                   ,0
                                                   ,0
                                                   ,nvl(i.total_legalizado,0)
                                                   ,0
                                                   ,0
                                                   );
            nucontareg := nucontareg + 1;
        END IF;
        COMMIT;
    END LOOP;


    COMMIT;

    nuok := 0;
    sberror := 'Proceso termino Ok : se procesaron '||nucontareg||' registros.';
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    nuok:=-1;
    sberror :='Error en ldc_prollestadisticasbrilla: '||sqlerrm;
END;
/
