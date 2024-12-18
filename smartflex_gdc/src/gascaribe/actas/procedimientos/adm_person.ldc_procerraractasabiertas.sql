CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PROCERRARACTASABIERTAS(
                                                                   isbTablaId      IN  VARCHAR2,
                                                                   inuCurrent      IN  NUMBER,
                                                                   inuTotal        IN  NUMBER,
                                                                   onuErrorCode    OUT NUMBER,
                                                                   osbErrorMessage OUT VARCHAR2
                                                                  ) IS
  /*****************************************************************
    Propiedad intelectual de JM GESTIONINFORMATICA S.A (c).

    Unidad         : ldc_procconsultaactasabiertas
    Descripcion    : Cierre actas abiertas para un tipo de contrato y contratista
                    comando : LDCCIMAAC
    Autor          : John Jairo Jimenez Marimón
    Fecha          :19/07/2016

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    28/07/2016      JJJM               Se modifica para que la fecha final sea
                                       la del acta y no la pasada por parámetro
  ******************************************************************/
nuidacta            ge_acta.id_acta%TYPE;
sbfecha_final       ge_boinstancecontrol.stysbvalue;
dtfechafinal        DATE;
sbflag              ge_boinstancecontrol.stysbvalue;
cnuerror_no_details ge_message.message_id%TYPE := 6762;
cnuexecutable_rep   CONSTANT sa_executable.executable_id%TYPE := 15016;
sw                  NUMBER(1) DEFAULT 0;
sberror             VARCHAR2(1000);
BEGIN
 ut_trace.trace('Inicio ldc_procerraractasabiertas', 12 );
 sbflag        := ge_boinstancecontrol.fsbgetfieldvalue('GE_ACTA','ESTADO');
 nuidacta      := to_number(isbTablaId);
 sw            := 0;
 BEGIN
  SELECT ac.fecha_fin INTO dtfechafinal
    FROM ge_acta ac
   WHERE ac.id_acta = nuidacta;
   sw := 1;
 EXCEPTION
  WHEN no_data_found THEN
   sw := 0;
 END;
 IF sw = 0 THEN
  sberror := 'El acta nro : '||to_char(nuidacta)||' no existe.';
  RAISE ex.controlled_error;
 END IF;
 ldc_validarfechacierremasivo(dtfechafinal,nuidacta);
 ut_trace.trace( 'dtFechaFinal: ' || dtfechafinal, 12 );
 ge_bocertificate.lockcertificatebypk(nuidacta);
 IF NOT ct_bccertificate.fblhasdetails(nuidacta ) THEN
    errors.seterror(cnuerror_no_details );
    RAISE ex.controlled_error;
 END IF;
 ge_bocertifcontratista.cerraracta(nuidacta,dtfechafinal,sbflag);
 COMMIT;
 ut_trace.trace('ldc_procerraractasabiertas', 12 );
 ge_boiopenexecutable.setonevent(cnuexecutable_rep, 'POST_REGISTER' );
 procesopostcerraracta(nuidacta);
EXCEPTION
 WHEN ex.controlled_error THEN
  RAISE ex.controlled_error;
 WHEN OTHERS THEN
   errors.seterror;
  RAISE ex.CONTROLLED_ERROR;
END LDC_PROCERRARACTASABIERTAS;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROCERRARACTASABIERTAS', 'ADM_PERSON');
END;
/
