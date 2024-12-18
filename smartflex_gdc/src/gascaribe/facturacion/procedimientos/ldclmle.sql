CREATE OR REPLACE PROCEDURE LDCLMLE (
    inuProgramacion   IN ge_process_schedule.process_schedule_id%TYPE)
IS
    /*****************************************************************
       Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2020-23-03
        Ticket      :
        Descripcion : Procedimiento que legaliza ordenes de lectura masiva

      Historia de Modificaciones
      Fecha         TICKET      Autor           Modificacion
      =========     =========   =========       ====================
      31/07/2023    OSF-1379    jpinedc-MVM     * Se reemplaza os_legalizeorders por
                                                api_legalizeorders
                                                * Se reemplaza Errors.setError; por
                                                pkg_error.setError;
                                                * Se reemplaza Errors.getError por
                                                pkg_error.getError
                                                * Se cambia when ex.CONTROLLED_ERROR 
                                                por WHEN pkg_error.Controlled_Error
                                                * Se cambia raise ex.Controlled_Error
                                                por pkg_error.Controlled_Error
                                                * Se quitan variables que no se usan
                                                * Se quita codigo que está en comentarios
                                                * Se reemplaza dbms_output.put_line por pkg_Traza.Trace
                                                * Se agrega pkg_utilidades.prAplicarPermisos
                                                * Se agrega pkg_utilidades.prCrearSinonimos      
      04/04/2024    OSF-2378    jpinedc-MVM     * Ajustes manejo de archivos y 
                                                  últimos estandares de programación
      ******************************************************************/
    sbParametros             GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;
    nuCiclIni                NUMBER;
    nuCiclFin                NUMBER;

    nuTitrLect               VARCHAR2 (4000)
        := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LDC_TITRLECT');
    nuObsLect                NUMBER
        := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LDC_OBSELEMA');
    nuCausLeg                NUMBER
        := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LDC_CAUSLELE');

    nuPersonaLeg             NUMBER := pkg_BOPersonal.fnuGetPersonaId;
    nuConta                  NUMBER;
    nuActividad              LD_PARAMETER.NUMERIC_VALUE%TYPE
        := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ACT_LEC');

    nuerror                  NUMBER;
    osberror                 VARCHAR2 (4000);
    sbcadenalegalizacionot   VARCHAR2 (4000);

    --se consultan ordenes a legalizar
    CURSOR cuOrdenLega IS
        SELECT /*+ index(c IX_LECTELME18)
                  index(A PK_OR_ORDER_ACTIVITY)
                  index(o PK_OR_ORDER)
                  index(p UX_PERIFACT01)
                  */
               o.order_id,
               o.operating_unit_id,
               leemsesu,
               p.pefacicl,
               a.order_activity_id
          FROM lectelme           c,
               or_order_activity  A,
               or_order           o,
               perifact           p
         WHERE     leemdocu = A.order_activity_id
               AND A.order_id = o.order_id
               AND p.pefacodi = c.leempefa
               AND p.pefacicl BETWEEN nuciclini AND nuciclfin
               AND o.task_type_id = nutitrlect
               AND o.order_status_id = 5
               AND leemfele IS NULL;

    --tipo de causal
    CURSOR cuTipoCausal IS
        SELECT DECODE (c.CLASS_CAUSAL_ID, 1, 1, 0)
          FROM ge_causal c
         WHERE c.causal_id = nuCausLeg;

    nucausalClas             NUMBER;
    nusesion                 NUMBER := USERENV ('SESSIONID');

    --se obtiene personas
    CURSOR cuGetPersona (nuunidad NUMBER)
    IS
        SELECT person_id
          FROM or_oper_unit_persons
         WHERE operating_unit_id = nuunidad;

    nuparano                 NUMBER;
    nuparmes                 NUMBER;
    sbparuser                VARCHAR2 (4000);
    
    CURSOR cuOperUnitPerson( inuPersona NUMBER, inuUnidadOper NUMBER)
    IS
    SELECT person_id
    FROM or_oper_unit_persons
    WHERE person_id = inuPersona
    AND operating_unit_id = inuUnidadOper;    

    sbproceso  VARCHAR2(100)  := 'LDCLMLE'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
  
    PROCEDURE prInsertLog (inuOrden      IN NUMBER,
                           inuProducto   IN NUMBER,
                           inuCiclo      IN NUMBER,
                           isbError      IN VARCHAR)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_Traza.Trace ('[prInsertLog] INICIO ' || inuOrden, 10);

        INSERT INTO LDC_LOGLEGMLEC (LOLEORDE,
                                    LOLENUSE,
                                    LOLECICL,
                                    LOLEERRO,
                                    LOLEFECH,
                                    LOLEUSUA,
                                    LOLETERM,
                                    LOLESESI)
             VALUES (inuOrden,
                     inuProducto,
                     inuCiclo,
                     isbError,
                     SYSDATE,
                     USER,
                     USERENV ('TERMINAL'),
                     nusesion);

        COMMIT;
        pkg_Traza.Trace ('[prInsertLog] FIN ', 10);
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Traza.Trace ('[prInsertLog] ERROR ' || SQLERRM, 10);
    END;

    PROCEDURE proEnviaCorreo
    IS
        /**************************************************************************
           Autor       : Luis Javier Lopez Barrios / Horbath
           Fecha       : 2017-04-01
           Ticket      :
           Descripcion : se envia correo.

           Parametros Entrada

           Valor de salida

           HISTORIA DE MODIFICACIONES
           FECHA        AUTOR       DESCRIPCION
         ***************************************************************************/
        sbNombreArchivo   VARCHAR2 (250)
            := 'InforLegMasi_' || TO_CHAR (SYSDATE, 'DDMMYYYY_HH24MISS'); --Ticket 200-991 LJLB-- se almacena el nombre del archivo
        archivo           pkg_GestionArchivos.styArchivo;


        sbMensaje         VARCHAR2 (200)
            :=    'Proceso termino, por favor valide la ruta [/smartfiles/Facturacion/Lecturas], nombre archivo ['
               || sbNombreArchivo
               || ']';


        sbfrom            VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER'); --  se coloca el emisor del correo
        -- Destinatarios
        sbto              VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_EMAILNOLE');

        CURSOR cuCorreo IS
        SELECT trim(regexp_substr(sbto,'[^,]+', 1,LEVEL)) Correo
        FROM dual
        CONNECT BY regexp_substr(sbto, '[^,]+', 1, LEVEL) IS NOT NULL;              

        -- asunto
        sbsubject         VARCHAR2 (255)
            :=    'Informacion de legalizacion Masiva de ordenes lectura del rango de ciclo ['
               || nuCiclIni
               || ' - '
               || nuCiclFin
               || ']';
        sbmsg             VARCHAR2 (10000) := sbMensaje;

        sbfileext         VARCHAR2 (10) := 'txt';

        sbTitulo          VARCHAR2 (4000)
            := 'ORDEN|PRODUCTO|CICLO|ERROR|FECHA|USUARIO|TERMINAL';

        --  Se consulta log de errores
        CURSOR cuErrores IS
            SELECT    LOLEORDE
                   || '|'
                   || LOLENUSE
                   || '|'
                   || LOLECICL
                   || '|'
                   || LOLEERRO
                   || '|'
                   || LOLEFECH
                   || '|'
                   || LOLEUSUA
                   || '|'
                   || LOLETERM    datos
              FROM LDC_LOGLEGMLEC
             WHERE     LOLEUSUA = USER
                   AND LOLESESI = nusesion
                   AND LOLECICL BETWEEN nuCiclIni AND nuCiclFin;

        directorio        VARCHAR2 (255)
                              := '/smartfiles/Facturacion/Lecturas';

        erNoExiste        EXCEPTION;
    BEGIN
        pkerrors.Push ('proEnviaCorreo');

        -- se abre archivo para su escritura
        BEGIN
            archivo :=
                pkg_GestionArchivos.ftAbrirArchivo_SMF (directorio,
                                sbNombreArchivo || '.' || sbfileext,
                                'w');
        EXCEPTION
            WHEN OTHERS
            THEN
                NULL;
        END;

        pkg_GestionArchivos.prcEscribeTermLinea_SMF (archivo);
        pkg_GestionArchivos.prcEscribirLineaSinTerm_SMF (archivo, 'Informacion a Procesar Archivo Plano');
        pkg_GestionArchivos.prcEscribeTermLinea_SMF (archivo);
        pkg_GestionArchivos.prcEscribeTermLinea_SMF (archivo);
        pkg_GestionArchivos.prcEscribirLineaSinTerm_SMF (archivo, sbTitulo);

        -- se cargan los datos para el indicador
        FOR reg IN cuErrores
        LOOP
            pkg_GestionArchivos.prcEscribeTermLinea_SMF (archivo);
            pkg_GestionArchivos.prcEscribirLineaSinTerm_SMF (archivo, reg.datos);
        END LOOP;

        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => sbfrom,
            isbDestinatarios    => sbto,
            isbAsunto           => sbsubject,
            isbMensaje          => sbmsg
        );    

        pkErrors.Pop;
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Traza.Trace (
                'Error no Controlado, en proEnviaCorreo ' || SQLERRM,
                10);
    END proEnviaCorreo;
    
