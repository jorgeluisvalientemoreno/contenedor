CREATE OR REPLACE PACKAGE      LDCI_PKMOVIVENTMATE AS
	/*
				PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
				FUNCION    : LDCI_PKMOVIVENTMATE
				AUTOR      : Eduardo Aguera
				FECHA      : 26/01/2012
				RICEF      : I004; I018
				DESCRIPCION: Paquete realizar movimientos de isbMateriales para
																	contratistas/cuadrillas

    Historia de Modificaciones
	Autor       Fecha           Descripcion
    Kbaquero    21/08/2015      #8481:Se coloca una excepcion dentro del loop para que en el momento
                                     en que hay un error, sea controlado y ademas continue el proceso con el resto de la informacion
    jpinedc     27/06/2024      OSF-2603: Se ajusta proNotificaExcepcion  y se hace público                                                                       

	*/

			-- Notifica el movimiento de isbMaterial al front
			PROCEDURE ProNotiMaestroMovMaterial(inuMovMatCodi in  LDCI_INTEMMIT.MMITCODI%type,
																																						isbDocFront   in  LDCI_INTEMMIT.MMITNUDO%type,
																																						isbPedFront   in  LDCI_INTEMMIT.MMITNUPE%type,
																																						isbDocSap     in  LDCI_INTEMMIT.MMITDSAP%type,
																																						isbTipoMov    in  LDCI_INTEMMIT.MMITTIMO%type,
																																						isbDescMov    in  LDCI_INTEMMIT.MMITDESC%type,
																																						isbSigno      in  LDCI_INTEMMIT.MMITNATU%type,
																																						isbCliente    in  LDCI_INTEMMIT.MMITCLIE%type,
																																						idtFechaDoc   in  LDCI_INTEMMIT.MMITFESA%type,
																																						inuValorTotal in  LDCI_INTEMMIT.MMITVTOT%type,
																																						idtFechaVenc  in  LDCI_INTEMMIT.MMITFEVE%type);


			-- Notifica el detalle del movimineto
			PROCEDURE proNotiDetalleMovMaterial(inuMovMatCodi    in  LDCI_DMITMMIT.DMITMMIT%type,
																																						inuDetMovMatCodi in  LDCI_DMITMMIT.DMITCODI%type,
																																						isbMaterial      in  LDCI_DMITMMIT.DMITITEM%type,
																																						inuCantidad      in  LDCI_DMITMMIT.DMITCANT%type,
																																						inuCantPend      in  LDCI_DMITMMIT.DMITCAPE%type,
																																						inuCostoUni      in  LDCI_DMITMMIT.DMITCOUN%type,
																																						inuValorUni      in  LDCI_DMITMMIT.DMITVAUN%type,
																																						inuPorcIva       in  LDCI_DMITMMIT.DMITPIVA%type,
																																						isbNumFac        in  LDCI_DMITMMIT.DMITNUFA%type,
																																						isbAlmDest       in  LDCI_DMITMMIT.DMITALDE%type,
																																						isbMarca         in  LDCI_DMITMMIT.DMITMARC%type,
																																						isbSaliFinal     in  LDCI_DMITMMIT.DMITSAFI%type,
																																						isbMarcBorrado   in  LDCI_DMITMMIT.DMITMABO%type,
																																						isbItemDoVal     in  VARCHAR2);

			--Notifica el detalle de los isbSeriales
			Procedure ProNotiSerialDetaMovi(inuMovMatCodi    in LDCI_SERIDMIT.SERIMMIT%type,
																																		inuDetMovMatCodi in LDCI_SERIDMIT.SERIDMIT%type,
																																		inuSeriMatCodi   in LDCI_SERIDMIT.SERICODI%type,
																																		isbSerial        in LDCI_SERIDMIT.SERINUME%type);

			-- procedimiento que confirma la solicitud
			procedure proConfirmarSolicitud(inuMovimiento in LDCI_INTEMMIT.MMITCODI%type);

			-- Notifica el movimiento de isbMaterial al front
			PROCEDURE proReprocesaMovimiento(inuMovMatCodi   in  LDCI_INTEMMIT.MMITCODI%type,
																																			inuCurrent	     in NUMBER,
																																			inuTotal	       in NUMBER,
																																			onuErrorCode    out NUMBER,
																																			osbErrorMessage out VARCHAR2);

			PROCEDURE proAsignaMaterialSeriado(isbPosicion     in VARCHAR2,
  											   inuCurrent	     in NUMBER,
											   inuTotal	       in NUMBER,
											   onuErrorCode    out NUMBER,
											   osbErrorMessage out VARCHAR2);


			procedure proGenXMLItemSeriVendido(isbDOVECODI in  LDCI_DOCUVENT.DOVECODI%type,
																																					inuITDVPROV in  LDCI_ITEMDOVE.ITDVPROV%type,
																																					inuITDVCODI in  LDCI_ITEMDOVE.ITDVCODI%type,
																																					isbITDVITEM in  LDCI_ITEMDOVE.ITDVITEM%type,
																																					inuITDVOPUN in  LDCI_ITEMDOVE.ITDVOPUN%type,
																																					isbTipoMovi in  VARCHAR2,
																																					ol_Payload  out CLOB,
																																					osbMesjErr  out VARCHAR2);

			procedure proActualizaLDCI_TRANSOMA(inuTRSMCODI     in NUMBER,
			                                    inuTRSMESTA     in NUMBER,
  																			  onuErrorCode    out NUMBER,
                                          osbErrorMessage out VARCHAR2);

			procedure proActualizaLDCI_TRSOITEM(inuTSITSOMA     in NUMBER,
			                                   inuTSITITEM	    in NUMBER,
			                                   inuTSITCARE	    in NUMBER,
                                          inuTSITVUNI	    in NUMBER,
                                          inuTSITPIVA	    in NUMBER,
                                          isbTSITSAFI			in VARCHAR2,
                                          isbTSITMABO	    in VARCHAR2,
                                          isbTSITVALO	    in VARCHAR2,
                                          isbMMITNATU     in VARCHAR2,
                                          onuErrorCode    out NUMBER,
                                          osbErrorMessage out VARCHAR2);

			procedure proActuPosicionesSolVenta(inuDMITMMIT     in LDCI_DMITMMIT.DMITMMIT%type,
																																						onuErrorCode    out NUMBER,
																																						osbErrorMessage out VARCHAR2);

			PROCEDURE proActivaSoliVenta(inuPosicion     in NUMBER, --138682: Procedimiento para activar los pedidos de venta
										 inuCurrent	     in NUMBER,
										 inuTotal	     in NUMBER,
										 onuErrorCode    out NUMBER,
										 osbErrorMessage out VARCHAR2);

			-- funcion que retorna la marca
			function fsbGetDescMarca(inuMARCCODI  LDCI_MARCA.MARCCODI%type) return VARCHAR2;

			-- funcion que retorna el material vendido
			function frfGetSoliVentaMaterial return LDCI_PKREPODATATYPE.tyRefcursor;


			-- funcion que retorna todos los movimientos
			function frfGetMaterialVendido return LDCI_PKREPODATATYPE.tyRefcursor;

   function fboIsNumber(isbCadena IN VARCHAR2) RETURN BOOLEAN DETERMINISTIC PARALLEL_ENABLE;



    procedure proNotificaExcepcion(inuDocumento     in NUMBER,
		                         isbAsunto        in VARCHAR2,
								 isbMesExcepcion  in VARCHAR2);

	END LDCI_PKMOVIVENTMATE;
	
/

CREATE OR REPLACE PACKAGE BODY      LDCI_PKMOVIVENTMATE AS

	/*
				PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
				FUNCION    : LDCI_PKMOVIVENTMATE
				AUTOR      : Eduardo Aguera
				FECHA      : 26/01/2012
				RICEF      : I004; I018
				DESCRIPCION: Paquete realizar movimientos de isbMateriales para
															contratistas/cuadrillas

			Historia de Modificaciones
			Autor   		Fecha   		Descripcion
			MABG			06/11/2020		Se modifica el cursor cuWS_MOVIMIENTO_MATERIAL para tener
											en cuenta las nuevos atributos MARCA_VM, REFERENCIA_VM, MODELO_VM CASO 31
	*/

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$LDCI_PKMOVIVENTMATE||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
			-- cursor de las clases de movimientos, parametros definidos en LDCI_CARASEWE
			cursor cuClaseMovi is
						select sbMoviMate, sbMoviHerr, sbDevoMate, sbDevoHerr, sbClasSolMatAct, sbClasDevMatAct
								from (select CASEVALO sbMoviMate
										from LDCI_CARASEWE
									where CASEDESE = 'WS_RESERVA_MATERIALES'
											and CASECODI = 'CLS_MOVI_MATERIAL'),
								(select CASEVALO sbMoviHerr
										from LDCI_CARASEWE
										where CASEDESE = 'WS_RESERVA_MATERIALES'
									and CASECODI = 'CLS_MOVI_HERRAMIENTA'),
								(select CASEVALO sbDevoMate
										from LDCI_CARASEWE
										where CASEDESE = 'WS_RESERVA_MATERIALES'
									and CASECODI = 'CLS_MOVI_DEVOLUCION_MAT'),
								(select CASEVALO sbDevoHerr
										from LDCI_CARASEWE
										where CASEDESE = 'WS_RESERVA_MATERIALES'
									and CASECODI = 'CLS_MOVI_DEVOLUCION_HER'),
								(select CASEVALO sbClasSolMatAct --#OYM_CEV_3429_1
										from LDCI_CARASEWE
										where CASEDESE = 'WS_RESERVA_MATERIALES'
									and CASECODI = 'CLSM_SOLI_ACT'),
								(select CASEVALO sbClasDevMatAct --#OYM_CEV_3429_1
										from LDCI_CARASEWE
										where CASEDESE = 'WS_RESERVA_MATERIALES'
									and CASECODI = 'CLSM_DEVO_ACT');

			-- cursor de la configuraicon de la definicon LDCI_CARASEWE "WS_MOVIMIENTO_MATERIAL"
			-- #NC-2227: Se agrega el parametro ATT_MARCA_TECHNICAL_NAME
			-- #FAC_CEV_3655_1: Se agrega el parametro ATT_MAXVALUE_TECHNICAL_NAME #TODO: Valida el nombre del parametro
			-- #MABG modificacion caso 31
			cursor cuWS_MOVIMIENTO_MATERIAL is
					------------ inicio caso 31 ---------------
					select PROVEEDOR_LOGISTICO, ATT_MARCA_TECHNICAL_NAME, ATT_MAXVALUE_TECHNICAL_NAME,
						   ATT_MODELO_VM_TECHNICAL_NAME, ATT_REFERENCIA_VM_TEC_NAME, ATT_MARCA_VM_TECHNICAL_NAME
						from
						(select CASEVALO PROVEEDOR_LOGISTICO
						 		from LDCI_CARASEWE
						 	where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
							 		and CASECODI = 'PROVEEDOR_LOGISTICO'),

						(select CASEVALO ATT_MARCA_TECHNICAL_NAME
						 		from LDCI_CARASEWE
					 		where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
						 			and CASECODI = 'ATT_MARCA_TECHNICAL_NAME'),

						(select CASEVALO ATT_MAXVALUE_TECHNICAL_NAME
						 		from LDCI_CARASEWE
					 		where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
						 			and CASECODI = 'ATT_MAXVALUE_TECHNICAL_NAME'),

						(select CASEVALO ATT_MODELO_VM_TECHNICAL_NAME
						 		from LDCI_CARASEWE
					 		where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
						 			and CASECODI = 'ATT_MODELO_VM_TECHNICAL_NAME'),

						(select CASEVALO ATT_REFERENCIA_VM_TEC_NAME
						 		from LDCI_CARASEWE
					 		where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
						 			and CASECODI = 'ATT_REFERENCIA_VM_TEC_NAME'),

						(select CASEVALO ATT_MARCA_VM_TECHNICAL_NAME
						 		from LDCI_CARASEWE
					 		where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
						 			and CASECODI = 'ATT_MARCA_VM_TECHNICAL_NAME');

					/*select PROVEEDOR_LOGISTICO, ATT_MARCA_TECHNICAL_NAME, ATT_MAXVALUE_TECHNICAL_NAME
						from
						(select CASEVALO PROVEEDOR_LOGISTICO
						 		from LDCI_CARASEWE
						 	where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
							 		and CASECODI = 'PROVEEDOR_LOGISTICO'),
						(select CASEVALO ATT_MARCA_TECHNICAL_NAME
						 		from LDCI_CARASEWE
					 		where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
						 			and CASECODI = 'ATT_MARCA_TECHNICAL_NAME'),
						(select CASEVALO ATT_MAXVALUE_TECHNICAL_NAME
						 		from LDCI_CARASEWE
					 		where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
						 			and CASECODI = 'ATT_MAXVALUE_TECHNICAL_NAME');*/

					-------------- fin caso 31

			-- variable de tipo rowtype basada en el cursor cuClaseMovi
			reClaseMovi cuClaseMovi%rowtype;
			reWS_MOVIMIENTO_MATERIAL cuWS_MOVIMIENTO_MATERIAL%rowtype;


  procedure proAsignaMarcaBorrado(inuTSITSOMA     in NUMBER,
	                              isbMMITNATU     in VARCHAR2,
							      inuDMITMMIT     in NUMBER,
							      onuErrorCode    out NUMBER,
							      osbErrorMessage out VARCHAR2) As
