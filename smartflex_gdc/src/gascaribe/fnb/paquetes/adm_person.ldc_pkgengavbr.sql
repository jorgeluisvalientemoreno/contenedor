CREATE OR REPLACE PACKAGE adm_person.ldc_pkgengavbr AS

 /*****************************************************************
  Propiedad intelectual de Gascaribe (c).

  Unidad         : ldc_pkGenGaVBr
  Descripcion    : Paquete para el PB LDGAVBR el cual se usara para el
                   reporte LDRGAVBR (CA_200-54)

  Autor          : F.Castro
  Fecha          : 26/06/2016 ERS 200-54

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================
  26/06/2024    Adrianavg               OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
  ******************************************************************/

  ------------------
  -- Constantes
  ------------------


  -----------------------
  -- Variables
  -----------------------



  -----------------------
  -- Elementos Packages
  -----------------------
  PROCEDURE gengavbr (inuproductype in LDC_GAVBR.Tipo_Producto%TYPE,
                                               inuano in LDC_GAVBR.Ano%TYPE,
                                               inumes in LDC_GAVBR.Mes%TYPE);


  PROCEDURE GenDatos (inuserv pr_product.product_type_id%type,
                    idtfecha date);

  procedure GenDatosHilos (inuano ldc_osf_sesucier.nuano%type,
                         inumes ldc_osf_sesucier.numes%type,
                         inuserv pr_product.product_type_id%type,
                         idtfecha date,
                         idttoday date,
                         innuNroHilo number,
                         innuTotHilos number,
                         innusesion number);

 function fnuGetSaldoDife (inudife diferido.difecodi%type,
                          idtfecha date) return number ;

 procedure pro_grabalog (inusesion number, idtfecha date, inuhilo number,
                        inuresult number, isbobse varchar2);

END ldc_pkGenGaVBr;
/
CREATE OR REPLACE package body adm_person.ldc_pkGenGaVBr AS
 /*****************************************************************
  Propiedad intelectual de Gascaribe (c).

  Unidad         : ldc_pkGenGaVBr
  Descripcion    : Paquete para el PB LDGAVBR el cual se usara para el
                   reporte LDRGAVBR (CA_200-54)

  Autor          : F.Castro
  Fecha          : 26/06/2016 ERS 200-54

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================

  ******************************************************************/

    ------------------
    -- Tipos de Datos
    ------------------


    -- Variables
    -----------------------

--********************************************************************************************

PROCEDURE gengavbr (inuproductype in LDC_GAVBR.Tipo_Producto%TYPE,
                                               inuano in LDC_GAVBR.Ano%TYPE,
                                               inumes in LDC_GAVBR.Mes%TYPE) IS
   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ldcandm
  Descripcion    : Procedimiento llamado por el PB
  Autor          : F.Castro
  Fecha          : 02/04/2016 ERS 200-206

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================

  ******************************************************************/

  sbPRODUCT_TYPE NUMBER;
  sbAno NUMBER;
  sbMes NUMBER;
  dtFechaCierre date;

 cursor cuCierre  is
  SELECT trunc(cicofech)
    FROM open.ldc_ciercome c
  where cicoano = sbAno
    and cicomes = sbMes;

BEGIN

  UT_TRACE.TRACE('**************** Inicio ldc_pkGenGaVBr.gengavbr', 10);

  sbPRODUCT_TYPE := inuproductype;
  sbAno := inuano;
  sbMes := inumes;


  if (sbPRODUCT_TYPE is null or sbAno is null or sbMes is null) then
    Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                    'Tipo Producto, A?o y Mes no deben ser nulos');
    raise ex.CONTROLLED_ERROR;
  end if;

  if (sbAno < 2015) then
    Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                    'A?o debe ser superior al 2014');
    raise ex.CONTROLLED_ERROR;
  end if;

  if (sbMes < 1 or sbMes > 12) then
    Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                    'Mes debe estar entre 1 y 12');
    raise ex.CONTROLLED_ERROR;
  end if;

  open cuCierre;
  fetch cuCierre into dtFechaCierre;
  if cuCierre%notfound then
    dtFechaCierre := null;
  end if;
  close cuCierre;

  if dtFechaCierre is null then
     Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                    'No hay una fecha de cierre para el A?o/Mes dado');
    raise ex.CONTROLLED_ERROR;
  end if;

