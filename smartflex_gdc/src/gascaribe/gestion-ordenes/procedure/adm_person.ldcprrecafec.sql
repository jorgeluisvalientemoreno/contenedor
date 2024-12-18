create or replace procedure ADM_PERSON.LDCPRRECAFEC Is
/*******************************************************************************
Propiedad intelectual de PROYECTO GASES DEL CARIBE

  Autor         :ESANTIAGO (horbath)
  Fecha         :13-06-2019
  DESCRIPCION   :PROCEDIMIENTO PARA REGISTRA EL CAMBIO DE FECHA EN LA TABLA 'LDC_CAMFEC' UTILIZADO EN LA FORMA 'LDCRECAFEC'
  CASO          : 200-2538

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  24/04/2024       PACOSTA            OSF-2596: Se crea el objeto en el esquema adm_person  
  23/06/2022       LJLB CA OSF-368    correccion de validacion de fechas de ejecucion   
  *******************************************************************************/

 sbmensaje        VARCHAR2(2000);
 eerror           EXCEPTION;
 
 f_reg  ge_boInstanceControl.stysbValue;
 f_ejec ge_boInstanceControl.stysbValue;
 orden  ge_boInstanceControl.stysbValue;
 obs    ge_boInstanceControl.stysbValue;

  sbFechaInicialEjec        ge_boInstanceControl.stysbValue;
  dtFechaInicialEjec        DATE;

  tipo_t  OR_ORDER.TASK_TYPE_ID%type ;
  per_c   GE_PERSON.USER_ID%type ;
  us number;

  CURSOR cu_valuser (usua number, tipo number) IS
  SELECT count(*)
	FROM LDC_USERCAFEC
	where USUARIO = usua
    and permiso='REGISTRAR'
    and TASK_TYPE_ID = tipo;

  CURSOR cuExisteOrden IS
  SELECT order_status_id, EXEC_INITIAL_DATE, EXECUTION_FINAL_DATE, task_type_id
  FROM or_order
  WHERE order_id = to_number(orden);

  nuEstadoOrde NUMBER;
  dtFechaIniOrde DATE;
  dtFechaFinOrde DATE;

begin
  f_ejec := ge_boinstancecontrol.fsbgetfieldvalue('LDC_CAMFEC','FEC_EJEC');
  f_reg := ge_boinstancecontrol.fsbgetfieldvalue('LDC_CAMFEC','FEC_REG');
  orden := ge_boinstancecontrol.fsbgetfieldvalue('LDC_CAMFEC','ORDER_ID');
  obs := ge_boinstancecontrol.fsbgetfieldvalue('LDC_CAMFEC','OBSERVACION');
  sbFechaInicialEjec := ge_boinstancecontrol.fsbgetfieldvalue('LDC_CAMFEC','FEC_INI_EJEC');

	dtFechaInicialEjec := TO_DATE(sbFechaInicialEjec);

  per_c := dage_person.fnugetuser_id(GE_BOPERSONAL.FNUGETPERSONID());

	IF f_ejec > SYSDATE OR f_reg > SYSDATE OR dtFechaInicialEjec > SYSDATE THEN
    sbmensaje := 'Las fechas no deben ser mayores que el dia actual';
    RAISE eerror;
	END IF;

  IF f_reg IS NULL AND f_ejec IS NULL AND dtFechaInicialEjec IS NULL THEN
	    sbmensaje := 'Al menos uno de estos campos debe estar diligenciados
						         fecha de registro y fecha de ejecucion ';
       RAISE eerror;
  END IF;

  IF f_ejec IS NOT NULL AND dtFechaInicialEjec IS NOT NULL THEN
      IF dtFechaInicialEjec > f_ejec THEN
          sbmensaje := 'La fecha inicial de ejecucion debe ser menor o igual a la fecha final de ejecucion. Favor validar.';
          RAISE eerror;
      END IF;
  END IF;
  
  OPEN cuExisteOrden;
  FETCH cuExisteOrden INTO nuEstadoOrde, dtFechaIniOrde, dtFechaFinOrde, tipo_t ;
  CLOSE cuExisteOrden;

  IF nuEstadoOrde IS NULL THEN
      sbmensaje := 'La orden de trabajo no existe';
      RAISE eerror;
  END IF;

  IF nuEstadoOrde <> 8 THEN 
      sbmensaje := 'La orden de trabajo no se encuentra cerrada';
      RAISE eerror;
  ELSIF f_ejec IS NOT NULL AND dtFechaInicialEjec IS NULL THEN
      IF f_ejec < dtFechaIniOrde THEN
          sbmensaje := 'La fecha final de ejecucion debe ser mayor o igual a la fecha inicial de ejecucion. Favor validar.';
          RAISE eerror;
      END IF;
  ELSIF  dtFechaInicialEjec IS NOT NULL AND f_ejec IS NULL THEN
      IF dtFechaInicialEjec > dtFechaFinOrde THEN
          sbmensaje := 'La fecha inicial de ejecucion debe ser menor o igual a la fecha final de ejecucion. Favor validar.';
          RAISE eerror;
      END IF;
  END IF;
  ---------------- SE VALIDA QUE EL USUARIO TENGA PERIMISO-------------------
 	OPEN cu_valuser (per_c, tipo_t);
  FETCH cu_valuser INTO us;
  CLOSE cu_valuser;
  
  if US = 0 then
    sbmensaje := 'Usuario no autorizado para modificar ordenes de este tipo de trabajo: '||tipo_t;
    RAISE eerror;
  end if;

  INSERT INTO LDC_CAMFEC (CAMFECRE_ID, FEC_EJEC,FEC_REG,FEC_PROCE,ORDER_ID,OBSERVACION,USER_RE,ESTADO,FEC_INI_EJEC)
    		VALUES (seq_camfec.nextval, f_ejec,f_reg,sysdate,orden,obs,per_c,'P',dtFechaInicialEjec);
  commit;

EXCEPTION
  WHEN eerror THEN
    rollback;
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
    ut_trace.trace('LDCPRRECAFEC '||sbmensaje||' '||SQLERRM, 11);
 WHEN OTHERS THEN
    rollback;
    errors.seterror;
    ut_trace.trace('LDCPRRECAFEC '||' '||SQLERRM, 11);
    raise ex.controlled_error;   
end ldcprrecafec;
/
PROMPT Otorgando permisos de ejecucion a LDCPRRECAFEC
BEGIN
    pkg_utilidades.praplicarpermisos('LDCPRRECAFEC', 'ADM_PERSON');
END;
/