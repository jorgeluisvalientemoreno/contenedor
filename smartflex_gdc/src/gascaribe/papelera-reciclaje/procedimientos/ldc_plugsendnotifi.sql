CREATE OR REPLACE PROCEDURE LDC_PLUGSENDNOTIFI IS
    /**************************************************************************
        Autor       : Ernesto Santiago / Horbath
        Fecha       : 2019-11-27
        Ticket      : 54
        Descripcion : Plugin que  permite que envio correo de notificacion
                      por correo electronico para los tipos de trabajos toma de lectura y tomo de relectura.
        Valor de salida
        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
	 01/04/2020		Horbath		caso 313: Se modifica el procedimiento para manejar las plantillas directamnete en el procedimiento
	 04/08/2020     Horbath     caso 313_2: agregar el nuevo cursor 'CUCOMMET_EFG'  y validacion con la funcion FBLAPLICAENTREGA
   ***************************************************************************/
    nuOrden                 or_order.order_id%type;
	nuOrder_id              or_order.order_id%type;
    nuCausal                or_order.causal_id%type;
    nuproducto              or_order_activity.PRODUCT_ID%type;
    nucliente               or_order_activity.SUBSCRIBER_ID%type;
    nucontrato              or_order_activity.SUBSCRIPTION_ID%type;
    nuOrderActivity_id      or_order_activity.ACTIVITY_ID%type;
    osbErrorMessage         GE_ERROR_LOG.DESCRIPTION%TYPE;
	onuErrorCode          ge_error_log.error_log_id%type;
    nuUnitop              or_operating_unit.OPERATING_UNIT_ID%type;
	SBNOTI                LDC_USER_NOTI.NOTIFICABLE%TYPE;
	SBCORREO              LDC_USER_NOTI.CORREO%TYPE;
    LECTURA               Lectelme.LEEMLETO%TYPE;
	FECHA_LECT            Lectelme.LEEMFELE%TYPE;
	DIR                   or_order_activity.ADDRESS_ID%TYPE;
    COMENT                or_order_comment.ORDER_COMMENT%TYPE;
	NUSUBSCRIBER_ID		  or_order_activity.SUBSCRIBER_ID%type;--caso: 313
	SBNOMBRE    varchar(200);--caso: 313
	SBMEDIDOR   varchar(200);--caso: 313
    nuclascau   number;
    nuplant   number;
    SBDATOS VARCHAR2(1);
	nuactivity number;
	nuCausalLegalizacion number;
    nuTipoComentario number;
    sbComentario varchar(200);
	message    VARCHAR2(3000);
     --- en este cursor se obtiene el tipo de trabajo, la actividad y el estado de la orden que se esta legalizando
    cursor cuproduct(NUORDEN NUMBER) is
			select PRODUCT_ID,ADDRESS_ID
			from or_order_activity
			WHERE order_id=NUORDEN;
	cursor CUNOTI(PRODUCT NUMBER) is
			select NOTIFICABLE,CORREO
			from LDC_USER_NOTI
			where PRODUCT_ID=PRODUCT;
	cursor CUDATO(PRODUCT NUMBER) is
	    select SUBSTR(a.value1,9,INSTR(a.value1,'>>>')-9)lectura, O.execution_final_date,a.SUBSCRIBER_ID --caso:313
        from or_order_activity a, or_order o
        where a.order_id= o.order_id
        and o.order_id=NUORDEN;  -- 185873
    cursor CUPLANTILLA(PLANT NUMBER) is
        select t.TEMPLATE_SOURCE
        from GE_XSL_TEMPLATE t
        where  t.XSL_TEMPLATE_ID= PLANT;
	-- Inicio caso:313
	cursor CUCOMMET(NUORDEN NUMBER) is
		select ORDER_COMMENT comentario, o.execution_final_date
        from or_order_comment c, or_order o
        where c.order_id= o.order_id
        and LEGALIZE_COMMENT='Y'
        and o.order_id=NUORDEN
        and rownum=1;
    cursor CUCOMMET_EFG(NUORDEN NUMBER) is
		select daobselect.fsbgetobledesc(to_number(SUBSTR(a.value2,10,INSTR(a.value2,'>>>')-10)))comentario, o.execution_final_date --caso:313
        from or_order_activity a, or_order o
        where a.order_id= o.order_id
        and o.order_id=NUORDEN;
	cursor CUNOMBRE(NUSUBSCRIBER_ID NUMBER) is
		select SUBSCRIBER_NAME||' '||SUBS_LAST_NAME nombre
        from GE_SUBSCRIBER where SUBSCRIBER_ID=NUSUBSCRIBER_ID;--640113
	cursor CUMEDIDOR(NUPRODUCTI_ID NUMBER) is
        SELECT EMSSCOEM medidor
        FROM ELMESESU
        where EMSSSESU=NUPRODUCTI_ID;
	-- Fin caso:313
