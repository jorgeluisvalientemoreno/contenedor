CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_MO_PACKAGES_99

  /*****************************************************************
  Unidad         : TRG_MO_PACKAGES_99
  Descripcion    : Trigger que permite modificar la observacion de la solicitud en caso que contenga
                   Caracteres especiales
  Autor          : OL-Software
  Fecha          : 21/01/2021

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  08/04/2021        OL-Software       Se ajusta validacion con el parametro LDC_SOLICI_SIN_CARACT
  21/01/2021        OL-Software       Creacion
  ******************************************************************/
  BEFORE INSERT ON mo_packages
  FOR EACH ROW

DECLARE


    sbCaso587           VARCHAR2(30) := '0000587';
    sbObservacion       mo_packages.comment_%type;
    sbObservacionNew    mo_packages.comment_%type;
    sbSoliValidate      ld_parameter.value_chain%TYPE := dald_parameter.fsbGetValue_Chain('LDC_SOLICI_SIN_CARACT',0);
    nuCount             number := 0;

    cursor cuValida
    (
        inuTipoSolicitud in mo_packages.package_type_id%type,
	    isbTiposSolicitudes in varchar2
    )
    is
	   select count(1) from dual
       where inuTipoSolicitud in (select to_number(column_value)
	                              from table (ldc_boutilities.splitStrings(isbTiposSolicitudes,',')));

BEGIN

    ut_trace.trace('Inicio del trigger TRG_MO_PACKAGES_99',10);

    sbObservacion := :NEW.COMMENT_;

    ut_trace.trace('Observacion solicitud: ['||sbObservacion||']',10);

    IF fblaplicaentregaxcaso(sbCaso587) THEN

        open cuValida(:NEW.PACKAGE_TYPE_ID, sbSoliValidate);
		fetch cuValida into nuCount;
		close cuValida;

        IF nuCount > 0 THEN

            sbObservacionNew := LDC_BoRegistroProducto.fsbGetObseSinCaract(sbObservacion);

            :NEW.COMMENT_ := sbObservacionNew;
        END IF;

    END IF;


    ut_trace.trace('Fin del trigger TRG_MO_PACKAGES_99',10);

EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;

end TRG_MO_PACKAGES_99;
/
