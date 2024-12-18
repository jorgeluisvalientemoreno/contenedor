CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FRFLISTOPERATINGUNITY" (inuContractor ge_contratista.id_contratista%TYPE)
  RETURN PKCONSTANTE.TYREFCURSOR IS
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.
  Nombre del Servicio: LDC_FRFLISTOPERATINGUNITY
  Descripcion: Funcion para lista de valores, Unidad Operativa del (contratista de contrucciones)

    Autor    : Sebastian Tapias

    Fecha    : 17/01/2018

    Historia de Modificaciones

   DD-MM-YYYY    <Autor>.              Modificacion
   -----------  -------------------    -------------------------------------
   17/01/2018   Sebastian Tapias       Creacion - CA 200-1640
   15/01/2019   HORBART                CASO 88: Se adiciona parametro CLAF_ID para excluir unidades operativa
                                                que hagan parte de una clasificacion configurada en el parametro
    ******************************************************************/
  crUnitOper PKCONSTANTE.TYREFCURSOR;

BEGIN
  OPEN crUnitOper FOR
    SELECT ou.operating_unit_id id, ou.name description
      FROM or_operating_unit ou
     WHERE ou.contractor_id = inuContractor
     --Inicio CA88
     and ou.oper_unit_classif_id NOT IN
       (select to_number(column_value)
          from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLAF_ID',
                                                                                   NULL),
                                                  ',')))
     --Fin CA88
     ORDER BY ou.operating_unit_id;

  RETURN crUnitOper;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FRFLISTOPERATINGUNITY', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_FRFLISTOPERATINGUNITY TO REPORTES;
/
