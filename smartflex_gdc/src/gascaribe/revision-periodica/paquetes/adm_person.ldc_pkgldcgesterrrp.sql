CREATE OR REPLACE PACKAGE adm_person.ldc_pkgldcgesterrrp
IS
    /**************************************************************************
     Autor       :  Horbath
     Fecha       : 2019-12-23
     Proceso     : LDC_PKGLDCGESTERRRP
     Ticket      : 147
     Descripcion : Paquete para el proceso del PB LDCGESTERRRP

     Historia de Modificaciones
     Fecha         Autor           Modificacion
     =========     =========       ====================
     09/02/2023    dsaltarin       OSF-858: Se separa el código
                   llopez          con personalizaciones.LDC_PKGLDCGESTERRRP_PER
                   jpinedc
     28/02/2023    jpinedc	       OSF-858: Se modifican PRCPROCESAGRILLA Y
                                    FRFLLENAGRILLA
     02/03/2023    jpinedc	       OSF-858: Se modifican PRCPROCESAGRILLA
     18/06/2024    Adrianavg       OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
    ***************************************************************************/
    -- Procesa la información del PB LDCGESTERRRP
    PROCEDURE PRCPROCESAGRILLA (isborden          IN     VARCHAR2,
                                inuCurrent        IN     NUMBER,
                                inuTotal          IN     NUMBER,
                                onuErrorCode         OUT NUMBER,
                                osbErrorMessage      OUT VARCHAR2);

    -- Llena información en el PB LDCGESTERRRP
    FUNCTION FRFLLENAGRILLA
        RETURN constants.tyrefcursor;
END LDC_PKGLDCGESTERRRP;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGLDCGESTERRRP
IS
    PROCEDURE PRCPROCESAGRILLA (isborden          IN     VARCHAR2,
                                inuCurrent        IN     NUMBER,
                                inuTotal          IN     NUMBER,
                                onuErrorCode         OUT NUMBER,
                                osbErrorMessage      OUT VARCHAR2)
    IS
        /**************************************************************************************************************
         Autor       :  Horbath
         Fecha       : 2019-12-23
         Proceso     : PRCPROCESAGRILLA
         Ticket      : 147
         Descripcion : Proceso que se encarga a procecar la informacion del PB
                       LDCGESTERRRP

         Parametros Entrada
          isborden  orden
          inuCurrent dato current
          inuTotal  total de registros
         Valor de salida
          onuErrorCode  codigo de error
          osbErrorMessage  mensaje de error

         Historia de Modificaciones
         Fecha               Autor                             Modificacion
         =========           =========                      ====================
         22/OCT/2020    John Jairo Jimenez Marimon(JJJM)   CA516 Se coloca en comentario la validacion del proceso
                                                                 cursor cuGetProceso.
         22/OCT/2020    John Jairo Jimenez Marimon(JJJM)   CA516 Se invoca el proceso ldc_proc_aud_bloq_lega_sol para
                                                                 el registro de la auditoria.
		 28/02/2023    	jpinedc	       					   OSF-858: Se quita el uso de los campos de fecha
		 02/03/2023    	jpinedc	       					   OSF-858: Se quita el uso de la variable nuorden
        *************************************************************************************************************/
    BEGIN
        ut_trace.Trace ('Inicio PRCPROCESAGRILLA', 10);

        IF FBLAPLICAENTREGAXCASO ('0000147')
        THEN

            PERSONALIZACIONES.LDC_PKGLDCGESTERRRP_PER.PRCPROCESAGRILLA (
                isborden,
                onuErrorCode,
                osbErrorMessage);
        END IF;

        ut_trace.Trace ('Inicio PRCPROCESAGRILLA', 10);
    EXCEPTION
        WHEN ex.controlled_error
        THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
        WHEN OTHERS
        THEN
            errors.seterror;
            errors.geterror (onuErrorCode, osbErrorMessage);
    END PRCPROCESAGRILLA;

    FUNCTION FRFLLENAGRILLA
        RETURN constants.tyrefcursor
    IS
        /*********************************************************************************************************
           Autor       :  Horbath
           Fecha       : 2019-12-23
           Proceso     : FRFLLENAGRILLA
           Ticket      : 147
           Descripcion : funcion que se encarga de llenar  la informacion del PB
                         LDCGESTERRRP

           Parametros Entrada

           Valor de salida

           Historia de Modificaciones
           Fecha               Autor                               Modificacion
           =========           =========                       ====================
        22/OCT/2020     John Jairo Jimenez Marimon(JJJM)    CA516 Se leen los procedimientos del parametro :
                                                                   PARAM_PROCESOS_DESB_ORD
                                                            CA516 Para solucionar de que no repita registros,
                                                                   se hace el llamado de la función ldc_fncretornaotultmenerr
		 28/02/2023    	jpinedc	       					    OSF-858: Se quita el uso de los campos de fecha
        ***********************************************************************************************************/
        onuErrorCode      NUMBER;                --se almacena codigo de error
        osbErrorMessage   VARCHAR2 (4000);      --se almacena mensaje de error
        rfcursor          pkConstante.tyRefCursor; --se almacena cursor referenciado
    BEGIN
        ut_trace.Trace ('Inicio LDC_PKGLDCGESTERRRP.FRFLLENAGRILLA', 10);

        IF FBLAPLICAENTREGAXCASO ('0000147')
        THEN

            rfcursor :=
                PERSONALIZACIONES.LDC_PKGLDCGESTERRRP_PER.FRFLLENAGRILLA;

            UT_TRACE.TRACE ('Fin LDC_PKGLDCGESTERRRP.FRFLLENAGRILLA  ', 10);

            RETURN (rfcursor);
        END IF;
    EXCEPTION
        WHEN ex.controlled_error
        THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
        WHEN OTHERS
        THEN
            errors.seterror;
            errors.geterror (onuErrorCode, osbErrorMessage);
    END FRFLLENAGRILLA;
END LDC_PKGLDCGESTERRRP;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKGLDCGESTERRRP
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGLDCGESTERRRP', 'ADM_PERSON'); 
END;
/ 
