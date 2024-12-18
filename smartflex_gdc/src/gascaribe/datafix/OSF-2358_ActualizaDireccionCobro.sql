column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
/*
    Nombre:      OSF-2358_ActualizaDireccionCobro
    Descripcion: Actualiza la direccion de cobro del contrato (susciddi), colocando la misma
                 direccion de instalacion del producto de gas (address_id), de los productos
                 residenciales donde las direcciones son diferentes.
    Autor:       German Dario Guevara Alzate - GlobaMVM
    Fecha:       22/02/2023

    -- Cursor para buscar la data
    SELECT s.susccodi,
               s.susciddi,
               p.product_id,
               p.address_id
    FROM suscripc s
        INNER JOIN servsusc
            ON  sesususc = susccodi
            AND sesuserv = 7014        -- servicio de Gas
            AND sesucate = 1           -- categoria residencial
            --AND sesufere > sysdate     -- productos activos
        INNER JOIN pr_product p
            ON  p.product_id = sesunuse
            AND s.susciddi <> p.address_id;
*/

    -- Tipo de dato de tabla PL, donde el indice es el contrato y el valor es la nueva direccion
    TYPE tytbSusc IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

    tbSusc      tytbSusc;
    nuSusc      NUMBER;
    nuCont      NUMBER;
    nuTotal     NUMBER;
    nuDirOld    NUMBER;
    nuDirNew    NUMBER;

