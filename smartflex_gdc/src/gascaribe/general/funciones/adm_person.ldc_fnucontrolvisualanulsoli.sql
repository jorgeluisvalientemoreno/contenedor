CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUCONTROLVISUALANULSOLI" (inuPackagesId in mo_packages.package_id%type)
  return number IS

  /*****************************************************************
    Unidad          : ldc_fnuControlVisualAnulSoli
    Descripcion     : funcion para retornar si el codigo del funcionario y el tipo de paquete
                      son validos para permitir la vuialzacion de la opcion Anulación de Solicitudes
                      en la forma CNCRM

  Autor: Jorge Valiente
  Fecha: 16 Diciembre 2014

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  ******************************************************************/

  --cursor
  --cursor para validar si el dato esta en el paremtro de codigo de solicitud
  CURSOR CUEXISTESOLITITUD(NUDATO      NUMBER,
                           SBPARAMETRO LD_PARAMETER.VALUE_CHAIN%TYPE) IS
    SELECT count(1) cantidad
      FROM DUAL
     WHERE NUDATO IN
           (select to_number(column_value)
              from table(ldc_boutilities.splitstrings(SBPARAMETRO, ',')));

  --cursor para validar si el dato esta en el paremtro de login del funcionario conectado
  CURSOR CUEXISTELOGIN(sbDATO      varchar2,
                       SBPARAMETRO LD_PARAMETER.VALUE_CHAIN%TYPE) IS
    SELECT count(1) cantidad
      FROM DUAL
     WHERE sbDATO IN
           (select column_value
              from table(ldc_boutilities.splitstrings(SBPARAMETRO, ',')));

  --cursor para obtener el nombre del funcionario conectado en el sistema
  CURSOR cuuser IS
    SELECT user FROM DUAL;
  --fin cursor

  --variables
  sbparametrotipsol       LD_PARAMETER.VALUE_CHAIN%TYPE := ''; --parametro tipos de solicitudes
  nucantidad              number;
  nuretorna               number := 1;
  sbCOD_TIP_SOL_ANULACION LD_PARAMETER.VALUE_CHAIN%TYPE := DALD_PARAMETER.fsbGetValue_Chain('COD_TIP_SOL_ANULACION',
                                                                                            NULL);
  sbLOG_USU_SOL_ANU       LD_PARAMETER.VALUE_CHAIN%TYPE := DALD_PARAMETER.fsbGetValue_Chain('LOG_USU_SOL_ANU',
                                                                                            NULL);
  sbUSER                  varchar2(4000);
  nupackage_type_id       ps_package_type.package_type_id%type;
  --fin variables

BEGIN

  ut_trace.trace('Inicio ldc_fnuControlVisualAnulSoli', 10);

    nupackage_type_id := damo_packages.fnugetpackage_type_id(inuPackagesId,
                                                             null);

    ut_trace.trace('Tipo de solicitud nupackage_type_id --> ' ||
                   nupackage_type_id,
                   10);

    open CUEXISTESOLITITUD(nupackage_type_id, sbCOD_TIP_SOL_ANULACION);
    fetch CUEXISTESOLITITUD
      into nucantidad;
    close CUEXISTESOLITITUD;

    if nucantidad > 0 then
      --obtener ususario conectado
      open cuuser;
      fetch cuuser
        into sbUSER;
      close cuuser;

      ut_trace.trace('Login usuario --> ' || sbUSER, 10);

      ut_trace.trace('Parametro LOG_USU_SOL_ANU --> ' || sbLOG_USU_SOL_ANU,
                     10);

      open CUEXISTELOGIN(sbUSER, sbLOG_USU_SOL_ANU);
      fetch CUEXISTELOGIN
        into nucantidad;
      close CUEXISTELOGIN;

      ut_trace.trace('CUEXISTESOLITITUD nucantidad --> ' || sbUSER, 10);

      if nucantidad <= 0 then
        nuretorna := 0;
      end if;

      --fin obtener usuario conectado
    end if;


  ut_trace.trace('Fin ldc_fnuControlVisualAnulSoli', 10);

  ut_trace.trace('Valor que Retorna nuretorna --> ' || nuretorna, 10);
  return(nuretorna);

exception
  when others then
    Dbms_output.put_line('Error ' || SQLERRM);
    ---Retorna -1 cuando exista un error al ejecutar la funcion
    return(0);

END ldc_fnuControlVisualAnulSoli;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUCONTROLVISUALANULSOLI', 'ADM_PERSON');
END;
/