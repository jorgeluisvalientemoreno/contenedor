create or replace PROCEDURE LDC_INSERTITEMSMASIVO
(
    inuSchedule IN ge_process_schedule.process_schedule_id%TYPE
)
IS

    /*******************************************************************************
     Metodo:       LDC_INSERTITEMSMASIVO
     Descripcion:  Procedimiento que esta asociado al PB LDC_INSERTITEMSMASIVO el cual se ejecuta
				   para leer el archivo plano subido en el servidor y validar los datos sean los adecuados
				   tanto para la estructura del archivo de items como la del archivo de actividades caso 297

     Fecha:        23/07/2020

     Historia de Modificaciones
     FECHA        	OLSOFTWARE			Creacion de procedimiento LDC_INSERTITEMSMASIVO caso 297
	 06/03/2024		jsoto 				OSF-2381
										Ajustes:
										Se reemplaza uso de  GE_BOFILEMANAGER.CSBREAD_OPEN_FILE por   por  
										Se reemplaza uso de  GE_BOFILEMANAGER.FILEREAD porpkg_gestionarchivos.fsbobtenerlinea_smf
										Se reemplaza uso de  EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
										Se reemplaza uso de  UT_TRACE.TRACE por PKG_TRAZA.TRACE
										Se reemplaza uso de  GE_BOPERSONAL.FNUGETPERSONID por pkg_bopersonal.fnugetpersonaid
										Se reemplaza uso de  UTL_FILE.FILE_TYPE por PKG_GESTIONARCHIVOS.STYARCHIVO
										Se reemplaza uso de  ERRORS.SETERROR por PKG_ERROR.SETERROR
										Se reemplaza uso de  GE_BOFILEMANAGER.FILEOPEN por pkg_gestionarchivos.ftabrirarchivo_smf
										Se reemplaza uso de  UTL_FILE.FCLOSE por pkg_gestionarchivos.prccerrararchivo_smf
										Se suprime uso de FBLAPLICAENTREGAXCASO y FBLAPLICAENTREGA y se deja la logica solamente los que esten activos.
										Se ajusta el manejo de errores y trazas por los personalizados

    *******************************************************************************/
	--- VARIABLES DE INSTANCIA DEL PB ---
    nuValidaNumerico			NUMBER := 0;
	sbPathFile					varchar2(200); ---'/smartfiles/Seguridad';
	sbFileName	 				varchar2(200); ---'Items_datos.txt';
	sbNameOrigSinExt			varchar2(200);	
	sbNombreArchivolog			varchar2(200);	
	sbNameFilesinExt			varchar2(200);
	sbEmail						varchar2(200);
	sb_subject            		varchar2(200);
	sb_text_msg           		varchar2(200);
	nuDirectoryID         		ge_directory.directory_id%type;
    sbDirectory_id              varchar2(200);
	sbActividad	 				varchar2(100); 
	sbItems	 					varchar2(100); 
	nuHilos                     NUMBER := 1;
    sbParametros                ge_process_schedule.parameters_%TYPE;
	nuLogProceso                ge_log_process.log_process_id%TYPE;


	--- VARIABLES DEL PROCEDURE ---
	nuCaso 		   				varchar2(30):='0000297';
	subtype stysizeline   		is varchar2(32000);
	fpordersdata          		pkg_gestionArchivos.styArchivo;
	cnumaxlengthtoassig   		constant  number:=32000; 
	tbstring              		ut_string.tytb_string;
	sbseparador           		varchar2(1) := '|';  
	sbline                		stysizeline;
	nurecord              		number;
	nuLineCont					NUMBER := 0;
	UTLFileLogItem				pkg_gestionArchivos.styArchivo;
	sbMessageError				varchar2(1000);
	
	nuError NUMBER;
	sbError VARCHAR2(4000);
	csbMetodo VARCHAR2(100) := 'LDC_INSERTITEMSMASIVO';


	--- VARIABLES QUE SE ASIGNARAN LOS DATOS DEL TEXTO PLANO --

	-------- Variables de Items -----------
	nuCodExterno				NUMBER;
	sbDescripcion				VARCHAR2(2000);
	nuClasificacion				NUMBER;
	nuUnidMedida				NUMBER;
	nuTipo						NUMBER;
	nuConcepto					NUMBER;
	nuConceptoDescuento			NUMBER;
	sbRecuperable				VARCHAR2(1 BYTE);
	nuItemRecupe				NUMBER;
	nuCostoUnitario				NUMBER;
	nuGarantiaDias				NUMBER;
	nuCategoria					NUMBER;
	nuTipoElemento				NUMBER;
	nuClaseElement				NUMBER;
	nuAtributo					NUMBER;
	sbTipoAprovisio				varchar2(100);
	sbCompartido				VARCHAR2(1 BYTE):= 'N';
	sbPlataforma				varchar2(100):= NULL;
	nuEstadoInicial				NUMBER := 1;
	nuCampAdiItemMater			NUMBER;


	-------- Variables de Actividades -----------
	nuObjeto							NUMBER;	
	sbUtilidad							varchar2(200);	
	nuTimeExeMinuto						NUMBER;
	nuActivtyCompens					NUMBER;
	nuObjetoCompens						NUMBER;
	nuCantLega							NUMBER;
	sbLegaMultiple						VARCHAR2(1 BYTE);
	sbObservNovedad						VARCHAR2(1000);
	sbItemNovedad						VARCHAR2(1 BYTE);
	nuSigno								NUMBER;


	CURSOR cuCorreo IS
	select e_mail 
	from ge_person 
	where person_id = pkg_bopersonal.fnugetpersonaid;

    /**************************************************************
    Unidad      :  FNUVALIDANUMERO
    Descripcion :  Funcion que valida si el valor ingresado es un
				   numero o no

    Parametros  :	p_cadena  -- cadena de texto a validar

    Autor         : OLSOFTWARE SAS
    Fecha         : 31/07/2020
    ***************************************************************/
    FUNCTION FNUVALIDANUMERO
    (
       p_cadena       in   varchar2
    )
    return number
    IS
	
	csbMetodo1 VARCHAR2(100) := csbMetodo||'.FNUVALIDANUMERO';
	validaText Varchar2(500);
	
	cursor cuValidaCadena is
    select CASE WHEN LENGTH(TRIM(TRANSLATE(p_cadena, '0123456789-', ' '))) IS NULL 
                THEN 'NUMERO' 
                ELSE 'TEXTO'
                end 
				from dual;

	
    BEGIN

    pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

	IF cuValidaCadena%ISOPEN THEN
		CLOSE cuValidaCadena;
	END IF;

	OPEN cuValidaCadena;
	FETCH cuValidaCadena into validaText;
	CLOSE cuValidaCadena;
	
	pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 
        if(validaText = 'NUMERO')then
            return 1;
        else
            return 0;
        end if;
		

    EXCEPTION
        when pkg_error.controlled_error then
        pkg_error.getError(nuError, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		raise pkg_error.controlled_error;
        when others then
        pkg_error.setError;
		pkg_error.getError(nuError, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.controlled_error;
    END FNUVALIDANUMERO;

BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
    

		-- se adiciona al log de procesos
        ge_boschedule.AddLogToScheduleProcess(inuSchedule,nuHilos,nuLogProceso);

		-- Se obtiene el registro de la programacion
		sbParametros      := dage_process_schedule.fsbgetparameters_(inuSchedule);

		-- se obtienen los parametros ingresados en el PB
        sbDirectory_id    := TRIM(ut_string.getparametervalue(sbParametros,'DIRECTORY_ID','|','='));
        sbFileName        := TRIM(ut_string.getparametervalue(sbParametros,'ORDER_COMMENT','|','='));
        sbActividad       := TRIM(ut_string.getparametervalue(sbParametros,'LEGALIZE_COMMENT','|','='));
        sbItems        	  := TRIM(ut_string.getparametervalue(sbParametros,'COMPARABLE','|','='));

        sbPathFile 			  := pkg_bcdirectorios.fsbGetRuta( sbDirectory_id );
		nuDirectoryID		  := to_number( sbDirectory_id );

		-- se quita la extension .txt del nombre original para poder concatenarlo
		sbNameOrigSinExt	  := replace(sbFileName,'.txt','');
		sbNombreArchivolog    := sbNameOrigSinExt||to_char(sysdate,'_ddmmyyyy_')||to_char(sysdate,'hhmmss')||'.err';
        
        nuValidaNumerico := 0;
		----------------------------------------------------------------------------------------
		------------------------------------ VALIDACION DE ITEMS -------------------------------		
		----------------------------------------------------------------------------------------
		if(sbItems = 'Y')then -- creacion de items

			-- se obtiene el archivo txt del servidor --
					
			fpordersdata:= pkg_gestionarchivos.ftabrirarchivo_smf(sbpathfile,sbFileName,pkg_gestionarchivos.csbmodo_lectura);

			-- se llama al proceso que crea el archivo de log y se guarda la instancia del archivo en una variable --
			UTLFileLogItem := LDC_PKGESTIONITEMS.LDC_CREATXTLOG(sbPathFile, sbNombreArchivolog);

			-- se recorre el archivo txt linea por linea --
			while true loop
    
				BEGIN
					
					sbline := pkg_gestionarchivos.fsbobtenerlinea_smf(fpordersdata);
				
				EXCEPTION WHEN NO_DATA_FOUND THEN
					EXIT;
				END;

				sbline:=replace(replace(trim(sbline),chr(10), ''), chr(13),'');
				nurecord := nurecord + 1;

				-- se crea un contador para establecer el numero de linea que se procesa
				nuLineCont := nuLineCont + 1;
				ut_string.extstring(sbline, sbseparador , tbstring);  --se crea tabla pl con los datos correspondiente
                
                nuValidaNumerico := 0;
                --sbMessageError := '';

				if(tbstring(1) is not null)then
                    if(FNUVALIDANUMERO(tbstring(1)) = 1)then 	
                        nuCodExterno:= to_number(tbstring(1)); 	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := 'El codigo externo debe ser numerico';
                    end if;
                else
                    nuCodExterno := null;
                end if;
                

				sbDescripcion:= tbstring(2);  

                if(tbstring(3) is not null)then
                    if(FNUVALIDANUMERO(tbstring(3)) = 1)then 	
                        nuClasificacion	:= to_number(tbstring(3));  	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El codigo de la clasificacion debe ser numerico';
                    end if;
                else
                    nuClasificacion	:= null;
                end if;
                

				if(tbstring(4) is not null)then
                    if(FNUVALIDANUMERO(tbstring(4)) = 1)then 	
                        nuUnidMedida := to_number(tbstring(4));	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', La unidad de medida debe ser numerica';
                    end if;
                else
                    nuUnidMedida := null;
                end if;
    

				if(tbstring(5) is not null)then
                    if(FNUVALIDANUMERO(tbstring(5)) = 1)then 	
                        nuTipo := to_number(tbstring(5));
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El tipo de item debe ser numerico';
                    end if;
                else
                    nuTipo := null;
                end if;
                

				if(tbstring(6) is not null)then
                    if(FNUVALIDANUMERO(tbstring(6)) = 1)then 	
                        nuConcepto := to_number(tbstring(6));	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El concepto debe ser numerico';
                    end if;
                else
                    nuConcepto := null;
                end if;


				if(tbstring(7) is not null)then
                    if(FNUVALIDANUMERO(tbstring(7)) = 1)then 	
                        nuConceptoDescuento := to_number(tbstring(7));	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El concepto de descuento debe ser numerico';
                    end if;
                else
                    nuConceptoDescuento := null;
                end if;

				sbRecuperable			:= tbstring(8);  

                if(tbstring(9) is not null)then
                    if(FNUVALIDANUMERO(tbstring(9)) = 1)then 	
                        nuItemRecupe := to_number(tbstring(9)); 	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El item de recuperacion debe ser numerico';
                    end if;
                else
                    nuItemRecupe := null;
                end if;
                
               
				if(tbstring(10) is not null)then
                    if(FNUVALIDANUMERO(tbstring(10)) = 1)then 	
                        nuCostoUnitario := to_number(tbstring(10)); 	 
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El Costo Unitario debe ser numerico';
                    end if;
                else
                    nuCostoUnitario := null;
                end if;
                

                if(tbstring(11) is not null)then
                    if(FNUVALIDANUMERO(tbstring(11)) = 1)then 	
                        nuGarantiaDias := to_number(tbstring(11)); 	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', Los dias de garantia debe ser numerico';
                    end if;
                else
                    nuGarantiaDias := null;
                end if;
                

				if(tbstring(12) is not null)then
                    if(FNUVALIDANUMERO(tbstring(12)) = 1)then 	
                        nuCategoria := to_number(tbstring(12)); 	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', La categoria debe ser numerico';
                    end if;
                else
                    nuCategoria := null;
                end if;
                

				if(tbstring(13) is not null)then
                    if(FNUVALIDANUMERO(tbstring(13)) = 1)then 	
                        nuTipoElemento := to_number(tbstring(13)); 	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El tipo de elemento debe ser numerico';
                    end if;
                else
                    nuTipoElemento := null;
                end if;
  
  
				if(tbstring(14) is not null)then
                    if(FNUVALIDANUMERO(tbstring(14)) = 1)then 	
                        nuClaseElement := to_number(tbstring(14)); 	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', La clase de elemento debe ser numerico';
                    end if;
                else
                    nuClaseElement := null;
                end if;

				
				if(tbstring(15) is not null)then
                    if(FNUVALIDANUMERO(tbstring(15)) = 1)then 	
                        nuAtributo := to_number(tbstring(15)); 	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El atributo debe ser numerico';
                    end if;
                else
                    nuAtributo := null;
                end if;
                
				sbTipoAprovisio := tbstring(16);     

           
				if(nuValidaNumerico = 0)then

					if(nuClasificacion is not null)then
                                           
						if(nuCodExterno is not null)then
                                    
							if(sbDescripcion is not null)then
                                    
								if(nuUnidMedida is not null)then
                                    

									if(nuClasificacion = 1  or nuClasificacion = 3 or nuClasificacion = 23 or nuClasificacion = 50 or
									   nuClasificacion = 51 or nuClasificacion = 52 or nuClasificacion = 903 or nuClasificacion = 904)then

										if(nuCostoUnitario is not null)then
            
											if(nuClasificacion = 51)then
												-- si existe un item con esta clasificacion 51, debe ir un campo adicional
                                                
                                                -- se crea un bloque para validar si no viene la separacion del parametro extra
                                                -- con esto se evitará que el programa se detenga al no recibir nada y mostrará
                                                -- un mensaje indicando que se debe poner la separacion | en la estructura para 
                                                -- validar el dato nulo siempre y cuando la clasificacion sea 51
                                                begin
                                                    
                                                    if(tbstring(17) is not null)then
                                                        if(FNUVALIDANUMERO(tbstring(17)) = 1)then 	
                                                            nuCampAdiItemMater := to_number(tbstring(17)); 	
                                                        else
                                                            nuValidaNumerico := 1;      
                                                            sbMessageError := sbMessageError || 'El item adicional de material debe ser numerico';
                                                        end if;
                                                    else                        
                                                        nuCampAdiItemMater := null;         
                                                    end if;
                                                    
                                                
                                                EXCEPTION
                                                when others then
                                                    nuValidaNumerico := 1;
                                                    sbMessageError := ' Falta un "|" en la estructura para la creacion de items de clasificacion 51, para el valor del item de material que puede ir vacio o llevar dato';
                                                end;
                                                
                                                
                                            else
                                                nuCampAdiItemMater := null;
											end if;

											if(nuValidaNumerico = 0)then    
												----SE LLAMA A LA FUNCION QUE SE ENCARGA DE CREAR EL ITEM
												LDC_PKGESTIONITEMS.LDC_CREATEITEM  (nuCodExterno,
																					sbDescripcion,		
																					nuClasificacion,			
																					nuUnidMedida,			
																					null,					
																					nuConcepto,				
																					nuConceptoDescuento,	
																					null,			
																					null,			
																					nuCostoUnitario,			
																					null,			
																					null,				
																					null,			
																					null,			
																					null,				
																					null,			
																					sbCompartido,			
																					sbPlataforma,			
																					nuEstadoInicial,
																					UTLFileLogItem,
																					nuLineCont,
																					nuCampAdiItemMater);
											else
												LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = '||sbMessageError);
											end if;

										else
											LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El Costo unitario no puede ser NULL!!!');
										end if;

									end if;



									if(nuClasificacion = 4  or nuClasificacion = 5)then

										if(nuCostoUnitario is not null)then

											if(nuTipoElemento is not null)then

												LDC_PKGESTIONITEMS.LDC_CREATEITEM  (nuCodExterno,			
																					sbDescripcion,			
																					nuClasificacion,			
																					nuUnidMedida,			
																					null,					
																					nuConcepto,				
																					nuConceptoDescuento,		
																					null,			
																					null,			
																					nuCostoUnitario,			
																					nuGarantiaDias,			
																					null,				
																					nuTipoElemento,			
																					nuClaseElement,			
																					nuAtributo,				
																					null,			
																					sbCompartido,			
																					sbPlataforma,			
																					nuEstadoInicial,
																					UTLFileLogItem,
																					nuLineCont,
																					null);

											else
												LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El tipo de elemento no puede ser NULL!!!');
											end if;

										else
											LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El Costo unitario no puede ser NULL!!!');
										end if;

									end if;



									if(nuClasificacion = 7)then

										LDC_PKGESTIONITEMS.LDC_CREATEITEM  (nuCodExterno,			
																			sbDescripcion,			
																			nuClasificacion,			
																			nuUnidMedida,			
																			null,					
																			nuConcepto,				
																			nuConceptoDescuento,		
																			null,			
																			null,			
																			null,			
																			null,
																			null,			
																			null,			
																			null,			
																			null,				
																			null,			
																			sbCompartido,			
																			sbPlataforma,			
																			nuEstadoInicial,
																			UTLFileLogItem,
																			nuLineCont,
																			null);

									end if;




									if(nuClasificacion = 8 or nuClasificacion = 9)then

										-- SE LLAMA AL PROCESO QUE CREA EL ITEM --
										LDC_PKGESTIONITEMS.LDC_CREATEITEM  (nuCodExterno,			
																			sbDescripcion,			
																			nuClasificacion,			
																			nuUnidMedida,			
																			null,					
																			nuConcepto,				
																			nuConceptoDescuento,		
																			sbRecuperable,			
																			nuItemRecupe,			
																			null,			
																			null,
																			null,			
																			null,			
																			null,			
																			null,				
																			null,			
																			sbCompartido,			
																			sbPlataforma,			
																			nuEstadoInicial,
																			UTLFileLogItem,
																			nuLineCont,
																			null);


									end if;





									if(nuClasificacion = 6  or nuClasificacion = 10  or nuClasificacion = 11)then

										if(nuTipoElemento is not null)then

											--- SE LLAMA AL PROCESO QUE CREA EL ITEM
											LDC_PKGESTIONITEMS.LDC_CREATEITEM  (nuCodExterno,			
																				sbDescripcion,			
																				nuClasificacion,			
																				nuUnidMedida,			
																				null,					
																				nuConcepto,				
																				nuConceptoDescuento,		
																				null,			
																				null,			
																				null,			
																				nuGarantiaDias,			
																				null,				
																				nuTipoElemento,			
																				nuClaseElement,			
																				nuAtributo,				
																				null,			
																				sbCompartido,			
																				sbPlataforma,			
																				nuEstadoInicial,
																				UTLFileLogItem,
																				nuLineCont,
																				null);

										else
											LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El tipo de elemento no puede ser NULL!!!');
										end if;

									end if;




									if(nuClasificacion = 13)then

										if(nuTipo is not null)then

											if(sbTipoAprovisio is not null)then

												-- SE LLAMA AL PROCESO QUE CREA EL ITEM
												LDC_PKGESTIONITEMS.LDC_CREATEITEM  (nuCodExterno,			
																					sbDescripcion,			
																					nuClasificacion,			
																					nuUnidMedida,			
																					nuTipo,					
																					nuConcepto,				
																					nuConceptoDescuento,		
																					null,			
																					null,			
																					null,			
																					nuGarantiaDias,			
																					null,				
																					null,			
																					null,			
																					null,				
																					sbTipoAprovisio,			
																					sbCompartido,			
																					sbPlataforma,			
																					nuEstadoInicial,
																					UTLFileLogItem,
																					nuLineCont,
																					null);

											else
												LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El tipo de aprovisionamiento no puede ser NULL!!!');
											end if;

										else
											LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El tipo no puede ser NULL!!!');
										end if;

									end if;




									if(nuClasificacion = 20)then

										if(nuCostoUnitario is not null)then

											-- SE LLAMA AL PROCESO QUE CREA EL ITEM
											LDC_PKGESTIONITEMS.LDC_CREATEITEM  (nuCodExterno,			
																				sbDescripcion,			
																				nuClasificacion,			
																				nuUnidMedida,			
																				null,					
																				nuConcepto,				
																				nuConceptoDescuento,		
																				null,			
																				null,			
																				nuCostoUnitario,			
																				null,			
																				null,				
																				null,			
																				null,			
																				null,				
																				null,			
																				sbCompartido,			
																				sbPlataforma,			
																				nuEstadoInicial,
																				UTLFileLogItem,
																				nuLineCont,
																				null);

										else
											LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El Costo unitario no puede ser NULL!!!');
										end if;

									end if;





									if(nuClasificacion = 21)then

										if(nuTipo is not null)then

											if(sbTipoAprovisio is not null)then

												--- SE LLAMA AL PROCESO QUE CREA EL ITEM
												LDC_PKGESTIONITEMS.LDC_CREATEITEM  (nuCodExterno,			
																					sbDescripcion,			
																					nuClasificacion,			
																					nuUnidMedida,			
																					nuTipo,					
																					nuConcepto,				
																					nuConceptoDescuento,		
																					sbRecuperable,			
																					nuItemRecupe,			
																					null,			
																					nuGarantiaDias,			
																					nuCategoria,				
																					null,			
																					null,			
																					null,				
																					sbTipoAprovisio,			
																					sbCompartido,			
																					sbPlataforma,			
																					nuEstadoInicial,
																					UTLFileLogItem,
																					nuLineCont,
																					null);

											else
												LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El tipo de aprovisionamiento no puede ser NULL!!!');
											end if;

										else
											LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El campo del tipo de item no puede ser nulo si la clasificacion del item es de Equipos y accesorios [21]!!!');
										end if;

									end if;




								else
									LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = La Unidad de medida no puede ser NULL!!!');
								end if;

							else	
								LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = La descripcion no puede ser NULL!!!');
							end if;

						else
							LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El codigo Externo no puede ser NULL!!!');
						end if;


					else				
						-- se registra el mensaje de error en el bloc de notas
						LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = Debe ingresar la clasificacion del item');
					end if;

				else
					LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = '||sbMessageError);
				end if;




			end loop;


		----------------------------------------------------------------------------------------
		------------------------------- VALIDACION DE ACTIVIDADES ------------------------------	
		----------------------------------------------------------------------------------------
		else  

			-- se obtiene el archivo txt del servidor --

			fpordersdata:= pkg_gestionarchivos.ftabrirarchivo_smf(sbpathfile,sbFileName,pkg_gestionarchivos.csbmodo_lectura);

			-- se llama al proceso que crea el archivo de log y se guarda la instancia del archivo en una variable --
			UTLFileLogItem := LDC_PKGESTIONITEMS.LDC_CREATXTLOG(sbPathFile, sbNombreArchivolog);

			-- se recorre el archivo txt linea por linea --
			while true loop

				BEGIN
					
					sbline := pkg_gestionarchivos.fsbobtenerlinea_smf(fpordersdata);
				
				EXCEPTION 
				WHEN NO_DATA_FOUND THEN
					EXIT;
                WHEN OTHERS THEN
                    RAISE;
				END;

				sbline:=replace(replace(trim(sbline),chr(10), ''), chr(13),'');
				nurecord := nurecord + 1;

				-- se crea un contador para establecer el numero de linea que se procesa
				nuLineCont := nuLineCont + 1;

				ut_string.extstring(sbline, sbseparador , tbstring);  --se crea tabla pl con los datos correspondiente
                
                nuValidaNumerico := 0;
                
                if(tbstring(1) is not null)then
                    if(FNUVALIDANUMERO(tbstring(1)) = 1)then 	
                        nuObjeto := to_number(tbstring(1)); 	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El campo objeto debe ser numerico';
                    end if;
                else
                    nuObjeto := null;
                end if;
                
                
				sbDescripcion := tbstring(2);  
                
                
                if(tbstring(3) is not null)then
                    if(FNUVALIDANUMERO(tbstring(3)) = 1)then 	
                        nuConcepto := to_number(tbstring(3)); 	
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El concepto debe ser numerico';
                    end if;
                else
                    nuConcepto := null;
                end if;
   
                if(tbstring(4) is not null)then
                    if(FNUVALIDANUMERO(tbstring(4)) = 1)then 	
                        nuCostoUnitario := to_number(tbstring(4));
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El costo unitario debe ser numerico';
                    end if;
                else
                    nuCostoUnitario := null;
                end if;


				sbUtilidad	:= tbstring(5);


                if(tbstring(6) is not null)then
                    if(FNUVALIDANUMERO(tbstring(6)) = 1)then 	
                        nuConceptoDescuento := to_number(tbstring(6));
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El concepto de descuento debe ser numerico';
                    end if;
                else
                    nuConceptoDescuento := null;
                end if;
                
                
                if(tbstring(7) is not null)then
                    if(FNUVALIDANUMERO(tbstring(7)) = 1)then 	
                        nuUnidMedida := to_number(tbstring(7));
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', La unidad de medida debe ser numerico';
                    end if;
                else
                    nuUnidMedida := null;
                end if;

                
                if(tbstring(8) is not null)then
                    if(FNUVALIDANUMERO(tbstring(8)) = 1)then 	
                        nuTimeExeMinuto := to_number(tbstring(8));
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El tiempo por minuto debe ser numerico';
                    end if;
                else
                    nuTimeExeMinuto := null;
                end if;
				
                
                if(tbstring(9) is not null)then
                    if(FNUVALIDANUMERO(tbstring(9)) = 1)then 	
                        nuActivtyCompens := to_number(tbstring(9));
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', La actividad de compensacion debe ser numerico';
                    end if;
                else
                    nuActivtyCompens := null;
                end if;


                if(tbstring(10) is not null)then
                    if(FNUVALIDANUMERO(tbstring(10)) = 1)then 	
                        nuObjetoCompens := to_number(tbstring(10));
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El objeto de compensacion debe ser numerico';
                    end if;
                else
                    nuObjetoCompens := null;
                end if;


				if(tbstring(11) is not null)then
                    if(FNUVALIDANUMERO(tbstring(11)) = 1)then 	
                        nuCantLega := to_number(tbstring(11));
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', La Cantidad de legalizacion debe ser numerico';
                    end if;
                else
                    nuCantLega := null;
                end if;	


				if(tbstring(12) is not null)then
                    if(FNUVALIDANUMERO(tbstring(12)) = 1)then 	
                        nuGarantiaDias := to_number(tbstring(12));
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', Los dias de garantia debe ser numerico';
                    end if;
                else
                    nuGarantiaDias := null;
                end if;		

				sbLegaMultiple			:= tbstring(13);                 
				sbObservNovedad			:= tbstring(14);                 
				sbItemNovedad			:= tbstring(15);   

				
                if(tbstring(16) is not null)then
                    if(FNUVALIDANUMERO(tbstring(16)) = 1)then 	
                        nuSigno := to_number(tbstring(16));
                    else
                        nuValidaNumerico := 1;
                        sbMessageError := sbMessageError || ', El signo debe ser numerico';
                    end if;
                else
                    nuSigno := null;
                end if;	
                

				if(nuValidaNumerico = 0)then

					--- aqui se valida que en el item de novedad no este activado con el valor de Y
					if(sbItemNovedad is null or sbItemNovedad = 'N')then

						if(sbDescripcion is not null)then

							if(nuCostoUnitario is not null)then

								if(nuUnidMedida is not null)then

									if(nuTimeExeMinuto is not null)then

										-- SE LLAMA AL PROCESO QUE CREA LA ACTIVIDAD
										LDC_PKGESTIONITEMS.LDC_CREATEACTIVITY(	
																				nuObjeto,					
																				sbDescripcion,				
																				nuConcepto,					
																				nuCostoUnitario,				
																				sbUtilidad,					
																				nuConceptoDescuento,			
																				nuUnidMedida,				
																				nuTimeExeMinuto,				
																				nuActivtyCompens,			
																				nuObjetoCompens,				
																				nuCantLega,					
																				nuGarantiaDias,				
																				sbLegaMultiple,				
																				sbObservNovedad,				
																				sbItemNovedad,				
																				nuSigno,						
																				nuEstadoInicial,				
																				UTLFileLogItem,      		
																				nuLineCont					
																			);

									else
										LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El tiempo de ejecucion no puede ser NULL!!!');
									end if;

								else	
									LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = La Unidad de medida no puede ser NULL!!!');
								end if;

							else
								LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El costo unitario no puede ser NULL!!!');
							end if;


						else				
							LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = La descripcion no puede ser NULL!!!');
						end if;

					else

						if(sbItemNovedad = 'Y')then

							if(sbDescripcion is not null)then

								if(nuCostoUnitario is not null)then

									if(nuSigno is not null)then

										-- SE LLAMA AL PROCESO QUE CREA LA ACTIVIDAD
										LDC_PKGESTIONITEMS.LDC_CREATEACTIVITY(	
																				nuObjeto,					
																				sbDescripcion,				
																				nuConcepto,					
																				nuCostoUnitario,				
																				sbUtilidad,					
																				nuConceptoDescuento,			
																				nuUnidMedida,				
																				nuTimeExeMinuto,				
																				nuActivtyCompens,			
																				nuObjetoCompens,				
																				nuCantLega,					
																				nuGarantiaDias,				
																				sbLegaMultiple,				
																				sbObservNovedad,				
																				sbItemNovedad,				
																				nuSigno,						
																				nuEstadoInicial,				
																				UTLFileLogItem,      		
																				nuLineCont					
																			);

									else	
										LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El campo Signo no puede ser NULL!!!');
									end if;

								else
									LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El costo unitario no puede ser NULL!!!');
								end if;

							else				
								LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = La descripcion no puede ser NULL!!!');
							end if;

						else
							LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = El campo item de novedad solo pueden ir los valores Y o N!!!');
						end if;


					end if;

				else
					LDC_PKGESTIONITEMS.LDC_LLENATXTLOG(UTLFileLogItem, nuLineCont||' = '||sbMessageError);
				end if;

			end loop;

		end if;


		-- cuando se terminan de recorrer todas las lineas del archivo se procede a llamar a la funcion
		-- para cerrar el archivo .err que guarda el estado de los items creados o los que generaron error
		if(sbline is null)then

			-- se cierra el archivo de log
			pkg_gestionarchivos.prccerrararchivo_smf(UTLFileLogItem,sbPathFile, sbNombreArchivolog);

			-- se procesa el nombre del archivo			
			sbNameFilesinExt := replace(sbNombreArchivolog,'.err','');

			-- se llama al proceso de envio de correo electronico
				IF cuCorreo%ISOPEN THEN
					CLOSE cuCorreo;
				END IF;

				OPEN cuCorreo;
				FETCH cuCorreo into sbEmail;
				CLOSE cuCorreo;


			if(sbEmail is not null)then

				if(sbItems = 'Y')then
					sb_subject      := 'Generacion de items masiva SMARTFLEX';
					sb_text_msg     := 'Se realiza el proceso de creacion de Items. Se anexa log del proceso.';
				else
					sb_subject      := 'Generacion de Actividades masivas SMARTFLEX';
					sb_text_msg     := 'Se realiza el proceso de creacion de Actividades de forma correcta, se anexa log del proceso.';
				end if;

				LDC_PKGESTIONITEMS.LDC_SENDFILEADJUNT	(	sbNameFilesinExt, 'err',  sbEmail,  sb_subject,   sb_text_msg,  nuDirectoryID );

			end if;

		end if;


		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
    when pkg_error.controlled_error then
		pkg_error.getError(nuError, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        raise pkg_error.controlled_error;
    when others then
		pkg_error.setError;
		pkg_error.getError(nuError, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.controlled_error;
END;
/
GRANT EXECUTE on LDC_INSERTITEMSMASIVO to SYSTEM_OBJ_PRIVS_ROLE; 
