/**********************************
Caso: OSF-4196
Descripcion: Retiro productos
Fecha: 07/04/2025
***********************************/
DECLARE
    nuerror     NUMBER;
    sberror     VARCHAR2(2000);
    
    CURSOR      cuservsusc IS
        SELECT A.* 
        FROM   OPEN.servsusc A
        WHERE  sesunuse IN (SELECT  product_id
                            FROM    /*+ PR_BORetireServChrgPrd.cuGetServChargesProds */
                            OPEN.pr_product P
                            WHERE   NOT EXISTS (SELECT
                                                'X'
                                                FROM   OPEN.mo_motive M, OPEN.mo_packages pack, OPEN.ps_motive_status ms
                                                WHERE  P.product_id = M.product_id
                                                AND    M.package_id = pack.package_id
                                                AND    pack.motive_status_id = ms.motive_status_id
                                                AND    ms.is_final_status   = 'N')
                            AND     P.product_type_id = 6121 -- Tipo de producto "Cobro de servicios"
                            AND     OPEN.pkdeferredmgr.fnugetdeferredbalservice(P.product_id) <= 0
                            AND     OPEN.pkbccuencobr.fnugetoutstandbal(P.product_id) <= 0
                            AND     OPEN.pkbccuencobr.fnuclaimvaluebyprod(P.product_id) <= 0                           
                            AND p.product_id in (   51176686, 51226979, 51104684, 51273861, 50904378,
                                                    51348756, 51231468, 51444914, 51935017, 52696145,
                                                    51514109, 52912402, 51786926, 52998931, 51161933,
                                                    50912901, 51279424, 51345486, 51408284, 52679852,
                                                    51559156, 52510717, 52499321, 51176374, 51277748,
                                                    51279177, 51283481, 51151401, 50944683, 51425072,
                                                    52587226, 52759226, 51909577, 52946210, 52998910,
                                                    51097409, 51151657, 51151719, 51161650, 51102356,
                                                    51272729, 51272772, 51277720, 51182724, 51007356,
                                                    51356361, 51828833, 51881987, 52069103, 52213579,
                                                    52664599, 52376826, 52781995, 52902073, 52998914,
                                                    51169659, 51182966, 50925289, 52277648, 52409041,
                                                    52861319, 51028116, 51132442, 51641176, 52893501,
                                                    52960532, 51408952, 51116748, 50923488, 51103497,
                                                    51349698, 50898202, 51097429, 51593851, 52856585,
                                                    51151447, 51181870, 51315616, 51274966, 51356443,
                                                    50908425, 51415936, 51347712, 51400836, 50996463,
                                                    52505265, 52810480, 52965791)
                                )                   
        AND sesuesfn <> 'C'                    
        AND nvl(sesusafa,0) = 0
        AND sesuesco <> 92;

    rcservsusc      servsusc%rowtype;
    TYPE tytbservsusc  IS TABLE OF servsusc%rowtype INDEX BY BINARY_INTEGER;
    tbservsusc tytbservsusc;
BEGIN
    
    if pktblconfesco.fblexist(/*min sig:*/inucoecserv=>6121/*number*/,inucoeccodi=>92/*number*/) then
        dbms_output.put_line('Registro (6121, 92) existe en confesco, no se crea');
    else
        dbms_output.put_line('Registro No existe (6121, 92), se crea');        
        insert 
        into confesco (COECSERV, COECCODI, COECFUFA, COECFACT, COECDICO, COECGECA, COECREDA, COECTECS, COECREGE, COECREGL, COECRVAD, COECIDRV)
        values(6121, 92, NULL, 'N',	0, 'N',	'N', '--', NULL, NULL, NULL, NULL);
        
        COMMIT;
    end if;
    
    
    OPEN    cuservsusc;
    FETCH   cuservsusc BULK COLLECT INTO tbservsusc;
    CLOSE   cuservsusc;
    
    dbms_output.put_line('Cantidad de productos: '||tbservsusc.COUNT);
    IF tbservsusc.COUNT <= 0 THEN    
        RETURN;    
    END IF;
    
    FOR I IN tbservsusc.FIRST .. tbservsusc.LAST LOOP
        
        rcservsusc :=  tbservsusc(I);
        
        --actualiza servsusc
        pktblservsusc.updsesuesco(rcservsusc.sesunuse, 92);
        
        --actualiza pr_product 
        update open.pr_product set product_status_id = 16 where product_id = rcservsusc.sesunuse;
        --pkg_producto.practualizasoloestadocorte(rcservsusc.sesunuse, 16);
               
        dbms_output.put_line('Producto: '||rcservsusc.sesunuse||' actualizado.');
            
    END LOOP;

    COMMIT;
EXCEPTION
    WHEN ex.controlled_error THEN
        RAISE ex.controlled_error;
    WHEN OTHERS THEN
        ERRORS.seterror;
        RAISE ex.controlled_error;
END;
/