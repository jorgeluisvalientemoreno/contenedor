CREATE OR REPLACE PROCEDURE LDC_PROCREPAVC_AUTOMATICO
IS
    /**************************************************************************
        Autor       : HB
        Fecha       : 2020-08-24
        Descripcion : Generamos informacion de analisis de consumo por periodo mediante schedule
                      que procesa automaticamente los periodos cerrados el dia anterior (CA-317)

        Parametros Entrada

        Valor de salida

       HISTORIA DE MODIFICACIONES
         FECHA          AUTOR   DESCRIPCION
         19/06/2024     jpinedc OSF-2605: * Se usa pkg_Correo
                                          * Ajustes por estándares
		 06/08/2024		jsoto	OSF-3092: 	Se restaura el objeto 
											Se elimina el llamado a las funciones ldc_fsbretornarespprenencues y ldc_fncretornaotencueconccero
											ya que hacían parte de funcionalidad de encuestas que ya no se usa desde OSF.
    ***************************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) := 'LDC_PROCREPAVC_AUTOMATICO';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    nuerror        NUMBER (3) := 0;
    nuciclo        servsusc.sesucicl%TYPE;
    sbMensaje        VARCHAR2 (4000);
    error          NUMBER;
    nuparano       NUMBER (4);
    nuparmes       NUMBER (2);
    nutsess        NUMBER;
    sbparuser      VARCHAR2 (30);
    dtfeanal       DATE := SYSDATE;
    nucantregis    NUMBER (10) DEFAULT 0;
    cant_reg       NUMBER (10) DEFAULT 0;

    -- Destinatarios
    sbDestinatarios           VARCHAR2 (4000)
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_MAIL_LDC_PROCREPAVC');
    sbAsunto      VARCHAR2 (4000) := 'LDC_PROCREPAVC Automatico';
    sbCiclos       VARCHAR2 (4000);

    -- cursor de periodos a procesar
    CURSOR cuPeriodos IS
        SELECT pefacicl,
               pefaano,
               pefames,
               p.*
          FROM procejec p, perifact pf
         WHERE     TRUNC (prejfech) = TRUNC (SYSDATE - 1)
               AND p.prejprog = 'FGCC'
               AND p.prejespr = 'T'
               AND p.prejcope = pefacodi;


    -- Cursor de ciclos
    CURSOR cuciclos (nuciclo perifact.pefacicl%TYPE)
    IS
        SELECT COUNT (1)     AS cant_reg
          FROM servsusc
         WHERE sesuserv = 7014 AND sesucicl = nuciclo;
    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    nuerror := 1;
    nucantregis := 0;
      
    nutsess     := USERENV ('SESSIONID');
    sbparuser   := USER;

    nuerror := 2;
    -- Se adiciona al log de procesos
    ldc_proinsertaestaprog (nuparano,
                            nuparmes,
                            'LDC_PROCREPAVC_AUTO',
                            'En ejecucion',
                            nutsess,
                            sbparuser);

    nuerror := 3;

    -- Se recorren los periodos procesados el dia anterior
    FOR i IN cuPeriodos
    LOOP
        -- se busca el numero de productos por ciclo
        OPEN cuciclos (i.pefacicl);

        FETCH cuciclos INTO cant_reg;

        IF cuciclos%NOTFOUND
        THEN
            cant_reg := -1;
        END IF;

        CLOSE cuciclos;

        IF cant_reg > 0
        THEN
            -- Borramos registros
            DELETE ldc_repanalcons p
             WHERE     nuano = i.pefaano
                   AND numes = i.pefames
                   AND p.ciclo = i.pefacicl;

            COMMIT;


            nuerror := 4;
            -- buscamos los datos para el analisis de consumo para cada producto del ciclo
            nuciclo := i.pefacicl;

            INSERT INTO ldc_repanalcons
                (SELECT /*+INDEX(servsusc IX_SERVSUSC08)*/
                        i.pefaano
                            AS nuano,
                        i.pefames
                            AS numes,
                        sesususc,
                        sesunuse,
                        sesucicl,
                        sesucate,
                        sesusuca,
                        sesufein,
                        ldc_osspkevaluametodosavc.fnuevalmetodo5 (sesunuse,
                                                                  dtfeanal)
                            metodo5,
                        ldc_osspkevaluametodosavc.fnuevalmetodo9 (sesunuse,
                                                                  dtfeanal)
                            metodo9,
                        ldc_fnuGetZeroConsPer_gdc (sesunuse,
                                                   i.pefaano,
                                                   i.pefames)
                            periodos_cero,
                        28,
                        null,
                        null
                   FROM servsusc
                  WHERE     sesucicl = i.pefacicl
                        AND sesuserv = 7014
                        AND sesunuse = sesunuse);

            COMMIT;
            nucantregis := nucantregis + cant_reg;
            sbCiclos :=
                   sbCiclos
                || i.pefacicl
                || ' ('
                || i.pefaano
                || ' - '
                || i.pefames
                || '),'
                || '<br>';
        END IF;
    END LOOP;

    -- se muestra log de final del proceso
    nuerror := 5;
    sbMensaje :=
           'Proceso termino Ok. Se procesaron :'
        || TO_CHAR (nucantregis)
        || ' registros';
    ldc_proactualizaestaprog (nutsess,
                              sbMensaje,
                              'LDC_PROCREPAVC_AUTO',
                              'Ok.');

    --se envian correos
    sbMensaje :=
           'Proceso termino Ok. Se procesaron :'
        || TO_CHAR (nucantregis)
        || ' registros de los ciclos: '
        || '<br>'
        || sbCiclos;
                    
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbDestinatarios,
        isbAsunto           => sbAsunto,
        isbMensaje          => sbMensaje
    );                    
                    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);                      
EXCEPTION
    WHEN OTHERS
    THEN
        ROLLBACK;
        sbMensaje :=
               TO_CHAR (error)
            || ' Error en ldc_procrepavc..lineas error '
            || TO_CHAR (nuerror)
            || ' '
            || SQLERRM;
        ldc_proactualizaestaprog (nutsess,
                                  sbMensaje,
                                  'LDC_PROCREPAVC_AUTO',
                                  'Termino con error.');
        --se envian correos si hubo error
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbDestinatarios,
            isbAsunto           => sbAsunto,
            isbMensaje          => sbMensaje
        );
END LDC_PROCREPAVC_AUTOMATICO;
/
GRANT EXECUTE ON LDC_PROCREPAVC_AUTOMATICO TO SYSTEM_OBJ_PRIVS_ROLE;
/