BEGIN

    pkg_Traza.Trace ('[LDCLMLE] INICIO ' || nuCiclIni || ' - ' || nuCiclFin,
                    10);

    -- Obtenemos datos para realizar ejecucion
    nuparano    := TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'));
    nuparmes    := TO_NUMBER (TO_CHAR (SYSDATE, 'MM'));
    sbparuser   := USER;

    -- Start log program
    pkg_estaproc.prinsertaestaproc( sbproceso , 1);
    
    sbParametros := dage_process_schedule.fsbGetParameters_ (inuProgramacion);
    nuCiclIni :=
        TO_NUMBER (ut_string.getparametervalue (sbParametros,
                                                'CICLCODI',
                                                '|',
                                                '='));
    nuCiclFin :=
        TO_NUMBER (ut_string.getparametervalue (sbParametros,
                                                'CICLCICO',
                                                '|',
                                                '='));


    --se consulta tpo de causal
    OPEN cuTipoCausal;
    FETCH cuTipoCausal INTO nucausalClas;
    CLOSE cuTipoCausal;

    pkg_Traza.Trace ('CAUSAL ' || nuCausLeg || ' - TIPO ' || nucausalClas, 10);
    pkg_Traza.Trace (
        'CAUSAL ' || nuCausLeg || ' - TIPO ' || nucausalClas, 10);


    FOR reg IN cuOrdenLega
    LOOP
        sbcadenalegalizacionot := NULL;
        nuerror := NULL;
        osberror := NULL;

        --se valida personas
        OPEN cuOperUnitPerson( nuPersonaLeg, REG.operating_unit_id);
        FETCH cuOperUnitPerson INTO nuConta;
        CLOSE cuOperUnitPerson;

        IF nuConta = 0
        THEN
            IF cuGetPersona%ISOPEN
            THEN
                CLOSE cuGetPersona;
            END IF;

            --se obtiene persona a legalizar
            OPEN cuGetPersona (REG.operating_unit_id);
            FETCH cuGetPersona INTO nuPersonaLeg;
            CLOSE cuGetPersona;
            
        END IF;

        sbcadenalegalizacionot :=
               reg.order_id
            || '|'
            || nuCausLeg
            || '|'
            || nuPersonaLeg
            || '||'
            || reg.order_activity_id
            || '>'
            || nucausalClas
            || ';READING>'
            || '>>;COMMENT1>'
            || nuObsLect
            || '>>;COMMENT2>>>;COMMENT3>>>|'
            || nuActividad
            || '>1>Y>||'
            || '1277;LEGALIZACION DE ORDEN POR CONTIGENCIA FUERZA MAYOR';

        pkg_Traza.Trace (
            'sbcadenalegalizacionot ' || sbcadenalegalizacionot, 10);
            
        api_legalizeorders (sbcadenalegalizacionot,
                           SYSDATE,
                           SYSDATE,
                           NULL,
                           nuerror,
                           osberror);

        IF nuerror = 0
        THEN
            COMMIT;
        ELSE
            prInsertLog (reg.order_id,
                         reg.leemsesu,
                         reg.pefacicl,
                         osberror);
            ROLLBACK;
        END IF;
    END LOOP;

    proEnviaCorreo;

    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso);

    pkg_Traza.Trace ('[LDCLMLE] FIN ', 10);
    
EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR
    THEN
        pkg_error.getError (nuerror, osberror);
        pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', osberror  );
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS
    THEN
        pkg_error.setError;
        pkg_error.getError (nuerror, osberror);
        pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', osberror  );
        RAISE pkg_error.CONTROLLED_ERROR;
END LDCLMLE;
/

Prompt Otorgando permisos de ejecución sobre LDCLMLE
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCLMLE','OPEN');
END;
/

