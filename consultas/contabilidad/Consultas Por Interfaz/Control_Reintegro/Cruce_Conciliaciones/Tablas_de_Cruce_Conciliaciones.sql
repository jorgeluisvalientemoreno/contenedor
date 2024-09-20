-- Consultas de cruce en Control Reintegro
select * from open.concilia c where c.conccons = 29817;  -- Numero de Conciliacion
-- Documeto soporte
select * from open.docusore d where d.dosrconc = 29817 and d.dosrtdsr = 1; -- Numero de Conciliacion
-- Transaccion bancaria por documento soporte.
select * from open.trbadosr t where t.tbdsdosr in (select d.dosrcodi from open.docusore d 
                                                    where d.dosrconc = 29817 
                                                      /*and d.dosrtdsr = 1*/); -- Numero de Conciliacion
-- Transaccion Bancaria
select * from open.tranbanc t 
 where t.trbacodi in (select ta.tbdsdosr  -- Numero de transaccion bancaria en documento soporte
                        from open.trbadosr ta
                       where ta.tbdsdosr in (select d.dosrcodi from open.docusore d 
                                              where d.dosrconc = 29817 -- Numero de Conciliacion
                                                and d.dosrtdsr = 1));

-----
-- OTRAS ENTIDADES
-----
RC_TRBADSAN: Transacciones bancarias por documentos de soporte anuladas
RC_TRBAANUL: Transacciones bancarias anuladas
RC_DETRBAAN: Detalle de transacciones bancarias anuladas


select * from open.concilia c where c.conccons in (136021);
select * from open.pagos p where p.pagoconc in (136021);
select t.tdsrdesc, d.* from open.docusore d, OPEN.TIDOSORE t
 where d.dosrconc in (136021) --131374,132604,132631,133494,133954,134233,135719,136021,136107,136274,136677,137365,137642,137765,137801,138489,138836,138841)
   and d.dosrtdsr = t.tdsrcodi
order by dosrconc, dosrtdsr;
--select d.* from open.docusore d where d.dosrtdsr = 2 and d.dosrfere >= '01-01-2018';
-- Transaccion bancaria por documento soporte.
select * from open.trbadosr t
 where t.tbdsdosr in (select d.dosrcodi from open.docusore d where d.dosrconc = 136021 /*and d.dosrtdsr = 1*/); -- Numero de Conciliacion
-- Transaccion Bancaria
select * from open.tranbanc t 
 where t.trbacodi in (select ta.tbdstrba  -- Numero de transaccion bancaria en documento soporte
                        from open.trbadosr ta
                       where ta.tbdsdosr in (select d.dosrcodi from open.docusore d 
                                              where d.dosrconc = 136021/* -- Numero de Conciliacion
                                                and d.dosrtdsr = 1*/));
select * 
  from open.trbadosr ta
 where ta.tbdstrba = 71734 
