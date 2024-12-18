CREATE OR REPLACE package adm_person.LDC_BOConstans is
  /*****************************************************************
    Propiedad intelectual de Peti (c).

    Unidad         : LDC_BOConstans
    Descripcion    : Objeto de negocio para el manejo de constantes

    Autor          : Emiro leyva
    Fecha          : 20/02/2013

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    19/06/2024        PAcosta               OSF-2845: Cambio de esquema ADM_PERSON 
  ******************************************************************/

  /*Actividades de ventas cargo x conexion*/
   cnuC_x_C_Res   constant   ge_items.items_id%type :=4000051;
   cnuC_x_C_Com   constant   ge_items.items_id%type :=4000053;
   cnuC_x_C_Ind   constant   ge_items.items_id%type :=4000054;

  /*Actividades de ventas instalacion interna*/
   cnuInte_Res    constant  ge_items.items_id%type :=4000050;
   cnuInte_Com    constant  ge_items.items_id%type :=4000052;
   cnuInte_Ind    constant  ge_items.items_id%type :=4000055;

  /*Item de Actividad de comision de ventas en zona nueva*/
   cnuItemZnueva  constant  ge_items.items_id%type :=4000603;

 /*Item de Actividad de comision de ventas en zona saturada*/
   cnuItemZsatur  constant  ge_items.items_id%type :=4000604;


  /* Flag de zona nueva */
   sbFlag_z_nueva constant  LDC_INFO_PREDIO.is_zona%type := 'N';


  /*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemInteResi
  Descripcion    : Obtiene el item de actividad de instalacion interna residencial.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemInteResi return number;

  /*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemInteComer
  Descripcion    : Obtiene el item de actividad de instalacion interna comercial.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemInteComer return number;

/*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemInteIndu
  Descripcion    : Obtiene el item de actividad de instalacion interna industrial.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemInteIndu return number;


  /*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemCxCResi
  Descripcion    : Obtiene el item de actividad del cargo por conexion residencial.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemCxCResi return number;

  /*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemCxCComer
  Descripcion    : Obtiene el item de actividad del cargo por conexion comercial.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemCxCComer return number;

/*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemCxCIndu
  Descripcion    : Obtiene el item de actividad del cargo por conexion industrial.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemCxCIndu return number;

 /*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemComiZNueva
  Descripcion    : Obtiene el item de actividad comision de ventas en zona nueva.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemComiZNueva return number;


 /*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemComiZSatura
  Descripcion    : Obtiene el item de actividad comision de ventas en zona saturada.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemComiZSatura return number;


/*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fsbFlagzn
  Descripcion    : Obtiene el flag de zona nueva.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  FUNCTION fsbFlagzn return varchar2;


end LDC_BOCONSTANS;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BOCONSTANS IS


   /*****************************************************************
   Propiedad intelectual de Peti (c).


  Unidad         : fnuItemInteResi
  Descripcion    : Obtiene el item de actividad de instalacion interna residencial.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemInteResi return number IS
  begin

    return cnuInte_Res;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuItemInteResi;

   /*****************************************************************
   Propiedad intelectual de Peti (c).


  Unidad         : fnuItemInteComer
  Descripcion    : Obtiene el item de actividad de instalacion interna comercial.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemInteComer return number IS
  begin

    return cnuInte_Com;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuItemInteComer;

   /*****************************************************************
   Propiedad intelectual de Peti (c).


  Unidad         : fnuItemInteIndu
  Descripcion    : Obtiene el item de actividad de instalacion interna industrial.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemInteIndu return number IS
  begin

    return cnuInte_Ind;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuItemInteIndu;


  /*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemCxCResi
  Descripcion    : Obtiene el item de actividad del cargo por conexion residencial.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemCxCResi return number IS
  begin

    return cnuC_x_C_Res;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuItemCxCResi;


  /*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemCxCComer
  Descripcion    : Obtiene el item de actividad del cargo por conexion comercial.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemCxCComer return number IS
  begin

    return cnuC_x_C_Com;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuItemCxCComer;


/*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemCxCIndu
  Descripcion    : Obtiene el item de actividad del cargo por conexion industrial.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemCxCIndu return number IS
  begin

    return cnuC_x_C_Ind;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuItemCxCIndu;



 /*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemComiZNueva
  Descripcion    : Obtiene el item de actividad comision de ventas en zona nueva.
  Autor          : Emiro Leyva Hernandez
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemComiZNueva return number IS
  begin

    return cnuItemZnueva;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuItemComiZNueva;

 /*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fnuItemComiZSatura
  Descripcion    : Obtiene el item de actividad comision de ventas en zona saturada.
  Autor          : Emiro Leyva Hernandez
  Fecha          : 06/03/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuItemComiZSatura return number IS
  begin

    return cnuItemZsatur;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuItemComiZSatura;


/*****************************************************************
  Propiedad intelectual de Peti (c).

  Unidad         : fsbFlagzn
  Descripcion    : Obtiene el flag de zona nueva.
  Autor          :
  Fecha          : 20/02/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  FUNCTION fsbFlagzn return varchar2 IS
  begin

    return sbFlag_z_nueva;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fsbFlagzn;


END LDC_BOCONSTANS;
/
PROMPT Otorgando permisos de ejecucion a LDC_BOCONSTANS
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BOCONSTANS', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_BOCONSTANS para reportes
GRANT EXECUTE ON adm_person.LDC_BOCONSTANS TO rexereportes;
/