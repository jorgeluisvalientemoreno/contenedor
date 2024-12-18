create or replace procedure adm_person.ldcdesendnotifi Is

/*******************************************************************************
Propiedad intelectual de PROYECTO GASES DEL CARIBE

  Autor         :ESANTIAGO (horbath)
  Fecha         :20-07-2019
  DESCRIPCION   :
  CASO          : 54

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  24/04/2024      Adrianavg           OSF-2597: Se migra del esquema OPEN al esquema ADM_PERSON
  *******************************************************************************/

 sbmensaje        VARCHAR2(2000);
 eerror           EXCEPTION;
  produc  ge_boInstanceControl.stysbValue;
  noti    ge_boInstanceControl.stysbValue;
  --mail  ge_boInstanceControl.stysbValue;

  us number;



  CURSOR cu_val (product number) IS
    SELECT count(*)
	FROM LDC_USER_NOTI
	WHERE PRODUCT_ID=product;


begin
    produc := ge_boinstancecontrol.fsbgetfieldvalue('LDC_USER_NOTI','PRODUCT_ID');
    noti := ge_boinstancecontrol.fsbgetfieldvalue('LDC_USER_NOTI','NOTIFICABLE');
	--mail := ge_boinstancecontrol.fsbgetfieldvalue('LDC_USER_NOTI','CORREO');


---------------- SE VALIDA QUE EL PRODUCTO TENGA PERIMISO-------------------

		OPEN cu_val (produc);

		  FETCH cu_val INTO us;
		  if US = 0 then
				sbmensaje := ' El producto '||produc|| 'no ha autorizado Notificacion por correo electronico: ';
				RAISE eerror;
		  end if;

		CLOSE cu_val;

		IF noti is null  THEN
		   sbmensaje := 'Selecione una opcion de notificacion' ||noti ;
			RAISE eerror;
		ELSE

			UPDATE LDC_USER_NOTI
			SET NOTIFICABLE = noti
			where PRODUCT_ID=produc;
			/*if mail is not null then
				UPDATE LDC_USER_NOTI
				SET CORREO = mail
				where PRODUCT_ID=produc;
			end if;*/
        COMMIT;
		END IF;



EXCEPTION
  WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('LDCDESENDNOTIFI '||sbmensaje||' '||SQLERRM, 11);
 WHEN OTHERS THEN
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
  ut_trace.trace('LDCDESENDNOTIFI '||' '||SQLERRM, 11);
end LDCDESENDNOTIFI;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDCDESENDNOTIFI
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCDESENDNOTIFI', 'ADM_PERSON'); 
END;
/