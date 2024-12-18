CREATE OR REPLACE PACKAGE PK_MIGRACION_PERSONA AS
/* *********************************************************************
Propiedad intelectual de Gases de Occidente

United        : PK_MIGRACION_PERSONA
Description   : Migra informacion a GE_SUBCRIBER y tablas GE_SUBS_*
Autor         : Manuel Alejandro Palomares // Olsoftware
Fecha         : 12-12-2012
Proyecto   	  : Frente de Datos - Migracion SmartFlex

HISTORIA DE DEPURACION
FECHA         AUTOR      DESCRIPCION
=====         =======    ================================================

***********************************************************************/


  procedure pr_carga_GE_SUBSCRIBER_SUSC1;
  procedure pr_carga_GE_SUBSCRIBER_SUSC2;

  procedure pr_carga_GE_SUBSCRIBER_NOSUSC1;

  procedure pr_carga_GE_SUBSCRIBER_NOSUSC2;

  procedure pr_carga_GE_SUBS_PHONE(nuGesubs in number,inuPerstele2 in number, inuPerscelu in number, basedato in number, nuok out number);

  --procedure pr_carga_GE_SUBS_BUSINES_DATA(nuGesubs in number,basedato in number); no existe informacion

  --procedure pr_carga_GE_SUBS_CREDIT_DATA(nuGesubs in number,basedato in number); no existe informacion

  --procedure pr_carga_GE_SUBS_FAMILY_DATA(nuGesubs in number,basedato in number); no existe informacion

  procedure pr_carga_GE_SUBS_GENERAL_DATA(nuGesubs in number,idtPersfena in date, isbPerssexo in varchar2,inuPersesci in number,
                                          inuPersnies in number, inuPersinme in number, inuPersgame in number, idtPersfeua in date,
                                          inuPersnuid in number,nuBasedato in number, nuOk out number);

  --procedure pr_carga_GE_SUBS_HOUSING_DATA(nuGesubs in number,basedato in number); no existe informacion

  procedure pr_carga_GE_SUBS_REFEREN_DATA(nuGesubs in varchar2,nuBasedato in number, nuok out number);

  --procedure pr_carga_GE_SUBS_WORK_RELAT(nuGesubs in number,basedato in number, nuok out number);
  procedure pr_carga_GE_SUBS_WORK_RELAT(nuGesubs in number, isbCompany in varchar2, inuPerstele1 in number, inuPersocup in number, inuPersexte in number, basedato in number, nuok out number);

  procedure pr_carga_REFERPERS_VACASOLI(nuGesubs in varchar2,nuBasedato in number, nuok out number);

  procedure prConsultaDasosesu(inuSusc in number, inuCedu in number, DASSFEUA out date, DASSFENA out date, DASSSEXO out varchar2,DASSCELU out number, DASSTELE out number);

  function check_email(l_user_name IN VARCHAR2) RETURN number;

  procedure pr_cargueRoleCliente(nuSusc number,nuBasedato number);

  procedure prInsertActualizaProdSubs(nPRODUCT_ID number,nUBSCRIBER_ID number,sROLE_ID number);

  procedure prActulizaCorreo(nuGesubs number, isbIdent varchar2, isbPersMail varchar2, inuPersTele number,nuBasedato number, dtFechCed date default null);

  procedure pr_carga_GE_SUBS_HOUSING_DATA(nuTipoV number, nuAnos number,nuSubscriberId number,nuBasedato number);

  PROCEDURE pr_carga_LDC_PROTECCION_DATOS(inuGeSubs in number, isbPersAuto in varchar2, onuCodeError out number);

  PROCEDURE PR_CARGUE_ROL_CLIENTE_C;

  PROCEDURE PR_CARGUE_ROL_CLIENTE_V;

END PK_MIGRACION_PERSONA;
/
