--(Concepto) 
select *
  from open.CONCEPTO a
 where a.conccodi in (30, 291, 282, 287, 985, 795, 202);
---Concepto Base 
select cb.coblconc || ' - ' || cgenerado.concdesc Concepto_generado,
       cb.coblcoba || ' - ' || c.concdesc Concepto_base
  from open.concbali cb
 inner join open.concepto c
    on c.conccodi = cb.coblcoba
 inner join open.concepto cgenerado
    on cgenerado.conccodi = cb.coblcoba
 where cb.coblcoba in (291, 282, 991);
select * from open.concbali c where c.coblcoba in (282, 985);
select * from open.concbali c where c.coblconc in (291); --30,291,282,287,985); 
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
