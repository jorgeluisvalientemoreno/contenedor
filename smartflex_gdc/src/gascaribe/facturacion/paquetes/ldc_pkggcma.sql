create or replace PACKAGE LDC_PKGGCMA IS
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
   dtFechaProg DATE;

    FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-11-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-11-2024   OSF-3540    Creacion
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
   PROCEDURE PRJOBGENCUENCOBRAUTO;
   /**************************************************************************
      Autor       :  Horbath
      Proceso     : PRJOBGENCUENCOBRAUTO
      Fecha       : 2025-07-01
      Ticket      : OSF-3540
      Descripcion : Job que genera las cuentas de cobro de forma automaticamente

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
END LDC_PKGGCMA;
/
create or replace PACKAGE BODY LDC_PKGGCMA IS
  sbCadenaCone  VARCHAR2(100);
 sbUsuario      VARCHAR2(100);
 sbpassword     VARCHAR2(100);
 sbInstance     VARCHAR2(100);
 sbCadeScrip    VARCHAR2(500);
 sbdateformat   VARCHAR2(100);--se almacena formato de fecha
 nuConsecutivo  NUMBER := 0;
 nuIdReporte NUMBER;

  csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion          CONSTANT VARCHAR2(15) := 'OSF-3540';
  nuError             NUMBER;
  sbError             VARCHAR2(4000);

 sbCiclo VARCHAR2(4000) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_CICLEXPCA');


  NUMINUTOS           NUMBER := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_MINENTHILOS');
  sbPEFAFEGEP ge_boInstanceControl.stysbValue;


  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-11-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-11-2024   OSF-3540    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

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
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.PRJOBGENCARGAUTO';
    SBERROR      VARCHAR2(4000);
    nuerror      NUMBER;
    nuPais    NUMBER := PKG_BCLD_PARAMETER.fnuObtieneValorNumerico('CODIGO_PAIS');
    nuDiasRetraso  NUMBER := pkg_parametros.fnuGetValorNumerico('DIAS_RETRASO_FGCA');

    --se retorna periodo
    CURSOR cugetPeriodo IS
    SELECT pefacodi,
           pefafege,
           pefadesc,
		   pefacicl,
		   pefaano,
		   pefames,
		   to_char(ldc_boconsgenerales.fdtgetsysdate(), ldc_boconsgenerales.fsbgetformatofecha) fecha,
		   pefafimo,
		   pefaffmo
    FROM perifact P
    WHERE pefaactu = 'S'
     AND trunc(pefaffmo) = ( SELECT date_
                              FROM (
                                    SELECT date_  , rownum id_num
                                    FROM ge_calendar
                                    WHERE country_id = nuPais
                                     AND day_type_id = 1
                                     AND date_ > trunc(sysdate)
                                     ORDER BY date_)
                                WHERE id_num = nuDiasRetraso)
     AND pefacicl NOT IN (  SELECT to_number(regexp_substr(sbCiclo,  '[^,]+',   1, LEVEL)) AS CICLO
						  FROM dual
						  CONNECT BY regexp_substr(sbCiclo, '[^,]+', 1, LEVEL) IS NOT NULL		)
	  AND pkg_bcldcgcam.fnuValidaPrecedencia('FGCA',p.pefacodi,p.pefacicl) = 1
      AND NOT EXISTS ( SELECT 1
                       FROM PROCEJEC
                       WHERE PREJCOPE =P.pefacodi
                         and PREJPROG = 'FGCA')
      AND NOT EXISTS ( SELECT 1
                       FROM LDC_PERIPROG
                       WHERE PEPRPEFA = P.pefacodi AND PEPRFLAG = 'N'
                        AND PROCESO = 1);

     sbProceso  VARCHAR2(100) := 'PRJOBGENCARGAUTO'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

    PROCEDURE prInicializadatos IS
    BEGIN
          dtFechaProg := null;
          SBERROR := null;
		  nuError := 0;
    END prInicializadatos;

  BEGIN
   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
   -- Inicializamos el proceso
   pkg_estaproc.prinsertaestaproc( sbProceso , 0);

	--se realiza proceso de cadena de conexion
	IF sbCadeScrip IS NULL THEN
	  --se obtiene cadena de conexion
	  GE_BODATABASECONNECTION.GETCONNECTIONSTRING(sbUsuario, sbpassword, sbInstance);
	  sbCadenaCone  := sbUsuario || '/' || sbpassword || '@' || sbInstance;
	  sbCadeScrip   := FA_UIProcesosFact.FSBENCRIPTACADENA(sbCadenaCone);
	 END IF;

	 FOR regPeriodo IN cugetPeriodo LOOP
		 pkg_traza.trace(' CICLO ['||regPeriodo.PEFACICL||'] anio ['||regPeriodo.PEFAANO||' MES ['||regPeriodo.PEFAMES||'] FECHA ['||regPeriodo.FECHA||']', 10);
		 --se inicializan datos
		 prInicializadatos;
		 dtFechaProg := SYSDATE + (NUMINUTOS * (1/24/60));
		 --se programa FGCA
		 pkg_boldcgcam.PRCPROGFGCA(dtFechaProg, regPeriodo, sbCadeScrip, nuError, sbError );

		 IF nuError = 0 then
		     COMMIT;
		 ELSE
		    ROLLBACK;
		 END IF;
    END LOOP;

    pkg_estaproc.practualizaestaproc(isbproceso => sbProceso);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.GETERROR(nuerror,SBERROR);
      pkg_estaproc.practualizaestaproc( sbProceso, 'Error ', sbError  );
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
	  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      ROLLBACK;
    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.GETERROR(nuerror,SBERROR);
       pkg_estaproc.practualizaestaproc( sbProceso, 'Error ', sbError  );
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
	  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      ROLLBACK;
  END PRJOBGENCARGAUTO;

  PROCEDURE PRJOBGENCUENCOBRAUTO IS
  /**************************************************************************
      Autor       :  Horbath
      Proceso     : PRJOBGENCUENCOBRAUTO
      Fecha       : 2025-07-01
      Ticket      : OSF-3540
      Descripcion : Job que genera las cuentas de cobro de forma automaticamente

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
     --variabe para estaproc
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.PRJOBGENCUENCOBRAUTO';
    SBERROR      VARCHAR2(4000);
    nuerror      NUMBER;

    --se retorna periodo
    CURSOR cugetPeriodo IS
    SELECT pefacodi,
           pefafege,
           pefadesc,
		   pefacicl,
		   pefaano,
		   pefames,
		   to_char(ldc_boconsgenerales.fdtgetsysdate(), ldc_boconsgenerales.fsbgetformatofecha) fecha,
		   pefafimo,
		   pefaffmo
    FROM perifact P
    WHERE p.pefaactu = 'S'
      AND trunc(P.pefaffmo)  = trunc(sysdate)
      AND p.pefacicl NOT IN (  SELECT to_number(regexp_substr(sbCiclo,  '[^,]+',   1, LEVEL)) AS CICLO
						  FROM dual
						  CONNECT BY regexp_substr(sbCiclo, '[^,]+', 1, LEVEL) IS NOT NULL		)
      AND pkg_bcldcgcam.fnuValidaPrecedencia('FGCC',p.pefacodi,p.pefacicl) = 1
      AND NOT EXISTS ( SELECT 1
                       FROM PROCEJEC
                       WHERE PREJCOPE =P.pefacodi
                           AND PREJPROG = 'FGCC')
      AND NOT EXISTS (SELECT 1 FROM LDC_PERIPROG WHERE PEPRPEFA = P.pefacodi AND PEPRFLAG = 'N' and PROCESO = 2 );

     sbProceso  VARCHAR2(100) := 'PRJOBGENCUENCOBRAUTO'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

    PROCEDURE prInicializadatos IS
    BEGIN
          dtFechaProg := null;
          SBERROR := null;
		  nuError := 0;
    END prInicializadatos;

  BEGIN
   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
   -- Inicializamos el proceso
   pkg_estaproc.prinsertaestaproc( sbProceso , 0);

	--se realiza proceso de cadena de conexion
	IF sbCadeScrip IS NULL THEN
	  --se obtiene cadena de conexion
	  GE_BODATABASECONNECTION.GETCONNECTIONSTRING(sbUsuario, sbpassword, sbInstance);
	  sbCadenaCone  := sbUsuario || '/' || sbpassword || '@' || sbInstance;
	  sbCadeScrip   := FA_UIProcesosFact.FSBENCRIPTACADENA(sbCadenaCone);
	 END IF;

	 FOR regPeriodo IN cugetPeriodo LOOP
		 pkg_traza.trace(' CICLO ['||regPeriodo.PEFACICL||'] anio ['||regPeriodo.PEFAANO||' MES ['||regPeriodo.PEFAMES||'] FECHA ['||regPeriodo.FECHA||']', 10);
		 --se inicializan datos
		 prInicializadatos;
		 dtFechaProg := SYSDATE + (NUMINUTOS * (1/24/60));
		 --se programa FGCC
		 pkg_boldcgcam.PRCPROGFGCC(dtFechaProg, regPeriodo, sbCadeScrip, nuError, sbError );

		 IF nuError = 0 then
		     COMMIT;
		 ELSE
		    ROLLBACK;
		 END IF;
    END LOOP;

    pkg_estaproc.practualizaestaproc(isbproceso => sbProceso);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.GETERROR(nuerror,SBERROR);
      pkg_estaproc.practualizaestaproc( sbProceso, 'Error ', sbError  );
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
	  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      ROLLBACK;
    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.GETERROR(nuerror,SBERROR);
       pkg_estaproc.practualizaestaproc( sbProceso, 'Error ', sbError  );
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
	  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      ROLLBACK;
  END PRJOBGENCUENCOBRAUTO;

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
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.PRPROCOPYFACT';
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
   sbProceso  VARCHAR2(100) := 'PRPROCOPYFACT'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

  BEGIN
   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

   pkg_estaproc.prinsertaestaproc( sbProceso , 0);

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

      END IF;

    pkg_estaproc.practualizaestaproc(isbproceso => sbProceso);
   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.GETERROR(nuerror,SBERROR);
      pkg_estaproc.practualizaestaproc( sbProceso, 'Error ', SBERROR  );
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
	  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      ROLLBACK;
    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.GETERROR(nuerror,SBERROR);
      pkg_estaproc.practualizaestaproc( sbProceso, 'Error ', SBERROR  );
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
	  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
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
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.PRJOBNOTIPROCFACT';
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
      sbEmailNoti VARCHAR2(4000) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_EMAILNOLE');
      sb_subject        VARCHAR2(200);

       cursor cuEmails(sbEmail VARCHAR2, sbseparador VARCHAR2) is
        SELECT regexp_substr(sbEmail,  '[^'||sbseparador||']+',   1, LEVEL) AS correo
          FROM dual
          CONNECT BY regexp_substr(sbEmail, '[^'||sbseparador||']+', 1, LEVEL) IS NOT NULL;

        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
        sbProceso VARCHAR2(100) := 'PRJOBNOTIPROCFACT'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
    BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_estaproc.prinsertaestaproc( sbProceso , 0);

	  IF sbEmailNoti IS NOT NULL THEN
		 FOR reg IN cuGetPeriodosNoti LOOP

		   IF nuProcesoAnt <> reg.proceso THEN
			  IF nuProcesoAnt <> -1 THEN
				   BEGIN
					   FOR item IN cuEmails(sbEmailNoti, ',') LOOP

							pkg_Correo.prcEnviaCorreo
							(
								isbRemitente        =>  sbRemitente,
								isbDestinatarios    =>  TRIM(item.correo),
								isbAsunto           =>  'Ejecucion masivo del proceso ['||sbPrograma||'] dia ['||to_char(sysdate, 'dd/mm/yyyy hh24_mi_ss')||']',
								isbMensaje          =>  'Proceso ['||sbPrograma||'] termino correctamente para los ciclos ['||sbCiclos||']'
							);

					   END LOOP;
					   COMMIT;
				   EXCEPTION
					 WHEN OTHERS THEN
						pkg_error.setErrorMessage(nuerror,SBERROR);
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
							isbDestinatarios    =>  TRIM(item.correo),
							isbAsunto           =>  'Ejecucion masivo del proceso ['||sbPrograma||'] dia ['||to_char(sysdate, 'dd/mm/yyyy hh24_mi_ss')||']',
							isbMensaje          =>  'Proceso ['||sbPrograma||'] termino correctamente para los ciclos ['||sbCiclos||']'
						);

				   END LOOP;
				   COMMIT;
			   EXCEPTION
				 WHEN OTHERS THEN
					pkg_error.setErrorMessage(nuerror,SBERROR);
					ROLLBACK;
			   END;
		  END IF;
    	 END IF;

       pkg_estaproc.practualizaestaproc(isbproceso => sbProceso);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.GETERROR(nuerror,SBERROR);
        pkg_estaproc.practualizaestaproc( sbProceso, 'Error ', sbError  );
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        ROLLBACK;
      WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.GETERROR(nuerror,SBERROR);
         pkg_estaproc.practualizaestaproc( sbProceso, 'Error ', sbError  );
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        ROLLBACK;
    END PRJOBNOTIPROCFACT;
END LDC_PKGGCMA;
/