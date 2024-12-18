CREATE OR REPLACE FUNCTION LDC_VAL_SOL_EST_REG_100225(InuProducto NUMBER)
  RETURN NUMBER IS

  /************************************************************************************************************
   Propiedad intelectual PETI.
  
   Funcion  :  LDC_VAL_SOL_EST_REG_100225
  
   Descripci?n  : Valida solicitudes en estado registradas
                  asociadas al prodcuto para validar el uso del tramite 100225
  
   Autor  : Jorge Valiente
   Fecha  : 25/07/2022
   CASO   : OSF-445
  
   Historia de Modificaciones
   Autor                          Fecha              Descripcion
   ---------------------------    ---------------    -------------------------------------------
  
  ****************************************************************************************************************/

  TOTAL       NUMBER := 0;
  SBRESPUESTA VARCHAR2(2000) := '';
  NURESPUESTA number := 0;

  CURSOR CUTIPOSOLICITUD IS
    select to_number(column_value) TipoSolicitud
      from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_SOL_EST_REGISTRADA_100225',
                                                                               NULL),
                                              ','));

  rfCUTIPOSOLICITUD CUTIPOSOLICITUD%rowtype;

  CURSOR CUVALIDASOLICITUD(InuTipoSolicitud number) IS
    select count(1) Cantidad
      from open.mo_packages a, open.mo_motive b
     where a.package_type_id = InuTipoSolicitud
       and a.motive_status_id = 13
       and a.package_id = b.package_id
       and b.product_id = InuProducto;

  rfCUVALIDASOLICITUD CUVALIDASOLICITUD%rowtype;

BEGIN

  --valida si la entrega esta o no activa
  if FBLAPLICAENTREGAXCASO('OSF-445') then
  
    --Recorre el parametro de los tipos de solicitud
    for rfCUTIPOSOLICITUD in CUTIPOSOLICITUD loop
      --ut_trace.trace('Tipo Solcititud : ' || rfCUTIPOSOLICITUD.Tiposolicitud,1);
      --Valida si el tipo de solicitud existe como registrada en el producto utilizado en el 100225
      for rfCUVALIDASOLICITUD in CUVALIDASOLICITUD(rfCUTIPOSOLICITUD.Tiposolicitud) loop
        if rfCUVALIDASOLICITUD.Cantidad > 0 then
          NURESPUESTA := 1;
          ut_trace.trace('Existe solicitud tipo : ' ||
                         rfCUTIPOSOLICITUD.Tiposolicitud || ' registrada',
                         1);
        end if;
      end loop;
      EXIT WHEN NURESPUESTA = 1;
    end loop;
  
  end if;

  RETURN NURESPUESTA;

EXCEPTION
  WHEN OTHERS THEN
    ut_trace.trace(' error : ' || sqlerrm, 15);
    RETURN NURESPUESTA;
END LDC_VAL_SOL_EST_REG_100225;
/
