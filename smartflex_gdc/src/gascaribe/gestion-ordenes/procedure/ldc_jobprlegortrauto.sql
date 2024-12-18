CREATE OR REPLACE PROCEDURE LDC_JOBPRLEGORTRAUTO  IS
 /**************************************************************************
      Autor       : Elkin Alvarez / Horbath
      Fecha       : 2018-21-11
      Ticket      : 200-2134
      Descripcion : Job que legaliza ordenes de trabajo

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      20/10/2020   HT          CA 465 se realiza legalizacion de orden teniendo en cuenta nueva configuracion
                               de la forma LDCCONFTITRLEGA
      08/08/2021  JJJM         CA 592 Se modifica los cursor cuGetOrdenes agregandole el parametro de entrada : sbfestivo
                               para que se realice el calculo de los dias habiles para los campos dias de asignacion y
                               dias de creacion siempre y cuando el parametro sbfestivo sea igual a 'S',
                               para este calculo se utiliza la funci?n:pkholidaymgr.fnugetnumofdaynonholiday, en caso
                               de que el parametro : sbfestivo sea igual a 'N', se deja esl calculo tal cual como
                               estaba funcionando.
                               Se modifica el cursor : cuOrdenesLega para que en el WHERE donde hace refencia al campo :
                               > c.numedias, se realice tambien el calculo de los dias festivos, siempre y cuando el valoir
                               del campo: fladiafest sea igual a 'S', en caso contrario, se maneja la condicion
                               que tenia anteriormente.
	  08/11/2023   jeerazomvm	Caso OSF-1872:
								1. Se elimina la logica de fblaplicaentregaxcaso para el caso 0000592 y 0000465
								2. Se reemplaza el llamado de los siguientes métodos:
									2.1. os_legalizeorders por API_LEGALIZEORDERS
									2.2. dage_causal.FNUGETCLASS_CAUSAL_ID por pkg_bcordenes.fnuObtieneClaseCausal
									2.3. ldc_proinsertaestaprog por pkg_estaproc.prInsertaEstaproc
									2.4. ldc_proactualizaestaprog por pkg_estaproc.prActualizaEstaproc
***************************************************************************/
  
  sbEstadoOrde   	VARCHAR2(4000) := dald_parameter.fsbgetvalue_chain('LDC_ESTORDLEGA', NULL); --se almacenan estado de las ordenes
  sbproceso  		VARCHAR2(100) := 'LDC_JOBPRLEGORTRAUTO'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

  nusession 		NUMBER;         -- se almacena la session conectada
  sbuser    		VARCHAR2(4000); -- se almacena el usuario conectado
  sbErrorMessage  	VARCHAR2(4000);  --se almacena error
  sbErrorOrdenes  	VARCHAR2(4000);  --se almacena error

  nuCodError  		NUMBER; -- se almacena codigo de error
  sbdiashab  		ldc_conftitrlega.flagdiashab%TYPE;
  
  -- Constantes para el control de la traza
  csbSP_NAME 	CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
  cnuNVLTRC 	CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
  csbInicio   	CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;

  --INICIO CA 465
  CURSOR cuOrdenesLegaNue  IS
  SELECT *
  FROM  LDC_CONFTITRLEGA c;

  CURSOR cuGetOrdenes( nuTitr NUMBER,
                       nuDias NUMBER,
                       sbBusque VARCHAR2,
                       nuCausal NUMBER,
                       nuactividad NUMBER,
                       sbfestivo VARCHAR2/*CA592*/) IS
  SELECT *
  FROM (
        SELECT o.order_id orden,
               nuCausal  causal,
               decode(pkg_bcordenes.fnuObtieneClaseCausal(nuCausal), 1, 1, 0) tipo_causal,
               oa.ORDER_ACTIVITY_ID id_actividad,
      /*CA592*/decode(nvl(sbfestivo,'N'),'N',( SYSDATE - o.created_date ),pkholidaymgr.fnugetnumofdaynonholiday(o.created_date,SYSDATE)) difecrea,
      /*CA592*/decode(nvl(sbfestivo,'N'),'N',( SYSDATE - o.assigned_date ),pkholidaymgr.fnugetnumofdaynonholiday(o.assigned_date,SYSDATE)) difeasig
        FROM or_order o, or_order_activity oa
        WHERE o.order_id = oa.order_id
         AND o.task_type_id = nuTitr
         AND o.order_status_id in (SELECT trim(estado)
                                   FROM (
                                       SELECT DISTINCT 1 ID , regexp_substr(sbEstadoOrde ,'[^,]+', 1, LEVEL )  AS estado
                                        , LEVEL
                                       FROM dual A
                                       CONNECT BY regexp_substr(sbEstadoOrde, '[^,]+', 1, LEVEL)  IS NOT NULL
                                    ORDER BY ID, LEVEL))
          AND nvl( nuactividad, OA.ACTIVITY_ID ) = OA.ACTIVITY_ID)
    WHERE (CASE WHEN sbBusque = 'C' THEN
                difecrea
              ELSE
                difeasig
              END) > nuDias;

    sbCadenalega 	VARCHAR2(4000);
    nuIdReporte  	NUMBER;
    nuConsecutivo 	NUMBER := 0;
	
    FUNCTION fnuCrReportHeader
    return number
    IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuCrReportHeader';
	
        PRAGMA AUTONOMOUS_TRANSACTION;
        -- Variables
        rcRecord Reportes%rowtype;
    BEGIN
	
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
    --{
        -- Fill record
        rcRecord.REPOAPLI := 'LEGAJLOC';
        rcRecord.REPOFECH := sysdate;
        rcRecord.REPOUSER := ut_session.getTerminal;
        rcRecord.REPODESC := 'INCONSISTENCIAS JOB LEGALIZACIONES AUTOMATICAS' ;
        rcRecord.REPOSTEJ := null;
        rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');

        -- Insert record
        pktblReportes.insRecord(rcRecord);
		
        commit;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
        return rcRecord.Reponume;
    --}
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            Pkg_Error.SETERROR;
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END;
	
    PROCEDURE crReportDetail(
        inuIdReporte    in repoinco.reinrepo%type,
        inuProduct      in repoinco.reinval1%type,
        isbError        in repoinco.reinobse%type,
        isbTipo         in repoinco.reindes1%type
    )
    IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.crReportDetail';
	
         PRAGMA AUTONOMOUS_TRANSACTION;
        -- Variables
        rcRepoinco repoinco%rowtype;
    BEGIN
	
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuIdReporte: ' || inuIdReporte || chr(10) ||
						'inuProduct: ' 	 || inuProduct 	 || chr(10) ||
						'isbError: ' 	 || isbError 	 || chr(10) ||
						'isbTipo: ' 	 || isbTipo, cnuNVLTRC);
		
    --{
        rcRepoinco.reinrepo := inuIdReporte;
        rcRepoinco.reinval1 := inuProduct;
        rcRepoinco.reindes1 := isbTipo;
        rcRepoinco.reinobse := isbError;
        rcRepoinco.reincodi := nuConsecutivo;

        -- Insert record
        pktblRepoinco.insrecord(rcRepoinco);

        commit;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            Pkg_Error.SETERROR;
            RAISE Pkg_Error.CONTROLLED_ERROR;
    --}
    END;
  --FIN CA 465