BEGIN
    -- con estas funciones se obtienen los datos de la orden que se intentan legalizar --
    ut_trace.trace('Inicio PLUGIN LDC_PLUGSENDNOTIFI',10);
    nuOrden := or_bolegalizeorder.fnuGetCurrentOrder; -- se obtiene el id de la orden que se intenta legalizar
    nuCausal := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla ('or_order','order_id','causal_id',nuOrden));
    nuclascau := dage_causal.fnugetclass_causal_id(nuCausal); -- tipo de causal
	OPEN cuproduct(nuOrden);
	FETCH cuproduct INTO nuproducto,dir;
	CLOSE cuproduct;
	OPEN CUNOTI(nuproducto);
    FETCH CUNOTI INTO SBNOTI, SBCORREO;
    CLOSE CUNOTI;
	IF SBNOTI = 'Y' THEN
        OPEN CUDATO(nuOrden);
        FETCH CUDATO INTO LECTURA, FECHA_LECT, NUSUBSCRIBER_ID ;
        CLOSE CUDATO;
		-- Inicio caso:313
		OPEN CUMEDIDOR(nuproducto);
        FETCH CUMEDIDOR INTO SBMEDIDOR;-- medidor
        CLOSE CUMEDIDOR;
		OPEN CUNOMBRE(NUSUBSCRIBER_ID);
        FETCH CUNOMBRE INTO SBNOMBRE;-- nombre del cliente
        CLOSE CUNOMBRE;
		-- Fin caso:313
        IF LECTURA is not null THEN
			-- Inicio caso:313
            message:='<html>
						<head>
							<title>Untitled Document</title>
							<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
						</head>
						<body>
							<h3>Fecha:<FECHA_EJEC></h3>
							<h3>Contrato:<CONTRATO></h3>
							<h3>Nombre:<NOMBRE></h3>
							<h3>Direccion:<DIREC></h3>
							<h3>Medidor:<ELEMEDI></h3>
							<h3>Lectura:<LECTURA></h3>
						</body>
					</html>';
            -- Fin caso:313
            /* comentario caso 313
            nuplant:= DALD_PARAMETER.FNUGETNUMERIC_VALUE('PLA_SI_TOMA_LECTURA');
            OPEN CUPLANTILLA(nuplant);
            FETCH CUPLANTILLA INTO message;
            CLOSE CUPLANTILLA;*/
            message := replace(message, '<FECHA_EJEC>', TO_char(FECHA_LECT,'DD/MM/YYYY HH24:MI:SS'));
            message := replace(message, '<LECTURA>',LECTURA);
            message := replace(message, '<DIREC>', daab_address.fsbgetaddress(dir));
            message := replace(message, '<CONTRATO>',dapr_product.fnugetsubscription_id(nuproducto));
			message := replace(message, '<ELEMEDI>',SBMEDIDOR);--caso: 313
			message := replace(message, '<NOMBRE>',SBNOMBRE);--caso: 313
        ELSE
        --caso:313 nuplant:= DALD_PARAMETER.FNUGETNUMERIC_VALUE('PLA_NO_TOMA_LECTURA');
			IF FBLAPLICAENTREGA('OSS_HT_0000313_2') THEN
				OPEN CUCOMMET_EFG(nuOrden);
				FETCH CUCOMMET_EFG INTO COMENT, FECHA_LECT ;
				CLOSE CUCOMMET_EFG;
			ELSE
				OPEN CUCOMMET(nuOrden);
				FETCH CUCOMMET INTO COMENT, FECHA_LECT ;
				CLOSE CUCOMMET;
			END IF;
            message:='<html>
                        <head>
                            <title>Untitled Document</title>
                            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
                        </head>
                        <body>
                            <h3>Fecha:<FECHA_EJEC></h3>
                            <h3>Contrato:<CONTRATO></h3>
                            <h3>Nombre:<NOMBRE></h3>
                            <h3>Direccion:<DIREC></h3>
                            <h3>Medidor:<ELEMEDI></h3>
                            <h3>Lectura: No fue posible registrar la lectura debido a:<OR_COMENT></h3>
                        </body>
                    </html>';
            /* comentario caso 313
            OPEN CUPLANTILLA(nuplant);
            FETCH CUPLANTILLA INTO message;
            CLOSE CUPLANTILLA;*/
            message := replace(message, '<FECHA_EJEC>', TO_char(FECHA_LECT,'DD/MM/YYYY HH24:MI:SS'));
            message := replace(message, '<OR_COMENT>',COMENT);
            message := replace(message, '<DIREC>', daab_address.fsbgetaddress(dir));
            message := replace(message, '<CONTRATO>',dapr_product.fnugetsubscription_id(nuproducto));
			message := replace(message, '<ELEMEDI>',SBMEDIDOR);--caso: 313
			message := replace(message, '<NOMBRE>',SBNOMBRE);--caso: 313
            -- Fin caso:313
        END IF;
        IF message IS NOT NUll THEN
            ldc_sendemail(SBCORREO, 'Toma de lectura del medidor', message);  --- se envian los correos con este procedimiento
            -- ldc_sendemail(destinatarios, Asunto, Mensaje);
            -- Se guarda en la tabla ldc_cant_noti
             INSERT INTO ldc_cant_noti
             (CANTNOTI, PRODUCT_ID, FECHA )
             VALUES
             (SEQ_CANT_NOTI.NEXTVAL, nuproducto, SYSDATE );
        END IF;
	END IF;
    ut_trace.trace('fin PLUGIN LDC_PLUGSENDNOTIFI',10);
EXCEPTION
    when ex.CONTROLLED_ERROR then
       RAISE Ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,osbErrorMessage);
        RAISE ex.controlled_error;
END LDC_PLUGSENDNOTIFI;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_PLUGSENDNOTIFI', 'OPEN');
END;
/
