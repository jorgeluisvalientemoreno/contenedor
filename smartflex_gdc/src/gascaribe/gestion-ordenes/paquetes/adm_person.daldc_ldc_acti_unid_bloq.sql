CREATE OR REPLACE PACKAGE adm_person.DALDC_LDC_ACTI_UNID_BLOQ IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     :  DALDC_LDC_ACTI_UNID_BLOQ
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
              (inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE)
              IS  SELECT *
            		  FROM LDC_ACTI_UNID_BLOQ WHERE ACTIVITY_ID = inuACTIVITY_ID;

    /* Subtipos */
	           subtype styLDC_ACTI_UNID_BLOQ  is  cuRecord%rowtype;

   /*Tipos*/
	           type tytbLDC_ACTI_UNID_BLOQ is table of styLDC_ACTI_UNID_BLOQ index by binary_integer;

 FUNCTION fblExist
                	(inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE)
                	RETURN boolean;

   FUNCTION frcGetRecord
            	(inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE)
            	RETURN styLDC_ACTI_UNID_BLOQ;

   PROCEDURE insRecord
            	(ircLDC_ACTI_UNID_BLOQ in styLDC_ACTI_UNID_BLOQ);

   PROCEDURE insRecords
            	(iotbLDC_ACTI_UNID_BLOQ in out nocopy tytbLDC_ACTI_UNID_BLOQ);

PROCEDURE delRecord
            	(inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE);

PROCEDURE updRecord
            	(ircLDC_ACTI_UNID_BLOQ in styLDC_ACTI_UNID_BLOQ);

FUNCTION fnuGetACTIVITY_ID( inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE;

FUNCTION fdtGetCREATION_DATE( inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_ACTI_UNID_BLOQ.CREATION_DATE%TYPE;

END DALDC_LDC_ACTI_UNID_BLOQ;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_LDC_ACTI_UNID_BLOQ IS

rcData cuRecord%rowtype;

blDAO_USE_CACHE    boolean := null;

PROCEDURE Load
            	(inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE)
            	IS
            		rcRecordNull cuRecord%rowtype;
            	BEGIN
            		if cuRecord%isopen then
            			close cuRecord;
            		end if;
            		open cuRecord
            		(inuACTIVITY_ID);

            		fetch cuRecord into rcData;
            		if cuRecord%notfound  then
            			close cuRecord;
            			rcData := rcRecordNull;
            			raise no_data_found;
            		end if;
            		close cuRecord;
            	END;

FUNCTION fblExist
            	(inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE)
            	RETURN boolean
            	IS
            	BEGIN
            		Load
            		(inuACTIVITY_ID);
            		return(TRUE);
            	EXCEPTION
            		when no_data_found then
            			return(FALSE);
            	END;

FUNCTION frcGetRecord
            	(inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE)
            	RETURN styLDC_ACTI_UNID_BLOQ IS
            	BEGIN
            		Load
            		(inuACTIVITY_ID);
            		return(rcData);
            	EXCEPTION
            		when no_data_found then
                            RAISE_APPLICATION_ERROR(-20010,'Registro ['||inuACTIVITY_ID||'] no se ha encontrado en la tabla.');
            	END;

PROCEDURE insRecord
            	(ircLDC_ACTI_UNID_BLOQ in styLDC_ACTI_UNID_BLOQ)
            	IS
            	BEGIN
            		insert into LDC_ACTI_UNID_BLOQ(ACTIVITY_ID,CREATION_DATE)
            		values
            		(ircLDC_ACTI_UNID_BLOQ.ACTIVITY_ID,ircLDC_ACTI_UNID_BLOQ.CREATION_DATE);
            	EXCEPTION
            		when dup_val_on_index then
                            RAISE_APPLICATION_ERROR(-20010,'Registro ['||ircLDC_ACTI_UNID_BLOQ.ACTIVITY_ID||'] se encuentra duplicado');
            	END;

PROCEDURE insRecords
            	(iotbLDC_ACTI_UNID_BLOQ in out nocopy tytbLDC_ACTI_UNID_BLOQ)
            	IS
            	BEGIN
            		forall n in iotbLDC_ACTI_UNID_BLOQ.first..iotbLDC_ACTI_UNID_BLOQ.last
            			insert into LDC_ACTI_UNID_BLOQ(ACTIVITY_ID,CREATION_DATE)
            		values
            		(iotbLDC_ACTI_UNID_BLOQ(n).ACTIVITY_ID,iotbLDC_ACTI_UNID_BLOQ(n).CREATION_DATE	);
            	EXCEPTION
            		when dup_val_on_index then
                        RAISE_APPLICATION_ERROR(-20010,'Registro se encuentra duplicado');
            	END;

PROCEDURE delRecord
            	(inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE)
            	IS
            	BEGIN
            		delete
            		from LDC_ACTI_UNID_BLOQ where ACTIVITY_ID = inuACTIVITY_ID; if sql%notfound then
                            raise no_data_found;
                        end if;
            	EXCEPTION
            		when no_data_found then RAISE_APPLICATION_ERROR(-20010,'No existe el registro');
            		when ex.RECORD_HAVE_CHILDREN then
                            RAISE_APPLICATION_ERROR(-20010,'No se puede borrar el registro');
            	END;

PROCEDURE updRecord
            	(ircLDC_ACTI_UNID_BLOQ in styLDC_ACTI_UNID_BLOQ)
            	IS
            		nuACTIVITY_ID LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE;BEGIN
            			update LDC_ACTI_UNID_BLOQ set CREATION_DATE = ircLDC_ACTI_UNID_BLOQ.CREATION_DATE where ACTIVITY_ID = ircLDC_ACTI_UNID_BLOQ.ACTIVITY_ID returning ACTIVITY_ID into nuACTIVITY_ID;
                    if nuACTIVITY_ID is NULL then
            			raise no_data_found;
            		end if;

            	EXCEPTION
            		when no_data_found then
                        RAISE_APPLICATION_ERROR(-20010,'No existe el registro');
            	END;

FUNCTION fblAlreadyLoaded
            	( inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE)
            	RETURN boolean
            	IS
            	BEGIN
            		if (inuACTIVITY_ID = rcData.ACTIVITY_ID ) then
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

FUNCTION fnuGetACTIVITY_ID( inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuACTIVITY_ID)
                		then
                			 return(rcData.ACTIVITY_ID);
                		end if;
                		Load
                		(
                			inuACTIVITY_ID);
                		return(rcData.ACTIVITY_ID);
                	EXCEPTION
                		when no_data_found then
                			if inuRaiseError = 1 then
                                RAISE_APPLICATION_ERROR(-20010,'No se encontraron datos');
                			else
                				return null;
                			end if;
                	END;

FUNCTION fdtGetCREATION_DATE( inuACTIVITY_ID in LDC_ACTI_UNID_BLOQ.ACTIVITY_ID%TYPE,  inuRaiseError in number default 1
                	) RETURN LDC_ACTI_UNID_BLOQ.CREATION_DATE%TYPE
                		IS
                	BEGIN
                		-- si usa cache y esta cargado retorna
                		if  blDAO_USE_CACHE AND fblAlreadyLoaded
                			 (
                				inuACTIVITY_ID)
                		then
                			 return(rcData.CREATION_DATE);
                		end if;
                		Load
                		(
                			inuACTIVITY_ID);
                		return(rcData.CREATION_DATE);
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

END DALDC_LDC_ACTI_UNID_BLOQ;
/
PROMPT Otorgando permisos de ejecucion a DALDC_LDC_ACTI_UNID_BLOQ
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_LDC_ACTI_UNID_BLOQ', 'ADM_PERSON');
END;
/