--Punto atencion (Area Organizacional)
SELECT a.organizat_area_id || ' - ' || a.name_ Punto_Atencion,
       a.geo_area_father_id || ' - ' || GGL.NAME_ Area_Padre,
       --a.organizat_area_type Tipo_Area,
       decode(b.is_current, 'Y', 'Y - Si', 'N - No') Punto_Activo,
       b.person_id || ' - ' || su.mask || ' - ' || gp.name_ Funcional
  FROM open.ge_organizat_area   a,
       open.cc_orga_area_seller b,
       open.ge_person           gp,
       open.sa_user             su,
       OPEN.GE_ORGANIZAT_AREA   GGL
 WHERE 1 = 1
   and a.organizat_area_id = b.organizat_area_id
   and gp.person_id = b.person_id
      ---and upper(gp.name_) like upper('%MONICA%OLIVELLA%')
   AND b.person_id = gp.person_id
   and gp.user_id = su.user_id
   --and b.organizat_area_id in (5147, 5201, 5200, 5201)
   AND GGL.ORGANIZAT_AREA_ID = a.geo_area_father_id
--and upper(su.mask) like upper('%MON%')
 order by a.organizat_area_id;

--ge_boinstancecontrol.fsbGetFieldValue('MO_PACKAGES', 'PERSON_ID')

--Punto de atencion
select aor.*, rowid
  from open.ge_organizat_area aor
 where aor.organizat_area_id in
       (select coas.organizat_area_id
          from OPEN.CC_ORGA_AREA_SELLER coas
          left join OPEN.GE_PERSON gp
            on gp.person_id = coas.person_id
          left join open.sa_user su
            on gp.user_id = su.user_id
         where upper(su.mask) like upper('%MON%'));

SELECT a.organizat_area_id id, a.display_description description
  FROM ge_organizat_area a, cc_orga_area_seller b
 WHERE a.organizat_area_id = b.organizat_area_id
   AND b.person_id =
       ge_boinstancecontrol.fsbGetFieldValue('MO_PACKAGES', 'PERSON_ID');

--Punto de atencion activo
select coas.*, rowid
  from OPEN.CC_ORGA_AREA_SELLER coas
 where coas.person_id in
       (select gp.person_id
          from OPEN.GE_PERSON gp
          left join open.sa_user su
            on gp.user_id = su.user_id
         where upper(su.mask) like upper('%JHOESC%'));
select *
  from ge_organizat_area aor
 where aor.organizat_area_id = (PKG_BOPERSONAL.fnuGetPuntoAtencionId(1));
select a.*, rowid from OPEN.CC_ORGA_AREA_SELLER a where a.person_id = 1;
/*
update OPEN.CC_ORGA_AREA_SELLER a
   set a.is_current = 'N'
 where a.person_id = 1;
commit;
*/
