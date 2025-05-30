--Punto de atencion
select aor.*, rowid
  from ge_organizat_area aor
 where aor.organizat_area_id in
       (select coas.organizat_area_id
          from OPEN.CC_ORGA_AREA_SELLER coas
          left join OPEN.GE_PERSON gp
            on gp.person_id = coas.person_id
          left join open.sa_user su
            on gp.user_id = su.user_id
         where upper(su.mask) like upper('%JHOESC%'));
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
