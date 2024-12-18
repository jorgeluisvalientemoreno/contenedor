CREATE OR REPLACE PACKAGE ldc_pkInfoAuditoria is
	/*****************************************************************
	Propiedad intelectual de PETI (c).

	******************************************************************/

	procedure proRunJobs;


    /**************************************************************************
	  HISTORIA DE MODIFICACIONES
	  FECHA         AUTOR                       DESCRIPCION
      16/02/2022    Carlos Gonzalez (Horbath)   Se modifica para adicionar el llenado del campo CICLO
                                                que se obtiene a partir del periodo de facturacion
	***************************************************************************/
	procedure proInfoAuditoria (nuHilo in number,
							  dtfeini in date,
							  dtfefin in date);

	procedure PRGENJOBINFAUD (nuAno number,
							  nuMes number);
	/**************************************************************************
	  Autor       : Horbath
	  Fecha       : 29/10/2021
	  Ticket      : 863
	  Descripcion : Proceso que genera 2 Jobs para el procedimiento ldc_pkInfoAuditoria.proInfoAuditoria
					para el mes y a¿o recibidos como par¿metros.


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
	PROCEDURE PRVALINFAUD;

	/*****************************************************************
		Autor       :  Horbath
		Fecha       : 2021/10/26
		Ticket      : 863
		Descripcion : Procedimiento que se encargara de validar si los campos recibidos en la forma LDCINFAUD est¿n llenos
						y que no tenga un registro en la tabla LDC_REGINFAUD con los campos hilo1 o hilo2 igual a 0.

	  Historia de Modificaciones
	  FECHA         AUTOR                       DESCRIPCION
	  16/02/2022    Carlos Gonzalez (Horbath)   Se modifica para adicionar el campo CICLO en el archivo
	  ******************************************************************/
	  procedure PRGENARCHINFAUD (nuAno number, nuMes number, sbRuta varchar2,persona number);

	/*******************************************************************************
	  Propiedad intelectual de PROYECTO GASES DEL CARIBE

	  Autor         : horbath
	  Fecha         : 27-10-2021
	  CASO          : 863
	  DESCRIPCION   : procedmineto para generar un archivo plano en la ruta recibida
					  como par¿metro con la informaci¿n de la tabla ¿LDC_INFCARGOSAUD¿


	  Fecha                IDEntrega           Modificacion
	  ============    ================    ============================================

	  *******************************************************************************/


end ldc_pkInfoAuditoria;
/
CREATE OR REPLACE PACKAGE BODY ldc_pkInfoAuditoria is
  /*****************************************************************
    Propiedad intelectual de GDC (c).

  *****************************************************************************/

  procedure proRunJobs is

   nutsess   NUMBER;
   sbparuser VARCHAR2(100);

   nuJob number;
   sbWhat varchar2(2000) ;

    nuHilo01 number := 1;
   dtFecIni01 date := to_date('01/07/2019','dd/mm/yyyy');
   dtFecFin01 date := to_date('15/07/2019','dd/mm/yyyy');

   nuHilo02 number := 2;
   dtFecIni02 date := to_date('16/07/2019','dd/mm/yyyy');
   dtFecFin02 date := to_date('31/07/2019','dd/mm/yyyy');

   nuHilo03 number := 3;
   dtFecIni03 date := to_date('01/08/2019','dd/mm/yyyy');
   dtFecFin03 date := to_date('15/08/2019','dd/mm/yyyy');

   nuHilo04 number := 4;
   dtFecIni04 date := to_date('16/08/2019','dd/mm/yyyy');
   dtFecFin04 date := to_date('31/08/2019','dd/mm/yyyy');

   /*nuHilo05 number := 5;
   dtFecIni05 date := to_date('01/03/2019','dd/mm/yyyy');
   dtFecFin05 date := to_date('15/03/2019','dd/mm/yyyy');

   nuHilo06 number := 6;
   dtFecIni06 date := to_date('16/03/2019','dd/mm/yyyy');
   dtFecFin06 date := to_date('31/03/2019','dd/mm/yyyy');

   nuHilo07 number := 7;
   dtFecIni07 date := to_date('01/04/2019','dd/mm/yyyy');
   dtFecFin07 date := to_date('15/04/2019','dd/mm/yyyy');

   nuHilo08 number := 8;
   dtFecIni08 date := to_date('16/04/2019','dd/mm/yyyy');
   dtFecFin08 date := to_date('30/04/2019','dd/mm/yyyy');
*/
  /*nuHilo09 number := 9;
   dtFecIni09 date := to_date('01/05/2018','dd/mm/yyyy');
   dtFecFin09 date := to_date('15/05/2018','dd/mm/yyyy');

   nuHilo10 number := 10;
   dtFecIni10 date := to_date('16/05/2018','dd/mm/yyyy');
   dtFecFin10 date := to_date('31/05/2018','dd/mm/yyyy');

   nuHilo11 number := 11;
   dtFecIni11 date := to_date('01/06/2018','dd/mm/yyyy');
   dtFecFin11 date := to_date('15/06/2018','dd/mm/yyyy');

   nuHilo12 number := 12;
   dtFecIni12 date := to_date('16/06/2018','dd/mm/yyyy');
   dtFecFin12 date := to_date('30/06/2018','dd/mm/yyyy');*/




  begin
    SELECT userenv('SESSIONID'),USER INTO nutsess,sbparuser FROM dual;
    ldc_proinsertaestaprog(2019,4,'ldc_pkInfoAuditoria Ppal','En ejecucion',nutsess,sbparuser);

    DELETE FROM LDC_INFCARGOSAUD WHERE ANO=2019 AND MES IN (7,8);
    COMMIT;

    sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo01 || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecIni01, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecFin01, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;
     --dbms_output.put_line(sbWhat);

      sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo02 || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecIni02, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecFin02, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;


         sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo03 || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecIni03, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecFin03, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;

        sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo04 || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecIni04, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecFin04, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;

       /*sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo05 || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecIni05, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecFin05, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;

        sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo06 || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecIni06, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecFin06, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;

        sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo07 || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecIni07, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecFin07, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;

        sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo08 || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecIni08, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecFin08, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;*/

        /*sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo09 || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecIni09, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecFin09, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;

        sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo10 || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecIni10, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecFin10, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;

        sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo11 || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecIni11, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecFin11, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;


        sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo12 || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecIni12, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtFecFin12, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;   */


      ldc_proactualizaestaprog(nutsess,'Ok','ldc_pkInfoAuditoria Ppal','Termino Ok');

  end proRunJobs;

  procedure proInfoAuditoria (nuHilo in number,
                              dtfeini in date,
                              dtfefin in date) is

    nuLimit      Number := 500;   -- 500
    nuCommit     number := 5000;
    nuCont       number := 0;

    nuano        number(4);
    numes        number(2);
    nuCiclo      ciclo.ciclcodi%type;

    nutsess   NUMBER;
    sbparuser VARCHAR2(100);
	nuUltregHilo1 number;
	nuUltregHilo2 number;


 CURSOR CurData  is
  SELECT A_TIDO,
       B_TIMO,
       C_DESC_TIMO,
       TIPO_PRODUCTO,
       CONTRATO,
       CUENTA_COBRO,
       FACTURA,
       PERIODO_FACT,
       FECHA_GENERACION,
       CONCEPTO,
       case when CONCEPTO in ( 30,19) then
            ( SELECT o.order_id
              FROM OPEN.or_order o, OPEN.or_order_activity oa, OPEN.ge_causal c
              WHERE o.task_type_id IN (12150,12152,12153)
                  AND o.order_id = oa.order_id
                  and oa.PRODUCT_ID = producto
                  AND o.order_status_id = 8
                  AND c.causal_id = o.causal_id
                  AND c.class_causal_id = 1
                  AND ROWNUM < 2
                )
       else
         0
       end orden_construccion,
       CONCCLCO,
       CAUSAL_CARGO,
       FECHA_CREACION_CARGO,
       VALOR
