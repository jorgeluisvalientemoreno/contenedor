CREATE OR REPLACE procedure ADM_PERSON.LOG_CERTIFICADOS_OIA(inuContratoId           IN LDC_CERTIFICADOS_OIA.id_contrato%TYPE, -- codifo del contrato
                                                 idtfechaInspe           IN LDC_CERTIFICADOS_OIA.FECHA_INSPECCION%TYPE, -- fecha de inspeccion
                                                 inuTipoInspec           IN LDC_CERTIFICADOS_OIA.TIPO_INSPECCION%TYPE, -- tipo de inspeccion
                                                 isbCertificado          IN LDC_CERTIFICADOS_OIA.CERTIFICADO%TYPE, -- numero del certificado
                                                 inuOrganismoId          IN LDC_CERTIFICADOS_OIA.ID_ORGANISMO_OIA%TYPE, -- codigo del organismo certificador
                                                 inuRESULTADO_INSPECCION IN LDC_CERTIFICADOS_OIA.RESULTADO_INSPECCION%TYPE, -- resultado de la inspeccion
                                                 isbRED_INDIVIDUAL       IN LDC_CERTIFICADOS_OIA.RED_INDIVIDUAL%TYPE,
                                                 isbmensaje              ldc_tempomensajeweb.mensaje%type,
                                                 onuErrorCode            OUT NUMBER,
                                                 osbErrorMessage         OUT VARCHAR2) is
  pragma autonomous_transaction;
    /* -------------------------------------------------------------------------------------------------------------------
      PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P
      PROCEDIMIENTO : log_certificados_oia
      AUTOR : JM
      FECHA : 08/04/2014
      DESCRIPCION : Procedimiento para REGISTRAR EL LOG DE CERTIFICADOS OIA

      Historia de Modificaciones
      Autor        Fecha       Descripcion.
      -------------------------------------------------------------------------------------
      AAcuna       02-04-2018  Caso 200-1869 Se agregan dos nuevos parametros al procedimiento de LOG de certificados, a su vez se quita
                                             el raise del bloque de excepciones.
    *----------------------------------------------------------------------------------------------------------------------*/

  --Caso 200-171
  nuCERTIFICADOS_OIA_ID_LOG LDC_CERTIFICADOS_OIA.CERTIFICADOS_OIA_ID%TYPE;

  --Fin Caso 200-171

  begin
  SELECT seq_LDC_CERTIFICADOS_OIA_LOG.nextval
    INTO nuCERTIFICADOS_OIA_ID_LOG
    FROM dual;

  INSERT INTO ldc_certificados_oia_log
    (certificados_oia_id,
     id_contrato,
     fecha_inspeccion,
     tipo_inspeccion,
     certificado,
     id_organismo_oia,
     resultado_inspeccion,
     red_individual,
     fecha_registro,
     codigo,
     mensaje_error)
  values
    (nuCERTIFICADOS_OIA_ID_LOG,
     inuContratoId,
     idtfechaInspe,
     inuTipoInspec,
     isbCertificado,
     inuOrganismoId,
     inuRESULTADO_INSPECCION,
     isbRED_INDIVIDUAL,
     SYSDATE,
     99,
     isbmensaje);

  commit;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    Errors.seterror;
    Errors.geterror(onuErrorCode, osbErrorMessage);
  WHEN OTHERS THEN
    Errors.seterror;
    Errors.geterror(onuErrorCode, osbErrorMessage);
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LOG_CERTIFICADOS_OIA', 'ADM_PERSON');
END;
/