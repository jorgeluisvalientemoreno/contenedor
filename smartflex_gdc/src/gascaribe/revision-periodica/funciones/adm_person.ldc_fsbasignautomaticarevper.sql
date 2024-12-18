CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBASIGNAUTOMATICAREVPER" (sbin IN VARCHAR2) RETURN VARCHAR2 IS
/***********************************************
 MODIFICACIONES

 Fecha        autor      observacion
 23/12/2019   horbath    CA 147  se coloca log en la tabla LDC_LOGERRLEORRESU y se cambia flag de ldc_order
 02/10/2020   horbath    CA 530  se agraga nueva variable nuValeliBloq para evidar que se vuelva a marcar la solictud en la tabla LDC_BLOQ_LEGA_SOLICITUD
***************************************************/
CURSOR cudata IS
 SELECT column_value
   FROM TABLE(ldc_boutilities.splitstrings(sbin, '|'));
nuoperating_unit_id or_order.operating_unit_id%TYPE;
sbdatain        VARCHAR2(4000);
sbtrigger       VARCHAR2(4000);
sbcategoria     VARCHAR2(4000);
sborder_id      VARCHAR2(4000) := NULL;
sbpackage_id    VARCHAR2(4000) := NULL;
sbactivity_id   VARCHAR2(4000) := NULL;
subscription_id VARCHAR2(4000) := NULL;
onuerrorcode    NUMBER;
osberrormessage VARCHAR2(4000);
 --INICIO CA 147
  sbAplicaEnT147 VARCHAR2(1);--se almacena si entrega aplica o no la gasera
  nuExisJobRP number;
  sbEstaBlo VARCHAR2(1) := 'N';
  nuExisteBRPJ NUMBER;

  --se obtiene flag de bloqueo
  CURSOR cuGetBloqueo IS
  SELECT ORDEBLOQ
   FROM LDC_ORDER
  WHERE ORDER_ID= to_number(sborder_id);
 --FIN CA 147
 nuValeliBloq NUMBER:=0; --caso 530

