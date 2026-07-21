--Punto atencion - Medio Receprion
SELECT su.mask USUARIO,
       gp.name_ NOMBRE,
       a.organizat_area_id || ' - ' || a.display_description Punto_Atencion,
       oourt.reception_type_id || ' - ' || grt.description Medio_Recepcion
  FROM open.ge_organizat_area a
 inner join open.cc_orga_area_seller b
    on a.organizat_area_id = b.organizat_area_id
--AND b.IS_CURRENT = 'Y' --Punto Activo
 inner join OPEN.GE_PERSON gp
    on b.person_id in gp.person_id
 inner join open.sa_user su
    on gp.user_id = su.user_id
   and (upper(su.mask) like upper('%NEHSAR%') or
       upper(su.mask) like upper('%EDUCAB%')) --NEHEMIAS SARABI
 inner join open.or_ope_uni_rece_type oourt
    on oourt.operating_unit_id = a.organizat_area_id
 inner join open.ge_reception_type grt
    on grt.reception_type_id = oourt.reception_type_id
 order by su.mask, a.organizat_area_id, oourt.reception_type_id;

--Punto atencion
SELECT su.mask,
       a.organizat_area_id || ' - ' || a.display_description Punto_Atencion
  FROM open.ge_organizat_area a
 inner join open.cc_orga_area_seller b
    on a.organizat_area_id = b.organizat_area_id
 inner join OPEN.GE_PERSON gp
    on b.person_id in gp.person_id
 inner join open.sa_user su
    on gp.user_id = su.user_id
   and (upper(su.mask) like upper('%OLGGAR%') or
       upper(su.mask) like upper('%FRAGUZ%'));

--Medio de recepcion
SELECT r.RECEPTION_TYPE_ID id, r.description, r.*, o.*, u.*
  FROM open.ge_reception_type    r,
       open.or_ope_uni_rece_type o,
       open.or_operating_unit    u
 WHERE 1 = 1
   and r.RECEPTION_TYPE_ID <> -1 --GE_BOPARAMETER.fnuGet('EXTERN_RECEPTION')
      --and r.RECEPTION_TYPE_ID = :RECEPTION_ID
      --and r.description like :DESCRIPTION
   and r.reception_type_id = o.reception_type_id
   and o.operating_unit_id = u.operating_unit_id
   and u.operating_unit_id = 36; -- ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES','POS_OPER_UNIT_ID');

SELECT A.*
  FROM open.CC_ORGA_AREA_SELLER A
 WHERE A.PERSON_ID in
       (select gp.person_id
          from OPEN.GE_PERSON gp
         inner join open.sa_user su
            on gp.user_id = su.user_id
         where upper(su.mask) like upper('%FRAGUZ%'))
   AND A.IS_CURRENT = 'Y';
-- GE_BOCONSTANTS.CSBYES;

--SELECT   a.person_id ID, a.name_ DESCRIPTION FROM   GE_PERSON a
/*
       select oourt.*, rowid
         from open.or_ope_uni_rece_type oourt
        where oourt.operating_unit_id = (PKG_BOPERSONAL.fnuGetPuntoAtencionId(1));
       delete open.or_ope_uni_rece_type oourt
        where oourt.operating_unit_id = (PKG_BOPERSONAL.fnuGetPuntoAtencionId(1));
       commit;
       --*/
select oourt.*, rowid
  from open.or_ope_uni_rece_type oourt
 where oourt.operating_unit_id = (PKG_BOPERSONAL.fnuGetPuntoAtencionId(1));

--1 34710 2470  20  AACI6UAAyAAABmxACI
