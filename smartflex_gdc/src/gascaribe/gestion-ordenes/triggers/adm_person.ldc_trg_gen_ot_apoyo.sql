CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_GEN_OT_APOYO
BEFORE insert ON or_order_activity
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
/*************************************************************************************************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Funcion     :  ldc_trg_gen_ot_apoyo
    Descripcion :  llama al proceso que Genera la orden de apoyo
    Ticket		:	200-2180
    Autor       : Elkin Alvarez
    Fecha       : 22-11-2018
Historial de modificaciones
Fecha          autor         Observacion
23/06/2021     horbath        ca 754 se envia campo instancia al proceso ldcprocgenordenapoyo
**************************************************************************************************************************************************************/

DECLARE
 nulocalidad ab_address.geograp_location_id%TYPE;
 eerror      EXCEPTION;
 sbmensaje   VARCHAR2(1000);
 sbactivavalidacion   VARCHAR2(10);

 nuconta NUMBER;
 -- se consulta localidad por direccion de la orden
 CURSOR cuConsuDire IS
 SELECT d.geograp_location_id
 FROM ab_address d
 WHERE d.address_id = :new.address_id;

   -- se consulta localidad por direccion del producto
  CURSOR cuConsuDireProd IS
  SELECT d.geograp_location_id , d.address_id
  FROM ab_address d, pr_product p
  WHERE d.address_id = p.address_id
   AND p.product_id = :NEW.PRODUCT_ID;

     -- se consulta localidad por direccion del producto
  CURSOR cuConsuDireContrat IS
  SELECT d.geograp_location_id , d.address_id
  FROM ab_address d, suscripc p
  WHERE d.address_id = p.SUSCIDDI
   AND p.SUSCCODI = :NEW.SUBSCRIPTION_ID;

   error number;
   nuDireccion NUMBER;

BEGIN

  --se valida si la entrega aplica a la gasera
 IF Fblaplicaentregaxcaso('200-2180') THEN
   sbactivavalidacion := dald_parameter.fsbGetValue_Chain('PARAM_VALOR_APLICA',NULL);

   IF sbactivavalidacion IS NULL THEN
      sbmensaje := 'Debe definir valor para el parametro : PARAM_VALOR_APLICA en la forma LDPAR.';
      RAISE eerror;
   END IF;
   -- Validamos con parametro si la solucion aplica para la empresa
   IF TRIM(sbactivavalidacion) = 'S' THEN
      --se sonsulta si la actividad esta configurada
      SELECT COUNT(1) INTO nuconta
      FROM(
        (SELECT to_number(column_value) valor
           FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAM_ACT_PARA_ORDEN_APOYO',NULL),',')))
        )
      WHERE valor = :new.activity_id;

      --si la actividad esta configurada llamo al proceso
      IF nuconta > 0 THEN
           nulocalidad := NULL;
		  IF :NEW.PRODUCT_ID IS NOT NULL THEN
		     OPEN cuConsuDireProd;
			 FETCH cuConsuDireProd INTO nulocalidad, nuDireccion;
			 CLOSE cuConsuDireProd;

		  ELSE
		     IF :NEW.SUBSCRIPTION_ID IS NOT NULL THEN
			    OPEN cuConsuDireContrat;
				FETCH cuConsuDireContrat INTO nulocalidad, nuDireccion;
				CLOSE cuConsuDireContrat;
			 END IF;
		  END IF;

		  IF nulocalidad IS NULL THEN
             --se valida si la direccion no este vacia
              IF :new.address_id IS NOT NULL THEN
                  nuDireccion :=  :new.address_id ;
                  OPEN cuConsuDire;
                  FETCH cuConsuDire INTO nulocalidad;
                  IF cuConsuDire%NOTFOUND THEN
                   nulocalidad := NULL;
                   sbmensaje := 'Error al consultar localidad con la direcci¿¿n  '||:new.address_id;
                   CLOSE cuConsuDire;
                   RAISE eerror;
                  END IF;
                  CLOSE cuConsuDire;
               ELSE
                  sbmensaje := 'Error al consultar localidad con la direcci¿¿n  '||:new.address_id;
                  RAISE eerror;
               END IF;
           END IF;

		   sbmensaje := NULL;
          --CA 754 -- se envia nuevo campo de instancia al proceso de orden de apoyo
		  ldcprocgenordenapoyo(:new.ORDER_ID, :new.activity_id,nulocalidad, nuDireccion, :NEW.SUBSCRIPTION_ID, :new.package_id,:new.motive_id, :new.instance_id, sbmensaje);

          IF sbmensaje IS NOT NULL THEN
             RAISE eerror;
          END IF;
        END IF;
    END IF;
   END IF;
Exception
  when ex.CONTROLLED_ERROR then
        Errors.getError(error, sbmensaje);
    raise;
 When eerror Then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
  when OTHERS then
      Errors.getError(error, sbmensaje);

END;
/
