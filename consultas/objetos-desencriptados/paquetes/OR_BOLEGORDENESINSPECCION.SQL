
CREATE OR REPLACE PACKAGE OR_BOLEGORDENESINSPECCION IS
   FUNCTION FSBVERSION
    RETURN VARCHAR2;
   FUNCTION FBLVALIDARPERIODODESCARGO( INUORDENID IN OR_ORDER.ORDER_ID%TYPE )
    RETURN BOOLEAN;
   FUNCTION FBLTIENEANOMALIAS( INUORDENID IN OR_ORDER.ORDER_ID%TYPE )
    RETURN BOOLEAN;
   PROCEDURE SEPUEDELEGALIZAR( INUORDENID IN OR_ORDER.ORDER_ID%TYPE );
   PROCEDURE PROCESARORDENINSPECCION( INUORDENID IN OR_ORDER.ORDER_ID%TYPE, INUCAUSAL IN OR_ORDER.CAUSAL_ID%TYPE );
END OR_BOLEGORDENESINSPECCION;
/


CREATE OR REPLACE PACKAGE BODY OR_BOLEGORDENESINSPECCION IS
   CSBVERSION CONSTANT VARCHAR2( 10 ) := 'SAO140742';
   CNUNOPUEDELEGALIZAR CONSTANT NUMBER := 7562;
   CNUNOITEMSINSPECC CONSTANT NUMBER := 8301;
   CNUNOSIGMUESTRA CONSTANT NUMBER := 8321;
   CSBACEPTADA CONSTANT VARCHAR2( 1 ) := 'A';
   CSBRECHAZADA CONSTANT VARCHAR2( 1 ) := 'R';
   CSBGENERAR CONSTANT VARCHAR2( 1 ) := 'G';
   CSBUSE_SAMP_AUTO_TRAN CONSTANT VARCHAR2( 100 ) := 'USE_SAMP_AUTO_TRAN';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   FUNCTION FBLVALIDARPERIODODESCARGO( INUORDENID IN OR_ORDER.ORDER_ID%TYPE )
    RETURN BOOLEAN
    IS
      DTFECHAEJECUCION OR_ORDER.EXECUTION_FINAL_DATE%TYPE;
      NUDIAS NUMBER;
    BEGIN
      DAOR_ORDER.SETUSECACHE( FALSE );
      DTFECHAEJECUCION := DAOR_ORDER.FDTGETEXECUTION_FINAL_DATE( INUORDENID );
      DAOR_ORDER.SETUSECACHE( GE_BOPARAMETER.FSBGET( 'DAO_USE_CACHE' ) = 'Y' );
      NUDIAS := GE_BOPARAMETER.FNUGET( OR_BOCONSTANTS.CSBPARAMETERPERIODODESCARGO );
      RETURN ( UT_DATE.FDTSYSDATE >= ( DTFECHAEJECUCION + NUDIAS ) );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FBLVALIDARPERIODODESCARGO;
   FUNCTION FBLTIENEANOMALIAS( INUORDENID IN OR_ORDER.ORDER_ID%TYPE )
    RETURN BOOLEAN
    IS
    BEGIN
      RETURN OR_BCLEGORDENESINSPECCION.FBLTIENEANOMALIAS( INUORDENID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FBLTIENEANOMALIAS;
   PROCEDURE SEPUEDELEGALIZAR( INUORDENID IN OR_ORDER.ORDER_ID%TYPE )
    IS
      RCORDEN DAOR_ORDER.STYOR_ORDER;
    BEGIN
      DAOR_ORDER.GETRECORD( INUORDENID, RCORDEN );
      IF RCORDEN.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_EXECUTING THEN
         RETURN;
      END IF;
      IF ( FBLTIENEANOMALIAS( INUORDENID ) ) THEN
         IF ( NOT FBLVALIDARPERIODODESCARGO( INUORDENID ) ) THEN
            GE_BOERRORS.SETERRORCODE( CNUNOPUEDELEGALIZAR );
            RAISE EX.CONTROLLED_ERROR;
            RETURN;
         END IF;
      END IF;
      IF ( NOT ( OR_BCLEGORDENESINSPECCION.FBLTIENEITEMSINSPE( INUORDENID ) ) ) THEN
         GE_BOERRORS.SETERRORCODE( CNUNOITEMSINSPECC );
         RAISE EX.CONTROLLED_ERROR;
         RETURN;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END SEPUEDELEGALIZAR;
   PROCEDURE PROCESARORDENINSPECCION( INUORDENID IN OR_ORDER.ORDER_ID%TYPE, INUCAUSAL IN OR_ORDER.CAUSAL_ID%TYPE )
    IS
      NUMUESTRA GE_ORDENES_MUESTRA.ID_MUESTRA%TYPE;
      RCMUESTRA DAGE_MUESTRAS.STYGE_MUESTRAS;
      RCTAMMUESTRA DAGE_TAMANO_MUESTRA.STYGE_TAMANO_MUESTRA;
      RCCONFIGURACION DAGE_CONF_MUES_UNIDAD.STYGE_CONF_MUES_UNIDAD;
      NUACEPTADAS NUMBER;
      NURECHAZADAS NUMBER;
      NUBASEORDER OR_ORDER.ORDER_ID%TYPE;
      TBADJUSTEDITEMS OR_BCADJUSTMENTORDER.TYTBADJUSTEDITEMS;
      NUADJORDERID OR_ORDER.ORDER_ID%TYPE;
      PROCEDURE REGISTRARLOG( INUMENSAJEID IN GE_MESSAGE.MESSAGE_ID%TYPE )
       IS
         RCLOG DAGE_LOG_ERR_INSPECC.STYGE_LOG_ERR_INSPECC;
       BEGIN
         RCLOG.ID_LOG_ERROR_INSP := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE( 'GE_LOG_ERR_INSPECC', 'SEQ_GE_LOG_ERR_INSPECC' );
         RCLOG.ID_MUESTRA := RCMUESTRA.ID_MUESTRA;
         RCLOG.FECHA_PROCESO := UT_DATE.FDTSYSDATE;
         RCLOG.MENSAJE_ERROR := INUMENSAJEID || ' - ' || DAGE_MESSAGE.FSBGETDESCRIPTION( INUMENSAJEID );
         DAGE_LOG_ERR_INSPECC.INSRECORD( RCLOG );
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END REGISTRARLOG;
      FUNCTION FBLVALIDARORDEN
       RETURN BOOLEAN
       IS
         NUCLASECAUSAL GE_CLASS_CAUSAL.CLASS_CAUSAL_ID%TYPE;
       BEGIN
         UT_TRACE.TRACE( 'Se valida la orden... fblValidarOrden', 12 );
         NUCLASECAUSAL := DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID( INUCAUSAL );
         IF ( NUCLASECAUSAL = OR_BCTASK_TYPE_ADMIN.CNUSUCESFULLCAUSALCLASS ) THEN
            IF NOT ( OR_BCLEGORDENESINSPECCION.FBLTIENEITEMSINSPE( INUORDENID ) ) THEN
               UT_TRACE.TRACE( 'No se deja legalizar por no tener items inspeccionados', 12 );
               GE_BOERRORS.SETERRORCODE( CNUNOITEMSINSPECC );
               RAISE EX.CONTROLLED_ERROR;
               RETURN FALSE;
            END IF;
            IF OR_BCLEGORDENESINSPECCION.FBLTIENEANOMVALIDAS( INUORDENID ) THEN
               UT_TRACE.TRACE( 'Se rechaza la orden por tener anomalias validas', 12 );
               RETURN FALSE;
            END IF;
            UT_TRACE.TRACE( 'Se acepta la orden', 12 );
            RETURN TRUE;
          ELSE
            IF ( DAGE_CAUSAL.FNUGETATTRIBUTED_TO( INUCAUSAL ) = GE_BOCONSTANTS.FNUGETIMPUTABLEEMPRESA ) THEN
               UT_TRACE.TRACE( 'Se rechaza la orden por culpa de open', 12 );
               RETURN FALSE;
             ELSE
               UT_TRACE.TRACE( 'Se acepta la orden por ser culpa del cliente', 12 );
               RETURN TRUE;
            END IF;
         END IF;
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END FBLVALIDARORDEN;
      PROCEDURE ACTUALIZARMUESTRA( ISBCASO IN VARCHAR2 )
       IS
         RCORDENMUESTRA DAGE_ORDENES_MUESTRA.STYGE_ORDENES_MUESTRA;
       BEGIN
         DAGE_ORDENES_MUESTRA.GETRECORD( OR_BCLEGORDENESINSPECCION.FNUOBTENERORDENMUESTRA( INUORDENID, RCMUESTRA.ID_MUESTRA ), RCORDENMUESTRA );
         IF ( ISBCASO = CSBACEPTADA ) THEN
            RCMUESTRA.ORDENES_ACEPT_LEGAL := RCMUESTRA.ORDENES_ACEPT_LEGAL + 1;
            RCORDENMUESTRA.ACEPTADA := OR_BOCONSTANTS.CSBSI;
          ELSE
            RCMUESTRA.ORDENES_RECHA_LEGAL := RCMUESTRA.ORDENES_RECHA_LEGAL + 1;
            RCORDENMUESTRA.ACEPTADA := OR_BOCONSTANTS.CSBNO;
         END IF;
         UT_TRACE.TRACE( 'Se actualiza el numero de aceptaciones o rechazos para las ordenes de la muestra', 12 );
         DAGE_MUESTRAS.UPDRECORD( RCMUESTRA );
         DAGE_ORDENES_MUESTRA.UPDRECORD( RCORDENMUESTRA );
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END ACTUALIZARMUESTRA;
      FUNCTION FBLESULTIMAORDEN
       RETURN BOOLEAN
       IS
       BEGIN
         RETURN ( RCMUESTRA.TAMANO_MUESTRA = RCMUESTRA.ORDENES_ACEPT_LEGAL + RCMUESTRA.ORDENES_RECHA_LEGAL );
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END FBLESULTIMAORDEN;
      FUNCTION VALIDARMUESTRA
       RETURN VARCHAR2
       IS
       BEGIN
         OR_BCLEGORDENESINSPECCION.OBTENERVALORES( RCMUESTRA.ID_UNIDAD_OPERATIVA, RCMUESTRA.ID_CRIT_MUESTRA, NUACEPTADAS, NURECHAZADAS );
         IF NURECHAZADAS <= RCTAMMUESTRA.CANTIDAD_ACEPTAR THEN
            RETURN CSBACEPTADA;
         END IF;
         UT_TRACE.TRACE( 'nuRechazadas: ' || NURECHAZADAS, 12 );
         UT_TRACE.TRACE( 'rcTamMuestra.CANTIDAD_RECHAZAR: ' || RCTAMMUESTRA.CANTIDAD_RECHAZAR, 12 );
         IF NURECHAZADAS >= RCTAMMUESTRA.CANTIDAD_RECHAZAR THEN
            RETURN CSBRECHAZADA;
         END IF;
         UT_TRACE.TRACE( 'Se debe generar otra muestra', 12 );
         RETURN CSBGENERAR;
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END VALIDARMUESTRA;
      PROCEDURE HACERTRANSICION
       IS
         NUNIVEL GE_TRANS_NIVEL_MUEST.ID_NIVEL_DESTINO%TYPE;
       BEGIN
         UT_TRACE.TRACE( 'Se verifica si la transicion esta configurada', 12 );
         IF OR_BCLEGORDENESINSPECCION.FBLTIENECONGTRANSI( RCMUESTRA.ID_UNIDAD_OPERATIVA, RCCONFIGURACION.TIPO_ULTIMO_HALLAZGO, RCCONFIGURACION.CANT_HALLAZGOS, NUNIVEL ) THEN
            UT_TRACE.TRACE( 'Se hace la transicion', 12 );
            RCCONFIGURACION.ID_NIVEL_MUESTRA := NUNIVEL;
         END IF;
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END HACERTRANSICION;
      PROCEDURE ACEPTARMUESTRA
       IS
       BEGIN
         DAGE_CONF_MUES_UNIDAD.GETRECORD( RCMUESTRA.ID_CONFIGURACION, RCCONFIGURACION );
         IF RCCONFIGURACION.TIPO_ULTIMO_HALLAZGO = CSBACEPTADA THEN
            RCCONFIGURACION.CANT_HALLAZGOS := RCCONFIGURACION.CANT_HALLAZGOS + 1;
          ELSE
            RCCONFIGURACION.CANT_HALLAZGOS := 1;
            RCCONFIGURACION.TIPO_ULTIMO_HALLAZGO := CSBACEPTADA;
         END IF;
         UT_TRACE.TRACE( 'Se verifica si se debe hacer la transicion de plan de muestreo', 12 );
         IF GE_BOPARAMETER.FSBGET( CSBUSE_SAMP_AUTO_TRAN ) = OR_BOCONSTANTS.CSBSI THEN
            HACERTRANSICION;
         END IF;
         DAGE_CONF_MUES_UNIDAD.UPDRECORD( RCCONFIGURACION );
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END ACEPTARMUESTRA;
      PROCEDURE RECHAZARMUESTRA
       IS
       BEGIN
         DAGE_CONF_MUES_UNIDAD.GETRECORD( RCMUESTRA.ID_CONFIGURACION, RCCONFIGURACION );
         IF RCCONFIGURACION.TIPO_ULTIMO_HALLAZGO = CSBRECHAZADA THEN
            RCCONFIGURACION.CANT_HALLAZGOS := RCCONFIGURACION.CANT_HALLAZGOS + 1;
          ELSE
            RCCONFIGURACION.CANT_HALLAZGOS := 1;
            RCCONFIGURACION.TIPO_ULTIMO_HALLAZGO := CSBRECHAZADA;
         END IF;
         UT_TRACE.TRACE( 'Se verifica si se debe hacer la transicion de plan de muestreo', 12 );
         IF GE_BOPARAMETER.FSBGET( CSBUSE_SAMP_AUTO_TRAN ) = OR_BOCONSTANTS.CSBSI THEN
            HACERTRANSICION;
         END IF;
         DAGE_CONF_MUES_UNIDAD.UPDRECORD( RCCONFIGURACION );
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END RECHAZARMUESTRA;
      PROCEDURE GENERARMUESTRA
       IS
         NUSIGORDINALMUESTRA GE_ORDENES_MUESTRA.ID_ORDENES_MUESTRA%TYPE;
         NUCANTIDADRECHAZA GE_TAMANO_MUESTRA.CANTIDAD_RECHAZAR%TYPE;
         NUJOB_ID BINARY_INTEGER;
       BEGIN
         UT_TRACE.TRACE( 'Se valida si existe el siguiente ordinal', 12 );
         IF OR_BCLEGORDENESINSPECCION.FBLEXISTESIGORDINAL( RCTAMMUESTRA.ID_ORDINAL_MUESTRA, NUSIGORDINALMUESTRA ) THEN
            UT_TRACE.TRACE( 'Se Obtiene el valor a rechazar del siguiente plan de muestreo ', 12 );
            NUCANTIDADRECHAZA := OR_BCLEGORDENESINSPECCION.FNUCANTIDADRECHAZAR( RCTAMMUESTRA.ID_NIVEL, NUSIGORDINALMUESTRA, RCMUESTRA.TAMANO_POBLACION );
            IF NUCANTIDADRECHAZA IS NULL THEN
               UT_TRACE.TRACE( 'Se rechaza la orden por no existir configuracion', 12 );
               REGISTRARLOG( CNUNOSIGMUESTRA );
               RECHAZARMUESTRA;
               RETURN;
            END IF;
            IF NURECHAZADAS >= NUCANTIDADRECHAZA THEN
               UT_TRACE.TRACE( 'Se rechaza la muestra por cantidad de ordenes rechazadas supera a las del siguiente ordinal', 12 );
               RECHAZARMUESTRA;
             ELSE
               UT_TRACE.TRACE( 'Crea el Job para una unica ejecucion exitosa de la generacion', 12 );
               PKBIUT_JOBMGR.CREATEJOB( 'OR_BOOrdenesInspeccion.GenerarOtraMuestra(' || RCMUESTRA.ID_MUESTRA || ',' || NUSIGORDINALMUESTRA || ');', SYSDATE, NULL, NUJOB_ID );
            END IF;
          ELSE
            UT_TRACE.TRACE( 'Se rechaza la muestra por no existir el siguiente ordinal', 12 );
            REGISTRARLOG( CNUNOSIGMUESTRA );
            RECHAZARMUESTRA;
         END IF;
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END GENERARMUESTRA;
      PROCEDURE PROCESARMUESTRA
       IS
         SBVALIDO VARCHAR2( 1 );
       BEGIN
         DAGE_TAMANO_MUESTRA.GETRECORD( RCMUESTRA.ID_TAMANO_MUESTRA, RCTAMMUESTRA );
         IF RCTAMMUESTRA.CANTIDAD_ACEPTAR IS NULL OR RCTAMMUESTRA.CANTIDAD_RECHAZAR IS NULL THEN
            UT_TRACE.TRACE( 'No es Plan de Muestreo Multiple.', 12 );
            RETURN;
         END IF;
         SBVALIDO := VALIDARMUESTRA;
         IF SBVALIDO = CSBACEPTADA THEN
            UT_TRACE.TRACE( 'Se acepta la muestra', 12 );
            ACEPTARMUESTRA;
          ELSIF SBVALIDO = CSBRECHAZADA THEN
            UT_TRACE.TRACE( 'Se rechaza la muestra', 12 );
            RECHAZARMUESTRA;
          ELSE
            UT_TRACE.TRACE( 'Se procede a validar si se puede regenerar', 12 );
            GENERARMUESTRA;
         END IF;
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END PROCESARMUESTRA;
      PROCEDURE CORRERPROCESO
       IS
       BEGIN
         NUMUESTRA := OR_BCLEGORDENESINSPECCION.FNUOBTENERMUESTRA( INUORDENID );
         DAGE_MUESTRAS.GETRECORD( NUMUESTRA, RCMUESTRA );
         UT_TRACE.TRACE( 'Se verifica si la orden es aceptada o rechazada en la muestra', 12 );
         IF FBLVALIDARORDEN THEN
            ACTUALIZARMUESTRA( CSBACEPTADA );
          ELSE
            ACTUALIZARMUESTRA( CSBRECHAZADA );
         END IF;
         IF FBLESULTIMAORDEN THEN
            UT_TRACE.TRACE( 'Se procede a verificar la muestra', 12 );
            PROCESARMUESTRA();
         END IF;
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END CORRERPROCESO;
    BEGIN
      UT_TRACE.TRACE( 'Se verifica si la orden pertenece a una muestra', 12 );
      OR_BOADJUSTMENTORDER.GETADJITEMFROMINSP( INUORDENID, NUBASEORDER, TBADJUSTEDITEMS );
      IF ( TBADJUSTEDITEMS.COUNT > 0 ) THEN
         OR_BOADJUSTMENTORDER.CREATEORDER( NUBASEORDER, TBADJUSTEDITEMS, NUADJORDERID );
         OR_BOADJUSTMENTORDER.RELATEADJORDERWINSP( INUORDENID, NUADJORDERID );
      END IF;
      IF OR_BCLEGORDENESINSPECCION.FBLPERTENECEMUESTRA( INUORDENID ) THEN
         CORRERPROCESO;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END PROCESARORDENINSPECCION;
END OR_BOLEGORDENESINSPECCION;
/


