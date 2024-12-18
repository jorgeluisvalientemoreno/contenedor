create or replace PROCEDURE adm_person.ldc_pr_cantlegaitems
IS

  /**************************************************************************
  UNIDAD      :  LDC_PR_CANTLEGAITEMS
  Descripcion :  Procedimiento  para actualizar o agregar cantidad maxima y
                 minima de legalizacion por la forma LDCIMTPB
  Autor       :  Antonio Benitez Llorente
  Fecha       :  04-09-2019

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  26/02/2020          dsaltarin          320: Se crea log de errores.
  19/03/2023          Adrianavg          OSF-2389: Se aplican pautas técnicas y se reemplazan servicios homólogos
                                         Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                         Se declaran variables de gestion de trazas
                                         Se retira el esquema open antepuesto a tablas or_task_type, ge_items, ldc_cmmitemsxtt y or_task_types_items
                                         Se retira código comentado
                                         Se reemplaza ERROR.SetError por Pkg_Error.Seterror
                                         Se reemplaza ex.controlled_error por pkg_error.controlled_error
                                         Se reemplaza ut_file.fileopen por pkg_gestionarchivos.ftabrirarchivo_smf
                                         Se reemplaza utl_file.get_line por pkg_gestionarchivos.fsbobtenerlinea_smf
                                         Se reemplaza SELECT-INTO por cursor cuExisteTipoTrab, cuExisteItems, cuExisteActClasif2, cuExisteTipTrabItems, cuCantMaxMin
                                         Se reemplaza ut_file.filewrite por pkg_gestionarchivos.prcescribirlinea_smf
                                         Se reemplaza utl_file.fclose por pkg_gestionarchivos.prccerrararchivo_smf
                                         Se ajusta bloque de excepciones según pautas técnicas
                                         Se reemplaza ge_boerrors.seterrorcodeargument por pkg_Error.seterrormessage
                                         Se retira IF-ENDIF del fblaplicaentrega(sbEntrega), pero se deja la logica interna, ya que la entrega OSS_OL_0000050_4 se encuentra
                                         activa en producción, se retira la variable sbEntrega.
                                         Se añade BEGIN-END para capturar error al momento de abrir el archivo y no continue el procesamiento
                                         Se retira la exception utl_file.invalid_operation, de haber error se irá por el WHEN OTHERS
  25/04/2024          Adrianavg          OSF-2389: Se migra del esquema OPEN al esquema ADM_PERSON                                         
  **************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
	csbInicio   	    CONSTANT VARCHAR2(35) 	    := pkg_traza.csbINICIO;  
    Onuerrorcode        NUMBER                      := pkg_error.CNUGENERIC_MESSAGE; 
    
    cnuNULL_ATTRIBUTE   CONSTANT NUMBER := 2126; 
    
    sbDESCRIPCION       ge_boInstanceControl.stysbValue;
    sbNOMBRE            ge_boInstanceControl.stysbValue;
    
    Archivo             pkg_gestionarchivos.styarchivo;
    sblinea             VARCHAR2(5000);
    sbTipo_Trabajo      VARCHAR2(4000);
    sbItems             VARCHAR2(4000);
    sbActividad         VARCHAR2(4000);
    sbCantidad_min      VARCHAR2(4000);
    sbCantidad_max      VARCHAR2(4000);
    
    nuValidaActividad   NUMBER;
    nuValidaDatos       NUMBER;
    boFinArchivo        BOOLEAN := FALSE;
    
    CURSOR cuCursor IS
    SELECT COUNT(1)
      FROM ldc_cmmitemsxtt
     WHERE task_type_id = sbtipo_trabajo
       AND items_id = sbitems
       AND (activity_id = sbactividad OR (activity_id IS NULL AND sbactividad IS NULL));    
    
    ---320---------------------------------------
    nuTipoTrab          or_task_type.task_type_id%TYPE;
    nuItems             ge_items.items_id%TYPE;
    nuActividad         ge_items.items_id%TYPE;
    nuCantMin           ldc_cmmitemsxtt.item_amount_min%TYPE;
    nuCantMax           ldc_cmmitemsxtt.item_amount_max%TYPE;
    sbMensaje           VARCHAR2(4000);
    nuExiste            NUMBER;
    sbErrorFile         VARCHAR2(100);
    nuLinea             NUMBER;
    FPORDERERRORS       pkg_gestionarchivos.styarchivo;
    CNUMAXLENGTHTOASSIG CONSTANT  NUMBER:=32000;
    tbCadena            ut_string.TYTB_STRING;
    sbSeparador         VARCHAR2(1) := '|';
    ---320---------------------------------------
    
    CURSOR cuExisteTipoTrab( p_nutipotrab or_task_type.task_type_id%TYPE) 
    IS
    SELECT COUNT(1) 
      FROM or_task_type T
     WHERE T.task_type_id = p_nutipotrab;
    
    CURSOR cuExisteItems( p_nuitems ge_items.items_id%TYPE) 
    IS
    SELECT COUNT(1) 
      FROM ge_items I
     WHERE I.items_id = p_nuitems;
     
    CURSOR cuExisteActClasif2( p_nuactividad ge_items.items_id%TYPE) 
    IS
    SELECT COUNT(1) 
      FROM ge_items I
     WHERE I.items_id = nuactividad
      AND I.item_classif_id = 2;     
     
    CURSOR cuExisteTipTrabItems( p_nutipotrab or_task_type.task_type_id%TYPE,
                                 p_nuitems ge_items.items_id%TYPE) 
    IS
    SELECT COUNT(1) 
      FROM or_task_types_items TI
     WHERE TI.task_type_id = p_nutipotrab
       AND TI.items_id = p_nuitems;
       
    CURSOR cuCantMaxMin(p_nutipotrab  ldc_cmmitemsxtt.task_type_id%TYPE,
                        p_nuactividad ldc_cmmitemsxtt.activity_id%TYPE, 
                        p_nucantmin   ldc_cmmitemsxtt.item_amount_min%TYPE,
                        p_nucantmax   ldc_cmmitemsxtt.item_amount_max%TYPE)
    IS
    SELECT COUNT(1) 
      FROM ldc_cmmitemsxtt C
     WHERE C.task_type_id = p_nutipotrab
       AND C.items_id= nuitems
       AND (C.activity_id = p_nuactividad OR (C.activity_id IS NULL AND p_nuactividad IS NULL))
       AND C.item_amount_min= p_nucantmin
       AND C.item_amount_max= p_nucantmax;    
          
     
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, sbmensaje);

    --Se obtienen los valores de la instancia
    sbDESCRIPCION   := ge_boInstanceControl.fsbGetFieldValue ('SM_SERVIDOR', 'DESCRIPCION');
    sbNOMBRE        := ge_boInstanceControl.fsbGetFieldValue ('SM_SERVIDOR', 'NOMBRE');
    pkg_traza.trace(csbMetodo ||' Ruta del archivo: '||sbDESCRIPCION , csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' Nombre del archivo: '||sbNOMBRE , csbNivelTraza);
    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    IF (sbdescripcion IS NULL) THEN
        PKG_ERROR.SETERROR;
        pkg_traza.trace(csbMetodo ||' Ruta vacia' , csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RAISE PKG_ERROR.controlled_error;
    END IF;

    IF (sbnombre IS NULL) THEN 
        PKG_ERROR.SETERROR;
        pkg_traza.trace(csbMetodo ||' Nombre del archivo vacia' , csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RAISE PKG_ERROR.controlled_error;
    END IF;

    --320
    sberrorfile := substr(sbnombre,1,instr(sbnombre,'.')-1); 
    
    IF sberrorfile IS NULL THEN
     sberrorfile := sbnombre;
    END IF;
    sberrorfile := sberrorfile||REPLACE(REPLACE(REPLACE(TO_CHAR(sysdate,'DD/MM/YYYY HH:MI'),'/','_'),':','_'),' ','_')||'.err';
    pkg_traza.trace(csbMetodo ||' sberrorfile: '||sberrorfile , csbNivelTraza);
    
    fpordererrors := pkg_gestionarchivos.ftAbrirArchivo_SMF(sbdescripcion, sberrorfile , 'w');-- isbDirectorio , isbArchivo , isbModo   
    --320

    archivo := pkg_gestionarchivos.ftabrirarchivo_smf(sbdescripcion, sbnombre , 'R');     
    nulinea := 0;
    LOOP
    
         BEGIN
           nulinea := nulinea+1;
           --Se recorren las lineas del archivo
           sblinea := pkg_gestionarchivos.fsbobtenerlinea_smf(archivo);
           pkg_traza.trace(csbMetodo ||' sblinea: '||sblinea , csbNivelTraza);
           
           --320--------------------------------------------------
           sblinea := REPLACE(sblinea, CHR(32), '');
           ut_string.extstring(sblinea, sbseparador , tbcadena);
           --320--------------------------------------------------
        
           --Se obtiene el tipo de trabajo
           sbtipo_trabajo:= tbcadena(1);
           pkg_traza.trace(csbMetodo ||' sbtipo_trabajo: '||sbtipo_trabajo , csbNivelTraza);
           
           --Se obtiene el id del item
           sbitems:=  tbcadena(2);
           pkg_traza.trace(csbMetodo ||' sbitems: '||sbitems , csbNivelTraza);
           
           --Se obtiene el id de la actividad
           sbactividad:= tbcadena(3);
           pkg_traza.trace(csbMetodo ||' sbactividad: '||sbactividad , csbNivelTraza);
           
           --Se obtiene la cantidad minima a legalizar
           sbcantidad_min:= tbcadena(4);
           pkg_traza.trace(csbMetodo ||' sbcantidad_min: '||sbcantidad_min , csbNivelTraza);
           
           --Se obtiene la cantidad maxima a legalizar
           sbcantidad_max:= tbcadena(5);
           pkg_traza.trace(csbMetodo ||' sbcantidad_max: '||sbcantidad_max , csbNivelTraza);
           
           --320--------------------------------------------------
           nutipotrab := NULL;
           nuitems := NULL;
           nuactividad := NULL;
           nucantmin:= NULL;
           nucantmax:=NULL; 
        
           sbmensaje := NULL;
           --Valida el tipo de trabajo
            BEGIN
                pkg_traza.trace(csbMetodo ||' Inicia validación del tipo de trabajo ' , csbNivelTraza);
                IF sbtipo_trabajo IS NULL THEN                
                    sbmensaje := 'El tipo de trabajo no puede ser nulo. ';                
                ELSE                
                    nutipotrab:= TO_NUMBER(sbtipo_trabajo);
                    
                    OPEN cuExisteTipoTrab(nutipotrab);
                    FETCH cuExisteTipoTrab INTO nuexiste;
                    CLOSE cuExisteTipoTrab;
                    
                    IF nuexiste = 0 THEN
                        sbmensaje := 'Error tipo de trabajo '||sbtipo_trabajo||' no existe. ';
                    END IF;
                    pkg_traza.trace(csbMetodo ||' Existe Tipo Trabajo(>0): '||nuexiste , csbNivelTraza);
                
                END IF;
                pkg_traza.trace(csbMetodo ||' Fin validación del tipo de trabajo ' , csbNivelTraza);
            
            EXCEPTION
                WHEN value_error THEN
                
                    IF LOWER(sqlerrm) LIKE '%character to NUMBER conversion error%' THEN
                        sbmensaje:= 'Error al convertir el tipo de trabajo '||sbtipo_trabajo||' a numero. ';
                    ELSIF LOWER(sqlerrm) LIKE '%NUMBER precision too large%' THEN
                        sbmensaje:= 'Error al convertir el tipo de trabajo '||sbtipo_trabajo||' se intenta ingresar un numero muy grande. ';
                    END IF;
                    
                    pkg_traza.trace(csbMetodo ||' WHEN value_error: '||sbmensaje , csbNivelTraza);
                    pkg_traza.trace(csbMetodo ||' Fin validación del tipo de trabajo ' , csbNivelTraza);
                WHEN OTHERS THEN
                    sbmensaje := 'Error tipo de trabajo '||sbtipo_trabajo||':'||sqlerrm||'. ';
                    pkg_traza.trace(csbMetodo ||' WHEN OTHERS: '||sbmensaje , csbNivelTraza);
                    pkg_traza.trace(csbMetodo ||' Fin validación del tipo de trabajo ' , csbNivelTraza);
            END;
           
            --Valida el item
            BEGIN
                pkg_traza.trace(csbMetodo ||' Inicia validación de el item ' , csbNivelTraza);
                IF sbitems IS NULL THEN                
                    sbmensaje := sbmensaje||'El item no puede ser nulo. ';                
                ELSE                
                    nuitems:= TO_NUMBER(sbitems);
                    
                    OPEN cuExisteItems(nuitems);
                    FETCH cuExisteItems INTO nuexiste;
                    CLOSE cuExisteItems;
                    pkg_traza.trace(csbMetodo ||' Existe Item(>0): '||nuexiste , csbNivelTraza);
                    
                    IF nuexiste = 0 THEN
                        sbmensaje := sbmensaje||'Error  item '||sbitems||' no existe. ';
                    ELSE
                        IF nutipotrab IS NOT NULL THEN                        
                            OPEN cuExisteTipTrabItems(nutipotrab, nuitems );
                            FETCH cuExisteTipTrabItems INTO nuexiste;
                            CLOSE cuExisteTipTrabItems;
                            pkg_traza.trace(csbMetodo ||' Existe Tipo Trabajo-Item(>0): '||nuexiste , csbNivelTraza);
                            
                            IF nuexiste = 0 THEN
                             sbmensaje := sbmensaje||'Error item '||sbitems||' no se encuentra asociado al tipo de trbajo '||sbtipo_trabajo||'. ';
                            END IF;                        
                        END IF;
                    END IF;
                
                END IF;
                
                pkg_traza.trace(csbMetodo ||' Fin validación de el item ' , csbNivelTraza);
            
            EXCEPTION
                WHEN value_error THEN
                
                    IF LOWER(sqlerrm) LIKE '%character to NUMBER conversion error%' THEN
                        sbmensaje:= sbmensaje||'Error al convertir el item '||sbitems||' a numero. ';
                    ELSIF LOWER(sqlerrm) LIKE '%NUMBER precision too large%' THEN
                        sbmensaje:= sbmensaje||'Error al convertir el item '||sbitems||' se intenta ingresar un numero muy grande. ';
                    END IF;
                    
                    pkg_traza.trace(csbMetodo ||' WHEN value_error: '||sbmensaje , csbNivelTraza);
                    pkg_traza.trace(csbMetodo ||' Fin validación de el item ' , csbNivelTraza);
                    
                WHEN OTHERS THEN
                    sbmensaje := sbmensaje||'Error item '||sbitems||':'||sqlerrm||'. ';
                    pkg_traza.trace(csbMetodo ||' WHEN OTHERS: '||sbmensaje , csbNivelTraza);
                    pkg_traza.trace(csbMetodo ||' Fin validación de el item ' , csbNivelTraza);
            END;
           
           --Valida la actividad
            BEGIN
                pkg_traza.trace(csbMetodo ||' Inicia validación de la actividad ' , csbNivelTraza);
                IF sbactividad IS NOT NULL THEN
                
                    nuactividad:= TO_NUMBER(sbactividad);
                    
                    OPEN cuExisteActClasif2(nuactividad);
                    FETCH cuExisteActClasif2 INTO nuexiste;
                    CLOSE cuExisteActClasif2;
                    pkg_traza.trace(csbMetodo ||' Existe Actividad con Clasifid 2 (>0): '||nuexiste , csbNivelTraza);
                    
                    IF nuexiste = 0 THEN
                        sbmensaje := sbmensaje||'Error  actividad '||nuactividad||' no existe. ';
                    ELSE
                        IF nutipotrab IS NOT NULL THEN
                        
                            OPEN cuExisteTipTrabItems(nutipotrab, nuitems );
                            FETCH cuExisteTipTrabItems INTO nuexiste;
                            CLOSE cuExisteTipTrabItems;
                            pkg_traza.trace(csbMetodo ||' Existe actividad asociada al tipo de trabajo(>0): '||nuexiste , csbNivelTraza);
                            
                            IF nuexiste = 0 THEN
                             sbmensaje := sbmensaje||'Error actividad '||nuactividad||' no se encuentra asociada al tipo de trabajo '||sbtipo_trabajo||'. ';
                            END IF;
                        END IF;
                    END IF;
                END IF;
                
                pkg_traza.trace(csbMetodo ||' Fin validación de la actividad ' , csbNivelTraza);
            
            EXCEPTION
                WHEN value_error THEN
                
                    IF LOWER(sqlerrm) LIKE '%character to NUMBER conversion error%' THEN
                        sbmensaje:= sbmensaje||'Error al convertir la actividad '||sbactividad||' a numero. ';
                    ELSIF LOWER(sqlerrm) LIKE '%NUMBER precision too large%' THEN
                        sbmensaje:= sbmensaje||'Error al convertir la actividad '||sbactividad||' se intenta ingresar un numero muy grande. ';
                    END IF;
                    
                    pkg_traza.trace(csbMetodo ||' WHEN value_error: '||sbmensaje , csbNivelTraza); 
                    pkg_traza.trace(csbMetodo ||' Fin validación de la actividad ' , csbNivelTraza);
                    
                WHEN OTHERS THEN
                    sbmensaje := sbmensaje||'Error actividad '||sbactividad||':'||sqlerrm||'. ';
                    pkg_traza.trace(csbMetodo ||' WHEN OTHERS: '||sbmensaje , csbNivelTraza); 
                    pkg_traza.trace(csbMetodo ||' Fin validación de la actividad ' , csbNivelTraza);
            END;
        
           --Valida la cantidad minima
            BEGIN
                pkg_traza.trace(csbMetodo ||' Inicia validación la cantidad minima' , csbNivelTraza);
                
                IF sbcantidad_min IS NULL THEN
                    sbmensaje := sbmensaje||'La cantidad minima no puede ser nula. ';
                ELSE
                    nucantmin := TO_NUMBER(sbcantidad_min);
                END IF;
                pkg_traza.trace(csbMetodo ||' nucantmin: '||nucantmin , csbNivelTraza); 
                
                pkg_traza.trace(csbMetodo ||' Fin validación la cantidad minima' , csbNivelTraza);
            
            EXCEPTION
                WHEN value_error THEN            
                    IF LOWER(sqlerrm) LIKE '%character to NUMBER conversion error%' THEN
                        sbmensaje:= sbmensaje||'Error al convertir la cantidad minima '||sbcantidad_min||' a numero. ';
                    ELSIF LOWER(sqlerrm) LIKE '%NUMBER precision too large%' THEN
                        sbmensaje:= sbmensaje||'Error al convertir la cantidad minima '||sbcantidad_min||' se intenta ingresar un numero muy grande. ';
                    END IF;
                
                    pkg_traza.trace(csbMetodo ||' WHEN value_error: '||sbmensaje , csbNivelTraza); 
                    pkg_traza.trace(csbMetodo ||' Fin validación la cantidad minima ' , csbNivelTraza);
                
                WHEN OTHERS THEN
                    sbmensaje := sbmensaje||'Error cantidad minima '||sbcantidad_min||':'||sqlerrm||'. ';
                    pkg_traza.trace(csbMetodo ||' WHEN OTHERS: '||sbmensaje , csbNivelTraza);
                    pkg_traza.trace(csbMetodo ||' Fin validación la cantidad minima ' , csbNivelTraza);
            END;
            
           --Valida la cantidad máxima
            BEGIN
                pkg_traza.trace(csbMetodo ||' Inicia validación de la cantidad máxima' , csbNivelTraza);
                IF sbcantidad_max IS NULL THEN
                    sbmensaje := sbmensaje||'La cantidad maxima no puede ser nula. ';
                ELSE
                    nucantmax:= TO_NUMBER(sbcantidad_max);
                    IF nucantmax < nucantmin THEN
                        sbmensaje:= sbmensaje||'Error la cantidad minima '||sbcantidad_min||' no puede ser mayor que la cantidad maxima '||sbcantidad_max;
                    END IF;
                END IF;
                pkg_traza.trace(csbMetodo ||' nucantmax: '||nucantmax , csbNivelTraza); 
                pkg_traza.trace(csbMetodo ||' Fin validación de la cantidad máxima' , csbNivelTraza);
                
            EXCEPTION
                WHEN value_error THEN
                    IF LOWER(sqlerrm) LIKE '%character to NUMBER conversion error%' THEN
                        sbmensaje:= sbmensaje||'Error al convertir la cantidad maxima '||sbcantidad_max||' a numero. ';
                    ELSIF LOWER(sqlerrm) LIKE '%NUMBER precision too large%' THEN
                        sbmensaje:= sbmensaje||'Error al convertir la cantidad maxima '||sbcantidad_max||' se intenta ingresar un numero muy grande. ';
                    END IF;
                    pkg_traza.trace(csbMetodo ||' WHEN value_error: '||sbmensaje , csbNivelTraza);
                    pkg_traza.trace(csbMetodo ||' Fin validación de la cantidad máxima ' , csbNivelTraza);
                WHEN OTHERS THEN
                    sbmensaje := sbmensaje||'Error cantidad maxima '||sbcantidad_max||':'||sqlerrm||'. ';
                    pkg_traza.trace(csbMetodo ||' WHEN OTHERS: '||sbmensaje , csbNivelTraza);
                    pkg_traza.trace(csbMetodo ||' Fin validación de la cantidad máxima ' , csbNivelTraza);
            END;
        
            OPEN cuCantMaxMin(nutipotrab, nuactividad, nucantmin, nucantmax);
            FETCH cuCantMaxMin INTO nuexiste;
            CLOSE cuCantMaxMin;
            pkg_traza.trace(csbMetodo ||' Existe Cant Max, Min para el tipo de trabajo y actividad(>0): '||nuexiste , csbNivelTraza);
            
            IF nuexiste > 0 THEN
             sbmensaje := 'Ya existe un registro con los mismos datos.Validar';
            END IF;
           --320--------------------------------------------------
           
           IF sbmensaje IS NULL THEN
                 --Cursor que retorna 1 si los datos existen en la tabla LDC_CMMITEMSXTT  con actividad
                 IF(cucursor%isopen)THEN
                   CLOSE cucursor;
                 END IF;
            
                 OPEN cucursor;
                 FETCH cucursor INTO nuvalidaactividad;
                 CLOSE cucursor;
            
                 IF nuvalidaactividad = 1 THEN
                   --Se actualiza la campos el la tabla LDC_CMMITEMSXTT
                   UPDATE ldc_cmmitemsxtt
                      SET item_amount_min = sbcantidad_min,
                          item_amount_max = sbcantidad_max
                    WHERE task_type_id = sbtipo_trabajo
                      AND items_id = sbitems
                      AND (activity_id = sbactividad OR (activity_id IS NULL AND sbactividad IS NULL));
                    pkg_traza.trace(csbMetodo ||' UPDATE en ldc_cmmitemsxtt, task_type_id '||sbtipo_trabajo
                                              ||' , items_id '||sbitems||' , activity_id '||sbactividad , csbNivelTraza);
                 ELSE
                   --Se insertan los datos en la tabla LDC_CMMITEMSXTT
                   INSERT  INTO ldc_cmmitemsxtt
                   (itemsxtt_id, task_type_id, items_id, activity_id, item_amount_min, item_amount_max)
                   VALUES
                   (seqldc_cmmitemsxtt.NEXTVAL, sbtipo_trabajo, sbitems, sbactividad, sbcantidad_min, sbcantidad_max);
                    pkg_traza.trace(csbMetodo ||' INSERT en ldc_cmmitemsxtt, task_type_id '||sbtipo_trabajo
                                              ||' , items_id '||sbitems||' , activity_id '||sbactividad , csbNivelTraza);
                 END IF;
                 COMMIT;
            
             ELSE
               pkg_gestionarchivos.prcescribirlinea_smf(fpordererrors, '['||nulinea ||']'||sbmensaje);
             END IF; 
         
         --Exepcion para cuando el archivos no encuentre mas lineas.
         EXCEPTION
            WHEN no_data_found THEN
                boFinArchivo := TRUE;
                pkg_traza.trace(csbMetodo ||' no hay mas lineas' , csbNivelTraza);
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo ||' Excepcion cuando el archivo no encuentre mas lineas '  ||sqlerrm , csbNivelTraza);
                ROLLBACK;
                EXIT;
         END;
         EXIT WHEN boFinArchivo;
    END LOOP;
    --Se cierra  el archivo
    pkg_gestionarchivos.prccerrararchivo_smf(Archivo);
    pkg_gestionarchivos.prccerrararchivo_smf(fpordererrors);

    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR THEN
        pkg_Error.getError(onuerrorcode, sbmensaje);
        pkg_traza.trace(csbMetodo ||' sbmensaje: ' || sbmensaje, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error; 
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(onuerrorcode, sbmensaje);
        pkg_traza.trace(csbMetodo ||' sbmensaje: ' || sbmensaje, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;  
END LDC_PR_CANTLEGAITEMS;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_PR_CANTLEGAITEMS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PR_CANTLEGAITEMS', 'ADM_PERSON'); 
END;
/