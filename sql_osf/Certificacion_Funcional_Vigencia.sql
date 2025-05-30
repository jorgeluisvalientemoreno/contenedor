select a.*, rowid from OPEN.LDC_NORMA a order by a.id_norma desc;
select a.*, rowid from OPEN.LDC_CERTIFICADO a where a.id_org_cert = 34;
select a.*, rowid
  from OPEN.LDC_CERTIFICADO a
 order by a.id_certificado desc;
select a.*, rowid
  from OPEN.LDC_CERTIFICADO a
 where sysdate between a.fecha_ini_vig and a.fecha_fin_vig
 order by a.id_certificado desc;
select a.*, rowid from OPEN.LDC_TITULACION a order by a.id_titulacion desc;
select a.*, rowid from OPEN.LDC_ORG_CERT a order by a.id_org_cert desc;
select a.*, rowid from OPEN.ldc_organismos a order by a.organismo_id desc;
