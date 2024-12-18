CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_BOCONSPARAM AS

  /*******************************************************************************
  Propiedad intelectual de PROYECTO PETI

  Autor                :
  Fecha                :

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  29-Abr-2015     XXX.SAO311595           creacion
  *******************************************************************************/


    FUNCTION fsbVersion return varchar2;

    FUNCTION fsbGetCLASIFICACION_ITEM
      return varchar2;

    FUNCTION fsbGetCODIGO_TT_NUEVAS
      return varchar2;

END LDC_BOCONSPARAM;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_BOCONSPARAM AS

  /*****************************************************************
  Propiedad intelectual de PROYECTO PETI

  Autor                :
  Fecha                :

  Fecha                IDEntrega           Modificacion
  ============    ================    =========================================
  29-Abr-2015     XXX.SAO311595           creacion
********************************************************************************/

  csbVersion CONSTANT VARCHAR2(250) := 'SAO311595';


  CSBCLASIFICACION_ITEM ld_parameter.value_chain%type;
  CSBCODIGO_TT_NUEVAS ld_parameter.value_chain%type;


    FUNCTION fsbVersion return varchar2 IS
    BEGIN
        return csbVersion;
    END;

    FUNCTION fsbGetCLASIFICACION_ITEM
        return varchar2  IS
    begin
        return   CSBCLASIFICACION_ITEM;
    END fsbGetCLASIFICACION_ITEM;

    FUNCTION fsbGetCODIGO_TT_NUEVAS
        return varchar2  IS
    begin
        return   CSBCODIGO_TT_NUEVAS;
    END fsbGetCODIGO_TT_NUEVAS;


BEGIN
    CSBCLASIFICACION_ITEM   := DALD_PARAMETER.FSBGETVALUE_CHAIN('CODIGO_CLASIFICACION_ITEM',NULL);
    CSBCODIGO_TT_NUEVAS     := DALD_PARAMETER.FSBGETVALUE_CHAIN('CODIGO_TT_NUEVAS',NULL);

END LDC_BOCONSPARAM;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOCONSPARAM', 'ADM_PERSON');
END;
/
