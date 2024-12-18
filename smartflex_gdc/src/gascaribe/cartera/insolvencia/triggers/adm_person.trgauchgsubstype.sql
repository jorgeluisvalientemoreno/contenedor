CREATE OR REPLACE TRIGGER ADM_PERSON.trgauchgsubstype
FOR UPDATE OF sesuesco on SERVSUSC 
REFERENCING OLD AS OLD
NEW AS NEW
WHEN ( new.sesuesco = 99 )
COMPOUND TRIGGER    

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : trgauchgsubstype 
    Descripcion     : Trigger para actualizar el tipo de contrato a -1 si
                      todos los productos estan en estado de corte 99
    Autor           : GdC 
    Fecha           : 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     29-06-2023  OSF-1286    Se pasa el trigger a compound para evitar
                                        error de trigger mutante
    jpinedc     19-07-2023  OSF-1286    Se cambia pkErrors por pkg_error
    ***************************************************************************/
    
    csbSP_NAME                 CONSTANT VARCHAR2(100)         := 'trgauchgsubstype.';
    cnuNVLTRC                  CONSTANT NUMBER                := 5;

    gnusubstypeinsolv          CONSTANT NUMBER := gc_boconstants.fnugetsucriptypeinsolv;
                 
    CURSOR cuSusc
    IS
    select sesususc, count(1)
    from servsusc ss1,
    suscripc sc
    where ss1.sesuesco IN ( 111, 112 )
    and sc.susccodi = ss1.sesususc
    and sc.susctisu = gnusubstypeinsolv
    and ss1.sesuserv <> ( 7053 )
    group by sesususc
    having count(1) = 1;
    
    TYPE tytbSusc IS TABLE OF number(1) INDEX BY BINARY_INTEGER;
    
    tbSusc tytbSusc;
                
    BEFORE STATEMENT IS
        csbMT_NAME  VARCHAR2(30) := 'BEFORE_STATEMENT';
    BEGIN
                    
        ut_trace.trace('Inicia ' || csbSP_NAME ||csbMT_NAME, cnuNVLTRC); 
                
        FOR rg IN cuSusc LOOP
            tbSusc( rg.sesususc ) := 1;
        END LOOP;

        ut_trace.trace('tbSusc.count|' || tbSusc.count, cnuNVLTRC);
       
        ut_trace.trace('Termina ' || csbSP_NAME ||csbMT_NAME, cnuNVLTRC);
            
    END BEFORE STATEMENT;

    AFTER EACH ROW IS
    
        csbMT_NAME  VARCHAR2(30) := 'AFTER_EACH_ROW';
            
        nusubscrip         servsusc.sesususc%TYPE;
        nusubsctype        suscripc.susctisu%TYPE;
        nuerrcode          NUMBER;
        sberrmsg           VARCHAR2(2000);        

    BEGIN
    
        ut_trace.trace('Inicia ' || csbSP_NAME ||csbMT_NAME, cnuNVLTRC);
                
        -- Se obtiene el contrato
        nusubscrip := :new.sesususc;
        nusubsctype := pktblsuscripc.fnugetsusctisu(nusubscrip);
        
        ut_trace.trace('nusubscrip|' || nusubscrip, cnuNVLTRC);
        
        IF tbSusc.Exists(nusubscrip) THEN
        
            ut_trace.trace('tbSusc.Exists' , cnuNVLTRC);
        
            IF nusubsctype = gnusubstypeinsolv THEN
                ut_trace.trace('nusubsctype = '|| gnusubstypeinsolv , cnuNVLTRC);
                pktblsuscripc.updsusctisu(nusubscrip, -1);
            END IF;
            
        END IF;
                   
        ut_trace.trace('Termina ' || csbSP_NAME ||csbMT_NAME, cnuNVLTRC);  
        
    EXCEPTION
        WHEN login_denied OR pkconstante.exerror_level2 THEN
            pkg_error.getError(nuerrcode, sberrmsg);
            ut_trace.trace('Termina con ERROR_CONT' || csbSP_NAME ||csbMT_NAME || '|' || sberrmsg, cnuNVLTRC);              
            raise pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuerrcode, sberrmsg);
            ut_trace.trace('Termina con ERROR_NCONT ' || csbSP_NAME ||csbMT_NAME || '|' || sberrmsg, cnuNVLTRC);
            raise pkg_error.CONTROLLED_ERROR;
    END AFTER EACH ROW;
    
END trgauchgsubstype;
/