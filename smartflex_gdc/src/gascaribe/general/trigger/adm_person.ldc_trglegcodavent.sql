CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGLEGCODAVENT 
AFTER UPDATE ON PR_PRODUCT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
when (( OLD.PRODUCT_STATUS_ID = 15) and (NEW.PRODUCT_STATUS_ID = 1))
  /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2018-05-11
        Ticket      : 200-1901
        Descripcion : trigger que se encarga de legalizar las ordenes de documentacion de venta

        Parametros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA           AUTOR       DESCRIPCION
        21/10/2024      jpinedc     OSF-3450: Se migra a ADM_PERSON
   ***************************************************************************/

DECLARE

 nuContrato servsusc.sesususc%TYPE; --TICKET 2001901 LJLB -- se almacena numero de contrato
 sbasig_subsidy_id   VARCHAR2(100); --TICKET 2001901 LJLB -- se almacena codigo subsidio

 onuErrorCode NUMBER; --TICKET 2001901 LJLB -- se almacena codigo del error
 osbErrorMessage VARCHAR2(4000); --TICKET 2001901 LJLB -- se almacena mensaje de error


 --TICKET 2001901 LJLB -- se consulta contrato
 CURSOR cuContrato IS
 SELECT sesususc
 FROM servsusc
 WHERE sesunuse = :NEW.PRODUCT_ID;

  --TICKET 2001901 LJLB -- se consulta subsidio asociado al contrato
 CURSOR cuSubsisdio IS
 SELECT ASIG_SUBSIDY_ID|| '-S' codigo
 FROM ld_asig_subsidy asu, mo_packages s, ld_subsidy su
 WHERE asu.susccodi = nuContrato AND
    asu.delivery_doc = ld_boconstans.csbNOFlag AND
    asu.state_subsidy <> ld_boconstans.cnuSubreverstate AND
    Asu.subsidy_id  = su.subsidy_id AND
    S.package_id   = asu.package_id;

 sbmensa   VARCHAR2(4000);

BEGIN

  IF FBLAPLICAENTREGA('CRM_VENT_LJLB_2001901_3') THEN
      OPEN cuContrato;
      FETCH cuContrato INTO nuContrato;
      IF cuContrato%FOUND THEN
         FOR reg IN cuSubsisdio LOOP
            LDC_PROCCONTDOCUVENT ( REG.codigo,
                                   onuErrorCode,
                                   osbErrorMessage);

         END LOOP;
      END IF;
      CLOSE cuContrato;
  END IF;
EXCEPTION
 WHEN ex.controlled_error THEN
     RAISE;
 WHEN OTHERS THEN
    sbmensa := 'Proceso termino con Errores. '||SQLERRM;
    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
    errors.seterror;
    RAISE ex.controlled_error;
END LDC_TRGLEGCODAVENT;
/
