CREATE OR REPLACE PROCEDURE adm_person.api_assign_order(inuOrder          IN    NUMBER,
                                                        inuOperatingUnit  IN    NUMBER,
                                                        onuErrorCode      OUT   NUMBER,
                                                        osbErrorMessage   OUT   VARCHAR2) is

  /*****************************************************************
  Procedimiento   :   api_assignOrder
  Descripcion     :   Proceso que se encarga de llamar al api de asignación de open

  Historia de Modificaciones
  Fecha       Autor              Modificacion
  =========   =========       ====================
  06-06-2023  dsaltarin       OSF-1130 Creación

  ******************************************************************/                                                               
  dtArrangedHour DATE := SYSDATE + 1/1440;
  dtChangeDate   DATE := SYSDATE ;
BEGIN
   OS_ASSIGN_ORDER(inuOrder,inuOperatingUnit,dtArrangedHour,dtChangeDate,onuErrorCode,osbErrorMessage);

EXCEPTION
  WHEN OTHERS THEN
    PKG_ERROR.setError;
    PKG_ERROR.getError (onuErrorCode, osbErrorMessage);
END;
/
GRANT EXECUTE ON adm_person.api_assign_order TO SYSTEM_OBJ_PRIVS_ROLE
/
GRANT EXECUTE ON adm_person.api_assign_order TO REXEINNOVA
/
GRANT EXECUTE ON adm_person.api_assign_order TO PERSONALIZACIONES
/