-- borra los datos si se va a generar de nuevo el proceso
 delete from LDC_GAVBR l
   where l.ano = sbAno
     and l.mes = sbMes
     and l.tipo_producto = sbPRODUCT_TYPE;
 commit;

 GenDatos(sbPRODUCT_TYPE,dtFechaCierre);


  UT_TRACE.TRACE('**************** Fin ldc_pkGenGaVBr.gengavbr', 10);

END gengavbr;

--********************************************************************************************
PROCEDURE GenDatos (inuserv pr_product.product_type_id%type,
                    idtfecha date) IS

 dtToday                date := sysdate;
 nuHilosComision        number;
 nuTotReg               number;
 nuFinJobs              number(1);
 nuCont                 number;
 nusesion               number;
 nuresult               number(5);
 nuano                  number(4);
 numes                  number(2);

 cursor cuCierre is
   select count(1)
     from ldc_osf_sesucier s
    where s.nuano = nuano
      and s.numes = numes
      and s.tipo_producto = inuserv;

 cursor cuJobs (nuInd number) is
 select resultado
   from LDC_LOG_LDRGAVBR
  where sesion = nusesion
    and fecha_inicio = dtToday
    and hilo = nuind
    AND resultado in (-1,2); -- -1 Termino con errores, 2 termino OK


    nujob         number;
    sbWhat        varchar2(4000);

