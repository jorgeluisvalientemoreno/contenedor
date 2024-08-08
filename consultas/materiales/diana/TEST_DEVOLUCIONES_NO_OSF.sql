declare
inuMovimiento LDCI_INTEMMIT.MMITCODI%type:=6089;
      TRSMUNOP           NUMBER:=1852;--unidad operativa que tiene el serial
      TRSMPROV          NUMBER:=1773;--unidad operativa proveedor logistico

      onuErrorCode GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
            nuMMITCODI NUMBER; --Id del movimiento
            nuTRSMCODI NUMBER; --Id del perdido de venta
      -- define cursores
      -- cursor de los movimientos de material
      cursor cuMoviSolicitud(inuMMITCODI in LDCI_INTEMMIT.MMITCODI%type) is
        select *
            from LDCI_INTEMMIT
          where MMITCODI = inuMMITCODI
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
      --reLDCI_TRANSOMA           cuLDCI_TRANSOMA%rowtype;

      reGE_CONTRATISTA          cuGE_CONTRATISTA%rowtype;
      reCOUTN_OR_OPERATING_UNIT cuCOUTN_OR_OPERATING_UNIT%rowtype; --#OYM_CEV_2740_1


      -- define variables
      l_Payload   CLOB;
      nuErrorCode NUMBER;
      osbMesjErr GE_ERROR_LOG.DESCRIPTION%type;
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
			cursor cuWS_MOVIMIENTO_MATERIAL is
				select PROVEEDOR_LOGISTICO, ATT_MARCA_TECHNICAL_NAME, ATT_MAXVALUE_TECHNICAL_NAME
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
						 			and CASECODI = 'ATT_MAXVALUE_TECHNICAL_NAME');

			-- variable de tipo rowtype basada en el cursor cuClaseMovi
			reClaseMovi cuClaseMovi%rowtype;
			reWS_MOVIMIENTO_MATERIAL cuWS_MOVIMIENTO_MATERIAL%rowtype;
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
							select DMITITEM,  DMITCOIN, SERINUME,SERIESTR,SERIMARC,SERIANO,SERICAJA,SERIREMA,SERITIEN
																from LDCI_INTEMMIT Mov, LDCI_DMITMMIT Det, LDCI_SERIDMIT Ser
																where Det.DMITMMIT = inuMovimiento
																		and Det.DMITCODI = inuPosicion
																		and Mov.MMITCODI = Det.DMITMMIT
																		and Ser.SERIMMIT = Det.DMITMMIT
																		and Ser.SERIDMIT = Det.DMITCODI
																		and Ser.SERICODI = inuSerial;

      -- cursor del item seriado (Asignacion por venta)
						cursor cuItemSeriadoVenta(isbDocSAP VARCHAR2, isbSerialSAP VARCHAR2) is
							select DMITITEM,  DMITCOIN, SERINUME,SERIESTR,SERIMARC,SERIANO,SERICAJA,SERIREMA,SERITIEN
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
					end loop;--for reAttributes in cuAttributes(reItemSeriado.DMITCOIN) loop

					-- Cierra las etiquetas XML
					oclXMLAttributes := oclXMLAttributes || '</ATTRIBUTES>';

					-- Retorna el XML con los atibutos
					return oclXMLAttributes;
					ut_trace.trace('termina fclGetXMLAttributes',16);
			end fclGetXMLAttributes;

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
									osbMesjErr := '[proGenXMLItemSeriVendido]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
					When Others Then
									osbMesjErr := '[proGenXMLItemSeriVendido]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proGenXMLItemSeriVendido;
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




						-- variables tipo registro
						reGE_ITEMS_SERIADO cuGE_ITEMS_SERIADO%rowtype;

						--exepciones
						excep_proGenXMLItemSeriVendido exception;
						excepOS_LOADACCEPT_ITEMS       exception;
						excep_ITEM_SERIADO             exception;
						excep_proBorLDCI_SERIPOSI      exception;

			begin
			
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
																inuITDVOPUN, --138682: reGE_ITEMS_SERIADO.OPERATING_UNIT_ID,
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
										update LDCI_ITEMDOVE set ITDVPROV = inuITDVPROV, ITDVOPUN = inuITDVOPUN --138682: reGE_ITEMS_SERIADO.OPERATING_UNIT_ID
											where 	ITDVDOVE = isbITDVDOVE
													and ITDVCODI = rgLDCI_ITEMDOVE.ITDVCODI;

				  /*if (inuTRSMTIPO = 1) then 
					  proBorLDCI_SERIPOSI(inuSERITRSM => rgLDCI_ITEMDOVE.ITDVCODI,
										  inuSERITSIT => rgLDCI_ITEMDOVE.ITDVCOIN,
										  isbSERINUME => rgLDCI_ITEMDOVE.ITDVSERI,
										  inuSERISOMA => inuTRSMCODI,
										  onuErrorCode => nuErrorCode,
										  osbErrorMessage => osbMesException);

					  if (nuErrorCode <> 0) then
							raise excep_proBorLDCI_SERIPOSI;
					  end if;--if (nuErrorCode <> 0) then
				  end if;--if (inuTRSMTIPO = 1) then*/
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
							osbMesException := '[proCreaEncabezadoDocVenta]: Registro [' || isbDOVECODI || ']' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
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
							osbMesException := '[proCreaPosicionesDocVenta]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
			end proCreaPosicionesDocVenta;
			
			

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

