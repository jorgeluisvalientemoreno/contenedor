--    nuPersonId:=GE_BOPERSONAL.FNUGETPERSONID;
--    nuUserId:=DAGE_PERSON.FNUGETUSER_ID(nuPersonId);
select *
  from sa_user_roles sur, sa_role sr, sa_user su
 where sur.role_id = sr.role_id
   and su.user_id = sur.user_id
   and su.mask = upper('Jhonie')
--and su.user_id = nuUserId
/*and sr.name in
(SELECT (regexp_substr(&sbPerfilMod, '[^,]+', 1, LEVEL)) AS perfiles
   FROM dual
 CONNECT BY regexp_substr(&sbPerfilMod, '[^,]+', 1, LEVEL) IS NOT NULL);*/
