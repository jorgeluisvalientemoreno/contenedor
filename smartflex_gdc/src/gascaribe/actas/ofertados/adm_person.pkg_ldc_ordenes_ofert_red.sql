CREATE OR REPLACE package adm_person.PKG_LDC_ORDENES_OFERT_RED
is
/*******************************************************************************
Propiedad intelectual de PROYECTO GASES DEL CARIBE
  Autor                :  Edison Eduardo Ceron Moreno
  Fecha                :  28/11/2019
  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  28-Nov-2019     Caso 237            Paquete que contiene servicio para validar si las ordenes
                                      padre, hija y nieta estan asociadas a un acta.
  *******************************************************************************/

PROCEDURE PR_VALIDATE_ORDERS(INORDER_PADRE IN LDC_ORDENES_OFERTADOS_REDES.orden_padre%TYPE,
                            INORDER_HIJA IN LDC_ORDENES_OFERTADOS_REDES.orden_hija%type,
                            INORDER_NIETA IN LDC_ORDENES_OFERTADOS_REDES.orden_nieta%type);
end PKG_LDC_ORDENES_OFERT_RED;
/
CREATE OR REPLACE package body adm_person.PKG_LDC_ORDENES_OFERT_RED
is
/*******************************************************************************
Propiedad intelectual de PROYECTO GASES DEL CARIBE
  Autor                :  Edison Eduardo Ceron Moreno
  Fecha                :  28/11/2019
  Fecha                IDEntrega              Modificacion
 ============    ================       ============================================
 28-Nov-2019     Caso 237               Paquete que contiene servicio para validar si las ordenes
                                         padre, hija y nieta estan asociadas a un acta.
  24-Sep-2020    Caso 523       dsaltarin Se agrega control de excepcion de ex.CONTROLLED_ERROR
  *******************************************************************************/
  /*******************************************************************************/
  /* Servicio que valida si una orden tiene asociada un acta en estado cerrado   */
  /*******************************************************************************/

PROCEDURE PR_VALIDATE_ORDER(INORDER_ID IN OR_ORDER.ORDER_ID%TYPE)
IS
  nuCountActa      NUMBER;
  nuIdActa         ge_acta.id_acta%type;
  cursor curCountActa(inuOrder IN LDC_ORDENES_OFERTADOS_REDES.orden_padre%type) is
    SELECT COUNT(1)
    FROM ge_detalle_acta gda, GE_ACTA ga
    where gda.id_acta = ga.id_acta
     and gda.id_orden = inuOrder;

 cursor curGetActa(inuOrder IN LDC_ORDENES_OFERTADOS_REDES.orden_padre%type) is
    SELECT ga.id_acta
      FROM ge_detalle_acta gda, GE_ACTA ga
     where gda.id_acta = ga.id_acta
       and gda.id_orden = inuOrder
       and rownum = 1;
BEGIN
    OPEN curCountActa(INORDER_ID);
    FETCH curCountActa INTO nuCountActa;
    CLOSE curCountActa;
    IF nuCountActa > 0 THEN
        OPEN curGetActa(INORDER_ID);
        FETCH curGetActa INTO nuIdActa;
        CLOSE curGetActa;
        RAISE_APPLICATION_ERROR(-20005,'No es posible realizar la acción, debido a que la orden [' ||INORDER_ID||'] se encuentra en el acta ['||nuIdActa||'].');
        Errors.SetError (2741, 'No es posible realizar la acción, debido a que la orden [' ||INORDER_ID||'] se encuentra en el acta ['||nuIdActa||'].');
        RAISE ex.CONTROLLED_ERROR;
    END IF;
EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
     RAISE ex.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
  ut_trace.trace('PKG_LDC_ORDENES_OFERT_RED '||' '||SQLERRM, 11);
END PR_VALIDATE_ORDER;



/*******************************************************************************/
/* Servicio que valida si las ordenes padre, hija y nieta tienen asociadas un acta.
   A su vez se validan las orden relacionadas a las mencionadas anteriormente   */
/*******************************************************************************/
PROCEDURE PR_VALIDATE_ORDERS(INORDER_PADRE IN LDC_ORDENES_OFERTADOS_REDES.orden_padre%TYPE,
                            INORDER_HIJA IN LDC_ORDENES_OFERTADOS_REDES.orden_hija%type,
                            INORDER_NIETA IN LDC_ORDENES_OFERTADOS_REDES.orden_nieta%type)
is
   cursor curGetOrderNieta(inuOrder IN LDC_ORDENES_OFERTADOS_REDES.orden_padre%type) is
     select distinct orden_nieta AS nieta
      from ldc_ordenes_ofertados_redes
      where orden_padre = inuOrder;

   rwGetOrderNieta curGetOrderNieta%rowtype;
BEGIN
    IF INORDER_HIJA IS NOT NULL THEN
		IF OPEN.DAOR_ORDER.FNUGETORDER_STATUS_ID(INORDER_HIJA, NULL) = 8 THEN
			PR_VALIDATE_ORDER(INORDER_HIJA);
			OPEN curGetOrderNieta(INORDER_HIJA);
			LOOP
			FETCH curGetOrderNieta INTO rwGetOrderNieta;
			EXIT WHEN curGetOrderNieta%NOTFOUND;
				PR_VALIDATE_ORDER(rwGetOrderNieta.NIETA);
  		END LOOP;
			CLOSE curGetOrderNieta;
		END IF;
		IF INORDER_NIETA IS NOT NULL THEN
			PR_VALIDATE_ORDER(INORDER_NIETA);
		END IF;
  END IF;
EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
     RAISE ex.CONTROLLED_ERROR;
WHEN OTHERS THEN
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
  ut_trace.trace('PKG_LDC_ORDENES_OFERT_RED '||' '||SQLERRM, 11);
END PR_VALIDATE_ORDERS;
end PKG_LDC_ORDENES_OFERT_RED;
/
Prompt Otorgando permisos sobre ADM_PERSON.PKG_LDC_ORDENES_OFERT_RED
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('PKG_LDC_ORDENES_OFERT_RED'), 'ADM_PERSON');
END;
/