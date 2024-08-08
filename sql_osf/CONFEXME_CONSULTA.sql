--CONFEXME (Plantilla + Formato)
--select * from open.ed_confexme a order by a.coemcodi desc;
select * from open.ed_confexme a where a.coemcodi IN (95,59);
--select * from open.ed_confexme a where a.coemdesc like '%LDC_%VENTA%';

--Plantilla
select *
  from open.ed_plantill w
 where w.plannomb /*= 'LDC_FACTFIS_CONST'*/
       IN
       (select A.COEMPADI from open.ed_confexme a where a.coemcodi IN (95,59));
--Formato;
select *
  from open.ed_formato b
 where
--b.formdesc like '%LDC_FACTFISC_VENTA_CONS%'
 '<' || b.formcodi || '>' IN
 (select A.COEMPADA from open.ed_confexme a where a.coemcodi IN (95,59));
