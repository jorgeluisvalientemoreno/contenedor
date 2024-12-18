CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_VALIDARFECHACIERREMASIVO(
                                                                     dtfechafinal DATE
                                                                    ,nuacta ge_acta.id_acta%TYPE
                                                                     ) IS
  /*****************************************************************
    Propiedad intelectual de JM GESTIONINFORMATICA S.A (c).

    Unidad         : ldc_validarfechacierremasivo
    Descripcion    : Validamos fecha para el cierre actas abiertas para un tipo de contrato y contratista
                    comando : LDCCIMAAC
    Autor          : John Jairo Jimenez Marimón
    Fecha          :19/07/2016

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
  ******************************************************************/
 rcacta dage_acta.styge_acta;
 cnuerrorfecfinreq  CONSTANT ge_message.message_id%TYPE := 9883;
 cnuerrorfechamayor CONSTANT ge_message.message_id%TYPE := 3852;
 cnuerrrfecmnini    CONSTANT ge_message.message_id%TYPE := 9922;
 cnuerrrfecmayfinor CONSTANT ge_message.message_id%TYPE := 9983;
BEGIN
 dage_acta.getrecord( nuacta, rcacta );
 IF rcacta.id_tipo_acta = ct_boconstants.fnugetliquidationcertitype THEN
  IF (dtfechafinal IS NULL ) THEN
      ge_boerrors.seterrorcode(cnuerrorfecfinreq);
      RAISE ex.controlled_error;
      RETURN;
  END IF;
  IF (dtfechafinal > ut_date.fdtsysdate) THEN
    ge_boerrors.seterrorcode(cnuerrorfechamayor);
    RAISE ex.controlled_error;
    RETURN;
  END IF;
  IF (dtfechafinal < rcacta.fecha_inicio) THEN
    ge_boerrors.seterrorcode(cnuerrrfecmnini);
    RAISE ex.controlled_error;
    RETURN;
  END IF;
  IF (dtfechafinal > rcacta.fecha_fin) THEN
    ge_boerrors.seterrorcode( cnuerrrfecmayfinor);
    RAISE ex.controlled_error;
    RETURN;
  END IF;
 ELSIF rcacta.id_tipo_acta = ct_boconstants.fnugetbillingcertitype THEN
  IF ( dtfechafinal != rcacta.fecha_fin ) THEN
     errors.seterror( 6883 );
    RAISE ex.controlled_error;
  END IF;
 END IF;
EXCEPTION
 WHEN ex.controlled_error THEN
      RAISE ex.controlled_error;
 WHEN OTHERS THEN
      errors.seterror;
      RAISE ex.controlled_error;
END ldc_validarfechacierremasivo;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALIDARFECHACIERREMASIVO', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_VALIDARFECHACIERREMASIVO TO REXEREPORTES;
/