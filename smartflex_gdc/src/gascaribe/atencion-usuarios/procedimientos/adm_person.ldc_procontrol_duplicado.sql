CREATE OR REPLACE procedure ADM_PERSON.LDC_PROCONTROL_DUPLICADO(susccodi    number,
                                                     informacion varchar2) is
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  LDC_PROCONTROL_DUPLICADO
  Descripcion :  Prcedimiento para dejar registrado el control de informacion
                 utilizada par ael proceso de cobro de duplicado

  Autor       : Jorge Vaiente
  Fecha       : 07-06-2016

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  09/05/2024          Paola Acosta       OSF-2672: Cambio de esquema ADM_PERSON
                                         Retiro marcacion esquema .open objetos de lógica   
  **************************************************************************/

  nuREGISTRO_CONTROL_DUPLICADO ld_parameter.value_chain%type := dald_parameter.fnuGetNumeric_Value('REGISTRO_CONTROL_DUPLICADO');

begin

  UT_Trace.Trace('Inicia LDC_PROCONTROL_DUPLICADO', 10);

  if nuREGISTRO_CONTROL_DUPLICADO = 1 then
    insert into ldc_control_duplicado
      (susccodi, informacion, fecha_registro)
    values
      (susccodi, informacion, sysdate);
    commit;
  end if;

  UT_Trace.Trace('Fin LDC_PROCONTROL_DUPLICADO', 10);

end LDC_PROCONTROL_DUPLICADO;
/
PROMPT Otorgando permisos de ejecucion a LDC_PROCONTROL_DUPLICADO
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PROCONTROL_DUPLICADO', 'ADM_PERSON');
END;
/