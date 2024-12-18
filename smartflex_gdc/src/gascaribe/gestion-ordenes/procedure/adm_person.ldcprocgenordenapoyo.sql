CREATE OR REPLACE PROCEDURE adm_person.ldcprocgenordenapoyo(nuordenpadre IN NUMBER, nupaotactgen NUMBER,nupalocalidad NUMBER, nudireccion NUMBER, nuContrato  NUMBER, nupasolicitud NUMBER,numotivo NUMBER, nuinstancia NUMBER, sbmens OUT VARCHAR2) IS
/*************************************************************************
    Propiedad Intelectual de HORBATH TECHNOLOGIES

    Funcion     : ldcprocgenordenapoyo
    Descripcion : Genera la orden de apoyo
	Ticket		: 200-2180
    Autor       : Elkin Alvarez
    Fecha       : 22-11-2018

Historial de modificaciones
Fecha          autor         Observacion
23/06/2021     horbath        ca 754 se coloca nuevo campo de entrada para setear la instancia
08/05/2024     Adrianavg      OSF-2668: Se migra del esquema OPEN al esquema ADM_PERSON
***************************************************************************/
nuorderid          or_order.order_id%TYPE;
sbactivavalidacion ld_parameter.value_chain%TYPE;
nuerror            NUMBER;
eerroorexecp       EXCEPTION;
nuconta            NUMBER(4);
nuactividadgen     ge_items.items_id%TYPE;
nuunitoper         or_operating_unit.operating_unit_id%TYPE;
sbmensaje          VARCHAR2(1000);

nuProducto NUMBER;
nuCliente NUMBER;


CURSOR cuGetProducto IS
SELECT P.product_id, s.suscclie
from pr_product p, SUSCRIPC S
where P.SUBSCRIPTION_ID = nuContrato
 AND s.susccodi = P.SUBSCRIPTION_ID
 and p.PRODUCT_TYPE_ID = 7014;

BEGIN
 sbmens := NULL;
 ut_trace.trace('inicia ldcprocgenordenapoyo', 10);
 IF nupaotactgen IS NOT NULL THEN
   SELECT COUNT(1) INTO nuconta
     FROM(
          (SELECT to_number(column_value) valor
             FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAM_ACT_PARA_ORDEN_APOYO',NULL),',')))
          )
    WHERE valor = nupaotactgen;
   IF nuconta >= 1 THEN
    nuunitoper := NULL;
    BEGIN
     SELECT unioper_id INTO nuunitoper
       FROM ldc_locunit
      WHERE localidad_id = nupalocalidad;
    EXCEPTION
     WHEN no_data_found THEN
      nuunitoper := -1;
    END;
    IF nuunitoper >= 1 THEN
       nuactividadgen := dald_parameter.fnuGetNumeric_Value('PARAM_ACT_ORDEN_APOYO_GEN',NULL);
       nuorderid := NULL;
        ut_trace.trace('ingresa a crear orden '||nuactividadgen, 10);
		nuProducto := null;
		nuCliente := null;

		open cuGetProducto;
		fetch cuGetProducto into nuProducto, nuCliente;
		close cuGetProducto;
       os_createorderactivities(
                                nuactividadgen
                               ,nudireccion
                               ,SYSDATE
                               ,'SE GENERA ORDEN DE APOYO.'
                               ,NULL
                               ,nuorderid
                               ,nuerror
                               ,sbmensaje
                               );
     IF nuerror <> 0 THEN
       RAISE eerroorexecp;
     ELSE
       null;
      -- Asignamos la ord?n de trabajo generada
      IF nvl(nuorderid,-1) >= 1 THEN
        --Relacion de la orden creada
        insert into ldc_ordeapohij(solicitud, orden)
           VALUES (nupasolicitud, nuorderid);

    ut_trace.trace('ingresa a asignar orden '||nuorderid, 10);

         UPDATE or_order_activity a
            SET a.package_id = nupasolicitud
               , a.motive_id  = numotivo
			   , a.SUBSCRIBER_ID = nuCliente
			   , a.SUBSCRIPTION_ID = nuContrato
			   , a.PRODUCT_ID = nuProducto
         , A.INSTANCE_ID = nuinstancia -- CA 754 -- Se coloca nuevo campo de la instancian en el update
            WHERE a.order_id = nuorderid;
            nuerror   := 0;
            sbmensaje := NULL;
            os_assign_order(
                             nuorderid
                            ,nuunitoper
                            ,SYSDATE
                            ,SYSDATE
                            ,nuerror
                            ,sbmensaje
                            );
            IF nuerror <> 0 THEN
             RAISE eerroorexecp;
            END IF;
          END IF;

    END IF;
   END IF;
  END IF;
 END IF;

 sbmens := NULL;
EXCEPTION
 WHEN eerroorexecp THEN
  sbmens := sbmensaje;
 WHEN OTHERS THEN
  sbmens := SQLERRM;
END LDCPROCGENORDENAPOYO;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDCPROCGENORDENAPOYO
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCPROCGENORDENAPOYO', 'ADM_PERSON'); 
END;
/
