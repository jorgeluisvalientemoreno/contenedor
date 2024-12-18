create or replace PACKAGE      adm_person.LDC_PKG_CAMFEC IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    25/06/2024              PAcosta         OSF-2878: Cambio de esquema ADM_PERSON                              
    ****************************************************************/ 

    FUNCTION FUNCGETPBMULCAFEC RETURN constants.tyrefcursor;
   /**************************************************************************
		Autor       : Ernesto Santiago / Horbath
		Fecha       : 2019-06-11
		Ticket      : 200-2538
		Proceso     : FUNCGETPBMULCAFEC
		Descripcion : Funci?n para obtener el conjunto de registros para la forma LDCPBCAMFEC

  	HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

    procedure PROCMULTCAFEC(isbcodigo    In Varchar2,
                                          inucurrent   In Number,
                                          inutotal     In Number,
                                          onuerrorcode Out ge_error_log.message_id%Type,
                                          osberrormess Out ge_error_log.description%Type);
   /**************************************************************************
		Autor       : Ernesto Santiago / Horbath
		Fecha       : 2019-06-11
		Ticket      : 200-2538
		Proceso     : PRGENNOTACOMP
		Descripcion : procedimiento que se encarga de realizar el cambo de fecha de las ordenes

		HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
END LDC_PKG_CAMFEC;
/
create or replace PACKAGE BODY      adm_person.LDC_PKG_CAMFEC IS

FUNCTION FUNCGETPBMULCAFEC RETURN constants.tyrefcursor Is
   /**************************************************************************
    Autor       : Ernesto Santiago / Horbath
    Fecha       : 2019-06-11
    Ticket      : 200-2538
    Proceso     : FUNCGETPBMULCAFEC
    Descripcion : Funci?n para obtener el conjunto de registros para la forma LDCPBCAMFEC
   HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION    
    23/06/2022   LJLB        CA OSF-368 se ajusta proceso para solo mostrar los tipo de trabajos 
                             asociados al usuario que esta conectado
   ***************************************************************************/

 sbmensaje        VARCHAR2(2000);
 eerror           EXCEPTION;
 rfresult constants.tyrefcursor;

sbsqlmaestro   ge_boutilities.stystatement; -- se almacena la consulta

sbsqlfiltro   ge_boutilities.stystatement; -- se almacena la filtro

sbdttra  OR_TASK_TYPE.TASK_TYPE_ID%type; --se alamacena el tipo de trebajo
sbfec    ge_boInstanceControl.stysbValue;--LDC_CAMFEC.FEC_PROCE%type; --se almacena la fecha
sbfefin    ge_boInstanceControl.stysbValue;
per_c   GE_PERSON.USER_ID%type;
us number;
val number(1):= 0;
ttrabajos varchar(200);


  CURSOR cu_valuser (usua number, tipo number) IS
  SELECT count(*)
	FROM LDC_USERCAFEC
	where USUARIO = usua
	 and permiso='APROBAR'
	 and TASK_TYPE_ID = tipo;

  CURSOR cu_todos (usua number) IS
  SELECT TASK_TYPE_ID
	FROM LDC_USERCAFEC
	where USUARIO = usua
	 and permiso='APROBAR';

