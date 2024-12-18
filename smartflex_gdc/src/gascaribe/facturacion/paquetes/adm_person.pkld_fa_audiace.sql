CREATE OR REPLACE PACKAGE adm_person.PKLD_FA_AUDIACE is
/*************************************************************************************************************
      Propiedad intelectual de Ludycom S.A.

      Unidad         : PKLD_FA_AUDIACE
      Descripci�n    : Componente  de negocio que encarga de  lleva a cabo los procesos de gestión de la auditoría.
      Autor          : Jsilvera.SAOJERY.ANN.
      Fecha          : 21/09/2012

      Métodos

      Nombre         : Insertaudiace
      Descripción    : Componente de negocio que permite ingresar el registro de los cambios realizados en las tablas o entidades

      Par�metros     :

      Nombre Par�metro  Tipo de par�metro        Tipo de dato del par�metro            Descripción
         inuaudecodi        Entrada                    ld_fa_audidesc.audecodi%TYPE      Código de registro de auditoria de par�metros
         isbaudefunc        Entrada                    ld_fa_audidesc.audefunc%TYPE      Funcionalidad que realiza modificación(OPERACION)
         isbaudeenti        Entrada                    ld_fa_audidesc.audeenti%TYPE      Nombre de la entidad /tabla modificada
         isbaudedepa        Entrada                    ld_fa_audidesc.audedepa%TYPE      Nombre del parámetro modificado
         isbaudecolu        Entrada                    ld_fa_audidesc.audecolu%TYPE      Nombre de la columda modificada
         isbaudevaan        Entrada                    ld_fa_audidesc.audevaan%TYPE      Valor anterior de la calumna
         isbaudevaac        Entrada                    ld_fa_audidesc.audevaac%TYPE      Valor anterior de la columna
         inuaudesesi        Entrada                    ld_fa_audidesc.audesesi%TYPE      N�mero  de sesi�n
         inuaudeusid        Entrada                    ld_fa_audidesc.audeusid%TYPE      Usuario
         idtaudefech        Entrada                    ld_fa_audidesc.audefech%TYPE      Fecha de modificaci�n
         isbaudetide        Entrada                    ld_fa_audidesc.audetide%TYPE      Tipo de descuento: (r) referido o (d) descuento pronto pago
         isbaudeterm        Entrada                    ld_fa_audidesc.audeterm%TYPE      Terminal
         inuaudeinte        Entrada                    ld_fa_audidesc.audeinte%TYPE      Iteraci�n
         ionuResp           Entrada/Salida             number                            Par�metro de respuesta
**************************************************************************************************************************************

      Historia de Modificaciones
      Fecha             Autor             Modificación
      =========         =========         ====================
      19/06/2024        PAcosta           OSF-2845: Cambio de esquema ADM_PERSON
*******************************************************************************************************************/

  PROCEDURE Insertaudiace(inuaudecodi IN ld_fa_audidesc.audecodi%TYPE,
                          isbaudefunc IN ld_fa_audidesc.audefunc%TYPE,
                          isbaudeenti IN ld_fa_audidesc.audeenti%TYPE,
                          isbaudedepa IN ld_fa_audidesc.audedepa%TYPE,
                          isbaudecolu IN ld_fa_audidesc.audecolu%TYPE,
                          isbaudevaan IN ld_fa_audidesc.audevaan%TYPE,
                          isbaudevaac IN ld_fa_audidesc.audevaac%TYPE,
                          inuaudesesi IN ld_fa_audidesc.audesesi%TYPE,
                          inuaudeusid IN ld_fa_audidesc.audeusid%TYPE,
                          idtaudefech IN ld_fa_audidesc.audefech%TYPE,
                          isbaudetide IN ld_fa_audidesc.audetide%TYPE,
                          isbaudeterm IN ld_fa_audidesc.audeterm%TYPE,
                          inuaudeinte IN ld_fa_audidesc.audeinte%TYPE,
                          ionuResp    IN OUT number);

END PKLD_FA_AUDIACE;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PKLD_FA_AUDIACE IS
 csbVersion constant varchar2(250) := 'SAO209498';
  /*Procedimiento para ingresar el registro de los cambios realizados en las tablas o entidades*/
  PROCEDURE Insertaudiace(inuaudecodi IN ld_fa_audidesc.audecodi%TYPE,
                          isbaudefunc IN ld_fa_audidesc.audefunc%TYPE,
                          isbaudeenti IN ld_fa_audidesc.audeenti%TYPE,
                          isbaudedepa IN ld_fa_audidesc.audedepa%TYPE,
                          isbaudecolu IN ld_fa_audidesc.audecolu%TYPE,
                          isbaudevaan IN ld_fa_audidesc.audevaan%TYPE,
                          isbaudevaac IN ld_fa_audidesc.audevaac%TYPE,
                          inuaudesesi IN ld_fa_audidesc.audesesi%TYPE,
                          inuaudeusid IN ld_fa_audidesc.audeusid%TYPE,
                          idtaudefech IN ld_fa_audidesc.audefech%TYPE,
                          isbaudetide IN ld_fa_audidesc.audetide%TYPE,
                          isbaudeterm IN ld_fa_audidesc.audeterm%TYPE,
                          inuaudeinte IN ld_fa_audidesc.audeinte%TYPE,
                          ionuResp    IN OUT number) IS

    gsbErrMsg ge_error_log.description%TYPE; /*variable para error de excepción*/

  BEGIN
    pkErrors.Push('PKLD_FA_AUDIACE.InsertAudiace');
    /*se realiza la inserción en la Auditoria*/
    INSERT INTO ld_fa_audidesc
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
       audeinte,
       audedepa)
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
       inuaudeinte,
       isbaudedepa);
    pkErrors.Pop;
    ionuResp := 1;
  /*Excepción para enviar mensajes de error*/
  EXCEPTION
    when OTHERS then
      ionuResp := -1;
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, gsbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, gsbErrMsg);
  END Insertaudiace;
 /****************************************************************************
      Funcion       :  fsbVersion

      Descripcion  :  Obtiene el SAO que identifica la version asociada a la
                       ultima entrega del paquete

      Retorno      :  csbVersion - Version del Paquete
    *****************************************************************************/

    FUNCTION fsbVersion RETURN varchar2 IS
    BEGIN
    --{
        -- Retorna el SAO con que se realizó la última entrega del paquete
        return (csbVersion);
    --}
    END fsbVersion;
END PKLD_FA_AUDIACE;
/
PROMPT Otorgando permisos de ejecucion a PKLD_FA_AUDIACE
BEGIN
    pkg_utilidades.praplicarpermisos('PKLD_FA_AUDIACE', 'ADM_PERSON');
END;
/