begin
  ut_trace.trace('Inicio ldc_pkGenGaVBr.GenDatos', 10);

  nuano := to_char(idtfecha,'YYYY');
  numes := to_char(idtfecha,'MM') ;

  nuHilosComision := dald_parameter.fnuGetNumeric_Value('LDRGAVBR_HILOS');
  select userenv('SESSIONID') into nusesion from dual;

    -- se halla el total de registros a procesar
    open cuCierre;
    fetch cuCierre into nuTotReg;
    if nuTotReg is null then
      nuTotReg := -1;
    end if;
    close cuCierre;

  if nuTotReg > 0 then
    -- Si el numero de regs a procesar es menor o igual al Nro de hilos, se ejecutara en uno solo
     if nuTotReg <= nuHilosComision then
       nuHilosComision := 1;
     end if;

    -- se crean los jobs y se ejecutan
    for rgJob in 1 .. nuHilosComision loop
          sbWhat := 'BEGIN'                                           || chr(10) ||
            '   SetSystemEnviroment;'                         || chr(10) ||
            '   ldc_pkGenGaVBr.GenDatosHilos(' || nuano   || ',' || chr(10) ||
            '                                ' || numes   || ',' || chr(10) ||
            '                                ' || inuserv || ',' || chr(10) ||
            '                                to_date(''' ||to_char(idtfecha,'DD/MM/YYYY  HH24:MI:SS')||'''),' || chr(10) ||
            '                                to_date(''' ||to_char(dtToday,'DD/MM/YYYY  HH24:MI:SS')||'''),' || chr(10) ||
            '                                ' || rgJob || ',' || chr(10) ||
            '                                ' || nuHilosComision || ',' || chr(10) ||
            '                                ' || nusesion || ');' || chr(10) ||
            'END;';
        dbms_job.submit (nujob,
                         sbWhat,
                         sysdate + 1/3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;
     end loop;

    -- se verifica si terminaron los jobs
    nuFinJobs := 0;
    while nuFinJobs = 0 loop
      nucont    := 0;
      for i in 1 .. nuHilosComision loop
        open cujobs (i);
        fetch cujobs into nuresult;
        if cujobs%found then
            nucont := nucont + 1;
         end if;
         close cujobs;
       end loop;
       if nucont = nuHilosComision then
         nuFinJobs := 1;
       else
         DBMS_LOCK.SLEEP(60);
       end if;
     end loop;

    pro_grabalog (nusesion, dtToday, 0, 0, 'Terminaron todos los hilos');



    ut_trace.trace('Fin ldc_pkGenGaVBr.GenDatos', 10);


  else
    pro_grabalog (nusesion, dtToday, 0, 0, 'ldc_pkGenGaVBr.GenDatos con cero registros a procesar');
    ut_trace.trace('ldc_pkGenGaVBr.GenDatos con cero registros a procesar', 10);
  end if;

  exception
    WHEN ex.CONTROLLED_ERROR then
      pro_grabalog (nusesion, dtToday, 0, 0, 'Error: ' || sqlerrm);
      rollback;
      raise;
    When others then
      pro_grabalog (nusesion, dtToday, 0, 0, 'Error: ' || sqlerrm);
      rollback;
      gw_boerrors.checkerror(SQLCODE, SQLERRM);


END GenDatos;

/*************************************************************************************************/
function fnuGetSaldoDife (inudife diferido.difecodi%type,
                          idtfecha date) return number is

nudifesape diferido.difesape%type;

cursor cuSaldoDife is
select sum(decode(m.modisign,'DB',m.modivacu,-m.modivacu))
  from open.movidife m
 where m.modidife = inudife
   and m.modifeca < idtfecha  + 1;

begin
  open cuSaldoDife;
  fetch cuSaldoDife into nudifesape;
  if cuSaldoDife%notfound then
    nudifesape := 0;
  end if;
  close cuSaldoDife;
  return (nudifesape);
exception when others then
  return 0;
end fnuGetSaldoDife;
/*************************************************************************************************/




procedure GenDatosHilos (inuano ldc_osf_sesucier.nuano%type,
                         inumes ldc_osf_sesucier.numes%type,
                         inuserv pr_product.product_type_id%type,
                         idtfecha date,
                         idttoday date,
                         innuNroHilo number,
                         innuTotHilos number,
                         innusesion number) is

nucont number := 0;
nuproducto pr_product.product_id%type;

cursor cuDatos is
select * from (
 SELECT s.area_servicio area_servicio
      ,s.departamento
      ,s.localidad
      ,s.cliente
      ,s.contrato
      ,s.producto
      ,s.categoria
      ,s.subcategoria
      ,(select  pr.commercial_plan_id
     from open.pr_product pr
     where pr.product_id = s.producto) plan_comercial

     , (select sum(d.difevatd)
          from open.diferido d
         where d.difecofi = (select min(d2.difecofi)
                               from open.diferido d2
                              where d2.difenuse = s.producto
                                and d2.difefein < idtfecha + 1
                                and d2.difeprog != 'GCNED')) valor_primer_diferido
     , (select min(d.difefein)
          from open.diferido d
         where d.difecofi = (select min(d2.difecofi)
                               from open.diferido d2
                              where d2.difenuse = s.producto
                                and d2.difefein < idtfecha + 1
                              and d2.difeprog != 'GCNED')) fecha_primer_diferido

      , (select sum(d.difevatd)
           from open.diferido d
          where d.difenuse = s.producto
            and d.difefein < idtfecha + 1
            and d.difeprog != 'GCNED') total_diferidos_cargados

      ,  (select sum(decode(m.modisign,'DB',m.modivacu,-m.modivacu))
            from open.movidife m, open.diferido d, open.concepto c
           where d.difeconc = c.conccodi
             and d.difecodi = m.modidife
             and c.concclco = 2
             and m.modinuse=s.producto
             and m.modifeca < idtfecha  + 1 ) valor_diferido_actual


          , (select sum(nvl(cucovato,0))
          from open.cuencobr cc, open.factura f
         where cc.cucofact = f.factcodi
           and cc.cuconuse = s.producto
           and f.factprog = decode(s.cliente,50000,704,429846,704,429845,704,6)
           and nvl(cucosacu,0) = 0
           and f.factfege < idtfecha + 1
           and cc.cucofepa < idtfecha + 1) total_pagos_brilla

     , decode(open.ldc_pro_esta_refinanciado(s.producto,to_char(idtfecha,'YYYY'),to_char(idtfecha,'MM')),1,'SI','NO') refinanciado

     , (SELECT count(distinct(f.difecofi))
          FROM open.diferido f
         where f.difenuse = s.producto
           and f.difefein < idtfecha + 1
           and f.difeprog = 'GCNED') Nro_Refinan_Brilla

      , (SELECT max(f.difefein)
           FROM open.diferido f
          where f.difenuse = s.producto
            and f.difefein < idtfecha + 1
            and f.difeprog = 'GCNED')  fecha_ultima_negoc_brilla

      , (select cucovaab
           from open.cuencobr c2
          where cucocodi = (select max(cc.cucocodi)
                              from open.cuencobr cc, open.factura f
                             where cc.cucofact = f.factcodi
                               and cc.cuconuse = s.producto
                               and f.factprog = decode(s.cliente,50000,704,429846,704,429845,704,6)
                               and nvl(cc.cucosacu,0) = 0
                               and cc.cucofepa < idtfecha + 1
                               and f.factfege < idtfecha + 1)) valor_ult_pago_brilla

         , (select max(cucofepa)
              from open.cuencobr cc, open.factura f
             where cc.cucofact = f.factcodi
               and cc.cuconuse = s.producto
               and f.factprog = decode(s.cliente,50000,704,429846,704,429845,704,6)
               and nvl(cucosacu,0) = 0
               and f.factfege < idtfecha + 1
               and cc.cucofepa < idtfecha + 1) fecha_ult_pago_brilla

        ,  (select qh.assigned_quote
              from Open.ld_quota_historic qh
             where qh.subscription_id = s.contrato
               and qh.register_date = (SELECT max(h.register_date)
                                         FROM Open.ld_quota_historic h
                                        WHERE h.subscription_id = s.contrato
                                          and h.register_date < idtfecha + 1)
               AND qh.result = 'Y') Cupo_asignado_brilla

       /* ,  (select sum(cargvalo)
              from open.cargos c
             where cargcuco = (select max(cc.cucocodi)
                                 from open.cuencobr cc, open.factura f
                                where cc.cucofact = f.factcodi
                                  and cc.cuconuse = s.producto
                                  and f.factprog = 6
                                  and f.factfege < idtfecha + 1)
               and cargnuse = s.producto
               and substr(cargdoso,1,2) in ('DF','ID')
               and cargsign='DB'
               and cargfecr < idtfecha + 1) valor_cuota_brilla*/

       ,  (select cc4.cucovato
              from open.cuencobr cc4
             where cc4.cucocodi = (select max(cc.cucocodi)
                                 from open.cuencobr cc, open.factura f
                                where cc.cucofact = f.factcodi
                                  and cc.cuconuse = s.producto
                                  and f.factprog = decode(s.cliente,50000,704,429846,704,429845,704,6)
                                  and f.factfege < idtfecha + 1)) valor_cuota_brilla

      ,  (select max(difenucu)
            from open.diferido d
           where d.difenuse=s.producto
             and d.difefein < idtfecha + 1
             and ldc_pkGenGaVBr.fnuGetSaldoDife(d.difecodi,idtfecha)>0) nro_cuotas_brilla

       , (select count(distinct(ca.cargcuco))
            from open.cargos ca
           where cargnuse=s.producto
             and cargfecr < idtfecha + 1
             and cargdoso='DF-'||(select difecodi
                                    from open.diferido d2
                                   where d2.difenuse=s.producto
                                     and ldc_pkGenGaVBr.fnuGetSaldoDife(d2.difecodi,idtfecha)>0
                                     and rownum = 1
                                     and d2.difecupa = (select max(d.difecupa)
                                                          from open.diferido d
                                                         where d.difenuse=s.producto
                                                           and d.difefein < idtfecha + 1
                                                           and ldc_pkGenGaVBr.fnuGetSaldoDife(d.difecodi,idtfecha)>0))) cuotas_cobradas_brilla

        , (select count(1)
           from open.cuencobr cc
          where nvl(cc.cucosacu,0)=0
            and cc.cuconuse = s.producto
            and cc.cucocodi in (select distinct(ca.cargcuco)
                               from open.cargos ca
                              where ca.cargnuse=s.producto
                                and ca.cargfecr < idtfecha + 1
                                and ca.cargdoso='DF-'||(select d2.difecodi
                                                       from open.diferido d2
                                                      where d2.difenuse=s.producto
                                                        and ldc_pkGenGaVBr.fnuGetSaldoDife(d2.difecodi,idtfecha)>0
                                                        and rownum = 1
                                                        and d2.difecupa = (select max(d.difecupa)
                                                                             from open.diferido d
                                                                            where d.difenuse=s.producto
                                                                              and d.difefein < idtfecha + 1
                                                                              and ldc_pkGenGaVBr.fnuGetSaldoDife(d.difecodi,idtfecha)>0)))) cuotas_pagadas_brilla

          , (SELECT max(f.difefein)
              FROM open.diferido f
             where f.difenuse = (select ss2.producto
                                   from open.ldc_osf_sesucier ss2
                                  where ss2.nuano = inuano
                                    and ss2.numes = inumes
                                    and ss2.contrato = s.contrato
                                    and ss2.tipo_producto = 7014
                                    and rownum = 1)
               and f.difefein < idtfecha + 1
               and f.difeprog = 'GCNED')  fecha_ult_negociacion_gas

       , (select cucovaab
            from open.cuencobr c2
           where cucocodi = (select max(cc.cucocodi)
                               from open.cuencobr cc, open.factura f
                              where cc.cucofact = f.factcodi
                                and cc.cuconuse = (select ss2.producto
                                                     from open.ldc_osf_sesucier ss2
                                                    where ss2.nuano = inuano
                                                      and ss2.numes = inumes
                                                      and ss2.contrato = s.contrato
                                                      and ss2.tipo_producto = 7014
                                                      and rownum = 1)
                                and f.factprog = decode(s.cliente,50000,704,429846,704,429845,704,6)
                                and nvl(cc.cucosacu,0) = 0
                                and f.factfege < idtfecha + 1
                                and cc.cucofepa < idtfecha + 1)) valor_ult_pago_gas

       , (select max(cucofepa)
            from open.cuencobr cc, open.factura f
           where cc.cucofact = f.factcodi
             and cc.cuconuse = (select ss2.producto
                                   from open.ldc_osf_sesucier ss2
                                  where ss2.nuano = inuano
                                    and ss2.numes = inumes
                                    and ss2.contrato = s.contrato
                                    and ss2.tipo_producto = 7014
                                    and rownum = 1)
             and f.factprog = decode(s.cliente,50000,704,429846,704,429845,704,6)
             and nvl(cucosacu,0) = 0
             and f.factfege < idtfecha + 1
             and cc.cucofepa < idtfecha + 1) fecha_ult_pago_gas

         /* , (select sum(cargvalo)
              from open.cargos c
             where cargcuco = (select max(cc.cucocodi)
                                 from open.cuencobr cc, open.factura f
                                where cc.cucofact = f.factcodi
                                  and cc.cuconuse = (select ss2.producto
                                                       from open.ldc_osf_sesucier ss2
                                                      where ss2.nuano = inuano
                                                        and ss2.numes = inumes
                                                        and ss2.contrato = s.contrato
                                                        and ss2.tipo_producto = 7014
                                                        and rownum = 1)
                                  and f.factprog = 6
                                  and f.factfege < idtfecha + 1)
               and substr(cargdoso,1,2) in ('DF','ID')
               and cargsign='DB'
               and cargfecr < idtfecha + 1) valor_cuota_gas*/

         , (select cc4.cucovato
              from open.cuencobr cc4
             where cc4.cucocodi = (select max(cc.cucocodi)
                                 from open.cuencobr cc, open.factura f
                                where cc.cucofact = f.factcodi
                                  and cc.cuconuse = (select ss2.producto
                                                       from open.ldc_osf_sesucier ss2
                                                      where ss2.nuano = inuano
                                                        and ss2.numes = inumes
                                                        and ss2.contrato = s.contrato
                                                        and ss2.tipo_producto = 7014
                                                        and rownum = 1)
                                  and f.factprog = decode(s.cliente,50000,704,429846,704,429845,704,6)
                                  and f.factfege < idtfecha + 1)) valor_cuota_gas

      , (select max(factfege)
           from open.cuencobr cc, open.factura f
          where cc.cucofact = f.factcodi
            and cc.cuconuse = (select ss2.producto
                                   from open.ldc_osf_sesucier ss2
                                  where ss2.nuano = inuano
                                    and ss2.numes = inumes
                                    and ss2.contrato = s.contrato
                                    and ss2.tipo_producto = 7014
                                    and rownum = 1)
            and f.factprog = decode(s.cliente,50000,704,429846,704,429845,704,6)
            and f.factfege < idtfecha + 1) fecha_ult_factura_gas

      ,s.edad

      ,s.deuda_corriente_no_vencida
      ,s.deuda_corriente_vencida
      ,s.sesusape total_deuda_corriente
      ,s.deuda_no_corriente
      ,(s.sesusape+s.deuda_no_corriente) deuda_tota

      ,nvl(valor_castigado,0) valor_castigado

      ,s.saldo_favor
      ,s.valor_reclamo
      ,s.valor_pago_no_abonado
      ,s.nro_ctas_con_saldo
      ,s.edad_deuda

      ,s.estado_tecnico estado_producto
      ,s.estado_financiero
      ,s.barrio
      ,s.ciclo
      ,s.estado_corte
      ,s.tipo_producto

     /*,(SELECT (SELECT tt.task_type_id||' - '||tt.description FROM open.or_task_type tt WHERE tt.task_type_id = o.task_type_id)
          FROM open.or_order o
         WHERE o.order_id =(
                            SELECT oa.order_id
                              FROM open.or_order_activity oa
                             WHERE oa.order_activity_id = s.ult_act_susp)) ultima_acti_suspe*/
    ,s.ultimo_plan_fina

   /*, (select sum(s1.sesusape)
       from open.ldc_osf_sesucier s1
      where s1.nuano = s.nuano
        and s1.numes = s.numes
        and s1.producto = (select ss2.producto
                                   from open.ldc_osf_sesucier ss2
                                  where ss2.nuano = inuano
                                    and ss2.numes = inumes
                                    and ss2.contrato = s.contrato
                                    and ss2.tipo_producto = 7014
                                    and rownum = 1)) saldo_pendiente_gas

   , (select sum(s1.deuda_no_corriente)
       from open.ldc_osf_sesucier s1
      where s1.nuano = s.nuano
        and s1.numes = s.numes
        and s1.producto = (select ss2.producto
                                   from open.ldc_osf_sesucier ss2
                                  where ss2.nuano = inuano
                                    and ss2.numes = inumes
                                    and ss2.contrato = s.contrato
                                    and ss2.tipo_producto = 7014
                                    and rownum = 1)) diferido_gas

   , (select sum(s1.sesusape+s1.deuda_no_corriente)
       from open.ldc_osf_sesucier s1
      where s1.nuano = s.nuano
        and s1.numes = s.numes
        and s1.producto = (select ss2.producto
                                   from open.ldc_osf_sesucier ss2
                                  where ss2.nuano = inuano
                                    and ss2.numes = inumes
                                    and ss2.contrato = s.contrato
                                    and ss2.tipo_producto = 7014
                                    and rownum = 1))  deuda_total_gas

   ,(select s1.estado_tecnico
       from open.ldc_osf_sesucier s1
      where s1.nuano = s.nuano
        and s1.numes = s.numes
        and s1.producto = (select ss2.producto
                                   from open.ldc_osf_sesucier ss2
                                  where ss2.nuano = inuano
                                    and ss2.numes = inumes
                                    and ss2.contrato = s.contrato
                                    and ss2.tipo_producto = 7014
                                    and rownum = 1)) estado_producto_gas

   ,(select s1.estado_corte
       from open.ldc_osf_sesucier s1
      where s1.nuano = s.nuano
        and s1.numes = s.numes
        and s1.producto = (select ss2.producto
                                   from open.ldc_osf_sesucier ss2
                                  where ss2.nuano = inuano
                                    and ss2.numes = inumes
                                    and ss2.contrato = s.contrato
                                    and ss2.tipo_producto = 7014
                                    and rownum = 1)) estado_corte_gas

   ,(select s1.estado_financiero
       from open.ldc_osf_sesucier s1
      where s1.nuano = s.nuano
        and s1.numes = s.numes
        and s1.producto = (select ss2.producto
                                   from open.ldc_osf_sesucier ss2
                                  where ss2.nuano = inuano
                                    and ss2.numes = inumes
                                    and ss2.contrato = s.contrato
                                    and ss2.tipo_producto = 7014
                                    and rownum = 1)) estado_financiero_gas

   , (select s1.edad
        from open.ldc_osf_sesucier s1
       where s1.nuano = s.nuano
         and s1.numes = s.numes
         and s1.producto = (select ss2.producto
                                   from open.ldc_osf_sesucier ss2
                                  where ss2.nuano = inuano
                                    and ss2.numes = inumes
                                    and ss2.contrato = s.contrato
                                    and ss2.tipo_producto = 7014
                                    and rownum = 1)) edad_mora_gas

   , (select s1.nro_ctas_con_saldo
        from open.ldc_osf_sesucier s1
       where s1.nuano = s.nuano
         and s1.numes = s.numes
             and s1.producto = (select ss2.producto
                                   from open.ldc_osf_sesucier ss2
                                  where ss2.nuano = inuano
                                    and ss2.numes = inumes
                                    and ss2.contrato = s.contrato
                                    and ss2.tipo_producto = 7014
                                    and rownum = 1)) cuentas_con_saldo_gas*/

  FROM open.ldc_osf_sesucier s
 WHERE s.nuano =  inuano
   AND s.numes =  inumes
   AND s.tipo_producto = inuserv
  )
   where mod(producto,innuTotHilos)+innuNroHilo= innuTotHilos;

cursor cuDatos1 (nucontrato ldc_osf_sesucier.contrato%type)is
select sum(s1.sesusape) saldo_pendiente_gas,
       sum(s1.deuda_no_corriente) diferido_gas,
       sum(s1.sesusape + s1.deuda_no_corriente) deuda_total_gas,
       s1.estado_tecnico estado_producto_gas,
       s1.estado_corte estado_corte_gas,
       s1.estado_financiero estado_financiero_gas,
       s1.edad edad_mora_gas,
       s1.nro_ctas_con_saldo cuentas_con_saldo_gas
  from open.ldc_osf_sesucier s1
 where s1.nuano = inuano
   and s1.numes = inumes
   and s1.producto = (select ss2.producto
                        from open.ldc_osf_sesucier ss2
                       where ss2.nuano = inuano
                         and ss2.numes = inumes
                         and ss2.contrato = nucontrato
                         and ss2.tipo_producto = 7014
                         and rownum = 1)
 group by s1.estado_tecnico,
          s1.estado_corte,
          s1.estado_financiero,
          s1.edad,
          s1.nro_ctas_con_saldo;
  rg1 cuDatos1%rowtype;
begin
  ut_trace.trace('Inicio ldc_pkGenGaVBr.GenDatosHilos Hilo ' || innuNroHilo, 10);
  pro_grabalog (innusesion, idttoday, innuNroHilo, 1, 'Inicia Hilo: ' || innuNroHilo);

  for rg in cuDatos loop
    nuproducto := rg.producto;
    OPEN cuDatos1(rg.contrato);
    FETCH cuDatos1
      INTO rg1;
    CLOSE cuDatos1;
    insert into LDC_GAVBR (area_servicio, departamento, localidad, cliente, contrato,
                           producto, categoria, subcategoria, plan_comercial, valor_primer_diferido,
                           fecha_primer_diferido, total_diferidos_cargados, valor_diferido_actual, total_pagos_brilla, refinanciado,
                           nro_refinan_brilla, fecha_ultima_negoc_brilla, valor_ult_pago_brilla, fecha_ult_pago_brilla, cupo_asignado_brilla,
                           valor_cuota_brilla, nro_cuotas_brilla, cuotas_cobradas_brilla, cuotas_pagadas_brilla, fecha_ult_negociacion_gas,
                           valor_ult_pago_gas, fecha_ult_pago_gas, valor_cuota_gas, fecha_ult_factura_gas, edad,
                           deuda_tota, valor_castigado, edad_deuda, estado_producto, estado_financiero,
                           barrio, ciclo, estado_corte, tipo_producto, ultima_acti_suspe,
                           ultimo_plan_fina, saldo_pendiente_gas, diferido_gas, deuda_total_gas, estado_producto_gas,
                           estado_corte_gas, estado_financiero_gas, edad_mora_gas, cuentas_con_saldo_gas, fecha_cierre,
                           deuda_corriente_no_vencida, deuda_corriente_vencida, total_deuda_corriente,
                           deuda_no_corriente, saldo_favor, valor_reclamo, valor_pago_no_abonado,
                           nro_ctas_con_saldo, ano, mes)
                 values   (rg.area_servicio, rg.departamento, rg.localidad, rg.cliente, rg.contrato,
                           rg.producto, rg.categoria, rg.subcategoria, rg.plan_comercial, rg.valor_primer_diferido,
                           rg.fecha_primer_diferido, rg.total_diferidos_cargados, rg.valor_diferido_actual, rg.total_pagos_brilla, rg.refinanciado,
                           rg.nro_refinan_brilla, rg.fecha_ultima_negoc_brilla, rg.valor_ult_pago_brilla, rg.fecha_ult_pago_brilla, rg.cupo_asignado_brilla,
                           rg.valor_cuota_brilla, rg.nro_cuotas_brilla, rg.cuotas_cobradas_brilla, rg.cuotas_pagadas_brilla, rg.fecha_ult_negociacion_gas,
                           rg.valor_ult_pago_gas, rg.fecha_ult_pago_gas, rg.valor_cuota_gas, rg.fecha_ult_factura_gas, rg.edad,
                           rg.deuda_tota, rg.valor_castigado, rg.edad_deuda, rg.estado_producto, rg.estado_financiero,
                           rg.barrio, rg.ciclo, rg.estado_corte, rg.tipo_producto, /*rg.ultima_acti_suspe*/ null,
                           rg.ultimo_plan_fina, rg1.saldo_pendiente_gas, rg1.diferido_gas, rg1.deuda_total_gas, rg1.estado_producto_gas,
                           rg1.estado_corte_gas, rg1.estado_financiero_gas, rg1.edad_mora_gas, rg1.cuentas_con_saldo_gas, idtfecha,
                           rg.deuda_corriente_no_vencida, rg.deuda_corriente_vencida, rg.total_deuda_corriente,
                           rg.deuda_no_corriente, rg.saldo_favor, rg.valor_reclamo, rg.valor_pago_no_abonado,
                           rg.nro_ctas_con_saldo, inuano, inumes);
    nucont := nucont + 1;
    if mod(nucont,1000) = 0 then
      commit;
    end if;
  end loop;
  commit;

  pro_grabalog (innusesion, idttoday, innuNroHilo, 2, 'Termino Hilo: ' || innuNroHilo || ' - Proceso Ok');
  ut_trace.trace('Finalizo ldc_pkGenGaVBr.GenDatosHilos Hilo ' || innuNroHilo, 10);

exception
   When others then
      pro_grabalog (innusesion, idttoday, innuNroHilo, -1, 'Hilo: ' || innuNroHilo ||
                             ' Termino con errores (en el Producto que le sigue al: ' || nuProducto || '). LA INFORMACION PUEDE NO ESTAR COMPLETA: ' || sqlerrm);
      rollback;


end GenDatosHilos;


/**************************************************************************************************/

procedure pro_grabalog (inusesion number, idtfecha date, inuhilo number,
                        inuresult number, isbobse varchar2) is
PRAGMA AUTONOMOUS_TRANSACTION;
begin
  insert into LDC_LOG_LDRGAVBR
              (sesion, usuario, fecha_inicio, fecha_final, hilo, resultado, observacion)
       values (inusesion, user, idtfecha, sysdate, inuhilo, inuresult, isbobse);
  commit;
end pro_grabalog;

END LDC_PKGENGAVBR;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKGENGAVBR
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGENGAVBR', 'ADM_PERSON'); 
END;
/
