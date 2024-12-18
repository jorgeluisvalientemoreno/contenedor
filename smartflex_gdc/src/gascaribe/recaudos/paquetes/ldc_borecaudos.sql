CREATE OR REPLACE PACKAGE OPEN."LDC_BORECAUDOS" AS

  /*******************************************************************************
  Propiedad intelectual de PROYECTO PETI

  Descripcion    : Implementa la logica requerida para el area de recaudos
  Autor          : Luz Andrea Angel M./OLSoftware
  Fecha          : 18-03-2013

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  18-03-2013     luzaa                creacion del paquete y adicion del procedimiento proNotificaErroresRecaudo
  12-06-2013     luzaa                modificacion para que la fecha de verificacion sea parametrizable
  06-08-2013     luzaa                NC418: se elimina el parametro de fecha y se ajusta la logica para que la ejecucion
                                      del job sea cada hora, por lo que el reporte buscara los archivos aplicados en el rango
                                      de ejecucion del job.
  09-08-2013     luzaa                NC418v2:se adiciona la observacion en el mensaje, a fin de informar el error. Y se incluye
                                      la entidad que tiene error en el asunto
  22-01-2014     smejia               NC 2657: modificacion del procedimiento proNotificaErroresRecaudo, donde
                                      se parametrizan los destinatarios de los correos, de modo que estos no sean las
                                      entidades financieras, sino los que el usuario funcional defina.
  15-05-2024	 JSOTO				  OSF-2602 Se reemplaza uso de LDC_Email.mail por pkg_correo.prcEnviaCorreo
									  Se reemplaza uso de LDC_ManagementEmailFNB.PROENVIARCHIVO  por pkg_correo.prcEnviaCorreo
									  Se reemplaza uso de las funciones UTL_FILE por pkg_GestionArchivos
  *******************************************************************************/

  procedure proNotificaErroresRecaudo;

  /*****************************************
  Metodo      : ProErrorArchivoRecaudo
  Descripcion : Envia en un correo mediante un archivo adjunto
                del LOG de errores. Para que el funcionario
                veirifque el archivo LOG generado por SMARTFLEX.

  Autor: Jorge Luis Valiente Moreno
  Fecha: 05 de Noviembre de 2013

    Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  ******************************************/
  PROCEDURE ProErrorArchivoRecaudo;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_BORECAUDOS
  Descripcion    : PROCEDIMIENTO QUE SE ENCARGARA DE CREAR ORDEN DE TRABAJO
                   PROCESO ASCOCIADO A LA FORMA LDCGOC (Generacion de Ordenes a Contratistas)

  Autor          : Jorge Valiente
  Fecha          : 16/09/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PRGENERAORDE;

END LDC_BORECAUDOS;
/

