CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUUNITRACONECOATCI" RETURN NUMBER IS
 CURSOR cucontratistas IS
  SELECT /*+rule*/ DISTINCT u.contractor_id
    FROM or_oper_unit_persons uo,or_operating_unit u
   WHERE u.es_externa = 'Y'
     AND u.operating_unit_id = uo.operating_unit_id
     AND uo.person_id =(
                        SELECT p.person_id
                          FROM ge_person p
                         WHERE p.person_id=ge_bopersonal.fnugetpersonid);
 nucontratista or_operating_unit.contractor_id%TYPE DEFAULT -1;
BEGIN
 FOR i IN cucontratistas LOOP
  nucontratista := i.contractor_id;
 END LOOP;
 RETURN nucontratista;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUUNITRACONECOATCI', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_FNUUNITRACONECOATCI TO REXEREPORTES;
/
