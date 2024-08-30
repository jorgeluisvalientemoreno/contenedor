use catalog production;

with cierre_sap_febrero as(
select sum(decode(SHKZG,'H',-1,'S',1,0)*(DMBTR)*100) valor
 from sap.BSEG b
where BUKRS='GDCA'
  and HKONT in ('1518900200','1518900300')
  and sap.formattodate(BUDAT)<DATE('2024-03-01')
  )
, movimientos_meses as(select sum(decode(SHKZG,'H',-1,'S',1,0)*(DMBTR)*100) valor
 from sap.BSEG b
where BUKRS='GDCA'
  and HKONT in ('1518900200','1518900300')
  and sap.formattodate(BUDAT)>=DATE('2024-03-01')
  and sap.formattodate(BUDAT)<DATE('2024-04-01')
)
, cierre_osf(
    select round(sum(b.COSTO_BODEGA)) valor
 from osfgdc.LDC_OSF_LDCRBAI b
 where fec_corte=to_Date('01/04/2024','dd/MM/yyyy')

)
select  valor  , (select m.valor from movimientos_meses m) movimientos , (select c.valor from cierre_osf c) osf
from cierre_sap_febrero
;---falta agregar transito
