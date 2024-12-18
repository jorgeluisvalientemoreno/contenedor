CREATE OR REPLACE FUNCTION adm_person.ldc_retornameedadmora (
    inudias IN NUMBER
) RETURN VARCHAR2 IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-08-14
  Descripcion : Retorna descripción de la edad del producto

  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
    FECHA           AUTOR               DESCRIPCION
    06/03/2024      Paola Acosta        OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez 
    27/02/2024      Paola Acosta        OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON    
***************************************************************************/
BEGIN
    IF inudias = -1 THEN
        RETURN '0 MES';
    ELSIF inudias = 0 THEN
        RETURN 'PRESENTE MES';
    ELSIF inudias = 30 THEN
        RETURN to_char(inudias)
               || ' DIAS';
    ELSIF inudias = 60 THEN
        RETURN to_char(inudias)
               || ' DIAS';
    ELSIF inudias = 90 THEN
        RETURN to_char(inudias)
               || ' DIAS';
    ELSIF inudias = 120 THEN
        RETURN to_char(inudias)
               || ' DIAS';
    ELSIF inudias = 150 THEN
        RETURN to_char(inudias)
               || ' DIAS';
    ELSIF inudias = 180 THEN
        RETURN to_char(inudias)
               || ' DIAS';
    ELSIF inudias = 210 THEN
        RETURN to_char(inudias)
               || ' DIAS';
    ELSIF inudias = 240 THEN
        RETURN to_char(inudias)
               || ' DIAS';
    ELSIF inudias = 270 THEN
        RETURN to_char(inudias)
               || ' DIAS';
    ELSIF inudias = 300 THEN
        RETURN to_char(inudias)
               || ' DIAS';
    ELSIF inudias = 330 THEN
        RETURN to_char(inudias)
               || ' DIAS';
    ELSIF inudias = 360 THEN
        RETURN to_char(inudias)
               || ' DIAS';
    ELSIF inudias > 360 THEN
        RETURN '> 360 DIAS';
    ELSE
        RETURN 'ERROR AL RECUPERAR DESCRIPCION DE LA EDAD';
    END IF;
END ldc_retornameedadmora;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_RETORNAMEEDADMORA', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_RETORNAMEEDADMORA TO REXEREPORTES;
/