FROM (
 select 71 A_tido, 1 B_timo, 'Facturacion por Concepto' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) tipo_producto ,
       factsusc contrato,
	   cucocodi cuenta_cobro,
	   factcodi factura,
	   (select  lpad(pefames,2,'0')||'/'||pefaano  from open.perifact p where p.pefacodi =factpefa) periodo_fact,
	   factfege fecha_generacion,
	   cargconc concepto,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca causal_cargo,
	   cargfecr fecha_creacion_cargo,
	   decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) valor,
     cargnuse producto
  from open.factura f, open.cuencobr cc, open.cargos ca
 where factcodi=cucofact
   and cucocodi=cargcuco
   and factfege >= dtfeini
   and factfege <  dtfefin + 1
  -- and factprog=6
   and cargcuco>0
   and cargfecr <  dtfefin + 1
   and cargtipr='A'
   and cargsign in ('DB','CR')
 --  AND CARGCONC IN (19,30))
union all -- SA de Facturaci?n ------------------------------------------------------------------------------------------------------------
select 71 A_tido, 44 B_timo, 'Saldo a Favor por Facturacion' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi,
	   factcodi factura,
	   (select lpad(pefames,2,'0')||'/'||pefaano  from open.perifact p where p.pefacodi =factpefa) periodo_fact,
	   factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo,
       cargnuse producto
  from open.factura f, open.cuencobr cc, open.cargos ca
 where factcodi=cucofact
   and cucocodi=cargcuco
   and factfege >= dtfeini
   and factfege <  dtfefin + 1
   --and factprog=6
   and cargcuco>0
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign = 'SA'
   AND cargdoso not like 'PA%'
   AND cargprog in (6,18,42) -- FGCC, FAFS, FGCO
union all  -- Aplicaciones de Saldo a Favor por Facturaci?n ------------------------------------------------------------------------------------------------------------
select 71 A_tido, 11 B_timo, 'Aplicacion de Saldo a Favor en Facturacion' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi,
	   factcodi factura,
	   (select lpad(pefames,2,'0')||'/'||pefaano   from open.perifact p where p.pefacodi =factpefa) periodo_fact,
	   factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo,
       cargnuse producto
  from open.factura f, open.cuencobr cc, open.cargos ca
 where factcodi=cucofact
   and cucocodi=cargcuco
   and cargcuco>0
   and cargfecr >= dtfeini
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign = 'AS'
   AND cargprog in (6,18,42) -- FGCC, FAFS, FGCO
