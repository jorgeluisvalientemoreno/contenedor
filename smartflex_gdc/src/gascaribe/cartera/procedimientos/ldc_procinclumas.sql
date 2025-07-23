create or replace PROCEDURE      ldc_procinclumas(inuProgramacion in ge_process_schedule.process_schedule_id%TYPE) IS
  /*********************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2014-08-12
    Descripcion : Generamos el proyecto de castigo a usuarios por inclusion manual

    Parametros Entrada

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR     DESCRIPCION
     25/03/2021   DANVAL    Caso 604_1: Validacion del Estado de Corte con base al parametro ESTACORT_NO_PERMI_CASTIGO
     31/05/2021   DANVAL    Caso 604_2: En cambio de alcance, se definio ejecutar el registro GC_PRODPRCA por fuera del ciclo y establecer un mensaje segun el caso, si es o no cartera castigada
     13/07/2021   DANVAL    Caso 604_3: Se modifica el proceso para garantizar el registro de todos los productos validos en la tabla de castigos
     06/07/2022   CGONZALEZ OSF-194: Se adiciona validacion por estado del producto para 7014-Gas
									 Actualizacion de fecha de exclusion cuando el producto no cumpla las validaciones
     19/03/2023   Adrianavg OSF-2389: Se aplican pautas técnicas y se reemplazan servicios homólogos
                            Se declaran variables para la gestión de trazas
                            Se reemplaza ldc_boutilities.splitstrings por regexp_substr
                            Se reemplaza dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbObtieneValorCadena
                            Se reemplaza dald_parameter.fnuGetNumeric_Value por pkg_bcld_parameter.fnuobtienevalornumerico
                            Se declaran variables para inicializar el proceso
                            Se reemplaza consulta de datos para inicializar el proceso según pautas técnicas
                            Se reemplaza ldc_proinsertaestaprog por pkg_estaproc.prinsertaestaproc
                            Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.prinsertaestaproc
                            Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo                            
                            Se reemplaza utl_file.get_line por pkg_gestionarchivos.fsbobtenerlinea_smf
                            Se reemplaza utl_file.fopen por pkg_gestionarchivos.ftabrirarchivo_smf
                            Se reemplaza utl_file.PUT por pkg_gestionarchivos.prcescribirlineasinterm_smf
                            Se reemplaza SELECT-INTO por cursor cuEdoCorteTipProduc, cuEstadoProduc, cuConseProyCast, cuConsecProy
                            Se reemplaza ut_trace.trace por pkg_traza.trace
                            Se reemplaza utl_file.fclose por pkg_gestionarchivos.prccerrararchivo_smf
                            Se reemplaza el tipo de dato de las variables sbnombrearchivo y sbnombrearinco de VARCHAR(30) por ge_boInstanceControl.stysbValue[VARCHAR2(2000)]
                            Se retiran las variables nuparano, nuparmes, nutsess, sbparuser
                            Se ajusta bloque de excepciones según pautas técnicas
  *********************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
	csbInicio   	    CONSTANT VARCHAR2(35) 	    := pkg_traza.csbINICIO;  
    
	nuCodigoError	NUMBER            	:= pkg_error.CNUGENERIC_MESSAGE; 
	sbproceso       VARCHAR2(100 BYTE)	:=  csbMetodo||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
	sbmensaje       VARCHAR2(5000);
    
BEGIN

	pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    
    pkg_traza.trace('inuProgramacion: ' || inuProgramacion , csbNivelTraza);
	
	pkg_boinclusioncastigocartera.prcProcesa(inuProgramacion,
											 sbproceso
											 );
	
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        sbmensaje := 'Error en LDC_PROCINCLUMAS  - ' || sqlerrm;
        pkg_estaproc.practualizaestaproc(sbproceso, 'NOk ', 'Error en el proceso : ' || ' ' || sbmensaje  ); 
        pkg_Error.setError;
        pkg_Error.getError(nuCodigoError, sbmensaje);
        pkg_traza.trace(csbMetodo ||' sbmensaje: ' || sbmensaje, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
END;
/