/*
			PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
			FUNCION    : LDCI_PKMOVIVENTMATE.proAsignaMarcaBorrado
			AUTOR      : OLSoftware / Carlos E. Virgen
			FECHA      : 01-10-2013
			RICEF      : 138682
			DESCRIPCION: Actualzia el encabezado de la solicitu de venta LDCI_TRANSOMA

		Historia de Modificaciones
		Autor         Fecha        Descripcion
*/
    --Cursor para determinar la marca de borrado
	cursor cuItemMarcaBorradoSD(inuTSITSOMA NUMBER,
								inuDMITMMIT NUMBER) is
		select TSITITEM ITEM_OSF, CODE ITEM_SAP
		  from LDCI_TRSOITEM, GE_ITEMS
		 where TSITSOMA = inuTSITSOMA
		   and ITEMS_ID = TSITITEM
		 minus
		select DMITCOIN ITEM_OSF, DMITITEM ITEM_SAP
		  from LDCI_DMITMMIT
		 where DMITMMIT = inuDMITMMIT;

  begin
   onuErrorCode := 0;
   if (isbMMITNATU = '=') then
	   -- Determina que posiciones no llegaron en el movimiento y las marca como borradas
	   for rtItemMarcaBorradoSD in cuItemMarcaBorradoSD(inuTSITSOMA, inuDMITMMIT) loop
		  update LDCI_TRSOITEM set TSITMABO = 'X',
								   TSITSAFI = 'C',
								   TSITESIT = 'R'

			where TSITSOMA = inuTSITSOMA
			  and TSITITEM = rtItemMarcaBorradoSD.ITEM_OSF;
	   end loop; -- for rtItemMarcaBorradoSD in cuItemMarcaBorradoSD(inuTSITSOMA, inuDMITMMIT) loop
   end if;--if (isbMMITNATU = '=') then
  exception
		When Others Then
			onuErrorCode    := -1;
			osbErrorMessage := '[LDCI_PKMOVIVENTMATE.proAsignaMarcaBorrado]:' || chr(13) ||  'Error no controlado: ' || SQLERRM;
  end proAsignaMarcaBorrado;

    procedure proNotificaExcepcion(inuDocumento     in NUMBER,
		                         isbAsunto        in VARCHAR2,
								 isbMesExcepcion  in VARCHAR2) as
			/*
					PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
					FUNCION    : proNotificaExcepcion
					AUTOR      : Carlos Eduardo Virgen Londono <carlos.virgen@olsfotware.com>
					FECHA      : 03/02/2015
					RICEF      : 138682
					DESCRIPCION: Notifica excepciones por correo eletronico

				Historia de Modificaciones
				Autor    Fecha       Descripcion
				carlosvl 12/08/2011  Se hace la validacion de datos.
                jpinedc  27/06/2024  OSF-2603: Se reemplaza LDC_EMAIL por pkg_Correo			
			*/

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'proNotificaExcepcion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 

		-- define cursores
		cursor cuLDCI_TRANSOMA(inuTRSMCODI NUMBER) is
			select TRSM.TRSMCODI SOLICITUD, TRSM.TRSMCONT CONTRATISTA, TRSM.TRSMUNOP UNIDA_OPERATIVA, UNIO.NAME NOMBRE_UNIDADO,
				   TRSM.TRSMPROV PROV_LOGISTICO, PROV.NAME NOMBRE_PROVLOG, TRSM.TRSMUSMO USUARIO, TRSM.TRSMFECR FECHA_CREACION,
				   TRSM.TRSMPROG TERMINAL
			  from LDCI_TRANSOMA TRSM,
				  OR_OPERATING_UNIT UNIO,
				  OR_OPERATING_UNIT PROV
			 where TRSM.TRSMUNOP = UNIO.OPERATING_UNIT_ID
			   and TRSM.TRSMPROV = PROV.OPERATING_UNIT_ID
			   and TRSM.TRSMCODI = inuTRSMCODI;

		--cursor datos de la persona
		cursor cuGE_PERSON(isbMASK VARCHAR2) is
			select PERSON_ID,	NAME_, E_MAIL
			  from SA_USER USR, GE_PERSON 	PER
			 where upper(USR.MASK) = upper(isbMASK)
			   and USR.USER_ID = PER.USER_ID;

		-- tipo registro
		reGE_PERSON          cuGE_PERSON%rowtype;
		reLDCI_TRANSOMA cuLDCI_TRANSOMA%rowtype;
		
        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
		
		sbMensCorreo        VARCHAR2(4000);
		
    begin

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        -- abre el registro del documento con excepciones
        open cuLDCI_TRANSOMA(inuDocumento);
        fetch cuLDCI_TRANSOMA into reLDCI_TRANSOMA;
        close cuLDCI_TRANSOMA;

        --determina el usuario que esta realizando la operacion
        open cuGE_PERSON(reLDCI_TRANSOMA.USUARIO);
        fetch cuGE_PERSON into reGE_PERSON;
        close cuGE_PERSON;

        if (reGE_PERSON.E_MAIL is not null or reGE_PERSON.E_MAIL <> '') then

            -- genera el cuerpo del correo
            sbMensCorreo := sbMensCorreo ||'<html><body>';
            sbMensCorreo := sbMensCorreo ||'<table  border="1px" width="100%">';
            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td colspan="2"><h1>' || isbAsunto || '<h1></td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';
            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td><b>Documento de solicitud</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || inuDocumento  || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';
            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td><b>Fecha</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || to_char(reLDCI_TRANSOMA.FECHA_CREACION, 'DD/MM/YYYY HH:MM:SS') || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';


            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td><b>Unidad Operativa Origen</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || reLDCI_TRANSOMA.UNIDA_OPERATIVA || '-' || reLDCI_TRANSOMA.NOMBRE_UNIDADO || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';

            sbMensCorreo := sbMensCorreo ||'<td><b>Unidad Operativa Destino</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || reLDCI_TRANSOMA.PROV_LOGISTICO || '-' || reLDCI_TRANSOMA.NOMBRE_PROVLOG || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';

            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td><b>Usuario</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || reGE_PERSON.NAME_ || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';
            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td><b>Terminal</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || reLDCI_TRANSOMA.TERMINAL || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';

            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td><b>Mensaje</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || isbMesExcepcion || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';

            sbMensCorreo := sbMensCorreo ||'</table>';
            sbMensCorreo := sbMensCorreo ||'</html></body>';

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => reGE_PERSON.E_MAIL,
                isbAsunto           => isbAsunto,
                isbMensaje          => sbMensCorreo
            );
                                               
        else
        
            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbRemitente,
                isbAsunto           => 'Usuario sin correo electrónico ('|| reGE_PERSON.NAME_ || ')',
                isbMensaje          => sbMensCorreo
            );

	  end if;
	  

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
    	  
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    end proNotificaExcepcion;

   function fsbGetDescMarca(inuMARCCODI  LDCI_MARCA.MARCCODI%type)	return VARCHAR2 as
					-- cursor de la marca
					cursor cuLDCI_MARCA(inuMARCCODI  LDCI_MARCA.MARCCODI%type) is
						select MARCCODI, MARCDESC
								from LDCI_MARCA
							where MARCCODI = inuMARCCODI;

					reLDCI_MARCA cuLDCI_MARCA%rowtype;
				begin

					open cuLDCI_MARCA(inuMARCCODI);
					fetch cuLDCI_MARCA into reLDCI_MARCA;
					if (cuLDCI_MARCA%NOTFOUND) then
						close cuLDCI_MARCA;
						open cuLDCI_MARCA(-1);
						fetch cuLDCI_MARCA into reLDCI_MARCA;
						close cuLDCI_MARCA;
					end if; --if (cuLDCI_MARCA%NOTFOUND) then
					close cuLDCI_MARCA;

					return reLDCI_MARCA.MARCDESC;
			end fsbGetDescMarca;

   FUNCTION fboIsNumber (isbCadena IN VARCHAR2) RETURN BOOLEAN DETERMINISTIC PARALLEL_ENABLE IS
     nuNumber NUMBER;
   BEGIN
						nuNumber := TO_NUMBER(isbCadena);
						RETURN TRUE;
			EXCEPTION
						WHEN VALUE_ERROR THEN
								RETURN FALSE;
			END fboIsNumber;

   function fsbAtrTopeMedidor(inuRMMAMARC in LDCI_REMEMARC.RMMAMARC%type,
			                          inuRMMACODI in LDCI_REMEMARC.RMMACODI%type)	return VARCHAR2 as
					/*
						* Propiedad Intelectual Gases de Occidente SA ESP
						*
						* Script  : LDCI_PKMOVIVENTMATE.fsbAtrTopeMedidor
						* RICEF   : #FAC_CEV_3655_1
						* Autor   : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
						* Fecha   : 27-05-2014
						* Descripcion : Retorna el tope de medidor segun la configuracion de referencia por marca

						*
						* Historia de Modificaciones
						* Autor          Fecha      Descripcion
						* carlos.virgen  23-05-2014 Version inicial
					**/
					-- cursor referencia por marca
					cursor cuLDCI_REMEMARC(inuMarca    in LDCI_REMEMARC.RMMAMARC%type,
			                        inuRefMarca in LDCI_REMEMARC.RMMACODI%type) is
						select RMMAMARC,
												RMMACODI,
												RMMACAAR,
												RMMAQMAX,
												RMMAQMIN,
												RMMACCDM,
												RMMAMPOP,
												RMMAVMRM,
												RMMATCLE,
												RMMAAVUT,
												RMMAAGME,
												RMMADCSA,
												RMMADCME,
												RMMANDME,
												RMMAFAME
								from LDCI_REMEMARC
							where RMMAMARC = inuMarca
							  and RMMACODI = inuRefMarca;

					reLDCI_REMEMARC cuLDCI_REMEMARC%rowtype;
				begin

					open cuLDCI_REMEMARC(inuRMMAMARC, inuRMMACODI);
					fetch cuLDCI_REMEMARC into reLDCI_REMEMARC;
					if (cuLDCI_REMEMARC%NOTFOUND) then
						close cuLDCI_REMEMARC;
						open cuLDCI_REMEMARC(-1, -1);
						fetch cuLDCI_REMEMARC into reLDCI_REMEMARC;
					end if; --if (cuLDCI_MARCA%NOTFOUND) then
					close cuLDCI_REMEMARC;

					return reLDCI_REMEMARC.RMMANDME;
			end fsbAtrTopeMedidor;

			function fnuGetCodigoInternoItem(isbCODE in GE_ITEMS.CODE%type) return NUMBER  AS
			/*
					PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
					PAQUETE       : LDCI_PKMOVIVENTMATE.fnuGetCodigoInternoItem
					AUTOR         : OLSoftware / Carlos E. Virgen
					FECHA         : 19/03/2013
					RICEF : I020,I038,I039,I040
					DESCRIPCION: Paquete que permite encapsula las operaciones de consulta de movimientos de material

				Historia de Modificaciones
				Autor   Fecha      Descripcion

			*/
	  nuCodInterno NUMBER;
			cursor cuGE_ITEMS(isbCODE GE_ITEMS.CODE%type) is
			  select ITEMS_ID
					   from GE_ITEMS
							where CODE =  isbCODE;
			BEGIN
					-- carga el cursor para deteminar el item
					open cuGE_ITEMS(isbCODE);
					fetch cuGE_ITEMS into nuCodInterno;
					close cuGE_ITEMS;

					return nuCodInterno;
			END fnuGetCodigoInternoItem;

			procedure proInsLDCI_SERIPOSI(inuSERITRSM in NUMBER,
                                    inuSERITSIT in NUMBER,
                                    isbSERINUME in VARCHAR2,
                                    inuSERISOMA in NUMBER,
                                    onuErrorCode    out NUMBER,
                                    osbErrorMessage out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : LDCI_PKMOVIVENTMATE.proInsLDCI_SERIPOSI
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 01-10-2013
						RICEF      : I100
						DESCRIPCION: Inserta un registro de serial en LDCI_SERIPOSI

					Historia de Modificaciones
					Autor         Fecha        Descripcion
			*/
      nuSERITRSM NUMBER;
			begin
		    onuErrorCode := 0;
--dbms_output.put_line('[382:<proInsLDCI_SERIPOSI>step inuSERITRSM ]' || inuSERITRSM);
--dbms_output.put_line('[382:<proInsLDCI_SERIPOSI>step inuSERITSIT ]' || inuSERITSIT);
--dbms_output.put_line('[382:<proInsLDCI_SERIPOSI>step isbSERINUME ]' || isbSERINUME);
--dbms_output.put_line('[382:<proInsLDCI_SERIPOSI>step inuSERISOMA ]' || inuSERISOMA);
        select LDCI_SEQSERIPOSI.nextval into nuSERITRSM
          from dual;
        insert into LDCI_SERIPOSI (SERITRSM,SERITSIT,SERINUME,SERISOMA)
          values (nuSERITRSM /*inuSERITRSM*/,inuSERITSIT,isbSERINUME,inuSERISOMA);
			exception
					When Others Then
					    onuErrorCode    := -1;
									osbErrorMessage := '[LDCI_PKMOVIVENTMATE.proInsLDCI_SERIPOSI]:' || chr(13) ||  'Error no controlado: ' || SQLERRM;
			end proInsLDCI_SERIPOSI;

			procedure proBorLDCI_SERIPOSI(inuSERITRSM in NUMBER,
                                    inuSERITSIT in NUMBER,
                                    isbSERINUME in VARCHAR2,
                                    inuSERISOMA in NUMBER,
                                    onuErrorCode    out NUMBER,
                                    osbErrorMessage out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : LDCI_PKMOVIVENTMATE.proBorLDCI_SERIPOSI
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 01-10-2013
						RICEF      : I100
						DESCRIPCION: Borra un registro de serial en LDCI_SERIPOSI

					Historia de Modificaciones
					Autor         Fecha        Descripcion
			*/

			begin
			   onuErrorCode := 0;
--dbms_output.put_line('[350:<proBorLDCI_SERIPOSI>step inuSERITRSM ]' || inuSERITRSM);
--dbms_output.put_line('[350:<proBorLDCI_SERIPOSI>step inuSERITSIT ]' || inuSERITSIT);
--dbms_output.put_line('[350:<proBorLDCI_SERIPOSI>step isbSERINUME ]' || isbSERINUME);
--dbms_output.put_line('[350:<proBorLDCI_SERIPOSI>step inuSERISOMA ]' || inuSERISOMA);
        delete LDCI_SERIPOSI
          where SERINUME = isbSERINUME
            and SERISOMA = inuSERISOMA
            /*and SERITSIT = inuSERITSIT*/;
			exception
					When Others Then
					    onuErrorCode    := -1;
									osbErrorMessage := '[LDCI_PKMOVIVENTMATE.proBorLDCI_SERIPOSI]:' || chr(13) ||  'Error no controlado: ' || SQLERRM;
			end proBorLDCI_SERIPOSI;

			procedure proActualizaLDCI_TRANSOMA(inuTRSMCODI     in NUMBER,
                                          inuTRSMESTA     in NUMBER,
                                          onuErrorCode    out NUMBER,
                                          osbErrorMessage out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : LDCI_PKMOVIVENTMATE.proActualizaLDCI_TRANSOMA
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 01-10-2013
						RICEF      : I100
						DESCRIPCION: Actualzia el encabezado de la solicitu de venta LDCI_TRANSOMA

					Historia de Modificaciones
					Autor         Fecha        Descripcion
			*/

			begin
			   onuErrorCode := 0;

				 update LDCI_TRANSOMA set TRSMESTA = inuTRSMESTA,  /*ESTADO 1- CREADO, 2- ENVIADO. 3 RECIBIDO, 4- ANULADO Pedido / Devolucion*/
                                     TRSMPROG = 'WS_MOVIMIENTO_MATERIAL'
						  where TRSMCODI = inuTRSMCODI;
			exception
					When Others Then
					    onuErrorCode    := -1;
									osbErrorMessage := '[LDCI_PKMOVIVENTMATE.proActualizaLDCI_TRANSOMA]:' || chr(13) ||  'Error no controlado: ' || SQLERRM;
			end proActualizaLDCI_TRANSOMA;

			procedure proActualizaLDCI_TRSOITEM(inuTSITSOMA     in NUMBER,
			                                   inuTSITITEM	    in NUMBER,
			                                   inuTSITCARE	    in NUMBER,
                                          inuTSITVUNI	    in NUMBER,
                                          inuTSITPIVA	    in NUMBER,
                                          isbTSITSAFI		  in VARCHAR2,
                                          isbTSITMABO	    in VARCHAR2,
                                          isbTSITVALO	    in VARCHAR2,
                                          isbMMITNATU     in VARCHAR2,
                                          onuErrorCode    out NUMBER,
                                          osbErrorMessage out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : LDCI_PKMOVIVENTMATE.proActualizaLDCI_TRSOITEM
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 01-10-2013
						RICEF      : I100
						DESCRIPCION: Actualzia el encabezado de la solicitu de venta LDCI_TRANSOMA

					Historia de Modificaciones
					Autor                                   Fecha        Descripcion
                    carlosvl<carlos.virgen@olsoftware.com>  26-11-2014   NC: 4008, 4009, 4010: Visualizacion si el item ha sido despachado total, paracial o rechazado
                    carlosvl<carlos.virgen@olsoftware.com>  13-01-2015   Aranda 138682: Ajuste: Manejo para el flag de estado cuando se procesa INSTATUSPEDIDO
                    carlosvl<carlos.virgen@olsoftware.com>  27-02-2015   Aranda 138682: Ajuste: Manejo para el flag isbTSITSAFI, para indicar que la salida final
			*/
      --NC: 4008, 4009, 4010 cursor para validar el estado del item en despacho
      cursor cuLDCI_TRSOITEM(inuTSITSOMA NUMBER, inuTSITITEM NUMBER) is
        select TSITSOMA, TSITITEM, nvl(TSITCANT,0) CANT_SOLICITADA, nvl(TSITCARE,0) CANT_RECIBIDA
          from LDCI_TRSOITEM
         where TSITSOMA = inuTSITSOMA
           and TSITITEM = inuTSITITEM;

      sbTSITESIT VARCHAR2(1) := NULL; --NC: 4008, 4009, 4010
      reLDCI_TRSOITEM cuLDCI_TRSOITEM%rowtype;--NC: 4008, 4009, 4010
			begin
          onuErrorCode := 0;

          --NC: 4008, 4009, 4010
          open cuLDCI_TRSOITEM(inuTSITSOMA, inuTSITITEM);
          fetch cuLDCI_TRSOITEM into reLDCI_TRSOITEM;
          close cuLDCI_TRSOITEM;

          --Si la marca de borrado esta llena es por que lo rechazaron
          if (isbTSITMABO is not null) then
              sbTSITESIT := 'R';
          else
              --Si la la cantidad recibida es mayo o igual a lo solicitado
              if ((reLDCI_TRSOITEM.CANT_RECIBIDA + inuTSITCARE) >=  reLDCI_TRSOITEM.CANT_SOLICITADA) then
                  sbTSITESIT := 'T';
              else
                  sbTSITESIT := 'P';
              end if;--if ((reLDCI_TRSOITEM.CANT_RECIBIDA + inuTSITCARE) >=  reLDCI_TRSOITEM.CANT_SOLICITADA) then
          end if;--if (isbTSITMABO is not null) then

		  if (isbTSITSAFI = 'C') then -- 138682: Manejo de la marca de salida final
              sbTSITESIT := 'T';
		  end if;--if (isbTSITSAFI = 'C') then



          if (isbMMITNATU = '=') then  --#10-11-2014: carlos.virgen: Se valida el status pedido

				if (isbTSITMABO is not null) then -- 138682 Se valida que el flag venga nulo, de lo contrario esta fija estado pendiente
				  sbTSITESIT := 'R';
				else
				  sbTSITESIT := 'P';
				end if;--if (isbTSITMABO is not null) then

			    if (isbTSITSAFI = 'C') then -- 138682: Manejo de la marca de salida final
				  sbTSITESIT := 'R';
			    end if;--if (isbTSITSAFI = 'C') then

                update LDCI_TRSOITEM set TSITCANT = inuTSITCARE,
                                         TSITSAFI	= isbTSITSAFI,
                                         TSITMABO	= isbTSITMABO,
                                         TSITVALO	= isbTSITVALO,
                                         TSITESIT =  sbTSITESIT /*NC: 4008, 4009, 4010: Estado del Item T: Despacho total - P: Parcial - R: Rechazado*/
                  where TSITSOMA = inuTSITSOMA
                      and TSITITEM = inuTSITITEM;
          else
               if (isbMMITNATU = '-') then
                      update LDCI_TRSOITEM set TSITCARE = nvl(TSITCARE,0) + inuTSITCARE,
                                              TSITVUNI  = 0,
                                              TSITPIVA	= 0,
                                              TSITSAFI	= isbTSITSAFI,
                                              TSITMABO	= isbTSITMABO,
                                              TSITVALO	= isbTSITVALO,
                                              TSITESIT =  sbTSITESIT /*NC: 4008, 4009, 4010: Estado del Item T: Despacho total - P: Parcial - R: Rechazado*/
                        where TSITSOMA = inuTSITSOMA
                          and TSITITEM = inuTSITITEM;
               else
                   if (isbMMITNATU = '+') then
                          update LDCI_TRSOITEM set TSITCARE = nvl(TSITCARE,0) + inuTSITCARE,
                                                  TSITVUNI  = inuTSITVUNI,
                                                  TSITPIVA	= inuTSITPIVA,
                                                  TSITSAFI	= isbTSITSAFI,
                                                  TSITMABO	= isbTSITMABO,
                                                  TSITVALO	= isbTSITVALO,
                                                  TSITESIT =  sbTSITESIT /*NC: 4008, 4009, 4010: Estado del Item T: Despacho total - P: Parcial - R: Rechazado*/
                            where TSITSOMA = inuTSITSOMA
                              and TSITITEM = inuTSITITEM;
                   end if;--if (isbMMITNATU = '+') then
               end if;--if (isbMMITNATU = '-') then
          end if;--if (isbMMITNATU = '=') then
			exception
					When Others Then
					    onuErrorCode    := -1;
              osbErrorMessage := '[LDCI_PKMOVIVENTMATE.proActualizaLDCI_TRSOITEM]:' || chr(13) ||  'Error no controlado: ' || SQLERRM;
      --dbms_output.put_line('[362:step ] osbErrorMessage ' || osbErrorMessage );
			end proActualizaLDCI_TRSOITEM;

			procedure proActuPosicionesSolVenta(inuDMITMMIT     in LDCI_DMITMMIT.DMITMMIT%type,
																																						onuErrorCode    out NUMBER,
																																						osbErrorMessage out VARCHAR2) as
					/*
								PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
								FUNCION    : LDCI_PKMOVIVENTMATE.proActuPosicionesSolVenta
								AUTOR      : OLSoftware / Carlos E. Virgen
								FECHA      : 24-09-2013
								RICEF      : I064
								DESCRIPCION: Crea un registro en la tabla LDCI_ITEMDOVE con la informaci??n del movimiento de venta

							Historia de Modificaciones
							Autor    Fecha       Descripcion
							carlosvl 24-09-2013  Crea el procedimiento
					*/
						nuITDVCODI LDCI_ITEMDOVE.ITDVCODI%type;
						nuITDVCOIN LDCI_ITEMDOVE.ITDVCOIN%type;
						-- Cursor de los items seriados
						cursor cuItemMovimiento(inuMMITCODI LDCI_INTEMMIT.MMITCODI%type) is
						-- lista la informacion de los seriales de un  movimiento

				  -- 09/11/2014 - Juan David Aragon
                  -- Se modifica forma de generar la cantidad, debido que cuando un despacho con MMITNATU es '=' esta dejan cantidad 1
                  -- y al llegar un segundo despacho con MMITNATU = '+' suma 1 + la cantidad real
                  -- Cambio: nvl(DMITCANT * decode(MMITNATU, '+',  1, '-', -1), 1) a nvl(DMITCANT * decode(MMITNATU, '+',  1, '-', -1), 0)
									select to_number(substr(MMITNUPE,instr(MMITNUPE,'-') + 1, LENGTH(MMITNUPE))) NRO_SOLICITUD,
                          MMITDSAP DOC_SAP,
                          DMITCOIN ITEM_OSF,
                          DMITITEM ITEM_SAP,
                          --nvl(DMITCANT * decode(MMITNATU, '+',  1, '-', -1), 1) as CANTIDAD,
                          nvl(DMITCANT * decode(MMITNATU,'=', 1, '+',  1, '-', -1), 0) as CANTIDAD,	--#10-11-2014: carlos.virgen: Se agrega la validacion del '='
                          DMITCAPE CANTIDAD_PENDIENTE,
                          DMITVAUN VALOR_UNITARIO,
                          DMITPIVA PROC_IVA,
                          DMITSAFI SALIDA_FINAL,
                          DMITVALO VALORACION,
                          DMITMABO MARCA_BORRADO,
                          MMITNATU NATURALEZA_MOV --#10-11-2014: carlos.virgen: Se coloca la naturaleza del moviento
											from LDCI_INTEMMIT,LDCI_DMITMMIT
										where MMITCODI = inuMMITCODI
												and MMITCODI = DMITMMIT;
			begin
						-- inicializa la posicion del detalle
						nuITDVCODI := 1;
						-- recorre las posiciones con seriales del movimiento e inserta los seriales vendidos
						for reItemMovimiento in cuItemMovimiento(inuDMITMMIT) loop

											LDCI_PKMOVIVENTMATE.proActualizaLDCI_TRSOITEM(inuTSITSOMA     => reItemMovimiento.NRO_SOLICITUD,
                                                                    inuTSITITEM	    => reItemMovimiento.ITEM_OSF,
                                                                    inuTSITCARE	    => reItemMovimiento.CANTIDAD,
                                                                    inuTSITVUNI	    => reItemMovimiento.VALOR_UNITARIO,
                                                                    inuTSITPIVA	    => reItemMovimiento.PROC_IVA,
                                                                    isbTSITSAFI			=> reItemMovimiento.SALIDA_FINAL,
                                                                    isbTSITMABO	    => reItemMovimiento.MARCA_BORRADO,
                                                                    isbTSITVALO	    => reItemMovimiento.VALORACION,
                                                                    isbMMITNATU     => reItemMovimiento.NATURALEZA_MOV,
                                                                    onuErrorCode    => onuErrorCode,
                                                                    osbErrorMessage => osbErrorMessage);
						end loop;--for reItemMovimiento in cuItemMovimiento(inuDMITMMIT) loop
			exception
					when others then
							osbErrorMessage := '[LDCI_PKMOVIVENTMATE.proActuPosicionesSolVenta]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proActuPosicionesSolVenta;

			function fclGetXMLAttributes(inuMovimiento in NUMBER,
			                             inuPosicion   in NUMBER,
																															 inuSerial     in NUMBER,
																															 isbDocSAP     in VARCHAR2,
																															 isbSerialSAP  in VARCHAR2,
																															 isbOrigen     in VARCHAR2)
						return CLOB is
			/*
				* Propiedad Intelectual Gases de Occidente SA ESP
				*
				* Script  : LDCI_PKMOVIVENTMATE.fclGetXMLAttributes
				* Tiquete : I032
				* Autor   : OLSoftware / Carlos E. Virgen Londo??o
				* Fecha   : 09-04-2013
				* Descripcion : Retorna el promedio de consumo
				*
				* Historia de Modificaciones
				* Autor                                        Fecha            Descripcion
				* carlosvl<carlos.virgen@olsoftware.com>       05-02-2014       #NC-42079: Se valida si el item seriado hace manejo de la estructura SAP en el serial
				*                                                                           Si maneja la esctructura debe calcula la descripcion de la marca de lo contrario no.
			**/

			   -- #NC-42079: carlosvl: 05-02-2014: Cursor para validar el la estructura
			   cursor cuLDCI_CONTESSE(sbCOESCOSA LDCI_CONTESSE.COESCOSA%type) is
        select			'S'
          from LDCI_CONTESSE
				  				where COESCOSA = sbCOESCOSA;

      -- cursor del item seriado (Asignacion por requisicion)
						cursor cuItemSeriadoConsumo(inuMovimiento NUMBER, inuPosicion NUMBER,inuSerial NUMBER) is
							select DMITITEM,  DMITCOIN, SERINUME,SERIESTR,SERIMARC,SERIANO,SERICAJA,SERIREMA,SERITIEN,DMITMARC
																from LDCI_INTEMMIT Mov, LDCI_DMITMMIT Det, LDCI_SERIDMIT Ser
																where Det.DMITMMIT = inuMovimiento
																		and Det.DMITCODI = inuPosicion
																		and Mov.MMITCODI = Det.DMITMMIT
																		and Ser.SERIMMIT = Det.DMITMMIT
																		and Ser.SERIDMIT = Det.DMITCODI
																		and Ser.SERICODI = inuSerial;

      -- cursor del item seriado (Asignacion por venta)
						cursor cuItemSeriadoVenta(isbDocSAP VARCHAR2, isbSerialSAP VARCHAR2) is
							select DMITITEM,  DMITCOIN, SERINUME,SERIESTR,SERIMARC,SERIANO,SERICAJA,SERIREMA,SERITIEN,DMITMARC
                from LDCI_INTEMMIT Mov, LDCI_DMITMMIT Det, LDCI_SERIDMIT Ser
                where Mov.MMITDSAP = isbDocSAP
                  and Mov.MMITCODI = Det.DMITMMIT
                  and Ser.SERIMMIT = Det.DMITMMIT
                  and Ser.SERIDMIT = Det.DMITCODI
                  and Ser.SERINUME = isbSerialSAP;

						-- Cursor del promedio de consumo
						cursor cuAttributes(inuITEMS_ID GE_ITEMS.ITEMS_ID%type) is
									select att.TECHNICAL_NAME as "TECHNICAL_NAME",
																1 as "VALUE"
											from GE_ENTITY_ATTRIBUTES att,
																GE_ITEMS_TIPO_ATR tiit_att,
																GE_ATTRIBUTES_TYPE ti_att,
																GE_ITEMS item
										where att.ENTITY_ATTRIBUTE_ID  = tiit_att.ENTITY_ATTRIBUTE_ID
												and ti_att.ATTRIBUTE_TYPE_ID = att.ATTRIBUTE_TYPE_ID
												and tiit_att.ID_ITEMS_TIPO   = item.ID_ITEMS_TIPO
												and item.ITEMS_ID            = inuITEMS_ID
												and tiit_att.REQUERIDO       = 'Y';

						sbCrtlEstrSerial VARCHAR2(1) := 'N'; -- -- #NC-42079: carlosvl: 05-02-2014: Flag para el control de la estructura
						oclXMLAttributes CLOB;
						reItemSeriado cuItemSeriadoConsumo%rowtype;
						sbDebug3655 VARCHAR2(200);

						------ variables caso 31 -----------
						nuCaso 		   varchar2(30):='0000031';
						------------------------------------
			begin

					ut_trace.trace('inicia fclGetXMLAttributes',16);
					ut_trace.trace('inuMovimiento: ' || inuMovimiento,17);
					ut_trace.trace('inuPosicion: ' || inuPosicion,17);
					ut_trace.trace('inuSerial: ' || inuSerial,17);
					ut_trace.trace('isbDocSAP: ' || isbDocSAP,17);
					ut_trace.trace('isbSerialSAP: ' || isbSerialSAP,17);
					ut_trace.trace('isbOrigen: ' || isbOrigen,17);

			  -- inicializa el mensaje XML
					oclXMLAttributes := null;
					oclXMLAttributes := '<ATTRIBUTES>' || chr(13);


					-- carga el item seriado mas los atributos llegados por interfaz
					if (isbOrigen = 'CONSUMO') then
							open cuItemSeriadoConsumo(inuMovimiento, inuPosicion,inuSerial);
							fetch cuItemSeriadoConsumo into reItemSeriado;
							close cuItemSeriadoConsumo;
					else
								if (isbOrigen = 'VENTA') then
					     ut_trace.trace(' if (isbOrigen = VENTA) then: isbDocSAP: ' || isbDocSAP,17);
					     ut_trace.trace(' if (isbOrigen = VENTA) then: isbSerialSAP: ' || isbSerialSAP,17);
										open cuItemSeriadoVenta(isbDocSAP, isbSerialSAP);
										fetch cuItemSeriadoVenta into reItemSeriado;
										close cuItemSeriadoVenta;
								end if;--if (isbOrigen = 'VENTA') then
					end if;--if (isbOrigen = 'CONSUMO') then

					-- #NC-42079: carlosvl: 05-02-2014:  Valida el listado de los items con seriales estructurados
					open cuLDCI_CONTESSE(reItemSeriado.DMITITEM);
					fetch cuLDCI_CONTESSE into sbCrtlEstrSerial;
					close cuLDCI_CONTESSE;

					ut_trace.trace('sbCrtlEstrSerial: ' || sbCrtlEstrSerial,17);
					ut_trace.trace('reItemSeriado.SERIMARC: ' || reItemSeriado.SERIMARC,17);
					ut_trace.trace('reItemSeriado.DMITCOIN: ' || reItemSeriado.DMITCOIN,17);

					-- recorre los atributos obligatorios
					for reAttributes in cuAttributes(reItemSeriado.DMITCOIN) loop

					  ut_trace.trace('reAttributes.TECHNICAL_NAME: ' || reAttributes.TECHNICAL_NAME,17);
					  ut_trace.trace('reItemSeriado.SERIMARC: ' || reItemSeriado.SERIMARC,17);
					  ut_trace.trace('reItemSeriado.SERIREMA: ' || reItemSeriado.SERIREMA,17);
					  -- #NC-2227: Se agrega la comparacion con el valor del parametro reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_TECHNICAL_NAME
					  if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_TECHNICAL_NAME
	  						    and sbCrtlEstrSerial = 'S' /*#NC-42079: carlosvl: 05-02-2014: Valida si controla estructura*/) then
									oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.SERIMARC || '-' || fsbGetDescMarca(reItemSeriado.SERIMARC) || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
					  end if;--if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_TECHNICAL_NAME) then

					  if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_TECHNICAL_NAME
	  						    and sbCrtlEstrSerial = 'N') then
									oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.SERIMARC || '-' || fsbGetDescMarca(-1) || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
					  end if;--if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_TECHNICAL_NAME) then

					  -- #FAC_CEV_3655_1: Se agrega la comparacion con el valor del parametro reWS_MOVIMIENTO_MATERIAL.ATT_MAXVALUE_TECHNICAL_NAME (Tope de medidor)
					  if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MAXVALUE_TECHNICAL_NAME
	  						    and sbCrtlEstrSerial = 'S') then
									oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || fsbAtrTopeMedidor(reItemSeriado.SERIMARC, reItemSeriado.SERIREMA) || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
					  end if;--if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_TECHNICAL_NAME) then

					  if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MAXVALUE_TECHNICAL_NAME
	  						    and sbCrtlEstrSerial = 'N') then
									oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || fsbAtrTopeMedidor(-1, -1) || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
					  end if;--if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_TECHNICAL_NAME) then


					  ------- caso 31 ------
					  IF fblAplicaEntregaxCaso(nuCaso) THEN

							--------- ATRIBUTO MODELO_VM ---------------
							if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MODELO_VM_TECHNICAL_NAME
	  						    and sbCrtlEstrSerial = 'S') then
									oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.DMITMARC || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
							end if;

							if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MODELO_VM_TECHNICAL_NAME
	  						    and sbCrtlEstrSerial = 'N') then
									oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.DMITMARC || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
							end if;

							--------- ATRIBUTO REFERENCIA_VM ---------------
							if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_REFERENCIA_VM_TEC_NAME
	  						    and sbCrtlEstrSerial = 'S') then
									oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.SERIREMA  || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
							end if;

							if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_REFERENCIA_VM_TEC_NAME
	  						    and sbCrtlEstrSerial = 'N') then
									oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.SERIREMA || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
							end if;

							--------- ATRIBUTO MARCA_VM ---------------
							if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_VM_TECHNICAL_NAME
	  						    and sbCrtlEstrSerial = 'S') then
									oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.SERIMARC || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
							end if;

							if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_VM_TECHNICAL_NAME
	  						    and sbCrtlEstrSerial = 'N') then
									oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.SERIMARC || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
							end if;


					  END IF;
					------- fin caso 31 ------


					end loop;--for reAttributes in cuAttributes(reItemSeriado.DMITCOIN) loop

					-- Cierra las etiquetas XML
					oclXMLAttributes := oclXMLAttributes || '</ATTRIBUTES>';

					-- Retorna el XML con los atibutos
					return oclXMLAttributes;
					ut_trace.trace('termina fclGetXMLAttributes',16);
			end fclGetXMLAttributes;

			function frfGetSoliVentaMaterial return LDCI_PKREPODATATYPE.tyRefcursor  AS
			/*
					PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
					PAQUETE       : LDCI_PKMOVIVENTMATE.frfGetSoliVentaMaterial
					AUTOR         : OLSoftware / Carlos E. Virgen
					FECHA         : 19/03/2013
					RICEF : I020,I038,I039,I040
					DESCRIPCION: Paquete que permite encapsula las operaciones de consulta de movimientos de material

				Historia de Modificaciones
				Autor   Fecha      Descripcion

			*/
					-- variables
					orfSoliVentaMaterial LDCI_PKREPODATATYPE.tyRefcursor;
					sbTRSMUNOP ge_boInstanceControl.stysbValue;
					inuTRSMUNOP NUMBER;

			BEGIN

			            sbTRSMUNOP  := ge_boInstanceControl.fsbGetFieldValue ('LDCI_TRANSOMA', 'TRSMUNOP');
						inuTRSMUNOP := to_number(sbTRSMUNOP);
						-- carga el cusor referenciado
						open orfSoliVentaMaterial for
							select TRSM.TRSMCODI as "SOLICITUD",
							       TRSM.TRSMCONT as "CONTRATISTA",
								   TRSM.TRSMUNOP as "UNIDAD OPERATIVA",
								   UNIO.NAME     as "NOMBRE UNIDAD",
								   TRSM.TRSMPROV as "PROVEEDOR LOGISTICO",
								   PROV.NAME     as "NOMBRE PROVEEDOR",
								   TRSM.TRSMUSMO as "USUARIO",
								   TRSM.TRSMFECR as "FECHA CREACION",
								   decode(TRSM.TRSMTIPO, 1, 'Solicitud', 2, 'Devolucion') as "TIPO",
								 decode(TRSM.TRSMESTA, 1,'CREADO', 2, 'ENVIADO',3,'RECIBIDO',4, 'ANULADO') as "ESTADO"
							  from LDCI_TRANSOMA TRSM,
								OR_OPERATING_UNIT UNIO,
								OR_OPERATING_UNIT PROV
							 where TRSM.TRSMUNOP = UNIO.OPERATING_UNIT_ID
							   and TRSM.TRSMPROV = PROV.OPERATING_UNIT_ID
							   and TRSMESTA = 2
							   and TRSMACTI = 'S'
							   and TRSM.TRSMUNOP = inuTRSMUNOP;
						return orfSoliVentaMaterial;
			EXCEPTION
						when ex.CONTROLLED_ERROR then
							raise;

						when OTHERS then
							Errors.setError;
							raise ex.CONTROLLED_ERROR;
			END frfGetSoliVentaMaterial;

			function frfGetMaterialVendido return LDCI_PKREPODATATYPE.tyRefcursor  AS
			/*
					PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
					PAQUETE       : LDCI_PKMOVIVENTMATE.frfGetMaterialVendido
					AUTOR         : OLSoftware / Carlos E. Virgen
					FECHA         : 19/03/2013
					RICEF : I064
					DESCRIPCION: Paquete que retorna el material vendido

				Historia de Modificaciones
				Autor   Fecha      Descripcion

			*/
					-- variables
					cnuNULL_ATTRIBUTE constant number := 2126;
					orfMoviMaterial LDCI_PKREPODATATYPE.tyRefcursor;
					sbDocuVenta     LDCI_DOCUVENT.DOVECODI%type;
					nuProveedor     number;
					nuUnidadOpe     LDCI_ITEMDOVE.ITDVOPUN%type;


					sbDOVECODI ge_boInstanceControl.stysbValue;
					sbITDVPROV ge_boInstanceControl.stysbValue;

					sbITDVCODI ge_boInstanceControl.stysbValue;
					sbITDVITEM ge_boInstanceControl.stysbValue;
					sbITDVCANT ge_boInstanceControl.stysbValue;
					sbITDVCAPE ge_boInstanceControl.stysbValue;
					sbITDVCOUN ge_boInstanceControl.stysbValue;
					sbITDVVAUN ge_boInstanceControl.stysbValue;
					sbITDVPIVA ge_boInstanceControl.stysbValue;
					sbITDVMARC ge_boInstanceControl.stysbValue;
					sbITDVSAFI ge_boInstanceControl.stysbValue;
					sbITDVMABO ge_boInstanceControl.stysbValue;
					sbITDVVALO ge_boInstanceControl.stysbValue;
					sbITDVOPUN ge_boInstanceControl.stysbValue;
					sbITDVSERI ge_boInstanceControl.stysbValue;
					sbDOVECLIE ge_boInstanceControl.stysbValue;--#NC-YYYYYX

			BEGIN
							-- carga los parametros del proceso
							sbDOVECODI := ge_boInstanceControl.fsbGetFieldValue ('LDCI_DOCUVENT', 'DOVECODI');
							sbITDVPROV := ge_boInstanceControl.fsbGetFieldValue ('LDCI_ITEMDOVE', 'ITDVPROV');
							sbITDVOPUN := ge_boInstanceControl.fsbGetFieldValue ('LDCI_ITEMDOVE', 'ITDVOPUN');
			    sbDOVECLIE := ge_boInstanceControl.fsbGetFieldValue ('LDCI_DOCUVENT', 'DOVECLIE'); --#NC-YYYYYX

						------------------------------------------------
						-- Required Attributes
						------------------------------------------------
						if (sbDOVECODI is null) then
										Errors.SetError (cnuNULL_ATTRIBUTE, 'NUMERO DOCUMENTO SAP');
										raise ex.CONTROLLED_ERROR;
						end if;

						if (sbITDVPROV is null) then
										Errors.SetError (cnuNULL_ATTRIBUTE, 'UNIDAD OPERATIVA PROVEEDOR LOG??STICO');
										raise ex.CONTROLLED_ERROR;
						end if;

						if (sbITDVOPUN is null) then
										Errors.SetError (cnuNULL_ATTRIBUTE, 'C??DIGO UNIDAD OPERATIVA');
										raise ex.CONTROLLED_ERROR;
						end if;

						if (sbDOVECLIE is null) then --#NC-YYYYYX
										Errors.SetError (cnuNULL_ATTRIBUTE, 'NIT DEL CLIENTE');
										raise ex.CONTROLLED_ERROR;
						end if;


						-- carga el cusor referenciado
						open orfMoviMaterial for
								select DOVECODI || '|' || ITDVCODI || '|' || sbITDVOPUN || '|' || sbITDVPROV as "POSICION",
														ITDVITEM	as "MATERIAL",
														DESCRIPTION as "DESCRIPCION",
														ITDVCANT	as "CANTIDAD DE MATERIAL",
														--ITDVCAPE	as "CANTIDAD PENDIENTE",
														--ITDVCOUN	as "COSTO UNITARIO",
														ITDVVAUN	as "VALOR UNITARIO",
														--ITDVPIVA	as "PORCENTAJE IVA",
														ITDVSERI	as "SERIE DEL ELEMENTO",
														ITDVMARC	as "MARCA DEL MATERIAL",
														ITDVSAFI	as "MARCA SALIDA FINAL",
														ITDVMABO	as "MARCA BORRADO",
														ITDVVALO	as "VALORACION N NUEVO / U USADO"
										from LDCI_DOCUVENT, LDCI_ITEMDOVE, GE_ITEMS
									where DOVECODI = sbDOVECODI
											and DOVECODI = ITDVDOVE
											and CODE = ITDVITEM  --#OYM_CEV_2740_1  ITEMS_ID --> CODE
											and ITDVOPUN is null;

						return orfMoviMaterial;
			EXCEPTION
						when ex.CONTROLLED_ERROR then
							raise;

						when OTHERS then
							Errors.setError;
							raise ex.CONTROLLED_ERROR;
			END frfGetMaterialVendido;

			PROCEDURE ProNotiMaestroMovMaterial(inuMovMatCodi in LDCI_INTEMMIT.MMITCODI%type,
																																						isbDocFront   in  LDCI_INTEMMIT.MMITNUDO%type,
																																						isbPedFront   in  LDCI_INTEMMIT.MMITNUPE%type,
																																						isbDocSap     in  LDCI_INTEMMIT.MMITDSAP%type,
																																						isbTipoMov    in  LDCI_INTEMMIT.MMITTIMO%type,
																																						isbDescMov    in  LDCI_INTEMMIT.MMITDESC%type,
																																						isbSigno      in  LDCI_INTEMMIT.MMITNATU%type,
																																						isbCliente    in  LDCI_INTEMMIT.MMITCLIE%type,
																																						idtFechaDoc   in  LDCI_INTEMMIT.MMITFESA%type,
																																						inuValorTotal in  LDCI_INTEMMIT.MMITVTOT%type,
																																						idtFechaVenc  in  LDCI_INTEMMIT.MMITFEVE%type) As

			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : ProNotiMaestroMovMaterial
						AUTOR      : Eduardo Aguera
						FECHA      : 26/01/2012
						RICEF      : I004; I018
						DESCRIPCION: Realiza la insercion de un movimiento de isbMaterial
																			contratistas/cuadrillas

					Historia de Modificaciones
					Autor    Fecha       Descripcion
					carlosvl 12/08/2011  Se hace la validacion de datos.
					carlosvl 17/09/2013  #NC-622: Se ajusta el procesamiento del identificador Front con el formato
																							[Letra(s) que identifican la empresa]-[Tipo de Movimiento]-[Numero de la Solicitud]/[Nombre del solicitante]
																							Ejemplo: GDO-Z03-335/995 JACK SPARROW
	*/
					sbData varchar2(200) := '';
					excepNoDocuFront 	EXCEPTION; 	-- Excepcion: No llega el documento FRONT.
					excepNoDocuSAP  	EXCEPTION; 	-- Excepcion: No llega el documento SAP.
					excepNoisbTipoMovi  	EXCEPTION; 	-- Excepcion: No llega el Tipo Movimiento.
					excepNoSignMovi  	EXCEPTION; 	-- Excepcion: No llega el isbSigno Movimiento.
					excepNoFechDocu  	EXCEPTION; 	-- Excepcion: No llega el Fecha Documento.
					excepNoFechVenc  	EXCEPTION; 	-- Excepcion: No llega el Fecha Vencimiento.
			Begin
					--<< Valida que los datos lleguen con valores
					if (isbDocFront is null and isbPedFront is null) then
						RAISE excepNoDocuFront;
					end if;--if (isbDocFront is null and isbPedFront is null) then

					/*if (isbDocSap is null) then
						RAISE excepNoDocuSAP;
					end if;--if (isbDocSap is null) then*/

					if (isbDescMov != 'INTSTATUSPEDIDO') then
									if (isbTipoMov is null) then
										RAISE excepNoisbTipoMovi;
									end if;--if (isbTipoMov is null) then

									if (isbSigno is null) then
										RAISE excepNoSignMovi;
									end if;--if (isbSigno is null) then
					end if;--if (isbDescMov = 'INTSTATUSPEDIDO') then
					-->>

					-- Determina la secuencia del motivo
					/*Select LDC_SEQINTEMMIT.Nextval Into inuMovMatCodi
							From Dual;*/

					-- Realiza la insercion del movimiento
					Insert Into LDCI_INTEMMIT (MMITCODI,
																															MMITNUDO,
																															MMITNUPE,
																															MMITDSAP,
																															MMITTIMO,
																															MMITDESC,
																															MMITNATU,
																															MMITCLIE,
																															MMITFESA,
																															MMITVTOT,
																															MMITESTA,
																															MMITFEVE)
																							values (inuMovMatCodi,
																															--#NC-622: carlosvl: 17/09/2013: Se remplaza el codigo  substr(trim(isbDocFront), 4, instr(trim(isbDocFront), '/', 1, 1) - 4) , por :
																															substr(trim(isbDocFront), instr(trim(isbDocFront), '-', 1, 2) + 1, instr(trim(isbDocFront), '/', 1, 1) - instr(trim(isbDocFront), '-', 1, 2) - 1),
																															isbPedFront,
																															isbDocSap,
																															decode(isbDescMov, 'INTSTATUSPEDIDO', 'STA',isbTipoMov),
																															isbDescMov,
																															decode(isbDescMov, 'INTSTATUSPEDIDO', '=',isbSigno),
																															isbCliente,
																															idtFechaDoc,
																															inuValorTotal,
																															'1',
																															idtFechaVenc);
			Exception
					when excepNoSignMovi then
							Raise_Application_Error(-20100, 'Error: No ha llegado isbSigno de Movimiento.');

					when excepNoisbTipoMovi then
							Raise_Application_Error(-20100, 'Error: No ha llegado Tipo de Movimiento.');

					when excepNoDocuFront then
							Raise_Application_Error(-20100, 'Error: No ha llegado el documento FRONT.');

					when excepNoDocuSAP then
							Raise_Application_Error(-20100, 'Error: No ha llegado el documento SAP.');

					When Others Then
							Raise_Application_Error(-20100, 'Error no controlado: '|| Sqlerrm || ' - ' || Dbms_Utility.Format_Error_Backtrace);
			End ProNotiMaestroMovMaterial;

			PROCEDURE proNotiDetalleMovMaterial(inuMovMatCodi    in  LDCI_DMITMMIT.DMITMMIT%type,
																																						inuDetMovMatCodi in  LDCI_DMITMMIT.DMITCODI%type,
																																						isbMaterial      in  LDCI_DMITMMIT.DMITITEM%type,
																																						inuCantidad      in  LDCI_DMITMMIT.DMITCANT%type,
																																						inuCantPend      in  LDCI_DMITMMIT.DMITCAPE%type,
																																						inuCostoUni      in  LDCI_DMITMMIT.DMITCOUN%type,
																																						inuValorUni      in  LDCI_DMITMMIT.DMITVAUN%type,
																																						inuPorcIva       in  LDCI_DMITMMIT.DMITPIVA%type,
																																						isbNumFac        in  LDCI_DMITMMIT.DMITNUFA%type,
																																						isbAlmDest       in  LDCI_DMITMMIT.DMITALDE%type,
																																						isbMarca         in  LDCI_DMITMMIT.DMITMARC%type,
																																						isbSaliFinal     in  LDCI_DMITMMIT.DMITSAFI%type,
																																						isbMarcBorrado   in  LDCI_DMITMMIT.DMITMABO%type,
																																						isbItemDoVal     in  VARCHAR2)
			As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : proNotiDetalleMovMaterial
						AUTOR      : Eduardo Aguera
						FECHA      : 26/01/2012
						RICEF      : I004; I018
						DESCRIPCION: Realiza la insercion del detalle del movimiento

					Historia de Modificaciones
					Autor    Fecha      Descripcion
			*/
					sbData varchar2(200) := '';
					nuDMITCOIN number;

					-- Cursor del encabezado del movimiento para detemrinar el status
					cursor cuLdcIntemmit(vDMITMMIT LDCI_DMITMMIT.DMITMMIT%type) is
						select *
								from LDCI_INTEMMIT
							where MMITCODI = vDMITMMIT;

					rtLdcIntemmit cuLdcIntemmit%rowtype; -- Cursor del encabezado del movimiento para detemrinar el estatus
			Begin

					--Select LDCI_SEQDMITMMIT.Nextval Into inuDetMovMatCodi From Dual;

					Sbdata:= inuMovMatCodi || ', ' || inuDetMovMatCodi || ', '|| isbMaterial || ',  '|| inuCantidad || ', ' || inuCostoUni;
					Sbdata:= Sbdata || ', ' || inuValorUni || ', ' || inuPorcIva || ', ' || isbNumFac || ', ' || isbAlmDest;

					-- Carga el encabezado del movimiento
					open cuLdcIntemmit(inuMovMatCodi);
					fetch cuLdcIntemmit into rtLdcIntemmit;
					close cuLdcIntemmit;

					nuDMITCOIN := fnuGetCodigoInternoItem(isbMaterial);

					-- Realiza la insercion en el detalle del movimiento de isbMaterial
					insert into LDCI_DMITMMIT (DMITMMIT,
																															DMITCODI,
																															DMITCOIN,
																															DMITITEM,
																															DMITCANT,
																															DMITCOUN,
																															DMITCAPE,
																															DMITVAUN,
																															DMITPIVA,
																															DMITNUFA,
																															DMITALDE,
																															DMITMARC,
																															DMITSAFI,
																															DMITMABO,
																															DMITVALO)
																															values
																														(inuMovMatCodi,
																															inuDetMovMatCodi,
																															nuDMITCOIN,
																															isbMaterial,
																															nvl(inuCantidad,0),
																															nvl(inuCostoUni,0),
																															nvl(inuCantPend,0),
																															nvl(inuValorUni,0),
																															nvl(inuPorcIva,0),
																															isbNumFac,
																															isbAlmDest,
																															isbMarca,
																															decode(isbSaliFinal, NULL, 'P','X','C', isbSaliFinal),
																															isbMarcBorrado,
																															decode(isbItemDoVal, 'USADO', 'U', 'N'));
			Exception
					When Others Then
							Raise_Application_Error(-20100, 'Error insertando detalle [ '|| sbData|| ']: '|| Sqlerrm || Dbms_Utility.Format_Error_Backtrace);
			END proNotiDetalleMovMaterial;

			Procedure ProNotiSerialDetaMovi(inuMovMatCodi    in LDCI_SERIDMIT.SERIMMIT%type,
																																		inuDetMovMatCodi in LDCI_SERIDMIT.SERIDMIT%type,
																																		inuSeriMatCodi   in LDCI_SERIDMIT.SERICODI%type,
																																		isbSerial        in LDCI_SERIDMIT.SERINUME%type) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : ProNotiSerialDetaMovi
						AUTOR      : Eduardo Aguera
						FECHA      : 26/01/2012
						RICEF      : I004; I018
						DESCRIPCION: Realiza la insercion del detalle del movimiento

					Historia de Modificaciones
					Autor   Fecha   Descripcion
			*/

				 -- cursor para validar el la estructura
				 cursor cuLDCI_CONTESSE(sbCOESCOSA LDCI_CONTESSE.COESCOSA%type) is
					select			'S'
					from LDCI_CONTESSE
					where COESCOSA = sbCOESCOSA;

				-- cursor para cargar la informacion de la posicion a validar
				cursor cuLDCI_DMITMMIT(nuDMITMMIT LDCI_DMITMMIT.DMITMMIT%type, nuDMITCODI LDCI_DMITMMIT.DMITCODI%type) is
						select *
							from LDCI_DMITMMIT
						where DMITMMIT = nuDMITMMIT
								and DMITCODI = nuDMITCODI;


				reLDCI_DMITMMIT				cuLDCI_DMITMMIT%rowtype;
			 sbMESG VARCHAR2(4000);
				sbCrtlEstrSerial VARCHAR2(1) := 'N';
			Begin

					open cuLDCI_DMITMMIT(inuMovMatCodi,inuDetMovMatCodi);
					fetch cuLDCI_DMITMMIT into reLDCI_DMITMMIT;
					close cuLDCI_DMITMMIT;

					-- valida el listado de los items con seriales estructurados
					open cuLDCI_CONTESSE(reLDCI_DMITMMIT.DMITITEM);
					fetch cuLDCI_CONTESSE into sbCrtlEstrSerial;
					close cuLDCI_CONTESSE;

					if (sbCrtlEstrSerial = 'S') then
						-- procesa el serial y lo almacena
						LDCI_PKMATSERIALIZADO.PROSETSERIE(SBESTRSERI => isbSerial, SBMESG => SBMESG);

						INSERT INTO LDCI_SERIDMIT(SERIMMIT,
												  SERIDMIT,
												  SERICODI,
												  SERINUME,
												  SERIESTR,
												  SERIMARC,
												  SERIANO,
												  SERICAJA,
												  SERIREMA,
												  SERITIEN  )
											VALUES
												 (INUMOVMATCODI,
												  INUDETMOVMATCODI,
												  INUSERIMATCODI,
												  LDCI_PKMATSERIALIZADO.fsbGetSerial,
												  LDCI_PKMATSERIALIZADO.fsbGetEstr,
												  LDCI_PKMATSERIALIZADO.fsbGetMarca,
												  LDCI_PKMATSERIALIZADO.fsbGetAno,
												  LDCI_PKMATSERIALIZADO.fsbGetCaja,
												  LDCI_PKMATSERIALIZADO.fsbRefMarc,
												  LDCI_PKMATSERIALIZADO.fsbTipoEnt);
					else
						-- almacena el serial tal como llega
						INSERT INTO LDCI_SERIDMIT(SERIMMIT,
						  						  SERIDMIT,
					  							  SERICODI,
												  SERINUME,
												  SERIESTR)
											VALUES
											(INUMOVMATCODI,
											 INUDETMOVMATCODI,
											 INUSERIMATCODI,
											 isbSerial,
											 isbSerial);
					end if;--if (sbCrtlEstrSerial = 'S') then

			Exception
					When Others Then
					 Raise_Application_Error(-20100, 'Error insertando seriales ITEM ' || reLDCI_DMITMMIT.DMITITEM || ' SERIE ' || isbSerial || ' ' || Sqlerrm || Dbms_Utility.Format_Error_Backtrace);
			END ProNotiSerialDetaMovi;

			procedure proActualizaMovimiento(inuMMITCODI in  LDCI_INTEMMIT.MMITCODI%type,
																																			isbTipo     in VARCHAR2,
																																			isMMITMENS  in  VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : proActualizaMovimiento
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 15-01-2013
						RICEF      : I004; I018
						DESCRIPCION: Actualiza la tabla LDCI_INTEMMIT

					Historia de Modificaciones
					Autor   Fecha   Descripcion
         Kbaquero   21/08/2015      #8481:Se coloca una excepcion dentro del loop para que en el momento
                                     en que hay un error, sea controlado y ademas continue el proceso con el resto de la informacion
			*/
				cursor cuLDCI_INTEMMIT(inuMovimiento LDCI_INTEMMIT.MMITCODI%type) is
					select *
							from LDCI_INTEMMIT
						where MMITCODI = inuMovimiento;

				reLDCI_INTEMMIT cuLDCI_INTEMMIT%rowtype;
				nuTRSMCODI number;  --138682
        onuErrorCode GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
        osbMesjErr GE_ERROR_LOG.DESCRIPTION%type;

			begin
							--dbms_output.put_line('[proActualizaMovimiento.inuMMITCODI]' || inuMMITCODI);
							--dbms_output.put_line('[proActualizaMovimiento.isbTipo]' || isbTipo);
							rollback;

							open cuLDCI_INTEMMIT(inuMMITCODI);
							fetch cuLDCI_INTEMMIT into reLDCI_INTEMMIT;
							close cuLDCI_INTEMMIT;

							if (isbTipo = 'INTENTO') then
									update LDCI_INTEMMIT set MMITMENS = isMMITMENS,
													         MMITINTE = MMITINTE + 1
									 where MMITCODI = inuMMITCODI;

        nuTRSMCODI := to_number(substr(reLDCI_INTEMMIT.MMITNUPE,instr(reLDCI_INTEMMIT.MMITNUPE,'-') + 1, LENGTH(reLDCI_INTEMMIT.MMITNUPE)));--138682
									proNotificaExcepcion(nuTRSMCODI,  --03-02-2015: 138682: Se agrega la funcionalidad para notificar excepcion por correo
									                     'Excepcion de procesamiento movimiento de material (Venta de Material), Mov. Ref. ' || nvl(reLDCI_INTEMMIT.MMITDSAP, 'N/A'),
														 isMMITMENS);
							end if;--if (isbTipo = 'INTENTO') then

							if (isbTipo = 'CONFIRMADO') then
									update LDCI_INTEMMIT set MMITESTA = 2
												where MMITCODI = inuMMITCODI;
							end if;--if (isbTipo = 'CONFIRMADO') then

							if (isbTipo = 'CERRAERR') then
									update LDCI_INTEMMIT set MMITESTA = 3,
																																		MMITMENS = isMMITMENS
												where MMITCODI = inuMMITCODI;
							end if;--if (isbTipo = 'CERRAERR') then

						commit;

            Exception
					When Others Then
            						commit;
                   -- proActualizaMovimiento(inuMMITCODI, 'INTENTO', SQLERRM);
					pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbMesjErr);
					Errors.seterror;
					Errors.geterror (onuErrorCode, osbMesjErr);

			end proActualizaMovimiento;

			procedure proSetRequestConf(inuMMITCODI in  LDCI_INTEMMIT.MMITCODI%type,
																														isbMMITTIMO in  LDCI_INTEMMIT.MMITTIMO%type,
																														inuDMITCODI in	 LDCI_DMITMMIT.DMITCODI%type,
																														isbDMITITEM in	 LDCI_DMITMMIT.DMITITEM%type,
																														ol_Payload  out CLOB,
																														osbMesjErr  out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : proSetRequestConf
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 15-01-2013
						RICEF      : I004
						DESCRIPCION: genera el XML al API OS_SET_REQUEST_CONF

					Historia de Modificaciones
					Autor   Fecha   Descripcion
			*/

				-- define variables
				qryCtx        DBMS_XMLGEN.ctxHandle;

				-- define excepciones
				excepNoProcesoRegi exception;
			begin
			-- genera el XML del encabezado
						-- valida el tipo de movimiento
						if(isbMMITTIMO in (reClaseMovi.sbMoviMate, reClaseMovi.sbClasSolMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbMoviHerr)) then
							-- tipos de movimiento Z01 Salida de Material / Z03 Salida de Herramientas
							qryCtx :=  Dbms_Xmlgen.Newcontext ('select
																	cursor(select MMITNUDO     as "DOCUMENT_ID",
																						        OPERATING_UNIT_ID as "OPERATING_UNIT_ID",
																						        CURRENT_DATE as "DELIVERYDATE"
																				      from LDCI_INTEMMIT, GE_ITEMS_DOCUMENTO
																								where MMITCODI = ' || to_char(inuMMITCODI) || '
																										and ID_ITEMS_DOCUMENTO = MMITNUDO) as "DOCUMENT",
																	cursor (select DMITITEM /*DMITCOIN*/ as "ITEM_CODE" ,
																			            	decode(DMITSAFI, ''C'', 0, ''P'',nvl(DMITCAPE,0), nvl(DMITCAPE,0)) as "QUANTITY",
																				           decode(DMITSAFI, ''C'', 0, ''P'',nvl(DMITCAPE,0), nvl(DMITCAPE,0)) * DMITCOUN as "COST"
																					from LDCI_DMITMMIT
																				where DMITMMIT = ' || to_char(inuMMITCODI) || '
																			and  DMITCODI = :inuDMITCODI
																			and DMITITEM = :isbDMITITEM) as "ITEMS" from dual');
						else
										if(isbMMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbClasDevMatAct /*#OYM_CEV_3429_1*/,reClaseMovi.sbDevoHerr)) then
													-- tipos de movimiento Z02 Devolucion de Material / Z04 Devolucion de Herramientas
													qryCtx :=  Dbms_Xmlgen.Newcontext ('select
																							cursor(select MMITNUDO     as "DOCUMENT_ID",
																												OPERATING_UNIT_ID as "OPERATING_UNIT_ID",
																												CURRENT_DATE as "DELIVERYDATE"
																										from LDCI_INTEMMIT, GE_ITEMS_DOCUMENTO
																									where MMITCODI = ' || to_char(inuMMITCODI) || '
																											and ID_ITEMS_DOCUMENTO = MMITNUDO) as "DOCUMENT",
																							cursor (select DMITITEM /*DMITCOIN*/ as "ITEM_CODE" ,
																										nvl(DMITCANT,0) + nvl(DMITCAPE,0) as "QUANTITY",
																										(nvl(DMITCANT,0) + nvl(DMITCAPE,0)) * DMITCOUN as "COST"
																											from LDCI_DMITMMIT
																										where DMITMMIT = ' || to_char(inuMMITCODI) || '
																									and  DMITCODI = :inuDMITCODI
																									and DMITITEM = :isbDMITITEM) as "ITEMS" from dual');
										end if;--if(isbMMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbDevoHerr)) then
						end if;--if(isbMMITTIMO in (reClaseMovi.sbMoviMate, reClaseMovi.sbMoviHerr)) then

						-- define las variables cl contexto qryCtx
						-- Asigna el valor de la variable :isbTipoRejeTras
						DBMS_XMLGEN.setBindvalue (qryCtx, 'inuDMITCODI', inuDMITCODI);
						DBMS_XMLGEN.setBindvalue (qryCtx, 'isbDMITITEM', isbDMITITEM);

						DBMS_XMLGEN.setRowSetTag(qryCtx, 'REQUEST_CONF');
						DBMS_XMLGEN.setRowTag(qryCtx, '');
						ol_Payload := dbms_xmlgen.getXML(qryCtx);
						--Valida si proceso registros
						if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
											RAISE excepNoProcesoRegi;
						end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

						dbms_xmlgen.closeContext(qryCtx);
						ol_Payload := replace(ol_Payload, '<DOCUMENT_ROW>',  '');
						ol_Payload := replace(ol_Payload, '</DOCUMENT_ROW>',  '');
						ol_Payload := replace(ol_Payload, '<ITEMS_ROW>',  '<ITEM>');
						ol_Payload := replace(ol_Payload, '</ITEMS_ROW>', '</ITEM>');
						ol_Payload := trim(ol_Payload);

			Exception
					WHEN excepNoProcesoRegi THEN
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proSetRequestConf]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
					When Others Then
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proSetRequestConf]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proSetRequestConf;

			procedure proGenXMLItemSeriVendido(isbDOVECODI in  LDCI_DOCUVENT.DOVECODI%type,
												inuITDVPROV in  LDCI_ITEMDOVE.ITDVPROV%type,
												inuITDVCODI in  LDCI_ITEMDOVE.ITDVCODI%type,
												isbITDVITEM in  LDCI_ITEMDOVE.ITDVITEM%type,
												inuITDVOPUN in  LDCI_ITEMDOVE.ITDVOPUN%type,
												isbTipoMovi in  VARCHAR2,
												ol_Payload  out CLOB,
												osbMesjErr  out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : proGenXMLItemSeriVendido
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 01-10-2013
						RICEF      : I064
						DESCRIPCION: genera el XML al API OS_LOADACCEPT_ITEMS

					Historia de Modificaciones
					Autor         Fecha        Descripcion
					carlos.virgen 27-05-2014   #FAC_CEV_3655_1: Ajuste para se ingresen los elementos seriados con costo cero
			*/
			 -- cursor de la posici??n vendida
			 cursor cuLDCI_ITEMDOVE(isbITDVDOVE in  LDCI_ITEMDOVE.ITDVDOVE%type, inuITDVCODI in  LDCI_ITEMDOVE.ITDVCODI%type) is
				  select ITDVDOVE, ITDVSERI
						  from LDCI_ITEMDOVE
							where ITDVDOVE = isbITDVDOVE
							  and ITDVCODI = inuITDVCODI;

				-- define variables
				qryCtx        DBMS_XMLGEN.ctxHandle;
				reLDCI_ITEMDOVE cuLDCI_ITEMDOVE%rowtype;

				-- define excepciones
				excepNoProcesoRegi exception;
			begin
						-- Si el tipo de movimiento es I, indica que incrementara en bodega y coloca la cantidad positiva
						if (isbTipoMovi = 'I') then
										-- genera el XML con cantidad positiva
										--#FAC_CEV_3655_1: Se ajusta la consulta del nuevo contexto para que el campo COST sea cero
                    -- to_char(DOVEFESA, ''DD/MM/YYYY'') as "DATE",
										qryCtx :=  Dbms_Xmlgen.Newcontext ('select :inuITDVPROV as "OPERUNIT_ORIGIN_ID",
                                                                :inuITDVOPUN as "OPERUNIT_TARGET_ID",
                                                                to_char(DOVEFESA, ''DD/MM/YYYY'') as "DATE",
                                                                DOVECODI as "DOCUMENT",
                                                                DOVECODI as "REFERENCE",
                                                                ITDVITEM /*ITDVCOIN*/ as "ITEM_CODE",
                                                                nvl(ITDVCANT * decode(DOVENATU, ''+'',  1, ''-'', -1), 0) as "QUANTITY",
                                                                0   /*ITDVVAUN*/ as "COST",
                                                                ITDVVALO as "STATUS",
                                                                ITDVSERI as "SERIE",
                                                                ''ATTRIBUTES'' as "ATTRIBUTES"
                                                      from LDCI_DOCUVENT, LDCI_ITEMDOVE
                                                    where DOVECODI = :isbDOVECODI
                                                        and ITDVCODI = :inuITDVCODI
                                                        and DOVECODI = ITDVDOVE');

										-- asigna las valores para la consulta
										DBMS_XMLGEN.setBindvalue (qryCtx, 'isbDOVECODI', isbDOVECODI);
										DBMS_XMLGEN.setBindvalue (qryCtx, 'inuITDVPROV', inuITDVPROV);
										DBMS_XMLGEN.setBindvalue (qryCtx, 'inuITDVCODI', inuITDVCODI);
										DBMS_XMLGEN.setBindvalue (qryCtx, 'inuITDVOPUN', inuITDVOPUN);

						end if;--if (isbTipoMovi = 'I') then

						DBMS_XMLGEN.setRowSetTag(qryCtx, 'ITEMS_LOADACEPT');
						DBMS_XMLGEN.setRowTag(qryCtx, '');
						ol_Payload := dbms_xmlgen.getXML(qryCtx);
						--Valida si proceso registros
						if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
											RAISE excepNoProcesoRegi;
						end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

						dbms_xmlgen.closeContext(qryCtx);

						open cuLDCI_ITEMDOVE(isbDOVECODI, inuITDVCODI);
						fetch cuLDCI_ITEMDOVE into reLDCI_ITEMDOVE;
						close cuLDCI_ITEMDOVE;

						-- determina los atributos del item seriado
						ol_Payload := replace(ol_Payload, '<ATTRIBUTES>ATTRIBUTES</ATTRIBUTES>',  nvl(fclGetXMLAttributes(null,
						                                                                                           null,
																																																																																																	null,
																																																																																																	reLDCI_ITEMDOVE.ITDVDOVE,
																																																																																																	reLDCI_ITEMDOVE.ITDVSERI,
																																																																																																	'VENTA'),''));


						ol_Payload := trim(ol_Payload);
			Exception
			WHEN excepNoProcesoRegi THEN
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proGenXMLItemSeriVendido]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
					When Others Then
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proGenXMLItemSeriVendido]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proGenXMLItemSeriVendido;

			procedure proGenXMLAceptItemSeriado(inuDMITMMIT in  LDCI_DMITMMIT.DMITMMIT%type,
																																						inuMMITCODI in  LDCI_INTEMMIT.MMITCODI%type,
																																						inuSERICODI in  LDCI_SERIDMIT.SERICODI%type,
																																						isbTipoMovi in  VARCHAR2,
																																						ol_Payload  out CLOB,
																																						osbMesjErr  out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : proGenXMLAceptItemSeriado
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 15-01-2013
						RICEF      : I004
						DESCRIPCION: genera el XML al API OS_LOADACCEPT_ITEMS

					Historia de Modificaciones
					Autor   Fecha   Descripcion
			*/
				-- cursor del item seriado
				cursor cuItemSeriado(inuDMITMMIT in  LDCI_DMITMMIT.DMITMMIT%type,
																								inuMMITCODI in  LDCI_INTEMMIT.MMITCODI%type,
																								inuSERICODI in  LDCI_SERIDMIT.SERICODI%type) is
							select  Doc.DESTINO_OPER_UNI_ID as "OPERUNIT_ORIGIN_ID",
														Doc.OPERATING_UNIT_ID as "OPERUNIT_TARGET_ID",
														Mov.MMITFESA as "DATE",
														Mov.MMITDSAP as "DOCUMENT",
														Mov.MMITDSAP as "REFERENCE",
														Det.DMITITEM as "ITEM_CODE",
														1 as "QUANTITY",
														Det.DMITCOUN as "COST",
														Det.DMITVALO as "STATUS",
														Ser.SERINUME as "SERIE"
							from LDCI_INTEMMIT Mov, LDCI_DMITMMIT Det, LDCI_SERIDMIT Ser, GE_ITEMS_DOCUMENTO Doc
							where Det.DMITCODI = inuMMITCODI
									and Det.DMITMMIT = inuDMITMMIT
									and Mov.MMITCODI = Det.DMITMMIT
									and Ser.SERIMMIT = Det.DMITMMIT
									and Ser.SERIDMIT = Det.DMITCODI
									and Doc.ID_ITEMS_DOCUMENTO = Mov.MMITNUDO
									and Ser.SERICODI = inuSERICODI;

				-- variables de tipo registro
				reItemSeriado cuItemSeriado%rowtype;
				-- define variables
				qryCtx        DBMS_XMLGEN.ctxHandle;

				-- define excepciones
				excepNoProcesoRegi exception;
			begin

						-- Si el tipo de movimiento es I, indica que incrementara en bodega y coloca la cantidad positiva
						if (isbTipoMovi = 'I') then
										-- genera el XML con cantidad positiva
										qryCtx :=  Dbms_Xmlgen.Newcontext ('select Doc.DESTINO_OPER_UNI_ID as "OPERUNIT_ORIGIN_ID",
																																																					Doc.OPERATING_UNIT_ID as "OPERUNIT_TARGET_ID",
																																																					to_char(Mov.MMITFESA,''DD/MM/YYYY'') as "DATE",
																																																					Mov.MMITDSAP as "DOCUMENT",
																																																					Mov.MMITDSAP as "REFERENCE",
																																																					Det.DMITITEM /*Det.DMITCOIN*/ as "ITEM_CODE",
																																																					1 as "QUANTITY",
																																																					Det.DMITCOUN as "COST",
																																																					Det.DMITVALO as "STATUS",
																																																					Ser.SERINUME as "SERIE",
																																																					''ATTRIBUTES'' as "ATTRIBUTES"
																																														from LDCI_INTEMMIT Mov, LDCI_DMITMMIT Det, LDCI_SERIDMIT Ser, GE_ITEMS_DOCUMENTO Doc
																																														where Det.DMITCODI = ' || to_char(inuMMITCODI) || '
																																																and Det.DMITMMIT = ' || to_char(inuDMITMMIT) || '
																																																and Mov.MMITCODI = Det.DMITMMIT
																																																and Ser.SERIMMIT = Det.DMITMMIT
																																																and Ser.SERIDMIT = Det.DMITCODI
																																																and Doc.ID_ITEMS_DOCUMENTO = Mov.MMITNUDO
																																																and Ser.SERICODI = ' || to_char(inuSERICODI));
						end if;--if (isbTipoMovi = 'I') then

						-- Si el tipo de movimiento es D, indica que disminuye en bodega y coloca la cantidad negativa
						if (isbTipoMovi = 'D') then
									-- genera el XML con cantidad negativa
									qryCtx :=  Dbms_Xmlgen.Newcontext ('select Doc.DESTINO_OPER_UNI_ID as "OPERUNIT_ORIGIN_ID",
																																																				Doc.OPERATING_UNIT_ID as "OPERUNIT_TARGET_ID",
																																																				to_char(Mov.MMITFESA,''DD/MM/YYYY'') as "DATE",
																																																				Mov.MMITDSAP as "DOCUMENT",
																																																				Mov.MMITDSAP as "REFERENCE",
																																																				Det.DMITITEM /*Det.DMITCOIN*/ as "ITEM_CODE",
																																																				-1 as "QUANTITY",
																																																				Det.DMITCOUN as "COST",
																																																				Det.DMITVALO as "STATUS",
																																																				Ser.SERINUME as "SERIE",
																																																				''ATTRIBUTES'' as "ATTRIBUTES"
																																													from LDCI_INTEMMIT Mov, LDCI_DMITMMIT Det, LDCI_SERIDMIT Ser, GE_ITEMS_DOCUMENTO Doc
																																													where Det.DMITCODI = ' || to_char(inuMMITCODI) || '
																																															and Det.DMITMMIT = ' || to_char(inuDMITMMIT) || '
																																															and Mov.MMITCODI = Det.DMITMMIT
																																															and Ser.SERIMMIT = Det.DMITMMIT
																																															and Ser.SERIDMIT = Det.DMITCODI
																																															and Doc.ID_ITEMS_DOCUMENTO = Mov.MMITNUDO
																																															and Ser.SERICODI = ' || to_char(inuSERICODI));
						end if;--if (isbTipoMovi = 'D') then

						-- Si el tipo de movimiento es R, indica que sera removido de la bodega del proveedor logistico y coloca la cantidad negativa
						-- Esta condicion aparece para el caso de una devolucion de material serializado aceptada y que necesita ser anuladaa
						if (isbTipoMovi = 'R')	then
									-- #TODO Se debe
									null;
						end if;--if (isbTipoMovi = 'R')

						DBMS_XMLGEN.setRowSetTag(qryCtx, 'ITEMS_LOADACEPT');
						DBMS_XMLGEN.setRowTag(qryCtx, '');
						ol_Payload := dbms_xmlgen.getXML(qryCtx);
						--Valida si proceso registros
						if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
											RAISE excepNoProcesoRegi;
						end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

						dbms_xmlgen.closeContext(qryCtx);

						/*-- determina los atributos del item seriado
						open cuItemSeriado(inuDMITMMIT, inuMMITCODI, inuSERICODI);
						fetch cuItemSeriado into reItemSeriado;
						close cuItemSeriado;*/
						ol_Payload := replace(ol_Payload, '<ATTRIBUTES>ATTRIBUTES</ATTRIBUTES>',  nvl(fclGetXMLAttributes(inuDMITMMIT,
						                                                                                           inuMMITCODI,
																																																																																																	inuSERICODI,
																																																																																																	null,
																																																																																																	null,
																																																																																																	'CONSUMO'),''));


						ol_Payload := trim(ol_Payload);
			Exception
			WHEN excepNoProcesoRegi THEN
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proGenXMLAceptItemSeriado]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
					When Others Then
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proGenXMLAceptItemSeriado]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proGenXMLAceptItemSeriado;

			procedure proGenXMLAceptItem(inuMMITCODI in  LDCI_INTEMMIT.MMITCODI%type,
																															inuDMITCODI in  LDCI_DMITMMIT.DMITCODI%type,
																															isbDMITITEM in  LDCI_DMITMMIT.DMITITEM%type,
																															isbTipoMovi in  VARCHAR2,
																															ol_Payload  out CLOB,
																															osbMesjErr  out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : proGenXMLAceptItem
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 15-01-2013
						RICEF      : I004
						DESCRIPCION: genera el XML al API OS_LOADACCEPT_ITEMS

					Historia de Modificaciones
					Autor   Fecha   Descripcion
			*/

				-- define variables
				qryCtx        DBMS_XMLGEN.ctxHandle;

				-- define excepciones
				excepNoProcesoRegi exception;
			begin
						if (isbTipoMovi = 'I') then
										-- genera el XML con la cantidad positiva
										qryCtx :=  Dbms_Xmlgen.Newcontext ('select  DESTINO_OPER_UNI_ID as "OPERUNIT_ORIGIN_ID",
																																																					OPERATING_UNIT_ID        as "OPERUNIT_TARGET_ID",
																																																					to_char(MMITFESA,''DD/MM/YYYY'') as "DATE",
																																																					MMITDSAP                 as "DOCUMENT",
																																																					MMITDSAP                 as "REFERENCE",
																																																					DMITITEM /*DMITCOIN */    as "ITEM_CODE",
																																																					DMITCANT                 as "QUANTITY",
																																																					DMITCANT * DMITCOUN      as "COST",
																																																					DMITVALO                 as "STATUS"
																																														from LDCI_INTEMMIT, LDCI_DMITMMIT, GE_ITEMS_DOCUMENTO
																																													where DMITCODI = ' || to_char(inuDMITCODI) || '
																																															and DMITMMIT = ' || to_char(inuMMITCODI) || '
																																															and DMITITEM = ' || isbDMITITEM || '
																																															and DMITMMIT = MMITCODI
																																															and ID_ITEMS_DOCUMENTO = MMITNUDO');
						else
										-- genera el XML con la cantidad negativa
										qryCtx :=  Dbms_Xmlgen.Newcontext ('select  DESTINO_OPER_UNI_ID as "OPERUNIT_ORIGIN_ID",
																																																					OPERATING_UNIT_ID        as "OPERUNIT_TARGET_ID",
																																																					to_char(MMITFESA,''DD/MM/YYYY'') as "DATE",
																																																					MMITDSAP                 as "DOCUMENT",
																																																					MMITDSAP                 as "REFERENCE",
																																																					DMITITEM  /*DMITCOIN*/    as "ITEM_CODE",
																																																					DMITCANT * -1            as "QUANTITY",
																																																					DMITCANT * DMITCOUN      as "COST",
																																																					DMITVALO                 as "STATUS"
																																														from LDCI_INTEMMIT, LDCI_DMITMMIT, GE_ITEMS_DOCUMENTO
																																													where DMITCODI = ' || to_char(inuDMITCODI) || '
																																															and DMITMMIT = ' || to_char(inuMMITCODI) || '
																																															and DMITITEM = ' || isbDMITITEM || '
																																															and DMITMMIT = MMITCODI
																																															and ID_ITEMS_DOCUMENTO = MMITNUDO');

						end if;--if (isbTipoMovi = 'I') then

						DBMS_XMLGEN.setRowSetTag(qryCtx, 'ITEMS_LOADACEPT');
						DBMS_XMLGEN.setRowTag(qryCtx, '');
						ol_Payload := dbms_xmlgen.getXML(qryCtx);
						--Valida si proceso registros
						if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
											RAISE excepNoProcesoRegi;
						end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

						dbms_xmlgen.closeContext(qryCtx);
						ol_Payload := trim(ol_Payload);

			Exception
			WHEN excepNoProcesoRegi THEN
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proGenXMLAceptItem]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
					When Others Then
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proGenXMLAceptItem]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proGenXMLAceptItem;

			procedure proGenXMLAcepTrasItemSeri(inuMMITCODI     in  LDCI_INTEMMIT.MMITCODI%type,
																																						inuDMITCODI     in  LDCI_DMITMMIT.DMITCODI%type,
																																						inuSERICODI     in  LDCI_SERIDMIT.SERICODI%type,
																																						isbRejectItem   in VARCHAR2,
																																						isbTipoRejeTras in VARCHAR2,
																																						ol_Payload      out CLOB,
																																						osbMesjErr      out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : proGenXMLAcepTrasItemSeri
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 15-01-2013
						RICEF      : I004
						DESCRIPCION: genera el XML al API OS_ACCEPT_ITEM

					Historia de Modificaciones
					Autor   Fecha   Descripcion
			*/

				-- define variables
				qryCtx        DBMS_XMLGEN.ctxHandle;

				-- define excepciones
				excepNoProcesoRegi exception;
			begin

						qryCtx :=  Dbms_Xmlgen.Newcontext ('select
																																									cursor(select DESTINO_OPER_UNI_ID as "OPERATING_UNIT",
																																											DMITITEM /*DMITCOIN*/  as "ITEM_CODE",
																																											SERINUME as "SERIE",
																																											1        as "QUANTITY",
																																											MMITDSAP as "SUPPORT_DOCUMENT"
																																										from LDCI_INTEMMIT, LDCI_DMITMMIT, LDCI_SERIDMIT, GE_ITEMS_DOCUMENTO
																																									where DMITCODI = ' || to_char(inuDMITCODI) || '
																																											and DMITMMIT = ' || to_char(inuMMITCODI) || '
																																											and SERICODI = ' || to_char(inuSERICODI)  || '
																																											and MMITCODI = DMITMMIT
																																											and SERIMMIT = DMITMMIT
																																											and SERIDMIT = DMITCODI
																																											and ID_ITEMS_DOCUMENTO = MMITNUDO) as "ITEM" from DUAL');

						-- valida si acepta o rechaza un item isbRejectItem [A]cepta / [R]echaza
						if (isbRejectItem = 'A') then
			DBMS_XMLGEN.setRowSetTag(qryCtx, 'ACEPT_ITEM');
			else
			if (isbRejectItem = 'R') then
			DBMS_XMLGEN.setRowSetTag(qryCtx, 'REJECT_ITEM');
			end if;--if (isbRejectItem = 'R') then
						end if;--if (isbRejectItem = 'A') then

						DBMS_XMLGEN.setRowTag(qryCtx, '');
						ol_Payload := dbms_xmlgen.getXML(qryCtx);
						--Valida si proceso registros
						if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
											RAISE excepNoProcesoRegi;
						end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

						dbms_xmlgen.closeContext(qryCtx);
						ol_Payload := replace(ol_Payload, '<ITEM_ROW>',  '');
						ol_Payload := replace(ol_Payload, '</ITEM_ROW>',  '');
						ol_Payload := trim(ol_Payload);
			Exception
			WHEN excepNoProcesoRegi THEN
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proGenXMLAcepTrasItemSeri]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
					When Others Then
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proGenXMLAcepTrasItemSeri]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proGenXMLAcepTrasItemSeri;--proGenXMLAcepTrasItemSeri;

			procedure proGenXMLRejectTrasItemSeri(inuID_ITEMS_DOCUMENTO in  NUMBER,
																																						  isbSERIE              in  VARCHAR2,
																																						  isbDOCSAP             in  VARCHAR2,
																																						  ol_Payload            out CLOB,
																																						  osbMesjErr            out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : proGenXMLRejectTrasItemSeri
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 18-12-2013
						RICEF      : NC-2229
						DESCRIPCION: genera el XML al API REJECT_ITEM

					Historia de Modificaciones
					Autor   Fecha   Descripcion
			*/

				-- define variables
				qryCtx        DBMS_XMLGEN.ctxHandle;

				-- define excepciones
				excepNoProcesoRegi exception;
			begin

						qryCtx :=  Dbms_Xmlgen.Newcontext ('select
																																																cursor
																																																(
																																																		select  /*+ LEADING(OR_UNI_ITEM_BALA_MOV)
																																																													INDEX(OR_UNI_ITEM_BALA_MOV IDX_OR_UNI_ITEM_BALA_MOV01)
																																																													INDEX(GE_ITEMS_SERIADO PK_GE_ITEMS_SERIADO)
																																																													INDEX(GE_ITEMS PK_GE_ITEMS)
																																																													INDEX(GE_ITEMS_DOCUMENTO PK_GE_ITEMS_DOCUMENTO)*/
																																																										OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID as "OPERATING_UNIT",
																																																										GE_ITEMS.CODE as "ITEM_CODE",
																																																										OR_UNI_ITEM_BALA_MOV.AMOUNT as "QUANTITY",
																																																										:isbDOCSAP as "SUPPORT_DOCUMENT",
																																																										GE_ITEMS_SERIADO.SERIE
																																																				from  OR_UNI_ITEM_BALA_MOV,
																																																										OR_OPE_UNI_ITEM_BALA,
																																																										GE_ITEMS_SERIADO,
																																																										GE_ITEMS,
																																																										GE_ITEMS_DOCUMENTO
																																																			where  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = GE_ITEMS.ITEMS_ID
																																																					and  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = OR_OPE_UNI_ITEM_BALA.ITEMS_ID
																																																					and  OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID = OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID
																																																					and  OR_UNI_ITEM_BALA_MOV.MOVEMENT_TYPE = ''N'' --OR_BOITEMSMOVE.CSBNEUTRALMOVETYPE
																																																					and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO = GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO
																																																					and  OR_UNI_ITEM_BALA_MOV.SUPPORT_DOCUMENT = '' ''
																																																					and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_SERIADO = GE_ITEMS_SERIADO.ID_ITEMS_SERIADO (+)
																																																					and  GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO = :inuID_ITEMS_DOCUMENTO
																																																					and  GE_ITEMS_SERIADO.SERIE = :isbSERIE
																																																) as "ITEM"
																																									from DUAL');

						-- Asigna el valor de la variable :isbTipoRejeTras
						DBMS_XMLGEN.setBindvalue (qryCtx, 'inuID_ITEMS_DOCUMENTO', inuID_ITEMS_DOCUMENTO);
						DBMS_XMLGEN.setBindvalue (qryCtx, 'isbSERIE', isbSERIE);
						DBMS_XMLGEN.setBindvalue (qryCtx, 'isbDOCSAP', isbDOCSAP);

						-- valida si acepta o rechaza un item isbRejectItem [A]cepta / [R]echaza
   			DBMS_XMLGEN.setRowSetTag(qryCtx, 'REJECT_ITEM');
						DBMS_XMLGEN.setRowTag(qryCtx, '');
						ol_Payload := dbms_xmlgen.getXML(qryCtx);
						--Valida si proceso registros
						if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
											RAISE excepNoProcesoRegi;
						end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

						dbms_xmlgen.closeContext(qryCtx);
						ol_Payload := replace(ol_Payload, '<ITEM_ROW>',  '');
						ol_Payload := replace(ol_Payload, '</ITEM_ROW>',  '');
						ol_Payload := trim(ol_Payload);
			Exception
			WHEN excepNoProcesoRegi THEN
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proGenXMLRejectTrasItemSeri]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
					When Others Then
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proGenXMLRejectTrasItemSeri]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proGenXMLRejectTrasItemSeri;--proGenXMLRejectTrasItemSeri;

			procedure proGenXMLAcepTrasItem(inuMMITCODI     in  LDCI_INTEMMIT.MMITCODI%type,
																																			inuDMITCODI     in  LDCI_DMITMMIT.DMITCODI%type,
																																			isbDMITITEM     in  LDCI_DMITMMIT.DMITITEM%type,
																																			isbRejectItem   in VARCHAR2,
																																			isbTipoRejeTras in VARCHAR2,
																																			ol_Payload      out CLOB,
																																			osbMesjErr      out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : proGenXMLAcepTrasItem
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 15-01-2013
						RICEF      : I004
						DESCRIPCION: genera el XML al API OS_ACCEPT_ITEM

					Historia de Modificaciones
					Autor   Fecha   Descripcion
			*/

				-- define variables
				qryCtx        DBMS_XMLGEN.ctxHandle;

				-- define excepciones
				excepNoProcesoRegi exception;
			begin
						-- genera el XML
						qryCtx :=  Dbms_Xmlgen.Newcontext ('select
																																															cursor(select DESTINO_OPER_UNI_ID as "OPERATING_UNIT",
																																																											DMITITEM /*DMITCOIN*/ as "ITEM_CODE",
																																																											decode(:isbTipoRejeTras,''T'', DMITCANT, ''P'', DMITCAPE, ''R'', DMITCAPE, DMITCANT) as "QUANTITY",
																																																											MMITDSAP as "SUPPORT_DOCUMENT"
																																									from LDCI_INTEMMIT, LDCI_DMITMMIT, GE_ITEMS_DOCUMENTO
																																				where DMITCODI = ' || to_char(inuDMITCODI) || '
																																						and DMITMMIT = ' || to_char(inuMMITCODI) || '
																																						and DMITITEM = ' || isbDMITITEM || '
																																						and MMITCODI = DMITMMIT
																																						and ID_ITEMS_DOCUMENTO = MMITNUDO) as "ITEM" from DUAL');

						-- Asigna el valor de la variable :isbTipoRejeTras
						DBMS_XMLGEN.setBindvalue (qryCtx, 'isbTipoRejeTras', isbTipoRejeTras);

						-- valida si acepta o rechaza un item isbRejectItem [A]cepta / [R]echaza
						if (isbRejectItem = 'A') then
			DBMS_XMLGEN.setRowSetTag(qryCtx, 'ACEPT_ITEM');
			else
			if (isbRejectItem = 'R') then
			DBMS_XMLGEN.setRowSetTag(qryCtx, 'REJECT_ITEM');
			end if;--if (isbRejectItem = 'R') then
						end if;--if (isbRejectItem = 'A') then

						DBMS_XMLGEN.setRowTag(qryCtx, '');
						ol_Payload := dbms_xmlgen.getXML(qryCtx);
						--Valida si proceso registros
						if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
											RAISE excepNoProcesoRegi;
						end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

						dbms_xmlgen.closeContext(qryCtx);
						ol_Payload := replace(ol_Payload, '<ITEM_ROW>',  '');
						ol_Payload := replace(ol_Payload, '</ITEM_ROW>',  '');
						ol_Payload := trim(ol_Payload);

			Exception
			WHEN excepNoProcesoRegi THEN
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proGenXMLAcepTrasItem]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
					When Others Then
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proGenXMLAcepTrasItem]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end ;--proGenXMLAcepTrasItem;

			procedure proAcepTrastItem(inuMovimiento in  LDCI_INTEMMIT.MMITCODI%type,
																													osbMesjErr    out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : proAcepTrastItem
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 15-01-2013
						RICEF      : I004
						DESCRIPCION: genera el XML al API OS_ACCEPT_ITEM

					Historia de Modificaciones
					Autor    Fecha      Descripcion
					carlosvl 16-10-2013 #NC-933   - Validacion para el item con cantidad cero y marca de borrado
					carlosvl 16-10-2013 #NC-2228  - NC:En la anulaci??n de un movimiento en SAP, cre?? un registro en OSF con un c??digo nuevo
					                                AJ:Se valida que en la anulacion de un traslado item seriado, este se encuentre en poder de una unidad operativa
																																    clasificacion 11-Proveedor Logistico

					carlosvl 16-10-2013 #NC-2229  - NC: Rechazo en SAP por la forma Reserva gener?? mensaje de Error
					                              - AJ: Se debe validar el indicador de salida final para determina el traslado parcial de una devolucion


			*/

		-- define cursores
		-- #NC-2229:19-12-2013:carlos.virgen: Cursor para extraer la informacion del item
  cursor cuGE_ITEMS(isbCODE VARCHAR2) is
			select ITEMS_ID, DESCRIPTION, ITEM_CLASSIF_ID, ID_ITEMS_TIPO, CODE
					from GE_ITEMS
				where CODE = isbCODE;

		-- #NC-2229:19-12-2013:carlos.virgen: Cursor para determinar los items en transito
  cursor cuItemSeriadoTransito(inuID_ITEMS_DOCUMENTO 	NUMBER, isbITEM_CODE VARCHAR2) is
					select  /*+ LEADING(OR_UNI_ITEM_BALA_MOV)
																INDEX(OR_UNI_ITEM_BALA_MOV IDX_OR_UNI_ITEM_BALA_MOV01)
																INDEX(GE_ITEMS_SERIADO PK_GE_ITEMS_SERIADO)
																INDEX(GE_ITEMS PK_GE_ITEMS)
																INDEX(GE_ITEMS_DOCUMENTO PK_GE_ITEMS_DOCUMENTO)*/
													GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO,
													TRUNC(MOVE_DATE) MOVE_DATE,
													GE_ITEMS.ITEMS_ID||' - '||GE_ITEMS.DESCRIPTION DESCRIPTION,
													GE_ITEMS.CODE CODE,
													OR_UNI_ITEM_BALA_MOV.AMOUNT,
													OR_UNI_ITEM_BALA_MOV.TOTAL_VALUE,
													GE_ITEMS_SERIADO.SERIE,
													OR_UNI_ITEM_BALA_MOV.TARGET_OPER_UNIT_ID OPERATING_UNIT_ID,
													OR_UNI_ITEM_BALA_MOV.USER_ID,
													OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID TARGET_OPER_UNIT_ID
							from  OR_UNI_ITEM_BALA_MOV,
													OR_OPE_UNI_ITEM_BALA,
													GE_ITEMS_SERIADO,
													GE_ITEMS,
													GE_ITEMS_DOCUMENTO
						where  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = GE_ITEMS.ITEMS_ID
								and  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = OR_OPE_UNI_ITEM_BALA.ITEMS_ID
								and  OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID = OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID
								and  OR_UNI_ITEM_BALA_MOV.MOVEMENT_TYPE = 'N' --OR_BOITEMSMOVE.CSBNEUTRALMOVETYPE
								and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO = GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO
								and  OR_UNI_ITEM_BALA_MOV.SUPPORT_DOCUMENT = ' '
								and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_SERIADO = GE_ITEMS_SERIADO.ID_ITEMS_SERIADO (+)
								and  GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO
								and  GE_ITEMS.CODE = isbITEM_CODE;

		-- #NC-2228: cursor para validar si un item seriado se encuenta en poder de una unidad operativa proveedor logistico
		cursor cuCHECK_GE_ITEMS_SERIADO(isbSERIE GE_ITEMS_SERIADO.SERIE%type) is
			select its.ITEMS_ID, its.SERIE, its.OPERATING_UNIT_ID, uop.OPER_UNIT_CLASSIF_ID
					from GE_ITEMS_SERIADO its, OR_OPERATING_UNIT uop
				where its.SERIE = isbSERIE
						and uop.OPERATING_UNIT_ID = its.OPERATING_UNIT_ID
						and uop.OPER_UNIT_CLASSIF_ID = 11;


		-- cursor del detalle del movimeinto de material
		cursor cuDetalleMovimiento(inuDMITMMIT LDCI_DMITMMIT.DMITMMIT%type) is
				select MMITCODI, MMITNUDO, MMITTIMO, MMITNATU, MMITDSAP, LDCI_DMITMMIT.*
						from LDCI_INTEMMIT,LDCI_DMITMMIT
					where DMITMMIT = MMITCODI
							and MMITCODI = inuDMITMMIT;

		-- cursor para detemrinar si una posicion tiene detalle de seriales o no
		cursor cuCuentaisbSeriales(inuSERIMMIT LDCI_SERIDMIT.SERIMMIT%type,
									inuSERIDMIT LDCI_SERIDMIT.SERIDMIT%type) is
					select count(*)
							from LDCI_SERIDMIT
						where SERIMMIT = inuSERIMMIT
								and SERIDMIT = inuSERIDMIT;

					-- cursor para listar el detalle de seriales
					cursor cuDetalleisbSeriales(inuSERIMMIT LDCI_SERIDMIT.SERIMMIT%type,
																															inuSERIDMIT LDCI_SERIDMIT.SERIDMIT%type) is
							select SERIMMIT,SERIDMIT,SERICODI, SERINUME
									from LDCI_SERIDMIT
								where SERIMMIT = inuSERIMMIT
										and SERIDMIT = inuSERIDMIT
									order by SERIMMIT,SERIDMIT,SERICODI;

					-- cursor del documento. Usado para determinar el tipo del documento
					cursor cuGE_ITEMS_DOCUMENTO(inuID_ITEMS_DOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%type) is
							select ID_ITEMS_DOCUMENTO, DOCUMENT_TYPE_ID, OPERATING_UNIT_ID, DESTINO_OPER_UNI_ID
									from GE_ITEMS_DOCUMENTO
								where ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO;

					-- cursor para determinar si el numero de serie ya esta asignado (Caso de anulacion de un despacho)
					cursor cuGE_ITEMS_SERIADO(isbSERIE            in GE_ITEMS_SERIADO.SERIE%type,
																													inuOPERATING_UNIT_ID in GE_ITEMS_SERIADO.OPERATING_UNIT_ID%type)	 is
							select SERIE, OPERATING_UNIT_ID
								from GE_ITEMS_SERIADO
								where SERIE = isbSERIE
										and OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;

					-- registro de   cuGE_ITEMS_SERIADO
					reGE_ITEMS_SERIADO	cuGE_ITEMS_SERIADO%rowtype;
					-- registro de cuGE_ITEMS_DOCUMENTO
					reGE_ITEMS_DOCUMENTO cuGE_ITEMS_DOCUMENTO%rowtype;
					-- #NC-2228 registro de cuGE_ITEMS_SERIADO
					reCHECK_GE_ITEMS_SERIADO cuCHECK_GE_ITEMS_SERIADO%rowtype;
					-- #NC-2229 registro de cuGE_ITEMS
					reGE_ITEMS cuGE_ITEMS%rowtype;

					-- define variables
					l_Payload      CLOB;
					nuisbSeriales  NUMBER;
					nuErrorCode    NUMBER;
					sbRejectItem   VARCHAR2(1);
					sbTipoRejeTras VARCHAR2(1);   -- flag tipo rechazo de tralado [T]otal ; [P]Parcial ; [N]o aplica
					onuTipoItemId  NUMBER;
					onuItemsGamaId NUMBER;
					sbAPI          VARCHAR2(100);
					sbITEM         VARCHAR2(18);
					sbSERIE        VARCHAR2(20);

					-- define excepciones
					excepNoProcesoRegi           exception;
					excepOS_ACCEPT_ITEM          exception;
					excep_OS_ITEMMOVEOPERUNIT    exception;
					excep_OS_SET_MOVE_ITEM       exception;
					excepOS_LOADACCEPT_ITEMS		   exception;
		   excep_CHECK_GE_ITEMS_SERIADO exception; -- #NC-2228
			begin

					-- recorre los items de la solicitud
					for reDetalleMovimiento in cuDetalleMovimiento(inuMovimiento) loop
					   -- registra el item que se esta procesando
   					sbITEM  := reDetalleMovimiento.DMITITEM;
			   		sbSERIE := 'N.A.';

								-- carga el documento para determina las unidades operativas involucradas
								open cuGE_ITEMS_DOCUMENTO(to_number(reDetalleMovimiento.MMITNUDO));
								fetch cuGE_ITEMS_DOCUMENTO into reGE_ITEMS_DOCUMENTO;
								close cuGE_ITEMS_DOCUMENTO;

								sbRejectItem   := 'A';
								sbTipoRejeTras := 'N';

								--NC-933: Valida la marca de borrado para cuando la cantidad es mayor que cero
								-- valida si se rechaza la posicion o si es aceptada
								if (reDetalleMovimiento.DMITMABO is not null or reDetalleMovimiento.DMITMABO <> ''
								    and reDetalleMovimiento.DMITCANT <> 0
												and reDetalleMovimiento.DMITCAPE = 0) then
										sbRejectItem   := 'R';
										sbTipoRejeTras := 'T';
								end if; --if ((reDetalleMovimiento.DMITMABO <> null or reDetalleMovimiento.DMITMABO <> ''...)

								-- #NC-2229:19-12-2013:carlos.virgen: Rechazo total realizado desde la opci??n reserva de SAP
								if (reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITCAPE = 0
												and (reDetalleMovimiento.DMITSAFI = 'C' or reDetalleMovimiento.DMITMABO is not null)) then
										sbRejectItem   := 'R';
										sbTipoRejeTras := 'T';
								end if;--if (reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'C'

								--NC-933: Valida la marca de borrado para cuando la cantidad es menor que cero y cantidad pendiente es mayor que cero
								-- valida si se rechaza la posicion o si es aceptada
								if (reDetalleMovimiento.DMITMABO is not null or reDetalleMovimiento.DMITMABO <> ''
								    and reDetalleMovimiento.DMITCANT = 0
												and reDetalleMovimiento.DMITCAPE <> 0) then
										sbRejectItem   := 'R';
										sbTipoRejeTras := 'R';
								end if; --if ((reDetalleMovimiento.DMITMABO <> null or reDetalleMovimiento.DMITMABO <> ''...)

								-- Determina si el traslado es parcial y se rechaza una parte de el
								if (reDetalleMovimiento.DMITCANT <> 0 and reDetalleMovimiento.DMITSAFI = 'C'
												and reDetalleMovimiento.DMITCAPE <> 0) then
										sbRejectItem   := 'R';
										sbTipoRejeTras := 'P';
								end if;--if (reDetalleMovimiento.DMITCANT <> 0 and reDetalleMovimiento.DMITSAFI = 'C'

								-- Rechazo total realizado desde la opci??n MIGO de SAP
								if (reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'C'
												and reDetalleMovimiento.DMITCAPE <> 0) then
										sbRejectItem   := 'R';
										sbTipoRejeTras := 'R';
								end if;--if (reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'C'

								-- determina si el item es isbSerializado
								open cuCuentaisbSeriales(inuMovimiento, reDetalleMovimiento.DMITCODI);
								fetch cuCuentaisbSeriales into nuisbSeriales;
								close cuCuentaisbSeriales;

								--#NC-2229:19-12-2013:carlos.virgen: Determina si el item procesao es seriado o no
								open cuGE_ITEMS(reDetalleMovimiento.DMITITEM);
								fetch cuGE_ITEMS into reGE_ITEMS;
								close cuGE_ITEMS;

								-- valida si el item tiene isbSeriales
								if (reGE_ITEMS.ITEM_CLASSIF_ID = 21) then
								  if (nuisbSeriales <> 0 and sbTipoRejeTras in ('N','P')) then
													-- recorre los isbSeriales para generar el XML
													for reDetalleisbSeriales in cuDetalleisbSeriales(inuMovimiento, reDetalleMovimiento.DMITCODI) loop
																							sbSERIE := reDetalleisbSeriales.SERINUME;
																							-- valida el tipo de movimiento Z02 Devolucion Material / Z04 Devolucion de Herramienta
																							if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbClasDevMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbDevoHerr)) then
																											-- genera xml para los items isbSerializados
																											proGenXMLAcepTrasItemSeri(reDetalleisbSeriales.SERIMMIT,
																																																					reDetalleisbSeriales.SERIDMIT,
																																																					reDetalleisbSeriales.SERICODI,
																																																					'A',	--#NC-2229:19-12-2013:carlos.virgen: Se cambia sbRejectItem por 'A'
																																																					sbTipoRejeTras,
																																																					l_Payload,
																																																					osbMesjErr);

																											-- valida si pudo generar el XML para el llamado OS_LOADACCEPT_ITEMS
																											if (osbMesjErr is not null) then
																													raise excepNoProcesoRegi;
																											end if;--if (osbMesjErr is not null) then

																											/* --#NC-2229:19-12-2013:carlos.virgen: Se comenta el codigo de la version anterior
																											-- hace el llamado al API para hacer el ingreso del item
																											if (sbRejectItem = 'A') then
																														sbAPI := 'OS_ACCEPT_ITEM';
																														OS_ACCEPT_ITEM(l_Payload,nuErrorCode, osbMesjErr);
																														-- #TODO
																														-- se debe generar el codigo del OS_LOADACCEPT_ITEMS para eliminar el registro de la unidad proveedora
																														-- se debe ejecutar el llamado OS_LOADACCEPT_ITEMS
																											else
																															if (sbRejectItem = 'R') then
																																	sbAPI := 'OS_REJECT_ITEM';
																																	OS_REJECT_ITEM(l_Payload,nuErrorCode, osbMesjErr);
																															end if;-- if (sbRejectItem = 'R') then
																											end if;-- if (sbRejectItem = 'A') then			 */

																											--#NC-2229:19-12-2013:carlos.virgen: Se hace el llamado al API OS_ACCEPT_ITEM para aceptar total o parcialmente
																											sbAPI := 'OS_ACCEPT_ITEM';
																											OS_ACCEPT_ITEM(l_Payload,nuErrorCode, osbMesjErr);
																											-- valida si OS_ACCEPT_ITEM se ejecuto con exito
																											if (nuErrorCode <> 0) then
																													raise excepOS_ACCEPT_ITEM;
																											end if;--if (onuErrorCode <> 0) then
																								else
																											-- tipo de movimiento Z01 Movimiento de Material / Z03 Movimiento de Heramientas (Anulacion de Traslados / Devolucion)
																											if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate, reClaseMovi.sbClasSolMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbMoviHerr)) then
																													-- ini:#NC-2228 valida que un proveedor logistico tenga en su poder el serial que se esta procesando
																													open cuCHECK_GE_ITEMS_SERIADO(reDetalleisbSeriales.SERINUME);
																													fetch cuCHECK_GE_ITEMS_SERIADO into reCHECK_GE_ITEMS_SERIADO;

																													-- si el item seriado existe en bodega del proveedor logistico, procede a moverlo a la bodega de unidad operativa
																													if (cuCHECK_GE_ITEMS_SERIADO%FOUND) then
																															-- Mueve el serial del proveedor logistico a la unidad operativa
																															/* Versi??n haciendo uso del API :OS_LOADACCEPT_ITEMS
																															-- Genera el XML para el API OS_LOADACCEPT_ITEMS, indicando que suma al inventario*/
																															proGenXMLAceptItemSeriado(reDetalleisbSeriales.SERIMMIT,
																																																									reDetalleisbSeriales.SERIDMIT,
																																																									reDetalleisbSeriales.SERICODI,
																																																									'I',
																																																									l_Payload,
																																																									osbMesjErr);
																															-- valida si OS_LOADACCEPT_ITEMS se ejecuto con exito
																															if (osbMesjErr is not null) then
																																	raise excepNoProcesoRegi;
																															end if;--if (osbMesjErr is not null) then

																															OS_LOADACCEPT_ITEMS(l_Payload,nuErrorCode, osbMesjErr);
																															-- valida si OS_LOADACCEPT_ITEMS se ejecuto con exito
																															if (nuErrorCode <> 0) then
																																	raise excepOS_LOADACCEPT_ITEMS;
																															end if;--if (onuErrorCode <> 0) then
																															close cuCHECK_GE_ITEMS_SERIADO;
																													else
																															close cuCHECK_GE_ITEMS_SERIADO;
																															raise excep_CHECK_GE_ITEMS_SERIADO;
																													end if;--if (cuCHECK_GE_ITEMS_SERIADO%FOUND) then
																													-- eof:#NC-2228 valida que un proveedor logistico tenga en su poder el serial que se esta procesando
																											end if;--if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate,reClaseMovi.sbMoviHerr)) then
																							end if;--if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbDevoHerr)) then
													end loop; --for reDetalleisbSeriales in cuDetalleisbSeriales(inuMovimiento, reDetalleMovimiento.DMITMMIT) loop
								  end if;--if (nuisbSeriales <> 0 and sbTipoRejeTras in ('N','P')) then

          --ini:#NC-2229:19-12-2013:carlos.virgen: Valida si el rechazo si tiene marca de concluido para rechazar la cantidad pendiente
										-- procesa tralado parcial y rechazo de la cantida pendiente
										if (sbRejectItem = 'R' and sbTipoRejeTras in ('R','P','T')) then
           -- recorre el detalle de los items seriados que se van a rechazar
											for reItemSeriadoTransito in cuItemSeriadoTransito(reDetalleMovimiento.MMITNUDO, reDetalleMovimiento.DMITITEM) loop
											     -- genera el XML para hacer la ejeucion del REJECT
																proGenXMLRejectTrasItemSeri(reItemSeriadoTransito.ID_ITEMS_DOCUMENTO,
																																												reItemSeriadoTransito.SERIE,
																																												reDetalleMovimiento.MMITDSAP,
																																												l_Payload,
																																												osbMesjErr);
																if (osbMesjErr is not null) then
																		raise excepNoProcesoRegi;
																end if;--if (osbMesjErr is not null) then

																sbAPI := 'OS_REJECT_ITEM';
																OS_REJECT_ITEM(l_Payload, nuErrorCode, osbMesjErr);

																-- valida si OS_ACCEPT_ITEM / OS_REJECT_ITEM se ejecuto con exito
																if (nuErrorCode <> 0) then
																		raise excepOS_ACCEPT_ITEM;
																end if;--if (onuErrorCode <> 0) then
											end loop;--for reItemSeriadoTransito in cuItemSeriadoTransito loop ...
										end if;--if (sbRejectItem = 'R' and sbTipoRejeTras in ('R','P','T')) then
          --eof:#NC-2229:19-12-2013:carlos.virgen: Valida si el rechazo si tiene marca de concluido para rechazar la cantidad pendiente
								else
												-- valida el tipo de movimiento Z02 Devolucion Material / Z04 Devolucion de Herramienta
												if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbClasDevMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbDevoHerr)) then
																	-- procesa una aceptacion de tralado o un rechazo total del tralado
																		if (sbTipoRejeTras in ('N', 'T', 'R')) then
																				-- genera xml para los item no isbSerialziados
																				proGenXMLAcepTrasItem(inuMovimiento,
																																										reDetalleMovimiento.DMITCODI,
																																										reDetalleMovimiento.DMITITEM,
																																										sbRejectItem,
																																										sbTipoRejeTras,
																																										l_Payload,
																																										osbMesjErr);

																				-- valida si pudo generar el XML para el llamado OS_LOADACCEPT_ITEMS
																				if (osbMesjErr is not null) then
																						raise excepNoProcesoRegi;
																				end if;--if (osbMesjErr is not null) then

																				-- valida si acepta el item o lo rechaza
																				-- acepta el item para el traslado
																				if (sbRejectItem = 'A') then
																						-- hace el llamado al API para hacer el ingreso del item
																						sbAPI := 'OS_ACCEPT_ITEM';
																						OS_ACCEPT_ITEM(l_Payload, nuErrorCode, osbMesjErr);
																				else
																								-- rechaza el tralado del item
																								if (sbRejectItem = 'R') then
																									-- hace el llamado al API para hacer el ingreso del item
																									sbAPI := 'OS_REJECT_ITEM';
																									OS_REJECT_ITEM(l_Payload, nuErrorCode, osbMesjErr);
																								end if;--if (sbRejectItem = 'R') then
																				end if;--if (sbRejectItem = 'A') then

																				-- valida si OS_ACCEPT_ITEM / OS_REJECT_ITEM se ejecuto con exito
																				if (nuErrorCode <> 0) then
																						raise excepOS_ACCEPT_ITEM;
																				end if;--if (onuErrorCode <> 0) then
																	end if;--if (sbTipoRejeTras in ('N','T')) then

																	-- procesa tralado parcial y rechazo de la cantida pendiente
																	if (sbTipoRejeTras = 'P') then
																			-- acepta la cantidad enviada
																			-- genera xml para los item no isbSerialziados
																			proGenXMLAcepTrasItem(inuMovimiento,
																																									reDetalleMovimiento.DMITCODI,
																																									reDetalleMovimiento.DMITITEM,
																																									'A',
																																									'N',
																																									l_Payload,
																																									osbMesjErr);

																			-- valida si pudo generar el XML para el llamado OS_LOADACCEPT_ITEMS
																			if (osbMesjErr is not null) then
																						raise excepNoProcesoRegi;
																			end if;--if (osbMesjErr is not null) then

																			-- hace el llamado al API para hacer el ingreso del item
																			sbAPI := 'OS_ACCEPT_ITEM';
																			OS_ACCEPT_ITEM(l_Payload, nuErrorCode, osbMesjErr);

																			-- valida si OS_ACCEPT_ITEM / OS_REJECT_ITEM se ejecuto con exito
																			if (nuErrorCode <> 0) then
																						raise excepOS_ACCEPT_ITEM;
																			end if;--if (onuErrorCode <> 0) then

																			-- rechaza la cantidad pendiente
																			-- genera xml para los item no isbSerialziados
																			proGenXMLAcepTrasItem(inuMovimiento,
																																									reDetalleMovimiento.DMITCODI,
																																									reDetalleMovimiento.DMITITEM,
																																									sbRejectItem,
																																									sbTipoRejeTras,
																																									l_Payload,
																																									osbMesjErr);

																			-- valida si pudo generar el XML para el llamado OS_LOADACCEPT_ITEMS
																			if (osbMesjErr is not null) then
																						raise excepNoProcesoRegi;
																			end if;--if (osbMesjErr is not null) then

																			sbAPI := 'OS_REJECT_ITEM';
																			-- hace el llamado al API para hacer el ingreso del item
																			OS_REJECT_ITEM(l_Payload, nuErrorCode, osbMesjErr);

																			-- valida si OS_ACCEPT_ITEM / OS_REJECT_ITEM se ejecuto con exito
																			if (nuErrorCode <> 0) then
																						raise excepOS_ACCEPT_ITEM;
																			end if;--if (onuErrorCode <> 0) then
																	end if;-- if (sbTipoRejeTras = 'P') then
												else
																	-- tipo de movimiento Z01 Movimiento de Material / Z03 Movimiento de Heramientas (Anulacion de Traslados / Devolucion)
																	if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate, reClaseMovi.sbClasSolMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbMoviHerr)) then
																				-- Genera el XML para el API OS_LOADACCEPT_ITEMS, indicando que suma al inventario
																				proGenXMLAceptItem(inuMovimiento,
																																						reDetalleMovimiento.DMITCODI,
																																						reDetalleMovimiento.DMITITEM,
																																						'I',
																																						l_Payload,
																																						osbMesjErr);

																				if (osbMesjErr is not null) then
																							raise excepNoProcesoRegi;
																				end if;--if (osbMesjErr is not null) then

																				-- hace el llamado al API para hacer el ingreso del item
																				OS_LOADACCEPT_ITEMS(l_Payload, nuErrorCode, osbMesjErr);
																				-- valida si OS_LOADACCEPT_ITEMS se ejecuto con exito
																				if (nuErrorCode <> 0) then
																							raise excepOS_LOADACCEPT_ITEMS;
																				end if;--if (onuErrorCode <> 0) then

																	end if;--if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate,reClaseMovi.sbMoviHerr)) then
												end if;--if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbDevoHerr)) then
								end if; -- if (reGE_ITEMS.ITEM_CLASSIF_ID = 21) then
					end loop;-- for reDetalleMovimiento in cuDetalleMovimiento loop

			Exception
							WHEN excep_CHECK_GE_ITEMS_SERIADO THEN
												osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAcepTrastItem.CHECK_GE_ITEMS_SERIADO]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
												              chr(13) || ' El ITEM no se encuentra asignado en poder de una Unida Operativa de clase Proveedor Logistico.';

							WHEN excepOS_LOADACCEPT_ITEMS THEN
												osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAcepTrastItem.OS_LOADACCEPT_ITEMS]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
												              chr(13) || ' Error de ejecucion del API: ' || osbMesjErr;

							WHEN excep_OS_SET_MOVE_ITEM THEN
												osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAcepTrastItem.OS_SET_MOVE_ITEM]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
												              chr(13) || 'Error de ejecucion del API: ' || osbMesjErr;

							WHEN excep_OS_ITEMMOVEOPERUNIT THEN
												osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAcepTrastItem.OS_ITEMMOVEOPERUNIT]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
												              chr(13) || 'Error de ejecucion del API: ' || osbMesjErr;

							WHEN excepNoProcesoRegi THEN
												osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAcepTrastItem.excepNoProcesoRegi]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
																										chr(13) || 'Error generando el XML: ' || osbMesjErr;

							WHEN excepOS_ACCEPT_ITEM THEN
												osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAcepTrastItem.OS_ACCEPT_ITEM]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
																										chr(13) || 'Error de ejecucion del API('|| sbAPI ||'): ' || osbMesjErr;

							WHEN OTHERS THEN
												osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAcepTrastItem.Others]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
																										chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proAcepTrastItem;

			procedure proAceptItem(inuMovimiento in  LDCI_INTEMMIT.MMITCODI%type,
																									osbMesjErr    out VARCHAR2) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : proAceptItem
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 15-01-2013
						RICEF      : I004
						DESCRIPCION: genera el XML al API OS_SET_REQUEST_CONF

					Historia de Modificaciones
					Autor   Fecha       Descripcion
				carlosvl 11-09-2013	 #NC-629: Se valida las marcas de salida final y marca de borrado.
			*/
				-- define cursores
				-- cusro que carga el detalle de la posicion involucrada en un movimiento
				cursor cuDetalleMovimiento(inuDMITMMIT LDCI_DMITMMIT.DMITMMIT%type) is
						select MMITCODI, MMITNUDO, MMITTIMO, MMITNATU, MMITDSAP, LDCI_DMITMMIT.*
								from LDCI_INTEMMIT,LDCI_DMITMMIT
							where DMITMMIT = MMITCODI
									and MMITCODI = inuDMITMMIT;

			-- cursor que determina si la posicion tiene seriales realcionados
			cursor cuCuentaisbSeriales(inuSERIMMIT LDCI_SERIDMIT.SERIMMIT%type,
																											inuSERIDMIT LDCI_SERIDMIT.SERIDMIT%type) is
					select count(*)
							from LDCI_SERIDMIT
						where SERIMMIT = inuSERIMMIT
								and SERIDMIT = inuSERIDMIT;


			-- cursor que muestra la informacion de los seriales relacionados a la posicion
			cursor cuDetalleisbSeriales(inuSERIMMIT LDCI_SERIDMIT.SERIMMIT%type,
																															inuSERIDMIT LDCI_SERIDMIT.SERIDMIT%type) is
					select SERIMMIT,SERIDMIT,SERICODI, SERINUME
							from LDCI_SERIDMIT
						where SERIMMIT = inuSERIMMIT
								and SERIDMIT = inuSERIDMIT
					order by SERIMMIT,SERIDMIT,SERICODI;

			-- cursor del documento. Usado para determinar el tipo del documento
			cursor cuGE_ITEMS_DOCUMENTO(inuID_ITEMS_DOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%type) is
				select ID_ITEMS_DOCUMENTO, DOCUMENT_TYPE_ID, OPERATING_UNIT_ID, DESTINO_OPER_UNI_ID
						from GE_ITEMS_DOCUMENTO
					where ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO;

			-- cursor para determinar si el numero de serie ya esta asignado (Caso de anulacion de un despacho)
			cursor cuGE_ITEMS_SERIADO(isbSERIE              in GE_ITEMS_SERIADO.SERIE%type,
																													inuOPERATING_UNIT_ID in GE_ITEMS_SERIADO.OPERATING_UNIT_ID%type)	 is
				select SERIE, OPERATING_UNIT_ID
					from GE_ITEMS_SERIADO
					where SERIE = isbSERIE
							and OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;

				-- registro de   cuGE_ITEMS_SERIADO
				reGE_ITEMS_SERIADO	cuGE_ITEMS_SERIADO%rowtype;

			-- registro de cuGE_ITEMS_DOCUMENTO
			reGE_ITEMS_DOCUMENTO cuGE_ITEMS_DOCUMENTO%rowtype;

				-- define variables
				l_Payload      CLOB;
				nuisbSeriales  NUMBER;
				nuErrorCode    NUMBER;
				onuTipoItemId  NUMBER;
				onuItemsGamaId NUMBER;
				sbITEM         VARCHAR2(18);
				sbSERIE        VARCHAR2(20);

				-- define excepciones
				excepNoProcesoRegi        exception;
				excepOS_LOADACCEPT_ITEMS  exception;
				excep_proSetRequestConf   exception;
				excep_OS_SET_REQUEST_CONF exception;
				excep_OS_ITEMMOVEOPERUNIT exception;
				excep_OS_SET_MOVE_ITEM    exception;
				excep_OS_ACCEPT_ITEM      exception;
			begin


					-- recorre los items de la solicitud
					for reDetalleMovimiento in cuDetalleMovimiento(inuMovimiento) loop
          sbITEM  := reDetalleMovimiento.DMITITEM;

										--11-09- 2013: #NC-629: carlosvl: Se agrega condificon para cuando DMITSAFI = 'P' and DMITMABO is null o DMITMABO is not null
										-- valida si la posicion ha sido rechazada o marcada en salida final con cantidad cero
										if(reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'C' and reDetalleMovimiento.DMITMABO is null
													or reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'C' and reDetalleMovimiento.DMITMABO is not null
													or reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'P' and reDetalleMovimiento.DMITMABO is null
													or reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'P' and reDetalleMovimiento.DMITMABO is not null) then


														-- se acepta la posicion rechazada y libera el cupo
														-- genera el XML para OS_SET_REQUEST_CONF
														proSetRequestConf(inuMovimiento,
																																reDetalleMovimiento.MMITTIMO,
																																reDetalleMovimiento.DMITCODI,
																																reDetalleMovimiento.DMITITEM,
																																l_Payload,
																																osbMesjErr);



														if (osbMesjErr is not null) then
																raise excep_proSetRequestConf;
														end if;--if (osbMesjErr is not null) then

														-- hace el llamado del API para confirmar isbMaterial faltante
														OS_SET_REQUEST_CONF(l_Payload, nuErrorCode,osbMesjErr);

														if (osbMesjErr is not null) then
																raise excep_OS_SET_REQUEST_CONF;
														end if;--if (osbMesjErr is not null) then
										else
											-- carga el documento para determina las unidades operativas involucradas
											open cuGE_ITEMS_DOCUMENTO(to_number(reDetalleMovimiento.MMITNUDO));
											fetch cuGE_ITEMS_DOCUMENTO into reGE_ITEMS_DOCUMENTO;
											close cuGE_ITEMS_DOCUMENTO;

														--  la posicion no fue rechazada y se procede a cargarla al inventario
											-- determina si el item es isbSerializado

											open cuCuentaisbSeriales(inuMovimiento, reDetalleMovimiento.DMITCODI);
											fetch cuCuentaisbSeriales into nuisbSeriales;
											close cuCuentaisbSeriales;

											-- valisa si el item tiene isbSeriales
											if (nuisbSeriales <> 0) then
													-- recorre los isbSeriales para generar el XML
													for reDetalleisbSeriales in cuDetalleisbSeriales(inuMovimiento, reDetalleMovimiento.DMITCODI) loop
                sbSERIE := reDetalleisbSeriales.SERINUME;
																-- hace la carga al inventario de items no seriados (tipos de movimiento Z01 Salida de Material / Z03 Salida de Herramientas)
																if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate, reClaseMovi.sbClasSolMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbMoviHerr)) then

																				-- Genera el XML para el API OS_LOADACCEPT_ITEMS, indicando que suma al inventario
																				proGenXMLAceptItemSeriado(reDetalleisbSeriales.SERIMMIT,
																																														reDetalleisbSeriales.SERIDMIT,
																																														reDetalleisbSeriales.SERICODI,
																																														'I',
																																														l_Payload,
																																														osbMesjErr);
																else
																			if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbClasDevMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbDevoHerr)) then
																					-- Genera el XML para el API OS_LOADACCEPT_ITEMS, indicando que suma al inventario
																					proGenXMLAceptItemSeriado(reDetalleisbSeriales.SERIMMIT,
																																															reDetalleisbSeriales.SERIDMIT,
																																															reDetalleisbSeriales.SERICODI,
																																															'D',
																																															l_Payload,
																																															osbMesjErr);
																			end if;-- if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbDevoHerr)) then
																end if;--if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate,reClaseMovi.sbMoviHerr)) then

																-- valida si pudo generar el XML para el llamado OS_LOADACCEPT_ITEMS
																if (osbMesjErr is not null) then
																		raise excepNoProcesoRegi;
																end if;--if (osbMesjErr is not null) then

																-- hace el llamado al API para hacer el ingreso del item
																OS_LOADACCEPT_ITEMS(l_Payload,nuErrorCode, osbMesjErr);
																-- valida si OS_LOADACCEPT_ITEMS se ejecuto con exito
																if (nuErrorCode <> 0) then
																		raise excepOS_LOADACCEPT_ITEMS;
																end if;--if (onuErrorCode <> 0) then
													end loop; --for reDetalleisbSeriales in cuDetalleisbSeriales(inuMovimiento, reDetalleMovimiento.DMITMMIT) loop
											else
                 -- procesamiento de items no seriados
																	if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate, reClaseMovi.sbClasSolMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbMoviHerr)) then
																							-- Genera el XML para el API OS_LOADACCEPT_ITEMS, indicando que suma al inventario
																							proGenXMLAceptItem(inuMovimiento,
																																									reDetalleMovimiento.DMITCODI,
																																									reDetalleMovimiento.DMITITEM,
																																									'I',
																																									l_Payload,
																																									osbMesjErr);
																	else
																						if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbClasDevMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbDevoHerr)) then
																										-- Genera el XML para el API OS_LOADACCEPT_ITEMS, indicando que resta del inventario
																										proGenXMLAceptItem(inuMovimiento,
																																													reDetalleMovimiento.DMITCODI,
																																													reDetalleMovimiento.DMITITEM,
																																													'D',
																																													l_Payload,
																																													osbMesjErr);
																						end if; --if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbDevoHerr)) then
																	end if; --if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate,reClaseMovi.sbMoviHerr)) then

																	-- valida si pudo generar el XML para el llamado OS_LOADACCEPT_ITEMS
																	if (osbMesjErr is not null) then
																				raise excepNoProcesoRegi;
																	end if;--if (osbMesjErr is not null) then

																	-- hace el llamado al API para hacer el ingreso del item
																	OS_LOADACCEPT_ITEMS(l_Payload, nuErrorCode, osbMesjErr);
																	-- valida si OS_LOADACCEPT_ITEMS se ejecuto con exito
																	if (nuErrorCode <> 0) then
																				raise excepOS_LOADACCEPT_ITEMS;
																	end if;--if (onuErrorCode <> 0) then
											end if; -- if (nuisbSeriales <> 0) then

											-- realiza la confimacion del saldo pendiente
											-- genera el XML para OS_SET_REQUEST_CONF
											proSetRequestConf(inuMovimiento,
																													reDetalleMovimiento.MMITTIMO,
																													reDetalleMovimiento.DMITCODI,
																													reDetalleMovimiento.DMITITEM,
																													l_Payload,
																													osbMesjErr);

											if (osbMesjErr is not null) then
													raise excep_proSetRequestConf;
											end if;--if (osbMesjErr is not null) then

											-- hace el llamado del API para confirmar isbMaterial faltante
											OS_SET_REQUEST_CONF(l_Payload, nuErrorCode,osbMesjErr);
											if (osbMesjErr is not null) then
													raise excep_OS_SET_REQUEST_CONF;
											end if;--if (osbMesjErr is not null) then
										end if;-- if(reDetalleMovimiento.DMITCAPE = 0 and ...
			end loop;-- for reDetalleMovimiento in cuDetalleMovimiento loop

			Exception
						WHEN excep_OS_ACCEPT_ITEM THEN
											osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAceptItem.OS_ACCEPT_ITEM]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
											              chr(13) || 'Error de ejecucion del API: ' || osbMesjErr;

						WHEN excep_OS_SET_MOVE_ITEM THEN
											osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAceptItem.OS_SET_MOVE_ITEM]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
											              chr(13) || 'Error de ejecucion del API: ' || osbMesjErr;

						WHEN excep_OS_ITEMMOVEOPERUNIT THEN
											osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAceptItem.OS_ITEMMOVEOPERUNIT]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
											              chr(13) || 'Error de ejecucion del API: ' || osbMesjErr;

						WHEN excep_proSetRequestConf THEN
											osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAceptItem.proSetRequestConf]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
											              chr(13) || 'Error generando el XML: ' || osbMesjErr;

						WHEN excep_OS_SET_REQUEST_CONF THEN
											osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAceptItem.OS_SET_REQUEST_CONF]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
											              chr(13) || 'Error cargando el item (OS_SET_REQUEST_CONF): ' || osbMesjErr;

						WHEN excepNoProcesoRegi THEN
											osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAceptItem.NoProcesoRegi]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
																									chr(13) || 'Error generando el XML: ' || osbMesjErr;

						WHEN excepOS_LOADACCEPT_ITEMS THEN
											osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAceptItem.OS_LOADACCEPT_ITEMS]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
											              chr(13) || 'Error cargando el item (OS_LOADACCEPT_ITEMS): ' || osbMesjErr;

						WHEN OTHERS THEN
									osbMesjErr := '[LDCI_PKMOVIVENTMATE.proAceptItem.Others]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
    									          chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proAceptItem;

			procedure proCreaEncabezadoDocVenta(isbDOVECODI	in VARCHAR2,
                                          isbDOVETIMO	in VARCHAR2,
                                          isbDOVEDESC	in VARCHAR2,
                                          isbDOVENATU	in VARCHAR2,
                                          isbDOVECLIE	in VARCHAR2,
                                          idtDOVEFESA	in DATE,
                                          inuDOVEVTOT	in NUMBER,
                                          idtDOVEFEVE	in DATE,
                                          osbMesException out VARCHAR2) as
					/*
								PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
								FUNCION    : LDCI_PKMOVIVENTMATE.proCreaEncabezadoDocVenta
								AUTOR      : OLSoftware / Carlos E. Virgen
								FECHA      : 24-09-2013
								RICEF      : I064
								DESCRIPCION: Crea un registro en la tabla LDCI_DOCUVENT con la informaci??n del movimiento de venta

							Historia de Modificaciones
							Autor    Fecha       Descripcion
							carlosvl 24-09-2013  Crea el procedimiento
					*/
          --11-11-2014: carlos.virgen: Se valida que el registro en LDCI_DOCUVENT este creado
          cursor cuLDCI_DOCUVENT(isbDOVECODI in VARCHAR2) is
            select DOVECODI
              from LDCI_DOCUVENT
             where DOVECODI = isbDOVECODI;

          reLDCI_DOCUVENT cuLDCI_DOCUVENT%rowtype;
			begin
            open cuLDCI_DOCUVENT(isbDOVECODI);
            fetch cuLDCI_DOCUVENT into reLDCI_DOCUVENT;
            if (cuLDCI_DOCUVENT%NOTFOUND) then
                -- realiza la insercion del encabezado del documento de venta
                insert into LDCI_DOCUVENT(DOVECODI,
                                          DOVETIMO,
                                          DOVEDESC,
                                          DOVENATU,
                                          DOVECLIE,
                                          DOVEFESA,
                                          DOVEVTOT,
                                          DOVEESTA,
                                          DOVEINTE,
                                          DOVEFEVE) values
                                          (isbDOVECODI,
                                          isbDOVETIMO,
                                          isbDOVEDESC,
                                          isbDOVENATU,
                                          isbDOVECLIE,
                                          idtDOVEFESA,
                                          inuDOVEVTOT,
                                          '1',
                                          0,
                                          idtDOVEFEVE);
            end if;--if (cuLDCI_DOCUVENT%NOTFOUND) then
            close cuLDCI_DOCUVENT;
			exception
					when others then
							osbMesException := '[LDCI_PKMOVIVENTMATE.proCreaEncabezadoDocVenta]: Registro [' || isbDOVECODI || ']' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proCreaEncabezadoDocVenta;

			procedure proCreaPosicionesDocVenta(inuDMITMMIT in LDCI_DMITMMIT.DMITMMIT%type,
																																						inuITDVOPUN in NUMBER,
																																						inuITDVPROV in NUMBER,
																																						osbMesException out VARCHAR2) as
					/*
								PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
								FUNCION    : LDCI_PKMOVIVENTMATE.proCreaPosicionesDocVenta
								AUTOR      : OLSoftware / Carlos E. Virgen
								FECHA      : 24-09-2013
								RICEF      : I064
								DESCRIPCION: Crea un registro en la tabla LDCI_ITEMDOVE con la informaci??n del movimiento de venta

							Historia de Modificaciones
							Autor    Fecha       Descripcion
							carlosvl 24-09-2013  Crea el procedimiento
					*/
						nuITDVCODI LDCI_ITEMDOVE.ITDVCODI%type;
						nuITDVCOIN LDCI_ITEMDOVE.ITDVCOIN%type;
						-- Cursor de los items seriados
						cursor cuItemSeriado(inuMMITCODI LDCI_INTEMMIT.MMITCODI%type) is
						-- lista la informacion de los seriales de un  movimiento
									select MMITDSAP, LDCI_DMITMMIT.*, LDCI_SERIDMIT.*
											from LDCI_INTEMMIT,LDCI_DMITMMIT, LDCI_SERIDMIT
										where MMITCODI = inuMMITCODI
												and MMITCODI = DMITMMIT
												and SERIMMIT = MMITCODI
												and DMITCODI = SERIDMIT;
			begin
						-- inicializa la posicion del detalle
						nuITDVCODI := 1;
						-- recorre las posiciones con seriales del movimiento e inserta los seriales vendidos
						for reItemSeriado in cuItemSeriado(inuDMITMMIT) loop

        nuITDVCOIN := fnuGetCodigoInternoItem(reItemSeriado.DMITITEM);
								-- realiza la insercion del item
								insert into LDCI_ITEMDOVE(ITDVDOVE,
                                          ITDVCODI,
                                          ITDVCOIN,
                                          ITDVITEM,
                                          ITDVCANT,
                                          ITDVCAPE,
                                          ITDVCOUN,
                                          ITDVVAUN,
                                          ITDVPIVA,
                                          ITDVMARC,
                                          ITDVSAFI,
                                          ITDVMABO,
                                          ITDVVALO,
                                          ITDVOPUN,
                                          ITDVPROV,
                                          ITDVSERI) values
                                        (reItemSeriado.MMITDSAP,
                                          nuITDVCODI,
                                        nuITDVCOIN,
                                          reItemSeriado.DMITITEM,
                                          1,
                                          0,
                                          reItemSeriado.DMITCOUN,
                                          reItemSeriado.DMITVAUN,
                                          reItemSeriado.DMITPIVA,
                                          reItemSeriado.DMITMARC,
                                          reItemSeriado.DMITSAFI,
                                          reItemSeriado.DMITMABO,
                                          reItemSeriado.DMITVALO,
                                          inuITDVOPUN,
                                          inuITDVPROV,
                                          reItemSeriado.SERINUME);


								--incrementa la posicion
								nuITDVCODI := nuITDVCODI + 1;
						end loop;--for reItemSeriado in cuItemSeriado(inuDMITMMIT) loop
			exception
					when others then
							osbMesException := '[LDCI_PKMOVIVENTMATE.proCreaPosicionesDocVenta]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proCreaPosicionesDocVenta;

			procedure proAsignaPosicionesDocVenta(inuTRSMCODI in NUMBER,
                                            inuTRSMTIPO in NUMBER,/*inuTRSMDORE in NUMBER*/
                                            isbITDVDOVE in LDCI_ITEMDOVE.ITDVDOVE%type,
                                            inuITDVOPUN in NUMBER,
                                            inuITDVPROV in NUMBER,
                                            osbMesException out VARCHAR2) as
					/*
								PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
								FUNCION    : LDCI_PKMOVIVENTMATE.proAsignaPosicionesDocVenta
								AUTOR      : OLSoftware / Carlos E. Virgen
								FECHA      : 24-09-2013
								RICEF      : I064
								DESCRIPCION: Asigna los elementos seriados de un movimiento de material vendido

							Historia de Modificaciones
							Autor    Fecha       Descripcion
							carlosvl 24-09-2013  Crea el procedimiento
					*/
						-- definicion de variables
						ol_Payload  CLOB;
						nuErrorCode NUMBER;

						-- Cursor de los items seriados
						cursor cuLDCI_ITEMDOVE(isbITDVDOVE in LDCI_ITEMDOVE.ITDVDOVE%type) is
								select ITDVCODI,
                       ITDVITEM,
                       ITDVCOIN,
                       ITDVCANT,
                       ITDVCAPE,
                       ITDVCOUN,
                       ITDVVAUN,
                       ITDVPIVA,
                       ITDVMARC,
                       ITDVSERI,
                       ITDVSAFI,
                       ITDVMABO,
                       ITDVVALO
										from LDCI_DOCUVENT, LDCI_ITEMDOVE, GE_ITEMS
									where DOVECODI = isbITDVDOVE
											and DOVECODI = ITDVDOVE
											and CODE = ITDVITEM; --#OYM_CEV_2740_1  ITEMS_ID --> CODE
						--exepciones
						excep_proGenXMLItemSeriVendido exception;
						excepOS_LOADACCEPT_ITEMS       exception;
            excep_proInsLDCI_SERIPOSI      exception;
			begin
						-- recorre las posiciones del documento de venta y llama el API OS_LOADACCEPT_ITEMS
						for rgLDCI_ITEMDOVE in cuLDCI_ITEMDOVE(isbITDVDOVE) loop

								-- Genera el XML para hacer la asignaci??n del elemento seriado
								proGenXMLItemSeriVendido(isbITDVDOVE,
                                          inuITDVPROV,
                                          rgLDCI_ITEMDOVE.ITDVCODI,
                                          rgLDCI_ITEMDOVE.ITDVITEM,
                                          inuITDVOPUN,
                                          'I',
                                          ol_Payload,
                                          osbMesException);

								if (osbMesException is not null) then
											raise excep_proGenXMLItemSeriVendido;
								end if;--if (osbMesException is not null) then

								-- Carga el serial a la unidad operativa destinada
								OS_LOADACCEPT_ITEMS(ol_Payload, nuErrorCode, osbMesException);

								if (nuErrorCode <> 0) then
											raise excepOS_LOADACCEPT_ITEMS;
								end if;--if (nuErrorCode <> 0) then

                if (inuTRSMTIPO = 1) then /*inuTRSMDORE is null*/
                    proInsLDCI_SERIPOSI(inuSERITRSM => rgLDCI_ITEMDOVE.ITDVCODI,
                                        inuSERITSIT => rgLDCI_ITEMDOVE.ITDVCOIN,
                                        isbSERINUME => rgLDCI_ITEMDOVE.ITDVSERI,
                                        inuSERISOMA => inuTRSMCODI,
                                        onuErrorCode => nuErrorCode,
                                        osbErrorMessage => osbMesException);

                    if (nuErrorCode <> 0) then
                          raise excep_proInsLDCI_SERIPOSI;
                    end if;--if (nuErrorCode   <> 0) then
                end if;--if (inuTRSMTIPO = 1) then

						end loop;--for rgLDCI_ITEMDOVE in cuLDCI_ITEMDOVE(isbITDVDOVE) loop
			exception
          when excep_proInsLDCI_SERIPOSI then
							osbMesException := '[LDCI_PKMOVIVENTMATE.proAsignaPosicionesDocVenta.excep_proInsLDCI_SERIPOSI]:' || chr(13) ||  'Excepcion API: ' || osbMesException;

					when excep_proGenXMLItemSeriVendido then
							osbMesException := '[LDCI_PKMOVIVENTMATE.proAsignaPosicionesDocVenta.excep_proGenXMLItemSeriVendido]:' || chr(13) ||  'Excepcion API: ' || osbMesException;

					when excepOS_LOADACCEPT_ITEMS then
							osbMesException := '[LDCI_PKMOVIVENTMATE.proAsignaPosicionesDocVenta.excepOS_LOADACCEPT_ITEMS]:' || chr(13) ||  'Excepcion API: ' || osbMesException;

					when others then
							osbMesException := '[LDCI_PKMOVIVENTMATE.proAsignaPosicionesDocVenta]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proAsignaPosicionesDocVenta;

			procedure proDesasignaPosicionesDocVenta(inuTRSMCODI in NUMBER,
                                               inuTRSMTIPO in NUMBER,/*inuTRSMDORE in NUMBER*/
                                               isbITDVDOVE in LDCI_ITEMDOVE.ITDVDOVE%type,
                                               inuITDVOPUN in NUMBER,
                                               inuITDVPROV in NUMBER,
                                               osbMesException out VARCHAR2) as
					/*
								PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
								FUNCION    : LDCI_PKMOVIVENTMATE.proDesasignaPosicionesDocVenta
								AUTOR      : OLSoftware / Carlos E. Virgen
								FECHA      : 24-09-2013
								RICEF      : I064
								DESCRIPCION: Desasigna los elementos seriados de un movimiento de material vendido

							Historia de Modificaciones
							Autor    Fecha       Descripcion
							carlosvl 24-09-2013  Crea el procedimiento
					*/
						-- definicion de variables
						sbITDVITEM LDCI_ITEMDOVE.ITDVITEM%type;
						sbITDVSERI LDCI_ITEMDOVE.ITDVSERI%type;
						ol_Payload  CLOB;
						nuErrorCode NUMBER;

						-- cursor del item seriado
						cursor cuGE_ITEMS_SERIADO(inuITEMS_ID GE_ITEMS_SERIADO.ITEMS_ID%type, isbSERIE GE_ITEMS_SERIADO.SERIE%type) is
								select ITEMS_ID, SERIE, OPERATING_UNIT_ID
										from GE_ITEMS_SERIADO
									where /*ITEMS_ID = inuITEMS_ID
											and */SERIE = isbSERIE;

						-- Cursor de los items seriados
						cursor cuLDCI_ITEMDOVE(isbITDVDOVE in LDCI_ITEMDOVE.ITDVDOVE%type) is
								select ITDVCODI,
									   ITDVITEM,
									   ITDVCOIN,
									   ITDVCANT,
									   ITDVCAPE,
									   ITDVCOUN,
									   ITDVVAUN,
									   ITDVPIVA,
									   ITDVMARC,
									   ITDVSERI,
									   ITDVSAFI,
									   ITDVMABO,
									   ITDVVALO
										from LDCI_DOCUVENT, LDCI_ITEMDOVE, GE_ITEMS
									where DOVECODI = isbITDVDOVE
											and DOVECODI = ITDVDOVE
											and CODE = ITDVITEM; --#OYM_CEV_2740_1  ITEMS_ID --> CODE


						cursor cuLDCI_TRANSOMA(inuTRSMCODI NUMBER) is  	--cursor: Informacion del pedido de venta: --138682
						 select TRSMPROV PROVEEDOR_LOGISTICO, TRSMUNOP UNIDA_OPERATIVA
						   from LDCI_TRANSOMA
						  where TRSMCODI = inuTRSMCODI;

						-- variables tipo registro
						reGE_ITEMS_SERIADO cuGE_ITEMS_SERIADO%rowtype;
						reLDCI_TRANSOMA    cuLDCI_TRANSOMA%rowtype;
						--exepciones
						excep_proGenXMLItemSeriVendido exception;
						excepOS_LOADACCEPT_ITEMS       exception;
						excep_ITEM_SERIADO             exception;
						excep_proBorLDCI_SERIPOSI      exception;

			begin

					open cuLDCI_TRANSOMA(inuTRSMCODI);	-- 138682
					fetch cuLDCI_TRANSOMA into reLDCI_TRANSOMA;
					close cuLDCI_TRANSOMA;
					-- recorre las posiciones del documento de venta y llama el API OS_LOADACCEPT_ITEMS
					for rgLDCI_ITEMDOVE in cuLDCI_ITEMDOVE(isbITDVDOVE) loop
							-- consulta el item seriado
							open cuGE_ITEMS_SERIADO(rgLDCI_ITEMDOVE.ITDVITEM, rgLDCI_ITEMDOVE.ITDVSERI);
							fetch cuGE_ITEMS_SERIADO into reGE_ITEMS_SERIADO;
							if(cuGE_ITEMS_SERIADO%ROWCOUNT = 1) then


										-- Genera el XML para hacer la asignaci??n del elemento seriado
										proGenXMLItemSeriVendido(isbITDVDOVE,
																inuITDVPROV,
																rgLDCI_ITEMDOVE.ITDVCODI,
																rgLDCI_ITEMDOVE.ITDVITEM,
																reLDCI_TRANSOMA.UNIDA_OPERATIVA, --138682: reGE_ITEMS_SERIADO.OPERATING_UNIT_ID,
																'I',
																ol_Payload,
																osbMesException);


										if (osbMesException is not null) then
												sbITDVITEM := rgLDCI_ITEMDOVE.ITDVITEM;
												sbITDVSERI := rgLDCI_ITEMDOVE.ITDVSERI;
												raise excep_proGenXMLItemSeriVendido;
										end if;--if (osbMesException is not null) then

										-- Carga el serial a la unidad operativa destinada
										OS_LOADACCEPT_ITEMS(ol_Payload, nuErrorCode, osbMesException);


										if (nuErrorCode <> 0) then
													raise excepOS_LOADACCEPT_ITEMS;
										end if;--if (nuErrorCode <> 0) then

										-- actualiza la posici??n asignando el elemento seriado
										update LDCI_ITEMDOVE set ITDVPROV = inuITDVPROV, ITDVOPUN = reLDCI_TRANSOMA.UNIDA_OPERATIVA --138682: reGE_ITEMS_SERIADO.OPERATING_UNIT_ID
											where 	ITDVDOVE = isbITDVDOVE
													and ITDVCODI = rgLDCI_ITEMDOVE.ITDVCODI;

				  if (inuTRSMTIPO = 1) then /*inuTRSMDORE is null*/
					  proBorLDCI_SERIPOSI(inuSERITRSM => rgLDCI_ITEMDOVE.ITDVCODI,
										  inuSERITSIT => rgLDCI_ITEMDOVE.ITDVCOIN,
										  isbSERINUME => rgLDCI_ITEMDOVE.ITDVSERI,
										  inuSERISOMA => inuTRSMCODI,
										  onuErrorCode => nuErrorCode,
										  osbErrorMessage => osbMesException);

					  if (nuErrorCode <> 0) then
							raise excep_proBorLDCI_SERIPOSI;
					  end if;--if (nuErrorCode <> 0) then
				  end if;--if (inuTRSMTIPO = 1) then
							else
										raise excep_ITEM_SERIADO;
							end if;--if(cuGE_ITEMS_SERIADO%ROWCOUNT = 1) then
							close cuGE_ITEMS_SERIADO;

					end loop;--for rgLDCI_ITEMDOVE in cuLDCI_ITEMDOVE(isbITDVDOVE) loop
			exception
					when excep_ITEM_SERIADO then
							osbMesException := '[LDCI_PKMOVIVENTMATE.proDesasignaPosicionesDocVenta.excep_ITEM_SERIADO]:' || chr(13) || 'El elemento seriado [ITEM: ' || sbITDVITEM ||
																										'] [SERIE: ' || sbITDVSERI || '] no se encuentra registrado.';
					when excep_proGenXMLItemSeriVendido then
							osbMesException := '[LDCI_PKMOVIVENTMATE.proDesasignaPosicionesDocVenta.excep_proGenXMLItemSeriVendido]:' || chr(13) ||  'Excepcion API: ' || osbMesException;

					when excepOS_LOADACCEPT_ITEMS then
							osbMesException := '[LDCI_PKMOVIVENTMATE.proDesasignaPosicionesDocVenta.excepOS_LOADACCEPT_ITEMS]:' || chr(13) ||  'Excepcion API: ' || osbMesException;

					when excep_proBorLDCI_SERIPOSI then
							osbMesException := '[LDCI_PKMOVIVENTMATE.proDesasignaPosicionesDocVenta.excep_proBorLDCI_SERIPOSI]:' || chr(13) ||  'Excepcion API: ' || osbMesException;

					when others then
							osbMesException := '[LDCI_PKMOVIVENTMATE.proDesasignaPosicionesDocVenta]:' || chr(13) ||  'Error no controlado: ' || SQLERRM;
			end proDesasignaPosicionesDocVenta;

			procedure proConfirmarSolicitud(inuMovimiento in LDCI_INTEMMIT.MMITCODI%type) As
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : proConfirmarSolicitud
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 15-01-2013
						RICEF      : I004; I018
						DESCRIPCION: Toma los datos de la interfaz y le asigna a los datos al API OS_SET_REQUEST_CONF

					Historia de Modificaciones
					Autor      Fecha           Descripcion
          Kbaquero   21/08/2015      #8481:Se coloca una excepcion dentro del loop para que en el momento
                                     en que hay un error, sea controlado y ademas continue el proceso con el resto de la informacion
			*/

			onuErrorCode GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
            nuMMITCODI NUMBER; --Id del movimiento
            nuTRSMCODI NUMBER; --Id del perdido de venta
			-- define cursores
			-- cursor de los movimientos de material
			cursor cuMoviSolicitud(inuMMITCODI in LDCI_INTEMMIT.MMITCODI%type) is
				select *
						from LDCI_INTEMMIT
					where MMITCODI = decode(inuMMITCODI, -1, MMITCODI, inuMMITCODI)
							and MMITESTA = 1
							and MMITINTE <= 3
							and MMITCLIE is not null
							and MMITNUDO is null
								order by MMITCODI asc;

			-- cursor del documento. Usado para determinar el tipo del documento
			cursor cuLDCI_TRANSOMA(inuTRSMCODI LDCI_TRANSOMA.TRSMCODI%type) is
					select TRSMCODI, TRSMTIPO, TRSMUNOP, TRSMPROV, TRSMDORE
							from LDCI_TRANSOMA
						where TRSMCODI = inuTRSMCODI;

			cursor cuGE_CONTRATISTA(isbIDENTIFICATION GE_SUBSCRIBER.IDENTIFICATION%type) is
					select su.IDENTIFICATION, CO.NOMBRE_CONTRATISTA, UO.OPERATING_UNIT_ID, UO.NAME
							from GE_CONTRATISTA co, OR_OPERATING_UNIT uo, GE_SUBSCRIBER su
						where co.ID_CONTRATISTA = uo.CONTRACTOR_ID
								and su.SUBSCRIBER_ID = co.SUBSCRIBER_ID
								and su.IDENTIFICATION = isbIDENTIFICATION;


			cursor cuCOUTN_OR_OPERATING_UNIT(isbIDENTIFICATION GE_SUBSCRIBER.IDENTIFICATION%type) is --#OYM_CEV_2740_1
					select count(*) COUNT_OR_OPERATING_UNIT
							from GE_CONTRATISTA co, OR_OPERATING_UNIT uo, GE_SUBSCRIBER su
						where co.ID_CONTRATISTA = uo.CONTRACTOR_ID
								and su.SUBSCRIBER_ID = co.SUBSCRIBER_ID
								and su.IDENTIFICATION = isbIDENTIFICATION;


			-- registro de cuLDCI_TRANSOMA
			reLDCI_TRANSOMA           cuLDCI_TRANSOMA%rowtype;
			reGE_CONTRATISTA          cuGE_CONTRATISTA%rowtype;
			reCOUTN_OR_OPERATING_UNIT cuCOUTN_OR_OPERATING_UNIT%rowtype; --#OYM_CEV_2740_1


			-- define variables
			l_Payload   CLOB;
			nuErrorCode NUMBER;
			osbMesjErr GE_ERROR_LOG.DESCRIPTION%type;

			begin