CREATE OR REPLACE PACKAGE BODY OPEN."LDC_BORECAUDOS" AS

  /*****************************************
  Metodo      : proNotificaErroresRecaudo
  Descripcion : Obtiene por entidad recaudadora las inconsistencias presentadas en los archivos aplicados
                en un d?a y enviar una notificacion via e-mail donde se informa:
                - el dia
                - archivo
                - inconsistencia

  Autor: Luz Andrea Angel M./OLSoftware
  Fecha: Marzo 18/2013

    Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  18-Mar-2013     luzaa               creacion del paquete y adicion del procedimiento proNotificaErroresRecaudo
  12-Jun-2013     luzaa               modificacion para que la fecha de verificacion sea parametrizable
  06-Ago-2013     luzaa               NC418: se elimina el parametro de fecha y se ajusta la logica para que la ejecucion
                                      del job sea cada hora, por lo que el reporte buscara los archivos aplicados en el rango
                                      de ejecucion del job.
  09-08-2013      luzaa               NC418v2:se adiciona la observacion en el mensaje, a fin de informar el error. Y se incluye
                                      la entidad que tiene error en el asunto
  22-01-2014      smejia              NC 2657: Se parametrizan los destinatarios de los correos, de modo que estos no sean las
                                      entidades financieras, sino los que el usuario funcional defina.
  ******************************************/
  PROCEDURE proNotificaErroresRecaudo IS

    CURSOR cuRecaudadores(dtFechaU date, dtfechan date) is
      select distinct b.hirebanc banco,
                      -- d.correo_electronico correo,
                      c.bancnomb nombreBanco
        FROM GST_REERDEAU a, GST_HIARREDA b, banco c --, ge_contratista d
       WHERE a.REDAHIRE = b.HIRECODI
         and b.hirebanc = c.banccodi
            --   and c.banccont = d.id_contratista
         and b.hirefepr >= dtfechau
         AND B.HIREFEPR <= dtfechan
      --      AND TRUNC(B.HIREFEPR) = TRUNC(TO_DATE('01/02/2013')-1)
       order by b.HIREBANC asc;

    cursor cuinformacion(idbanco  banco.banccodi%type,
                         dtFechaU date,
                         dtfechan date) IS
      select a.redacodi consecutivoerror,
             a.redahire idarchivo,
             b.hirefepr fechaprocesa,
             a.REDAREER regError,
             b.HIREARCH archivo,
             a.redaobse observacion
        FROM GST_REERDEAU a, GST_HIARREDA b, banco c, ge_contratista d
       WHERE a.REDAHIRE = b.HIRECODI
         and b.hirebanc = c.banccodi
         and c.banccont = d.id_contratista
         and b.hirefepr >= dtfechau
         AND B.HIREFEPR <= dtfechan
            --      AND TRUNC(B.HIREFEPR) = TRUNC(TO_DATE('01/02/2013')-1)
         and c.banccodi = idbanco;

    cursor cuejecucion(dtfechar date) is
      select c.last_date, c.next_date
        from ge_object a, ge_process_schedule b, dba_jobs c
       where b.job = c.job
         and upper(a.name_) like
             upper('%LDC_BORECAUDOS.proNotificaErroresRecaudo%')
         and b.parameters_ like ('%' || a.object_id || '%')
         and b.status = 'P'
         and trunc(c.last_date) = trunc(dtfechar);

    sbCorreo    GE_CONTRATISTA.CORREO_ELECTRONICO%type;
    sbAsunto    varchar2(4000);
    sbcontenido varchar2(4000);
    sbErrores   varchar2(4000);
    sbmensaje   varchar2(4000);
    sender      varchar2(1000);
    dtfecha     date;
    dtufecha    date;
    dtpFecha    date;

    sbDestinatarios ld_parameter.value_chain%type;

  begin
    ut_trace.trace('Inicio ldc_borecaudos.proNotificaErroresRecaudo', 10);

    sender := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER');
    dbms_output.put_line('sender -->' || sender);

    sbDestinatarios := dald_parameter.fsbgetvalue_chain('LDC_REC_DESTINARIO_REP_INCONS');
    dbms_output.put_line('Destinatarios -->' || sbDestinatarios);

    dtfecha := trunc(sysdate);
    dbms_output.put_line('dtfecha -->' || dtfecha);
    sbcontenido := 'Los archivos aplicados el d?a ' || to_char(dtfecha) ||
                   ' presentaron las siguientes inconsistencias:';
    dbms_output.put_line('sbcontenido -->' || sbcontenido);
    --NC418
    open cuejecucion(dtfecha);
    fetch cuejecucion
      into dtufecha, dtpFecha;
    close cuejecucion;

    ut_trace.trace('ldc_borecaudos.proNotificaErroresRecaudo - ultima fecha: ' ||
                   dtufecha,
                   10);
    ut_trace.trace('ldc_borecaudos.proNotificaErroresRecaudo - proxima Fecha: ' ||
                   dtpFecha,
                   10);
    --Obtiene las entidades recaudadoras que presentan inconsistencias el d?a anterior a la ejecucion del proceso
    FOR rcRecaudadores IN cuRecaudadores(dtufecha, dtpFecha) LOOP
      sbAsunto  := 'Inconsistencias presentadas por la entidad ' ||
                   rcrecaudadores.nombreBanco ||
                   ', en la aplicaci?n de archivos del d?a ' ||
                   to_char(dtFecha) || chr(10);
      sbErrores := '';
      sbmensaje := '';
      sbErrores := '  ARCHIVO   |||           ERROR       |||               OBSERVACION        ' ||
                   chr(10);

      dbms_output.put_Line('banco --> ' || rcrecaudadores.banco);
      --Obtiene los archivos e inconsistencias presentadas en los archivos aplicados por recaudador
      for rcinformacion in cuinformacion(rcrecaudadores.banco,
                                         dtufecha,
                                         dtpfecha) loop
        sbErrores := sbErrores || chr(10) || rcInformacion.archivo ||
                     ' ||| ' || rcInformacion.regError || ' ||| ' ||
                     rcInformacion.observacion || chr(10);
      end loop;
      sbMensaje := sbContenido || chr(10) || sbErrores;

      --Enviar correspondencia por entidad recaudadora
	  
	  pkg_Correo.prcEnviaCorreo
							(
								isbRemitente        => sender,
								isbDestinatarios    => sbDestinatarios,
								isbAsunto           => sbAsunto,
								isbMensaje          => sbMensaje
							);


      dbms_output.put_line('sbmensaje -->' || sbmensaje);
    end loop;

    ut_trace.trace('Fin ldc_borecaudos.proNotificaErroresRecaudo', 10);

  END proNotificaErroresRecaudo;

  /*****************************************
  Metodo      : ProErrorArchivoRecaudo
  Descripcion : Envia en un correo mediante un archivo adjunto
                del LOG de errores. Para que el funcionario
                veirifque el archivo LOG generado por SMARTFLEX.

  Autor: Jorge Luis Valiente Moreno
  Fecha: 05 de Noviembre de 2013

    Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  ******************************************/
  PROCEDURE ProErrorArchivoRecaudo IS

    sbCorreo                     varchar2(1000);
    sbAsunto                     varchar2(4000);
    sbcontenido                  varchar2(4000);
    sbErrores                    varchar2(4000);
    sbMsg                        varchar2(4000);
    sender                       varchar2(1000);
    dtfecha                      date;
    dtufecha                     date;
    dtpFecha                     date;
    sbfilename                   varchar2(4000);
    sbOutfilename                varchar2(4000);
    SBRUTA_LOG_ARCH_RECA         varchar2(2000);
    v_archivo                    PKG_GESTIONARCHIVOS.STYARCHIVO;
    temp_file                    PKG_GESTIONARCHIVOS.STYARCHIVO;
    nuErrorCode                  number;
    ctrl                         varchar2(20) := CHR(10); -- Salto de linea..

    itab LDC_ARCHENVIADO%rowtype;

    nuVersion LDC_ARCHENVIADO.NU_VERSION%TYPE;
    nuCanti   LDC_ARCHENVIADO.CANTIDAD_REG%TYPE;
    nuconta   LDC_ARCHENVIADO.CANTIDAD_REG%TYPE;
    sbL_nom   varchar2(4000);
    cadena    VARCHAR2(32767);
    sw        number;
  begin
    ut_trace.trace('Inicio ldc_borecaudos.ProErrorArchivoRecaudo', 10);

    sender               := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER');
    SBRUTA_LOG_ARCH_RECA := dald_parameter.fsbgetvalue_chain('RUTA_LOG_ARCH_RECA');
    sbCorreo             := dald_parameter.fsbgetvalue_chain('EMAIL_FUNC_ARCH_RECA');
    nuVersion            := 0;
    nuCanti              := 0;

    sbfilename := 'BITAProcAutoRec_' || to_char(sysdate, 'DD-MM-YYYY') ||
                  '.trc';

    begin
      SELECT *
        INTO itab
        FROM LDC_ARCHENVIADO
       WHERE NOMBARCHI_ID = sbfilename;

      nuVersion := itab.NU_VERSION;
      nuCanti   := itab.CANTIDAD_REG;
    exception
      when no_data_found then
        nuVersion := 0;
        nuCanti   := 0;
    end;
    nuVersion     := nuVersion + 1;
    sbL_nom       := substr(sbfilename, 1, length(sbfilename) - 4);
    sbOutfilename := sbL_nom || '_' || nuVersion || '.trc';
    v_archivo     := PKG_GESTIONARCHIVOS.FTABRIRARCHIVO_SMF(SBRUTA_LOG_ARCH_RECA, sbfilename, 'r');

    nuconta := 0;
    sw      := 0;

    loop
      begin
        cadena:= PKG_GESTIONARCHIVOS.FSBOBTENERLINEA_SMF(v_archivo);
      exception
        when others then
          exit;
      end;
      exit when cadena is null;

      if cadena is not null then
        nuConta := nuConta + 1;
        if nuConta > nuCanti then
          if sw = 0 then
            temp_file := PKG_GESTIONARCHIVOS.FTABRIRARCHIVO_SMF(SBRUTA_LOG_ARCH_RECA,
																sbOutfilename,
																'w');
            sw        := 1;
          end if;
          PKG_GESTIONARCHIVOS.PRCESCRIBIRLINEA_SMF(temp_file, cadena);
        end if;
      end if;
    end loop;
    if sw = 1 then
      PKG_GESTIONARCHIVOS.PRCCERRARARCHIVO_SMF(temp_file);
      sbMsg    := 'Se adjunto el archivo ' || sbOutfilename;
      sbAsunto := 'LOG Inconsistencia Archivo Recaudos';
											
		pkg_correo.prcEnviaCorreo(
									isbRemitente        => sender,
									isbDestinatarios    => sbcorreo,
									isbAsunto           => sbAsunto,
									isbMensaje          => sbMsg,
									isbArchivos         => SBRUTA_LOG_ARCH_RECA
								);
								

      if nuErrorCode = 0 then
        update LDC_ARCHENVIADO
           set CANTIDAD_REG = nuConta, NU_VERSION = nuVersion
         where NOMBARCHI_ID = sbfilename;
        IF SQL%NOTFOUND THEN
          INSERT INTO LDC_ARCHENVIADO
            (NOMBARCHI_ID,
             FECHA_ENVIO,
             ENVIADO_A,
             ASUNTO,
             CANTIDAD_REG,
             NU_VERSION)
          values
            (sbfilename, sysdate, sbcorreo, sbAsunto, nuConta, nuVersion);
        end if;
        commit;
      end if;
    end if;
    PKG_GESTIONARCHIVOS.PRCCERRARARCHIVO_SMF(v_archivo);

    ut_trace.trace('Fin ldc_borecaudos.ProErrorArchivoRecaudo', 10);

  END ProErrorArchivoRecaudo;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_BORECAUDOS
  Descripcion    : PROCEDIMIENTO QUE SE ENCARGARA DE CREAR ORDEN DE TRABAJO
                   PROCESO ASCOCIADO A LA FORMA LDCGOC (Generacion de Ordenes a Contratistas)
                   ESTAS ORDENES SON PARA LAS ENTIDADES DE RECAUDO CONFIGURADAS EN LA FORMA LDCGOC
                   PARA LOS CONTRATISTAS

  Autor          : Jorge Valiente
  Fecha          : 16/09/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  04/12/2023		JSOTO			OSF-1890 Se elimina lógica del método PRGENERAORDE

  ******************************************************************/
  PROCEDURE PRGENERAORDE IS


  BEGIN

	NULL;

  END PRGENERAORDE;

END LDC_BORECAUDOS;
/

