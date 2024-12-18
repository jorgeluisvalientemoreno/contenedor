CREATE OR REPLACE PACKAGE personalizaciones.ldc_pksatabmirror is

/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   26/06/2024   OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
   jpinedc     09/10/2024   OSF-3164: Migrar del esquema ADM_PERSON al esquema 
								     PERSONALIZACIONES
   jpinedc     28/10/2024   OSF-3164: Ajustes por cambios es paquetes de acceso a
                            datos
   ***************************************************************************/

  /**************************************************************************
  Procedimiento      : PRREGISTRSA_TAB_MIRROR
  Descripcion        : Registrar datos en la entidad SA_TAB_MIRROR
  Autor              : Jorge Valiente
  Fecha              : 18/06/2018

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  PROCEDURE PRREGISTRASA_TAB_MIRROR(V_TAB_ID                NUMBER,
                                    V_TAB_NAME              VARCHAR2,
                                    V_PROCESS_NAME          VARCHAR2,
                                    V_APLICA_EXECUTABLE     VARCHAR2,
                                    V_PARENT_TAB            VARCHAR2,
                                    V_TYPE                  VARCHAR2,
                                    V_SEQUENCE              NUMBER,
                                    V_ADDITIONAL_ATTRIBUTES VARCHAR2,
                                    V_CONDITION             VARCHAR2);

  /**************************************************************************
  Procedimiento      : PRACTUALIZASA_TAB_MIRROR
  Descripcion        : Actualiza datos en la entidad SA_TAB_MIRROR
  Autor              : Jorge Valiente
  Fecha              : 19/06/2018

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  PROCEDURE PRACTUALIZASA_TAB_MIRROR(V_TAB_ID                NUMBER,
                                     V_TAB_NAME              VARCHAR2,
                                     V_PROCESS_NAME          VARCHAR2,
                                     V_APLICA_EXECUTABLE     VARCHAR2,
                                     V_PARENT_TAB            VARCHAR2,
                                     V_TYPE                  VARCHAR2,
                                     V_SEQUENCE              NUMBER,
                                     V_ADDITIONAL_ATTRIBUTES VARCHAR2,
                                     V_CONDITION             VARCHAR2);

  --INICIO SERVICIO SA_TAB
  /**************************************************************************
  Procedimiento      : PRREGISTRASA_TAB
  Descripcion        : Registrar datos en la entidad SA_TAB
  Autor              : Jorge Valiente
  Fecha              : 18/06/2018

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  PROCEDURE PRREGISTRASA_TAB(V_TAB_NAME              VARCHAR2,
                             V_PROCESS_NAME          VARCHAR2,
                             V_APLICA_EXECUTABLE     VARCHAR2,
                             V_PARENT_TAB            VARCHAR2,
                             V_TYPE                  VARCHAR2,
                             V_SEQUENCE              NUMBER,
                             V_ADDITIONAL_ATTRIBUTES VARCHAR2,
                             V_CONDITION             VARCHAR2);

  /**************************************************************************
  Procedimiento      : PRACTUALIZASA_TAB
  Descripcion        : Actualiza datos en la entidad SA_TAB
  Autor              : Jorge Valiente
  Fecha              : 19/06/2018

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  PROCEDURE PRACTUALIZASA_TAB(V_TAB_NAME              VARCHAR2,
                              V_PROCESS_NAME          VARCHAR2,
                              V_APLICA_EXECUTABLE     VARCHAR2,
                              V_PARENT_TAB            VARCHAR2,
                              V_TYPE                  VARCHAR2,
                              V_SEQUENCE              NUMBER,
                              V_ADDITIONAL_ATTRIBUTES VARCHAR2,
                              V_CONDITION             VARCHAR2);

  /**************************************************************************
  Procedimiento      : PRACTUALIZASA_TAB_JOB
  Descripcion        : JOB para actualizar datos en la entidad SA_TAB
  Autor              : Jorge Valiente
  Fecha              : 19/06/2018

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  PROCEDURE PRACTUALIZASA_TAB_JOB;

End LDC_PKSATABMIRROR;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.LDC_PKSATABMIRROR AS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /**************************************************************************
    Procedimiento      : PRREGISTRASA_TAB_MIRROR
    Descripcion        : Registrar datos en la entidad SA_TAB_MIRROR
    Autor              : Jorge Valiente
    Fecha              : 18/06/2018

    Historia de Modificaciones
    Fecha          Autor                   Modificacion
    =========       =========                ====================
    **************************************************************************/
    PROCEDURE PRREGISTRASA_TAB_MIRROR(V_TAB_ID                NUMBER,
                                    V_TAB_NAME              VARCHAR2,
                                    V_PROCESS_NAME          VARCHAR2,
                                    V_APLICA_EXECUTABLE     VARCHAR2,
                                    V_PARENT_TAB            VARCHAR2,
                                    V_TYPE                  VARCHAR2,
                                    V_SEQUENCE              NUMBER,
                                    V_ADDITIONAL_ATTRIBUTES VARCHAR2,
                                    V_CONDITION             VARCHAR2) AS

    PRAGMA autonomous_transaction;

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PRREGISTRASA_TAB_MIRROR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    
        SBFLAG_JOB_SA_TAB LD_PARAMETER.VALUE_CHAIN%TYPE := 
                    NVL(pkg_BCLD_Parameter.fsbObtieneValorCadena('FLAG_JOB_SA_TAB'),'N');

        rcRegistroRId pkg_sa_tab_mirror.cuRegistroRId%ROWTYPE;    

        rc_sa_tab_mirror    pkg_sa_tab_mirror.cusa_tab_mirror%ROWTYPE;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        pkg_Traza.Trace('SBFLAG_JOB_SA_TAB[' || SBFLAG_JOB_SA_TAB || ']', 10);
        
        IF SBFLAG_JOB_SA_TAB = 'N' THEN

            rcRegistroRId  := pkg_sa_tab_mirror.frcObtRegistroRId
            (
                isbTAB_NAME             =>  V_TAB_NAME,  
                isbPROCESS_NAME         =>  V_PROCESS_NAME,
                isbAPLICA_EXECUTABLE    =>  V_APLICA_EXECUTABLE
            ); 
                                                   
            IF rcRegistroRId.tab_id IS NULL THEN
                        
                rc_sa_tab_mirror.tab_id                 :=  v_tab_id;
                rc_sa_tab_mirror.tab_name               :=  v_tab_name;
                rc_sa_tab_mirror.process_name           :=  v_process_name;
                rc_sa_tab_mirror.aplica_executable      :=  v_aplica_executable;
                rc_sa_tab_mirror.parent_tab             :=  v_parent_tab;
                rc_sa_tab_mirror.type                   :=  v_type;
                rc_sa_tab_mirror.sequence               :=  v_sequence;
                rc_sa_tab_mirror.additional_attributes  :=  v_additional_attributes;
                rc_sa_tab_mirror.condition              :=  v_condition;
            
                pkg_sa_tab_mirror.prinsRegistro( rc_sa_tab_mirror );

                commit;

            END IF;
            
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
    END PRREGISTRASA_TAB_MIRROR;

    /**************************************************************************
    Procedimiento      : PRACTUALIZASA_TAB_MIRROR
    Descripcion        : Actualiza datos en la entidad SA_TAB_MIRROR
    Autor              : Jorge Valiente
    Fecha              : 19/06/2018

    Historia de Modificaciones
    Fecha          Autor                   Modificacion
    =========       =========                ====================
    **************************************************************************/
    PROCEDURE PRACTUALIZASA_TAB_MIRROR(V_TAB_ID                NUMBER,
                                     V_TAB_NAME              VARCHAR2,
                                     V_PROCESS_NAME          VARCHAR2,
                                     V_APLICA_EXECUTABLE     VARCHAR2,
                                     V_PARENT_TAB            VARCHAR2,
                                     V_TYPE                  VARCHAR2,
                                     V_SEQUENCE              NUMBER,
                                     V_ADDITIONAL_ATTRIBUTES VARCHAR2,
                                     V_CONDITION             VARCHAR2) AS

        PRAGMA autonomous_transaction;

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PRACTUALIZASA_TAB_MIRROR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                
        rcRegistroRId pkg_sa_tab_mirror.cuRegistroRId%ROWTYPE;    

        rc_sa_tab_mirror    pkg_sa_tab_mirror.cusa_tab_mirror%ROWTYPE;

        SBFLAG_JOB_SA_TAB LD_PARAMETER.VALUE_CHAIN%TYPE := 
                            NVL(pkg_BCLD_Parameter.fsbObtieneValorCadena('FLAG_JOB_SA_TAB'),'N');

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        pkg_Traza.Trace('SBFLAG_JOB_SA_TAB[' || SBFLAG_JOB_SA_TAB || ']', 10);
        
        IF SBFLAG_JOB_SA_TAB = 'N' THEN

            rcRegistroRId  := pkg_sa_tab_mirror.frcObtRegistroRId
            (
                isbTAB_NAME             =>  V_TAB_NAME,  
                isbPROCESS_NAME         =>  V_PROCESS_NAME,
                isbAPLICA_EXECUTABLE    =>  V_APLICA_EXECUTABLE
            ); 
                                                   
            IF rcRegistroRId.tab_id IS NOT NULL THEN


                rc_sa_tab_mirror.tab_id                 :=  v_tab_id;
                rc_sa_tab_mirror.tab_name               :=  v_tab_name;
                rc_sa_tab_mirror.process_name           :=  v_process_name;
                rc_sa_tab_mirror.aplica_executable      :=  v_aplica_executable;
                rc_sa_tab_mirror.parent_tab             :=  v_parent_tab;
                rc_sa_tab_mirror.type                   :=  v_type;
                rc_sa_tab_mirror.sequence               :=  v_sequence;
                rc_sa_tab_mirror.additional_attributes  :=  v_additional_attributes;
                rc_sa_tab_mirror.condition              :=  v_condition;
            
                pkg_sa_tab_mirror.prActRegistro( rc_sa_tab_mirror );
                                                    
                commit;
                
            END IF;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
    END PRACTUALIZASA_TAB_MIRROR;

    /**************************************************************************
    Procedimiento      : PRREGISTRASA_TAB
    Descripcion        : Registrar datos en la entidad SA_TAB
    Autor              : Jorge Valiente
    Fecha              : 18/06/2018

    Historia de Modificaciones
    Fecha          Autor                   Modificacion
    =========       =========                ====================
    **************************************************************************/
    PROCEDURE PRREGISTRASA_TAB(V_TAB_NAME              VARCHAR2,
                             V_PROCESS_NAME          VARCHAR2,
                             V_APLICA_EXECUTABLE     VARCHAR2,
                             V_PARENT_TAB            VARCHAR2,
                             V_TYPE                  VARCHAR2,
                             V_SEQUENCE              NUMBER,
                             V_ADDITIONAL_ATTRIBUTES VARCHAR2,
                             V_CONDITION             VARCHAR2) AS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PRREGISTRASA_TAB';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        V_TAB_ID NUMBER;
        
        rcsa_tab    pkg_sa_tab.cusa_tab%ROWTYPE;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        pkg_traza.trace('Inserta en sa_tab', csbNivelTraza);
        pkg_traza.trace('v_tab_name|'|| v_tab_name, csbNivelTraza);
        pkg_traza.trace('v_process_name|'|| v_process_name, csbNivelTraza);
        pkg_traza.trace('v_aplica_executable|'|| v_aplica_executable, csbNivelTraza);

        V_TAB_ID := pkg_gestionSecuencias.fnuSEQ_SA_TAB;
        
        rcsa_tab.tab_id                 :=  v_tab_id;
        rcsa_tab.tab_name               :=  v_tab_name;
        rcsa_tab.process_name           :=  v_process_name;
        rcsa_tab.aplica_executable      :=  v_aplica_executable;
        rcsa_tab.parent_tab             :=  v_parent_tab;
        rcsa_tab.type                   :=  v_type;
        rcsa_tab.sequence               :=  v_sequence;
        rcsa_tab.additional_attributes  :=  v_additional_attributes;
        rcsa_tab.condition              :=  v_condition;
        
        pkg_sa_tab.prinsRegistro( rcsa_tab);
        
        commit;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
    END PRREGISTRASA_TAB;

    PROCEDURE prcCierracuSA_Tab
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCierracuSA_Tab';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);       
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        IF pkg_sa_tab.cuSA_Tab%ISOPEN THEN
            CLOSE pkg_sa_tab.cuSA_Tab;
        END IF;
        
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
    END prcCierracuSA_Tab;
        
    /**************************************************************************
    Procedimiento      : PRACTUALIZASA_TAB
    Descripcion        : Actualiza datos en la entidad SA_TAB
    Autor              : Jorge Valiente
    Fecha              : 19/06/2018

    Historia de Modificaciones
    Fecha          Autor                   Modificacion
    =========       =========                ====================
    **************************************************************************/
    PROCEDURE PRACTUALIZASA_TAB(V_TAB_NAME              VARCHAR2,
                              V_PROCESS_NAME          VARCHAR2,
                              V_APLICA_EXECUTABLE     VARCHAR2,
                              V_PARENT_TAB            VARCHAR2,
                              V_TYPE                  VARCHAR2,
                              V_SEQUENCE              NUMBER,
                              V_ADDITIONAL_ATTRIBUTES VARCHAR2,
                              V_CONDITION             VARCHAR2) AS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PRACTUALIZASA_TAB';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        rcsa_tab        pkg_sa_tab.cuSA_Tab%ROWTYPE;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_traza.trace('v_tab_name|'|| v_tab_name, csbNivelTraza);
        pkg_traza.trace('v_process_name|'|| v_process_name, csbNivelTraza);
        pkg_traza.trace('v_aplica_executable|'|| v_aplica_executable, csbNivelTraza);
                                       
        prcCierracuSA_Tab;
        
        OPEN pkg_sa_tab.cuSA_Tab( V_TAB_NAME, V_PROCESS_NAME, V_APLICA_EXECUTABLE );
        FETCH pkg_sa_tab.cuSA_Tab INTO rcsa_tab;
        CLOSE pkg_sa_tab.cuSA_Tab;
        
        IF rcsa_tab.tab_id IS NOT NULL THEN

            pkg_traza.trace('Actualiza en sa_tab', csbNivelTraza);

            pkg_traza.trace('tab_id|'||rcsa_tab.tab_id, csbNivelTraza);
            
            pkg_traza.trace('V_Parent_Tab|'||V_Parent_Tab, csbNivelTraza);
            pkg_traza.trace('V_type|'||V_type, csbNivelTraza);
            pkg_traza.trace('V_sequence|'||V_sequence, csbNivelTraza);
            pkg_traza.trace('V_additional_attributes|'||V_additional_attributes, csbNivelTraza);
            pkg_traza.trace('V_condition|'||V_condition, csbNivelTraza);
                                            
            rcsa_tab.parent_tab             := V_Parent_Tab;
            rcsa_tab.type                   := V_type;
            rcsa_tab.sequence               := V_sequence;
            rcsa_tab.additional_attributes  := V_additional_attributes;
            rcsa_tab.condition              := V_condition;
            
            pkg_sa_tab.prActRegistro( rcsa_tab ); 
        
            commit;
                
        ELSE
            pkg_traza.trace('No existe registro en SA_TAB', csbNivelTraza);            
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierracuSA_Tab;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierracuSA_Tab;            
    END PRACTUALIZASA_TAB;

    /**************************************************************************
    Procedimiento      : PRACTUALIZASA_TAB_JOB
    Descripcion        : JOB para actualizar datos en la entidad SA_TAB
    Autor              : Jorge Valiente
    Fecha              : 19/06/2018

    Historia de Modificaciones
    Fecha          Autor                   Modificacion
    =========       =========                ====================
    **************************************************************************/
    PROCEDURE PRACTUALIZASA_TAB_JOB AS

        PRAGMA autonomous_transaction;

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PRACTUALIZASA_TAB_JOB';
        
        nuError     number;
        sbError     varchar2(4000);
        
        rcsa_tab    pkg_sa_tab.cuSA_Tab%ROWTYPE;
        
        PROCEDURE pActParFLAG_JOB_SA_TAB( isbVALUE VARCHAR2)
        IS
        BEGIN
            pkg_ld_parameter.prAcVALUE_CHAIN
            (
                isbPARAMETER_ID    => 'FLAG_JOB_SA_TAB',
                isbVALUE_CHAIN    => isbVALUE
            );
            COMMIT;              
        END pActParFLAG_JOB_SA_TAB;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pActParFLAG_JOB_SA_TAB('S');

        FOR RFCUSA_TAB_MIRROR IN pkg_sa_tab_mirror.CUSA_TAB_MIRROR LOOP
        
            prcCierracuSA_Tab;
            
            OPEN pkg_sa_tab.cuSA_Tab(  RFCUSA_TAB_MIRROR.TAB_NAME, RFCUSA_TAB_MIRROR.PROCESS_NAME, RFCUSA_TAB_MIRROR.APLICA_EXECUTABLE  );
            FETCH pkg_sa_tab.cuSA_Tab INTO rcsa_tab;
            CLOSE pkg_sa_tab.cuSA_Tab;
            
            IF rcsa_tab.tab_id IS NULL THEN
                                  
                PRREGISTRASA_TAB(RFCUSA_TAB_MIRROR.TAB_NAME,
                               RFCUSA_TAB_MIRROR.PROCESS_NAME,
                               RFCUSA_TAB_MIRROR.APLICA_EXECUTABLE,
                               RFCUSA_TAB_MIRROR.PARENT_TAB,
                               RFCUSA_TAB_MIRROR.TYPE,
                               RFCUSA_TAB_MIRROR.SEQUENCE,
                               RFCUSA_TAB_MIRROR.ADDITIONAL_ATTRIBUTES,
                               RFCUSA_TAB_MIRROR.CONDITION);
            ELSE
                PRACTUALIZASA_TAB(RFCUSA_TAB_MIRROR.TAB_NAME,
                                RFCUSA_TAB_MIRROR.PROCESS_NAME,
                                RFCUSA_TAB_MIRROR.APLICA_EXECUTABLE,
                                RFCUSA_TAB_MIRROR.PARENT_TAB,
                                RFCUSA_TAB_MIRROR.TYPE,
                                RFCUSA_TAB_MIRROR.SEQUENCE,
                                RFCUSA_TAB_MIRROR.ADDITIONAL_ATTRIBUTES,
                                RFCUSA_TAB_MIRROR.CONDITION);
            END IF;

        END LOOP;

        pActParFLAG_JOB_SA_TAB('N');
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            pActParFLAG_JOB_SA_TAB('N');
            prcCierracuSA_Tab;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            pActParFLAG_JOB_SA_TAB('N');
            prcCierracuSA_Tab;
    END PRACTUALIZASA_TAB_JOB;

END LDC_PKSATABMIRROR;
/

PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKSATABMIRROR
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKSATABMIRROR', 'PERSONALIZACIONES'); 
END;
/

PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_PKSATABMIRROR
GRANT EXECUTE ON personalizaciones.LDC_PKSATABMIRROR TO REXEREPORTES;
/