BEGIN

	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, csbInicio);

	pkg_estaproc.prinsertaestaproc( sbproceso , 1);	
   
	nuIdReporte := fnuCrReportHeader;
		
	FOR reg IN cuOrdenesLegaNue LOOP
		sbdiashab := reg.flagdiashab; 
 
			
		FOR REorde IN  cuGetOrdenes(REG.TASK_TYPE_ID, REG.NUMEDIAS, REG.FLINTIFE, REG.CAUSAL_ID, REG.ACTIVIDAD,sbdiashab) LOOP
			nuCodError := 0;
			
			if reg.ITEM_LEGA is not null then
				sbCadenalega := REorde.orden||'|'||REorde.causal||'|'||reg.PERSON_ID||'||'||REorde.id_actividad||'>'||REorde.tipo_causal||';;;;|'||reg.ITEM_LEGA||'>1>Y||1277;Orden Legalizada por proceso LDC_JOBPRLEGORTRAUTO';
				
				pkg_traza.trace('sbCadenalega: ' || sbCadenalega, cnuNVLTRC);
			else
				sbCadenalega := REorde.orden||'|'||REorde.causal||'|'||reg.PERSON_ID||'||'||REorde.id_actividad||'>'||REorde.tipo_causal||';;;;|||1277;Orden Legalizada por proceso LDC_JOBPRLEGORTRAUTO';
				
				pkg_traza.trace('sbCadenalega: ' || sbCadenalega, cnuNVLTRC);
			end if;
			
			pkg_traza.trace('Legalizando la orden: ' || REorde.orden, cnuNVLTRC);
			  
			-- se procede a legalizar la orden de trabajo
			api_legalizeOrders(sbCadenalega, 
							   SYSDATE, 
							   SYSDATE, 
							   null, 
							   nuCodError, 
							   sbErrorMessage 
							   );
		  
			IF  nuCodError <> 0 THEN
				pkg_traza.trace('Error legalizando la orden: ' || REorde.orden, cnuNVLTRC);
				pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, cnuNVLTRC);
				
				sbErrorOrdenes := substr(sbErrorOrdenes ||' Orden '||REorde.orden||' con error '||sbErrorMessage, 0, 3999);
				ROLLBACK;
				nuConsecutivo := nuConsecutivo +1;
				crReportDetail(nuIdReporte,REorde.orden,sbErrorMessage, 'S');
			ELSE
				COMMIT;
			END IF;
				
		END LOOP;
			
	END LOOP;
   
	pkg_estaproc.practualizaestaproc(sbproceso, 'Termino', sbErrorMessage);
	
	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

EXCEPTION
	WHEN OTHERS THEN
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		ROLLBACK;
		pkg_error.seterror;
		pkg_error.geterror(nuCodError, sbErrorMessage);
		pkg_estaproc.practualizaestaproc(sbproceso, 'Error', 'Error '||sbErrorMessage);

END LDC_JOBPRLEGORTRAUTO ;
/