CREATE OR REPLACE FUNCTION adm_person.ldc_sbretornacoddane (
    inuloca IN NUMBER
) RETURN VARCHAR2 IS
 /**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-11-11
  Descripcion : Generamos codigo Dane con la ubicacion geografica

  Parametros Entrada
    inuloca Localidad

  Valor de salida
    sbcoddane Codigo Dane

 HISTORIA DE MODIFICACIONES
   FECHA           AUTOR               DESCRIPCION
   06/03/2024      Paola Acosta        OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
   28/02/2024      Paola Acosta        OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON  
   
 ***************************************************************************/
    sbcoddane VARCHAR2(10);
BEGIN
    BEGIN
        sbcoddane := daldc_equiva_localidad.fsbgetdepartamento(inuloca)
                     || daldc_equiva_localidad.fsbgetmunicipio(inuloca)
                     || daldc_equiva_localidad.fsbgetpoblacion(inuloca);

        RETURN sbcoddane;
    EXCEPTION
        WHEN OTHERS THEN
            sbcoddane := NULL;
            RETURN sbcoddane;
    END;
END ldc_sbretornacoddane;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_SBRETORNACODDANE', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON adm_person.ldc_sbretornacoddane TO REXEREPORTES;
/