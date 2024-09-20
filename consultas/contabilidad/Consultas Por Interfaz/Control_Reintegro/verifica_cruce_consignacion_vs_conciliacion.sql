select * from open.docusore d where d.dosrconc = 31775;
select * from open.trbadosr a where a.tbdstrba = 6449;
select a.tbdstrba consignacion, d.dosrcodi conse, d.dosrconc conciliacion, a.tbdsvads vr_cruce, a.tbdsfere
  from open.docusore d, open.trbadosr a
 where a.tbdstrba = 6449 -- Consignaion
   and a.tbdsdosr = d.dosrcodi 
   and d.dosrtdsr = 1
   