union all  -- Notas por concepto   Tener en cuenta causa de cargo 45 - Cheque Devuelto se reporta en tipo de movimiento 5 ------------------------------------------------------------------------------------------------------------
select 73 A_tido, 16 B_timo, 'Notas por concepto' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi,
		factcodi factura,
	   (select lpad(pefames,2,'0')||'/'||pefaano   from open.perifact p where p.pefacodi =factpefa) periodo_fact,
	   factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo,
       cargnuse producto
  from open.factura f, open.cuencobr cc, open.cargos ca
 where factcodi=cucofact
   and cucocodi=cargcuco
   and cargcuco>0
   and cargfecr >= dtfeini
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign in ('DB','CR')
union all  -- SA de Notas   ------------------------------------------------------------------------------------------------------------
select 73 A_tido, 46 B_timo, 'Saldo a Favor por Notas' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi,
	   factcodi factura,
	   (select lpad(pefames,2,'0')||'/'||pefaano  from open.perifact p where p.pefacodi =factpefa) periodo_fact,
	   factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo,
       cargnuse producto
  from open.factura f, open.cuencobr cc, open.cargos ca
 where factcodi=cucofact
   and cucocodi=cargcuco
   and cargcuco>0
   and cargfecr >= dtfeini
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign = 'SA'
   AND cargdoso not like 'PA%'
   AND cargprog not in (6,18,42) -- FGCC, FAFS, FGCO
union all  -- Aplicaciones de Saldo a Favor por Notas   ------------------------------------------------------------------------------------------------------------
select 73 A_tido, 40 B_timo, 'Aplicacion Saldo a Favor por Notas' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi,
		factcodi factura,
	   (select lpad(pefames,2,'0')||'/'||pefaano   from open.perifact p where p.pefacodi =factpefa) periodo_fact,
	   factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo,
       cargnuse producto
  from open.factura f, open.cuencobr cc, open.cargos ca
 where factcodi=cucofact
   and cucocodi=cargcuco
   and cargcuco>0
   and cargfecr >= dtfeini
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign = 'AS'
   AND cargprog not in (6,18,42) -- FGCC, FAFS, FGCO
union all  -- Pagos   ------------------------------------------------------------------------------------------------------------
select 72 A_tido, 23 B_timo, 'Recaudo por Concepto' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi,
		factcodi factura,
	   (select lpad(pefames,2,'0')||'/'||pefaano   from open.perifact p where p.pefacodi =factpefa) periodo_fact,
	   factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo,
       cargnuse producto
    from open.factura f, open.cuencobr cc, open.cargos ca, open.cupon
 where factcodi=cucofact
    and cucocodi=cargcuco
    and cargcuco>0
   and cargfecr >= dtfeini
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign in ('SA','PA','AP','NS')
   AND (cargdoso like 'PA%' OR cargdoso like 'AP%')
   AND cargcodo = cuponume -- Garantizar el paso a interfaz por detalle por cup?n   resureca
