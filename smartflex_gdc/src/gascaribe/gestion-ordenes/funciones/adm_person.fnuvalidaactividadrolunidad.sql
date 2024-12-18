CREATE OR REPLACE FUNCTION adm_person.fnuvalidaactividadrolunidad (
    nuactividad     IN  ge_items.items_id%TYPE,
    nuunidad        IN  or_operating_unit.operating_unit_id%TYPE
) RETURN NUMBER IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P
    
      Funcion     : fnuValidaActividadRolUnidad
      Descripcion : Valida si la actividad esta asociada a alguno de los roles de la unidad
      Autor       : Horbath
      Ticket      : 213
    
    Historia de Modificaciones
    Fecha               Autor                Modificacion
    =========           =========          ====================
    22-02-2024          Paola Acosta       OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON
    
    **************************************************************************/
    CURSOR curolunidad IS
    SELECT /*+ index(or_actividades_rol ux_or_actividades_rol01)
          index(or_rol_unidad_trab idx_or_rol_unidad_trab_01) */
        COUNT(or_actividades_rol.id_actividad) cantidad
    FROM
        or_rol_unidad_trab,
        or_actividades_rol
    WHERE
            or_rol_unidad_trab.id_unidad_operativa = nuunidad
        AND or_actividades_rol.id_actividad = nuactividad
        AND or_actividades_rol.id_rol = or_rol_unidad_trab.id_rol
        AND NOT EXISTS (
            SELECT /*+ use_nl(or_excep_act_unitrab)
         index(or_excep_act_unitrab idx_or_excep_act_unitrab_01) */
                or_excep_act_unitrab.id_actividad
            FROM
                or_excep_act_unitrab
            WHERE
                    or_excep_act_unitrab.id_unidad_operativa = nuunidad
                AND or_excep_act_unitrab.id_actividad = or_actividades_rol.id_actividad
        );

    nucant NUMBER := 0;
    
BEGIN
    OPEN curolunidad;
    FETCH curolunidad INTO nucant;
    CLOSE curolunidad;
    
    RETURN ( nucant );
    
EXCEPTION
    WHEN ex.controlled_error THEN
        ut_trace.trace('Error : ex.CONTROLLED_ERROR', 15);
        RAISE;
    WHEN OTHERS THEN
        ut_trace.trace('Error : OTHERS', 15);
        errors.seterror;
        RAISE ex.controlled_error;
END fnuvalidaactividadrolunidad;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUVALIDAACTIVIDADROLUNIDAD', 'ADM_PERSON');
END;
/