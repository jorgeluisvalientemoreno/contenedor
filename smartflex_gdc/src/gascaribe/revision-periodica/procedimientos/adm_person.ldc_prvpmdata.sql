CREATE OR REPLACE procedure adm_person.LDC_PRVPMDATA(producto in LDC_VPM.PRODUCT_ID%type,
                                          serial   in LDC_VPM.EMSSCOEM%type,
                                          fecha    in date) is
  /*******************************************************************************
  Propiedad intelectual Horbath.

  Autor         :DVALIENTE (horbath)
  Fecha         :07-12-2020
  DESCRIPCION   :Insertar o actualizar información con relación al cambio de medidor y establecer nuevas fechas para última verificación y proxima verificación.
  CASO          :132

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  09/05/2024      Paola Acosta        OSF-2672: Cambio de esquema ADM_PERSON 
  *******************************************************************************/
  
  nu_numreg   number := 0;
  nu_meses    number := dald_parameter.fnuGetNumeric_Value('MESESVPM', NULL);
  dt_nextdate date;
begin

		/*Logica: Se realizara una busqueda del producto en la entidad LDC_VPM.
		Si el producto NO existe sera agregado a la entidad (Producto, Serial, Fecha ultima verificacion, Fecha proxima verificacion con el incremento del parametro MESESVPM
		Si el producto existe se actualizara informacion (Serial, Fecha ultima verificacion, Fecha proxima verificacion con el incremento del parametro MESESVPM)*/
		--calculo la proxima fecha de verificacion
		SELECT ADD_MONTHS(fecha, nu_meses) into dt_nextdate FROM DUAL;
		--calculo el numero de registro existentes del producto
		select count(*)
		  into nu_numreg
		  from ldc_vpm l
		 where l.product_id = producto;
		if nu_numreg = 0 then
		  --registro el producto
		  insert into ldc_vpm
			(product_id, emsscoem, fecha_vpm, fecha_proxima_vpm)
		  values
			(producto, serial, fecha, dt_nextdate);
		else
		  --actualizo el producto
		  update ldc_vpm
			 set emsscoem          = serial,
				 fecha_vpm         = fecha,
				 fecha_proxima_vpm = dt_nextdate
		   where product_id = producto;
		end if;

EXCEPTION
   when ex.CONTROLLED_ERROR then
    ut_trace.trace('LDC_PRVPMDATA ' || ' ' || SQLERRM, 11);
    raise ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    ut_trace.trace('LDC_PRVPMDATA ' || ' ' || SQLERRM, 11);
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
end LDC_PRVPMDATA;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRVPMDATA
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRVPMDATA', 'ADM_PERSON');
END;
/