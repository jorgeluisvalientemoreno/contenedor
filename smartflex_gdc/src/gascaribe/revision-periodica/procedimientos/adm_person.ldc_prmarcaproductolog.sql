CREATE OR REPLACE PROCEDURE adm_person.ldc_prmarcaproductolog(nuProducto pr_product.product_id%type,
												   nuMarcaAnt ge_suspension_type.suspension_type_id%type,
												   nuMarcaAct ge_suspension_type.suspension_type_id%type,
												   sbOservaci varchar2) IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : LDC_PRMARCAPRODUCTOLOG
    Descripcion : Procedimiento que crea el  marca el producto con 103. Ca 200-1871

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    16/05/2024          Adrianavg          OSF-2675: Se migra del esquema OPEN al esquema ADM_PERSON
   **************************************************************************/


   --Cursor para obtener datos para el cambio de estado de la orden
  cursor cudatossesion is
    select su.mask USER_ID, sys_context('USERENV', 'TERMINAL') TERMINAL
      from sa_user su
     where su.user_id in (SELECT gp.user_id
                            FROM ge_person gp
                           WHERE person_id = GE_BOPersonal.fnuGetPersonId
                             AND rownum = 1)
       AND rownum = 1;

  rfcudatossesion cudatossesion%rowtype;
  sbmensa	varchar2(4000);

BEGIN
 ut_trace.trace('Inicia LDC_PRMARCAPRODUCTOLOG', 10);
 open cudatossesion;
 fetch cudatossesion into rfcudatossesion;
 close cudatossesion;
 insert into LDC_MARCA_PRODUCTO_LOG(ID_PRODUCTO, SUSPENSION_TYPE_ID_ANT, SUSPENSION_TYPE_ID_ACT, FECHA_CAMBIO, USER_ID, TERMINAL, OBSERVACION)
         values(nuProducto, nuMarcaAnt, nuMarcaAct,  sysdate, rfcudatossesion.user_id, rfcudatossesion.terminal, sbOservaci);
EXCEPTION
 WHEN ex.controlled_error THEN
  ut_trace.trace('Error LDC_PRMARCAPRODUCTOLOG ex.controlled_error', 10);
  RAISE;
 WHEN OTHERS THEN
  ut_trace.trace('Error LDC_PRMARCAPRODUCTOLOG OTHERS', 10);
  sbmensa := 'Proceso termino con Errores. '||SQLERRM;
  errors.seterror;
  RAISE ex.controlled_error;
END;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PRMARCAPRODUCTOLOG
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRMARCAPRODUCTOLOG', 'ADM_PERSON'); 
END;
/