begin
   sbsqlfiltro := 'WHERE R.ORDER_ID=O.ORDER_ID AND ESTADO=''P'' ';
   --se obtienen los datos

   sbdttra := ge_boinstancecontrol.fsbgetfieldvalue('LDC_USERCAFEC', 'TASK_TYPE_ID');
   sbfec := ge_boinstancecontrol.fsbgetfieldvalue('LDC_CAMFEC', 'FEC_PROCE');-- FECHA INICIAL
   sbfefin := ge_boinstancecontrol.fsbgetfieldvalue('LDC_CAMFEC', 'FEC_EJEC');-- FECHA FINAL
   per_c  := dage_person.fnugetuser_id(GE_BOPERSONAL.FNUGETPERSONID());
   
   ut_trace.trace('sbdttra ' || sbdttra ||' per_c '||per_c||' sbfefin '||sbfefin||' sbfec '||sbfec,10);
   if sbfec is null and sbfefin is not null then
      sbmensaje := 'la fecha inicial esta vacia.';
      RAISE eerror;
   end if;

   if sbfec is not null and sbfefin is null then
      sbmensaje := 'la fecha final esta vacia.';
      RAISE eerror;
   end if;

   if TO_DATE(sbfec, 'DD/MM/YYYY HH24:MI:SS')   > TO_DATE (sbfefin, 'DD/MM/YYYY HH24:MI:SS')  then
      sbmensaje := 'la fecha inicial es mayor que la final.';
      RAISE eerror;
   end if;

  
 -- validar usuario
	 if sbdttra = '-1' or sbdttra is null then
		 OPEN cu_todos (per_c);
       LOOP
			  FETCH cu_todos INTO us;					  
			    EXIT WHEN cu_todos%NOTFOUND;
          IF ttrabajos IS NULL THEN
             ttrabajos := us;
          ELSE
             ttrabajos := ttrabajos||','||us;
           END IF;               
			 END LOOP;
			CLOSE cu_todos;
      
       ut_trace.trace('ttrabajos ' || ttrabajos ,10);
			val:=1;
			if(ttrabajos is null) then
				 sbsqlmaestro :='select * from LDC_CAMFEC
										  where ORDER_ID=null ';
				 val:=0;
			end if;

     else --------------------------------------------------------

        OPEN cu_valuser (per_c,sbdttra);
            FETCH cu_valuser INTO us;
            if us=0 then
                sbsqlmaestro :='select * from LDC_CAMFEC
                        where ORDER_ID=null ';
            else
                  val:=1;
            end if;
        CLOSE cu_valuser;
	 end if;

  --filtros
  IF val =1 THEN
	   IF sbfec = '-1' or sbfec is null THEN
        IF sbdttra IS NOT NULL and  sbdttra <> '-1' THEN
              sbsqlfiltro := sbsqlfiltro||' AND O.TASK_TYPE_ID = '||sbdttra;
        elsif(sbdttra IS NULL OR  sbdttra = '-1')then
                sbsqlfiltro := sbsqlfiltro||' AND O.TASK_TYPE_ID in ('||ttrabajos||')';
        END IF;
	   ELSE
        IF sbfec IS NOT NULL AND sbfefin IS NOT NULL THEN
              sbsqlfiltro := sbsqlfiltro||' AND trunc(FEC_PROCE) between
                              trunc(TO_DATE('''||sbfec||''', ''DD/MM/YYYY HH24:MI:SS''))
                              AND trunc(TO_DATE('''||sbfefin||''', ''DD/MM/YYYY HH24:MI:SS'')) ';
          IF sbdttra IS NOT NULL and  sbdttra <> '-1' THEN
              sbsqlfiltro := sbsqlfiltro||' AND O.TASK_TYPE_ID = '||sbdttra;
          elsif(sbdttra IS NULL or  sbdttra = '-1')then
              sbsqlfiltro := sbsqlfiltro||' AND O.TASK_TYPE_ID in ('||ttrabajos||')';
          END IF;
        END IF;
	  END IF;
    
     ut_trace.trace('sbsqlfiltro ' || sbsqlfiltro,10);
    --consulta
    sbsqlmaestro :='select R.CAMFECRE_ID CODIGO,FEC_PROCE FECHA_PROCESO, R.FEC_REG FECHA_REGISTRO,
                    FEC_INI_EJEC FECHA_INICIAL_EJECUCION, FEC_EJEC FECHA_FIN_EJECUCION, R.OBSERVACION OBSERVACION,R.ORDER_ID ORDEN,R.USER_RE USUARIO_REGISTRO,R.ESTADO

                      from LDC_CAMFEC R, OR_ORDER O '||sbsqlfiltro;
       ut_trace.trace('sbsqlmaestro ' || sbsqlmaestro,10);
  END IF;



  Open rfresult For sbsqlmaestro;
  Return rfresult;

Exception
    WHEN eerror THEN
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
       ut_trace.trace('FUNCGETPBMULCAFEC '||sbmensaje||' '||SQLERRM, 11);
    When ex.controlled_error THEN
         Raise;
    When Others THEN
      errors.seterror;
      Raise ex.controlled_error;
end FUNCGETPBMULCAFEC;

procedure PROCMULTCAFEC(isbcodigo    In Varchar2,
                        inucurrent   In Number,
                        inutotal     In Number,
                        onuerrorcode Out ge_error_log.message_id%Type,
                        osberrormess Out ge_error_log.description%Type) Is


