select *
from open.mo_packages
where package_id in (52292202, 51404375 );

select *
from open.gc_debt_negotiation
where package_id in (52292202, 51404375 );

select *
from open.cupon
where cuponume in (153738332,154962189);
select *
from open.pagos
where pagocupo in (153738332,154962189);

select *
from open.gc_debt_negotiation dn, open.gc_debt_negot_prod dnp, open.cc_financing_request fr
where dn.package_id=fr.package_id
and dn.debt_negotiation_id=dnp.debt_negotiation_id
and dn.package_id in (52292202, 51404375);

select *
from OPEN.Gc_Debt_Negot_Prod;

select *
from open.GC_DEBT_NEGOT_CHARGE;
select *
from open.cc_fin_req_concept;

select *
from OPEN.MO_PACKAGE_CHNG_LOG
WHERE PACKAGE_ID IN ( 51404375);

--21/04/2017 17:15:36 153738332

select REG_dATE
from OPEN.LDCI_LOGPAYMENTREG
WHERE REG_DATE>='21/04/2017 17:15:20'
  AND REG_DATE<'21/04/2017 17:16:00';
