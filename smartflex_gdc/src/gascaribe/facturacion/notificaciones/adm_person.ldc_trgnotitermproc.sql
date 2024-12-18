CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGNOTITERMPROC
    AFTER UPDATE
    ON PROCEJEC
    FOR EACH ROW
/**************************************************************************
Proceso     : LDC_TRGNOTITERMPROC
Autor       :  Horbath
Fecha       : 2020-11-23
Ticket      : 461
Descripcion : trigger para notificar proceso que terminaron

Parametros Entrada
Parametros de salida
HISTORIA DE MODIFICACIONES
FECHA        AUTOR       DESCRIPCION
26/07/2021   LJLB        CA 696 se realiza update al campo PEPRFEFI en todos los casos
                         - si el proceso termino con error actualice solo el campo PEPRFLAG y no el campo PEPRFEFI
                         - envie un correo indicando que el periodo termino con errores
10/06/2022   LJLB        CA OSF-118 se evita envio de mas de un correo cuando hay errores en los procesos
25/04/2024   jpinedc     OSF-2581: se cambia ldc_sendemail por pkg_Correo.prcEnviaCorreo
21/10/2024   jpinedc     OSF-3450: Se migra a ADM_PERSON
***************************************************************************/
DECLARE

    csbMetodo        CONSTANT VARCHAR2(70) := 'LDC_TRGNOTITERMPROC';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
                  
    sbEmailNoti   VARCHAR2 (4000)
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_EMAILNOLE');
        
    sb_subject    VARCHAR2 (200)
        := 'Proceso ' || :NEW.PREJPROG || ' termino correctamente';

    CURSOR cuEmails (sbEmail VARCHAR2, sbseparador VARCHAR2)
    IS
            SELECT REGEXP_SUBSTR (sbEmail,
                                  '[^' || sbseparador || ']+',
                                  1,
                                  LEVEL)    AS email
              FROM DUAL
        CONNECT BY REGEXP_SUBSTR (sbEmail,
                                  '[^' || sbseparador || ']+',
                                  1,
                                  LEVEL)
                       IS NOT NULL;

    nuNotifica    NUMBER := 0;

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
         WHERE pefacodi = :NEW.prejcope AND pefacicl = ciclcodi;


    CURSOR cugetCodCiclo IS
        SELECT pefacicl
          FROM perifact
         WHERE pefacodi = :NEW.prejcope;

    nuciclo       NUMBER;
    sbPeriodo     VARCHAR2 (4000);
    nuTermino     NUMBER;

    CURSOR cuExisteNoti IS
        SELECT 'X'
          FROM LDC_PERIPROG
         WHERE     PEPRPEFA = :NEW.PREJCOPE
               AND PROCESO =
                   DECODE (:NEW.PREJPROG,  'FGCA', 1,  'FCPE', 4,  'FGCC', 2)
               AND PEPRNOTI = 'S';

    sbExiste      VARCHAR2 (1);
    nuExiste      NUMBER (1) := 1;
    nuProceso     NUMBER (1);

    sbRemitente   ld_parameter.value_chain%TYPE
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER');
        
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
        
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

    pkg_traza.trace(':NEW.PREJCOPE|' || :NEW.PREJCOPE, csbNivelTraza );      
    pkg_traza.trace(':NEW.PREJESPR|' || :NEW.PREJESPR, csbNivelTraza );  
    pkg_traza.trace(':NEW.PREJPROG|' || :NEW.PREJPROG, csbNivelTraza );
    pkg_traza.trace(':NEW.PREJESPR|' || :NEW.PREJESPR, csbNivelTraza );
        
    
    --si fgca termino
    IF :NEW.PREJESPR = 'T' AND :NEW.PREJPROG = 'FGCA'
    THEN
     
       UPDATE LDC_PERIPROG
           SET PEPRFLAG = 'T', PEPRFEFI = SYSDATE
         WHERE PEPRPEFA = :NEW.PREJCOPE AND PROCESO = 1;

        IF SQL%ROWCOUNT = 0
        THEN
            nuExiste := 0;
            nuProceso := 1;
        END IF;
    END IF;

    --si fgcc termino
    IF :NEW.PREJESPR = 'T' AND :NEW.PREJPROG = 'FGCC'
    THEN
        UPDATE LDC_PERIPROG
           SET PEPRFLAG = 'T', PEPRFEFI = SYSDATE
         WHERE PEPRPEFA = :NEW.PREJCOPE AND PROCESO = 2;

        IF SQL%ROWCOUNT = 0
        THEN
            nuExiste := 0;
            nuProceso := 2;
        END IF;
    END IF;

    --si fcpe termino
    IF :NEW.PREJESPR = 'T' AND :NEW.PREJPROG = 'FCPE'
    THEN
        UPDATE LDC_PERIPROG
           SET PEPRFLAG = 'T', PEPRFEFI = SYSDATE
         WHERE PEPRPEFA = :NEW.PREJCOPE AND PROCESO = 4;

        IF SQL%ROWCOUNT = 0
        THEN
            nuExiste := 0;
            nuProceso := 4;
        END IF;
    END IF;

    pkg_traza.trace('nuExiste|' || nuExiste, csbNivelTraza );
    
    IF nuExiste = 0
    THEN
        OPEN cugetCodCiclo;

        FETCH cugetCodCiclo INTO nuciclo;

        CLOSE cugetCodCiclo;

        INSERT INTO LDC_PERIPROG (PEPRFLAG,
                                  PEPRCICL,
                                  PEPRFEFI,
                                  PEPRPEFA,
                                  PROCESO)
             VALUES ('T',
                     nuciclo,
                     SYSDATE,
                     :NEW.PREJCOPE,
                     nuProceso);
    END IF;

    IF :NEW.PREJPROG IN ('FGCA', 'FCPE', 'FGCC') AND :NEW.PREJESPR = 'E'
    THEN
        SELECT COUNT (1)
          INTO nuTermino
          FROM ESTAPROG
         WHERE     ESPRPEFA = :NEW.PREJCOPE
               AND ESPRPROG LIKE :NEW.PREJPROG || '%'
               AND ESPRFEFI IS NOT NULL
               AND ESPRPRPR =
                   (SELECT MAX (ESPRPRPR)
                      FROM ESTAPROG
                     WHERE     ESPRPEFA = :NEW.PREJCOPE
                           AND ESPRPROG LIKE :NEW.PREJPROG || '%')
               AND ESPRPORC < 100;
               
        pkg_traza.trace('nuTermino|' || nuTermino, csbNivelTraza ); 

        IF nuTermino > 0
        THEN
            OPEN cuExisteNoti;

            FETCH cuExisteNoti INTO sbExiste;

            CLOSE cuExisteNoti;
            
            pkg_traza.trace('sbExiste|' || sbExiste, csbNivelTraza ); 

            IF sbExiste IS NULL
            THEN
                UPDATE LDC_PERIPROG
                   SET PEPRFLAG = 'T', PEPRNOTI = 'S'
                 WHERE     PEPRPEFA = :NEW.PREJCOPE
                       AND PROCESO =
                           DECODE (:NEW.PREJPROG,
                                   'FGCA', 1,
                                   'FCPE', 4,
                                   'FGCC', 2);

                nuNotifica := 1;
            END IF;
        END IF;
    END IF;


    pkg_traza.trace('sbEmailNoti|' || sbEmailNoti, csbNivelTraza ); 
    pkg_traza.trace('nuNotifica|' || nuNotifica, csbNivelTraza );

    --se envia correo notificando que se termino el proceso
    IF sbEmailNoti IS NOT NULL AND nuNotifica = 1
    THEN
        OPEN cugetCiclo;

        FETCH cugetCiclo INTO sbPeriodo;

        CLOSE cugetCiclo;

        FOR item IN cuEmails (sbEmailNoti, ',')
        LOOP
        
            pkg_traza.trace('item.email|' || item.email, csbNivelTraza );
            
            sb_subject := 'Proceso ' || :NEW.PREJPROG || ' termino con error';

            pkg_Correo.prcEnviaCorreo (
                isbRemitente       => sbRemitente,
                isbDestinatarios   => TRIM (item.email),
                isbAsunto          => sb_subject,
                isbMensaje         =>
                       'Proceso ['
                    || :NEW.PREJPROG
                    || '] termino con error para el '
                    || sbPeriodo);
        END LOOP;
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