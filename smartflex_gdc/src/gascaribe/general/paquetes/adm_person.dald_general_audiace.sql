CREATE OR REPLACE PACKAGE adm_person.dald_general_audiace is
/*************************************************************************************************************
      Propiedad intelectual de Ludycom S.A.

      Unidad         : DALD_GENERAL_AUDIACE
      Descripción    : Componente  de negocio que encarga de  lleva a cabo los procesos de gestión de la auditora.
      Autor          : Jsilvera.SAOJERY.ANN.
      Fecha          : 21/09/2012

      Métodos

      Nombre         : Insertaudiace
      Descripción    : Componente de negocio que permite ingresar el registro de los cambios realizados en las tablas o entidades

      Parámetros     :

      Nombre Parámetro  Tipo de parámetro        Tipo de dato del parámetro            Descripción
      inuaudecodi               IN               ld_general_audiace.audecodi%TYPE     Código de registro de auditoria de parámetros
      isbaudefunc               IN               ld_general_audiace.audefunc%TYPE     Funcionalidad que realiza modificación (OPERACION)
      isbaudeenti               IN               ld_general_audiace.audeenti%TYPE     Nombre de la entidad /tabla modificada
      isbaudecolu               IN               ld_general_audiace.audecolu%TYPE     Nombre de la columna modificada
      isbaudevaan               IN               ld_general_audiace.audevaan%TYPE     Valor anterior de la columna
      isbaudevaac               IN               ld_general_audiace.audevaac%TYPE     Valor anterior de la columna
      inuaudesesi               IN               ld_general_audiace.audesesi%TYPE     Numero  de sesión
      inuaudeusid               IN               ld_general_audiace.audeusid%TYPE     Usuario
      idtaudefech               IN               ld_general_audiace.audefech%TYPE     Fecha de modificación
      isbaudetide               IN               ld_general_audiace.audetide%TYPE     Tipo
      isbaudeterm               IN               ld_general_audiace.audeterm%TYPE     Terminal
      inuaudeinte               IN               ld_general_audiace.audeinte%TYPE     Iteración

         ionuResp           Entrada/Salida             number                            Parámetro de respuesta
**************************************************************************************************************************************

      Historia de Modificaciones
      Fecha             Autor             Modificación
      =========         =========         ====================
      04/06/2024        Adrianavg         OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
*******************************************************************************************************************/

  PROCEDURE InsertGaudiace(inuaudecodi IN ld_general_audiace.audecodi%TYPE,
                          isbaudefunc IN ld_general_audiace.audefunc%TYPE,
                          isbaudeenti IN ld_general_audiace.audeenti%TYPE,
                          isbaudecolu IN ld_general_audiace.audecolu%TYPE,
                          isbaudevaan IN ld_general_audiace.audevaan%TYPE,
                          isbaudevaac IN ld_general_audiace.audevaac%TYPE,
                          inuaudesesi IN ld_general_audiace.audesesi%TYPE,
                          inuaudeusid IN ld_general_audiace.audeusid%TYPE,
                          idtaudefech IN ld_general_audiace.audefech%TYPE,
                          isbaudetide IN ld_general_audiace.audetide%TYPE,
                          isbaudeterm IN ld_general_audiace.audeterm%TYPE,
                          inuaudeinte IN ld_general_audiace.audeinte%TYPE,
                          ionuResp    IN OUT number);

END DALD_GENERAL_AUDIACE;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_GENERAL_AUDIACE IS

  /*Procedimiento para ingresar el registro de los cambios realizados en las tablas o entidades*/
  PROCEDURE InsertGaudiace(inuaudecodi IN ld_general_audiace.audecodi%TYPE,
                          isbaudefunc IN ld_general_audiace.audefunc%TYPE,
                          isbaudeenti IN ld_general_audiace.audeenti%TYPE,
                          isbaudecolu IN ld_general_audiace.audecolu%TYPE,
                          isbaudevaan IN ld_general_audiace.audevaan%TYPE,
                          isbaudevaac IN ld_general_audiace.audevaac%TYPE,
                          inuaudesesi IN ld_general_audiace.audesesi%TYPE,
                          inuaudeusid IN ld_general_audiace.audeusid%TYPE,
                          idtaudefech IN ld_general_audiace.audefech%TYPE,
                          isbaudetide IN ld_general_audiace.audetide%TYPE,
                          isbaudeterm IN ld_general_audiace.audeterm%TYPE,
                          inuaudeinte IN ld_general_audiace.audeinte%TYPE,
                          ionuResp    IN OUT number) IS

    gsbErrMsg ge_error_log.description%TYPE; /*variable para error de excepción*/

  BEGIN
    pkErrors.Push('DALD_GENERAL_AUDIACE.InsertGAudiace');
    /*Se realiza la inserción en la Auditoria*/
    INSERT INTO ld_general_audiace
    (audecodi,
     audefunc,
     audeenti,
     audecolu,
     audevaan,
     audevaac,
     audesesi,
     audeusid,
     audefech,
     audetide,
     audeterm,
     audeinte)
    VALUES
      (inuaudecodi,
       isbaudefunc,
       isbaudeenti,
       isbaudecolu,
       isbaudevaan,
       isbaudevaac,
       inuaudesesi,
       inuaudeusid,
       idtaudefech,
       isbaudetide,
       isbaudeterm,
       inuaudeinte);
    pkErrors.Pop;
    ionuResp := 1;

  /*Excepción para enviar mensajes de error*/
  EXCEPTION
    when OTHERS then
      ionuResp := -1;
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, gsbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, gsbErrMsg);
  END InsertGaudiace;

END DALD_GENERAL_AUDIACE;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_GENERAL_AUDIACE
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_GENERAL_AUDIACE', 'ADM_PERSON'); 
END;
/  
