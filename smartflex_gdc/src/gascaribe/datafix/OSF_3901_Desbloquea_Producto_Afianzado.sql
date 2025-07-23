column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    -- Tipo de dato de tabla PL
    TYPE tytbProd IS VARRAY(519) OF NUMBER;

    tbProd          tytbProd;
    nuIdx           NUMBER;
    nuCont          NUMBER;
    nuTotal         NUMBER;
    nuContExi       NUMBER;
    nuContNoExi     NUMBER;
    sbBloq          VARCHAR2(20);

BEGIN
    nuCont      := 0;
    nuTotal     := 0;
    nuContExi   := 0;
    nuContNoExi := 0;

    tbProd := tytbProd (52610892, 52700259, 52675682, 52750152, 52788406, 52801919, 52868093, 52692057, 52699173, 52734819, 52902557,
                        52849399, 52804386, 52655670, 52662550, 52821831, 52862430, 52721312, 52795715, 52622033, 52651649, 52781079,
                        52877240, 52607489, 52679541, 52703506, 52729996, 52760699, 52770032, 52676268, 52687586, 52911600, 52802714,
                        52848832, 52848928, 52614098, 52792849, 52810319, 52662737, 52679308, 52718138, 52739104, 52782742, 52837713,
                        52662683, 52696411, 52829286, 52682208, 52844567, 52641896, 52825357, 52894584, 52621962, 52668088, 52616164,
                        52844560, 52660813, 52694364, 52666823, 52814153, 52835936, 52695607, 52913842, 52661636, 52846504, 52874265,
                        52716059, 52905904, 52648490, 52728799, 52895352, 52648092, 52711686, 52715072, 52717557, 52658175, 52663079,
                        52771082, 52695613, 52701570, 52739178, 52756895, 52900340, 52660992, 52656804, 52657251, 52676258, 52665950,
                        52740142, 52813249, 52837474, 52500985, 52475926, 52751783, 52784041, 52793707, 52655074, 52721362, 52895325,
                        52680363, 52725860, 52621763, 52661478, 52786144, 52579931, 52709149, 52745353, 52902468, 52631592, 52651435,
                        52657111, 52719626, 52724327, 52737044, 52662775, 52728374, 52748944, 52771432, 52796073, 52614794, 52652941,
                        52762592, 52819226, 52707022, 52735032, 52837491, 52665087, 52666579, 52699085, 52772383, 52823637, 52909535,
                        52694417, 52795855, 52599840, 52706537, 52746465, 52793520, 52675594, 52760138, 52778055, 52782328, 52627504,
                        52663378, 52671727, 52705275, 52883618, 52607490, 52684045, 52693736, 52637501, 52727056, 52782798, 52822107,
                        52857500, 52879388, 52617619, 52657752, 52768725, 52803618, 52791110, 52881249, 52604633, 52753788, 52755075,
                        52789895, 52797317, 52885081, 52589593, 52725617, 52884149, 52603796, 52620955, 52636743, 52762840, 52897885,
                        52766937, 52862000, 52880678, 52896580, 52914614, 52921643, 52936608, 52585930, 52577611, 52609272, 52643628,
                        52729507, 52749390, 52778969, 52887344, 52723953, 52600511, 52803632, 52837714, 52866195, 52903358, 52612968,
                        52636071, 52829738, 52921241, 52745225, 52672416, 52790908, 52614037, 52920606, 52635145, 52729233, 52889946,
                        52744082, 52768137, 52801856, 52813236, 52914386, 52585614, 52673053, 52879409, 52763064, 52803681, 52864226,
                        52610899, 52913669, 52641279, 52819746, 52856085, 52872397, 52567933, 52759229, 52705303, 52820568, 52588947,
                        52728567, 52782519, 52677928, 52768701, 52590342, 52756870, 52709241, 52859184, 52912387, 52926381, 52606543,
                        52622341, 52634292, 52894437, 52720283, 52754366, 52801481, 52886850, 52792865, 52806492, 52839376, 52755351,
                        52911357, 52636829, 52643972, 52820709, 52784499, 52869126, 52945143, 52753761, 52863908, 52910951, 52814316,
                        52631706, 52762327, 52873108, 52695719, 52621431, 52763225, 52778895, 52839895, 52930372, 52581932, 52590105,
                        52610040, 52678750, 52750585, 52781462, 52848769, 52608234, 52621546, 52820472, 52698571, 52702217, 52727347,
                        52901392, 52698205, 52703410, 52784775, 52856808, 52910165, 52731038, 52794731, 52872901, 52894586, 52909579,
                        52681283, 52890481, 52577093, 52682400, 52628220, 52935997, 52617882, 52699920, 52784827, 52594195, 52675939,
                        52803311, 52917851, 52568467, 52710134, 52752180, 52722241, 52601965, 52629669, 52632654, 52635263, 52719073,
                        52829397, 52937067, 52575025, 52757311, 52673582, 52715128, 52740739, 52744346, 52794560, 52803554, 52639601,
                        52906515, 52936614, 52681958, 52707232, 52850585, 52911618, 52790318, 52801370, 52919510, 52943280, 52679467,
                        52727369, 52734587, 52895793, 52662646, 52657206, 52493557, 52498595, 52709955, 52694117, 52756884, 52660602,
                        52474874, 52679648, 52689754, 52729497, 52709574, 52716914, 52893344);

    dbms_output.put_line('Inicia OSF-3901_Desbloquea_Producto_Afianzado');
    dbms_output.put_line('-----------------------------------------------------');

    -- Total de registros de la coleccion
    nuTotal := tbProd.COUNT;

    -- Primer registro
    nuIdx := tbProd.FIRST;
    
    -- Recorre la coleccion
    LOOP
        EXIT WHEN nuIdx IS NULL;

        BEGIN
            -- Trae datos del producto
            sbBloq := null;
            SELECT block INTO sbBloq
            FROM ldc_afianzado 
            WHERE product_id = tbProd(nuIdx);

            IF (sbBloq = 'N') THEN
                dbms_output.put_line('Producto: '||tbProd(nuIdx)||', ya estaba desbloqueado');
                nuContExi := nuContExi + 1;
            ELSE
                -- Actualiza el registro
                sbBloq := null;
                UPDATE LDC_AFIANZADO 
                SET block 		= 'N', 
					UPDATED_AT 	= sysdate
                WHERE product_id = tbProd(nuIdx)
                RETURNING block INTO sbBloq;

                IF sbBloq is not null THEN
                    dbms_output.put_line('Producto: '||tbProd(nuIdx)||', desbloqueado OK');
                    nuCont := nuCont + 1;
                    commit;
                END IF;
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                rollback;
                nuContNoExi := nuContNoExi + 1;
                dbms_output.put_line('Producto: '||tbProd(nuIdx)||', no existe en la tabla LDC_AFIANZADO');
            WHEN OTHERS THEN
                rollback;
                dbms_output.put_line('ERROR actualizando Producto: '|| tbProd(nuIdx) ||', SQLERRM: '|| SQLERRM );
        END;
        -- Siguiente registro
        nuIdx := tbProd.NEXT(nuIdx);
    END LOOP;

    tbProd.DELETE;
    dbms_output.put_line('-----------------------------------------------------');
    dbms_output.put_line('Seleccionados:   '||nuTotal  ||', Actualizados OK: '||nuCont);
    dbms_output.put_line('Ya Actualizados:   '||nuContExi||', No existen:        '||nuContNoExi);
    dbms_output.put_line('Fin del Proceso. ');

EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error en OSF-3901_Desbloquea_Producto_Afianzado: '|| SQLERRM);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/