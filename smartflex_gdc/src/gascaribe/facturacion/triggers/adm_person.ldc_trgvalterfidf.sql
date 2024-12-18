CREATE OR REPLACE TRIGGER adm_person.LDC_TRGVALTERFIDF
    BEFORE INSERT OR UPDATE
    ON ESTAPROG
    FOR EACH ROW
/**************************************************************************
Proceso     : LDC_TRGVALTERFIDF
Autor       :  Horbath
Fecha       : 2020-11-23
Ticket      : 461
Descripcion : trigger para marcar periodos que terminaron FIDF
Parametros Entrada
Parametros de salida
HISTORIA DE MODIFICACIONES
FECHA        AUTOR       DESCRIPCION
26/07/2021   LJLB        CA 696 se envia notificacion siempre y cuando el FIDF genere error
17/05/2024   jpinedc     OSF-2581: Ajustes por estandares de programación
17/10/2024 	 jpinedc	 OSF-3450: Se migra a ADM_PERSON
***************************************************************************/
DECLARE

    csbMetodo        CONSTANT VARCHAR2(70) := 'LDC_TRGVALTERFIDF';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
        
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    
    CURSOR cuExiste IS
        SELECT PCFAESTA
          FROM LDC_PECOFACT
         WHERE PCFAPEFA = :NEW.ESPRPEFA;

    sbdatos       VARCHAR2 (1);

    sbNitGdc      VARCHAR2 (400)
                      := pkg_BCLD_Parameter.fsbObtieneValorCadena ('NIT_GDC');

    CURSOR cuValiSistema IS
        SELECT 'X'
          FROM sistema
         WHERE SISTNITC = sbNitGdc;

    sbExiste      VARCHAR2 (4);
    sbEmailNoti   VARCHAR2 (4000)
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_EMAILNOLE');
    sb_subject    VARCHAR2 (200) := 'Proceso FIDF termino correctamente';

    CURSOR cuEmails (sbEmail VARCHAR2, sbseparador VARCHAR2)
    IS
        SELECT COLUMN_VALUE
          FROM TABLE (ldc_boutilities.splitstrings (sbEmail, sbseparador));

    CURSOR cugetCiclo IS
        SELECT    'PERIODO ['
               || pefacodi
               || ' - '
               || pefadesc
               || '] CICLO ['
               || pefacicl
               || ' - '
               || cicldesc
               || ']'
          FROM perifact, ciclo
         WHERE pefacodi = :NEW.ESPRPEFA AND pefacicl = ciclcodi;

    sbPeriodo     VARCHAR2 (4000);

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    IF (INSTR (:NEW.ESPRPROG, 'FIDF') > 0 AND :NEW.ESPRPORC = 100)
    THEN
        UPDATE LDC_PERIPROG
           SET PEPRFLAG = 'T', PEPRFEFI = SYSDATE
         WHERE PEPRPEFA = :NEW.ESPRPEFA AND PROCESO = 3;

        --se valida sistema
        OPEN cuValiSistema;

        FETCH cuValiSistema INTO sbExiste;

        CLOSE cuValiSistema;

        IF sbExiste IS NOT NULL
        THEN
            OPEN cuExiste;

            FETCH cuExiste INTO sbdatos;

            CLOSE cuExiste;

            IF sbdatos IS NULL
            THEN
                INSERT INTO LDC_PECOFACT (PCFAPEFA, PCFAESTA, PCFAFERE)
                     VALUES (:NEW.ESPRPEFA, 'N', SYSDATE);
            ELSE
                IF sbdatos <> 'N'
                THEN
                    UPDATE LDC_PECOFACT
                       SET PCFAESTA = 'N'
                     WHERE PCFAPEFA = :NEW.ESPRPEFA;
                END IF;
            END IF;
        END IF;

    END IF;

    IF (INSTR (:NEW.ESPRPROG, 'FBCS') > 0 AND :NEW.ESPRPORC = 100)
    THEN
        UPDATE OPEN.LDC_CODPERFACT
           SET ESTADPROCESS = 'T'
         WHERE COD_PERFACT = :NEW.ESPRPEFA AND TYPEPROCESS = 'FGCA';
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
END;
/