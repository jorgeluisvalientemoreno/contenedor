declare

    NUITEMSID          GE_ITEMS.ITEMS_ID%TYPE           := 4294367; -- REVISION INICIO ACTUACION ADMINISTRATIVA
    SBCOMMENT          OR_ORDER_ACTIVITY.COMMENT_%TYPE := 'Orden creada por el caso OSF-1240';

    ONUORDERID         OR_ORDER.ORDER_ID%TYPE;
    ONUORDERACTIVITYID OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;

    NULEGALIZETRYTIMES OR_ORDER_ACTIVITY.LEGALIZE_TRY_TIMES%TYPE;
    
    onuerrorcode        number;
    osberrormessage     varchar2(2000);
	
	CURSOR cuInfoCuenta IS
		select address_id, subscriber_id, subscription_id, product_id, order_id 
		from open.or_order_activity
		where order_id in (286096800, 279085886); 

begin
  dbms_output.put_line('---- Inicio Regeneración de ordenes de REVISION INICIO ACTUACION ADMINISTRATIVA ----');
  
	BEGIN
  
	  --reversion de transitorias
	  FOR reg IN cuInfoCuenta LOOP
	  
		or_boorderactivities.createactivity(inuitemsid          => NUITEMSID,
											inupackageid        => NULL,
											inumotiveid         => NULL,
											INUCOMPONENTID      => NULL,
											INUINSTANCEID       => NULL,
											INUADDRESSID        => reg.address_id,
											INUELEMENTID        => NULL,
											INUSUBSCRIBERID     => reg.subscriber_id,
											INUSUBSCRIPTIONID   => reg.subscription_id,
											INUPRODUCTID        => reg.product_id,
											INUOPERSECTORID     => null,
											INUOPERUNITID       => null,
											IDTEXECESTIMDATE    => null,
											INUPROCESSID        => null,
											ISBCOMMENT          => SBCOMMENT,
											IBLPROCESSORDER     => null,
											INUPRIORITYID       => null,
											IONUORDERID         => ONUORDERID,
											IONUORDERACTIVITYID => ONUORDERACTIVITYID,
											ISBCOMPENSATE       => null,
											INUCONSECUTIVE      => null,
											INUROUTEID          => null,
											INUROUTECONSECUTIVE => null,
											INULEGALIZETRYTIMES => NULEGALIZETRYTIMES, ---null,200-2686
											ISBTAGNAME          => null,
											IBLISACTTOGROUP     => null,
											INUREFVALUE         => null,
											INUACTIONID         => null);

		IF (ONUORDERID IS NOT NULL) THEN
			COMMIT;
			dbms_output.put_line('Nueva Orden creada: '||ONUORDERID);
			BEGIN
				OS_RELATED_ORDER( reg.order_id, -- Identificador de la Orden a la que se le va a Relacionar una Orden
								  ONUORDERID,   -- Identificador de la Orden que se va a Relacionar
								  onuerrorcode,
								  osberrormessage);
			EXCEPTION
			WHEN OTHERS THEN
			  rollback;
			  DBMS_OUTPUT.PUT_LINE('Error API OS_RELATED_ORDER--> '||sqlerrm);
			END;
			IF (onuerrorcode = 0) THEN
				dbms_output.put_line('onuerrorcode: '||onuerrorcode);
				dbms_output.put_line('osberrormessage: '||osberrormessage);
				dbms_output.put_line('Se relacionan OK las ordenes ' || reg.order_id || ' y ' || ONUORDERID );
				COMMIT;
			ELSE
				dbms_output.put_line('onuerrorcode: '||onuerrorcode);
				dbms_output.put_line('osberrormessage: '||osberrormessage);
				ROLLBACK;
			END IF;
		END IF;
	  COMMIT;
	  
	  ONUORDERID := null;
	  ONUORDERACTIVITYID := null;
		 
	  END LOOP;
	  
	  EXCEPTION
	  WHEN OTHERS THEN
		ERRORS.SETERROR;
		ERRORS.GETERROR(onuerrorcode, osberrormessage);
		DBMS_OUTPUT.PUT_LINE(osberrormessage);
	  END;
  
  dbms_output.put_line('---- Fin Regeneración de ordenes de REVISION INICIO ACTUACION ADMINISTRATIVA ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error Regeneración de ordenes de REVISION INICIO ACTUACION ADMINISTRATIVA ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/