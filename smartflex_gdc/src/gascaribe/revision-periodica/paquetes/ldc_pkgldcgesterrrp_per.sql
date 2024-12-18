CREATE OR REPLACE PACKAGE PERSONALIZACIONES.LDC_PKGLDCGESTERRRP_PER
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
                llopez          con OPEN.LDC_PKGLDCGESTERRRP
                jpinedc
  03/03/2023   	jpinedc         OSF-858: Se modifica FRFLLENAGRILLA 
  07/03/2023   	jpinedc      	OSF-953: Se modifica FRFLLENAGRILLA
 ***************************************************************************/
    -- Procesa la información del PB LDCGESTERRRP
    PROCEDURE PRCPROCESAGRILLA
    (
        inuorden        IN  NUMBER,
        onuErrorCode    OUT NUMBER,
        osbErrorMessage OUT VARCHAR2
    );
    
    -- Llena información en el PB LDCGESTERRRP
    FUNCTION FRFLLENAGRILLA RETURN constants_per.tyrefcursor;
    
    -- Crea registros en la tabla de auditoría LDC_AUD_BLOQ_LEGA_SOL
    PROCEDURE LDC_PROC_AUD_BLOQ_LEGA_SOL 
    (
        nmpasolicitud       NUMBER,
        nmpaorden           NUMBER,
        sbmensaje       OUT VARCHAR
    );    

    -- Borra registros de la tabla ldc_logerrleorresu
    PROCEDURE Ldc_job_BorraErrAsigOrdRP;

END LDC_PKGLDCGESTERRRP_PER;
/

CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.LDC_PKGLDCGESTERRRP_PER
IS
    csbPARAM_PROCESOS_DESB_ORD   CONSTANT  VARCHAR2(200)
        := ldc_bcConsGenerales.fsbValorColumna (
                          'OPEN.LDC_PARAREPE',
                          'PARAVAST',
                          'PARECODI',
                          'PARAM_PROCESOS_DESB_ORD') ;

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
    *************************************************************************************************************/
    PROCEDURE PRCPROCESAGRILLA
    (
        inuorden        IN  NUMBER,
        onuErrorCode    OUT NUMBER,
        osbErrorMessage OUT VARCHAR2
    )
    IS
        nuSolicitud   NUMBER;                          --se almacena solicitud

        --se obtiene solicitud de la orden
        CURSOR cuGetSolicitud IS
            SELECT oa.package_id
              FROM open.or_order_activity oa
             WHERE oa.order_id = Inuorden;
    BEGIN
        ut_trace.Trace ('Inicio LDC_PKGLDCGESTERRRP_PER.PRCPROCESAGRILLA', 10);

        OPEN cuGetSolicitud;
        FETCH cuGetSolicitud INTO nuSolicitud;
        CLOSE cuGetSolicitud;

        --se elimina registro de bloqueo
        DELETE FROM open.LDC_BLOQ_LEGA_SOLICITUD
        WHERE PACKAGE_ID_GENE = nuSolicitud;

        DELETE open.LDC_ORDER
        WHERE ORDER_ID = iNUORDEN;

        osbErrorMessage := NULL;
        /*CA516 JJJM Inicio*/
        ldc_proc_aud_bloq_lega_sol (nuSolicitud, inuorden, osbErrorMessage);

        IF osbErrorMessage IS NOT NULL
        THEN
            NULL;
        END IF;

        ut_trace.Trace ('Termina LDC_PKGLDCGESTERRRP_PER.PRCPROCESAGRILLA', 10);
    EXCEPTION
        WHEN ex.controlled_error THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
        WHEN OTHERS THEN
            errors.seterror;
            errors.geterror (onuErrorCode, osbErrorMessage);
    END PRCPROCESAGRILLA;

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
                                                               se hace el llamado de la funci?n ldc_fncretornaotultmenerr
    03/03/2023      jpinedc                             OSF-858: Se modifica rfcursor                                                                
    07/03/2023      jpinedc                             OSF-953: Se modifica rfcursor para incluir ordenes bloquedas
                                                                 que no tienen registro de error
    ***********************************************************************************************************/
    FUNCTION FRFLLENAGRILLA RETURN constants_per.tyrefcursor
    IS
        onuErrorCode      NUMBER;                --se almacena codigo de error
        osbErrorMessage   VARCHAR2 (4000);      --se almacena mensaje de error
        rfcursor          constants_per.tyrefcursor; --se almacena cursor referenciado
    BEGIN
        ut_trace.Trace ('Inicio LDC_PKGLDCGESTERRRP_PER.FRFLLENAGRILLA', 10);

        OPEN rfcursor FOR
            WITH procesos AS
            (   SELECT /*+ MATERIALIZE */ COLUMN_VALUE     NOMBRE_PROCESO
                FROM TABLE (CAST (ldc_bcConsGenerales.ftbSplitString (csbPARAM_PROCESOS_DESB_ORD,',') AS tStringTable))
            ),
            ordenes_error AS
            (   SELECT er.order_id, er.ordepadre, MAX (er.id) id_error
                FROM ldc_logerrleorresu er, open.or_order od1
                WHERE proceso IN (SELECT nombre_proceso FROM procesos)
                AND od1.order_id = er.order_id
                AND od1.order_status_id = 0
                GROUP BY er.order_id, er.ordepadre
                UNION ALL
                (
                    SELECT distinct  oa.order_id, null ordepadre, null id_error
                    FROM open.LDC_BLOQ_LEGA_SOLICITUD ls,
                    open.or_order_activity oa,
                    open.or_order od  
                    WHERE oa.package_id = ls.package_id_gene
                    AND NOT EXISTS
                    (
                        select '1'
                        from personalizaciones.ldc_logerrleorresu er
                        where er.order_id = oa.order_id
                    )
                    AND od.order_id = oa.order_id
                    AND od.order_status_id = 0
                    UNION
                    SELECT ls.order_id, null ordepadre, null id_error
                    FROM open.LDC_order ls,
                    open.or_order od 
                    WHERE od.order_id = ls.order_id
                    AND NOT EXISTS
                    (
                        select '1'
                        from personalizaciones.ldc_logerrleorresu er
                        where er.order_id = ls.order_id
                    )
                    AND od.order_status_id = 0
                    AND ls.ORDEBLOQ = 'S'
                )                                        
            ),             
            datos_actividad AS
            (   SELECT  oe2.order_id,
                        oe2.id_error,
                        od2.task_type_id            ttOrden,
                        oa1.product_id,
                        oa1.package_id,
                        gl1.geograp_location_id     LOCA,
                        gl1.geo_loca_father_id      DEPA,
                        oe2.ordepadre               OrdenPadre,
                        od3.task_type_id            ttOrdenPadre,
                        pr.product_status_id
                FROM    ordenes_error            oe2,
                        open.or_order            od2,
                        open.or_order_activity   oa1,
                        open.ab_address          ad1,
                        open.ge_geogra_location  gl1,
                        open.or_order            od3,
                        open.pr_product          pr
                WHERE   od2.order_id                = oe2.order_id
                        AND oa1.order_id            = oe2.order_id
                        AND ad1.address_id          = oa1.address_id
                        AND gl1.geograp_location_id = ad1.geograp_location_id
                        AND od3.order_id(+)         = oe2.ordepadre
                        AND pr.product_id(+)        = oa1.product_id
                        AND (   EXISTS
                                    (SELECT 1
                                       FROM open.LDC_BLOQ_LEGA_SOLICITUD
                                      WHERE PACKAGE_ID_GENE =
                                            oa1.package_id)
                                OR 
                                EXISTS
                                    (SELECT 1
                                       FROM open.LDC_ORDER L
                                      WHERE     l.order_id = od2.ORDER_ID
                                            AND l.ordebloq = 'S'))
            )
            SELECT da.order_id                     ORDEN,
                      da.ttOrden
                   || ' - '
                   || ldc_bcConsGenerales.fsbValorColumna (
                          'OPEN.OR_TASK_TYPE',
                          'DESCRIPTION',
                          'TASK_TYPE_ID',
                          da.ttOrden)              TIPO_TRABAJO,
                   da.package_id                   SOLICITUD,
                   da.product_id                   PRODUCTO,
                      da.product_status_id
                   || ' - '
                   || ldc_bcConsGenerales.fsbValorColumna (
                          'OPEN.PS_PRODUCT_STATUS',
                          'DESCRIPTION',
                          'PRODUCT_STATUS_ID',
                          da.product_status_id)    ESTADO_PRODUCTO,
                      da.DEPA
                   || ' - '
                   || ldc_bcConsGenerales.fsbValorColumna (
                          'OPEN.GE_GEOGRA_LOCATION',
                          'DESCRIPTION',
                          'GEOGRAP_LOCATION_ID',
                          da.DEPA)                 DEPARTAMENTO,
                      da.LOCA
                   || ' - '
                   || ldc_bcConsGenerales.fsbValorColumna (
                          'OPEN.GE_GEOGRA_LOCATION',
                          'DESCRIPTION',
                          'GEOGRAP_LOCATION_ID',
                          da.LOCA)                 LOCALIDAD,
                   da.OrdenPadre                   ORDEN_PADRE,
                      da.ttOrdenPadre
                   || ' - '
                   || ldc_bcConsGenerales.fsbValorColumna (
                          'OPEN.OR_TASK_TYPE',
                          'DESCRIPTION',
                          'TASK_TYPE_ID',
                          da.ttOrdenPadre)         TTRABAJO_OTPADRE,
                   er.fechgene                     FECHA_ERROR,
                   er.menserror                    MENSAJE_ERROR,
                   er.proceso                      PROCESO
              FROM datos_actividad da, ldc_logerrleorresu er
             WHERE er.id(+) = da.id_error;

        ut_trace.Trace ('Termina LDC_PKGLDCGESTERRRP_PER.FRFLLENAGRILLA', 10);

        RETURN (rfcursor);
    EXCEPTION
        WHEN ex.controlled_error
        THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
        WHEN OTHERS
        THEN
            errors.seterror;
            errors.geterror (onuErrorCode, osbErrorMessage);
    END FRFLLENAGRILLA;

    /**************************************************************************************************************
     Autor       :  Horbath
     Fecha       : 2020-OCT-22
     Proceso     : LDC_PROC_AUD_BLOQ_LEGA_SOL
     Ticket      : 516
     Descripcion : Proceso que se encarga crear registros en la tabla de auditoria LDC_AUD_BLOQ_LEGA_SOL

     Parametros Entrada
      nmpasolicitud  Solicitud
      nmpaorden      Orden

     Valor de salida
      sbmensaje      mensaje de error

     Historia de Modificaciones
     Fecha               Autor                             Modificacion
     =========           =========                      ====================

    *************************************************************************************************************/
    PROCEDURE ldc_proc_aud_bloq_lega_sol (nmpasolicitud       NUMBER,
                                          nmpaorden           NUMBER,
                                          sbmensaje       OUT VARCHAR)
    IS
    BEGIN
        sbmensaje := NULL;

        INSERT INTO ldc_aud_bloq_lega_sol (package_id,
                                                order_id,
                                                usuario,
                                                fecha,
                                                maquina)
             VALUES (nmpasolicitud,
                     nmpaorden,
                     USER,
                     SYSDATE,
                     SYS_CONTEXT ('USERENV', 'TERMINAL'));
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            sbmensaje :=
                   'Errorn en ldc_pkgldcgesterrrp.ldc_proc_aud_bloq_lega_sol : '
                || SQLERRM;
    END ldc_proc_aud_bloq_lega_sol;

    /**************************************************************************************************************
     Autor       :  Lubin Pineda - MVM
     Fecha       :  07-02-2023
     Proceso     :  Ldc_job_BorraErrAsigOrdRP
     Ticket      :  OSF-858
     Descripcion :  Proceso que borra registros en la tabla ldc_logerrleorresu

     Parametros Entrada

     Valor de salida

     Historia de Modificaciones
     Fecha               Autor                             Modificacion
     =========           =========                      ====================
	 28/02/2023			jpinedc - MVM					OSF-858 - Se borran registros anteriores a 2 dias sin 
														importar el proceso     
    *************************************************************************************************************/
    PROCEDURE Ldc_job_BorraErrAsigOrdRP
    IS
        CURSOR culdc_logerrleorresu IS
            SELECT er.ROWID     Rid
              FROM ldc_logerrleorresu er
             WHERE     fechgene < TRUNC (SYSDATE) - 2;

        TYPE tytbldc_logerrleorresu IS TABLE OF culdc_logerrleorresu%ROWTYPE
            INDEX BY BINARY_INTEGER;

        tbldc_logerrleorresu   tytbldc_logerrleorresu;
        
    BEGIN
        ut_trace.Trace (
            'Inicia LDC_PKGLDCGESTERRRP_PER.Ldc_job_BorraErrAsigOrdRP',
            10);

        LOOP
            tbldc_logerrleorresu.DELETE;

            OPEN culdc_logerrleorresu;

            FETCH culdc_logerrleorresu
                BULK COLLECT INTO tbldc_logerrleorresu
                LIMIT 1000;

            CLOSE culdc_logerrleorresu;

            EXIT WHEN tbldc_logerrleorresu.COUNT = 0;

            FORALL i IN 1 .. tbldc_logerrleorresu.COUNT
                DELETE FROM ldc_logerrleorresu
                      WHERE ROWID = tbldc_logerrleorresu (i).RID;

            COMMIT;
        END LOOP;

        ut_trace.Trace (
            'Termina LDC_PKGLDCGESTERRRP_PER.Ldc_job_BorraErrAsigOrdRP',
            10);
    END Ldc_job_BorraErrAsigOrdRP;
    
END LDC_PKGLDCGESTERRRP_PER;
/