---				nuTRSMCODI := to_number(substr(reMoviSolicitud.MMITNUPE,instr(reMoviSolicitud.MMITNUPE,'-') + 1, LENGTH(reMoviSolicitud.MMITNUPE)));



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
									  --proActualizaMovimiento(reMoviSolicitud.MMITCODI, 'INTENTO', osbMesjErr);
                    null;

							  else
									  proCreaPosicionesDocVenta(reMoviSolicitud.MMITCODI,
																TRSMUNOP, --reLDCI_TRANSOMA.TRSMUNOP,
																TRSMPROV, ---reLDCI_TRANSOMA.TRSMPROV,
																osbMesjErr);

									  -- valida si la transaccion es exitosa
									  if (osbMesjErr is not null) then
											  --proActualizaMovimiento(reMoviSolicitud.MMITCODI, 'INTENTO', osbMesjErr);
                        null;

									  else

											  if (reMoviSolicitud.MMITNATU = '-') then
													--llamar al proceso que lee los items seriados y los desasigna
													proDesasignaPosicionesDocVenta(-1, --reLDCI_TRANSOMA.TRSMCODI,
																				   1, --reLDCI_TRANSOMA.TRSMTIPO, /*reLDCI_TRANSOMA.TRSMDORE*/
																				   reMoviSolicitud.MMITDSAP,
																				   TRSMUNOP,--reLDCI_TRANSOMA.TRSMUNOP,
																				   TRSMPROV,--reLDCI_TRANSOMA.TRSMPROV,
																				   osbMesjErr);
											  end if;--if (reMoviSolicitud.MMITNATU = '-') then

											  -- valida si la transaccion es exitosa
											  if (osbMesjErr is not null) then
													  null;
                            --proActualizaMovimiento(reMoviSolicitud.MMITCODI, 'INTENTO', osbMesjErr);
													  --#11-11-2014: carlos.virgen: Se adiciona linea para desactivar la tabla LDCI_TRANSOMA
													  --ldc_bomaterialrequest.CloseTable(reLDCI_TRANSOMA.TRSMCODI);
											  else

												  -- confirma la operacion
                          null;
												  --commit;
												  --#11-11-2014: carlos.virgen: Se adiciona linea para desactivar la tabla LDCI_TRANSOMA
												  --ldc_bomaterialrequest.CloseTable(reLDCI_TRANSOMA.TRSMCODI);
												  -- cierra el movimiento
												  --proActualizaMovimiento(reMoviSolicitud.MMITCODI, 'CONFIRMADO', osbMesjErr);

                                end if;-- if (osbMesjErr is not null) then
                            end if;-- if (osbMesjErr is not null) then
                        end if;--if (osbMesjErr is not null) then




        	Exception
					When Others Then
                    --proActualizaMovimiento(nuMMITCODI, 'INTENTO', SQLERRM);
					pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbMesjErr);
					Errors.seterror;
					Errors.geterror (onuErrorCode, osbMesjErr);
        end;
			end loop; -- for reMoviSolicitud in cuMoviSolicitud loop

			Exception
					When Others Then
                   -- proActualizaMovimiento(nuMMITCODI, 'INTENTO', SQLERRM);
					pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbMesjErr);
					Errors.seterror;
					Errors.geterror (onuErrorCode, osbMesjErr);
			end proConfirmarSolicitud;
