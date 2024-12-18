CREATE OR REPLACE FUNCTION adm_person.fncvalidacerttecnasignaci RETURN NUMBER IS
/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : fncvalidacerttecnasignaci
Descripcion    : 
Autor          :
Fecha          :

Parametros           Descripcion
============         ===================

Fecha           Autor               Modificacion
=========       =========           ====================
06/03/2023      Paola Acosta        OSF-2180: Se agregan permisos para REXEREPORTES
20-Feb-2024     Paola Acosta        OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON  
******************************************************************/
    sbvar   VARCHAR2(1000);
    sbvar2  VARCHAR2(1000);
    sbvar3  VARCHAR2(1000);
    nuconta NUMBER DEFAULT 0;
BEGIN
    sbvar := 'to_number(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('
             || chr(39)
             || 'REPOINCO'
             || chr(39)
             || ','
             || chr(39)
             || 'REINCODI'
             || chr(39)
             || '))';

    sbvar2 := 'to_number(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('
              || chr(39)
              || 'REPOINCO'
              || chr(39)
              || ','
              || chr(39)
              || 'REINREPO'
              || chr(39)
              || '))';

    sbvar3 := 'SELECT ldc_consultacertvigtec('
              || sbvar
              || ','
              || sbvar2
              || ')'
              || ' FROM DUAL';

    EXECUTE IMMEDIATE sbvar3
    INTO nuconta;
    RETURN nuconta;
END fncvalidacerttecnasignaci;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNCVALIDACERTTECNASIGNACI', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.FNCVALIDACERTTECNASIGNACI TO REXEREPORTES;
/