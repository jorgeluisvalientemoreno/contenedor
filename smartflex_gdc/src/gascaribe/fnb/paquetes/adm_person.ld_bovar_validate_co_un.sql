CREATE OR REPLACE PACKAGE adm_person.LD_BOVar_Validate_Co_Un
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad        : LD_Validate_Tables_Co_Un
Descripcion   : Paquete para la validación de las Entidades del Proyecto Unidades constructivas para las LDC

Parametro      Descripcion
============  ==============================

Historia de Modificaciones
Fecha                Autor            Modificacion
====================   =========        ====================
DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
****************************************************************/
nuEntries BINARY_INTEGER := 0;

/*Variables para validación de la tabla LD_Co_Un_Task_Type*/
rctbLD_Co_Un_Task_Type  LD_Co_Un_Task_Type%rowtype;

/*Variable tipo registro para validación de la tabla Ld_Rel_Mar_Geo_Loc*/
rctbLD_Rel_Mar_Geo_Loc  Ld_Rel_Mar_Geo_Loc%rowtype;

/*Variable tipo registro para validación de la tabla Ld_Rel_Mar_Geo_Loc*/
rctbLd_Rel_Market_Rate  Ld_Rel_Market_Rate%rowtype;

/*Variable tipo registro para validación de la tabla Ld_Rel_Mark_Budget*/
rctbLd_Rel_Mark_Budget  Ld_Rel_Mark_Budget%rowtype;

/*Variable tipo registro para validación de la tabla Ld_Con_Uni_Budget*/
rctbLd_Con_Uni_Budget  Ld_Con_Uni_Budget%rowtype;

/*Variable tipo registro para validación de la tabla Ld_Service_Budget*/
rctbLd_Service_Budget  Ld_Service_Budget%rowtype;

/*Variable tipo registro para validación de la tabla Ld_Service_Budget*/
rctbLd_Demand_Budget  Ld_Demand_Budget%rowtype;

/*Variable tipo registro para validación de la tabla Ld_Dis_Exp_Budget*/
rctbLd_Dis_Exp_Budget  Ld_Dis_Exp_Budget%rowtype;

/*Variable tipo registro para validación de la tabla Ld_Mar_Exp_Budget*/
rctbLd_Mar_Exp_Budget  Ld_Mar_Exp_Budget%rowtype;


END LD_BOVar_Validate_Co_Un;
/
PROMPT Otorgando permisos de ejecucion a LD_BOVAR_VALIDATE_CO_UN
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BOVAR_VALIDATE_CO_UN', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LD_BOVAR_VALIDATE_CO_UN para reportes
GRANT EXECUTE ON adm_person.LD_BOVAR_VALIDATE_CO_UN TO rexereportes;
/

