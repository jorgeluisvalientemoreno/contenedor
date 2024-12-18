create or replace TRIGGER ADM_PERSON.LDC_TRGGENORDVALDOC
AFTER UPDATE OF STATUS_CERTIFICADO ON LDC_CERTIFICADOS_OIA FOR EACH ROW  
  
/*******************************************************************************
    Metodo:       LDC_TRGGENORDVALDOC
    Descripcion:  TRIGGER el cual se ejecutará cuando se Actualice un  registro en campo ¿STATUS_CERTIFICADO¿ en la tabla ¿LDC_CERTIFICADOS_OIA¿, 
	              se validara que el campo ¿STATUS_CERTIFICADO¿ tenga un valor de los configurado en el parámetro ¿STATUS_CERT¿ , LUEGO Se validara 
				  que el campo ¿RESULTADO_INSPECCION¿ tenga un valor de los configurado en el parámetro ¿RESULTADO_INS¿ y validar si la entrega 
				  aplica para la gasera, si es correcto esto se insertara un nuevo registro en la tabla ¿LDC_GENORDVALDOCU¿ , así será el ¿insert¿ 
				  a la tabla.

    Autor:  HORBATH
	caso:   371
    Fecha:  24/07/2020

    Historia de Modificaciones
    FECHA        AUTOR                       DESCRIPCION
    30/09/2922   dsaltarin          PE-321: Se modifica para que no tenga en cuenta para pago las observaciones que contengan el mensaje del parametro
                                            MSJ_APROBACION_AUTOMATICA
*******************************************************************************/
DECLARE
    -- Se lanzara despues de cada fila actualizada
    -- CURSOR QUE DEVUELVE EL VALOR STRING DE UN PARAMETRO QUE ESTE EN LA TABLA ldc_pararepe
   CURSOR cuvstparam (idp ldc_pararepe.parecodi%TYPE) is
	SELECT paravast 
   FROM ldc_pararepe 
   WHERE parecodi=idp;

	CURSOR cu_Parameter(inuvalor    NUMBER, sbvp ldc_pararepe.paravast%TYPE) IS
    SELECT COUNT(1) CANTIDAD
      FROM DUAL
     WHERE inuvalor IN (select to_number(column_value) from table(ldc_boutilities.splitstrings(sbvp,',')));
    
   Cursor cust_parameter(sbvalor varchar2,sbvp ldc_pararepe.paravast%TYPE) IS
    select 1 
    from table(ldc_boutilities.splitstrings(sbvp,',')) 
    where column_value=sbvalor;

	nuexistParameter    number;
   vpstparam ldc_pararepe.paravast%type;

   sbMsjeNoPago   ldc_pararepe.paravast%type:=DALDC_PARAREPE.fsbGetPARAVAST('MSJ_APROBACION_AUTOMATICA', null);


BEGIN
--  dbms_output.put_line('trg entro a trigger');
   IF fblaplicaentregaxcaso('0000371') and nvl(:new.STATUS_CERTIFICADO,'I')!=nvl(:old.STATUS_CERTIFICADO,'I') and :new.obser_rechazo not like '%'||sbMsjeNoPago||'%' then
      --  dbms_output.put_line('trg entrega si es valida');
        -- aqui se valida si el nuevo estado del certificado está en el parametro STATUS_CERT
		OPEN cuvstparam('STATUS_CERT');
		FETCH cuvstparam INTO vpstparam;
     --   dbms_output.put_line('trg el parametro STATUS_CERT tiene valor='||vpstparam);
		IF cuvstparam%notfound THEN
		   RAISE EX.CONTROLLED_ERROR;
		END IF;
		close cuvstparam;
     --   dbms_output.put_line('trg el valor de :new.status_certificado es '||to_char(:new.STATUS_CERTIFICADO));
        nuexistparameter:=0;
		OPEN cust_Parameter(:new.STATUS_CERTIFICADO, vpstparam);
        FETCH cust_Parameter INTO nuexistparameter;
        IF cust_Parameter%NOTFOUND THEN
         --  dbms_output.put_line('trg no esta en el parametro');
           nuExistParameter := 0;
        END IF;
        CLOSE cuST_Parameter;

        if nuExistParameter>0 then -- el valor de nuevo estado (.new.STATUS_CERTIFICADO esta en el parametro STATUS_CERT
		   -- aqui se valida si el valor del campo RESULTADO_INSPECCION esta en el parametro RESULTADO_INS
       --    dbms_output.put_line('trg si esta en el parametro');
		   open cuvstparam('RESULTADO_INS');
		   fetch cuvstparam into vpstparam;
		   if cuvstparam%notfound then 
		      RAISE EX.CONTROLLED_ERROR;
		   end if;
		   close cuvstparam;
       --    dbms_output.put_line('trg el parametro RESULTADO_INS tiene valor='||vpstparam);
		   OPEN cu_Parameter(:new.RESULTADO_INSPECCION, vpstparam);
           FETCH cu_Parameter INTO nuExistParameter;
           IF cu_Parameter%NOTFOUND THEN
              nuExistParameter := 0;
           END IF;
           CLOSE cu_Parameter;
        --   dbms_output.put_line('trg el valor de :new.RESULTADO_INSPECCION es '||to_char(:new.RESULTADO_INSPECCION));
           IF nuExistParameter>0 THEN -- EL VALOR DEL CAMPO RESULTADO_INSPECCION ESTA EN EL PARAMETRO RESULTADO_INS
          --    dbms_output.put_line('trg SI ESTA Y VA A INSERTA EN TABLA');
		      -- INSERTA EN LA TABLA LDC_GENORDVALDOCU
		      INSERT INTO OPEN.LDC_GENORDVALDOCU (CERTIFICADOS_OIA_ID,OBSERVACION,ESTADO) VALUES(:NEW.CERTIFICADOS_OIA_ID,NULL,'P');
		   END IF;
		 end if;   
   END IF;
EXCEPTION
   WHEN EX.CONTROLLED_ERROR THEN
	 raise;
   WHEN OTHERS THEN
	 ERRORS.SETERROR;
   RAISE EX.CONTROLLED_ERROR;

END LDC_TRGGENORDVALDOC;
/