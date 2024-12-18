create or replace FUNCTION "ADM_PERSON"."LDC_FNUCUENTASSALDOSPRODUCTO"(nuProductID PR_PRODUCT.PRODUCT_ID%type)
/*****************************************************************
  Unidad         : LDC_FNUCUENTASSALDOSPRODUCTO
  Descripcion    : retorna la cantidad de cuentas con saldo de un producto
                   Solo si el producto esta uspendido por RP
  Autor          : Jorge Valiente.
  Fecha          : 26/06/2022

  Parametros             Descripcion
  ============        ===================
  inuPackageId       Codigo de la solicitud

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>               Modificacion
  -----------  -------------------    -------------------------------------
  09/08/2022   Jorge Valiente         OSF-479: Actualizar la buqueda de cuentas con saldo para que
                                               tenga en cuenta el valor en reclamo y solo debe contar
                                               una cuenta de cobro si la diferencia entre el saldo de esta
                                               y el valor en reclamo es mayor a cero.
  ******************************************************************/
 RETURN NUMBER IS
  --<<
  -- Variables del proceso
  -->>
  nuRetorno      NUMBER := 0;
  sbCadTypeSuspe ldc_pararepe.PARAVAST%Type := open.DALDC_PARAREPE.fsbGetPARAVAST('LDC_VAL_TIPOSUSP767',
                                                                                  null);
  nuCuProdSusp   number := 0;

  --<<
  -- Cursor que obtiene la cantidad de cuentas de cobro con saldo de un producto
  -->>
  CURSOR cuCantidad IS
    SELECT count(1)
      FROM cuencobr
     WHERE cuconuse = nuProductID
       AND (NVL(cucosacu, 0) - NVL(cucovare, 0)) > 0;

  --<<
  -- Cursor para identificar si el producto esta suspendido por RP
  -->>
  CURSOR CuProSusp IS
    select count(1)
      from PR_PROD_SUSPENSION
     where active = 'Y'
       and product_id = nuProductID
       and SUSPENSION_TYPE_ID in
           (SELECT to_number(column_value) tipo_susp
              FROM TABLE(open.ldc_boutilities.splitstrings(sbCadTypeSuspe,
                                                           ',')));

BEGIN

  --<<
  -- Valida si el producto esta suspendido
  -->>
  OPEN CuProSusp;
  FETCH CuProSusp
    INTO nuCuProdSusp;
  CLOSE CuProSusp;

  if nuCuProdSusp > 0 then
    --<<
    -- obtiene la cantidad de cuentas de cobro con saldo de un producto
    -->>
    OPEN cuCantidad;
    FETCH cuCantidad
      INTO nuRetorno;
    IF cuCantidad%NOTFOUND THEN
      nuRetorno := 0;
    END IF;
    CLOSE cuCantidad;

  else
    nuRetorno := 0;
  end if;

  RETURN nuRetorno;
END LDC_FNUCUENTASSALDOSPRODUCTO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUCUENTASSALDOSPRODUCTO', 'ADM_PERSON');
END;
/
