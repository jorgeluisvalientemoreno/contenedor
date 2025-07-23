DECLARE

    CURSOR cuDatosGdCa
    IS
    SELECT 
    'GDCA'      CODIGO,
    sistempr    NOMBRE,
    sistnitc    NIT,
    sistdire    DIRECCION,
    55          LOCALIDAD,
    NULL DEPARTAMENTO,
    pkg_parametros.fsbGetValorCadena('MATRICULA_MERCANTIL') MATRICULA_MERCANTIL,
    pkg_parametros.fsbGetValorCadena('ZONA_POSTAL_EMISOR') ZONA_POSTAL_EMISOR,
    pkg_parametros.fsbGetValorCadena('RESP_FISCAL_EMISOR') RESP_FISCAL_EMISOR,
    pkg_parametros.fsbGetValorCadena('COD_TRIBUTO_EMISOR') COD_TRIBUTO_EMISOR,
    pkg_parametros.fsbGetValorCadena('NOMBRE_TRIBUTO_EMISOR') NOMBRE_TRIBUTO_EMISOR,
    pkg_parametros.fsbGetValorCadena('EMAIL_EMISOR') EMAIL_EMISOR,
    pkg_parametros.fsbGetValorCadena('EMAIL_CONTROLER_EMISOR') EMAIL_CONTROLER_EMISOR,
    pkg_parametros.fsbGetValorCadena('TELEFONO_EMISOR') TELEFONO_EMISOR,
    pkg_parametros.fsbGetValorCadena('FAX_EMISOR') FAX_EMISOR,
    pkg_parametros.fsbGetValorCadena('RAZON_SOCIAL_EMISOR') RAZON_SOCIAL_EMISOR,
    pkg_parametros.fsbGetValorCadena('DIRECCION_EMISOR') DIRECCION_EMISOR,
    pkg_parametros.fsbGetValorCadena('TIPO_REGIMEN_EMISOR') TIPO_REGIMEN_EMISOR    
    FROM sistema sgdc
    WHERE sistcodi = 99
    AND NOT EXISTS
    (
        SELECT '1'
        FROM empresa
        WHERE codigo = 'GDCA'
    )
    
    UNION ALL
    
    SELECT 'GDGU' CODIGO,
    'GASES DE LA GUAJIRA S.A. E.S.P'    NOMBRE,
    '892115036-6'    NIT,
    'Carrera 15 No.14C-33'    DIRECCION,
    -1          LOCALIDAD, -- Riohacha
    8978  DEPARTAMENTO,
    '' MATRICULA_MERCANTIL,
    '440001' ZONA_POSTAL_EMISOR,
    '' RESP_FISCAL_EMISOR,
    '' COD_TRIBUTO_EMISOR,
    '' NOMBRE_TRIBUTO_EMISOR,
    '' EMAIL_EMISOR,
    '' EMAIL_CONTROLER_EMISOR,
    '' TELEFONO_EMISOR,
    '' FAX_EMISOR,
    '' RAZON_SOCIAL_EMISOR,
    '' DIRECCION_EMISOR,
     pkg_parametros.fsbGetValorCadena('TIPO_REGIMEN_EMISOR') TIPO_REGIMEN_EMISOR    
    FROM DUAL sgdg
    WHERE NOT EXISTS
    (
        SELECT '1'
        FROM empresa
        WHERE codigo = 'GDGU'
    );  
    
    
    rcDatosGdCa cuDatosGdCa%ROWTYPE;
    
BEGIN


    FOR rcDatosGdCa IN cuDatosGdCa LOOP
    
        BEGIN
        
            INSERT INTO MULTIEMPRESA.EMPRESA VALUES rcDatosGdCa;
            
            COMMIT;

            DBMS_OUTPUT.PUT_LINE('INFO:INSERCION EN EMPRESA CODIGO[' || rcDatosGdCa.CODIGO || '][OK]' ); 
            
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR:INSERCION EN EMPRESA CODIGO[' || rcDatosGdCa.CODIGO || '][' || SQLERRM || ']' ); 
                ROLLBACK;
        END;
        
    END LOOP;

END;
/
