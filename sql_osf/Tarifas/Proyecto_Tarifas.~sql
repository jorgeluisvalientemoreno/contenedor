--Proyecto Tarifa
select *
  from open.TA_PROYTARI
 where 1 = 1
--and prtacons in (8711, 8733, 8734)
 order by prtafech desc;

select tp.prtacons Proyecto_Tarifa,
       tp.prtadesc Descripcion,
       tp.prtaserv servicio,
       tp.prtadocu Documento,
       tp.prtaesta || ' - ' || tep.esprdesc Estado,
       tp.prtafech Fecha_Creacion,
       tp.prtausua || ' - ' || gp.name_ Usuario,
       tp.prtaterm Terminal,
       tp.prtaobse Observacion
  from open.ta_proytari tp
  left join open.ta_estaproy tep
    on tep.esprcons = tp.prtaesta
  left join open.sa_user sa
    on sa.mask = tp.prtausua
  left join open.ge_person gp
    on gp.user_id = sa.user_id
 where tp.prtacons in (12351);

--TARIFAS ASOCIADAS A UN PROYECTO TARIFAS
select tcp.tacptacc Codigo_Tarifa,
       tcp.tacpdesc Descripcion,
       tcp.tacptimo Tipo_Moneda,
       tcp.tacpreso Resolucion,
       tcp.tacpprog Programa,
       tcp.tacpterm Terminal,
       tcp.tacpusua || ' - ' || gp.name_ Usuario
  from open.TA_TARICOPR tcp
  left join open.sa_user sa
    on sa.mask = tcp.tacpusua
  left join open.ge_person gp
    on gp.user_id = sa.user_id
 where 1 = 1
   and tcp.tacpprta in (12351)
   and tcp.tacptacc = 4384 --Codigo Tarifa
 order by tcp.tacptacc asc, tcp.tacpcotc asc;

--CRITERIOS ASOCIADAS A UN PROYECTO TARIFAS
select tcp.tacptacc Codigo_Tarifa,
       tcp.tacpsesu Producto,
       tcp.tacpsusc Contrato,
       tcp.tacpcr03 Mercado_Relevante,
       tcp.tacpcr02 || ' - ' || c.catedesc Categoria,
       tcp.tacpcr01 || ' - ' || sc.sucadesc
  from open.TA_TARICOPR tcp
  left join open.categori c
    on c.catecodi = tcp.tacpcr02
  left join open.subcateg sc
    on sc.sucacate = tcp.tacpcr02
   and sc.sucacodi = tcp.tacpcr01
 where 1 = 1
   and tcp.tacpprta in (12351)
   and tcp.tacptacc = 4384 --Codigo Tarifa
 order by tcp.tacptacc asc, tcp.tacpcotc asc;

SELECT ta_taricopr.*
  FROM ta_proytari, ta_taricopr
 WHERE ta_proytari.prtacons = 12351
   AND ta_proytari.prtacons = ta_taricopr.tacpprta;

--VIGENCIAS DE TARIFA CONCEPTO POR PROYECTO (BASE)
select t.*, rowid
  from open.TA_VIGETACP t
 where 1 = 1
   and t.vitptipo = 'B'
   and t.vitptacp = 12351
--and sysdate between t.vitpfein and t.vitpfefi
 order by t.vitpfein;

--VIGENCIAS DE TARIFA CONCEPTO POR PROYECTO (TIPO TRABAJO)
select t.*, rowid
  from open.TA_VIGETACP t
 where 1 = 1
   and t.vitptipo = 'T'
   and t.vitptacp = 12351
--and sysdate between t.vitpfein and t.vitpfefi
 order by t.vitpfein;

--RANGOS DE VIGENCIA DE TARIFA POR PROYECTO 
select a.*, rowid
  from OPEN.TA_RANGVITP a
 where 1 = 1
   and a.ravpvitp in (23544, 23543);

--CONFIGURAR TARIFA POR CONCEPTO PARA VENTAS
select tv.*
  from ta_conftaco t
  left join ta_tariconc ta
    on cotccons = tacocotc
  left join open.ta_vigetaco tv
    on tacocons = tv.vitctaco
  left join open.concepto c
    on cotcconc = c.conccodi
 where 1 = 1
   and vitctaco = 4384 --Codigo Tarifa
      --and cotcconc = 17 --Concepto
   and sysdate between tv.vitcfein and tv.vitcfefi
 order by tv.vitcfein desc;
