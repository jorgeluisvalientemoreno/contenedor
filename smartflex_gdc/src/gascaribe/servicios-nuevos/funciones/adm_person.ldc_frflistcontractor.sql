CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FRFLISTCONTRACTOR" 
  RETURN PKCONSTANTE.TYREFCURSOR IS
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.
  Nombre del Servicio: LDC_FRFLISTCONTRACTOR
  Descripcion: Funcion para lista de valores, contratista de contrucciones
               Toma los contratistas registrados en el parametro ID_LIST_CONTRACTOR_BUILDING

    Autor    : Sebastian Tapias

    Fecha    : 17/01/2018

    Historia de Modificaciones

   DD-MM-YYYY    <Autor>.              Modificacion
   -----------  -------------------    -------------------------------------
   17/01/2018   Sebastian Tapias       Creacion - CA 200-1640
   ******************************************************************/
  crContractor PKCONSTANTE.TYREFCURSOR;

BEGIN
  OPEN crContractor FOR
    SELECT g.id_contratista id, nombre_contratista description
      FROM ge_contratista g
     WHERE g.id_contratista in
           (select nvl(to_number(column_value), 0)
              from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('ID_LIST_CONTRACTOR_BUILDING',
                                                                                       NULL),
                                                      ',')))
     ORDER BY g.id_contratista;

  RETURN crContractor;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FRFLISTCONTRACTOR', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_FRFLISTCONTRACTOR TO REPORTES;
/
