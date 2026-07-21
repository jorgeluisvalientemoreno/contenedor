--(Concepto) 
select a.conccodi "codigo concepto",
       a.concdesc "descripcion",
       a.conccoco,
       a.concorli "orden liquidacion",
       a.concpoiv "porcentaje iva",
       a.concorim "orden impresion",
       a.concorge "orden de generacion",
       a.concdife "flag de diferible",
       a.conccore "concepto de refinanciacion",
       a.conccoin "Interes de financiacion",
       DECODE(a.concflde,
              'G',
              'G - Generacion de cargos',
              'F',
              'F - Facturacion cruzada',
              'S',
              'S - Solicitudes') "Etapa de ejecucion",
       a.concunme "Unidades de medida",
       a.concdefa "Concepto en impresion ",
       a.concflim "Flag impresion factura",
       a.concsigl "Sigla del concepto ",
       a.conctico || ' - ' || tc.ticodesc "concepto en impresion ",
       a.concnive "Nivel de proceso ",
       a.concclco "Clasificador contable ",
       DECODE(a.concticc, 'A', 'A - Cargo basico', 'C', 'C - Consumo') "Forma de liquidar",
       a.concticl "Tipo concepto de liquidacion",
       a.concappr "Aplica para presupuesto",
       DECODE(a.conccone, 'S', 'S - Negociable', 'N', 'N - No negociable') "Es negociable",
       DECODE(a.concapcp, 'S', '[S]-Si', 'N', '[N]-No') "Aplica Cambio de Plan"
  from open.CONCEPTO a
  left join OPEN.TIPOCONC tc
    on tc.ticocodi = a.conctico
 where
--a.concdesc like '%RECA%MORA%'
 a.conccodi in (1086, 203);
---Concepto Base 
select cb.coblconc || ' - ' || cgenerado.concdesc Concepto_generado,
       cb.coblcoba || ' - ' || c.concdesc Concepto_base
  from open.concbali cb
 inner join open.concepto c
    on c.conccodi = cb.coblcoba
 inner join open.concepto cgenerado
    on cgenerado.conccodi = cb.coblcoba
 where cb.coblcoba in (1086, 203);
select * from open.concbali c where c.coblcoba in (1086, 203);
select * from open.concbali c where c.coblconc in (1086, 203); --30,291,282,287,985); 
--(Concepto ciclo/facturación) 
select * from open.CONCCICL a where a.cociconc = 25;
--(Concepto por fecha por servicio suscrito)  
select * from open.CONCFESS a where a.cfssconc = 25;
--(Concepto por fecha contrato)  
select * from open.CONCFESU a where a.cofsconc = 25;
--(Concepto plan contrato)  
select * from open.CONCPLSU a where a.copsconc = 25;
--(Concepto por servicio)  
select * from open.CONCSERV a where a.coseconc = 25;
--(Concepto por servicio suscrito)  
select * from open.CONCSESU a where a.cossconc = 25;
--(Fecha de Última Liquidación por Concepto)  
select * from open.FEULLICO a where a.feliconc = 25;
--(Tipos de Conceptos de Liquidación) 
select * from open.TIPOCOLI a;
