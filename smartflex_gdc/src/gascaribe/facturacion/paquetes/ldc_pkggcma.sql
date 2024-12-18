CREATE OR REPLACE PACKAGE LDC_PKGGCMA IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    Paquete     :   LDC_PKGGCMA
    Autor       :   
    Fecha       :   
    Descripcion :   Paquete para la gestión de la automatización de la facturación
    
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     24-04-2024  OSF-2580    PRJOBNOTIPROCFACT: Se cambia ldc_sendemail por 
                                        pkg_Correo.prcEnviaCorreo
*******************************************************************************/

  sbPEFAANO ge_boInstanceControl.stysbValue;
  sbPEFAMES ge_boInstanceControl.stysbValue;
  sbPEFACODI ge_boInstanceControl.stysbValue;
  sbPEFAFEPA ge_boInstanceControl.stysbValue;
  sbPEFAACTU ge_boInstanceControl.stysbValue;
  sbPEFAOBSE ge_boInstanceControl.stysbValue;
  sbPEFAFEGE ge_boInstanceControl.stysbValue;
  sbProceso ge_boInstanceControl.stysbValue;
  sbPEFAORDE ge_boInstanceControl.stysbValue;
   cnuNULL_ATTRIBUTE constant number := 2126;
   dtFechaProg DATE;

 PROCEDURE prValidaInfor;
 /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Proceso     : prValidaInfor
      Fecha       : 2020-13-03
      Ticket      : 65
      Descripcion : proceso que se encarga de validar informacion del PB [LDCGCAM]

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
 FUNCTION FRFGETGCAM Return constants.tyrefcursor;
 /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Proceso     : prValidaInfor
      Fecha       : 2020-13-03
      Ticket      : 65
      Descripcion : funcion que se encarga de llenar PB [LDCGCAM]

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
 PROCEDURE PRGCAM(isbperiodo   In Varchar2,
                  inucurrent   In Number,
                  inutotal     In Number,
                  onuerrorcode Out ge_error_log.message_id%Type,
                  osberrormess Out ge_error_log.description%Type);
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Proceso     : PRGCAM
      Fecha       : 2020-13-03
      Ticket      : 65
      Descripcion : Proceso que genera programaciones del  PB [LDCGCAM]

      Parametros Entrada
        isbperiodo  periodo de facturacion
        inucurrent  valor actual
        inutotal    total
      Valor de salida
        onuerrorcode  codigo de error
        osberrormess  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE PRJOBGENCARGAUTO;
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRJOBGENCARGAUTO
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : Job que genera los cargos automaticamente

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE PRVALIPROFGCC(inuPeriodo IN NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2);
       /**************************************************************************
      Autor       : Horbath
      Proceso     : PRVALIPROFGCC
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de validar las condiciones para ejecucion del periodo para FGCC

      Parametros Entrada
       inuPeriodo  periodo de facturacion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE PRVALIPROFCPE(inuPeriodo IN NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2);
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRVALIPROFCPE
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de validar las condiciones para ejecucion del periodo para FCPE

      Parametros Entrada
       inuPeriodo  periodo de facturacion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE PRPROGFGCC ( inuPeriodo IN NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2);
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRPROGFGCC
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de programar el proceso FGCC

      Parametros Entrada
       inuPeriodo  periodo de facturacion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE 	PRPROGFIDF( inuPeriodo IN NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2);
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRPROGFIDF
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de programar el proceso FIDF

      Parametros Entrada
       inuPeriodo  periodo de facturacion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE 	PRPROGFCPE( inuPeriodo IN NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2);
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRPROGFCPE
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de programar el proceso FCPE

      Parametros Entrada
       inuPeriodo  periodo de facturacion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE 	PRPROCOPYFACT;
    /**************************************************************************
      Autor       : Horbath
      Proceso     : PRPROCOPYFACT
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : job que se encarga de generar proceso LDCCOPYFACT

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE PRJOBNOTIPROCFACT;
      /**************************************************************************
      Autor       : Horbath
      Proceso     : PRJOBNOTIPROCFACT
      Fecha       : 2021-26-07
      Ticket      : 696
      Descripcion : job que se encarga de enviar correo de procesos de facturacion

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
END LDC_PKGGCMA;
/

CREATE OR REPLACE PACKAGE BODY LDC_PKGGCMA IS
  sbCadenaCone  VARCHAR2(100);
 sbUsuario      VARCHAR2(100);
 sbpassword     VARCHAR2(100);
 sbInstance     VARCHAR2(100);
 sbCadeScrip    VARCHAR2(500);
 sbdateformat   VARCHAR2(100);--se almacena formato de fecha
 nuConsecutivo  NUMBER := 0;
 nuIdReporte NUMBER;

 sbCiclo VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CICLEXPCA',NULL);

   --se retorna periodo
  CURSOR cugetPeriodo(nuPeriodo NUMBER) IS
  SELECT PEFADESC, PEFACICL, PEFAANO, PEFAMES, UT_DATE.FSBSTR_DATE(UT_DATE.FDTSYSDATE()) fecha,
        pefafimo, pefaffmo
  FROM perifact
  WHERE pefacodi = nuPeriodo;

  NUMINUTOS           NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_MINENTHILOS', NULL);
  sbPEFAFEGEP ge_boInstanceControl.stysbValue;

  PROCEDURE prValidProgPeriodo
    (
      inuExecuta    IN  SA_EXECUTABLE.NAME%TYPE,
      inuperiodo    IN  PERIFACT.PEFACODI%TYPE
    )
    IS

        --variables para job
        nuJob                  GE_PROCESS_SCHEDULE.JOB%TYPE;
        sbparametros           GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;
        nuprogramacion         GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE;
        sbFechaejec            VARCHAR2(300);
        sbHoraejec             VARCHAR2(300);
        sbFrecuencia           VARCHAR2(300);
        --variables para ejecutables
        nuTipoejecutable       SA_EXECUTABLE.EXECUTABLE_TYPE_ID%TYPE;
        nuEjeOperTipo          SA_EXECUTABLE.EXEC_OPER_TYPE_ID%TYPE;
        nuEjecPath              VARCHAR2(200);
        cuprogramacion         PKCONSTANTE.TYREFCURSOR;
        nuExecutable           SA_EXECUTABLE.EXECUTABLE_ID%TYPE;
        sbdescripcion          SA_EXECUTABLE.DESCRIPTION%TYPE;
        nuEjecPadre            SA_EXECUTABLE.PARENT_EXECUTABLE_ID%TYPE;
        nuModulo               SA_EXECUTABLE.MODULE_ID%TYPE;
        sbversion              SA_EXECUTABLE.VERSION%TYPE;

        tblDetalleProg         DAGE_PROC_SCHE_DETAIL.TYTBGE_PROC_SCHE_DETAIL;

        nuPosiServ            NUMBER;
        nuPosiperiodo         NUMBER;
        nuPosFinal            NUMBER;

        --variable para programacion
        NUPERIODO             PERIFACT.PEFACODI%TYPE;
        nuTipoprod            SERVICIO.SERVCODI%TYPE;
        blprogramado          BOOLEAN := FALSE;
        NUERRORPROG     GE_MESSAGE.MESSAGE_ID%TYPE := 143474;
    BEGIN

        UT_TRACE.TRACE('[prValidProgPeriodo] INICIO',4);
        PKERRORS.SETAPPLICATION ( 'FEPF' );
        SA_BOEXECUTABLE.GETEXECUTABLEDATABYNAME(
                                                inuExecuta,
                                                nuExecutable,
                                                sbdescripcion,
                                                nuModulo,
                                                sbversion,
                                                nuTipoejecutable,
                                                nuEjeOperTipo,
                                                nuEjecPadre,
                                                nuEjecPath
                                               );


        cuprogramacion := GE_BCPROCESS_SCHEDULE.FRFGETSCHEDULESBYAPLICATION(nuExecutable);

        LOOP

            FETCH cuprogramacion INTO   sbFechaejec,
                                        sbHoraejec,
                                        sbFrecuencia,
                                        nuJob,
                                        sbparametros,
                                        nuprogramacion;
            EXIT WHEN  cuprogramacion%NOTFOUND;

            nuPosiperiodo := INSTR(sbparametros,'PEFACODI=') + 9;
            nuPosFinal := INSTR(sbparametros,'|',nuPosiperiodo,1);
            NUPERIODO := TO_CHAR(SUBSTR(sbparametros,nuPosiperiodo,nuPosFinal-nuPosiperiodo));

            IF  NUPERIODO = inuperiodo THEN
                ERRORS.SETERROR (NUERRORPROG);
                RAISE EX.CONTROLLED_ERROR;
            END IF;

        END LOOP;

        UT_TRACE.TRACE('[prValidProgPeriodo] ',10);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
  END prValidProgPeriodo;

    FUNCTION prValidProgPeriodo
    (
      inuExecuta    IN  SA_EXECUTABLE.NAME%TYPE,
      inuperiodo    IN  PERIFACT.PEFACODI%TYPE,
      inuTipoprod   IN  SERVICIO.SERVCODI%TYPE
    ) RETURN BOOLEAN
    IS

        --variables para job
        nuJob                  GE_PROCESS_SCHEDULE.JOB%TYPE;
        sbparametros           GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;
        nuprogramacion         GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE;
        sbFechaejec            VARCHAR2(300);
        sbHoraejec             VARCHAR2(300);
        sbFrecuencia           VARCHAR2(300);
        --variables para ejecutables
        nuTipoejecutable       SA_EXECUTABLE.EXECUTABLE_TYPE_ID%TYPE;
        nuEjeOperTipo          SA_EXECUTABLE.EXEC_OPER_TYPE_ID%TYPE;
        nuEjecPath              VARCHAR2(200);
        cuprogramacion         PKCONSTANTE.TYREFCURSOR;
        nuExecutable           SA_EXECUTABLE.EXECUTABLE_ID%TYPE;
        sbdescripcion          SA_EXECUTABLE.DESCRIPTION%TYPE;
        nuEjecPadre            SA_EXECUTABLE.PARENT_EXECUTABLE_ID%TYPE;
        nuModulo               SA_EXECUTABLE.MODULE_ID%TYPE;
        sbversion              SA_EXECUTABLE.VERSION%TYPE;

        tblDetalleProg         DAGE_PROC_SCHE_DETAIL.TYTBGE_PROC_SCHE_DETAIL;

        nuPosiServ            NUMBER;
        nuPosiperiodo         NUMBER;
        nuPosFinal            NUMBER;

        --variable para programacion
        NUPERIODO             PERIFACT.PEFACODI%TYPE;
        nuTipoprod            SERVICIO.SERVCODI%TYPE;
        blprogramado          BOOLEAN := FALSE;

    BEGIN

        UT_TRACE.TRACE('[prValidProgPeriodo] INICIO',4);
        PKERRORS.SETAPPLICATION ( 'FGCA' );

        SA_BOEXECUTABLE.GETEXECUTABLEDATABYNAME(
                                                inuExecuta,
                                                nuExecutable,
                                                sbdescripcion,
                                                nuModulo,
                                                sbversion,
                                                nuTipoejecutable,
                                                nuEjeOperTipo,
                                                nuEjecPadre,
                                                nuEjecPath
                                               );


        cuprogramacion := GE_BCPROCESS_SCHEDULE.FRFGETSCHEDULESBYAPLICATION(nuExecutable);

        LOOP

            FETCH cuprogramacion INTO   sbFechaejec,
                                        sbHoraejec,
                                        sbFrecuencia,
                                        nuJob,
                                        sbparametros,
                                        nuprogramacion;
            EXIT WHEN  cuprogramacion%NOTFOUND;
            nuPosiperiodo := INSTR(sbparametros,'PEFACODI=') + 9;
            nuPosFinal := INSTR(sbparametros,'|',nuPosiperiodo,1);
            NUPERIODO := TO_CHAR(SUBSTR(sbparametros,nuPosiperiodo,nuPosFinal-nuPosiperiodo));
--DBMS_OUTPUT.PUT_LINE(nuPosiperiodo||' '||nuPosFinal||' '||NUPERIODO||' '||inuperiodo);
            IF  NUPERIODO = inuperiodo THEN
                GE_BCPROC_SCHE_DETAIL.GETSCHEDULEDETAILS(nuprogramacion,tblDetalleProg);
                FOR I IN  1..tblDetalleProg.COUNT LOOP
                    nuPosiServ := INSTR(tblDetalleProg(I).PARAMETER,'SERVCODI=') + 9;
                    nuPosFinal := INSTR(tblDetalleProg(I).PARAMETER,'|',1,2);
                    nuTipoprod := SUBSTR(tblDetalleProg(I).PARAMETER,nuPosiServ,nuPosFinal-nuPosiServ);
                    IF  nuTipoprod = inuTipoprod THEN
                        blprogramado := TRUE;
                    END IF;
                END LOOP;
            END IF;
        END LOOP;

        RETURN(blprogramado);

        UT_TRACE.TRACE('[prValidProgPeriodo] ',10);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
  END prValidProgPeriodo;

 PROCEDURE prObtValorespb(isbPEFAANO  OUT  ge_boInstanceControl.stysbValue,
                          isbPEFAMES  OUT  ge_boInstanceControl.stysbValue,
                          isbPEFACODI OUT  ge_boInstanceControl.stysbValue,
                          isbPEFAFEPA OUT  ge_boInstanceControl.stysbValue,
                          isbPEFAACTU OUT  ge_boInstanceControl.stysbValue,
                          isbPEFAORDE OUT  ge_boInstanceControl.stysbValue,
                          isbPEFAFEGE OUT  ge_boInstanceControl.stysbValue,
                          isbProceso OUT  ge_boInstanceControl.stysbValue ) is
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Proceso     : prObtValorespb
      Fecha       : 2020-13-03
      Ticket      : 65
      Descripcion : obtiene valores del  PB [LDCGCAM]

      Parametros Entrada

      Valor de salida
        isbPEFAANO    a¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿o
        isbPEFAMES    mes
        isbPEFACODI   grupo de ciclos
        isbPEFAFEPA   fecha final de movimientos
        isbPEFAACTU   programar
        isbPEFAORDE   orden para  FIDF
        isbPEFAFEGE   fecha de programacion
        isbProceso  proceso a ejecutar

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      19/11/2020   horbath     ca 461 se quitan los campos de los filtros que se quitaron en la forma
                              - se agrega nuevo campo proceso
      26/07/2021   LJLB        ca 696 se habilita campo de fecha fecha final de movimiento
    ***************************************************************************/
 BEGIN
    ut_trace.trace('INICIO prObtValorespb', 10);
    --Se obtienen datos del PB
    /*isbPEFAANO := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAANO');
    isbPEFAMES := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAMES');
    isbPEFACODI := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFACODI');
    isbPEFAFEPA := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAFEPA');
    isbPEFAACTU := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAACTU');*/
    --isbPEFAORDE := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFACICL');
    isbPEFAFEPA := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAFFMO');
    isbPEFAFEGE := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAFEGE');
    isbProceso := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAANO');

    ut_trace.trace('FIN prObtValorespb', 10);
 EXCEPTION
    when ex.CONTROLLED_ERROR then
      ut_trace.trace('FIN prObtValorespb ERROR', 10);
      RAISE ex.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      errors.seterror;
       ut_trace.trace('FIN prObtValorespb ERROR OTHERS', 10);
       RAISE ex.CONTROLLED_ERROR;
 END prObtValorespb;
 PROCEDURE prValidaInfor IS
 /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Proceso     : prValidaInfor
      Fecha       : 2020-13-03
      Ticket      : 65
      Descripcion : proceso que se encarga de validar informacion del PB [LDCGCAM]

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      19/11/2020   horbath     ca 461 se agrega nuevo campo sbProceso al proceso que obtienen los valores
                              se quita las validaciones de los campos que no se utilizan
      26/07/2021   LJLB        CA 696 se agrega fecha final de movimiento y se valida que no sea mayor a la fecha del sistema
                               ni menor a la fecha resultante de la resta de la fecha del sistema menos los dias del parametro LDC_DIASATRAPERM

    ***************************************************************************/
    sbdateformat VARCHAR2(100);--se almacena formato de fecha

    dtFechaProg DATE;
    --inicio ca 696
    nuDias NUMBER := nvl(dald_parameter.fnugetnumeric_value('LDC_DIASATRAPERM',null), 0);
    dtFechaFinal DATE;
    dtFechaFinalCal date;
    --fin ca 696

  BEGIN
      ut_trace.trace('INICIO prValidaInfor', 10);
      sbdateformat := ut_date.fsbdate_format;
      --se obtienen datos del PB
      prObtValorespb(sbPEFAANO,
                     sbPEFAMES ,
                     sbPEFACODI,
                     sbPEFAFEPA,
                     sbPEFAACTU,
                     sbPEFAORDE,
                     sbPEFAFEGE,
                     sbProceso);

      --se validan datos obligatorios
     /* if (sbPEFAANO is null) then
          Errors.SetError (cnuNULL_ATTRIBUTE, 'A¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿o');
          raise ex.CONTROLLED_ERROR;
      end if;

      if (sbPEFAMES is null) then
          Errors.SetError (cnuNULL_ATTRIBUTE, 'Mes');
          raise ex.CONTROLLED_ERROR;
      end if;

      if (sbPEFAFEPA is null) then
          Errors.SetError (cnuNULL_ATTRIBUTE, 'Fecha Final de Movimientos');
          raise ex.CONTROLLED_ERROR;
      end if;

*/
      IF fblaplicaentregaxcaso('0000696') THEN
        IF TO_NUMBER(sbProceso) IN (3,4) and sbPEFAFEPA is not null  THEN
         ut_trace.trace('dtFechaFinal '||dtFechaFinal, 10);
            dtFechaFinal := TO_DATE(sbPEFAFEPA,''||sbdateformat||'');
          ut_trace.trace('sbdateformat '||sbdateformat||' dtFechaFinal '||dtFechaFinal, 10);
            IF dtFechaFinal > SYSDATE THEN
               Errors.SetError (2741, 'Fecha Final de Movimientos no puede ser mayor a la fecha del sistema');
               raise ex.CONTROLLED_ERROR;
            END IF;
            dtFechaFinalCal := TRUNC(SYSDATE) - nuDias;
            ut_trace.trace('fecha '||dtFechaFinalCal, 10);
            IF dtFechaFinal  < dtFechaFinalCal THEN
               Errors.SetError (2741, 'Fecha Final de Movimientos no puede ser menor a la fecha '||dtFechaFinalCal);
               raise ex.CONTROLLED_ERROR;
            END IF;
            ut_trace.trace('termino validar fecha', 10);
        END IF;

        /*IF sbProceso = '3' AND sbPEFAORDE IS NULL THEN
             Errors.SetError (cnuNULL_ATTRIBUTE, 'Ordenamiento');
          raise ex.CONTROLLED_ERROR;
        END IF;*/
      END IF;

       if (sbPEFAFEGE is null) then
          Errors.SetError (cnuNULL_ATTRIBUTE, 'Fecha de programacion');
          raise ex.CONTROLLED_ERROR;
      end if;

      dtFechaProg := TO_DATE(sbPEFAFEGE,''||sbdateformat||'');
       ut_trace.trace('dtFechaProg '||dtFechaProg, 10);

     --se valoida que la fecha de programacion no sea menor a la del sistema
      IF dtFechaProg < sysdate - 4/24/60 THEN
         Errors.SetError (2741, 'Fecha de programacion no puede ser menor a la del sistema');
         raise ex.CONTROLLED_ERROR;
      END IF;

      --se valida que se haya seleccionado un proceso
     /* IF nvl(sbPEFAOBSE,'N') = 'N' AND NVL(sbPEFAACTU,'N') = 'N' THEN
          Errors.SetError (2741, 'Se debe seleccionar por lo menos una opcion del proceso a Realizar');
         raise ex.CONTROLLED_ERROR;
      END IF;

       --se valida que se haya seleccionado un proceso
      IF sbPEFAOBSE = 'Y' AND sbPEFAACTU = 'Y' THEN
          Errors.SetError (2741, 'Se debe seleccionar solo una opcion del proceso a Realizar');
         raise ex.CONTROLLED_ERROR;
      END IF;*/


       ut_trace.trace('FIN prValidaInfor', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      ut_trace.trace('FIN prValidaInfor ERROR', 10);
      RAISE ex.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      errors.seterror;
       ut_trace.trace('FIN prValidaInfor ERROR OTHERS', 10);
       RAISE ex.CONTROLLED_ERROR;
  END prValidaInfor;
 FUNCTION FRFGETPERIFGCC Return constants.tyrefcursor IS
  /**************************************************************************
      Autor       : Horbath
      Proceso     : FRFGETPERIFGCC
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : funcion que se encarga de llenar PB [LDCGCAM] cuando proceso es FGCC

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    rfresult constants.tyrefcursor;

    /* Atributos de la consulta de ordenes */
    sbattributesperiodo ge_boutilities.stystatement;
    sbfrom ge_boutilities.stystatement;
    sqlPeriodos     ge_boutilities.stystatement;

  BEGIN
     --se agregan atributos
      ge_boutilities.addattribute('    p.pefacodi', '"Periodo"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFADESC', '"Descripcion"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFACICL', '"Ciclo"', sbattributesperiodo);
      ge_boutilities.addattribute('  (SELECT cicldesc FROM ciclo c WHERE C.CICLCODI=  p.PEFACICL)', '"Descripcion_Ciclo"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFAFIMO', '"Fecha_Inicio_Movimiento"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFAFFMO', '"Fecha_final_Movimiento"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFAFEPA', '"Fecha_Pago"', sbattributesperiodo);
      ge_boutilities.addattribute('   p.PEFAFEGE', '"Fecha_Generacion"', sbattributesperiodo);

     sqlPeriodos := ' SELECT '||sbattributesperiodo|| chr(10) ||
                    '  FROM PERIFACT P '|| chr(10) ||
                    ' WHERE  trunc(P.pefaffmo)  = to_date('''||trunc(sysdate)||''','''||sbdateformat||''')'|| chr(10)||'
                        AND p.pefacicl not in ('||sbCiclo||')
						AND p.pefaactu = ''S''
                        AND EXISTS  ( SELECT 1
                                      FROM LDC_VALIDGENAUDPREVIAS pf
                                      WHERE pf.PROCESO =''AUDPOST''
                                        AND pf.COD_PEFACODI = P.pefacodi)
                        AND NOT EXISTS ( SELECT 1
                                         FROM PROCEJEC
                                         WHERE PREJCOPE =P.pefacodi
                                           and PREJPROG = ''FGCC'')
                        AND NOT EXISTS (SELECT 1 FROM LDC_PERIPROG WHERE PEPRPEFA = P.pefacodi AND PEPRFLAG = ''N'' and PROCESO = 2 )';
      ut_trace.trace('sqlPeriodos '||sqlPeriodos, 10);
       Open rfresult For sqlPeriodos ;

      return rfresult;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      errors.seterror;
       RAISE ex.CONTROLLED_ERROR;
 end FRFGETPERIFGCC;

 FUNCTION 	FRFGETPERIFIDF Return constants.tyrefcursor IS
  /**************************************************************************
      Autor       : Horbath
      Proceso     : FRFGETPERIFIDF
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : funcion que se encarga de llenar PB [LDCGCAM] cuando proceso es FIDF

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      26/07/2021   LJLB       CA 696 se valida si la fecha final de movimiento es no nula
    ***************************************************************************/
    rfresult constants.tyrefcursor;

    /* Atributos de la consulta de ordenes */
    sbattributesperiodo ge_boutilities.stystatement;
    sbfrom ge_boutilities.stystatement;
    sqlPeriodos     ge_boutilities.stystatement;

  BEGIN
     --se agregan atributos
      ge_boutilities.addattribute('    p.pefacodi', '"Periodo"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFADESC', '"Descripcion"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFACICL', '"Ciclo"', sbattributesperiodo);
      ge_boutilities.addattribute('  (SELECT cicldesc FROM ciclo c WHERE C.CICLCODI=  p.PEFACICL)', '"Descripcion_Ciclo"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFAFIMO', '"Fecha_Inicio_Movimiento"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFAFFMO', '"Fecha_final_Movimiento"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFAFEPA', '"Fecha_Pago"', sbattributesperiodo);
      ge_boutilities.addattribute('   p.PEFAFEGE', '"Fecha_Generacion"', sbattributesperiodo);

     sqlPeriodos := ' SELECT '||sbattributesperiodo|| chr(10) ||
                    '  FROM PERIFACT P '|| chr(10);

      IF sbPEFAFEPA IS NOT NULL AND FBLAPLICAENTREGAXCASO('0000696') THEN
         sqlPeriodos := sqlPeriodos||  ' WHERE  trunc(P.pefaffmo)  = TRUNC(to_date('''||sbPEFAFEPA||''','''||sbdateformat||'''))'|| chr(10);
       ELSE
          sqlPeriodos := sqlPeriodos|| ' WHERE  trunc(P.pefaffmo)  = to_date('''||trunc(sysdate)||''','''||sbdateformat||''')'|| chr(10);
       END IF;

       sqlPeriodos :=  sqlPeriodos|| '    AND p.pefaactu = ''S''
                      AND p.pefacicl not in ('||sbCiclo||')
                                                AND NOT  EXISTS  ( SELECT 1
                                                                  FROM ESTAPROG
                                                                  WHERE ESPRPEFA = P.pefacodi
                                                                   AND ESPRPROG LIKE ''FIDF%''
                                               and ESPRPORC <> 100
                                                     )
                                  and LDC_PKGESTIONTARITRAN.FNUGETVALIPERIFIDF(P.pefacodi) = 1
                      AND EXISTS ( SELECT 1
                                         FROM PROCEJEC
                                         WHERE PREJCOPE =P.pefacodi
                                           and PREJPROG = ''FGDP''
                                           AND PREJESPR = ''T'')
                        AND NOT EXISTS (SELECT 1 FROM LDC_PERIPROG WHERE PEPRPEFA = P.pefacodi AND PEPRFLAG = ''N'' and PROCESO = 3 )';
      ut_trace.trace('sqlPeriodos '||sqlPeriodos, 10);
       Open rfresult For sqlPeriodos ;

      return rfresult;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      errors.seterror;
       RAISE ex.CONTROLLED_ERROR;
 end FRFGETPERIFIDF;

  FUNCTION 	FRFGETPERIFCPE Return constants.tyrefcursor IS
  /**************************************************************************
      Autor       : Horbath
      Proceso     : FRFGETPERIFCPE
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : funcion que se encarga de llenar PB [LDCGCAM] cuando proceso es fcpe

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
       26/07/2021   LJLB       CA 696 se valida si la fecha final de movimiento es no nula
    ***************************************************************************/
    rfresult constants.tyrefcursor;

    /* Atributos de la consulta de ordenes */
    sbattributesperiodo ge_boutilities.stystatement;
    sbfrom ge_boutilities.stystatement;
    sqlPeriodos     ge_boutilities.stystatement;

  BEGIN
     --se agregan atributos
      ge_boutilities.addattribute('    p.pefacodi', '"Periodo"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFADESC', '"Descripcion"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFACICL', '"Ciclo"', sbattributesperiodo);
      ge_boutilities.addattribute('  (SELECT cicldesc FROM ciclo c WHERE C.CICLCODI=  p.PEFACICL)', '"Descripcion_Ciclo"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFAFIMO', '"Fecha_Inicio_Movimiento"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFAFFMO', '"Fecha_final_Movimiento"', sbattributesperiodo);
      ge_boutilities.addattribute('    p.PEFAFEPA', '"Fecha_Pago"', sbattributesperiodo);
      ge_boutilities.addattribute('   p.PEFAFEGE', '"Fecha_Generacion"', sbattributesperiodo);

     sqlPeriodos := ' SELECT '||sbattributesperiodo|| chr(10) ||
                    '  FROM PERIFACT P '|| chr(10) ;

     --INICIO CA 696
     IF sbPEFAFEPA IS NOT NULL AND FBLAPLICAENTREGAXCASO('0000696') THEN
       sqlPeriodos := sqlPeriodos||  ' WHERE  trunc(P.pefaffmo)  = TRUNC(to_date('''||sbPEFAFEPA||''','''||sbdateformat||'''))'|| chr(10);
     ELSE
        sqlPeriodos := sqlPeriodos|| ' WHERE  trunc(P.pefaffmo)  = to_date('''||trunc(sysdate)||''','''||sbdateformat||''')'|| chr(10);
     END IF;
     --FIN CA 696

       sqlPeriodos :=  sqlPeriodos|| ' AND p.pefaactu = ''S''
						AND p.pefacicl not in ('||sbCiclo||')
                        AND NOT EXISTS ( SELECT 1
                                         FROM PROCEJEC
                                         WHERE PREJCOPE =P.pefacodi
                                           and PREJPROG = ''FCPE''
                                           )
					   and LDC_PKGESTIONTARITRAN.FNUGETVALIPERIFIDF(P.pefacodi) = 1
					   AND EXISTS ( SELECT 1
									 FROM PROCEJEC
									 WHERE PREJCOPE =P.pefacodi
									   and PREJPROG = ''FGDP''
									   AND PREJESPR = ''T'')
                        AND NOT EXISTS (SELECT 1 FROM LDC_PERIPROG WHERE PEPRPEFA = P.pefacodi AND PEPRFLAG = ''N'' and PROCESO = 4 )';
      ut_trace.trace('sqlPeriodos '||sqlPeriodos, 10);
       Open rfresult For sqlPeriodos ;

      return rfresult;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      errors.seterror;
       RAISE ex.CONTROLLED_ERROR;
 end FRFGETPERIFCPE;

 FUNCTION FRFGETGCAM Return constants.tyrefcursor IS
 /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Proceso     : prValidaInfor
      Fecha       : 2020-13-03
      Ticket      : 65
      Descripcion : funcion que se encarga de llenar PB [LDCGCAM]

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      19/11/2020   horbath      CA 461 se modifica proceso para quitar los filtros que ya
                               no se utilizan y llamar al proceso correspondiente
                               se quita validaciones que ya no se van a utilizar
    ***************************************************************************/
    rfresult constants.tyrefcursor;

    nuano  NUMBER;
    nuMes  NUMBER;
    dtfechaFin DATE;

    /* Atributos de la consulta de ordenes */
    sbattributesperiodo ge_boutilities.stystatement;
    sbfrom ge_boutilities.stystatement;
    sbfromunion ge_boutilities.stystatement;
    sbwhere ge_boutilities.stystatement;
    sbwhereunion ge_boutilities.stystatement;
    sqlPeriodos     ge_boutilities.stystatement;

 begin
  ut_trace.trace('INICIO FRFGETGCAM', 10);
   --se valdia informacion del PB
   prValidaInfor;
   sbdateformat := ut_date.fsbdate_format;

   /*nuano := TO_NUMBER(sbPEFAANO);
   nuMes := TO_NUMBER(sbPEFAMES);
   dtfechaFin := trunc(TO_DATE(sbPEFAFEPA,''||sbdateformat||''));*/ --CA 461 Se quita ya que no se utilizan los filtros
   dtFechaProg := null;
   ut_trace.trace('nuano '||nuano, 10);
   ut_trace.trace('nuMes '||nuMes, 10);
   ut_trace.trace('dtfechaFin '||dtfechaFin, 10);
   ut_trace.trace('sbPEFAACTU '||sbPEFAACTU, 10);
   ut_trace.trace('sbProceso '||sbProceso, 10);
   --si la opcion es programar
   --IF sbPEFAACTU = 'Y' THEN

   IF sbProceso = 1 THEN
    --se agregan atributos
    ge_boutilities.addattribute('    p.pefacodi', '"Periodo"', sbattributesperiodo);
    ge_boutilities.addattribute('    p.PEFADESC', '"Descripcion"', sbattributesperiodo);
    ge_boutilities.addattribute('    p.PEFACICL', '"Ciclo"', sbattributesperiodo);
    ge_boutilities.addattribute('  (SELECT cicldesc FROM ciclo c WHERE C.CICLCODI=  p.PEFACICL)', '"Descripcion_Ciclo"', sbattributesperiodo);
    ge_boutilities.addattribute('    p.PEFAFIMO', '"Fecha_Inicio_Movimiento"', sbattributesperiodo);
    ge_boutilities.addattribute('    p.PEFAFFMO', '"Fecha_final_Movimiento"', sbattributesperiodo);
    ge_boutilities.addattribute('    p.PEFAFEPA', '"Fecha_Pago"', sbattributesperiodo);
    ge_boutilities.addattribute('   p.PEFAFEGE', '"Fecha_Generacion"', sbattributesperiodo);

     sbwhere := '  WHERE PC.CCPCPRRE = 729
                           AND PC.CCPCINPR = 5
                           AND PC.CCPCCICL = p.pefacicl
                           AND trunc(P.pefaffmo)  = to_date('''||trunc(sysdate)||''','''||sbdateformat||''')'|| chr(10)||'
                           AND p.pefaactu = ''S''
						   AND p.pefacicl not in ('||sbCiclo||')
                           AND EXISTS  (SELECT 1
                                         FROM LDC_VALIDGENAUDPREVIAS pf
                                         WHERE pf.PROCESO =''AUDPREV''
                                            AND pf.COD_PEFACODI = P.pefacodi)
                            AND NOT EXISTS ( SELECT 1
                                             FROM PROCEJEC
                                             WHERE PREJCOPE =P.pefacodi
                                               and PREJPROG = ''FGCA'')
                            AND NOT EXISTS (SELECT 1 FROM LDC_PERIPROG WHERE PEPRPEFA = P.pefacodi AND PEPRFLAG = ''N'' and PROCESO = 1 )';
         sbwhereunion := ' WHERE p.pefaactu = ''S''
                             AND trunc(p.pefaffmo) = to_date('''||trunc(sysdate)||''','''||sbdateformat||''')'|| chr(10)||'
                             AND p.pefacicl not in ('||sbCiclo||')
							 AND NOT EXISTS  ( SELECT 1
                                               FROM COCOPRCI PC
                                               WHERE PC.CCPCPRRE = 729
                                                     AND PC.CCPCINPR = 5
                                                     AND PC.CCPCCICL = p.pefacicl)
                            AND NOT EXISTS ( SELECT 1
                                             FROM PROCEJEC
                                             WHERE PREJCOPE =P.pefacodi
                                               and PREJPROG = ''FGCA'')
                            AND NOT EXISTS (SELECT 1 FROM LDC_PERIPROG WHERE PEPRPEFA = P.pefacodi AND PEPRFLAG = ''N'' and PROCESO = 1 )';

       --si no se escogio grupo de ciclo
       IF sbPEFACODI IS NULL THEN
          sbfrom := ' COCOPRCI PC, PERIFACT P';
          sbfromunion := ' PERIFACT P';

       ELSE
         sbfrom := 'COCOPRCI PC, PERIFACT P, LDC_CICLGRCI c';
         sbfromunion := '  PERIFACT P, LDC_CICLGRCI c';
         sbwhere := sbwhere||'  AND c.CIGCGRCI = '||to_number(sbPEFACODI)|| chr(10)||'
                           AND c.CIGCCICL = p.pefacicl';

         sbwhereunion :=sbwhereunion|| '   AND c.CIGCGRCI = '||to_number(sbPEFACODI)|| chr(10)||'
                             AND c.CIGCCICL = p.pefacicl';
       END IF;
       ut_trace.trace('sbattributesperiodo '||sbattributesperiodo, 10);
       ut_trace.trace('sbfrom '||sbfrom, 10);
       ut_trace.trace('sbfromunion '||sbfromunion, 10);
       ut_trace.trace('sbwhereunion '||sbwhereunion, 10);

       sqlPeriodos := ' SELECT '||sbattributesperiodo|| chr(10) ||
                      '  FROM '||sbfrom|| chr(10) ||
                       sbwhere|| chr(10) ||
                       ' union all '|| chr(10) ||
                      ' SELECT '|| sbattributesperiodo|| chr(10) ||
                      '  FROM '|| sbfromunion|| chr(10) ||sbwhereunion;
      ut_trace.trace('sqlPeriodos '||sqlPeriodos, 10);
       Open rfresult For sqlPeriodos ;
    ELSIF sbProceso = 2 THEN
      rfresult := FRFGETPERIFGCC;
    ELSIF sbProceso = 3 THEN
      rfresult := FRFGETPERIFIDF;
    ELSE
      rfresult :=  FRFGETPERIFCPE;
    END IF;


 --   END IF;

    /*IF sbPEFAOBSE = 'Y' THEN
        Open rfresult For
        SELECT PEPRPROG programacion,
               PEPRPEFA periodo,
               PEPRCICL ciclo,
               PEPRUSUA usuario,
               PEPRTERM terminal,
               PEPRFEIN fecha_inicio,
               PEPRFEFI fecha_final,
               DECODE(PEPRFLAG,'S', 'SI', 'NO') termino
        FROM LDC_PERIPROG PR, PERIFACT P
        WHERE PR.PEPRPEFA = P.PEFACODI
         AND p.pefaano = nuano
         AND p.pefames = nuMes
         AND p.pefaactu = 'S'
         AND trunc(p.pefaffmo) <= dtfechaFin
         AND PR.PEPRFLAG = 'N'
         AND exists (SELECT 1
                     FROM GE_PROCESS_SCHEDULE PRG
                     WHERE  PRG.PROCESS_SCHEDULE_ID = PR.PEPRPROG
                      AND PRG.STATUS = 'P'
                      AND PRG.START_DATE_ >= SYSDATE);

    END IF;*/

   ut_trace.trace('FIN FRFGETGCAM', 10);
   return rfresult;

 EXCEPTION
    when ex.CONTROLLED_ERROR then
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      errors.seterror;
       RAISE ex.CONTROLLED_ERROR;
 end FRFGETGCAM;

  FUNCTION fnuCrReportHeader
    return number
    IS
        -- Variables
        rcRecord Reportes%rowtype;
    BEGIN
    --{
        -- Fill record
        rcRecord.REPOAPLI := 'PR_FACT_MA';
        rcRecord.REPOFECH := sysdate;
        rcRecord.REPOUSER := ut_session.getTerminal;
        rcRecord.REPODESC := 'INCONSISTENCIAS PROCESOS DE FACTURAICON MASIVOS' ;
        rcRecord.REPOSTEJ := null;
        rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');

        -- Insert record
        pktblReportes.insRecord(rcRecord);
        COMMIT;
        return rcRecord.Reponume;
  EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
           ROLLBACK;
           RETURN -1;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ROLLBACK;
            RETURN -1;
  END;

  PROCEDURE crReportDetail(
        inuIdReporte    in repoinco.reinrepo%type,
        inuProduct      in repoinco.reinval1%type,
        isbError        in repoinco.reinobse%type,
        isbTipo         in repoinco.reindes1%type
    )
    IS

       PRAGMA AUTONOMOUS_TRANSACTION;
        -- Variables
        rcRepoinco repoinco%rowtype;
    BEGIN
    --{
        rcRepoinco.reinrepo := inuIdReporte;
        rcRepoinco.reinval1 := inuProduct;
        rcRepoinco.reindes1 := isbTipo;
        rcRepoinco.reinobse := isbError;
        rcRepoinco.reincodi := nuConsecutivo;

        -- Insert record
        pktblRepoinco.insrecord(rcRepoinco);
        COMMIT;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
           ROLLBACK;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ROLLBACK;
    --}
    END;

 PROCEDURE PRGCAM(isbperiodo   In Varchar2,
                  inucurrent   In Number,
                  inutotal     In Number,
                  onuerrorcode Out ge_error_log.message_id%Type,
                  osberrormess Out ge_error_log.description%Type) IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Proceso     : PRGCAM
      Fecha       : 2020-13-03
      Ticket      : 65
      Descripcion : Proceso que genera programaciones del  PB [LDCGCAM]

      Parametros Entrada
        isbperiodo  periodo de facturacion
        inucurrent  valor actual
        inutotal    total
      Valor de salida
        onuerrorcode  codigo de error
        osberrormess  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      19/11/2020  horbath      ca 461 se agrega nuevo campo sbProcesop al proceso prObtValorespb
                              - se modifica proceso para que valide por el proceso y llame al proceso correspondiente
    ***************************************************************************/
    sbPEFAANOP ge_boInstanceControl.stysbValue;
    sbPEFAMESP ge_boInstanceControl.stysbValue;
    sbPEFACODIP ge_boInstanceControl.stysbValue;
     sbPEFAFEPAP ge_boInstanceControl.stysbValue;
    sbPEFAACTUP ge_boInstanceControl.stysbValue;
    sbPEFAOBSEP ge_boInstanceControl.stysbValue;
    sbPEFAORDEP ge_boInstanceControl.stysbValue;
    sbProcesop  ge_boInstanceControl.stysbValue;

    sbdateformat VARCHAR2(100);--se almacena formato de fecha
    --constantes de estados
    csbBloqueado        CONSTANT VARCHAR2(20) := 'BLOQUEADO' ;
    csbEjecucion        CONSTANT VARCHAR2(20) := 'EJECUCION' ;
    csbInconsistente    CONSTANT VARCHAR2(20) := 'INCONSISTENTE' ;
    csbCaido            CONSTANT VARCHAR2(20) := 'CAIDO' ;
    csbPendiente        CONSTANT VARCHAR2(20) := 'PENDIENTE' ;
    csbAutorizado       CONSTANT VARCHAR2(20) := 'AUTORIZADO' ;
    --tabla de servicios pendientes
    tblServpend         PKBOPROCCTRLBYSERVICEMGR.TYTBSERVPENDLIQU;
    SBTIPOSERV          VARCHAR2(2);
    SBDESCESTADO        VARCHAR2(100);
    SBSERVDESC          VARCHAR2(100);
    nuPeriodo           NUMBER;
    NUINDEX             NUMBER :=1 ;
    NUCICLO             NUMBER;
    NUMINUTOS           NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_MINENTHILOS', NULL);

    --variables de programcion
    onuScheduleProcessAux Ge_process_schedule.process_schedule_id%type;
    inuExecutable     Sa_executable.executable_id%type := 5153;
    isbParameters     Ge_process_schedule.parameters_%type;

    isbWhat           Ge_process_schedule.what%type;
    isbFrecuency      Ge_process_schedule.Frequency%type := 'UV';
    idtNextDate       Ge_process_schedule.Start_Date_%type ;

   regPeriodo  cugetPeriodo%ROWTYPE;

    sbDatos VARCHAR2(1);

    --se consulta estado de la programacion
    CURSOR cuprogramacion IS
    SELECT 'X'
    from GE_PROCESS_SCHEDULE
    where PROCESS_SCHEDULE_ID  = nuPeriodo
     AND STATUS = 'P';

  BEGIN
      ut_trace.trace('INICIO PRGCAM', 10);
     sbdateformat := ut_date.fsbdate_format;
     onuerrorcode := 0;
     osberrormess  := null;

    --se obtienen datos del PB
     prObtValorespb(sbPEFAANOP,
                     sbPEFAMESP ,
                     sbPEFACODIP,
                     sbPEFAFEPAP,
                     sbPEFAACTUP,
                     sbPEFAORDEP,--sbPEFAOBSEP,
                     sbPEFAFEGEP,
                     sbProcesop);

     ut_trace.trace('sbPEFAANOP ['||sbPEFAANOP||']'||' sbPEFAANO ['||sbPEFAANO||']', 10);
     ut_trace.trace('sbPEFAMESP ['||sbPEFAMESP||']'||' sbPEFAMES ['||sbPEFAMES||']', 10);
     ut_trace.trace('sbPEFACODIP ['||sbPEFACODIP||']'||' sbPEFACODI ['||sbPEFACODI||']', 10);
     ut_trace.trace('sbPEFAFEPAP ['||sbPEFAFEPAP||']'||' sbPEFAFEPA ['||sbPEFAFEPA||']', 10);
     ut_trace.trace('sbPEFAACTUP ['||sbPEFAACTUP||']'||' sbPEFAACTU ['||sbPEFAACTU||']', 10);
     ut_trace.trace('sbPEFAOBSEP ['||sbPEFAOBSEP||']'||' sbPEFAOBSE ['||sbPEFAOBSE||']', 10);
     ut_trace.trace('sbPEFAFEGEP ['||sbPEFAFEGEP||']'||' sbPEFAFEGE ['||sbPEFAFEGE||']', 10);
   --inicio ca 461
    /*  if (sbPEFAFEPAp is null) then
          Errors.SetError (cnuNULL_ATTRIBUTE, 'Fecha Final de Movimientos');
          raise ex.CONTROLLED_ERROR;
      end if;*/
   --fin ca 461
       if (sbPEFAFEGEp is null) then
          Errors.SetError (cnuNULL_ATTRIBUTE, 'Fecha de programacion');
          raise ex.CONTROLLED_ERROR;
      end if;

    --se valida que no hayna cambiados los datos
    /*IF to_number(sbPEFAANOP) <> to_number(sbPEFAANO)   OR
       to_number(sbPEFAMESP) <> to_number(sbPEFAMES)   OR
       to_number(sbPEFACODIP) <> to_number(sbPEFACODI) OR
       to_date(sbPEFAFEPAP,''||sbdateformat||'') <> to_date(sbPEFAFEPA,''||sbdateformat||'') OR
       sbPEFAACTUP <> sbPEFAACTU OR
       sbPEFAOBSEP <> sbPEFAOBSE  THEN
       Errors.SetError (2741, 'Se cambiaron los datos de la consulta, por favor volver a generar la busqueda');
         raise ex.CONTROLLED_ERROR;
    END IF;*/

    --INICIO CA 461
    IF NVL(sbProcesop,'-1') <> NVL(sbProceso ,'-1') THEN
       Errors.SetError (2741, 'Se cambiaron los datos de la consulta, por favor volver a generar la busqueda');
         raise ex.CONTROLLED_ERROR;
    END IF;

    --FIN CA 461

    --INICIO CA 696
    IF FBLAPLICAENTREGAXCASO('0000696') THEN
       IF sbProceso IN ('3', '4') THEN
         IF sbPEFAFEPAP <> sbPEFAFEPA /*or (sbPEFAORDEP <> sbPEFAORDE and sbProceso = '3')*/ THEN
             Errors.SetError (2741, 'Se cambiaron los datos de la consulta, por favor volver a generar la busqueda');
               raise ex.CONTROLLED_ERROR;
          END IF;
       END IF;
    END IF;
    --FIN CA 696

    nuPeriodo :=  to_number(isbperiodo);
    SBTIPOSERV :=  '-' ;
    --si es programacion
   -- IF sbPEFAACTUP = 'Y' THEN ca 461 se quita ya que no se contempla en el pb
    --se realiza proceso de cadena de conexion
    IF sbCadeScrip IS NULL THEN
      --se obtiene cadena de conexion
      GE_BODATABASECONNECTION.GETCONNECTIONSTRING(sbUsuario, sbpassword, sbInstance);
      sbCadenaCone  := sbUsuario || '/' || sbpassword || '@' || sbInstance;
      sbCadeScrip   := FA_UIProcesosFact.FSBENCRIPTACADENA(sbCadenaCone);
     END IF;
     --INICIO CA 461
     IF inucurrent = 1 THEN
        nuIdReporte := fnuCrReportHeader;
     END IF;

     IF sbProcesop = 1 THEN
         --se obtienen datos del periodo
         IF cugetPeriodo%ISOPEN THEN
             CLOSE cugetPeriodo;
         END IF;

         OPEN cugetPeriodo(nuPeriodo);
         FETCH cugetPeriodo INTO regPeriodo;
         CLOSE cugetPeriodo;

         ut_trace.trace(' CICLO ['||regPeriodo.PEFACICL||'] A¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿`O ['||regPeriodo.PEFAANO||' MES ['||regPeriodo.PEFAMES||'] FECHA ['||regPeriodo.FECHA||']', 10);
         --Obtine el siguiente valor para el id de Ge_process_schedule
         select max(process_schedule_id)+1 into onuScheduleProcessAux
         from Ge_process_schedule;

         ut_trace.trace('onuScheduleProcessAux ['||onuScheduleProcessAux||']', 10);

         IF dtFechaProg IS NULL THEN
           dtFechaProg := to_date(sbPEFAFEGEP,''||sbdateformat||'') + (NUMINUTOS * (1/24/60));
         ELSE
           dtFechaProg := dtFechaProg + (NUMINUTOS * (1/24/60));
         END IF;
         idtNextDate := dtFechaProg;
         --Parametros
         isbParameters := 'NULL=|PEFACODI='||nuPeriodo||'|PEFADESC='||regPeriodo.PEFADESC||'|PEFACICL='||regPeriodo.pefacicl||'|PEFAANO='||regPeriodo.PEFAANO||'|PEFAMES='||regPeriodo.PEFAMES||'|PEFAFEGE='||regPeriodo.FECHA||'|NULL=|SERVTISE=-|CON='||sbCadeScrip||'|';
         ut_trace.trace('isbParameters ['||isbParameters||']', 10);
         --Bloque an¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿nimo con el que se fija la frecuencia de ejecuci¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿n del job
         isbWhat := 'BEGIN
                      SetSystemEnviroment;
                      Errors.Initialize;
                      FGCA( '||onuScheduleProcessAux||' );
                      if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                        GE_BOSchedule.InactiveSchedule( '||onuScheduleProcessAux||' );
                      end if;
                    EXCEPTION
                      when OTHERS then
                        Errors.SetError;
                        if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                          GE_BOSchedule.DropSchedule( '||onuScheduleProcessAux||' );
                        end if;
                    END;';
            ut_trace.trace('isbWhat ['||isbWhat||']', 10);
           GE_BOSchedule.PrepareSchedule(inuExecutable,isbParameters,isbWhat,onuScheduleProcessAux);

           PKBOPROCCTRLBYSERVICEMGR.FILLSERVPENDLIQSERVTYPE
            (
                regPeriodo.pefacicl,
                NUPERIODO,
                SBTIPOSERV,
                tblServpend
            );

            --si hay datos pendientes
            IF tblServpend.COUNT > 0 THEN
                FOR I IN tblServpend.FIRST..tblServpend.LAST LOOP
                    IF NOT prValidProgPeriodo(PKBILLCONST.PROG_FGCA,  NUPERIODO, tblServpend(I).SERVCODI) THEN
                      IF tblServpend(I).SERVESTA = 'B' THEN
                        SBDESCESTADO := csbBloqueado;
                      END IF;

                      IF tblServpend(I).SERVESTA = 'E' THEN
                        SBDESCESTADO := csbEjecucion;
                      END IF;

                      IF tblServpend(I).SERVESTA = 'I' THEN
                        SBDESCESTADO := csbInconsistente;
                      END IF;

                      IF tblServpend(I).SERVESTA = 'C' THEN
                        SBDESCESTADO := csbCaido;
                      END IF;

                        IF tblServpend(I).SERVESTA = 'P' THEN
                        SBDESCESTADO := csbPendiente;
                      END IF;

                      IF tblServpend(I).SERVESTA = 'A' THEN
                        SBDESCESTADO := csbAutorizado;
                      END IF;

                      SBSERVDESC := PKTBLSERVICIO.FSBGETDESCRIPTION(tblServpend(I).SERVCODI);
                      INSERT INTO GE_PROC_SCHE_DETAIL (PROC_SCHE_DETAIL_ID,
                                                       PROCESS_SCHEDULE_ID,
                                                       SEQUENCE,
                                                       PARAMETER
                                                       )
                                                       VALUES(
                                                       SEQ_GE_PROC_SCHE_DETAIL.NEXTVAL,
                                                       onuScheduleProcessAux,
                                                       NUINDEX,
                                                       '|SERVCODI='||tblServpend(I).SERVCODI||'|SERVDESC='||SBSERVDESC||'|SERVESTA='||SBDESCESTADO||'|'
                                                       );
                      NUINDEX := NUINDEX + 1;
                    END IF;
                END LOOP;
            END IF;
            --se crea programacion
            GE_BOSchedule.Scheduleprocess(onuScheduleProcessAux,isbFrecuency,idtNextDate);
            --
            INSERT INTO LDC_PERIPROG
              (
                PEPRPEFA,    PEPRCICL,    PEPRPROG,    PEPRUSUA,    PEPRTERM,    PEPRFEIN, PROCESO
              )
              VALUES
              (
                 nuPeriodo,    regPeriodo.pefacicl,  onuScheduleProcessAux,    user,    userenv('TERMINAL'),   idtNextDate, 1
               );
      --- END IF;
     ELSIF sbProcesop = 2 THEN
       --valida informacion del periodo
       PRVALIPROFGCC(nuPeriodo, onuerrorcode, osberrormess);
       IF onuerrorcode =  0 THEN
          PRPROGFGCC(nuPeriodo, onuerrorcode, osberrormess);

          IF onuerrorcode <> 0 THEN
             nuConsecutivo := nuConsecutivo +1;
              crReportDetail(nuIdReporte,nuPeriodo,'PROCESO FGCC, ERROR: '||osberrormess, 'S');
          END IF;
       ELSE
          nuConsecutivo := nuConsecutivo +1;
          crReportDetail(nuIdReporte,nuPeriodo,'PROCESO FGCC, ERROR: '||osberrormess, 'S');
       END IF;
     ELSIF sbProcesop = 3 THEN
       PRPROGFIDF(nuPeriodo, onuerrorcode, osberrormess);
       IF onuerrorcode <> 0 THEN
          nuConsecutivo := nuConsecutivo +1;
          crReportDetail(nuIdReporte,nuPeriodo,'PROCESO FIDF, ERROR: '||osberrormess, 'S');
       END IF;
     ELSE
        --valida informacion del periodo
        PRVALIPROFCPE(nuPeriodo, onuerrorcode, osberrormess);
        IF  onuerrorcode =  0 THEN
          PRPROGFCPE(nuPeriodo, onuerrorcode, osberrormess);
          IF onuerrorcode <> 0 THEN
              nuConsecutivo := nuConsecutivo +1;
              crReportDetail(nuIdReporte,nuPeriodo,'PROCESO FCPE, ERROR: '||osberrormess, 'S');
          END IF;
        ELSE
            nuConsecutivo := nuConsecutivo +1;
            crReportDetail(nuIdReporte,nuPeriodo,'PROCESO FCPE, ERROR: '||osberrormess, 'S');
        END IF;
     END IF;


    --si es desprogramacion
    /*IF sbPEFAOBSEP = 'Y' THEN
       OPEN cuprogramacion;
       FETCH cuprogramacion INTO  sbDatos;
       CLOSE cuprogramacion;

       IF sbDatos IS NOT NULL THEN
           BEGIN
              GE_BOSchedule.InactiveSchedule( nuPeriodo );
           EXCEPTION
             WHEN OTHERS THEN
                GE_BOSchedule.DropSchedule( nuPeriodo );
           END;
           UPDATE LDC_PERIPROG SET PEPRFLAG = 'S', PEPRFEFI = SYSDATE WHERE PEPRPROG = nuPeriodo;
       END IF;

    END IF;*/--CA 461 se quita proceso ya que no es necesario

    ut_trace.trace('FIN PRGCAM', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
       errors.getError(onuerrorcode, osberrormess);
       nuConsecutivo := nuConsecutivo +1;
      crReportDetail(nuIdReporte,nuPeriodo,'PROCESO '||sbProcesop||', ERROR: '||osberrormess, 'S');
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      errors.seterror;
      errors.getError(onuerrorcode, osberrormess);
       nuConsecutivo := nuConsecutivo +1;
       crReportDetail(nuIdReporte,nuPeriodo,'PROCESO '||sbProcesop||', ERROR: '||osberrormess, 'S');
       RAISE ex.CONTROLLED_ERROR;
 end PRGCAM;

  PROCEDURE PRJOBGENCARGAUTO IS
     /**************************************************************************
      Autor       :  Horbath
      Proceso     : PRJOBGENCARGAUTO
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : Job que genera los cargos automaticamente

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
     --variabe para estaproc
    nuparano     NUMBER;
    nuparmes     NUMBER;
    nutsess      NUMBER;
    sbparuser    VARCHAR2(400);
    SBERROR      VARCHAR2(4000);
    nuerror      NUMBER;

    sbdateformat VARCHAR2(100);--se almacena formato de fecha
    --constantes de estados
    csbBloqueado        CONSTANT VARCHAR2(20) := 'BLOQUEADO' ;
    csbEjecucion        CONSTANT VARCHAR2(20) := 'EJECUCION' ;
    csbInconsistente    CONSTANT VARCHAR2(20) := 'INCONSISTENTE' ;
    csbCaido            CONSTANT VARCHAR2(20) := 'CAIDO' ;
    csbPendiente        CONSTANT VARCHAR2(20) := 'PENDIENTE' ;
    csbAutorizado       CONSTANT VARCHAR2(20) := 'AUTORIZADO' ;
    --tabla de servicios pendientes
    tblServpend         PKBOPROCCTRLBYSERVICEMGR.TYTBSERVPENDLIQU;
    SBTIPOSERV          VARCHAR2(2);
    SBDESCESTADO        VARCHAR2(100);
    SBSERVDESC          VARCHAR2(100);
    nuPeriodo           NUMBER;
    NUINDEX             NUMBER :=1 ;
    NUCICLO             NUMBER;


    --variables de programcion
    onuScheduleProcessAux Ge_process_schedule.process_schedule_id%type;
    inuExecutable     Sa_executable.executable_id%type := 5153;
    isbParameters     Ge_process_schedule.parameters_%type;

    isbWhat           Ge_process_schedule.what%type;
    isbFrecuency      Ge_process_schedule.Frequency%type := 'UV';
    idtNextDate       Ge_process_schedule.Start_Date_%type ;

	--AND p.pefacicl not in ('||sbCiclo||')

    --se retorna periodo
    CURSOR cugetPeriodo IS
    SELECT pefacodi periodo, PEFADESC, PEFACICL, PEFAANO, PEFAMES, UT_DATE.FSBSTR_DATE(UT_DATE.FDTSYSDATE()) fecha, pefaffmo
    FROM perifact P
    WHERE pefaactu = 'S'
     AND trunc(pefaffmo) = trunc(sysdate)
     AND pefacicl NOT IN ( select To_Number(column_value)
						from table(open.ldc_boutilities.splitstrings(sbCiclo, ',')) )
	 AND (NOT EXISTS  ( SELECT 1
                       FROM COCOPRCI PC
                       WHERE PC.CCPCPRRE = 729
                             AND PC.CCPCINPR = 5
                             AND PC.CCPCCICL = p.pefacicl)
      OR  EXISTS  ( SELECT 1
                    FROM LDC_VALIDGENAUDPREVIAS pf, COCOPRCI PC
                    WHERE pf.PROCESO ='AUDPREV'
                      AND pf.COD_PEFACODI = P.pefacodi
                      AND PC.CCPCPRRE = 729
                      AND PC.CCPCINPR = 5
                      AND PC.CCPCCICL = p.pefacicl))
      AND NOT EXISTS ( SELECT 1
                       FROM PROCEJEC
                       WHERE PREJCOPE =P.pefacodi
                         and PREJPROG = 'FGCA')
      AND NOT EXISTS ( SELECT 1
                       FROM LDC_PERIPROG
                       WHERE PEPRPEFA = P.pefacodi AND PEPRFLAG = 'N'
                        AND PROCESO = 1);



    regPeriodo  cugetPeriodo%ROWTYPE;
    sbDatos VARCHAR2(1);

    PROCEDURE prInicializadatos IS
    BEGIN
          onuScheduleProcessAux := null;
          dtFechaProg := null;
          idtNextDate := null;
          isbParameters := null;
          tblServpend.DELETE;
          isbWhat := NULL;
          SBDESCESTADO := NULL;
          SBSERVDESC := NULL;
          NUINDEX := 1;
    END prInicializadatos;

  BEGIN
      ut_trace.trace('INICIO PRGCAM', 10);

     -- Consultamos datos para inicializar el proceso
    SELECT to_number(TO_CHAR(SYSDATE,'YYYY')) ,
            to_number(TO_CHAR(SYSDATE,'MM')) ,
            userenv('SESSIONID') ,
            USER
          INTO nuparano,
            nuparmes,
            nutsess,
            sbparuser
    FROM dual;
   -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,nuparmes,'PRJOBGENCARGAUTO','En ejecucion',nutsess,sbparuser);
   IF FBLAPLICAENTREGAXCASO('0000461') THEN
       SBTIPOSERV :=  '-' ;
        --se realiza proceso de cadena de conexion
        IF sbCadeScrip IS NULL THEN
          --se obtiene cadena de conexion
          GE_BODATABASECONNECTION.GETCONNECTIONSTRING(sbUsuario, sbpassword, sbInstance);
          sbCadenaCone  := sbUsuario || '/' || sbpassword || '@' || sbInstance;
          sbCadeScrip   := FA_UIProcesosFact.FSBENCRIPTACADENA(sbCadenaCone);
         END IF;
--DBMS_OUTPUT.PUT_line('INICIO ');


         FOR regPeriodo IN cugetPeriodo LOOP
             ut_trace.trace(' CICLO ['||regPeriodo.PEFACICL||'] anio ['||regPeriodo.PEFAANO||' MES ['||regPeriodo.PEFAMES||'] FECHA ['||regPeriodo.FECHA||']', 10);
             --se inicializan datos
             prInicializadatos;

           --  DBMS_OUTPUT.PUT_line(' CICLO ['||regPeriodo.PEFACICL||'] anio ['||regPeriodo.PEFAANO||' MES ['||regPeriodo.PEFAMES||'] FECHA ['||regPeriodo.FECHA||']');


             --Obtine el siguiente valor para el id de Ge_process_schedule
             select max(process_schedule_id)+1 into onuScheduleProcessAux
             from Ge_process_schedule;
             ut_trace.trace('onuScheduleProcessAux ['||onuScheduleProcessAux||']', 10);
--DBMS_OUTPUT.PUT_line('onuScheduleProcessAux ['||onuScheduleProcessAux||']');

             dtFechaProg := SYSDATE + (NUMINUTOS * (1/24/60));

             idtNextDate := dtFechaProg;
             --Parametros
             isbParameters := 'NULL=|PEFACODI='||regPeriodo.periodo||'|PEFADESC='||regPeriodo.PEFADESC||'|PEFACICL='||regPeriodo.pefacicl||'|PEFAANO='||regPeriodo.PEFAANO||'|PEFAMES='||regPeriodo.PEFAMES||'|PEFAFEGE='||regPeriodo.FECHA||'|NULL=|SERVTISE=-|CON='||sbCadeScrip||'|';
             ut_trace.trace('isbParameters ['||isbParameters||']', 10);
             --Bloque an¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿nimo con el que se fija la frecuencia de ejecuci¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿n del job
             isbWhat := 'BEGIN
                          SetSystemEnviroment;
                          Errors.Initialize;
                          FGCA( '||onuScheduleProcessAux||' );
                          if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                            GE_BOSchedule.InactiveSchedule( '||onuScheduleProcessAux||' );
                          end if;
                        EXCEPTION
                          when OTHERS then
                            Errors.SetError;
                            if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                              GE_BOSchedule.DropSchedule( '||onuScheduleProcessAux||' );
                            end if;
                        END;';
              ut_trace.trace('isbWhat ['||isbWhat||']', 10);
            --  DBMS_OUTPUT.PUT_LINE('isbWhat ['||isbWhat||']');
             GE_BOSchedule.PrepareSchedule(inuExecutable,isbParameters,isbWhat,onuScheduleProcessAux);
-- DBMS_OUTPUT.PUT_LINE('TERMINO DE PROGRAMAR ');
             PKBOPROCCTRLBYSERVICEMGR.FILLSERVPENDLIQSERVTYPE
              (
                  regPeriodo.pefacicl,
                  regPeriodo.periodo,
                  SBTIPOSERV,
                  tblServpend
              );

              --si hay datos pendientes
              IF tblServpend.COUNT > 0 THEN
                  FOR I IN tblServpend.FIRST..tblServpend.LAST LOOP
                --   DBMS_OUTPUT.PUT_LINE('VALDIAR '||PKBILLCONST.PROG_FGCA||' - '||regPeriodo.periodo||' '|| tblServpend(I).SERVCODI);
                      IF NOT prValidProgPeriodo(PKBILLCONST.PROG_FGCA,  regPeriodo.periodo, tblServpend(I).SERVCODI) THEN
                        IF tblServpend(I).SERVESTA = 'B' THEN
                          SBDESCESTADO := csbBloqueado;
                        END IF;

                        IF tblServpend(I).SERVESTA = 'E' THEN
                          SBDESCESTADO := csbEjecucion;
                        END IF;

                        IF tblServpend(I).SERVESTA = 'I' THEN
                          SBDESCESTADO := csbInconsistente;
                        END IF;

                        IF tblServpend(I).SERVESTA = 'C' THEN
                          SBDESCESTADO := csbCaido;
                        END IF;

                          IF tblServpend(I).SERVESTA = 'P' THEN
                          SBDESCESTADO := csbPendiente;
                        END IF;

                        IF tblServpend(I).SERVESTA = 'A' THEN
                          SBDESCESTADO := csbAutorizado;
                        END IF;

                        SBSERVDESC := PKTBLSERVICIO.FSBGETDESCRIPTION(tblServpend(I).SERVCODI);
                        INSERT INTO GE_PROC_SCHE_DETAIL (PROC_SCHE_DETAIL_ID,
                                                         PROCESS_SCHEDULE_ID,
                                                         SEQUENCE,
                                                         PARAMETER
                                                         )
                                                         VALUES(
                                                         SEQ_GE_PROC_SCHE_DETAIL.NEXTVAL,
                                                         onuScheduleProcessAux,
                                                         NUINDEX,
                                                         '|SERVCODI='||tblServpend(I).SERVCODI||'|SERVDESC='||SBSERVDESC||'|SERVESTA='||SBDESCESTADO||'|'
                                                         );
                        NUINDEX := NUINDEX + 1;
                      END IF;
                  END LOOP;
               END IF;
              --se crea programacion
              GE_BOSchedule.Scheduleprocess(onuScheduleProcessAux,isbFrecuency,idtNextDate);
              --
              INSERT INTO LDC_PERIPROG
                (
                  PEPRPEFA,    PEPRCICL,    PEPRPROG,    PEPRUSUA,    PEPRTERM,    PEPRFEIN, PROCESO
                )
                VALUES
                (
                   regPeriodo.periodo,    regPeriodo.pefacicl,  onuScheduleProcessAux,    user,    userenv('TERMINAL'),   idtNextDate, 1
                 );

             COMMIT;

         END LOOP;
   END IF;
   ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBGENCARGAUTO','OK');

  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.geterror(nuerror,SBERROR);
      ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBGENCARGAUTO','error');
      ROLLBACK;
    WHEN OTHERS THEN
      ERRORS.seterror;
      ERRORS.geterror(nuerror,SBERROR);
      ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBGENCARGAUTO','error');
      ROLLBACK;
  END PRJOBGENCARGAUTO;

   PROCEDURE PRVALIPROFGCC(inuPeriodo IN NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2) is
   /**************************************************************************
      Autor       : Horbath
      Proceso     : PRVALIPROFGCC
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de validar las condiciones para ejecucion del periodo para Fgcc

      Parametros Entrada
       inuPeriodo  periodo de facturacion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

        regPeriFact   PERIFACT%ROWTYPE;

        SBPROGRAMA          VARCHAR2(100) := 'FGCC';


        PROCEDURE prValidaPeriFact(regPerifactu   IN OUT PERIFACT%ROWTYPE) IS
            CSBEJECUCION	     CONSTANT VARCHAR2(1) := 'E';
            sbestaEjecu	PROCEJEC.PREJESPR%TYPE;
        BEGIN

            sbestaEjecu := PKEXECUTEDPROCESSMGR.FSBGETSTATUSOFPROCESS(regPerifactu.PEFACODI, 'FGCC');

            IF ( sbestaEjecu = CSBEJECUCION ) THEN
                regPerifactu.PEFAFEGE := NVL(regPerifactu.PEFAFEGE,SYSDATE);
            ELSE
                regPerifactu.PEFAFEGE := SYSDATE;
            END IF;


            PKBCPERICOSE.VALCNSMPRDCONFIG
            (
              regPerifactu.PEFACICL,
              PKCONSTANTE.NULLNUM,
              regPerifactu.PEFACODI
            ) ;

        END prValidaPeriFact;


   BEGIN
        onuError := 0;
        osbError := null;

        regPeriFact := PKTBLPERIFACT.FRCGETRECORD(inuPeriodo);
        prValidaPeriFact(regPeriFact);

        PKEXECUTEDPROCESSMGR.VALIFCANEXECUTEPROCESS
        (
            regPeriFact.PEFACODI,
            SBPROGRAMA,
            -1
        );

        prValidProgPeriodo (SBPROGRAMA,inuPeriodo);


   EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
             errors.geterror(onuError, osbError);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
              errors.geterror(onuError, osbError);

    END  PRVALIPROFGCC;

     PROCEDURE PRVALIPROFCPE(inuPeriodo IN NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2) IS
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRVALIPROFCPE
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de validar las condiciones para ejecucion del periodo para FCPE

      Parametros Entrada
       inuPeriodo  periodo de facturacion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    SBPROGRAMA varchar2(40) := 'FCPE';

    BEGIN
     onuError := 0;
     osbError := null;

     PKEXECUTEDPROCESSMGR.VALIFCANEXECUTEPROCESS
      (
          inuPeriodo,
          SBPROGRAMA,
          -1
      );

       prValidProgPeriodo (SBPROGRAMA,inuPeriodo);

   EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
           errors.geterror(onuError, osbError);
      WHEN OTHERS THEN
          ERRORS.SETERROR;
          errors.geterror(onuError, osbError);
    END  PRVALIPROFCPE;

    PROCEDURE PRPROGFGCC ( inuPeriodo IN NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2) IS
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRPROGFGCC
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de programar el proceso FGCC

      Parametros Entrada
       inuPeriodo  periodo de facturacion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
     onuScheduleProcessAux NUMBER;
     regPeriodo  cugetPeriodo%ROWTYPE;
     idtNextDate DATE;
     isbParameters VARCHAR2(4000);
     isbWhat VARCHAR2(4000);
     inuExecutable     Sa_executable.executable_id%type := 5549;
     isbFrecuency      Ge_process_schedule.Frequency%type := 'UV';

    BEGIN

     OPEN cugetPeriodo(inuPeriodo);
     FETCH cugetPeriodo INTO regPeriodo;
     CLOSE cugetPeriodo;

     ut_trace.trace(' CICLO ['||regPeriodo.PEFACICL||'] ANIO ['||regPeriodo.PEFAANO||' MES ['||regPeriodo.PEFAMES||'] FECHA ['||regPeriodo.FECHA||']', 10);
     --Obtine el siguiente valor para el id de Ge_process_schedule
     select max(process_schedule_id)+1 into onuScheduleProcessAux
     from Ge_process_schedule;

     ut_trace.trace('onuScheduleProcessAux ['||onuScheduleProcessAux||']', 10);

     IF dtFechaProg IS NULL THEN
       dtFechaProg := to_date(sbPEFAFEGEP,''||sbdateformat||'') + (NUMINUTOS * (1/24/60));
     ELSE
       dtFechaProg := dtFechaProg + (NUMINUTOS * (1/24/60));
     END IF;
     idtNextDate := dtFechaProg;
     --Parametros
     isbParameters := 'PEFACODI='||inuPeriodo||'|PEFADESC='||regPeriodo.PEFADESC||'|PEFACICL='||regPeriodo.pefacicl||'|PEFAANO='||regPeriodo.PEFAANO||'|PEFAMES='||regPeriodo.PEFAMES||'|PEFAFEGE='||regPeriodo.FECHA||'|PEFAFCCO='||to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss')||'|CON='||sbCadeScrip||'|';

     ut_trace.trace('isbParameters ['||isbParameters||']', 10);
     --Bloque an¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿nimo con el que se fija la frecuencia de ejecuci¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿n del job
     isbWhat := 'BEGIN
                  SetSystemEnviroment;
                  Errors.Initialize;
                  FGCC( '||onuScheduleProcessAux||' );
                  if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                    GE_BOSchedule.InactiveSchedule( '||onuScheduleProcessAux||' );
                  end if;
                EXCEPTION
                  when OTHERS then
                    Errors.SetError;
                    if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                      GE_BOSchedule.DropSchedule( '||onuScheduleProcessAux||' );
                    end if;
                END;';
        ut_trace.trace('isbWhat ['||isbWhat||']', 10);
       GE_BOSchedule.PrepareSchedule(inuExecutable,isbParameters,isbWhat,onuScheduleProcessAux);
       --se crea programacion
      GE_BOSchedule.Scheduleprocess(onuScheduleProcessAux,isbFrecuency,idtNextDate);

       INSERT INTO LDC_PERIPROG
          (
            PEPRPEFA,    PEPRCICL,    PEPRPROG,    PEPRUSUA,    PEPRTERM,    PEPRFEIN, PROCESO
          )
          VALUES
          (
             inuPeriodo,    regPeriodo.pefacicl,  onuScheduleProcessAux,    user,    userenv('TERMINAL'),   idtNextDate, 2
           );

    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
           errors.geterror(onuError, osbError);
      WHEN OTHERS THEN
          ERRORS.SETERROR;
          errors.geterror(onuError, osbError);
    END  PRPROGFGCC;

    PROCEDURE 	PRPROGFIDF( inuPeriodo IN NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2) IS
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRPROGFIDF
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de programar el proceso FIDF

      Parametros Entrada
       inuPeriodo  periodo de facturacion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      27/07/2021   ljlb       ca 696 se coloca orden en la programacion del proceso FIDF
      ***************************************************************************/
      onuScheduleProcessAux NUMBER;
     regPeriodo  cugetPeriodo%ROWTYPE;
     idtNextDate DATE;
     isbParameters VARCHAR2(4000);
     isbWhat VARCHAR2(4000);
     inuExecutable     Sa_executable.executable_id%type := 5049;
     isbFrecuency      Ge_process_schedule.Frequency%type := 'UV';

     sbOrden VARCHAR2(40);

    BEGIN

     --Obtine el siguiente valor para el id de Ge_process_schedule
     select max(process_schedule_id)+1 into onuScheduleProcessAux
     from Ge_process_schedule;

     ut_trace.trace('onuScheduleProcessAux ['||onuScheduleProcessAux||']', 10);

     OPEN cugetPeriodo(inuPeriodo);
     FETCH cugetPeriodo INTO regPeriodo;
     CLOSE cugetPeriodo;

     IF dtFechaProg IS NULL THEN
       dtFechaProg := to_date(sbPEFAFEGEP,''||sbdateformat||'') + (NUMINUTOS * (1/24/60));
     ELSE
       dtFechaProg := dtFechaProg + (NUMINUTOS * (1/24/60));
     END IF;
     idtNextDate := dtFechaProg;
     --Parametros
     --INICIO CA 696
     /*IF FBLAPLICAENTREGAXCASO('0000696') THEN
        SELECT decode(sbPEFAORDE, '1', 's.susccodi', '2', 's.suscbanc', '3', 's.suscsuba', '4', 'r.route_id', '5', 's.susccodi', '6', 'funcion', '7', 'd.geograp_location_id') INTO sbOrden
        FROM DUAL;

       isbParameters := '|ORDEN='||sbOrden||'|PERIFACT='||inuPeriodo||'|CONDICION=|ESTAARCH=0|COPIAFIEL=S|MEDIO=GR|RUTASREPARTO=|TIPOSDOC=66|CON='||sbCadeScrip;
     ELSE
       isbParameters := '|ORDEN=r.route_id, funcion|PERIFACT='||inuPeriodo||'|CONDICION=|ESTAARCH=0|COPIAFIEL=S|MEDIO=GR|RUTASREPARTO=|TIPOSDOC=66|CON='||sbCadeScrip;
     END IF;*/

	   isbParameters := '|ORDEN=r.route_id, funcion|PERIFACT='||inuPeriodo||'|CONDICION=|ESTAARCH=0|COPIAFIEL=S|MEDIO=GR|RUTASREPARTO=|TIPOSDOC=66|CON='||sbCadeScrip;

     --FIN CA 696
      ut_trace.trace('isbParameters ['||isbParameters||']', 10);
     --Bloque an¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿nimo con el que se fija la frecuencia de ejecuci¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿n del job
     isbWhat := 'BEGIN
                  SetSystemEnviroment;
                  Errors.Initialize;
                  FIDF( '||onuScheduleProcessAux||' );
                  if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                    GE_BOSchedule.InactiveSchedule( '||onuScheduleProcessAux||' );
                  end if;
                EXCEPTION
                  when OTHERS then
                    Errors.SetError;
                    if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                      GE_BOSchedule.DropSchedule( '||onuScheduleProcessAux||' );
                    end if;
                END;';
        ut_trace.trace('isbWhat ['||isbWhat||']', 10);
       GE_BOSchedule.PrepareSchedule(inuExecutable,isbParameters,isbWhat,onuScheduleProcessAux);
       --se crea programacion
      GE_BOSchedule.Scheduleprocess(onuScheduleProcessAux,isbFrecuency,idtNextDate);

       --
        INSERT INTO LDC_PERIPROG
          (
            PEPRPEFA,    PEPRCICL,    PEPRPROG,    PEPRUSUA,    PEPRTERM,    PEPRFEIN, PROCESO
          )
          VALUES
          (
             inuPeriodo,    regPeriodo.pefacicl,  onuScheduleProcessAux,    user,    userenv('TERMINAL'),   idtNextDate, 3
           );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
           errors.geterror(onuError, osbError);
      WHEN OTHERS THEN
          ERRORS.SETERROR;
          errors.geterror(onuError, osbError);
    END  PRPROGFIDF;

    PROCEDURE 	PRPROGFCPE( inuPeriodo IN NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2) is
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRPROGFCPE
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de programar el proceso FCPE

      Parametros Entrada
       inuPeriodo  periodo de facturacion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
       onuScheduleProcessAux NUMBER;
     regPeriodo  cugetPeriodo%ROWTYPE;
     idtNextDate DATE;
     isbParameters VARCHAR2(4000);
     isbWhat VARCHAR2(4000);
     inuExecutable     Sa_executable.executable_id%type := 5316;
     isbFrecuency      Ge_process_schedule.Frequency%type := 'UV';
     nuPeriSigu NUMBER;
     nuReporte  REPORTES.REPONUME%TYPE;
     regPeriSigui  PERIFACT%ROWTYPE;

    BEGIN

     --Obtine el siguiente valor para el id de Ge_process_schedule
     select max(process_schedule_id)+1 into onuScheduleProcessAux
     from Ge_process_schedule;
     ut_trace.trace('onuScheduleProcessAux ['||onuScheduleProcessAux||']', 10);

     OPEN cugetPeriodo(inuPeriodo);
     FETCH cugetPeriodo INTO regPeriodo;
     CLOSE cugetPeriodo;

     ut_trace.trace(' CICLO ['||regPeriodo.PEFACICL||'] ANIO ['||regPeriodo.PEFAANO||' MES ['||regPeriodo.PEFAMES||'] FECHA ['||regPeriodo.FECHA||']', 10);

     IF dtFechaProg IS NULL THEN
       dtFechaProg := to_date(sbPEFAFEGEP,''||sbdateformat||'') + (NUMINUTOS * (1/24/60));
     ELSE
       dtFechaProg := dtFechaProg + (NUMINUTOS * (1/24/60));
     END IF;
     idtNextDate := dtFechaProg;

     --obtiene periodo siguiente
     PKBILLINGPERIODMGR.GETNEXTBILLPERIOD(inuPeriodo,nuPeriSigu);

    regPeriSigui  := PKTBLPERIFACT.FRCGETRECORD(nuPeriSigu);

     --se consulta reporte
     PKBOPROCCTRLBYBILLPERIOD.INSBILLPERIODTOPROCINREPOINCO
	  	(
	  		inuPeriodo,
	  		nuPeriSigu,
	  		nuReporte
	  	);

     --Parametros
     isbParameters := 'NULL=|PEFACODI='||inuPeriodo||'|PEFADESC='||regPeriodo.PEFADESC||'|PEFACICL='||regPeriodo.pefacicl||'|PEFAANO='||regPeriodo.PEFAANO||'|PEFAMES='||regPeriodo.PEFAMES||'|PEFAFIMO='||regPeriodo.pefafimo||'|PEFAFFMO='||regPeriodo.pefaffmo||'|NULL=|FACTPEFA='||nuPeriSigu||'|CICLDESC='||regPeriodo.PEFADESC||'|CICLCODI='||regPeriodo.pefacicl||'|SSEFANO='||regPeriSigui.pefaano||'|SSEFMES='||regPeriSigui.pefames||'|PECSFECI='||regPeriSigui.pefafimo||'|PECSFECF='||regPeriSigui.pefaffmo||'|REPONUME='||RPAD(nuReporte,8,' ')||'|CON='||sbCadeScrip||'|';

     ut_trace.trace('isbParameters ['||isbParameters||']', 10);
     --Bloque an¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿nimo con el que se fija la frecuencia de ejecuci¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿n del job
     isbWhat := 'BEGIN
                  SetSystemEnviroment;
                  Errors.Initialize;
                  FCPE( '||onuScheduleProcessAux||' );
                  if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                    GE_BOSchedule.InactiveSchedule( '||onuScheduleProcessAux||' );
                  end if;
                EXCEPTION
                  when OTHERS then
                    Errors.SetError;
                    if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                      GE_BOSchedule.DropSchedule( '||onuScheduleProcessAux||' );
                    end if;
                END;';
        ut_trace.trace('isbWhat ['||isbWhat||']', 10);
       GE_BOSchedule.PrepareSchedule(inuExecutable,isbParameters,isbWhat,onuScheduleProcessAux);
       --se crea programacion
      GE_BOSchedule.Scheduleprocess(onuScheduleProcessAux,isbFrecuency,idtNextDate);

       --
      INSERT INTO LDC_PERIPROG
        (
          PEPRPEFA,    PEPRCICL,    PEPRPROG,    PEPRUSUA,    PEPRTERM,    PEPRFEIN, PROCESO
        )
        VALUES
        (
           inuPeriodo,    regPeriodo.pefacicl,  onuScheduleProcessAux,    user,    userenv('TERMINAL'),   idtNextDate, 4
         );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
           errors.geterror(onuError, osbError);
      WHEN OTHERS THEN
          ERRORS.SETERROR;
          errors.geterror(onuError, osbError);
    END  PRPROGFCPE;

   PROCEDURE 	PRPROCOPYFACT is
    /**************************************************************************
      Autor       : Horbath
      Proceso     : PRPROCOPYFACT
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : job que se encarga de generar proceso LDCCOPYFACT

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
     --variabe para estaproc
    nuparano     NUMBER;
    nuparmes     NUMBER;
    nutsess      NUMBER;
    sbparuser    VARCHAR2(400);
    SBERROR      VARCHAR2(4000);
    nuerror      NUMBER;

    CURSOR cuGetPeriodosProc IS
    SELECT rowid ID_REG,  c.PCFAPEFA periodo
    FROM LDC_PECOFACT c
    WHERE PCFAESTA = 'N';

    TYPE tblPeriProc IS TABLE OF cuGetPeriodosProc%ROWTYPE INDEX BY VARCHAR2(20);
   vtblPeriProc tblPeriProc;
   sbIndexPeri VARCHAR2(20);
   sbPeriodos VARCHAR2(4000);

  BEGIN
      -- Consultamos datos para inicializar el proceso
    SELECT to_number(TO_CHAR(SYSDATE,'YYYY')) ,
            to_number(TO_CHAR(SYSDATE,'MM')) ,
            userenv('SESSIONID') ,
            USER
          INTO nuparano,
            nuparmes,
            nutsess,
            sbparuser
    FROM dual;
   -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,nuparmes,'PRPROCOPYFACT','En ejecucion',nutsess,sbparuser);
   IF FBLAPLICAENTREGAXCASO('0000461') THEN
     vtblPeriProc.DELETE;

     FOR reg IN cuGetPeriodosProc  LOOP
        --se coloca registro en procesando
        UPDATE LDC_PECOFACT
        SET PCFAESTA = 'T', PCFAFEPR = sysdate
        WHERE ROWID  = reg.ID_REG;
        COMMIT;

        IF NOT vtblPeriProc.EXISTS(reg.periodo) THEN
          vtblPeriProc(reg.periodo).ID_REG   := reg.ID_REG;
          vtblPeriProc(reg.periodo).periodo := reg.periodo;
		  IF sbPeriodos IS NULL THEN
		     sbPeriodos := reg.periodo;
		  ELSE
			 sbPeriodos := sbPeriodos||','||reg.periodo;
		  END IF;
        END IF;

      END LOOP;

      IF vtblPeriProc.COUNT > 0 THEN
        --se crrea la intancia necesaria
        GE_BOINSTANCECONTROL.INITINSTANCEMANAGER;
        GE_BOINSTANCECONTROL.CREATEINSTANCE('WORK_COPYFACT');
        GE_BOINSTANCECONTROL.ADDATTRIBUTE('WORK_COPYFACT', NULL,'CC_FILE', 'OBSERVATION', 0);
		--se actualiza valor a al intancia
		GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE('WORK_COPYFACT', NULL,'CC_FILE', 'OBSERVATION', sbPeriodos);

		--se llama proceso de copifact
        LDC_PKGOSFFACTURE.PROEXECOPYARCHFIDF;

          --se genera proceso de copyfact
       /* sbIndexPeri     := vtblPeriProc.FIRST;
        LOOP
          EXIT WHEN sbIndexPeri IS NULL;
           --se actualiza valor a al intancia
          GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE('WORK_COPYFACT', NULL,'CC_FILE', 'OBSERVATION', vtblPeriProc(sbIndexPeri).periodo);

          --se llama proceso de copifact
          LDC_PKGOSFFACTURE.PROEXECOPYARCHFIDF;


          UPDATE LDC_PECOFACT
            SET PCFAESTA = 'T'
            WHERE ROWID  = vtblPeriProc(sbIndexPeri).ID_REG;
          COMMIT;

          sbIndexPeri := vtblPeriProc.NEXT(sbIndexPeri);
        END LOOP;*/
      END IF;

   END IF;
   ldc_proactualizaestaprog(nutsess,SBERROR,'PRPROCOPYFACT','OK');
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.geterror(nuerror,SBERROR);
      ldc_proactualizaestaprog(nutsess,SBERROR,'PRPROCOPYFACT','error');
      ROLLBACK;
    WHEN OTHERS THEN
      ERRORS.seterror;
      ERRORS.geterror(nuerror,SBERROR);
      ldc_proactualizaestaprog(nutsess,SBERROR,'PRPROCOPYFACT','error');
      ROLLBACK;
    END PRPROCOPYFACT;

    PROCEDURE PRJOBNOTIPROCFACT IS
      /**************************************************************************
      Autor       : Horbath
      Proceso     : PRJOBNOTIPROCFACT
      Fecha       : 2021-26-07
      Ticket      : 696
      Descripcion : job que se encarga de enviar correo de procesos de facturacion

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
      --variabe para estaproc
      nuparano     NUMBER;
      nuparmes     NUMBER;
      nutsess      NUMBER;
      sbparuser    VARCHAR2(400);
      SBERROR      VARCHAR2(4000);
      nuerror      NUMBER;

      --se obtienen periodos pendientes
      CURSOR cuGetPeriodosNoti IS
      SELECT ROWID, PEPRCICL, PROCESO, DECODE(PROCESO,1, 'FGCA', 2, 'FGCC', 3,'FIDF', 4, 'FCPE') programa
      FROM LDC_PERIPROG p
      WHERE PEPRFLAG = 'T'
       AND PEPRNOTI = 'N'
       AND TRUNC(PEPRFEFI) = TRUNC(SYSDATE )
       AND NOT EXISTS ( SELECT 1
                        FROM LDC_PERIPROG P1
                        where p.PROCESO = p1.proceso
                          AND TRUNC(p1.PEPRFEIN) = TRUNC(SYSDATE)
                          AND P1.PEPRFLAG = 'N' )
       AND (( PROCESO = 3
                AND NOT EXISTS ( SELECT 1
                                 FROM LDC_PECOFACT pe
                                 WHERE  TRUNC(PCFAFERE) =  TRUNC(SYSDATE) AND PCFAESTA <> 'T')
            ) OR PROCESO <> 3)
      ORDER BY PROCESO;

      nuProcesoAnt NUMBER := -1;
      sbCiclos VARCHAR2(4000);
      sbPrograma VARCHAR2(40);
      sbEmailNoti VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_EMAILNOLE',NULL);
      sb_subject        VARCHAR2(200);

       cursor cuEmails(sbEmail VARCHAR2, sbseparador VARCHAR2) is
        select column_value
           from table(ldc_boutilities.splitstrings(sbEmail, sbseparador));

        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

    BEGIN
       -- Consultamos datos para inicializar el proceso
      SELECT to_number(TO_CHAR(SYSDATE,'YYYY')) ,
              to_number(TO_CHAR(SYSDATE,'MM')) ,
              userenv('SESSIONID') ,
              USER
            INTO nuparano,
              nuparmes,
              nutsess,
              sbparuser
      FROM dual;
       -- Inicializamos el proceso
      ldc_proinsertaestaprog(nuparano,nuparmes,'PRJOBNOTIPROCFACT','En ejecucion',nutsess,sbparuser);
       IF FBLAPLICAENTREGAXCASO('0000461') THEN
          IF sbEmailNoti IS NOT NULL THEN
             FOR reg IN cuGetPeriodosNoti LOOP

               IF nuProcesoAnt <> reg.proceso THEN
                  IF nuProcesoAnt <> -1 THEN
                       BEGIN
                           FOR item IN cuEmails(sbEmailNoti, ',') LOOP

                                pkg_Correo.prcEnviaCorreo
                                (
                                    isbRemitente        =>  sbRemitente, 
                                    isbDestinatarios    =>  TRIM(item.column_value),
                                    isbAsunto           =>  'Ejecucion masivo del proceso ['||sbPrograma||'] dia ['||to_char(sysdate, 'dd/mm/yyyy hh24_mi_ss')||']',
                                    isbMensaje          =>  'Proceso ['||sbPrograma||'] termino correctamente para los ciclos ['||sbCiclos||']'
                                );
                                
                           END LOOP;
                           COMMIT;
                       EXCEPTION
                         WHEN OTHERS THEN
                            ERRORS.SETERROR(nuerror,SBERROR);
                            ROLLBACK;
                       END;
                  END IF;
                  nuProcesoAnt := reg.proceso;
                  sbCiclos := NULL;
               END IF;
               sbPrograma := reg.programa;
                if sbCiclos is null then
                 sbCiclos :=  REG.PEPRCICL;
               else
                  sbCiclos := sbCiclos||','||REG.PEPRCICL;
               end if;

               UPDATE LDC_PERIPROG SET PEPRNOTI = 'S'
               WHERE ROWID = REG.ROWID;

             END LOOP;

              IF nuProcesoAnt <> -1 and sbCiclos is not null THEN
                   BEGIN
                       FOR item IN cuEmails(sbEmailNoti, ',') LOOP

                            pkg_Correo.prcEnviaCorreo
                            (
                                isbRemitente        =>  sbRemitente, 
                                isbDestinatarios    =>  TRIM(item.column_value),
                                isbAsunto           =>  'Ejecucion masivo del proceso ['||sbPrograma||'] dia ['||to_char(sysdate, 'dd/mm/yyyy hh24_mi_ss')||']',
                                isbMensaje          =>  'Proceso ['||sbPrograma||'] termino correctamente para los ciclos ['||sbCiclos||']'
                            );
                                
                       END LOOP;
                       COMMIT;
                   EXCEPTION
                     WHEN OTHERS THEN
                        ERRORS.SETERROR(nuerror,SBERROR);
                        ROLLBACK;
                   END;
              END IF;
         END IF;
       END IF;
       ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBNOTIPROCFACT','OK');
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
        ERRORS.geterror(nuerror,SBERROR);
        ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBNOTIPROCFACT','error');
        ROLLBACK;
      WHEN OTHERS THEN
        ERRORS.seterror;
        ERRORS.geterror(nuerror,SBERROR);
        ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBNOTIPROCFACT','error');
        ROLLBACK;
    END PRJOBNOTIPROCFACT;
END LDC_PKGGCMA;
/

