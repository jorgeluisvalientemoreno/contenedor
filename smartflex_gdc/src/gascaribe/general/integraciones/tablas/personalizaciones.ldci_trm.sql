/*
 *
 * Script  : LDCI_TRM.sql
 * Autor   : Jose Donado
 * Fecha   : 13/11/2024
 * Descripcion : Realiza la instalacion
 *
 * Historia de Modificaciones
 * Autor          Fecha  Descripcion
**/
--------------------------------------------------------
-- Create table
--------------------------------------------------------
declare

    nuExiste number;
begin

    select count(1)
      into nuExiste
      from dba_tables 
      where table_name='LDCI_TRM'
        and owner='PERSONALIZACIONES';

    if nuExiste = 0 then
        EXECUTE IMMEDIATE '  CREATE TABLE PERSONALIZACIONES.LDCI_TRM
                                                           (DIA_TRM DATE, 
                                                           CODIGO NUMBER(15), 
                                                           UNIDAD VARCHAR2(20),
                                                           FECHA_DESDE DATE,
                                                           FECHA_HASTA DATE, 
                                                           VALOR_TRM NUMBER(18,2),
                                                           EXITO VARCHAR2(10),
                                                           XMLTRM CLOB,
                                                           FECHA_REGISTRO DATE
                                                           ) 
                           tablespace TSD_BASICA
                            pctfree 5
                            initrans 2
                            maxtrans 255
                            storage
                            (
                                initial 20M
                                next 20M
                                minextents 1
                                maxextents unlimited
                                pctincrease 0
                            )';
        EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LDCI_TRM_00 ON PERSONALIZACIONES.LDCI_TRM(DIA_TRM) tablespace TSI_BASICA';
        EXECUTE IMMEDIATE 'alter table PERSONALIZACIONES.LDCI_TRM add constraint PK_LDCI_TRM primary key (DIA_TRM)';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.LDCI_TRM.DIA_TRM  IS 'DIA DE LA TRM'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.LDCI_TRM.CODIGO  IS 'ID DE REGISTRO DE TRANSACCION'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.LDCI_TRM.UNIDAD   IS 'UNIDAD'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.LDCI_TRM.FECHA_DESDE   IS 'FECHA INICIO DE VALIDEZ'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.LDCI_TRM.FECHA_HASTA   IS 'FECHA FIN DE VALIDEZ'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.LDCI_TRM.VALOR_TRM   IS 'VALOR DE LA TRM'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.LDCI_TRM.EXITO   IS 'ESTADO DE EXITOSO O FALLIDO'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.LDCI_TRM.XMLTRM   IS 'XML DE LA TRANSACCION'#';
        EXECUTE IMMEDIATE q'#COMMENT ON COLUMN PERSONALIZACIONES.LDCI_TRM.FECHA_REGISTRO   IS 'FECHA DE REGISTRO'#';
        EXECUTE IMMEDIATE q'#COMMENT ON TABLE  PERSONALIZACIONES.LDCI_TRM           IS 'TRM DE LA SUPERFINANCIERA'#';
        
        dbms_output.put_line('Creacion de la tabla PERSONALIZACIONES.LDCI_TRM Ok.');

        BEGIN
            pkg_utilidades.praplicarpermisos('LDCI_TRM', 'PERSONALIZACIONES');
            dbms_output.put_line('Permisos de la tabla PERSONALIZACIONES.LDCI_TRM Ok.');
        END;
    end if;
END;
/
