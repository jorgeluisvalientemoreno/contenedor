DECLARE
   nuConta NUMBER;
BEGIN

    SELECT COUNT(*) INTO nuConta
    FROM dba_tables
    WHERE table_name = 'TMP_GENERICA' 
      AND owner = 'PERSONALIZACIONES';

    IF nuConta = 0 THEN

        EXECUTE IMMEDIATE  'CREATE GLOBAL TEMPORARY TABLE personalizaciones.TMP_GENERICA 
                            (
                                nuDato_01       NUMBER,
                                nuDato_02       NUMBER,
                                nuDato_03       NUMBER,
                                nuDato_04       NUMBER,
                                nuDato_05       NUMBER,
                                nuDato_06       NUMBER,
                                nuDato_07       NUMBER,
                                nuDato_08       NUMBER,
                                nuDato_09       NUMBER,
                                nuDato_10       NUMBER,
                                sbDato_01       VARCHAR(4000),
                                sbDato_02       VARCHAR(4000),
                                sbDato_03       VARCHAR(4000),
                                sbDato_04       VARCHAR(4000),
                                sbDato_05       VARCHAR(4000),
                                sbDato_06       VARCHAR(4000),
                                sbDato_07       VARCHAR(4000),
                                sbDato_08       VARCHAR(4000),
                                sbDato_09       VARCHAR(4000),
                                sbDato_10       VARCHAR(4000),
                                dtDato_01       DATE,
                                dtDato_02       DATE,
                                dtDato_03       DATE,
                                dtDato_04       DATE,
                                dtDato_05       DATE,
                                dtDato_06       DATE,
                                dtDato_07       DATE,
                                dtDato_08       DATE,
                                dtDato_09       DATE,
                                dtDato_10       DATE,
                                FechaSys        DATE
                            )
                            ON COMMIT PRESERVE ROWS';

        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.nuDato_01 IS 'Cualquier valor de tipo Numerico'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.nuDato_02 IS 'Cualquier valor de tipo Numerico'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.nuDato_03 IS 'Cualquier valor de tipo Numerico'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.nuDato_04 IS 'Cualquier valor de tipo Numerico'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.nuDato_05 IS 'Cualquier valor de tipo Numerico'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.nuDato_06 IS 'Cualquier valor de tipo Numerico'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.nuDato_07 IS 'Cualquier valor de tipo Numerico'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.nuDato_08 IS 'Cualquier valor de tipo Numerico'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.nuDato_09 IS 'Cualquier valor de tipo Numerico'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.nuDato_10 IS 'Cualquier valor de tipo Numerico'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.sbDato_01 IS 'Cualquier valor de tipo Varchar'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.sbDato_02 IS 'Cualquier valor de tipo Varchar'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.sbDato_03 IS 'Cualquier valor de tipo Varchar'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.sbDato_04 IS 'Cualquier valor de tipo Varchar'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.sbDato_05 IS 'Cualquier valor de tipo Varchar'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.sbDato_06 IS 'Cualquier valor de tipo Varchar'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.sbDato_07 IS 'Cualquier valor de tipo Varchar'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.sbDato_08 IS 'Cualquier valor de tipo Varchar'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.sbDato_09 IS 'Cualquier valor de tipo Varchar'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.sbDato_10 IS 'Cualquier valor de tipo Varchar'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.dtDato_01 IS 'Cualquier valor de tipo Fecha'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.dtDato_02 IS 'Cualquier valor de tipo Fecha'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.dtDato_03 IS 'Cualquier valor de tipo Fecha'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.dtDato_04 IS 'Cualquier valor de tipo Fecha'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.dtDato_05 IS 'Cualquier valor de tipo Fecha'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.dtDato_06 IS 'Cualquier valor de tipo Fecha'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.dtDato_07 IS 'Cualquier valor de tipo Fecha'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.dtDato_08 IS 'Cualquier valor de tipo Fecha'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.dtDato_09 IS 'Cualquier valor de tipo Fecha'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.dtDato_10 IS 'Cualquier valor de tipo Fecha'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN personalizaciones.TMP_GENERICA.FechaSys IS 'Fecha de insercion del registro'#';        
        EXECUTE IMMEDIATE q'#COMMENT ON TABLE  personalizaciones.TMP_GENERICA IS 'DATOS TEMPORALES USADOS DENTRO DE UN PROGRAMA PL, POR EJEMPLO LOS DATOS DE UNA TABLA PL PARA USARSE LUEGO EN UN CURSOR REF'#';
          
        BEGIN
            pkg_utilidades.prAplicarPermisos('TMP_GENERICA', 'PERSONALIZACIONES');
        END;
    
    END IF;
END;
/