--dbms_output.put_line('[2639:ini]');
			-- carga la configuracion de las diferentes clase de movimiento
			open cuClaseMovi;
			fetch cuClaseMovi into reClaseMovi;
			close cuClaseMovi;

--dbms_output.put_line('[2645:step]');
			open cuWS_MOVIMIENTO_MATERIAL;
			fetch cuWS_MOVIMIENTO_MATERIAL into reWS_MOVIMIENTO_MATERIAL;
			close cuWS_MOVIMIENTO_MATERIAL;

--dbms_output.put_line('[2645:step inuMovimiento : ] ' || inuMovimiento);
			-- recorre los movimientos cuMoviSolicitud
			for reMoviSolicitud in cuMoviSolicitud(inuMovimiento) loop

      BEGIN-- 21/08/2015 se realiza para controlar la excepcion cuando el numero de pedido no este de acuerdo
      -- con el standar
				--TODO:
				--1) Valida si el ID del documento de venta es numerico
				--2) Si el ID del documento no es numerico entonces lo debe procesar como lo hace actualemnte
				--3) Si el ID del documento es numerico debe validar si existe o no
				--4) Si el ID del documento existe debe procesar la informacion de la nueva forma.
				--5) Si el ID del documento no existe debe procesar la informacion de la forma actual
				nuMMITCODI := reMoviSolicitud.MMITCODI;
