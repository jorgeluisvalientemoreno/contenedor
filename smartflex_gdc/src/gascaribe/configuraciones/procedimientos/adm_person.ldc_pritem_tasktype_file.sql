create or replace PROCEDURE ADM_PERSON.LDC_PRITEM_TASKTYPE_FILE  IS
/*******************************************************************
 PROGRAMA      :  LDC_PRITEM_TASKTYPE_FILE
 FECHA        :  22/04/2015
 AUTOR        :  Sergio Gomez - Arquitecsoft
 DESCRIPCION  :  lee un archivo plano y relaciona los tipos de trabajo con los items que se
                 encunetran en el archivo.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  21/10/2019	  dsaltarin			  GLPI-212: Se modifica para validar si se trata de una actividad principal
                                      y ya esta asociada a otro tipo de trabajo no permita asociarlo a otro.
  19/03/2023      Adrianavg           OSF-2389: Se aplican pautas técnicas y se reemplazan servicios homólogos
                                      Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                      Se declaran variables de gestion de trazas
                                      Se retira código comentado
                                      Se retira esquema OPEN antepuesto a LDC_VERSIONENTREGA, or_task_types_items, dage_items
                                      Se retira IF-ENDIF del fblaplicaentregaxcaso(sbEntrega212), pero se deja la logica interna, ya que la entrega 0000212 se encuentra
                                      activa en producción, se retira la variable sbEntrega212.
                                      Se reemplaza ERRORS.seterror por pkg_error.seterror
                                      Se reemplaza ex.controlled_error por pkg_error.controlled_error
                                      Se reemplaza pkUtlFileMgr.Fopen por pkg_gestionarchivos.ftabrirarchivo_smf
                                      Se reemplaza pkUtlFileMgr.Put_Line por pkg_gestionarchivos.prcescribirlinea_smf
                                      Se reemplaza pkUtlFileMgr.get_line por pkg_gestionarchivos.fsbobtenerlinea_smfSe reemplaza asignación de pkg_gestionarchivos.fsbobtenerlinea_smf() de nuCodigo por sbonline
                                      Se reemplaza SELECT-INTO por cuDirectorio, cuExisteTipoTrabajo, cuExisteItem, cuItem_TipoTrabajo
                                      Se añade BEGIN-END al llamado de pkg_gestionarchivos.fsbobtenerlinea_smf() para manejar
                                      la exception de fin de archivo y asignar valor a nuCodigo
                                      Se retira el ELSE que evalua la variable sbEntrega212, ya que esta se encuentra activa(S) en producción
                                      Se reemplaza utl_file.fclose por pkg_gestionarchivos.prccerrararchivo_smf
                                      Se ajusta bloque de excepciones según pautas técnicas
  29/04/2024      Adrianavg           OSF-2389: Se migra del esquema OPEN al esquema ADM_PERSON									  
 *******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
	csbInicio   	    CONSTANT VARCHAR2(35) 	    := pkg_traza.csbINICIO;  
    Onuerrorcode        NUMBER                      := pkg_error.CNUGENERIC_MESSAGE; 
    Osberrormessage     VARCHAR2(2000);
    
    cnuNULL_ATTRIBUTE   CONSTANT NUMBER := 2126; 
    
    -- Directorio donde esta el archivo
    sbDIRECTORY_ID      ge_boInstanceControl.stysbValue;
    
    --Ruta donde esta el archivo
    sbPATH              VARCHAR2(250);
    
    -- Nombre del archivo
    sbFILE_NAME         ge_boInstanceControl.stysbValue;
    
    -- sbFileToprocess archivo que se procesara
    sbFileToprocess     pkg_gestionarchivos.styarchivo;
    sbFileToprocessLog  pkg_gestionarchivos.styarchivo;
    
    -- cnuend_of_file ultima linea del archivo
    cnuend_of_file      CONSTANT NUMBER := 1;
    
    -- nuCodigo linea que se encuentra procesando
    nuCodigo            NUMBER;
    --
    -- nuLinea: Variables para mensaje de error
    nuLinea             NUMBER:=0;
    
    nuCampos            NUMBER:=0;
    
    -- sbOnline: guarda todo un registros del archivo
    sbOnline            VARCHAR2(2000);
    -- sbOnline: guarda todo un registros del archivo
    sbOnlineLog         VARCHAR2(500);
    
    --sbTemp variable utilizada para obtener los valores de cada registro
    sbTemp              VARCHAR2(2000);
    
    -- Variables que reciben los campos del archivo
    nuTaskType          or_task_types_items.task_type_id%TYPE;--tipo de trabajuo
    nuItem              or_task_types_items.items_id%TYPE;--Item
    nuCantidad          or_task_types_items.item_amount%TYPE;--Cantidad
    sbLegalizeVisi      or_task_types_items.is_legalize_visible%TYPE;--Es visible Y or N
    blContinuar         BOOLEAN;
    
    nuDisplayOrder      NUMBER(10);
    
    nuExisTipoTraItem   NUMBER (2):=0;
    --nuExisTipoTra variable para validar que el tipo de trabajo exista
    nuExisTipoTra       NUMBER (2):=0;
    --nuExisItem variable para validar que el item exista
    nuExisItem          NUMBER (2):=0;
    
    --0000212 
    sbExisAsociacion	VARCHAR2(4000);
    sbAplica212			VARCHAR2(1);
    
    cursor cuTaskTypesItems(nuCodTitr NUMBER,
                            nuCodItem NUMBER) 
    is
    select ti.task_type_id
      from or_task_types_items ti
     where ti.task_type_id!= nuCodTitr
       and ti.items_id=nuCodItem;

    CURSOR cuDirectorio (p_sbdirectory_id ge_directory.directory_id%TYPE)
    IS
    SELECT PATH 
      FROM ge_directory
     WHERE directory_id= p_sbdirectory_id;
    
    CURSOR cuExisteTipoTrabajo( p_nutasktype or_task_type.task_type_id%TYPE)
    IS
    SELECT COUNT(1) 
      FROM or_task_type
     WHERE task_type_id = p_nutasktype;
     
    CURSOR cuExisteItem( p_nuitem ge_items.items_id%TYPE)
    IS
    SELECT COUNT(1)
      FROM ge_items
     WHERE items_id= p_nuitem;
     
    CURSOR cuItem_TipoTrabajo( p_nutasktype or_task_type.task_type_id%TYPE,
                               p_nuitem ge_items.items_id%TYPE)
    IS
    SELECT COUNT(1) 
      FROM or_task_types_items
     WHERE task_type_id = p_nutasktype
       AND items_id = p_nuitem;    
    
BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);  
    
    --se toman los valores de la instancia
    sbDIRECTORY_ID := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'DIRECTORY_ID');
    pkg_traza.trace(csbMetodo ||' Diretorio: '||sbDIRECTORY_ID , csbNivelTraza);
    
    sbPATH :='';
    sbFILE_NAME := ge_boInstanceControl.fsbGetFieldValue ('GE_BATCH_PROCESS', 'FILE_NAME');
    pkg_traza.trace(csbMetodo ||' Nombre de Archivo: '||sbFILE_NAME , csbNivelTraza);
    
    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------
    
    IF (sbdirectory_id IS NULL) THEN
        PKG_ERROR.SETERROR;
        pkg_traza.trace(csbMetodo ||' Seleccionar Directorio ' , csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RAISE PKG_ERROR.controlled_error; 
    END IF;
    
    IF (sbfile_name IS NULL) THEN
        PKG_ERROR.SETERROR;
        pkg_traza.trace(csbMetodo ||' Ingresar el nombre del Archivo ' , csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RAISE PKG_ERROR.controlled_error;  
    END IF;
    
    --Con el directorio se encuentra donde esta la ruta
    OPEN cuDirectorio(sbDIRECTORY_ID);
    FETCH cuDirectorio INTO sbPATH;
    CLOSE cuDirectorio;
    pkg_traza.trace(csbMetodo ||' cuDirectorio--> sbPATH: '||sbPATH , csbNivelTraza);
    
    sbAplica212:='S';
    pkg_traza.trace(csbMetodo ||' sbAplica212: '||sbAplica212 , csbNivelTraza);    

	BEGIN
		-- Se crea el archivo de log          
		sbFileToprocessLog:= pkg_gestionarchivos.ftabrirarchivo_smf(sbPATH,               -- Ruta del log
                                                                    sbFILE_NAME||'.LOG',  -- Nombre del log
                                                                    'w');                 -- Modo [Escritura]
        pkg_traza.trace(csbMetodo ||' Se crea el archivo de log: ' ||sbFILE_NAME||'.LOG en '||sbPATH, csbNivelTraza);
        
		--PRIMERA LINEA DEL LOG DE ERRORES
		sbOnlineLog         := 'INICIO PROCESO DE RELACION TIPOS DE TRABAJO - ITEMS' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS');

		--Se escribe en el archivo del log de errores la linea
		pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);
        pkg_traza.trace(csbMetodo ||' Se escribe en el archivo del log de errores la linea: ' ||sbOnlineLog, csbNivelTraza); 

		-- la variable sbFileToprocess se carga con la informacion del archivo   
        sbFileToprocess:= pkg_gestionarchivos.ftabrirarchivo_smf(sbPATH,                -- Ruta del Archivo
                                                                 sbFILE_NAME||'.txt',   -- Nombre del Archivo
                                                                 'r' );                 -- Modo [Read=Lectura]
        pkg_traza.trace(csbMetodo ||' Se crea el archivo txt: ' ||sbFILE_NAME||' en '||sbPATH, csbNivelTraza);                                      
	EXCEPTION
        WHEN OTHERS THEN
            sbonlinelog         := ('No hay lectura del Archivo');
            pkg_traza.trace(csbMetodo || ' No hay lectura del Archivo' , csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' Se escribe en el archivo del log de errores la linea: ' ||sbonlinelog, csbNivelTraza);
            pkg_gestionarchivos.prcescribirlinea_smf(sbfiletoprocesslog, sbonlinelog);   
        COMMIT;

	END;

	--este ciclo recorre cada registros del archivo
	LOOP
		--nuCodigo: esta variable es igual a 1 cuando ya no hay registros para procesar
        BEGIN
          sbOnline := pkg_gestionarchivos.fsbobtenerlinea_smf(sbFileToprocess);
          pkg_traza.trace(csbMetodo ||' Se obtiene linea: ' || sbOnline, csbNivelTraza);
          nucodigo:=0;
        EXCEPTION WHEN NO_DATA_FOUND THEN
          nucodigo:=1;
        END;
        pkg_traza.trace(csbMetodo ||' nucodigo: ' || nucodigo, csbNivelTraza);	 
		nuLinea         := nuLinea + 1;--variable que sigue la cantidad de lineas procesadas
		blContinuar     := FALSE;--variable de control de errores
		EXIT WHEN(nuCodigo = cnuend_of_file);

		--se inicializan valores
		sbTemp:='';
		nuCampos:=0;
		
        --Este ciclo recorre dentro de la linea cada campo
		LOOP

			EXIT WHEN( instr(sbOnline, ',', 1, 1)=0    );
				-- tipo de trabajo
				sbTemp := substr(sbOnline,1,instr(sbOnline, ',', 1, 1) - 1);
                pkg_traza.trace(csbMetodo ||' sbTemp: ' || sbTemp, csbNivelTraza);
                
				sbOnline:=substr(sbOnline,instr(sbOnline, ',', 1, 1) + 1);
                pkg_traza.trace(csbMetodo ||' sbOnline: ' || sbOnline, csbNivelTraza);
                
				nuCampos:=nuCampos+1;

			IF (nuCampos = 1) then
			--Se valida que el tipo de trabajo contenga solo numeros
                pkg_traza.trace(csbMetodo ||' Inicia validación tipo de trabajo sea numérico' , csbNivelTraza);
				BEGIN
					nuTaskType:= sbTemp;
                    pkg_traza.trace(csbMetodo ||' Tipo trabajo: ' || nuTaskType, csbNivelTraza);
				EXCEPTION
					WHEN OTHERS THEN
						sbOnlineLog := ('Error en la linea '||nuLinea||' el tipo de trabajo solo recibe numeros '||sbTemp);
                        pkg_traza.trace(csbMetodo ||' Error validando tipo de trabajo: ' || sbOnlineLog, csbNivelTraza);
						pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);
						blContinuar := TRUE;
						EXIT;
				END;
                pkg_traza.trace(csbMetodo ||' Fin validación tipo de trabajo sea numérico' , csbNivelTraza);
			END IF;


			IF (nucampos = 2) THEN
				--Se valida que el item contenga solo numeros
				pkg_traza.trace(csbMetodo ||' Inicia validación item sea numérico' , csbNivelTraza);
                BEGIN
					nuitem:=sbtemp;
                    pkg_traza.trace(csbMetodo ||' Item: ' || nuitem, csbNivelTraza);
				EXCEPTION
					WHEN OTHERS THEN
						sbonlinelog := ('Error en la linea '||nulinea||' el item solo recibe numeros '||sbtemp);
						pkg_traza.trace(csbMetodo ||' Error validando Item: ' || sbOnlineLog, csbNivelTraza);
                        pkg_gestionarchivos.prcescribirlinea_smf(sbfiletoprocesslog, sbonlinelog);
						blcontinuar := TRUE;
						EXIT;
				END;
                pkg_traza.trace(csbMetodo ||' Fin validación item sea numérico' , csbNivelTraza);
			END IF;
            
			IF (nuCampos = 3) THEN
				--Se valida que la cantidad contenga solo numeros
				pkg_traza.trace(csbMetodo ||' Inicia validación cantidad sea numérico' , csbNivelTraza);
                BEGIN
					nuCantidad:=sbTemp;
                    pkg_traza.TRACE(csbMetodo ||' Cantidad: ' || nuCantidad, csbNivelTraza);
				EXCEPTION
					WHEN OTHERS THEN
						sbOnlineLog := ('Error en la linea '||nuLinea||' la cantidad solo recibe numeros '||sbTemp);
                        pkg_traza.TRACE(csbMetodo ||' Error validando Cantidad: ' || sbOnlineLog, csbNivelTraza);
						pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);
						blContinuar := TRUE;
						EXIT;
				END;
                pkg_traza.trace(csbMetodo ||' Fin validación cantidad sea numérico' , csbNivelTraza);
			END IF;
            
			IF (nucampos = 4) THEN
				pkg_traza.trace(csbMetodo ||' Inicia validación visible en legalización sea "Y" o "N"' , csbNivelTraza);
                IF (sbtemp='Y' OR sbtemp='N')THEN
					sblegalizevisi:=sbtemp;
                    pkg_traza.TRACE(csbMetodo ||' visible en legalización: ' || sblegalizevisi, csbNivelTraza);
				ELSE
					sbonlinelog := ('Error en la linea '||nulinea||' solo se recibe valores "Y" y "N" para el cuarto campo de la linea '||nulinea);
					pkg_traza.TRACE(csbMetodo ||' Error validando Legalizacion: ' || sbOnlineLog, csbNivelTraza);
                    pkg_gestionarchivos.prcescribirlinea_smf(sbfiletoprocesslog, sbonlinelog);
					blcontinuar := TRUE;
					EXIT;
				END IF;
                pkg_traza.trace(csbMetodo ||' Fin validación visible en legalización sea "Y" o "N"' , csbNivelTraza);
			END IF;
    
		END LOOP;

		IF blContinuar THEN
			CONTINUE;
		END IF;

		--Se valida que el despliegue de Orden sea numerico
		pkg_traza.trace(csbMetodo ||' Inicio validación Despliegue de Orden sea numérico' , csbNivelTraza);
        BEGIN
			--nuDisplayOrder es el ultimo campo de la linea y se debe de tratar de esta manera para
			--borrar el caracter de control y de esa forma ya convertirlo en numero
			nuDisplayOrder := TO_NUMBER (REGEXP_REPLACE(Trim(REPLACE(sbOnline,'|','')), '[[:cntrl:]]',''));
            pkg_traza.TRACE(csbMetodo ||' Despliegue de Orden: ' || nuDisplayOrder, csbNivelTraza);
		EXCEPTION
			when others then
				sbOnlineLog := ('Error en la linea '||nuLinea||' El campo despliegue de orden '||sbOnline||' solo acepta numeros');
				pkg_traza.TRACE(csbMetodo ||' Error validando despliegue de Orden: ' || sbOnlineLog, csbNivelTraza);
                pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);
				CONTINUE;
		END; 
        pkg_traza.trace(csbMetodo ||' Fin validación Despliegue de Orden sea numérico' , csbNivelTraza);


		-----------------------------SE VALIDA QUE EL TIPO DE TRABAJO EXISTA-----------------------------
		pkg_traza.trace(csbMetodo ||' Inicia validación existencia del tipo de trabajo ' , csbNivelTraza);
        OPEN cuExisteTipoTrabajo(nuTaskType);
        FETCH cuExisteTipoTrabajo INTO  nuExisTipoTra;
        CLOSE cuExisteTipoTrabajo; 
        pkg_traza.trace(csbMetodo ||' Existe Tipo Trabajo(>0): '||nuExisTipoTra , csbNivelTraza);
        
		IF (nuexistipotra=0) THEN
			sbonlinelog := ('Error en la linea '||nulinea||' El tipo de trabajo '||nutasktype||'  no existe');
			pkg_traza.TRACE(csbMetodo ||' Error en la linea '||nulinea||', el tipo de trabajo '||nutasktype||'  no existe', csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' Fin validación del tipo de trabajo ' , csbNivelTraza);
            pkg_gestionarchivos.prcescribirlinea_smf(sbfiletoprocesslog, sbonlinelog);            
			CONTINUE;
		END IF;
        pkg_traza.trace(csbMetodo ||' Fin validación existencia del tipo de trabajo ' , csbNivelTraza);
		
        -----------------------------SE VALIDA QUE EL ITEM EXISTA-----------------------------
		pkg_traza.trace(csbMetodo ||' Inicia validación existencia del ITEM ' , csbNivelTraza);
        OPEN cuExisteItem(nuItem);
        FETCH cuExisteItem INTO  nuExisItem;
        CLOSE cuExisteItem; 
        pkg_traza.trace(csbMetodo ||' Existe Item(>0): '||nuExisTipoTra , csbNivelTraza); 

		IF (nuexisitem=0) THEN 
			sbonlinelog := ('Error en la linea '||nulinea||' El item '||nuitem||' no existe');
			pkg_traza.TRACE(csbMetodo ||' Error en la linea '||nulinea||', el item '||nuitem||' no existe', csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' Fin validación del Item ' , csbNivelTraza);
            pkg_gestionarchivos.prcescribirlinea_smf(sbfiletoprocesslog, sbonlinelog);
			CONTINUE;
		END IF;
        pkg_traza.trace(csbMetodo ||' Fin validación existencia del ITEM ' , csbNivelTraza);
		-----------------------------------------------------------------------------------------

		-- se consulta si ya existe un registro en la tabla
		-- or_task_types_items con un tipo de trabajo y un items especifico.
        pkg_traza.trace(csbMetodo ||' Inicia validación existencia del ITEM relacionado al Tipo Trabajo' , csbNivelTraza);
		OPEN cuItem_TipoTrabajo(nuTaskType, nuItem );
        FETCH cuItem_TipoTrabajo INTO nuExisTipoTraItem;
        CLOSE cuItem_TipoTrabajo;
        pkg_traza.trace(csbMetodo ||' Existe Item-TipoTrabajo(>0): '||nuExisTipoTraItem , csbNivelTraza); 

		--si el registro no existe se inserta en la tabla or_task_types_items
		--deben existir el tipo de trabajo y el item en las tablas correspondientes
		IF (nuexistipotraitem=0 AND nuexistipotra>0 AND nuexisitem>0 ) THEN 
            pkg_traza.trace(csbMetodo ||' El registro Item-TipoTrabajo no existe, se procede a insertar en la tabla OR_TASK_TYPES_ITEMS' , csbNivelTraza); 
			IF sbaplica212='S' THEN
				sbexisasociacion:=NULL;
                
				IF dage_items.fnugetitem_classif_id(nuitem, NULL) =  2 THEN
					FOR reg IN cutasktypesitems(nutasktype, nuitem) LOOP
						IF sbexisasociacion IS NULL THEN
							sbexisasociacion := TO_CHAR(reg.task_type_id);
						ELSE
							sbexisasociacion := sbexisasociacion||','||to_char(reg.task_type_id);
						END IF;
					END LOOP;
				END IF;
                pkg_traza.trace(csbMetodo ||' sbexisasociacion: '||sbexisasociacion , csbNivelTraza); 
                
				IF sbexisasociacion IS NULL THEN
					INSERT INTO or_task_types_items
					(task_type_id, items_id,item_amount,is_legalize_visible,display_order,company_key)
					VALUES(nutasktype,nuitem,nucantidad,sblegalizevisi,nudisplayorder,99);
					pkg_traza.trace(csbMetodo ||' INSERT INTO or_task_types_items, task_type_id - items_id: '||nutasktype||' - '||nuitem , csbNivelTraza);
                    COMMIT;
				ELSE
					sbonlinelog := ('Error en la linea '||nulinea||' el item '||nuitem|| ' se encuentra asociado a los tipos de trabajo '||sbexisasociacion);
					pkg_traza.trace(csbMetodo ||' Error en la linea '||nulinea||' el item '||nuitem|| ' se encuentra asociado a los tipos de trabajo '||sbexisasociacion, csbNivelTraza);
                    pkg_traza.trace(csbMetodo ||' Fin validación existencia del ITEM relacionado al Tipo Trabajo' , csbNivelTraza);
                    pkg_gestionarchivos.prcescribirlinea_smf(sbfiletoprocesslog, sbonlinelog);
					CONTINUE;
				END IF;
			END IF;
		ELSE

			sbonlinelog := ('Error en la linea '||nulinea||' ya existe una relacion tipo de trabajo '||nutasktype||' con el item '||nuitem);
			pkg_traza.TRACE(csbMetodo ||' Error en la linea '||nulinea||' ya existe una relacion tipo de trabajo '||nutasktype||' con el item '||nuitem, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' Fin validación existencia del ITEM relacionado al Tipo Trabajo' , csbNivelTraza);
            pkg_gestionarchivos.prcescribirlinea_smf(sbfiletoprocesslog, sbonlinelog);
			CONTINUE;
		END IF;

		--Se inicializan valores para procesar un nuevo registro
		nuExisTipoTraItem:=0;
		nuExisTipoTra:=0;
		nuExisItem:=0;
		COMMIT;
        
	END LOOP; 

	pkg_gestionarchivos.prccerrararchivo_smf(sbFileToprocess, sbPATH, sbFILE_NAME||'.txt');
	pkg_gestionarchivos.prccerrararchivo_smf(sbFileToprocessLog, sbPATH, sbFILE_NAME||'.LOG');
	COMMIT;
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
EXCEPTION
	WHEN pkg_Error.controlled_error THEN
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error; 
	WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;
END LDC_PRITEM_TASKTYPE_FILE;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRITEM_TASKTYPE_FILE', 'ADM_PERSON');
END;
/