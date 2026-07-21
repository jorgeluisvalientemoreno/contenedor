select ve.CODIGO ID, ve.NOMBRE DESCRIPTION from vw_empresa ve;
select ba.*, rowid from base_admin ba;
SELECT --DECODE(pkg_reglas_flujo_resp_interac.fnuValidaEmpresa(236734514),0,'0 - GDGU',1,'1 - GDCA','N/A') 
 pkg_BOConsultaEmpresa.fsbObtEmpresaUnidadOper(pkg_mo_packages.fnuObtPOS_OPER_UNIT_ID(236734514)) Empresa,
 --(pkg_reglas_flujo_resp_interac.fnuValidaEmpresa(236734514),0,'0 - GDGU',1,'1 - GDCA','N/A')
 pkg_mo_packages.fnuObtPOS_OPER_UNIT_ID(236734514) || ' - ' ||
 pkg_or_operating_unit.fsbObtNAME(pkg_mo_packages.fnuObtPOS_OPER_UNIT_ID(236734514)) Unidad_Operativa,
 pkg_Or_Operating_Unit.fnuObtAdmin_Base_id(pkg_mo_packages.fnuObtPOS_OPER_UNIT_ID(236734514)) ||
  ' - ' ||
 --pkg_Or_Operating_Unit.fnuObtAdmin_Base_id(pkg_mo_packages.fnuObtPOS_OPER_UNIT_ID(236734514)) || ' - ' ||
  dage_base_administra.fsbgetdescripcion(pkg_Or_Operating_Unit.fnuObtAdmin_Base_id(pkg_mo_packages.fnuObtPOS_OPER_UNIT_ID(236734514))) Base_Admistrativa
--, pkg_Base_Admin.fsbObtieneEmpresa(pkg_Or_Operating_Unit.fnuObtAdmin_Base_id(pkg_mo_packages.fnuObtPOS_OPER_UNIT_ID(236734514))) Empresa
  FROM dual;

select * from ge_base_administra;
--SELECT pkg_bosolicitud_interaccion.fnuIniValorFlagValidate(:INST.EXTERNAL_ID:) FLAG_VALIDATE FROM DUAL
--SELECT pkg_reglas_flujo_resp_interac.fnuValidaEmpresa(:INST.EXTERNAL_ID:) EXIST_VALUE FROM dual