BEGIN
 Ut_Trace.TRACE('INICIO LDC_BOASIGAUTO.fsbAsignaRP', 10);
 --OBTENER DATOS DE LA CADENA OBTENIDA DEL SERVICIO DE ASIGNACION
 FOR tempcudata IN cudata LOOP
  Ut_Trace.trace(tempcudata.column_value, 10);
  IF sborder_id IS NULL THEN
     sborder_id      := tempcudata.column_value;
     osberrormessage := osberrormessage || ' - ' || sborder_id;
  ELSIF sbpackage_id IS NULL THEN
      sbpackage_id    := tempcudata.column_value;
      osberrormessage := osberrormessage || ' - ' || sbpackage_id;
  ELSIF sbactivity_id IS NULL THEN
      sbactivity_id   := tempcudata.column_value;
      osberrormessage := osberrormessage || ' - ' || sbactivity_id;
  ELSIF subscription_id IS NULL THEN
      subscription_id := tempcudata.column_value;
      osberrormessage := osberrormessage || ' - ' || subscription_id;
  ELSIF sbtrigger IS NULL THEN
      sbtrigger       := tempcudata.column_value;
      osberrormessage := osberrormessage || ' - ' || sbtrigger;
  ELSIF sbcategoria IS NULL THEN
      sbcategoria     := tempcudata.column_value;
      osberrormessage := osberrormessage || ' - ' || sbcategoria;
  END IF;
 END LOOP;
 nuoperating_unit_id := ldc_fncretornaunidsolicitud(to_number(sbpackage_id));
 IF nuoperating_unit_id IS NOT NULL THEN
      -- inicio Asignar orden
  --INICIO CA 147
    IF FBLAPLICAENTREGAXCASO('0000147') THEN
      sbAplicaEnT147 := 'S';
      --Se valida si existe bloqueo en OUBYSOL
	  OPEN cuGetBloqueo;
	  FETCH cuGetBloqueo INTO sbEstaBlo;
	  IF cuGetBloqueo%NOTFOUND THEN
	    sbEstaBlo := 'N';
	  END IF;
	  CLOSE cuGetBloqueo;

	  IF sbEstaBlo = 'S' THEN
		  UPDATE LDC_ORDER SET ORDEBLOQ = 'N'
		  WHERE ORDER_ID= to_number(sborder_id);
	  END IF;
	  --existe bloqueo a nivelde job
	  select count(1) into nuExisteBRPJ
	  FROM LDC_BLOQ_LEGA_SOLICITUD
	  WHERE PACKAGE_ID_GENE = TO_NUMBER(sbpackage_id);

	  IF nuExisteBRPJ > 0 THEN
		  -- Inicio caso530
		  SELECT COUNT(1) INTO nuExisJobRP
			FROM LDC_ORDEASIGPROC p
			WHERE P.ORAOPROC  in (SELECT column_value
								  FROM TABLE(open.ldc_boutilities.splitstrings('PROCESOS_ASIGNACION_RP',',')))
			 AND P.ORAPORPA = to_number(sborder_id);
			 -- Fin caso530
		  IF nuExisJobRP = 0 THEN
			delete LDC_BLOQ_LEGA_SOLICITUD where PACKAGE_ID_GENE = TO_NUMBER(sbpackage_id);
			nuValeliBloq :=1;
		  END IF;
	  END IF;
    END IF;
  --FIN CA 147
  BEGIN
   os_assign_order(
                   to_number(sborder_id),
                   nuoperating_unit_id,
                   SYSDATE,
                   SYSDATE,
                   onuerrorcode,
                   osberrormessage
                   );
   IF onuerrorcode = 0 THEN
      ldc_boasigauto.prregsitroasigautolog(
                                           to_number(sbpackage_id),
                                           to_number(sborder_id),
                                           'LA ORDEN FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                           nuoperating_unit_id || ']'
                                          );

      ldc_boasigauto.printentosasignacion(to_number(sbpackage_id),
                                          to_number(sborder_id));
      UPDATE ldc_order
         SET asignado = 'S'
       WHERE nvl(package_id, 0) = nvl(to_number(sbpackage_id), 0)
         AND order_id = to_number(sborder_id);
   ELSE
     osberrormessage := 'LA ORDEN DE TRABAJO NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                 nuoperating_unit_id ||
                         '] - MENSAJE DE ERROR PROVENIENTE DE os_assign_order --> ' ||
                                 osberrormessage;
     ldc_boasigauto.prregsitroasigautolog(to_number(sbpackage_id),
                                          to_number(sborder_id),
                                          osberrormessage);
     ldc_boasigauto.printentosasignacion(to_number(sbpackage_id),
                                         to_number(sborder_id));
    --INICIO CA 147
    --Se registra log
    IF sbAplicaEnT147 = 'S' THEN
	  LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp('UOBYSOL', SYSDATE,sborder_id, NULL, osberrormessage,USER );
      IF nuExisteBRPJ > 0 and nuValeliBloq=1 THEN
	     INSERT INTO LDC_BLOQ_LEGA_SOLICITUD (PACKAGE_ID_GENE)
             VALUES(sbpackage_id);
	  END IF;
	  IF sbEstaBlo = 'S' THEN
		  UPDATE LDC_ORDER SET ORDEBLOQ = 'S'
		  WHERE ORDER_ID= to_number(sborder_id);
	  END IF;
	END IF;
    --FIN CA 147
   END IF;
  EXCEPTION
   WHEN OTHERS THEN
     sbdatain := 'INCONSISTENCIA EN SERVICIO FSBREVISIONPERIODICA [' ||
                  dbms_utility.format_error_stack || '] - [' ||
                  dbms_utility.format_error_backtrace || ']';
      ldc_boasigauto.prregsitroasigautolog(null,
                                           to_number(sborder_id),
                                           'EL SERVICIO os_assign_order NO PUDO ASIGNAR LA UNIDAD OPERATIVA A LA ORDEN [' ||
                                           sbdatain || ']');
      --INICIO CA 147
    --Se registra log
    IF sbAplicaEnT147 = 'S' THEN
      LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp('UOBYSOL', SYSDATE,sborder_id, NULL, sbdatain,USER );
      IF nuExisteBRPJ > 0 and nuValeliBloq=1  THEN
	     INSERT INTO LDC_BLOQ_LEGA_SOLICITUD (PACKAGE_ID_GENE)
             VALUES(sbpackage_id);
	  END IF;

	  IF sbEstaBlo = 'S' THEN
		  UPDATE LDC_ORDER SET ORDEBLOQ = 'N'
		  WHERE ORDER_ID= to_number(sborder_id);
	  END IF;
	END IF;
    --FIN CA 147
  END;
   -- Fin Asignar orden
 ELSE
   -- sino obtuvo la UT
   nuoperating_unit_id := -1;
 END IF;
 RETURN(to_char(nuoperating_unit_id));
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBASIGNAUTOMATICAREVPER', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_FSBASIGNAUTOMATICAREVPER TO REPORTES;
/
