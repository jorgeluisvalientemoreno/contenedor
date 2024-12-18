CREATE OR REPLACE FUNCTION adm_person.fncvalicerttecnasignacire RETURN NUMBER IS
/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : fncvalicerttecnasignacire
Descripcion    : Proceso que valida si el tecnico tiene certificado vigente a la fecha
Autor          :
Fecha          :

Parametros           Descripcion
============         ===================

Fecha           Autor               Modificacion
=========       =========           ====================
19-Feb-2024     Paola Acosta        OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON  
14-Nov-2015     Mmejia              SAO.358079 Creacion
******************************************************************/
    sbvar   VARCHAR2(1000);
    sbvar2  VARCHAR2(1000);
    sbvar3  VARCHAR2(1000);
    nuconta NUMBER DEFAULT 0;
BEGIN
    sbvar := 'to_number(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('
             || chr(39)
             || 'OR_OPERATING_UNIT'
             || chr(39)
             || ','
             || chr(39)
             || 'FATHER_OPER_UNIT_ID'
             || chr(39)
             || '))';

    sbvar2 := 'to_number(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('
              || chr(39)
              || 'OR_OPERATING_UNIT'
              || chr(39)
              || ','
              || chr(39)
              || 'PERSON_IN_CHARGE'
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
END fncvalicerttecnasignacire;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNCVALICERTTECNASIGNACIRE', 'ADM_PERSON');
END;
/