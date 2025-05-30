SELECT copsplsu || ' - ' || cc.description Plan_Comercial,
       copsconc || ' - ' || c.concdesc Concepto,
       copsserv || ' - ' || o.servdesc Servicio,
       copsfufa Servicio_Regla,
       copsorge,
       copsacti Activo_Para_Facturar,
       copsflim Impresion_Factura,
       copsclco,
       copsregl Codigo_Regla,
       copsniro,
       copsfeli
  FROM open.concplsu cp
 inner join open.cc_commercial_plan cc
    on cc.commercial_plan_id = cp.copsplsu
 inner join open.concepto c
    on c.conccodi = cp.copsconc
 inner join open.servicio o
    on o.servcodi = cp.copsserv
 WHERE --copsfufa = 'FABCCT14E121047389'
--or 
 copsplsu in (286, 284, 156);

select a.*, rowid
  from OPEN.CONCSERV a
 where a.coseconc in (286, 284, 156)
 and a.coseserv = 7014
--and a.cosefufa = 'FABCCT14E121047389'
