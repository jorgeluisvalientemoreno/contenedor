DECLARE
  nuExistsTable NUMBER;    
BEGIN

   SELECT COUNT(1) INTO nuExistsTable
   FROM DBA_TABLES
   WHERE table_name = 'ESTAPROC' and owner = 'PERSONALIZACIONES';
   
   
    IF (nuExistsTable <> 0) THEN
        /*Si la tabla ya existe, se informa en consola acerca de su existencia*/
        dbms_output.put_Line('La Tabla ESTAPROC ya existe, se procede a borrar');
        EXECUTE IMMEDIATE 'drop table PERSONALIZACIONES.ESTAPROC';
    END IF;    
    
    EXECUTE IMMEDIATE q'#CREATE TABLE PERSONALIZACIONES.estaproc (
                                    anio                      NUMBER(4) ,     
                                    mes                       NUMBER(2) ,     
                                    proceso                   VARCHAR2(100) , 
                                    estado                    VARCHAR2(100) , 
                                    fecha_inicial_ejec        DATE ,          
                                    fecha_final_ejec          DATE, 
                                    total_registro            NUMBER(15),
                                    regis_procesado           NUMBER(15),         
                                    observacion               VARCHAR2(4000), 
                                    sesion                    NUMBER(20) ,    
                                    usuario_conectado         VARCHAR2(30) )#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.estaproc.anio IS 'AÑO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.estaproc.mes IS 'MES'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.estaproc.proceso IS 'PROCESO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.estaproc.estado IS 'ESTADO DEL PROCESO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.estaproc.fecha_inicial_ejec IS 'FECHA INICIAL DE EJECUCION'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.estaproc.fecha_final_ejec IS 'FECHA FINAL DE EJECUCION'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.estaproc.sesion IS 'SESION'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.estaproc.total_registro IS 'TOTAL REGISTROS'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.estaproc.regis_procesado IS 'REGISTROS PROCESADOS'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.estaproc.observacion IS 'OBSERVACION'#';
    EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.estaproc.usuario_conectado IS 'USUARIO CONECTADO'#';
    EXECUTE IMMEDIATE q'#COMMENT ON TABLE  PERSONALIZACIONES.estaproc IS 'ESTADO DE PROCESOS'#';
   
    BEGIN
      pkg_utilidades.prAplicarPermisos('ESTAPROC', 'PERSONALIZACIONES');
    END;
    
END;
/