--dbms_output.put_line('[3151:step proValidaSeriales : ] ' || inuMovimiento);
				LDCI_PKMOVIMATERIAL.proValidaSeriales(reMoviSolicitud.MMITCODI,  --138682
													  onuErrorCode,
													  osbMesjErr);
--dbms_output.put_line('[3155:step proValidaSeriales : ] ' || inuMovimiento);

				if (osbMesjErr is not null) then --138682
					--actualiza el registro para
					proActualizaMovimiento(reMoviSolicitud.MMITCODI,
										   'INTENTO',
											osbMesjErr);
				else
					nuTRSMCODI := to_number(substr(reMoviSolicitud.MMITNUPE,instr(reMoviSolicitud.MMITNUPE,'-') + 1, LENGTH(reMoviSolicitud.MMITNUPE)));


					--Carga el documento de solicitud de venta
					open cuLDCI_TRANSOMA(nuTRSMCODI);
					fetch cuLDCI_TRANSOMA into reLDCI_TRANSOMA;
					if (cuLDCI_TRANSOMA%FOUND) then
					  -- Actualiza LDCI_TRANSOMA
					  --#11-11-2014: carlos.virgen: Se adiciona linea para activar la tabla LDCI_TRANSOMA
					  ldc_bomaterialrequest.ActivateTable(reLDCI_TRANSOMA.TRSMCODI);
					  LDCI_PKMOVIVENTMATE.proActualizaLDCI_TRANSOMA(inuTRSMCODI     => reLDCI_TRANSOMA.TRSMCODI,
																	inuTRSMESTA     => 3 /*ESTADO 1- CREADO, 2- ENVIADO. 3 RECIBIDO, 4- ANULADO Pedido / Devolucion*/,
																	onuErrorCode    => onuErrorCode,
																	osbErrorMessage => osbMesjErr);

					  if (osbMesjErr is not null) then
						  proActualizaMovimiento(reMoviSolicitud.MMITCODI, 'INTENTO', osbMesjErr);
						  --#11-11-2014: carlos.virgen: Se adiciona linea para desactivar la tabla LDCI_TRANSOMA
						  ldc_bomaterialrequest.CloseTable(reLDCI_TRANSOMA.TRSMCODI);
					  else
						  -- Actualiza LDCI_TRSOITEM
						  LDCI_PKMOVIVENTMATE.proActuPosicionesSolVenta(inuDMITMMIT     => reMoviSolicitud.MMITCODI,
																		onuErrorCode    => onuErrorCode,
																		osbErrorMessage => osbMesjErr);

						  if (osbMesjErr is not null) then
							  proActualizaMovimiento(reMoviSolicitud.MMITCODI, 'INTENTO', osbMesjErr);
							  --#11-11-2014: carlos.virgen: Se adiciona linea para desactivar la tabla LDCI_TRANSOMA
							  ldc_bomaterialrequest.CloseTable(reLDCI_TRANSOMA.TRSMCODI);
						  else
							  -- Actualiza LDCI_SERIPOSI
							  -- Si Mov + asigna los seriales
							  -- Si Mov - desasigna los seriales
							  proCreaEncabezadoDocVenta(reMoviSolicitud.MMITDSAP,
														reMoviSolicitud.MMITTIMO,
														reMoviSolicitud.MMITDESC,
														reMoviSolicitud.MMITNATU,
														reMoviSolicitud.MMITCLIE,
														reMoviSolicitud.MMITFESA,
														reMoviSolicitud.MMITVTOT,
														reMoviSolicitud.MMITFEVE,
														osbMesjErr);

							  -- valida si la transaccion es exitosa
							  if (osbMesjErr is not null) then
									  proActualizaMovimiento(reMoviSolicitud.MMITCODI, 'INTENTO', osbMesjErr);
									  --#11-11-2014: carlos.virgen: Se adiciona linea para desactivar la tabla LDCI_TRANSOMA
									  ldc_bomaterialrequest.CloseTable(reLDCI_TRANSOMA.TRSMCODI);
							  else
									  proCreaPosicionesDocVenta(reMoviSolicitud.MMITCODI,
																reLDCI_TRANSOMA.TRSMUNOP,
																reLDCI_TRANSOMA.TRSMPROV,
																osbMesjErr);

									  -- valida si la transaccion es exitosa
									  if (osbMesjErr is not null) then
											  proActualizaMovimiento(reMoviSolicitud.MMITCODI, 'INTENTO', osbMesjErr);
											  --#11-11-2014: carlos.virgen: Se adiciona linea para desactivar la tabla LDCI_TRANSOMA
											  ldc_bomaterialrequest.CloseTable(reLDCI_TRANSOMA.TRSMCODI);
									  else
											  -- valida la naturaleza del movimiento si Suma o Resta
											  if (reMoviSolicitud.MMITNATU = '+') then
													-- Se recore las posiciones del movimiento y se invoca el API para cargas los items al inventario
													proAsignaPosicionesDocVenta(reLDCI_TRANSOMA.TRSMCODI,
																				reLDCI_TRANSOMA.TRSMTIPO, /*reLDCI_TRANSOMA.TRSMDORE*/
																				reMoviSolicitud.MMITDSAP,
																				reLDCI_TRANSOMA.TRSMUNOP,
																				reLDCI_TRANSOMA.TRSMPROV,
																				osbMesjErr);
											  end if;--if (reMoviSolicitud.MMITNATU = '+') then

											  if (reMoviSolicitud.MMITNATU = '-') then
													--llamar al proceso que lee los items seriados y los desasigna
													proDesasignaPosicionesDocVenta(reLDCI_TRANSOMA.TRSMCODI,
																				   reLDCI_TRANSOMA.TRSMTIPO, /*reLDCI_TRANSOMA.TRSMDORE*/
																				   reMoviSolicitud.MMITDSAP,
																				   reLDCI_TRANSOMA.TRSMUNOP,
																				   reLDCI_TRANSOMA.TRSMPROV,
																				   osbMesjErr);
											  end if;--if (reMoviSolicitud.MMITNATU = '-') then

											  -- valida si la transaccion es exitosa
											  if (osbMesjErr is not null) then
													  proActualizaMovimiento(reMoviSolicitud.MMITCODI, 'INTENTO', osbMesjErr);
													  --#11-11-2014: carlos.virgen: Se adiciona linea para desactivar la tabla LDCI_TRANSOMA
													  ldc_bomaterialrequest.CloseTable(reLDCI_TRANSOMA.TRSMCODI);
											  else
													proAsignaMarcaBorrado(nuTRSMCODI,  --138682: Anula los movimientos de marca de borrado
																		  reMoviSolicitud.MMITNATU,
																		  reMoviSolicitud.MMITCODI,
																		  onuErrorCode,
																		  osbMesjErr);
												  -- confirma la operacion
												  commit;
												  --#11-11-2014: carlos.virgen: Se adiciona linea para desactivar la tabla LDCI_TRANSOMA
												  ldc_bomaterialrequest.CloseTable(reLDCI_TRANSOMA.TRSMCODI);
												  -- cierra el movimiento
												  proActualizaMovimiento(reMoviSolicitud.MMITCODI, 'CONFIRMADO', osbMesjErr);

                                end if;-- if (osbMesjErr is not null) then
                            end if;-- if (osbMesjErr is not null) then
                        end if;--if (osbMesjErr is not null) then
                      end if;--if (osbMesjErr is not null) then
                    end if;--if (osbMesjErr is not null) then

                 end if;--if (cuLDCI_TRANSOMA%FOUND) then
                 close cuLDCI_TRANSOMA;
                end if;--if (osbMesjErr is not null) then --138682

        	Exception
					When Others Then
                    proActualizaMovimiento(nuMMITCODI, 'INTENTO', SQLERRM);
					pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbMesjErr);
					Errors.seterror;
					Errors.geterror (onuErrorCode, osbMesjErr);
        end;
			end loop; -- for reMoviSolicitud in cuMoviSolicitud loop

			Exception
					When Others Then
                    proActualizaMovimiento(nuMMITCODI, 'INTENTO', SQLERRM);
					pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbMesjErr);
					Errors.seterror;
					Errors.geterror (onuErrorCode, osbMesjErr);
			end proConfirmarSolicitud;

			-- Notifica el movimiento de isbMaterial al front
			PROCEDURE proReprocesaMovimiento(inuMovMatCodi   in  LDCI_INTEMMIT.MMITCODI%type,
																																			inuCurrent	     in NUMBER,
																																			inuTotal	       in NUMBER,
																																			onuErrorCode    out NUMBER,
																																			osbErrorMessage out VARCHAR2)  is
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : LDCI_PKMOVIVENTMATE.proReprocesaMovimiento
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 04-04-2013
						RICEF      : I004; I018
						DESCRIPCION: Toma los datos de la interfaz y le asigna a los datos al API OS_SET_REQUEST_CONF

					Historia de Modificaciones
					Autor   Fecha   Descripcion
			*/
			begin
					ut_trace.trace('inicia proReprocesaMovimiento',15);
					ut_trace.trace('inicia inuMovMatCodi: ' || inuMovMatCodi ,16);
					ut_trace.trace('inicia inuCurrent   : ' || inuCurrent ,16);
					ut_trace.trace('inicia inuTotal     : ' || inuTotal ,16);
					ut_trace.trace('finaliza proReprocesaMovimiento',15);
			exception
					when ex.CONTROLLED_ERROR then
								raise;

					when OTHERS then
								Errors.setError;
								raise ex.CONTROLLED_ERROR;
			end proReprocesaMovimiento;


			-- Notifica el movimiento de isbMaterial al front
			PROCEDURE proAsignaMaterialSeriado(isbPosicion     in VARCHAR2,
																																					inuCurrent	     in NUMBER,
																																					inuTotal	       in NUMBER,
																																					onuErrorCode    out NUMBER,
																																					osbErrorMessage out VARCHAR2)  is
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : LDCI_PKMOVIVENTMATE.proAsignaMaterialSeriado
						AUTOR      : OLSoftware / Carlos E. Virgen
						FECHA      : 04-04-2013
						RICEF      : I064
						DESCRIPCION: Toma los datos de la interfaz y le asigna a los datos al API OS_SET_REQUEST_CONF

					Historia de Modificaciones
					Autor   Fecha   Descripcion
			*/
					cnuNULL_ATTRIBUTE constant number := 2126;
					nuErrorCode NUMBER;
					ol_Payload CLOB;
					sb_Payload VARCHAR2(3000);
					osbMesjErr VARCHAR2(2000);

					-- definicion de cursores
					-- cusor de la posicion
					cursor cuPosicion(isbPosicion VARCHAR2) is
							select * from
								(select rownum CODIGO,
																trim(regexp_substr(isbPosicion,'[^|]+', 1, level)) VALOR
										from dual
											connect by regexp_substr(isbPosicion, '[^|]+', 1, level) is not null)
							PIVOT (MAX(VALOR)  FOR (CODIGO) IN (1 as DOC, 2 as POS, 3 as UNIDAD_OPERATIVA,4 as PROVEEDOR));

					-- cursor de la posicion vendida
					cursor cuLDCI_ITEMDOVE(isbDOVECODI LDCI_DOCUVENT.DOVECODI%type,
																											inuITDVCODI LDCI_ITEMDOVE.ITDVCODI%type) is
											select ITDVCODI,
																	ITDVITEM,
																	ITDVCANT,
																	ITDVCAPE,
																	ITDVCOUN,
																	ITDVVAUN,
																	ITDVPIVA,
																	ITDVMARC,
																	ITDVSERI,
																	ITDVSAFI,
																	ITDVMABO,
																	ITDVVALO
									from LDCI_DOCUVENT, LDCI_ITEMDOVE, GE_ITEMS
								where DOVECODI = isbDOVECODI
										and ITDVCODI = inuITDVCODI
										and DOVECODI = ITDVDOVE
										and CODE = ITDVITEM;  --#OYM_CEV_2740_1 ITEMS_ID --> CODE

					-- variables tipo registro
					reLDCI_ITEMDOVE	cuLDCI_ITEMDOVE%rowtype;
					rePosicion        cuPosicion%rowtype;
			begin
     --FAC_CEV_3655_1
     open cuWS_MOVIMIENTO_MATERIAL;
     fetch cuWS_MOVIMIENTO_MATERIAL into reWS_MOVIMIENTO_MATERIAL;
     close cuWS_MOVIMIENTO_MATERIAL;

					nuErrorCode := 0;

					open cuPosicion(isbPosicion);
					fetch cuPosicion into rePosicion;
					close cuPosicion;

					------------------------------------------------
					-- Required Attributes
					------------------------------------------------
					if (rePosicion.DOC is null) then
									Errors.SetError (cnuNULL_ATTRIBUTE, 'NUMERO DOCUMENTO SAP');
									raise ex.CONTROLLED_ERROR;
					end if;

					if (rePosicion.PROVEEDOR is null) then
									Errors.SetError (cnuNULL_ATTRIBUTE, 'UNIDAD OPERATIVA PROVEEDOR LOG??STICO');
									raise ex.CONTROLLED_ERROR;
					end if;

					if (rePosicion.UNIDAD_OPERATIVA is null) then
									Errors.SetError (cnuNULL_ATTRIBUTE, 'C??DIGO UNIDAD OPERATIVA');
									raise ex.CONTROLLED_ERROR;
					end if;

					ut_trace.trace('inicia proAsignaMaterialSeriado',15);
					ut_trace.trace('inicia rePosicion.DOC             : ' || rePosicion.DOC ,16);
					ut_trace.trace('inicia rePosicion.POS             : ' || rePosicion.POS ,16);
					ut_trace.trace('inicia rePosicion.PROVEEDOR       : ' || rePosicion.PROVEEDOR ,16);
					ut_trace.trace('inicia rePosicion.UNIDAD_OPERATIVA: ' || rePosicion.UNIDAD_OPERATIVA ,16);
					ut_trace.trace('inicia inuCurrent     : ' || inuCurrent ,16);
					ut_trace.trace('inicia inuTotal       : ' || inuTotal ,16);


					open cuLDCI_ITEMDOVE(rePosicion.DOC, rePosicion.POS);
					fetch cuLDCI_ITEMDOVE into reLDCI_ITEMDOVE;
					close cuLDCI_ITEMDOVE;

					ut_trace.trace('call proGenXMLItemSeriVendido : ' ,16);

					-- genera el XML para el acep item
					proGenXMLItemSeriVendido(rePosicion.DOC,
																														rePosicion.PROVEEDOR,
																														rePosicion.POS,
																														reLDCI_ITEMDOVE.ITDVITEM,
																														rePosicion.UNIDAD_OPERATIVA,
																														'I',
																														ol_Payload,
																														osbMesjErr);

					sb_Payload := ol_Payload;
					ut_trace.trace('out proGenXMLItemSeriVendido : ' ,16);
					ut_trace.trace('ol_Payload : ' || chr(13) || sb_Payload ,16);
					ut_trace.trace('osbMesjErr : ' || chr(13) || osbMesjErr ,16);


					if (osbMesjErr is not null) then
								Errors.SetError (cnuNULL_ATTRIBUTE, osbMesjErr);
								raise ex.CONTROLLED_ERROR;
					end if;--if (osbMesjErr is not null) then

					-- Carga el serial a la unidad operativa destinada
					OS_LOADACCEPT_ITEMS(ol_Payload, nuErrorCode, osbMesjErr);

					-- valida si OS_LOADACCEPT_ITEMS se ejecuto con exito
					if (nuErrorCode <> 0) then
								Errors.SetError (cnuNULL_ATTRIBUTE, osbMesjErr);
								raise ex.CONTROLLED_ERROR;
					end if;--if (onuErrorCode <> 0) then

					-- actualiza la posici??n asignando el elemento seriado
					update LDCI_ITEMDOVE set ITDVPROV = rePosicion.PROVEEDOR, ITDVOPUN = rePosicion.UNIDAD_OPERATIVA
						where 	ITDVDOVE = rePosicion.DOC
								and ITDVCODI = rePosicion.POS	;
					ut_trace.trace('finaliza proAsignaMaterialSeriado',15);
					--commit --OFF;
			exception
					when ex.CONTROLLED_ERROR then
								raise;

					when OTHERS then

								Errors.setError;
								raise ex.CONTROLLED_ERROR;
			end proAsignaMaterialSeriado;

			PROCEDURE proActivaSoliVenta(inuPosicion     in NUMBER,
										 inuCurrent	     in NUMBER,
										 inuTotal	     in NUMBER,
										 onuErrorCode    out NUMBER,
										 osbErrorMessage out VARCHAR2)  is
			/*
						PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
						FUNCION    : LDCI_PKMOVIVENTMATE.proActivaSoliVenta
						AUTOR      : OLSoftware / Carlos E. Virgen <carlos.virgen@olsfotware.com>
						FECHA      : 03-03-2015
						RICEF      : 138682
						DESCRIPCION: Procesa las solicitudes de venta y las reactiva para ser enviadas

					Historia de Modificaciones
					Autor   Fecha   Descripcion
			*/
					cnuNULL_ATTRIBUTE constant number := 2126;

			begin

					onuErrorCode := 0;
					ut_trace.trace('inicia proActivaSoliVenta',15);

					--Activa la transaccion para actualziarla
					--ldc_bomaterialrequest.ActivateTable(inuPosicion);

                    ut_trace.trace('inicia inuPosicion     : ' || inuPosicion ,16);
					ut_trace.trace('inicia inuCurrent     : ' || inuCurrent ,16);
					ut_trace.trace('inicia inuTotal       : ' || inuTotal ,16);

					--Actualiza la transaccion
					update LDCI_TRANSOMA set TRSMACTI = 'N', TRSMESTA = 1
					  where TRSMCODI = inuPosicion;

					--Desactiva la trasaccion
                    --ldc_bomaterialrequest.CloseTable(inuPosicion);

					ut_trace.trace('finaliza proActivaSoliVenta',15);
					commit;

			exception
					when ex.CONTROLLED_ERROR then
						rollback;
						raise;
					when OTHERS then
						rollback;
						Errors.setError;
						raise ex.CONTROLLED_ERROR;
			end proActivaSoliVenta;


	END LDCI_PKMOVIVENTMATE;
/

