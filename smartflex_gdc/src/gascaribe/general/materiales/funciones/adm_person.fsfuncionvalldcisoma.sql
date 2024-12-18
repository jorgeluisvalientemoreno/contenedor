CREATE OR REPLACE FUNCTION adm_person.fsfuncionvalldcisoma (
    inumotive            IN NUMBER,
    inuorder             IN or_order.order_id%TYPE,
    inuoperating_unit_id IN or_order.operating_unit_id%TYPE
) RETURN BOOLEAN IS
 /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  fsFuncionValLDCISOMA
  Descripcion :
  Autor       : Manuel mejia
  Fecha       : 11-11-2015

  Historia de Modificaciones
    Fecha               Autor                Modificación
  =========           =========          ====================
  23-02-2024          Paola Acosta       OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON   
  11-11-2015          mmejia             Creación.

  **************************************************************************/ 

    CURSOR cuvalmotive IS
    SELECT
        *
    FROM
        ldci_motipedi
    WHERE
        mopecodi = inumotive;

    rccuvalmotive cuvalmotive%rowtype;
    CURSOR cuvalorder (
        inuorder or_order.order_id%TYPE
    ) IS
    SELECT
        *
    FROM
        or_order
    WHERE
            order_id = inuorder
        AND operating_unit_id = inuoperating_unit_id
        AND order_status_id IN ( dald_parameter.fnugetnumeric_value('COD_ESTADO_ASIGNADA_OT'), dald_parameter.fnugetnumeric_value('COD_ESTADO_OT_EJE') );

    rccuvalorder  cuvalorder%rowtype;
BEGIN
    ut_trace.trace('fsFuncionValLDCISOMA: Inicia fsFuncionValLDCISOMA', 10);
    
    --Valia si el motivo de venta requiere codigo de orden
    --obligatorio
    OPEN cuvalmotive;
    FETCH cuvalmotive INTO rccuvalmotive;
    CLOSE cuvalmotive;
    
    ut_trace.trace('fsFuncionValLDCISOMA: rccuValMotive.MOPEFLAG' || rccuvalmotive.mopeflag, 10);
    
    IF ( rccuvalmotive.mopeflag = 'Y' ) THEN
        ut_trace.trace('fsFuncionValLDCISOMA: inuorder' || inuorder, 10);
        
        --Valida que la orden este asignada al contratista que
        --se ingreso en la forma  LDCISOMA
        OPEN cuvalorder(inuorder);
        FETCH cuvalorder INTO rccuvalorder;
        
        IF ( cuvalorder%notfound ) THEN
            ut_trace.trace('fsFuncionValLDCISOMA: Orden no existe ', 10);
            RETURN false;
        END IF;

        CLOSE cuvalorder;
    END IF;

    ut_trace.trace('fsFuncionValLDCISOMA: Fin fsFuncionValLDCISOMA', 10);
    
    RETURN true;
    
EXCEPTION
    WHEN ex.controlled_error THEN
        RAISE ex.controlled_error;
    WHEN OTHERS THEN
        errors.seterror;
        RAISE ex.controlled_error;
END fsfuncionvalldcisoma;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FSFUNCIONVALLDCISOMA', 'ADM_PERSON');
END;
/