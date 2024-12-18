CREATE OR REPLACE PROCEDURE prAsignarcPlano (
    sbPathFile    IN VARCHAR2,
    sbFile_Name   IN VARCHAR2,
    nuPerson      IN GE_PERSON.PERSON_ID%TYPE)
IS
    /*****************************************************************
      Unidad         : prAsignarcPlano
      Descripcion    : Asignación por archivo plano
      Fecha          : 13/03/2018

      Historia de Modificaciones
      Fecha             Autor               Modificacion
      =========         =========           ====================
      05/04/2024        jpinedc             OSF-2378: Se cambia utl_file por
                                            pkg_gestionArchivos y nuevos estandares
      28/08/2024        jpinedc             OSF-3210: Se reemplazan caracteres
                                            extraños
      ******************************************************************/
    SUBTYPE STYSIZELINE IS VARCHAR2 (32000);

    fpOrdersData                   pkg_gestionArchivos.styArchivo;
    sbLine                         STYSIZELINE;
    nuRecord                       NUMBER;
    fpOrderErrors                  pkg_gestionArchivos.styArchivo;
    sbErrorFile                    VARCHAR2 (100);
    sbErrorLine                    STYSIZELINE;
    nuOrderId                      OR_ORDER.ORDER_ID%TYPE;
    nuValida                       NUMBER;
    nuErrorCode                    NUMBER;
    sbErrorMessage                 VARCHAR2 (2000);
    sbOrder                        VARCHAR2 (2000);
    sbOperating_Unit               VARCHAR2 (2000);
    nuOperatingUnitId              OR_ORDER.OPERATING_UNIT_ID%TYPE;
    rcOrder                        DAOR_ORDER.STYOR_ORDER;
    rcPerson                       DAGE_PERSON.STYGE_PERSON;

    sbElimCaracter                 LD_PARAMETER.VALUE_CHAIN%TYPE
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('ELIM_ORASAR');
        
    sbRemitente                 LD_PARAMETER.VALUE_CHAIN%TYPE
        := DALD_PARAMETER.fsbGetValue_Chain('LDC_SMTP_SENDER');

    PROCEDURE LockOrder (
        INUORDER_ID       IN     OR_ORDER.ORDER_ID%TYPE,
        ONUERRORCODE         OUT NUMBER,
        OSBERRORMESSAGE      OUT GE_MESSAGE.DESCRIPTION%TYPE)
    IS
    BEGIN
        OR_BOFWLEGALIZEORDERUTIL.LockOrder (INUORDER_ID);
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            pkg_Error.getError (ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError (ONUERRORCODE, OSBERRORMESSAGE);
    END LockOrder;
BEGIN
    pkg_Traza.Trace ('[prAsignarcPlano] INICIO', 3);

    rcPerson := DAGE_PERSON.FRCGETRECORD (nuPerson);
     
    IF rcPerson.E_MAIL IS NOT NULL
    THEN
        pkg_Correo.prcEnviaCorreo 
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => rcPerson.E_MAIL,
            isbAsunto           => 'ASIGNACIÓN POR ARCHIVO PLANO ',
            isbMensaje          => 'INICIA ASIGNACIÓN POR ARCHIVO PLANO'
        );
    END IF;

    pkg_gestionArchivos.prcValidaExisteArchivo_SMF (sbPathFile , sbFile_Name);
    
    sbErrorFile := SUBSTR (sbFile_Name, 1, INSTR (sbFile_Name, '.') - 1);

    IF sbErrorFile IS NULL
    THEN
        sbErrorFile := sbFile_Name;
    END IF;

    sbErrorFile := sbErrorFile || '.err';

    fpOrdersData := pkg_gestionArchivos.ftAbrirArchivo_SMF (
                               sbPathFile,
                               sbFile_Name,
                               'r'
                               );
                               
    fpOrderErrors := pkg_gestionArchivos.ftAbrirArchivo_SMF (
                      sbPathFile,
                      sbErrorFile,
                      'w');
    nuRecord := 0;

    LOOP
        BEGIN
        
            sbLine := pkg_gestionArchivos.fsbObtenerLinea_SMF (fpOrdersData);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    EXIT;
        END;

        IF sbElimCaracter = 'S'
        THEN
            sbLine := TRIM (SUBSTR (sbLine, 1, LENGTH (sbLine) - 1));
        ELSE
            sbLine := TRIM (sbLine);
        END IF;

        nuRecord := nuRecord + 1;
        nuValida := LENGTH (sbLine) - LENGTH (REPLACE (sbLine, ';', ''));

        IF nuValida != 1
        THEN
            sbErrorLine :=
                '[' || nuRecord || '] LA ESTRUCTURA DE LA LINEA NO CUMPLE';
            pkg_Traza.Trace (
                'Error ' || nuErrorCode || '-' || sbErrorMessage);
            pkg_gestionArchivos.prcEscribirLinea_SMF (fpOrderErrors, sbErrorLine);
            sbErrorLine := NULL;
        ELSE
            sbOrder := SUBSTR (sbLine, 1, INSTR (sbLine, ';') - 1);
            sbOperating_Unit := SUBSTR (sbLine, INSTR (sbLine, ';') + 1);

            BEGIN
                nuOrderId := TO_NUMBER (sbOrder);
                nuOperatingUnitId := TO_NUMBER (TRIM (sbOperating_Unit));
            EXCEPTION
                WHEN OTHERS
                THEN
                    nuOrderId := NULL;
                    nuOperatingUnitId := NULL;
                    sbErrorLine :=
                           '['
                        || nuRecord
                        || '] ERROR AL CONVERTIR LA ORDEN O LA UNIDAD OPERATIVA';
                    pkg_gestionArchivos.prcEscribirLinea_SMF (fpOrderErrors, sbErrorLine);
                    sbErrorLine := NULL;
            END;

            IF nuOrderId IS NOT NULL AND nuOperatingUnitId IS NOT NULL
            THEN
                SAVEPOINT ASIGNA;
                LockOrder (nuOrderId, nuErrorCode, sbErrorMessage);

                IF nuErrorCode <> GE_BOCONSTANTS.CNUSUCCESS
                THEN
                    sbErrorLine :=
                           nuOrderId
                        || ' '
                        || nuErrorCode
                        || '-'
                        || sbErrorMessage;
                    pkg_Traza.Trace (
                           'Orden ['
                        || nuOrderId
                        || '] Error '
                        || nuErrorCode
                        || '-'
                        || sbErrorMessage);
                    pkg_gestionArchivos.prcEscribirLinea_SMF (fpOrderErrors, sbErrorLine);
                    sbErrorLine := NULL;
                    ROLLBACK TO ASIGNA;
                ELSE
                    rcOrder := pkg_BCOrdenes.FRCGETRECORD (nuOrderId);

                    IF rcOrder.Order_Status_Id != 0
                    THEN
                        sbErrorLine :=
                               '['
                            || nuRecord
                            || ']['
                            || nuOrderId
                            || '] La orden no se encuentra en estado 0-Registrada';
                        pkg_Traza.Trace (
                               'Orden ['
                            || nuOrderId
                            || '] Error '
                            || nuErrorCode
                            || '-'
                            || sbErrorMessage);
                        pkg_gestionArchivos.prcEscribirLinea_SMF (fpOrderErrors, sbErrorLine);
                        sbErrorLine := NULL;
                        ROLLBACK TO ASIGNA;
                        
                    ELSE
                                        
                        api_Assign_Order (nuOrderId,
                                         nuOperatingUnitId,
                                         nuErrorCode,
                                         sbErrorMessage);

                        IF nuErrorCode <> GE_BOCONSTANTS.CNUSUCCESS
                        THEN
                            sbErrorLine :=
                                   '['
                                || nuRecord
                                || ']['
                                || nuOrderId
                                || '] '
                                || nuErrorCode
                                || '-'
                                || sbErrorMessage;
                            pkg_Traza.Trace (
                                   'Error '
                                || nuErrorCode
                                || '-'
                                || sbErrorMessage);
                            pkg_gestionArchivos.prcEscribirLinea_SMF (fpOrderErrors, sbErrorLine);
                            sbErrorLine := NULL;

                            ROLLBACK TO ASIGNA;
                        ELSE
                            COMMIT;
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
    END LOOP;

    IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fpOrdersData)
    THEN
        pkg_gestionArchivos.prcCerrarArchivo_SMF (fpOrdersData);
    END IF;

    IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fpOrderErrors)
    THEN
        pkg_gestionArchivos.prcCerrarArchivo_SMF (fpOrderErrors);
    END IF;

    COMMIT;

    IF rcPerson.E_MAIL IS NOT NULL
    THEN
    
        pkg_Correo.prcEnviaCorreo 
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => rcPerson.E_MAIL,
            isbAsunto           => 'ASIGNACIÓN POR ARCHIVO PLANO ',
            isbMensaje          => 'TERMINÓ ASIGNACIÓN POR ARCHIVO PLANO. VALIDAR ARCHIVO: '
            || sbPathFile
            || '/'
            || sbErrorFile
        );
            
     
    END IF;

    pkg_Traza.Trace ('[prAsignarcPlano] FIN', 3);
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR
    THEN
        pkg_Error.getError (nuErrorCode, sbErrorMessage);
        pkg_Correo.prcEnviaCorreo 
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => rcPerson.E_MAIL,
            isbAsunto           => 'NOTIFICACION DE ERROR [ORASAR]',
            isbMensaje          => sbErrorMessage
        );
        ROLLBACK;
        RAISE pkg_Error.CONTROLLED_ERROR;
    WHEN OTHERS
    THEN
        pkg_Error.setError;
        pkg_Error.getError (nuErrorCode, sbErrorMessage);
        sbErrorMessage := sbErrorMessage || 'Error no controlado ' || SQLERRM;
        pkg_Correo.prcEnviaCorreo 
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => rcPerson.E_MAIL,
            isbAsunto           => 'NOTIFICACION DE ERROR [ORASAR]',
            isbMensaje          => sbErrorMessage
        );
        ROLLBACK;
        RAISE pkg_Error.CONTROLLED_ERROR;
END;
/