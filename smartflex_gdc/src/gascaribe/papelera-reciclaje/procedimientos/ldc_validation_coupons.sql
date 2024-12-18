CREATE OR REPLACE PROCEDURE LDC_VALIDATION_COUPONS IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe / Efigas S.A.

    Nombre del Proceso: ldc_validation_coupons
    Descripcion: Este proceso realizará la consulta de la información
                 (Ciclo, Periodo de Facturación, Cuentas de Cobro Generadas, Cupones generados, Impresiones generadas)
                 de los ciclos que se les hayan generado las impresiones de las factura el día anterior
                 a la fecha en que se está ejecutando el SP.
                 Adicionalmente realizará la notificacion por correo a los destinatarios parametrizados
                 en LDC_EMAIL_COUPON_VALIDATION.

    Autor  : Ing. Oscar Ospino Patiño, Ludycom S.A.
    Fecha  : 17-05-2016 (Fecha Creacion Procedimiento)  No Tiquete CA 200-231

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    30-06-2016   Oscar Ospino P.        Se adiciona un Loop para realizar un envìo por cada destinatario
                                        para corregir inconsistencia del Utl_mail.setto que no permite
                                        pasarle todos los correos en una sola cadena.
                                        En el parametro, los correos deben separarse con ";".
    27-06-2024   jpinedc                OSF-2606: * Se usa pkg_Correo
                                        * Ajustes por estándares
    ******************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) := 'LDC_VALIDATION_COUPONS';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    SBPROCESO VARCHAR2(100) := 'LDC_VALIDATION_COUPONS';

    NUSESSION NUMBER := USERENV('sessionid');
    NUPASO    VARCHAR2(20);

    ONUERRORCODE    NUMBER;
    OSBERRORMESSAGE VARCHAR2(4000);

    CURSOR CU_VALIDATION IS
        SELECT DISTINCT C.CICLCODI,
                        C.CICLDESC,
                        P.PEFACODI,
                        --Cuenta de cobro
                        (SELECT COUNT(*)
                         FROM   CUENCOBR CC,
                                FACTURA  F
                         WHERE  F.FACTCODI = CC.CUCOFACT
                         AND    F.FACTPEFA = P.PEFACODI
                         AND    F.FACTPROG = 6) AS CUENTAS_COBRO,
                        --cupones
                        (SELECT COUNT(*)
                         FROM   CUPON   U,
                                FACTURA A
                         WHERE  U.CUPODOCU = A.FACTCODI
                         AND    U.CUPOPROG = 'FIDF'
                         AND    A.FACTPEFA = P.PEFACODI
                         AND    A.FACTFEGE >= P.PEFAFIMO
                         AND    A.FACTFEGE <= P.PEFAFFMO) CUPONES,
                        --impresiones
                        (SELECT COUNT(*)
                         FROM   ED_DOCUMENT D
                         WHERE  D.DOCUTIDO = 66
                         AND    D.DOCUPEFA = P.PEFACODI) IMPRESIONES
        FROM   CICLO    C,
               PERIFACT P,
               ESTAPROG ETP
        WHERE  C.CICLCODI = P.PEFACICL
        AND    P.PEFACODI = ETP.ESPRPEFA
        AND    ETP.ESPRPROG LIKE 'FIDF%'
        AND    P.PEFACODI IN (SELECT E.ESPRPEFA
                              FROM   ESTAPROG E
                              WHERE  P.PEFACODI = E.ESPRPEFA
                              AND    P.PEFAACTU <> 'S' --valida que el periodo no sea el actual.
                              AND    E.ESPRPROG LIKE '%FIDF%'
                              AND    TRUNC(E.ESPRFEFI) = TRUNC(SYSDATE - 1));

    REGCORREO CU_VALIDATION%ROWTYPE;

    -- Correos de los destinatarios
    sbDestinatarios      VARCHAR2(4000) := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_EMAIL_COUPON_VALIDATION');

    sbMensaje  CLOB; --Cuerpo del Correo
    SBMSGTBL VARCHAR2(4000); -- tabla html

    sbAsunto VARCHAR2(500); --Asunto del Correo
    SBCICLO  VARCHAR2(50); --Valor columna Ciclo
    SBPEFA   VARCHAR2(50); --Valor columna Periodo de Facturacion
    SBCUCO   VARCHAR2(50); --Valor columna Cuenta de Cobro
    SBCUPON  VARCHAR2(50); --Valor columna Cupon
    SBIMPRE  VARCHAR2(50); --Valor columna impresiones
    EXDESTCORREOS  EXCEPTION; --Excepcion cuando no hay destinatarios de correos.
    EXPARAMSERV    EXCEPTION; --Excepcion cuando no hay parametros para el servidor de correos.
    EXENVIARCORREO EXCEPTION;

    CURSOR cuCorreo IS
    SELECT regexp_substr(sbDestinatarios,'[^;]+', 1,LEVEL) Destinatario
    FROM dual
    CONNECT BY regexp_substr(sbDestinatarios, '[^;]+', 1, LEVEL) IS NOT NULL        
    ;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    --Inserto el Estado del Proceso
    LDC_PROINSERTAESTAPROG(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),
                           TO_NUMBER(TO_CHAR(SYSDATE, 'MM')),
                           SBPROCESO,
                           'Inicia ejecucion..',
                           NUSESSION,
                           USER);

    sbAsunto := 'INFORME DIARIO VALIDACION DE CUPONES';

    --Actualizar estado del Proceso
    NUPASO := '10';
    LDC_PROACTUALIZAESTAPROG(NUSESSION,
                             'PASO: (' || NUPASO || ') >> ' ||
                             'Obteniendo los parametros de Correo',
                             SBPROCESO,
                             'OK');

    --Se valida que haya datos en los parametros del email
    IF sbDestinatarios IS NULL THEN
        ONUERRORCODE := 10;
        RAISE EXDESTCORREOS;
    END IF;

    IF ONUERRORCODE IS NULL THEN

        --Encabezado de la tabla
        SBCICLO := 'CICLO';
        SBPEFA  := 'PERIODO DE FACTURACION';
        SBCUCO  := 'CUENTAS DE COBRO';
        SBCUPON := 'CUPONES';
        SBIMPRE := 'IMPRESIONES DE FACTURA';

        sbMensaje := '<div align="center"><b>INFORME DIARIO VALIDACION DE CUPONES</b><p>Fecha de Proceso: ' ||
                   SYSDATE ||
                   '<br></p><br><br><style type="text/css">
                                                                                .tg  {border-collapse:collapse;border-spacing:0}
                                                                                .tg td{font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
                                                                                .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
                                                                                .tg .tg-1{text-align:left}
                                                                                .tg .tg-2{text-align:center}
                                                                                .tg .tg-3{text-align:right}
                                                                                .tgh {background-color: #E5ECF9}
                                                                            </style><table class="tg"><tr><th class="tgh tg-2">Ciclo</th><th class="tgh tg-2">Periodo de Facturacion</th><th class="tgh tg-2">Cuentas de Cobro</th>
                                    <th class="tgh tg-2">Cupones</th><th class="tgh tg-2">Impresiones Factura</th>
                                    </tr>
                                                                            ##TABLA##
                                                                            <br><br><br><table width="100%" border="0"><tr bgcolor="#E5ECF9"><td><div align="center"><font face="Tahoma" size="1" color="#FFFFFF"><font color="#003333"><b> Open SmartFlex </b></font></font></div></td></tr></table></div>';

        --Actualizar estado del Proceso
        NUPASO := '20';
        LDC_PROACTUALIZAESTAPROG(NUSESSION,
                                 'PASO: (' || NUPASO || ') >> ' ||
                                 'Cargado los datos del reporte en el cuerpo del sbMensaje.',
                                 SBPROCESO,
                                 'OK');

        FOR REGCORREO IN CU_VALIDATION LOOP
            --Se rellenan los datos del cursor [tipo fila]
            SBCICLO := REGCORREO.CICLCODI || ' - ' || REGCORREO.CICLDESC;
            SBPEFA  := REGCORREO.PEFACODI;
            SBCUCO  := REGCORREO.CUENTAS_COBRO;
            SBCUPON := REGCORREO.CUPONES;
            SBIMPRE := REGCORREO.IMPRESIONES;

            --html
            SBMSGTBL := SBMSGTBL || '<tr><td class="tg-1">' || SBCICLO ||
                        '</td><td class="tg-2">' || SBPEFA || '</td><td class="tg-2">' ||
                        SBCUCO || '</td><td class="tg-2">' || SBCUPON ||
                        '</td><td class="tg-2">' || SBIMPRE || '</td></tr>';
        END LOOP;

        --Se Cierra la tabla html
        SBMSGTBL := SBMSGTBL || '</table>';

        --INSERTO LA TABLA CON DATOS EN EL BODY DEL sbMensaje
        sbMensaje := REPLACE(sbMensaje, '##TABLA##', SBMSGTBL);

        NUPASO := '30';
        FOR rgCorreo IN cuCorreo LOOP

            --Actualizar estado del Proceso
            NUPASO := NUPASO + 1;
            LDC_PROACTUALIZAESTAPROG(NUSESSION,
                                     'PASO: (' || NUPASO || ') >> ' ||
                                     'Enviando Correo electronico a ' || rgCorreo.DESTINATARIO,
                                     SBPROCESO,
                                     'OK');


            pkg_Correo.prcEnviaCorreo
            (
                isbDestinatarios    => rgCorreo.DESTINATARIO,
                isbAsunto           => sbAsunto,
                isbMensaje          => sbMensaje,
                isbDescRemitente    => 'Open Smart Flex'
            );

        END LOOP;

        IF ONUERRORCODE = 0 AND OSBERRORMESSAGE IS NULL THEN
            ONUERRORCODE := NULL;
        ELSIF (ONUERRORCODE IS NOT NULL) OR OSBERRORMESSAGE IS NOT NULL THEN
            RAISE EXENVIARCORREO;
        END IF;
        NUPASO := '40';
        LDC_PROACTUALIZAESTAPROG(NUSESSION,
                                 'PASO: (' || NUPASO || ') >> ' || 'Termino OK',
                                 SBPROCESO,
                                 'OK');

    END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

EXCEPTION
    WHEN EXDESTCORREOS THEN
        ONUERRORCODE    := SQLCODE;
        OSBERRORMESSAGE := ONUERRORCODE ||
                           ' - El parametro EMAIL_COUPON_VALIDATION no tiene destinatarios de correo.';
        pkg_Traza.Trace(OSBERRORMESSAGE);
        LDC_PROACTUALIZAESTAPROG(NUSESSION,
                                 'PASO: (' || NUPASO || ') >> ' || OSBERRORMESSAGE,
                                 SBPROCESO,
                                 'ERROR');
    WHEN EXPARAMSERV THEN
        ONUERRORCODE    := SQLCODE;
        OSBERRORMESSAGE := ONUERRORCODE || ' - Error en los parametros del servidor de correo.';
        pkg_Traza.Trace(OSBERRORMESSAGE);
        LDC_PROACTUALIZAESTAPROG(NUSESSION,
                                 'PASO: (' || NUPASO || ') >> ' || OSBERRORMESSAGE,
                                 SBPROCESO,
                                 'ERROR');
    WHEN EXENVIARCORREO THEN
        ONUERRORCODE    := SQLCODE;
        OSBERRORMESSAGE := ONUERRORCODE || ' - Error al enviar el correo electronico.';
        pkg_Traza.Trace(OSBERRORMESSAGE);
        LDC_PROACTUALIZAESTAPROG(NUSESSION,
                                 'PASO: (' || NUPASO || ') >> ' || OSBERRORMESSAGE,
                                 SBPROCESO,
                                 'ERROR');
    WHEN OTHERS THEN
        ONUERRORCODE    := SQLCODE;
        OSBERRORMESSAGE := ONUERRORCODE || ' - Termino con error no controlado.';
        pkg_Traza.Trace(OSBERRORMESSAGE);
        LDC_PROACTUALIZAESTAPROG(NUSESSION,
                                 'PASO: (' || NUPASO || ') >> ' || OSBERRORMESSAGE,
                                 SBPROCESO,
                                 'ERROR');

END LDC_VALIDATION_COUPONS;
/

GRANT EXECUTE on LDC_VALIDATION_COUPONS to SYSTEM_OBJ_PRIVS_ROLE;
/

