CREATE OR REPLACE PACKAGE adm_person.DALDC_LDC_SCORHIST IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     :  DALDC_LDC_SCORHIST
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON                                
    ****************************************************************/   
    
    /* Cursor general para acceso por Llave Primaria */
              CURSOR cuRecord
              (inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE)
              IS  SELECT *
            		  FROM LDC_SCORHIST WHERE SUSCRIPTOR = inuSUSCRIPTOR;

    /* Subtipos */
	           subtype styLDC_SCORHIST  is  cuRecord%rowtype;

   /*Tipos*/
	           type tytbLDC_SCORHIST is table of styLDC_SCORHIST index by binary_integer;

 FUNCTION fblExist
                	(inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE)
                	RETURN boolean;

   FUNCTION frcGetRecord
            	(inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE)
            	RETURN styLDC_SCORHIST;

   PROCEDURE insRecord
            	(ircLDC_SCORHIST in styLDC_SCORHIST);

   PROCEDURE insRecords
            	(iotbLDC_SCORHIST in out nocopy tytbLDC_SCORHIST);

PROCEDURE delRecord
            	(inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE);

PROCEDURE updRecord
            	(ircLDC_SCORHIST in styLDC_SCORHIST);

FUNCTION fnuGetSUSCRIPTOR( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.SUSCRIPTOR%TYPE;

FUNCTION fsbGetTIPO( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO%TYPE;

FUNCTION fnuGetCONSUMO_01( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_01%TYPE;

FUNCTION fnuGetCONSUMO_02( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_02%TYPE;

FUNCTION fnuGetCONSUMO_03( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_03%TYPE;

FUNCTION fnuGetCONSUMO_04( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_04%TYPE;

FUNCTION fnuGetCONSUMO_05( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_05%TYPE;

FUNCTION fnuGetCONSUMO_06( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_06%TYPE;

FUNCTION fnuGetCONSUMO_07( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_07%TYPE;

FUNCTION fnuGetCONSUMO_08( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_08%TYPE;

FUNCTION fnuGetCONSUMO_09( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_09%TYPE;

FUNCTION fnuGetCONSUMO_10( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_10%TYPE;

FUNCTION fnuGetCONSUMO_11( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_11%TYPE;

FUNCTION fnuGetCONSUMO_12( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_12%TYPE;

FUNCTION fnuGetCONSUMO_13( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_13%TYPE;

FUNCTION fnuGetCONSUMO_14( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_14%TYPE;

FUNCTION fnuGetCONSUMO_15( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_15%TYPE;

FUNCTION fnuGetCONSUMO_16( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_16%TYPE;

FUNCTION fnuGetCONSUMO_17( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_17%TYPE;

FUNCTION fnuGetCONSUMO_18( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_18%TYPE;

FUNCTION fnuGetCONSUMO_19( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_19%TYPE;

FUNCTION fnuGetCONSUMO_20( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_20%TYPE;

FUNCTION fnuGetCONSUMO_21( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_21%TYPE;

FUNCTION fnuGetCONSUMO_22( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_22%TYPE;

FUNCTION fnuGetCONSUMO_23( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_23%TYPE;

FUNCTION fnuGetCONSUMO_24( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_24%TYPE;

FUNCTION fnuGetVALOR_CUOTA( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.VALOR_CUOTA%TYPE;

FUNCTION fdtGetANTI_CUPO_BRILLA( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.ANTI_CUPO_BRILLA%TYPE;

FUNCTION fdtGetANTI_GAS( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.ANTI_GAS%TYPE;

FUNCTION fnuGetMORA_MAXIMA( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.MORA_MAXIMA%TYPE;

FUNCTION fnuGetVALOR_COMPRA( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.VALOR_COMPRA%TYPE;

FUNCTION fsbGetTIPO_COMPRA_1( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_1%TYPE;

FUNCTION fsbGetTIPO_COMPRA_2( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_2%TYPE;

FUNCTION fsbGetTIPO_COMPRA_3( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_3%TYPE;

FUNCTION fsbGetTIPO_COMPRA_4( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_4%TYPE;

FUNCTION fsbGetTIPO_COMPRA_5( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_5%TYPE;

FUNCTION fsbGetTIPO_COMPRA_6( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_6%TYPE;

FUNCTION fsbGetTIPO_COMPRA_7( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_7%TYPE;

FUNCTION fnuGetPAGO_ACOMETIDA( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.PAGO_ACOMETIDA%TYPE;

END DALDC_LDC_SCORHIST;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_LDC_SCORHIST IS

rcData cuRecord%rowtype;

blDAO_USE_CACHE    boolean := null;

PROCEDURE Load
            	(inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE)
            	IS
            		rcRecordNull cuRecord%rowtype;
            	BEGIN
            		if cuRecord%isopen then
            			close cuRecord;
            		end if;
            		open cuRecord
            		(inuSUSCRIPTOR);

            		fetch cuRecord into rcData;
            		if cuRecord%notfound  then
            			close cuRecord;
            			rcData := rcRecordNull;
            			raise no_data_found;
            		end if;
            		close cuRecord;
            	END;

FUNCTION fblExist
            	(inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE)
            	RETURN boolean
            	IS
            	BEGIN
            		Load
            		(inuSUSCRIPTOR);
            		return(TRUE);
            	EXCEPTION
            		when no_data_found then
            			return(FALSE);
            	END;

FUNCTION frcGetRecord
            	(inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE)
            	RETURN styLDC_SCORHIST IS
            	BEGIN
            		Load
            		(inuSUSCRIPTOR);
            		return(rcData);
            	EXCEPTION
            		when no_data_found then
                            RAISE_APPLICATION_ERROR(-20010,'Registro ['||inuSUSCRIPTOR||'] no se ha encontrado en la tabla.');
            	END;

PROCEDURE insRecord
            	(ircLDC_SCORHIST in styLDC_SCORHIST)
            	IS
            	BEGIN
            		insert into LDC_SCORHIST(SUSCRIPTOR,TIPO,CONSUMO_01,CONSUMO_02,CONSUMO_03,CONSUMO_04,CONSUMO_05,CONSUMO_06,CONSUMO_07,CONSUMO_08,CONSUMO_09,CONSUMO_10,CONSUMO_11,CONSUMO_12,CONSUMO_13,CONSUMO_14,CONSUMO_15,CONSUMO_16,CONSUMO_17,CONSUMO_18,CONSUMO_19,CONSUMO_20,CONSUMO_21,CONSUMO_22,CONSUMO_23,CONSUMO_24,VALOR_CUOTA,ANTI_CUPO_BRILLA,ANTI_GAS,MORA_MAXIMA,VALOR_COMPRA,TIPO_COMPRA_1,TIPO_COMPRA_2,TIPO_COMPRA_3,TIPO_COMPRA_4,TIPO_COMPRA_5,TIPO_COMPRA_6,TIPO_COMPRA_7,PAGO_ACOMETIDA)
            		values
            		(ircLDC_SCORHIST.SUSCRIPTOR,ircLDC_SCORHIST.TIPO,ircLDC_SCORHIST.CONSUMO_01,ircLDC_SCORHIST.CONSUMO_02,ircLDC_SCORHIST.CONSUMO_03,ircLDC_SCORHIST.CONSUMO_04,ircLDC_SCORHIST.CONSUMO_05,ircLDC_SCORHIST.CONSUMO_06,ircLDC_SCORHIST.CONSUMO_07,ircLDC_SCORHIST.CONSUMO_08,ircLDC_SCORHIST.CONSUMO_09,ircLDC_SCORHIST.CONSUMO_10,ircLDC_SCORHIST.CONSUMO_11,ircLDC_SCORHIST.CONSUMO_12,ircLDC_SCORHIST.CONSUMO_13,ircLDC_SCORHIST.CONSUMO_14,ircLDC_SCORHIST.CONSUMO_15,ircLDC_SCORHIST.CONSUMO_16,ircLDC_SCORHIST.CONSUMO_17,ircLDC_SCORHIST.CONSUMO_18,ircLDC_SCORHIST.CONSUMO_19,ircLDC_SCORHIST.CONSUMO_20,ircLDC_SCORHIST.CONSUMO_21,ircLDC_SCORHIST.CONSUMO_22,ircLDC_SCORHIST.CONSUMO_23,ircLDC_SCORHIST.CONSUMO_24,ircLDC_SCORHIST.VALOR_CUOTA,ircLDC_SCORHIST.ANTI_CUPO_BRILLA,ircLDC_SCORHIST.ANTI_GAS,ircLDC_SCORHIST.MORA_MAXIMA,ircLDC_SCORHIST.VALOR_COMPRA,ircLDC_SCORHIST.TIPO_COMPRA_1,ircLDC_SCORHIST.TIPO_COMPRA_2,ircLDC_SCORHIST.TIPO_COMPRA_3,ircLDC_SCORHIST.TIPO_COMPRA_4,ircLDC_SCORHIST.TIPO_COMPRA_5,ircLDC_SCORHIST.TIPO_COMPRA_6,ircLDC_SCORHIST.TIPO_COMPRA_7,ircLDC_SCORHIST.PAGO_ACOMETIDA);
            	EXCEPTION
            		when dup_val_on_index then
                            RAISE_APPLICATION_ERROR(-20010,'Registro ['||ircLDC_SCORHIST.SUSCRIPTOR||'] se encuentra duplicado');
            	END;

PROCEDURE insRecords
            	(iotbLDC_SCORHIST in out nocopy tytbLDC_SCORHIST)
            	IS
            	BEGIN
            		forall n in iotbLDC_SCORHIST.first..iotbLDC_SCORHIST.last
            			insert into LDC_SCORHIST(SUSCRIPTOR,TIPO,CONSUMO_01,CONSUMO_02,CONSUMO_03,CONSUMO_04,CONSUMO_05,CONSUMO_06,CONSUMO_07,CONSUMO_08,CONSUMO_09,CONSUMO_10,CONSUMO_11,CONSUMO_12,CONSUMO_13,CONSUMO_14,CONSUMO_15,CONSUMO_16,CONSUMO_17,CONSUMO_18,CONSUMO_19,CONSUMO_20,CONSUMO_21,CONSUMO_22,CONSUMO_23,CONSUMO_24,VALOR_CUOTA,ANTI_CUPO_BRILLA,ANTI_GAS,MORA_MAXIMA,VALOR_COMPRA,TIPO_COMPRA_1,TIPO_COMPRA_2,TIPO_COMPRA_3,TIPO_COMPRA_4,TIPO_COMPRA_5,TIPO_COMPRA_6,TIPO_COMPRA_7,PAGO_ACOMETIDA)
            		values
            		(iotbLDC_SCORHIST(n).SUSCRIPTOR,iotbLDC_SCORHIST(n).TIPO,iotbLDC_SCORHIST(n).CONSUMO_01,iotbLDC_SCORHIST(n).CONSUMO_02,iotbLDC_SCORHIST(n).CONSUMO_03,iotbLDC_SCORHIST(n).CONSUMO_04,iotbLDC_SCORHIST(n).CONSUMO_05,iotbLDC_SCORHIST(n).CONSUMO_06,iotbLDC_SCORHIST(n).CONSUMO_07,iotbLDC_SCORHIST(n).CONSUMO_08,iotbLDC_SCORHIST(n).CONSUMO_09,iotbLDC_SCORHIST(n).CONSUMO_10,iotbLDC_SCORHIST(n).CONSUMO_11,iotbLDC_SCORHIST(n).CONSUMO_12,iotbLDC_SCORHIST(n).CONSUMO_13,iotbLDC_SCORHIST(n).CONSUMO_14,iotbLDC_SCORHIST(n).CONSUMO_15,iotbLDC_SCORHIST(n).CONSUMO_16,iotbLDC_SCORHIST(n).CONSUMO_17,iotbLDC_SCORHIST(n).CONSUMO_18,iotbLDC_SCORHIST(n).CONSUMO_19,iotbLDC_SCORHIST(n).CONSUMO_20,iotbLDC_SCORHIST(n).CONSUMO_21,iotbLDC_SCORHIST(n).CONSUMO_22,iotbLDC_SCORHIST(n).CONSUMO_23,iotbLDC_SCORHIST(n).CONSUMO_24,iotbLDC_SCORHIST(n).VALOR_CUOTA,iotbLDC_SCORHIST(n).ANTI_CUPO_BRILLA,iotbLDC_SCORHIST(n).ANTI_GAS,iotbLDC_SCORHIST(n).MORA_MAXIMA,iotbLDC_SCORHIST(n).VALOR_COMPRA,iotbLDC_SCORHIST(n).TIPO_COMPRA_1,iotbLDC_SCORHIST(n).TIPO_COMPRA_2,iotbLDC_SCORHIST(n).TIPO_COMPRA_3,iotbLDC_SCORHIST(n).TIPO_COMPRA_4,iotbLDC_SCORHIST(n).TIPO_COMPRA_5,iotbLDC_SCORHIST(n).TIPO_COMPRA_6,iotbLDC_SCORHIST(n).TIPO_COMPRA_7,iotbLDC_SCORHIST(n).PAGO_ACOMETIDA	);
            	EXCEPTION
            		when dup_val_on_index then
                        RAISE_APPLICATION_ERROR(-20010,'Registro se encuentra duplicado');
            	END;

PROCEDURE delRecord
            	(inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE)
            	IS
            	BEGIN
            		delete
            		from LDC_SCORHIST where SUSCRIPTOR = inuSUSCRIPTOR; if sql%notfound then
                            raise no_data_found;
                        end if;
            	EXCEPTION
            		when no_data_found then RAISE_APPLICATION_ERROR(-20010,'No existe el registro');
            		when ex.RECORD_HAVE_CHILDREN then
                            RAISE_APPLICATION_ERROR(-20010,'No se puede borrar el registro');
            	END;

PROCEDURE updRecord
            	(ircLDC_SCORHIST in styLDC_SCORHIST)
            	IS
            		nuSUSCRIPTOR LDC_SCORHIST.SUSCRIPTOR%TYPE;BEGIN
            			update LDC_SCORHIST set TIPO = ircLDC_SCORHIST.TIPO,CONSUMO_01 = ircLDC_SCORHIST.CONSUMO_01,CONSUMO_02 = ircLDC_SCORHIST.CONSUMO_02,CONSUMO_03 = ircLDC_SCORHIST.CONSUMO_03,CONSUMO_04 = ircLDC_SCORHIST.CONSUMO_04,CONSUMO_05 = ircLDC_SCORHIST.CONSUMO_05,CONSUMO_06 = ircLDC_SCORHIST.CONSUMO_06,CONSUMO_07 = ircLDC_SCORHIST.CONSUMO_07,CONSUMO_08 = ircLDC_SCORHIST.CONSUMO_08,CONSUMO_09 = ircLDC_SCORHIST.CONSUMO_09,CONSUMO_10 = ircLDC_SCORHIST.CONSUMO_10,CONSUMO_11 = ircLDC_SCORHIST.CONSUMO_11,CONSUMO_12 = ircLDC_SCORHIST.CONSUMO_12,CONSUMO_13 = ircLDC_SCORHIST.CONSUMO_13,CONSUMO_14 = ircLDC_SCORHIST.CONSUMO_14,CONSUMO_15 = ircLDC_SCORHIST.CONSUMO_15,CONSUMO_16 = ircLDC_SCORHIST.CONSUMO_16,CONSUMO_17 = ircLDC_SCORHIST.CONSUMO_17,CONSUMO_18 = ircLDC_SCORHIST.CONSUMO_18,CONSUMO_19 = ircLDC_SCORHIST.CONSUMO_19,CONSUMO_20 = ircLDC_SCORHIST.CONSUMO_20,CONSUMO_21 = ircLDC_SCORHIST.CONSUMO_21,CONSUMO_22 = ircLDC_SCORHIST.CONSUMO_22,CONSUMO_23 = ircLDC_SCORHIST.CONSUMO_23,CONSUMO_24 = ircLDC_SCORHIST.CONSUMO_24,VALOR_CUOTA = ircLDC_SCORHIST.VALOR_CUOTA,ANTI_CUPO_BRILLA = ircLDC_SCORHIST.ANTI_CUPO_BRILLA,ANTI_GAS = ircLDC_SCORHIST.ANTI_GAS,MORA_MAXIMA = ircLDC_SCORHIST.MORA_MAXIMA,VALOR_COMPRA = ircLDC_SCORHIST.VALOR_COMPRA,TIPO_COMPRA_1 = ircLDC_SCORHIST.TIPO_COMPRA_1,TIPO_COMPRA_2 = ircLDC_SCORHIST.TIPO_COMPRA_2,TIPO_COMPRA_3 = ircLDC_SCORHIST.TIPO_COMPRA_3,TIPO_COMPRA_4 = ircLDC_SCORHIST.TIPO_COMPRA_4,TIPO_COMPRA_5 = ircLDC_SCORHIST.TIPO_COMPRA_5,TIPO_COMPRA_6 = ircLDC_SCORHIST.TIPO_COMPRA_6,TIPO_COMPRA_7 = ircLDC_SCORHIST.TIPO_COMPRA_7,PAGO_ACOMETIDA = ircLDC_SCORHIST.PAGO_ACOMETIDA where SUSCRIPTOR = ircLDC_SCORHIST.SUSCRIPTOR returning SUSCRIPTOR into nuSUSCRIPTOR;
                    if nuSUSCRIPTOR is NULL then
            			raise no_data_found;
            		end if;

            	EXCEPTION
            		when no_data_found then
                        RAISE_APPLICATION_ERROR(-20010,'No existe el registro');
            	END;

FUNCTION fblAlreadyLoaded
            	( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE)
            	RETURN boolean
            	IS
            	BEGIN
            		if (inuSUSCRIPTOR = rcData.SUSCRIPTOR ) then
            			return ( true );
            		end if;
            		return (false);
            	END;

PROCEDURE GetDAO_USE_CACHE
            	IS
            	BEGIN
            	    if ( blDAO_USE_CACHE is null ) then
            	        blDAO_USE_CACHE :=  TRUE;
            	    end if;
            	END;

FUNCTION fnuGetSUSCRIPTOR( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.SUSCRIPTOR%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.SUSCRIPTOR);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.SUSCRIPTOR);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fsbGetTIPO( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.TIPO);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.TIPO);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_01( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_01%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_01);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_01);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_02( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_02%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_02);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_02);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_03( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_03%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_03);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_03);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_04( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_04%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_04);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_04);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_05( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_05%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_05);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_05);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_06( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_06%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_06);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_06);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_07( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_07%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_07);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_07);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_08( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_08%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_08);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_08);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_09( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_09%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_09);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_09);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_10( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_10%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_10);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_10);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_11( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_11%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_11);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_11);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_12( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_12%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_12);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_12);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_13( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_13%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_13);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_13);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_14( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_14%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_14);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_14);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_15( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_15%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_15);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_15);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_16( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_16%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_16);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_16);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_17( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_17%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_17);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_17);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_18( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_18%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_18);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_18);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_19( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_19%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_19);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_19);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_20( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_20%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_20);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_20);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_21( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_21%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_21);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_21);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_22( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_22%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_22);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_22);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_23( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_23%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_23);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_23);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetCONSUMO_24( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.CONSUMO_24%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.CONSUMO_24);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.CONSUMO_24);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetVALOR_CUOTA( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.VALOR_CUOTA%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.VALOR_CUOTA);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.VALOR_CUOTA);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fdtGetANTI_CUPO_BRILLA( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.ANTI_CUPO_BRILLA%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.ANTI_CUPO_BRILLA);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.ANTI_CUPO_BRILLA);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fdtGetANTI_GAS( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.ANTI_GAS%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.ANTI_GAS);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.ANTI_GAS);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetMORA_MAXIMA( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.MORA_MAXIMA%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.MORA_MAXIMA);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.MORA_MAXIMA);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetVALOR_COMPRA( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.VALOR_COMPRA%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.VALOR_COMPRA);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.VALOR_COMPRA);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fsbGetTIPO_COMPRA_1( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_1%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.TIPO_COMPRA_1);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.TIPO_COMPRA_1);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fsbGetTIPO_COMPRA_2( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_2%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.TIPO_COMPRA_2);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.TIPO_COMPRA_2);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fsbGetTIPO_COMPRA_3( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_3%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.TIPO_COMPRA_3);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.TIPO_COMPRA_3);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fsbGetTIPO_COMPRA_4( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_4%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.TIPO_COMPRA_4);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.TIPO_COMPRA_4);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fsbGetTIPO_COMPRA_5( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_5%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.TIPO_COMPRA_5);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.TIPO_COMPRA_5);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fsbGetTIPO_COMPRA_6( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_6%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.TIPO_COMPRA_6);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.TIPO_COMPRA_6);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fsbGetTIPO_COMPRA_7( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.TIPO_COMPRA_7%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.TIPO_COMPRA_7);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.TIPO_COMPRA_7);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fnuGetPAGO_ACOMETIDA( inuSUSCRIPTOR in LDC_SCORHIST.SUSCRIPTOR%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_SCORHIST.PAGO_ACOMETIDA%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuSUSCRIPTOR)
                		then
                			 return(rcData.PAGO_ACOMETIDA);
                		end if;
                		Load
                		(
                			inuSUSCRIPTOR);
                		return(rcData.PAGO_ACOMETIDA);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

 begin
                GetDAO_USE_CACHE;

END DALDC_LDC_SCORHIST;
/
PROMPT Otorgando permisos de ejecucion a DALDC_LDC_SCORHIST
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_LDC_SCORHIST', 'ADM_PERSON');
END;
/