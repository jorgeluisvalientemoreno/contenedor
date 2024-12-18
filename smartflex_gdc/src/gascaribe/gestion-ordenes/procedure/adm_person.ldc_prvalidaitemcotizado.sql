CREATE OR REPLACE procedure ADM_PERSON.LDC_PRVALIDAITEMCOTIZADO is

  /*****************************************************************
  UNIDAD       : LDC_PRVALIDAITEMCOTIZADO
  DESCRIPCION  : Prcedimiento para validar los items adicionales asociados al item cotizado
                 en al forma LDCRIAIC.
                 El valor total de los items adicionales asociados debe ser igual ser igual al
                 valor * cantidad del item cotizado que sera legalizado.

  AUTOR          : SINCECOMP
  FECHA          : 09/09/2016

  HISTORIA DE MODIFICACIONES
  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  11/03/2019      ELAL                CA 200-2404 -- se quita validacion del cursor cuvalidaordenintegraciones
                                      se modifica cursor  cutotalitemadicional para agregar codigo del items
  01/06/2020      MABG                CA 49 -- se valida que la forma LDCAPLAC no ejecute este plugin
  25/04/2024      PACOSTA             OSF-2596: Se retita el llamado al esquema OPEN (open.)                                   
                                      Se crea el objeto en el esquema adm_person
  ******************************************************************/

  --cursor para validar la cantidad de item adicional configurados al ITEM COTIZADO
  cursor cucantidaditemadicional(inuorden number, inuitemcotizado number) is
    select count(1) cantidaditemadicional
      from ldc_itemcoti_ldcriaic licl, ldc_itemadic_ldcriaic lial
     where licl.order_id = inuorden
       and licl.item_cotizado = inuitemcotizado
       and lial.codigo = licl.codigo;

  rfcucantidaditemadicional cucantidaditemadicional%rowtype;

  --TICKET 200-2404 ELAL -- se cambia cursor para que se agrupe por items
  --cursor para validar el total de item adicional y el total de ITEM COTIZADO
  cursor cutotalitemadicional(inuorden number) is
  SELECT items||' - '||dage_items.fsbgetdescription(items,null) items, totalitemadicional, valor_lega
  FROM (
        select items, sum(totalitemadicional) totalitemadicional, sum(valor_lega) valor_lega
		from (
				select licl.item_cotizado items,sum(nvl(lial.total,0)) totalitemadicional, 0 valor_lega
				from ldc_itemcoti_ldcriaic licl,
					   ldc_itemadic_ldcriaic lial
				where licl.order_id = inuorden
				   and lial.codigo = licl.codigo
				group by  licl.item_cotizado
				UNION all
				select ooi.items_id items,0 totalitemadicional, sum(nvl(ooi.value,0)) valor_lega
				from or_order_items        ooi
				where ooi.order_id = inuorden
				 and exists(select 1 from ldc_itemcoti_ldcriaic c where c.order_id=ooi.order_id and c.item_cotizado=ooi.items_id)
				group by  ooi.items_id
           )
		group by items)
  WHERE totalitemadicional <> valor_lega;   /*
    select sum(lial.total) totalitemadicional, ooi.value --lial.*
      from or_order_items        ooi,
           ldc_itemcoti_ldcriaic licl,
           ldc_itemadic_ldcriaic lial
     where ooi.order_id = inuorden
       and licl.order_id = ooi.order_id
       and lial.codigo = licl.codigo
       and licl.item_cotizado = ooi.items_id
     group by  ooi.value
  */

  rfcutotalitemadicional cutotalitemadicional%rowtype;

  --cursor para validar si el item a legalizar es un ITEM COTIZADO
  cursor cuvalidaitemcotizado(inuorden number) is
    select ooi.items_id
      from or_order_items ooi
     where ooi.order_id = inuorden
       and ooi.items_id IN
           (select to_number(column_value)
              from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_ITEMCOTI_LDCRIAIC',
                                                                                       NULL),

                                                      ',')));

  rfcuvalidaitemcotizado cuvalidaitemcotizado%rowtype;

  --cursor para validar si el item a legalizar es un ITEM COTIZADO
  cursor cuexisteitemcotizado(inuorden number, inuitem number) is
    select count(1) cantidad
      from ldc_itemcoti_ldcriaic licl
     where licl.order_id = inuorden
       and licl.item_cotizado = inuitem;

  rfcuexisteitemcotizado cuexisteitemcotizado%rowtype;

  --cursor para validar si el item a legalizar es un ITEM COTIZADO
  cursor cuvalidaorden(inuorden number) is
    select licl.*
      from ldc_itemcoti_ldcriaic licl
     where licl.order_id = inuorden;

  rfcuvalidaorden cuvalidaorden%rowtype;

  --cursor para validar si el item a legalizar es un ITEM COTIZADO
  cursor cuexisteitemcotizadoorden(inuorden number, inuitem number) is
    select count(1) cantidad
      from or_order_items ooi
     where ooi.order_id = inuorden
       and ooi.items_id = inuitem;

  rfcuexisteitemcotizadoorden cuexisteitemcotizadoorden%rowtype;

  --cursor para validar si el item a legalizar es un ITEM COTIZADO
  cursor cuvalidaordenintegraciones(inuorden number) is
    select count(1) cantidad
      from ldc_itemcotiinte_ldcriaic licl, or_related_order oro
     where oro.order_id = inuorden
       and oro.related_order_id = licl.order_id
       and rownum = 1;

  rfcuvalidaordenintegraciones cuvalidaordenintegraciones%rowtype;
  -----------

  NUORDENINSTANCIA OR_ORDER.ORDER_ID%TYPE;

  --Inicio Variables Errores
  EX_ERROR EXCEPTION;
  SBMENSAJE      VARCHAR2(30000);
  SBERRORMESSAGE VARCHAR2(4000);
  --Fin Variables

  -- inicio de variables caso 49 --
  nuCaso        varchar2(30):='0000049';
  sbNameForm    VARCHAR2(100);
  sw            boolean:=False;
  -- fin de variables caso 49 --