BEGIN
    nuCont  := 0;
    nuTotal := 0;
    tbSusc.DELETE;

    -- tbSusc(SUSCCODI) := SUSCIDDI
    tbSusc(1043475) := 702790;
    tbSusc(1059217) := 697530;
    tbSusc(1061162) := 442421;
    tbSusc(1118859) := 200436;
    tbSusc(1125744) := 427330;
    tbSusc(1130678) := 684957;
    tbSusc(1141067) := 499465;
    tbSusc(1151211) := 685767;
    tbSusc(1186644) := 4319179;
    tbSusc(1186894) := 420041;
    tbSusc(2157199) := 467802;
    tbSusc(2165773) := 21453;
    tbSusc(2183423) := 127398;
    tbSusc(4165160) := 48527;
    tbSusc(5100005) := 50641;
    tbSusc(6081620) := 584224;
    tbSusc(6093971) := 737854;
    tbSusc(6117604) := 1008545;
    tbSusc(6127493) := 1065884;
    tbSusc(6128082) := 735351;
    tbSusc(6136767) := 569674;
    tbSusc(6202653) := 64376;
    tbSusc(6210838) := 87580;
    tbSusc(6218642) := 2696724;
    tbSusc(6219774) := 61250;
    tbSusc(6223566) := 3690058;
    tbSusc(6225585) := 120040;
    tbSusc(6230299) := 2820804;
    tbSusc(6231865) := 127902;
    tbSusc(6232326) := 4253114;
    tbSusc(6232342) := 2968354;
    tbSusc(14204013) := 14990;
    tbSusc(14209058) := 2523362;
    tbSusc(14225452) := 2291362;
    tbSusc(17101662) := 543411;
    tbSusc(17106231) := 224185;
    tbSusc(17133138) := 4246087;
    tbSusc(17141433) := 240369;
    tbSusc(17141777) := 242848;
    tbSusc(17147009) := 261072;
    tbSusc(17154164) := 309453;
    tbSusc(17160083) := 320012;
    tbSusc(17163193) := 4246089;
    tbSusc(17179369) := 384746;
    tbSusc(17184198) := 405516;
    tbSusc(17186287) := 4246090;
    tbSusc(17190041) := 395903;
    tbSusc(17190121) := 405484;
    tbSusc(17190122) := 405490;
    tbSusc(17191273) := 279200;
    tbSusc(17193325) := 412249;
    tbSusc(48005363) := 632243;
    tbSusc(48019417) := 637824;
    tbSusc(48058761) := 1005386;
    tbSusc(48060700) := 665658;
    tbSusc(48077557) := 1070593;
    tbSusc(48078918) := 887749;
    tbSusc(48093163) := 647114;
    tbSusc(48097258) := 805628;
    tbSusc(48097561) := 806366;
    tbSusc(48099305) := 807141;
    tbSusc(48099892) := 758707;
    tbSusc(48104192) := 732747;
    tbSusc(48104811) := 907260;
    tbSusc(48125936) := 830158;
    tbSusc(48129877) := 4860096;
    tbSusc(48141198) := 824716;
    tbSusc(48146996) := 4246059;
    tbSusc(48161649) := 657573;
    tbSusc(48162320) := 680914;
    tbSusc(48190837) := 845364;
    tbSusc(48230310) := 798648;
    tbSusc(48236686) := 2966250;
    tbSusc(48239783) := 753302;
    tbSusc(48242476) := 729527;
    tbSusc(48244098) := 805147;
    tbSusc(48244099) := 805146;
    tbSusc(48247634) := 622725;
    tbSusc(48254871) := 782417;
    tbSusc(66249509) := 167460;
    tbSusc(66251477) := 4251175;
    tbSusc(66252754) := 193302;
    tbSusc(66256697) := 4253095;
    tbSusc(66279668) := 236882;
    tbSusc(66296100) := 1214633;
    tbSusc(66304682) := 1249818;
    tbSusc(66315278) := 1283915;
    tbSusc(66383994) := 263196;
    tbSusc(66405290) := 1444923;
    tbSusc(66427186) := 1485903;
    tbSusc(66478719) := 2678557;
    tbSusc(66478720) := 1645047;
    tbSusc(66478725) := 1645052;
    tbSusc(66478726) := 1645053;
    tbSusc(66478728) := 1645055;
    tbSusc(66478729) := 1645056;
    tbSusc(66478731) := 1645058;
    tbSusc(66478732) := 1645059;
    tbSusc(66478734) := 1645061;
    tbSusc(66478735) := 1645062;
    tbSusc(66478737) := 1645065;
    tbSusc(66478738) := 1645066;
    tbSusc(66478739) := 1645067;
    tbSusc(66478740) := 1645068;
    tbSusc(66478744) := 1645075;
    tbSusc(66478745) := 1645076;
    tbSusc(66478746) := 1645077;
    tbSusc(66478747) := 1645078;
    tbSusc(66478748) := 1645079;
    tbSusc(66478749) := 1645080;
    tbSusc(66478751) := 1645082;
    tbSusc(66485772) := 576054;
    tbSusc(66508481) := 578352;
    tbSusc(66542528) := 1809930;
    tbSusc(66546042) := 1816007;
    tbSusc(66598450) := 419874;
    tbSusc(66609060) := 1993882;
    tbSusc(66627439) := 2047072;
    tbSusc(66636270) := 4253098;
    tbSusc(66642437) := 2039085;
    tbSusc(66672165) := 2206329;
    tbSusc(66704119) := 892487;
    tbSusc(66751593) := 2397351;
    tbSusc(66759538) := 2432348;
    tbSusc(66762310) := 2332283;
    tbSusc(66807669) := 2352391;
    tbSusc(66819094) := 4985382;
    tbSusc(66831451) := 1147257;
    tbSusc(66834749) := 323356;
    tbSusc(66843071) := 2722534;
    tbSusc(66848825) := 2751861;
    tbSusc(66857064) := 136257;
    tbSusc(66857617) := 2765580;
    tbSusc(66860176) := 2766768;
    tbSusc(66860207) := 2768630;
    tbSusc(66860212) := 2768636;
    tbSusc(66860213) := 2768637;
    tbSusc(66860216) := 2768641;
    tbSusc(66890078) := 43178;
    tbSusc(66897929) := 1322867;
    tbSusc(66905284) := 2711623;
    tbSusc(66930571) := 4716119;
    tbSusc(66930719) := 2851598;
    tbSusc(66947209) := 358381;
    tbSusc(66952963) := 2198797;
    tbSusc(66955864) := 2993288;
    tbSusc(66956649) := 2997079;
    tbSusc(66972037) := 3069059;
    tbSusc(66994365) := 3154059;
    tbSusc(66994931) := 3168076;
    tbSusc(66994959) := 3173348;
    tbSusc(67012984) := 1039041;
    tbSusc(67016975) := 2149976;
    tbSusc(67019213) := 1035024;
    tbSusc(67020444) := 3240599;
    tbSusc(67039735) := 3281139;
    tbSusc(67051454) := 3364057;
    tbSusc(67055690) := 969838;
    tbSusc(67064544) := 3400053;
    tbSusc(67069100) := 3428054;
    tbSusc(67071120) := 1142291;
    tbSusc(67075416) := 624507;
    tbSusc(67080504) := 3458080;
    tbSusc(67087617) := 3488167;
    tbSusc(67089330) := 3502055;
    tbSusc(67102471) := 3545182;
    tbSusc(67108089) := 3572316;
    tbSusc(67124431) := 3654056;
    tbSusc(67129129) := 3671091;
    tbSusc(67134549) := 1145662;
    tbSusc(67134708) := 911773;
    tbSusc(67141218) := 3735067;
    tbSusc(67157503) := 3787093;
    tbSusc(67157517) := 3787092;
    tbSusc(67158004) := 2149418;
    tbSusc(67164205) := 3783105;
    tbSusc(67169697) := 3855061;
    tbSusc(67193756) := 191906;
    tbSusc(67226406) := 4038839;
    tbSusc(67238708) := 1764901;
    tbSusc(67239151) := 4176128;
    tbSusc(67266205) := 2794891;
    tbSusc(67273717) := 4160165;
    tbSusc(67283177) := 2946608;
    tbSusc(67323952) := 4403292;
    tbSusc(67336085) := 4464546;
    tbSusc(67339413) := 4472135;
    tbSusc(67405624) := 4724166;
    tbSusc(67424683) := 53976;
    tbSusc(67464701) := 104038;

    dbms_output.put_line('Inicia Proceso OSF-2358_ActualizaDireccionCobro');
    dbms_output.put_line('---------------------------------------------------------------------------------');

    -- Total de registros de la coleccion
    nuTotal := tbSusc.COUNT;

    -- Primer registro
    nuSusc  := tbSusc.FIRST;
    
    -- Recorre la coleccion
    LOOP
        EXIT WHEN nuSusc IS NULL;

        -- Actualiza el contrato con la nueva direccion
        nuDirOld := null;
        nuDirNew := null;
        BEGIN
            -- Trae el valor de la direccion anterior
            SELECT susciddi INTO nuDirOld
            FROM suscripc WHERE susccodi = nuSusc;

            IF (nuDirOld = tbSusc(nuSusc)) THEN
                dbms_output.put_line('** ERROR: Contrato: '||nuSusc||', La direccion de cobro ya esta actualizada: '||tbSusc(nuSusc));
            ELSE
                -- Valida que la direcion exista
                IF (DAAB_ADDRESS.fblExist(tbSusc(nuSusc))) THEN

                    -- Actualiza la nueva direccion en el contrato
                    UPDATE suscripc
                    SET susciddi = tbSusc(nuSusc)
                    WHERE susccodi = nuSusc
                    RETURNING susciddi INTO nuDirNew;

                    IF nuDirNew is not null THEN
                        dbms_output.put_line('Contrato: '||nuSusc||', Direccion Anterior: '||nuDirOld ||', Direccion Nueva: '||nuDirNew);
                        nuCont := nuCont + 1;
                        commit;
                    ELSE
                        dbms_output.put_line('** ERROR: Contrato: '||nuSusc||', No pudo ser actualizado con la direccion: '||tbSusc(nuSusc));
                    END IF;
                ELSE
                    dbms_output.put_line('** ERROR: Contrato: '||nuSusc||', Nueva Direccion NO EXISTE: '||tbSusc(nuSusc));
                END IF;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                rollback;
                dbms_output.put_line('ERROR actualizando contrato: '|| nuSusc ||', SQLERRM: '|| SQLERRM );
        END;
        -- Siguiente registro
        nuSusc := tbSusc.NEXT(nuSusc);
    END LOOP;

    tbSusc.DELETE;
    dbms_output.put_line('---------------------------------------------------------------------------------');
    dbms_output.put_line('Fin del Proceso. Contratos Seleccionados: '||nuTotal||', Contratos actualizados: '||nuCont);

EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error en OSF-2358_ActualizaDireccionCobro: '|| SQLERRM);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/