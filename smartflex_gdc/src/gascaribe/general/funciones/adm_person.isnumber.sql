CREATE OR REPLACE FUNCTION "ADM_PERSON"."ISNUMBER" (a_input VARCHAR2)
RETURN number is
val NUMBER;
BEGIN
--{
   val := TO_NUMBER (a_input);
   RETURN ( 1 );
--}
EXCEPTION
--{
   WHEN OTHERS THEN
      RETURN ( 0 );
--}
END ISNUMBER;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('ISNUMBER', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.ISNUMBER TO REXEREPORTES;
/