begin

	  IF(ut_session.getmodule != 'LDCAPLAC')THEN --- CASO 49

		  UT_TRACE.TRACE('INICIO LDC_PRVALIDAITEMCOTIZADO', 10);

		  NUORDENINSTANCIA := OR_BOLEGALIZEORDER.FNUGETCURRENTORDER;
		  UT_TRACE.TRACE('ORDEN A LEGALIZAR[' || NUORDENINSTANCIA || ']', 10);
		 --TICKET 200-2404 ELAL -- se quita validacion si la orden legalizada tiene configuracion de integraciones
		 /* open cuvalidaordenintegraciones(NUORDENINSTANCIA);
		  fetch cuvalidaordenintegraciones
			into rfcuvalidaordenintegraciones;
		  close cuvalidaordenintegraciones;

		  --condicional para no validar los items de de ordenes de integraciones

		  if rfcuvalidaordenintegraciones.cantidad = 0 then */

			UT_TRACE.TRACE('Validar Existencia ITEM COTIZADO', 10);
			for rfcuvalidaitemcotizado in cuvalidaitemcotizado(NUORDENINSTANCIA) loop

			  UT_TRACE.TRACE('**********************ITEM COTIZADO[' ||
							 nvl(rfcuvalidaitemcotizado.items_id, 0) || ']',
							 10);

			  --cursor para validar si el item cotizado esta asociado a la orden a alegalizar
			  open cuexisteitemcotizado(NUORDENINSTANCIA,
										rfcuvalidaitemcotizado.items_id);
			  fetch cuexisteitemcotizado
				into rfcuexisteitemcotizado;
			  close cuexisteitemcotizado;

			  if rfcuexisteitemcotizado.cantidad = 0 then
				--0
				SBMENSAJE := 'El item cotizado [' ||
							 rfcuvalidaitemcotizado.items_id ||
							 '] no esta asociado a la orden que se intenta legalizar';
			  else
				--cursor para validar si el item cotizado tiene asociado items adiconales
				open cucantidaditemadicional(NUORDENINSTANCIA,
											 rfcuvalidaitemcotizado.items_id);
				fetch cucantidaditemadicional
				  into rfcucantidaditemadicional;
				close cucantidaditemadicional;

				if nvl(rfcucantidaditemadicional.cantidaditemadicional, 0) = 0 then
				  --1
				  SBMENSAJE := 'El item cotizado[' ||
							   rfcuvalidaitemcotizado.items_id ||
							   '] no tiene configurado items adicionales';
				end if; --1

			  end if; --0

			end loop;

			IF SBMENSAJE IS NOT NULL THEN
			  RAISE EX_ERROR;
			END IF;

			SBMENSAJE := NULL;

			--cursor para validar total de items adcioanles y el total de item cotizado en la legalizacion
		   /*--TICKET 200-2404 ELAL -- se cambia de forma de recorrer del cursor cutotalitemadicional
			open cutotalitemadicional(NUORDENINSTANCIA);
			fetch cutotalitemadicional
			  into rfcutotalitemadicional;
			close cutotalitemadicional;*/

			 FOR rfcutotalitemadicional IN cutotalitemadicional(NUORDENINSTANCIA)  LOOP
				UT_TRACE.TRACE('Total ITEM COTIZADO[' ||
							   nvl(rfcutotalitemadicional.totalitemadicional, 0) || ']',
							   10);

				if nvl(rfcutotalitemadicional.totalitemadicional, 0) <>
				   rfcutotalitemadicional.valor_lega then
				  SBMENSAJE := substr('El total [' ||
							   rfcutotalitemadicional.totalitemadicional ||
							   '] de el Items '||rfcutotalitemadicional.items||' Adicional no coincide con el Total [' ||
							   rfcutotalitemadicional.valor_lega ||
							   '] del Item Cotizado que se intenta legalizar.'||SBMENSAJE,1,3999);
				  --RAISE EX_ERROR;
				end if;
			 END LOOP;

			  IF SBMENSAJE IS NOT NULL THEN
				RAISE EX_ERROR;
			  END IF;

			SBMENSAJE := NULL;

			UT_TRACE.TRACE('Validar ORDEN Vs ITEM COTIZADO', 10);
			--ciclo para identificar qeu si la orden itenta legalizar un ITEM COTIZADO este se
			--encuetre relacionado con la orden en LDRIAIC
			for rfcuvalidaorden in cuvalidaorden(NUORDENINSTANCIA) loop

			  UT_TRACE.TRACE('**********************ITEM COTIZADO[' ||
							 nvl(rfcuvalidaitemcotizado.items_id, 0) || ']',
							 10);

			  open cuexisteitemcotizadoorden(NUORDENINSTANCIA,
											 rfcuvalidaorden.item_cotizado);
			  fetch cuexisteitemcotizadoorden
				into rfcuexisteitemcotizadoorden;
			  close cuexisteitemcotizadoorden;

			  if rfcuexisteitemcotizadoorden.cantidad = 0 then
				SBMENSAJE := 'La orden legalizada tiene relacionado ITEM COTIZADO el cual no esta siendo legalizado';
			  end if;

			end loop;

			IF SBMENSAJE IS NOT NULL THEN
			  RAISE EX_ERROR;
			END IF;

			UPDATE LDC_ITEMCOTI_LDCRIAIC LIL
			   SET LIL.ORDER_STATUS_ID = 8
			 WHERE LIL.ORDER_ID = NUORDENINSTANCIA;

		  --end if;

			UT_TRACE.TRACE('FIN LDC_PRVALIDAITEMCOTIZADO', 10);

	  --RAISE EX_ERROR;

	  END IF; --- CASO 49




EXCEPTION
  WHEN EX_ERROR THEN
    GI_BOERRORS.SETERRORCODEARGUMENT(LD_BOCONSTANS.CNUGENERIC_ERROR,
                                     SBMENSAJE);
  WHEN OTHERS THEN
    GE_BOERRORS.SETERRORCODEARGUMENT(LD_BOCONSTANS.CNUGENERIC_ERROR,
                                     'ERROR AL EJECUTAR PROCESO LDC_PRVALIDAITEMCOTIZADO');
    RAISE;

end LDC_PRVALIDAITEMCOTIZADO;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRVALIDAITEMCOTIZADO
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRVALIDAITEMCOTIZADO', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_PRVALIDAITEMCOTIZADO para reportes
GRANT EXECUTE ON adm_person.LDC_PRVALIDAITEMCOTIZADO TO rexereportes;
/