/**************************************************************************
		Autor       : Ernesto Santiago / Horbath
		Fecha       : 2019-06-11
		Ticket      : 200-2538
		Proceso     : PRGENNOTACOMP
		Descripcion : procedimiento que se encarga de realizar el cambo de fecha de las ordenes



		HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION

    09/11/2021  DSALTARIN   CAMBIO 895: Se cambia el orden, primero debe actualizar la fecha incial de ejecucion
                            luego la fecha final de ejecucion
    23/06/2022   LJLB       CA OSF-368 se ajusta proceso para quitar validacion de fecha de ejecucion
   ***************************************************************************/
  sbFlag VARCHAR2(2);
  codigo number;
  f_reg  LDC_CAMFEC.FEC_REG%type;
  f_ejec LDC_CAMFEC.FEC_EJEC%type;
  a_reda LDC_CAMFEC.REGISTER_DATE%type;
  a_crda LDC_CAMFEC.CREATED_DATE%type;
  a_icfe LDC_CAMFEC.ICRTFECH%type;
  a_inre LDC_CAMFEC.INIT_REGISTER_DATE%type;
  a_more LDC_CAMFEC.MOTIV_RECORDING_DATE%type;

  orden LDC_CAMFEC.ORDER_ID%type:=0;
  a_ejec or_order.EXEC_INITIAL_DATE%type;
  pkg    or_order_activity.PACKAGE_ID%type;
  per_c   GE_PERSON.USER_ID%type;

   dtFechaIniEjecucion       LDC_CAMFEC.fec_ini_ejec%type;
  dtFechaIniEjecAnt         OR_order.exec_initial_date%type;
  dtFechaFinEjecAnt         OR_order.execution_final_date%type;

  CURSOR cugetValidaFechaIniEje IS
  select EXEC_INITIAL_DATE, 
         execution_final_date
  from  or_order
	where ORDER_ID= orden;


  CURSOR cu_reg (cod number) IS
	select FEC_REG,
           FEC_EJEC,
           ORDER_ID,
           FEC_INI_EJEC
	from LDC_CAMFEC
	where CAMFECRE_ID=cod;

  CURSOR cu_valcam (ord number) IS
  select o.CREATED_DATE, 
           a.REGISTER_DATE,
           icrtfech,
           m.init_register_date,
           mo.motiv_recording_date,
           a.PACKAGE_ID
  from  or_order o,or_order_activity a,ldc_imcorete i,mo_packages m, mo_motive mo
  where o.ORDER_ID=a.ORDER_ID
    and i.ICRTORDE (+)=o.ORDER_ID
    and a.PACKAGE_ID = m.PACKAGE_ID(+)
    and a.PACKAGE_ID = mo.PACKAGE_ID(+)
    and o.ORDER_ID=ord;

begin

  per_c  := dage_person.fnugetuser_id(GE_BOPERSONAL.FNUGETPERSONID());

  codigo := to_number(isbcodigo) ;
	
  OPEN cu_reg (codigo);
  FETCH cu_reg INTO f_reg, f_ejec, orden, dtFechaIniEjecucion;
	CLOSE cu_reg;

	IF f_reg is not null THEN

    OPEN cu_valcam (orden);   
    FETCH cu_valcam INTO a_crda, a_reda, a_icfe, a_inre, a_more, pkg;
    CLOSE cu_valcam;


    if a_crda is not null then
        UPDATE or_order
          SET created_date = f_reg
        WHERE ORDER_ID = orden;
    end if;

    if a_reda is not null then
        UPDATE or_order_activity
          SET register_date = f_reg
        WHERE ORDER_ID = orden;
    end if;

    if a_icfe is not null then
        UPDATE ldc_imcorete
          SET icrtfech = f_reg
        WHERE ICRTORDE = orden;
    end if;

    if a_inre is not null then
        UPDATE mo_packages
          SET  init_register_date = f_reg, 
               request_date = f_reg,
               messag_delivery_date = f_reg
        WHERE PACKAGE_ID = pkg;
    end if;

    if a_more is not null then
        UPDATE mo_motive
          SET motiv_recording_date = f_reg
        WHERE PACKAGE_ID = pkg;
    end if;

  END IF;
  
  OPEN cugetValidaFechaIniEje;
  FETCH cugetValidaFechaIniEje INTO a_ejec, dtFechaFinEjecAnt;
  CLOSE cugetValidaFechaIniEje;

  IF dtFechaIniEjecucion IS NOT NULL 
      AND dtFechaFinEjecAnt IS NOT NULL 
      AND  dtFechaIniEjecucion <= dtFechaFinEjecAnt  THEN
     daor_order.updexec_initial_date(orden, dtFechaIniEjecucion);
  END IF;

	IF f_ejec is not null THEN	    
    IF a_ejec IS NOT NULL AND a_ejec <= f_ejec  THEN
      	UPDATE or_order
			   SET execution_final_date = f_ejec
			  WHERE ORDER_ID = orden;   
		END IF;
	END IF;


   UPDATE LDC_CAMFEC SET FEC_EJEC_ANT = dtFechaFinEjecAnt,
                          REGISTER_DATE = a_reda ,
                          CREATED_DATE =  a_crda ,
                          ICRTFECH = a_icfe,
                          INIT_REGISTER_DATE = a_inre,
                          MOTIV_RECORDING_DATE =a_more,
                          USER_AP = per_c,
                          FEC_APRO= sysdate,
                          ESTADO='A',
                          FEC_INI_EJEC_ANT = dtFechaIniEjecAnt
   WHERE CAMFECRE_ID = codigo;
  
   commit;

Exception
  When ex.controlled_error THEN
      rollback;
      Raise ex.controlled_error;
  When Others THEN
      rollback;
      errors.seterror;
      Raise ex.controlled_error;
end PROCMULTCAFEC;

END ldc_pkg_camfec;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKG_CAMFEC
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKG_CAMFEC', 'ADM_PERSON');
END;
/