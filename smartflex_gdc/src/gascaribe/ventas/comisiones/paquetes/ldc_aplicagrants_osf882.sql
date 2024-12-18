CREATE OR REPLACE PROCEDURE personalizaciones.ldc_aplicagrants_osf882
AS
BEGIN
    EXECUTE IMMEDIATE 'grant select, insert, delete, update on personalizaciones.LDC_APPROVED_REQUESTS to OPEN';
END;
/
begin personalizaciones.ldc_aplicagrants_osf882; end;
/
DROP PROCEDURE personalizaciones.ldc_aplicagrants_osf882;