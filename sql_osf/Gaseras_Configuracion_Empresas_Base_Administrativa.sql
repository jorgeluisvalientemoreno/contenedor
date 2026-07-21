--[Atención al Cliente 2741] Registro de Reclamo Exitoso para la Cuenta 3079147524. Solicitud: 236733960

SELECT pkg_Reglas_Flujo_Resp_Inte.fnuValidaEmpresa(236733960),
       pkg_mo_packages.fnuObtPOS_OPER_UNIT_ID(236733960),
       pkg_BOConsultaEmpresa.fsbObtEmpresaUnidadOper(pkg_mo_packages.fnuObtPOS_OPER_UNIT_ID(236733960)),
       pkg_Or_Operating_Unit.fnuObtAdmin_Base_id(pkg_mo_packages.fnuObtPOS_OPER_UNIT_ID(236733960))
  FROM dual;

select ba.*, rowid from Base_Admin ba
