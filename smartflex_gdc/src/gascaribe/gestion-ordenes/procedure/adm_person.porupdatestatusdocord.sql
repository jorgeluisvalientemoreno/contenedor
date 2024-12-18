CREATE OR REPLACE PROCEDURE adm_person.porupdatestatusdocord(cXML IN CLOB,
                                                  ONUERRORCODE OUT NUMBER,
                                                  OSBERRORMESSAGE OUT VARCHAR2) IS
   /**************************************************************************

      Autor       : Josh Brito
      Fecha       : 13-09-2018
      Nombre      : PORUPDATESTATUSDOCORD
      Ticket      : 200-1752
      Descripcion : actualiza estado de orden en la tabla LDC_DOCUORDER

      Parametros Entrada

      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION
      08/10/2018   JBRITO      Al recibir una petición de actualización de registro, se debe hacer un update a la tabla LDC_DOCUORDER
                               cambiando el estado STATUS_DOCU por el estado recibido donde la orden es igual a la orden ingresada (idOrden en el XML).
                               Si el estado recibido es AR, se debe también actualizar el campo FILE_DATE con el campo fechaEstado que viene dentro
                               del XML. En esta tabla se debe tener en cuenta que si no se encuentra registro de la orden ingresada, se debe realizar
                               un INSERT en LDC_DOCUORDER con el número de orden, estado y fecha de archivo (FILE_DATE sólo si el estado es AR).
                               Se debe ingresar un registro en la tabla LDC_AUDOCUORDER para almacenar la auditoría de cambios de estado, teniendo en
                               cuenta que el usuario sería INTEGRACIONES. Se debe registrar el estado anterior en caso de existir registro previo en
                               LDC_DOCUORDER, sino se deja por defecto en CO. Se debe registrar el estado actual con lo recibido en el XML. La fecha
                               de cambio sería la del sistema.
    30/08/2019	   dsaltarin   GLPI-97 Se modifica para validar que la orden se encuentre en estado no terminal.
    08/05/2024     Adrianavg   OSF-2668: Se migra del esquema OPEN al esquema ADM_PERSON    
    ***************************************************************************/

  --YN_ORDEN LDC_DOCUORDER.ORDER_ID%TYPE;
  sbEstado LDC_DOCUORDER.STATUS_DOCU%TYPE;

  CURSOR CUORDEN IS
  SELECT DISTINCT idOrden, estado, fechaEstado
   FROM XMLTable('/estadoDocOrden' Passing
                     XMLType(cXML)  Columns
                              idOrden number Path 'idOrden', estado varchar2(2) Path 'estado', fechaEstado varchar2(20) Path 'fechaEstado')
   WHERE idOrden IS NOT NULL
   and estado is not null;

   --97
   nuEstadoOt     open.or_order.order_status_id%type;
   nuTitrOrde	  open.or_order.task_Type_id%type;
   nuExiste		  NUMBER;

BEGIN
  FOR O IN CUORDEN LOOP

    --97
	if fblAplicaEntregaxCaso('0000097') then
		begin
			select order_status_id, task_Type_id
			   into nuEstadoOt , nuTitrOrde
			  from open.or_order
			  where order_id=O.idOrden;
		exception
			when others then
				nuTitrOrde:=null;
				nuEstadoOt:=null;
		end;

		if nuTitrOrde is not null then
			select count(1)
            into nuExiste
            from ldc_titrdocu lt
           where lt.task_type_id = nuTitrOrde;
		    if nuExiste =1 and open.daor_order_status.fsbgetis_final_status(nuEstadoOt) != 'Y' then
				   ONUERRORCODE:=Ld_Boconstans.cnuGeneric_Error;
				   OSBERRORMESSAGE:='La orden '||O.idOrden|| ' No se encuentra en estado terminal.';
				   return;
			end if;
		end if;
	end if;
	--97

	BEGIN
      SELECT STATUS_DOCU INTO sbEstado
      FROM LDC_DOCUORDER WHERE ORDER_ID = O.idOrden;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        sbEstado := NULL;
    END;


        IF O.estado = 'AR' THEN
            IF sbEstado IS NOT NULL THEN
                UPDATE LDC_DOCUORDER
                  SET
                    STATUS_DOCU = O.estado,
                    FILE_DATE = O.fechaEstado
                WHERE ORDER_ID = O.idOrden;

                INSERT INTO LDC_AUDOCUORDER (USUARIO,TERMINAL,FECHA_CAMBIO,ORDER_ID,ESTADO_ANTERIOR,NUEVO_ESTADO)
                    VALUES ('342 - INTEGRACIONES', USERENV('TERMINAL'), SYSDATE, O.idOrden, sbEstado, O.estado);

            ELSE
                INSERT INTO LDC_DOCUORDER (ORDER_ID,STATUS_DOCU,FILE_DATE) VALUES (O.idOrden,O.estado,O.fechaEstado);
                INSERT INTO LDC_AUDOCUORDER (USUARIO,TERMINAL,FECHA_CAMBIO,ORDER_ID,ESTADO_ANTERIOR,NUEVO_ESTADO)
                    VALUES ('342 - INTEGRACIONES', USERENV('TERMINAL'), SYSDATE, O.idOrden, 'CO', O.estado);
            END IF;
            COMMIT;
            ONUERRORCODE := 0;
            OSBERRORMESSAGE := 'Proceso Ejecutado y actualizo correctamente';

        ELSE
            UPDATE LDC_DOCUORDER
              SET
                STATUS_DOCU = O.estado
            WHERE ORDER_ID = O.idOrden;

            INSERT INTO LDC_AUDOCUORDER (USUARIO,TERMINAL,FECHA_CAMBIO,ORDER_ID,ESTADO_ANTERIOR,NUEVO_ESTADO)
                    VALUES ('342 - INTEGRACIONES', USERENV('TERMINAL'), SYSDATE, O.idOrden, sbEstado, O.estado);
            COMMIT;
            ONUERRORCODE := 0;
            OSBERRORMESSAGE := 'Proceso Ejecutado y actualizo correctamente';
        END IF;


  END LOOP;

EXCEPTION
  WHEN OTHERS THEN
     ONUERRORCODE :=-1;
     OSBERRORMESSAGE := 'Error en el proceso PORUPDATESTATUSDOCORD '||sqlerrm;
END PORUPDATESTATUSDOCORD;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento PORUPDATESTATUSDOCORD
BEGIN
    pkg_utilidades.prAplicarPermisos('PORUPDATESTATUSDOCORD', 'ADM_PERSON'); 
END;
/
