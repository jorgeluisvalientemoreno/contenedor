declare
    nuExiste NUMBER;
begin
    SELECT COUNT(1) 
      INTO nuExiste
      FROM DBA_TABLES 
     WHERE OWNER='PERSONALIZACIONES' 
       AND TABLE_NAME='OBJETOS_PRODUCTO';
    IF NUEXISTE = 0 THEN
        EXECUTE IMMEDIATE q'#CREATE TABLE PERSONALIZACIONES.OBJETOS_PRODUCTO (
                                   nombre VARCHAR2(500),
                                   tipo   VARCHAR2(100))#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.OBJETOS_PRODUCTO.nombre IS 'NOMBRE OBJETO'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.OBJETOS_PRODUCTO.tipo IS 'TIPO OBJETO'#';
    
    END IF;
    BEGIN
      pkg_utilidades.prAplicarPermisos('OBJETOS_PRODUCTO', 'PERSONALIZACIONES');
    END;
    
end;
/