union all  -- Saldos a Favor por Pagos  ------------------------------------------------------------------------------------------------------------
select 72 A_tido, 25 B_timo, 'Saldo a Favor por Recaudo' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi,
		factcodi factura,
	   (select lpad(pefames,2,'0')||'/'||pefaano   from open.perifact p where p.pefacodi =factpefa) periodo_fact,
	   factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo,
       cargnuse producto
  from open.factura f, open.cuencobr cc, open.cargos ca, open.cupon
 where factcodi=cucofact
   and cucocodi=cargcuco
   and cargcuco>0
   and cargfecr >= dtfeini
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign in ('SA','NS')
   AND (cargdoso like 'PA%' OR cargdoso like 'AP%')
   AND cargcodo = cuponume);
  /* select 71 A_tido, 1 B_timo, 'Facturacion por Concepto' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi, factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo
  from open.factura f, open.cuencobr cc, open.cargos ca
 where factcodi=cucofact
   and cucocodi=cargcuco
   and factfege >= dtfeini
   and factfege <  dtfefin + 1
  -- and factprog=6
   and cargcuco>0
   and cargfecr <  dtfefin + 1
   and cargtipr='A'
   and cargsign in ('DB','CR')
union all -- SA de Facturaci?n ------------------------------------------------------------------------------------------------------------
select 71 A_tido, 44 B_timo, 'Saldo a Favor por Facturacion' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi, factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo
  from open.factura f, open.cuencobr cc, open.cargos ca
 where factcodi=cucofact
   and cucocodi=cargcuco
   and factfege >= dtfeini
   and factfege <  dtfefin + 1
   --and factprog=6
   and cargcuco>0
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign = 'SA'
   AND cargdoso not like 'PA%'
   AND cargprog in (6,18,42) -- FGCC, FAFS, FGCO
union all  -- Aplicaciones de Saldo a Favor por Facturaci?n ------------------------------------------------------------------------------------------------------------
select 71 A_tido, 11 B_timo, 'Aplicacion de Saldo a Favor en Facturacion' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi, factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo
  from open.factura f, open.cuencobr cc, open.cargos ca
 where factcodi=cucofact
   and cucocodi=cargcuco
   and cargcuco>0
   and cargfecr >= dtfeini
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign = 'AS'
   AND cargprog in (6,18,42) -- FGCC, FAFS, FGCO
union all  -- Notas por concepto   Tener en cuenta causa de cargo 45 - Cheque Devuelto se reporta en tipo de movimiento 5 ------------------------------------------------------------------------------------------------------------
select 73 A_tido, 16 B_timo, 'Notas por concepto' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi, factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo
  from open.factura f, open.cuencobr cc, open.cargos ca
 where factcodi=cucofact
   and cucocodi=cargcuco
   and cargcuco>0
   and cargfecr >= dtfeini
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign in ('DB','CR')
union all  -- SA de Notas   ------------------------------------------------------------------------------------------------------------
select 73 A_tido, 46 B_timo, 'Saldo a Favor por Notas' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi, factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo
  from open.factura f, open.cuencobr cc, open.cargos ca
 where factcodi=cucofact
   and cucocodi=cargcuco
   and cargcuco>0
   and cargfecr >= dtfeini
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign = 'SA'
   AND cargdoso not like 'PA%'
   AND cargprog not in (6,18,42) -- FGCC, FAFS, FGCO
union all  -- Aplicaciones de Saldo a Favor por Notas   ------------------------------------------------------------------------------------------------------------
select 73 A_tido, 40 B_timo, 'Aplicacion Saldo a Favor por Notas' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi, factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo
  from open.factura f, open.cuencobr cc, open.cargos ca
 where factcodi=cucofact
   and cucocodi=cargcuco
   and cargcuco>0
   and cargfecr >= dtfeini
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign = 'AS'
   AND cargprog not in (6,18,42) -- FGCC, FAFS, FGCO
union all  -- Pagos   ------------------------------------------------------------------------------------------------------------
select 72 A_tido, 23 B_timo, 'Recaudo por Concepto' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi, factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo
    from open.factura f, open.cuencobr cc, open.cargos ca, open.cupon
 where factcodi=cucofact
    and cucocodi=cargcuco
    and cargcuco>0
   and cargfecr >= dtfeini
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign in ('SA','PA','AP','NS')
   AND (cargdoso like 'PA%' OR cargdoso like 'AP%')
   AND cargcodo = cuponume -- Garantizar el paso a interfaz por detalle por cup?n   resureca
union all  -- Saldos a Favor por Pagos  ------------------------------------------------------------------------------------------------------------
select 72 A_tido, 25 B_timo, 'Saldo a Favor por Recaudo' C_desc_timo,
       (select sesuserv from open.servsusc where sesunuse=cuconuse) sesuserv,
       factsusc,cucocodi, factfege, cargconc,
       (Select co.concclco from open.concepto co where conccodi=cargconc) concclco,
       cargcaca, cargfecr, decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo) cargvalo
  from open.factura f, open.cuencobr cc, open.cargos ca, open.cupon
 where factcodi=cucofact
   and cucocodi=cargcuco
   and cargcuco>0
   and cargfecr >= dtfeini
   and cargfecr <  dtfefin + 1
   and cargtipr='P'
   AND cargsign in ('SA','NS')
   AND (cargdoso like 'PA%' OR cargdoso like 'AP%')
   AND cargcodo = cuponume;*/ -- Garantizar el paso a interfaz por detalle por cup?n   resureca

    TYPE rt_Data IS TABLE of CurData%ROWTYPE INDEX BY BINARY_INTEGER;
    vrt_Data rt_Data;

	cursor cuultregHilo1 (nuAno Number, nuMes number) is
		select REGINFAUD_REG
		from LDC_REGINFAUD
		where HILO1=0
		and ANO= nuAno
		and MES= nuMes;

	cursor cuultregHilo2 (nuAno Number, nuMes number) is
		select REGINFAUD_REG
		from LDC_REGINFAUD
		where HILO2=0
		and ANO= nuAno
		and MES= nuMes;

	PROCEDURE ActualizaHilo1 (RegHilo    number)  IS
		PRAGMA AUTONOMOUS_TRANSACTION;
		nutsess      NUMBER;
		sbmensa      VARCHAR2(1000);
		sbemail 	 VARCHAR2(100);
		sbparuser    VARCHAR2(30);


	BEGIN
		SELECT userenv('SESSIONID'),USER   INTO nutsess,sbparuser FROM dual;

		ldc_proinsertaestaprog(nuAno,nuMes,'ENVIACORREO','En ejecucion',nutsess,sbparuser);
				update LDC_REGINFAUD
				set hilo1=1
				where REGINFAUD_REG=RegHilo;
				commit;
		ldc_proactualizaestaprog(nutsess,'Envia correo','ENVIACORREO','Termino Ok.');
	EXCEPTION
	 WHEN OTHERS THEN
		sbmensa := 'Error al enviar el correo del proceso LDCREASCO. '||SQLERRM;
		ldc_proactualizaestaprog(nutsess,sbmensa,'ENVIACORREO','ERROR.');
	END;

	PROCEDURE ActualizaHilo2 (RegHilo    number)  IS
		PRAGMA AUTONOMOUS_TRANSACTION;
		nutsess      NUMBER;
		sbmensa      VARCHAR2(1000);
		sbemail 	 VARCHAR2(100);
		sbparuser    VARCHAR2(30);


	BEGIN
		SELECT userenv('SESSIONID'),USER   INTO nutsess,sbparuser FROM dual;

		ldc_proinsertaestaprog(nuAno,nuMes,'ENVIACORREO','En ejecucion',nutsess,sbparuser);
				update LDC_REGINFAUD
				set hilo2=1
				where REGINFAUD_REG=RegHilo;
				commit;
		ldc_proactualizaestaprog(nutsess,'Envia correo','ENVIACORREO','Termino Ok.');
	EXCEPTION
	 WHEN OTHERS THEN
		sbmensa := 'Error al enviar el correo del proceso LDCREASCO. '||SQLERRM;
		ldc_proactualizaestaprog(nutsess,sbmensa,'ENVIACORREO','ERROR.');
	END;


    BEGIN
        nuano  := to_char(dtfeini,'YYYY');
        numes  := to_char(dtfeini,'MM');

        SELECT userenv('SESSIONID'),USER INTO nutsess,sbparuser FROM dual;

        ldc_proinsertaestaprog(nuano,numes,'ldc_pkInfoAuditoria Hilo ' || nuHilo,'En ejecucion',nutsess,sbparuser);

        IF CurData%ISOPEN THEN
            CLOSE CurData;
        END IF;

        OPEN CurData;

        LOOP
            FETCH CurData BULK COLLECT INTO vrt_Data LIMIT nuLimit;

            FOR I IN 1 .. vrt_Data.COUNT LOOP
                --BEGIN
                nuCiclo := null;
                nuCiclo := daperifact.fnugetpefacicl(PKTBLFACTURA.FNUGETFACTPEFA(vrt_Data(I).FACTURA), 0);

                insert into LDC_INFCARGOSAUD (ano , mes,
                                          tido, timo,
                                          desc_timo, servicio,
                                          contrato, cuenta,
                                          fech_fact, concepto ,
                                          clas_cont, causal,
                                          fecha_cargo, valor_cargo,factura, PERIODO_FACT, orden, ciclo)
                values
                              (nuano, numes,
                              vrt_Data(I).A_tido, vrt_Data(I).B_timo,
                              vrt_Data(I).C_desc_timo , vrt_Data(I).TIPO_PRODUCTO ,
                              vrt_Data(I).CONTRATO , vrt_Data(I).CUENTA_COBRO ,
                              vrt_Data(I).FECHA_GENERACION , vrt_Data(I).CONCEPTO,
                              vrt_Data(I).concclco , vrt_Data(I).CAUSAL_CARGO ,
                              vrt_Data(I).FECHA_CREACION_CARGO , vrt_Data(I).VALOR,
                              vrt_Data(I).FACTURA, vrt_Data(I).PERIODO_FACT,
                               vrt_Data(I).orden_construccion, nuCiclo);

                nucont := nucont + 1;
                if mod(nucont,0) = nuCommit then
                    commit;
                end if;
          /*EXCEPTION
            WHEN OTHERS THEN
              dbms_output.put_Line(SQLERRM);
          END;*/
            END LOOP;
            EXIT WHEN CurData%NOTFOUND;
        END LOOP;

        CLOSE CurData;
        commit;
        dbms_session.free_unused_user_memory;

        IF FBLAPLICAENTREGAXCASO('0000863') THEN

			if nuHilo= 1 then
				OPEN cuultregHilo1(nuano,numes);
				FETCH cuultregHilo1 INTO nuUltregHilo1;
				CLOSE cuultregHilo1;

				ActualizaHilo1(nuUltregHilo1);

			end if;

			if nuHilo= 2 then
				OPEN cuultregHilo2(nuano,numes);
				FETCH cuultregHilo2 INTO nuUltregHilo2;
				CLOSE cuultregHilo2;

				ActualizaHilo2(nuUltregHilo2);

			end if;


        END IF;


        ldc_proactualizaestaprog(nutsess,'Ok','ldc_pkInfoAuditoria Hilo ' || nuHilo,'Termino Ok');

    EXCEPTION
        WHEN others THEN
            ldc_proactualizaestaprog(nutsess,'Error','ldc_pkInfoAuditoria Hilo ' || nuHilo,'Termino con Error: ' || SQLERRM);

    END proInfoAuditoria;
  --------------------------------------------------------------------------
  procedure PRGENJOBINFAUD (nuAno number, nuMes number) is
	  /**************************************************************************
		  Autor       : Horbath
		  Fecha       : 29/10/2021
		  Ticket      : 863
		  Descripcion : Proceso que genera 2 Jobs para el procedimiento ldc_pkInfoAuditoria.proInfoAuditoria
						para el mes y a¿o recibidos como par¿metros.


		  HISTORIA DE MODIFICACIONES
		  FECHA        AUTOR       DESCRIPCION
		***************************************************************************/

		nutsess   NUMBER;
		sbparuser VARCHAR2(100);
		nuJob number;
		sbWhat varchar2(2000) ;
		numes31 number;
		nuHilo01 number := 1;
		dtFecIni01 date;
		dtFecFin01 date;
		nuHilo02 number := 2;
		dtFecIni02 date;
		dtFecFin02 date;

		CURSOR cumes31 IS
			SELECT count(1)
			FROM TABLE(open.ldc_boutilities.splitstrings('1,3,5,7,8,10,12' ,','))
			where to_number(COLUMN_VALUE)=nuMes;




	  begin
		IF FBLAPLICAENTREGAXCASO('0000863') THEN

			SELECT userenv('SESSIONID'),USER INTO nutsess,sbparuser FROM dual;
			ldc_proinsertaestaprog(nuAno,nuMes,'PRGENJOBINFAUD','En ejecucion',nutsess,sbparuser);

			dtFecIni01 := to_date('01/'||nuMes||'/'||nuAno,'dd/mm/yyyy');
			dtFecFin01 := to_date('15/'||nuMes||'/'||nuAno,'dd/mm/yyyy');
			dtFecIni02 := to_date('16/'||nuMes||'/'||nuAno,'dd/mm/yyyy');

			OPEN cumes31;
			FETCH cumes31 INTO numes31;
			CLOSE cumes31;

			if numes31 =1 then
				dtFecFin02 := to_date('31/'||nuMes||'/'||nuAno,'dd/mm/yyyy');
			else
				if nuMes = 2 then
          if nuAno in (2024, 2028, 2032, 2036, 2040, 2044, 2052, 2056) then
            dtFecFin02 := to_date('29/'||nuMes||'/'||nuAno,'dd/mm/yyyy');
          else
					  dtFecFin02 := to_date('28/'||nuMes||'/'||nuAno,'dd/mm/yyyy');
          end if;
				else
					dtFecFin02 := to_date('30/'||nuMes||'/'||nuAno,'dd/mm/yyyy');
				end if;
			end if;

			DELETE FROM LDC_INFCARGOSAUD WHERE ANO=nuAno AND MES=nuMes;
			COMMIT;

			sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
					  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo01 || ',' ||
					  chr(10) || '                                to_date(''' ||
					  to_char(dtFecIni01, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
					  chr(10) || '                                to_date(''' ||
					  to_char(dtFecFin01, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
					  chr(10) || 'END;';
			dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
			commit;
		 --dbms_output.put_line(sbWhat);

		  sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
					  chr(10) || '   ldc_pkInfoAuditoria.proInfoAuditoria(' || nuHilo02 || ',' ||
					  chr(10) || '                                to_date(''' ||
					  to_char(dtFecIni02, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
					  chr(10) || '                                to_date(''' ||
					  to_char(dtFecFin02, 'DD/MM/YYYY  HH24:MI:SS') || '''));' ||
					  chr(10) || 'END;';
			dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
			commit;


			ldc_proactualizaestaprog(nutsess,'Ok','PRGENJOBINFAUD','Termino Ok');

		end if;

	end PRGENJOBINFAUD;
  --------------------------------------------------------------------------
  --------------------------------------------------------------------------
  PROCEDURE PRVALINFAUD IS
	/*****************************************************************
		Autor       :  Horbath
		Fecha       : 2021/10/26
		Ticket      : 863
		Descripcion : Procedimiento que se encargara de validar si los campos recibidos en la forma LDCINFAUD est¿n llenos
						y que no tenga un registro en la tabla LDC_REGINFAUD con los campos hilo1 o hilo2 igual a 0.

	  Historia de Modificaciones
	  Fecha         TICKET		    Autor             Modificacion
	  =========     =========  	    =========         ====================
	  ******************************************************************/

		sbRuta     		ge_boInstanceControl.stysbValue;
		sbMES     		ge_boInstanceControl.stysbValue;
		sbANO     		ge_boInstanceControl.stysbValue;
		SBPATHFILE      GE_DIRECTORY.PATH%TYPE;
		errorNumber		NUMBER;
		errorMessage	VARCHAR2(4000);
		Nuvalproc 		NUMBER;

		CURSOR cuvalproc (nuAno number, nuMes number) is
			select count(1)
			from LDC_REGINFAUD
			where (HILO1=0 or HILO2=0)
			and ANO= nuAno
			and MES= nuMes;

	BEGIN
		UT_TRACE.TRACE('[PRVALINFAUD] INICIO',99);
		--Se obtienen los datos de la forma LDCINFAUD

		IF FBLAPLICAENTREGAXCASO('0000863') THEN

			sbRuta		:= ge_boinstancecontrol.fsbgetfieldvalue('GE_DIRECTORY','DIRECTORY_ID');
			sbANO	 	:= ge_boinstancecontrol.fsbgetfieldvalue('LDC_OSF_SESUCIER','NUANO');
			sbMES	 	:= ge_boinstancecontrol.fsbgetfieldvalue('LDC_OSF_SESUCIER','NUMES');
			UT_TRACE.TRACE('[PRVALINFAUD] sbRuta: '||sbRuta,99);
			UT_TRACE.TRACE('[PRVALINFAUD] sbANO: '||sbANO,99);
			UT_TRACE.TRACE('[PRVALINFAUD] sbMES: '||sbMES,99);
			SBPATHFILE     := DAGE_DIRECTORY.FSBGETPATH(sbRuta);
			UT_TRACE.TRACE('[PRVALINFAUD] SBPATHFILE: '||SBPATHFILE,99);

			if (sbANO is null) then
					Errors.SetError (2126, 'A¿o');
					raise ex.CONTROLLED_ERROR;
			end if;

			if (sbMES is null) then
					Errors.SetError (2126, 'Mes');
					raise ex.CONTROLLED_ERROR;
			end if;

			OPEN cuvalproc(to_number(sbANO),to_number(sbMES));
			FETCH cuvalproc INTO Nuvalproc;
			CLOSE cuvalproc;

			if Nuvalproc = 1 then
				  Errors.SetError (2741, 'ya se encuentra un proceso para el a¿o: '||sbANO||' y mes: '||sbMES);
				  raise ex.CONTROLLED_ERROR;
			end if;

			INSERT INTO LDC_REGINFAUD (REGINFAUD_REG, ANO, MES, HILO1, HILO2, RUTA, PERSON_ID)
			VALUES (SEQ_LDC_REGINFAUD.nextval, to_number(sbANO), to_number(sbMES), 0, 0, SBPATHFILE, ge_bopersonal.fnuGetPersonId);

		END IF;


		UT_TRACE.TRACE('[PRVALINFAUD] FIN',99);
	  EXCEPTION
			when ex.CONTROLLED_ERROR then
				raise;
			when OTHERS then
				Errors.setError;
				raise ex.CONTROLLED_ERROR;
	END PRVALINFAUD;
  --------------------------------------------------------------------------
  --------------------------------------------------------------------------

  procedure PRGENARCHINFAUD (nuAno number, nuMes number, sbRuta varchar2,persona number) is
	/*******************************************************************************
	  Propiedad intelectual de PROYECTO GASES DEL CARIBE

	  Autor         : horbath
	  Fecha         : 27-10-2021
	  CASO          : 863
	  DESCRIPCION   : procedmineto para generar un archivo plano en la ruta recibida
					  como par¿metro con la informaci¿n de la tabla ¿LDC_INFCARGOSAUD¿


	  Fecha                IDEntrega           Modificacion
	  ============    ================    ============================================
          17/01/2022	  CRM_HT_0000863_3	Se amplia la variable sbRutaGen a varchar2(1000),
						Realizado por  Danilo Barranco Leyva
	  *******************************************************************************/
	nutsess   NUMBER;
	sbparuser VARCHAR2(100);
	sbNombre_Archivo Varchar2(100) ;

	F            UTL_FILE.FILE_TYPE;
	sbEncabezado Varchar2(4000);
	nuCupo       Number;
	nuCupoTotal  Number;
	nuLimit      Number := 500;
	NOMBRE_BD    VARCHAR2(30);
	sbRutaGen    varchar2(1000);

	--sbRuta           Varchar2(100) := open.dald_parameter.fsbGetValue_Chain('IFRS_RUTA'); /*'/smartfiles/Brilla'*/

	sbEmpresa        Varchar2(100) := 'GDC';


	CURSOR CurData  is
	select *
	from open.LDC_INFCARGOSAUD i
	where i.ano=nuano
	and i.mes=numes;

	TYPE rt_Data IS TABLE of CurData%ROWTYPE INDEX BY BINARY_INTEGER;
	vrt_Data rt_Data;

	PROCEDURE enviacorreo (message    VARCHAR2,nuCAno number,nuCMes number, perso number)  IS

		nutsess      NUMBER;
		sbmensa      VARCHAR2(1000);
		sbemail 	 VARCHAR2(100);
		sbparuser    VARCHAR2(30);

		cursor cuCorreoperson  is
		 SELECT E_MAIL
		 FROM GE_PERSON
		 WHERE PERSON_ID= perso;

	BEGIN
		SELECT userenv('SESSIONID'),USER   INTO nutsess,sbparuser FROM dual;

		IF FBLAPLICAENTREGAXCASO('0000863') THEN
			ldc_proinsertaestaprog(nuAno,nuMes,'ENVIACORREO','En ejecucion',nutsess,sbparuser);
			OPEN cuCorreoperson;
			FETCH cuCorreoperson INTO sbemail;
			CLOSE cuCorreoperson;

			if sbemail is not null then
				LDC_SENDEMAIL (sbemail, 'Se notifica que ha finalizado el proceso LDCGENDATACARGOS '||chr(45)||' Generaci'||chr(243)||'n de Data de Cargos para el periodo:'||nuCAno||'/'||nuCMes,  message) ;
				ldc_proactualizaestaprog(nutsess,'Envia correo','ENVIACORREO','Termino Ok.');
			else
				ldc_proactualizaestaprog(nutsess,'No se encontro correo configurado','ENVIACORREO','ERROR.');
			end if;

		END IF;
	EXCEPTION
	 WHEN OTHERS THEN
		sbmensa := 'Error al enviar el correo del proceso LDCREASCO. '||SQLERRM;
		ldc_proactualizaestaprog(nutsess,sbmensa,'ENVIACORREO','ERROR.');
	END;




  begin
		IF FBLAPLICAENTREGAXCASO('0000863') THEN
			UT_TRACE.TRACE('[PRGENARCHINFAUD] Inicio',99);
			SELECT userenv('SESSIONID'),USER INTO nutsess,sbparuser FROM dual;
			ldc_proinsertaestaprog(nuAno,nuMes,'PRGENARCHINFAUD','En ejecucion',nutsess,sbparuser);
			sbNombre_Archivo := 'Cargos_'||nuMes||'_'||nuAno;
			sbEncabezado := 'A¿O|MES|TIPODOC|TIPOMOV|DESCTIPOMOV|SERVICIO|CONTRATO|NATURALEZA|FACTURA|PERIODO|CUENTA|FECHA_FACT|CONCEPTO|CLASIF_CONT|CAUSAL|FECHA_CARGO|VALOR|ORDEN|CICLO';

			NOMBRE_BD := UT_DBINSTANCE.FSBGETCURRENTINSTANCETYPE;
			if NOMBRE_BD = 'B' THEN
                sbRutaGen:='XML_DIR';
            else
                sbRutaGen:=sbRuta;
            END IF;

			dbms_session.free_unused_user_memory;
			F                := UTL_FILE.FOPEN(sbRutaGen,
												 sbNombre_Archivo,
												 'W',
												 32767);
			  UTL_FILE.PUT_LINE(F, sbEncabezado);
			  IF CurData%ISOPEN THEN
				CLOSE CurData;
			  END IF;
			  OPEN CurData;
			  LOOP
				FETCH CurData BULK COLLECT
				  INTO vrt_Data LIMIT nuLimit;
				FOR I IN 1 .. vrt_Data.COUNT LOOP
				  --BEGIN
					UTL_FILE.PUT_LINE(F,
									  nuano || '|' || numes || '|' ||
									  vrt_Data(I).tido || '|' || vrt_Data(I).timo || '|' ||
									  vrt_Data(I).desc_timo || '|' || vrt_Data(I).servicio || '|' ||
									  vrt_Data(I).contrato || '|' ||  vrt_Data(I).naturaleza || '|' || vrt_Data(I).factura || '|' ||
									  vrt_Data(I).periodo_fact || '|' ||  vrt_Data(I).cuenta || '|' ||
									  vrt_Data(I).fech_fact || '|' || vrt_Data(I).concepto || '|' ||
									  vrt_Data(I).clas_cont || '|' || vrt_Data(I).causal || '|' ||
									  vrt_Data(I).fecha_cargo || '|' || vrt_Data(I).valor_cargo || '|' || vrt_Data(I).orden || '|' || vrt_Data(I).ciclo );
				  /*EXCEPTION
					WHEN OTHERS THEN
					  dbms_output.put_Line(SQLERRM);
				  END;*/
				END LOOP;
				EXIT WHEN CurData%NOTFOUND;
			  END LOOP;
			  CLOSE CurData;
			  dbms_session.free_unused_user_memory;
			  UTL_FILE.FCLOSE(F);
			  dbms_output.put_Line('Proceso Ok');

			  enviacorreo('<p>Termino el proceso de la forma LDCINFAUD para el mes: '|| nuMes ||' del a&' || 'ntilde;o: '||nuAno||' y se gener&' ||'oacute; el archivo:'||sbNombre_Archivo||', en la siguiente ruta:'||sbRuta||'</p>'
			  ,nuAno,nuMes,persona);
			  ldc_proactualizaestaprog(nutsess,'Ok','PRGENARCHINFAUD','Termino Ok');

		end if;

		UT_TRACE.TRACE('[PRGENARCHINFAUD] Fin',99);
  EXCEPTION
		WHEN UTL_FILE.INTERNAL_ERROR THEN

		  UT_TRACE.TRACE('[PRGENARCHINFAUD] Error: UTL_FILE: Ha ocurrido un error interno.',99);
		  ldc_proactualizaestaprog(nutsess,'UTL_FILE: Ha ocurrido un error interno.','PRGENARCHINFAUD','Termino Con error');
		  enviacorreo( 'UTL_FILE: Ha ocurrido un error interno.',nuAno,nuMes,persona);
		  UTL_FILE.FCLOSE_ALL;
		WHEN UTL_FILE.INVALID_FILEHANDLE THEN

		  UT_TRACE.TRACE('[PRGENARCHINFAUD] Error: UTL_FILE: El identificador del archivo no es v?lido.',99);
		  ldc_proactualizaestaprog(nutsess,'UTL_FILE: El identificador del archivo no es v?lido.','PRGENARCHINFAUD','Termino Con error');
		  enviacorreo( 'UTL_FILE: El identificador del archivo no es v?lido.',nuAno,nuMes,persona);
		  UTL_FILE.FCLOSE_ALL;
		WHEN UTL_FILE.INVALID_MODE THEN

		  UT_TRACE.TRACE('[PRGENARCHINFAUD] Error: UTL_FILE: Se dio un modo abierto inv?lido.',99);
		  ldc_proactualizaestaprog(nutsess,'UTL_FILE: Se dio un modo abierto inv?lido.','PRGENARCHINFAUD','Termino Con error');
		  enviacorreo( 'UTL_FILE: Se dio un modo abierto inv?lido.',nuAno,nuMes,persona);
		  UTL_FILE.FCLOSE_ALL;
		WHEN UTL_FILE.INVALID_OPERATION THEN

		  UT_TRACE.TRACE('[PRGENARCHINFAUD] Error: UTL_FILE: Se intent? una operaci?n no v?lida.',99);
		  ldc_proactualizaestaprog(nutsess,'UTL_FILE: Se intent? una operaci?n no v?lida.','PRGENARCHINFAUD','Termino Con error');
		  enviacorreo( 'UTL_FILE: Se intent? una operaci?n no v?lida.',nuAno,nuMes,persona);
		  UTL_FILE.FCLOSE_ALL;
		WHEN UTL_FILE.INVALID_PATH THEN

		  UT_TRACE.TRACE('[PRGENARCHINFAUD] Error: Se dio una ruta inv?lida para el archivo.',99);
		  ldc_proactualizaestaprog(nutsess,'UTL_FILE: Se dio una ruta inv?lida para el archivo.','PRGENARCHINFAUD','Termino Con error');
		  enviacorreo( 'UTL_FILE: Se dio una ruta inv?lida para el archivo.',nuAno,nuMes,persona);
		  UTL_FILE.FCLOSE_ALL;
		WHEN UTL_FILE.READ_ERROR THEN

		  UT_TRACE.TRACE('[PRGENARCHINFAUD] Error: UTL_FILE: A read error occurred.',99);
		  ldc_proactualizaestaprog(nutsess,'UTL_FILE: A read error occurred.','PRGENARCHINFAUD','Termino Con error');
		  enviacorreo( 'UTL_FILE: A read error occurred.',nuAno,nuMes,persona);
		  UTL_FILE.FCLOSE_ALL;
		WHEN UTL_FILE.WRITE_ERROR THEN

		  UT_TRACE.TRACE('[PRGENARCHINFAUD] Error: UTL_FILE: A write error occurred.',99);
		  ldc_proactualizaestaprog(nutsess,'UTL_FILE: A write error occurred.','PRGENARCHINFAUD','Termino Con error');
		  enviacorreo( 'UTL_FILE: A write error occurred.',nuAno,nuMes,persona);
		  UTL_FILE.FCLOSE_ALL;
		WHEN others THEN
		  UT_TRACE.TRACE('[PRGENARCHINFAUD] Error: Some other error occurred. ' || SQLERRM,99);
		  ldc_proactualizaestaprog(nutsess,'Some other error occurred. ' || SQLERRM,'PRGENARCHINFAUD','Termino Con error');
		  enviacorreo( 'UTL_FILE: Some other error occurred.',nuAno,nuMes,persona);
		  UTL_FILE.FCLOSE_ALL;

  end PRGENARCHINFAUD;

  --------------------------------------------------------------------------



end ldc_pkInfoAuditoria;
/
