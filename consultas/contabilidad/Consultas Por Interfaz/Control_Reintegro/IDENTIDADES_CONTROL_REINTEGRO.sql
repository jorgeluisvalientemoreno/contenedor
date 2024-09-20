-- TRANSACCIONES BANCARIAS ANULADAS
select * from OPEN.RC_TRBAANUL t;
-- DETALLE TRANSACCIONES BANCARIAS ANULADAS
select * from open.RC_DETRBAAN;
-- DOCUMENTO SOPORTE DE RECAUDOS
select * from open.docusore d ;
-- TRANSACCIONES BANCARIAS POR DOCUMENTO SOPORTE
select * from open.trbadosr a;
-- UNION TRANSACCIONES BANC X DCTO SOPORTE Y DOCUMENTO SOPORTE DE RECAUDO
select a.tbdstrba consignacion, d.dosrcodi conse, d.dosrconc conciliacion, a.tbdsvads vr_cruce, a.tbdsfere
  from open.docusore d, open.trbadosr a
 where a.tbdstrba = 6449 -- Consignaion
   and a.tbdsdosr = d.dosrcodi 
   and d.dosrtdsr = 1;
-- TRANSACCIONES BANCARIAS
select * from open.tranbanc t;
