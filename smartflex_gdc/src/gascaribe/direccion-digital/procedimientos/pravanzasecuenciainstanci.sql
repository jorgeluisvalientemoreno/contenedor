CREATE OR REPLACE PROCEDURE prAvanzaSecuenciaInstanci
IS
    /*******************************************************************************
        Fuente=Propiedad Intelectual de Gases del Caribe
        Procedimiento: prAvanzaSecuenciaInstanci
        Autor       :
        Fecha       :
        Descripcion :   Procedimiento que avanza la secuencia de wf_instance
        Modificaciones  :
        Autor       Fecha       Caso        Descripcion
        jpinedc     30-04-2024  OSF-2581    Se reemplaza ldc_sendemail por
                                            pkg_Correo.prcEnviaCorreo
    *******************************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) :=  'prAvanzaSecuenciaInstanci';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;    
    
    nuseq         NUMBER := 0;
    nuproxhueco   NUMBER;
    numax         NUMBER := NULL;
    i             NUMBER := 0;
    j             NUMBER := 1000000;
    nuRangos      NUMBER;

    I2            NUMBER := 0;
    J2            NUMBER := 1000000;

    CURSOR cuHuecos IS
          SELECT i.valor_inicial, i.valor_final, ROWID
            FROM ldc_huecos_disp_instancia i
           WHERE i.usado = 'N'
        ORDER BY 1;

    rwHuegos      cuHuecos%ROWTYPE;
    NOMBRE_BD     VARCHAR2 (4000);
    
    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
        
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  


    NOMBRE_BD := UT_DBINSTANCE.FSBGETCURRENTINSTANCETYPE;

    IF NOMBRE_BD != 'P'
    THEN
        NOMBRE_BD := 'PRUEBAS:';
    ELSE
        NOMBRE_BD := 'PRODUCCION:';
    END IF;

    --loop principal
    WHILE I2 < J2
    LOOP
        BEGIN
            IF numax IS NULL
            THEN
                --se busca el maximo del rango
                BEGIN
                    SELECT MAX (i.valor_final)
                      INTO numax
                      FROM ldc_huecos_disp_instancia i
                     WHERE i.usado = 'S';
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        numax := NULL;
                END;
            END IF;

            ---busco proximo hueco disponible
            IF numax IS NOT NULL
            THEN
                OPEN cuHuecos;

                FETCH cuHuecos INTO rwHuegos;

                IF cuHuecos%FOUND
                THEN
                    nuproxhueco := rwHuegos.valor_inicial;

                    WHILE nuseq < numax
                    LOOP
                        SELECT S.LAST_NUMBER
                          INTO nuseq
                          FROM all_sEQUENCES S
                         WHERE S.SEQUENCE_NAME = 'SEQ_GE_WORKFLOW_INSTANCE';

                        IF nuseq < numax
                        THEN
                            DBMS_LOCK.sleep (5);
                        END IF;
                    END LOOP;

                    SELECT COUNT (1)
                      INTO nuRangos
                      FROM ldc_huecos_disp_instancia i
                     WHERE i.usado = 'N' AND ROWID != rwHuegos.ROWID;

                    WHILE i <= j
                    LOOP
                        nuseq := SEQ_GE_WORKFLOW_INSTANCE.NEXTVAL;

                        IF nuseq < nuproxhueco
                        THEN
                            NULL;
                        ELSE
                            BEGIN
         
                                pkg_Correo.prcEnviaCorreo
                                (
                                    isbRemitente        => sbRemitente,
                                    isbDestinatarios    => 'dsaltarin@gascaribe.com;jdonado@gascaribe.com;jvaliente@horbath.com',
                                    isbAsunto           => NOMBRE_BD || 'Avanzo secuencia',
                                    isbMensaje          =>  'Quedan '
                                    || nuRangos
                                    || ' huecos disponibles.'
                                    || nuproxhueco
                                    || '-'
                                    || rwHuegos.valor_final
                                );
                                    
                            EXCEPTION
                                WHEN OTHERS
                                THEN
                                    pkg_Error.setError;
                            END;

                            i := j;
                            EXIT;
                        END IF;
                    END LOOP;

                    numax := rwHuegos.valor_final - 5000;

                    UPDATE ldc_huecos_disp_instancia
                       SET usado = 'S'
                     WHERE ROWID = rwHuegos.ROWID;

                    COMMIT;
                END IF;                           --if numax  is not null then
            ELSE
                I2 := I2 + 1;
                numax := NULL;

                BEGIN
                        
                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => sbRemitente,
                        isbDestinatarios    => 'dsaltarin@gascaribe.com;jdonado@gascaribe.com;jvaliente@horbath.com',
                        isbAsunto           => NOMBRE_BD || 'Avanzo secuencia',
                        isbMensaje          =>  'Quedan '
                        || nuRangos
                        || ' huecos disponibles.'
                        || nuproxhueco
                        || '-'
                        || rwHuegos.valor_final
                    );
                    
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        pkg_Error.setError;
                END;
            END IF;

            CLOSE cuHuecos;
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_Error.setError;
        END;
    END LOOP;
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
    
END prAvanzaSecuenciaInstanci;
/