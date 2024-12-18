DECLARE

    csbObjeto        CONSTANT VARCHAR2(70) :=   'LDC_METAS_CONT_GESTCOBR';
    csbEsquema       CONSTANT VARCHAR2(30) :=   'OPEN';
    csbTipoObjeto    CONSTANT VARCHAR2(30) :=   'TABLE';
        
    CURSOR cuDBA_Objects
    IS
    SELECT *
    FROM DBA_Objects
    WHERE owner = UPPER(csbEsquema) 
    AND object_name = UPPER(csbObjeto)
    AND object_type = UPPER(csbTipoObjeto)
    AND object_type IN ( 'PACKAGE','PROCEDURE','FUNCTION','TRIGGER', 'TABLE');   

    TYPE tyDBA_Objects IS TABLE OF cuDBA_Objects%ROWTYPE INDEX BY BINARY_INTEGER;
    tbDBA_Objects tyDBA_Objects;

    sbComando   VARCHAR2(4000);
            
    PROCEDURE prcExeImm( isbSent VARCHAR2)
    IS
    BEGIN

        EXECUTE IMMEDIATE isbSent;
        dbms_output.put_line('Ok Sentencia[' || isbSent || ']');
                
        EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('Error Sentencia[' || isbSent || '][' || sqlerrm || ']');
    END prcExeImm;
    
BEGIN

    OPEN cuDBA_Objects;
    FETCH cuDBA_Objects BULK COLLECT INTO tbDBA_Objects;
    CLOSE cuDBA_Objects;
    
    IF tbDBA_Objects.COUNT = 0 THEN

        sbComando := 'create table ' || csbEsquema || '.' || csbObjeto || '
        (
          ano                      NUMBER(4) not null,
          mes                      NUMBER(2) not null,
          unidad_operativa         NUMBER(15) not null,
          cant_usuarios_entregados NUMBER(10) not null,
          deuda_entregada          NUMBER(18,2) not null,
          meta_usuarios            NUMBER(10) not null,
          meta_minima              NUMBER(10) not null,
          porc_part_memin_meta     NUMBER(10,5) not null,
          meta_deuda               NUMBER(18,2) not null,
          usuarios_recuperados     NUMBER(10) not null,
          deuda_normalizada        NUMBER(18,2) not null,
          porc_cumpl_usua          NUMBER(10,5) not null,
          porc_cumpl_dinero        NUMBER(10,5) not null,
          total_recaudado          NUMBER(18,2) not null,
          fecha_registro           DATE not null,
          usuario                  VARCHAR2(100) not null,
          porc_met_usu             NUMBER(12,2),
          porc_met_cart            NUMBER(12,2),
          tarifa_usuario           NUMBER(18,2),
          tarifa_cartera           NUMBER(18,2),
          preliq_usu               NUMBER(18,2),
          preliq_cart              NUMBER(18,2),
          preliq_total             NUMBER(18,2),
          grupo                    NUMBER(15),
          grupo_categoria          NUMBER(10)
        )
        tablespace TSD_DEFAULT
          pctfree 10
          initrans 1
          maxtrans 255
          storage
          (
            initial 2M
            next 2M
            minextents 1
            maxextents unlimited
            pctincrease 0
          )';
         
        prcExeImm( sbComando );

        DBMS_OUTPUT.PUT_LINE( 'INFO: Se creo ' || csbTipoObjeto || ' ' || csbEsquema || '.' || csbObjeto );
        
    ELSE
            
        DBMS_OUTPUT.PUT_LINE( 'INFO: Ya existe ' || csbTipoObjeto || ' ' || csbEsquema || '.' || csbObjeto );
    
    END IF;
  
END;
/
-- Add comments to the table 
comment on table OPEN.LDC_METAS_CONT_GESTCOBR
  is 'META POR UNIDAD OPERATIVA DE CARTERA GESTION DE COBRO';
-- Add comments to the columns 
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.ano
  is 'A??o';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.mes
  is 'Mes';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.unidad_operativa
  is 'Unidad operativa';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.cant_usuarios_entregados
  is 'Cartera entregada en nro de usuarios';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.deuda_entregada
  is 'Cartera entregada en dinero';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.meta_usuarios
  is 'Meta en usuarios';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.meta_minima
  is '% participacion meta minima';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.meta_deuda
  is 'Meta en dinero';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.usuarios_recuperados
  is 'Usuarios recuperados';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.deuda_normalizada
  is 'Deuda normalizada';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.porc_cumpl_usua
  is '% de cumplimiento en usuarios';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.porc_cumpl_dinero
  is '% de cumplimiento en dinero';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.total_recaudado
  is 'Total recaudado';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.fecha_registro
  is 'Fecha registro';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.usuario
  is 'Usuario registro';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.porc_met_usu
  is 'PORCENTAJE A RECUPERAR POR USUARIO';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.porc_met_cart
  is 'PORCENTAJE A RECUPERAR POR CARTERA';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.tarifa_usuario
  is 'TARIFA A PAGAR POR USUARIO RECUPERADO';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.tarifa_cartera
  is 'PORCENTAJE A PAGAR POR CARTERA RECUPERADA';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.preliq_usu
  is 'PRELIQUIDACION POR USUARIOS RECUPERADOS';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.preliq_cart
  is 'PRELIQUIDACION POR CARTERA RECUPERADA';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.preliq_total
  is 'TOTAL PRELIQUIDACION';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.grupo
  is 'GRUPO POR TIPO DE PRODUCTO';
comment on column OPEN.LDC_METAS_CONT_GESTCOBR.grupo_categoria
  is 'GRUPO CATEGORIA DE LIQUIDACION';
-- Grant/Revoke object privileges 
grant select on OPEN.LDC_METAS_CONT_GESTCOBR to REPORTES;
grant select on OPEN.LDC_METAS_CONT_GESTCOBR to ROLESELOPEN;
grant select on OPEN.LDC_METAS_CONT_GESTCOBR to RSELOPEN;
grant select on OPEN.LDC_METAS_CONT_GESTCOBR to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_METAS_CONT_GESTCOBR to SYSTEM_OBJ_PRIVS_ROLE;

Prompt Agregando la columna ldc_metas_cont_gestcobr.cantidad_contratos
DECLARE

    -- OSF-3578

    csbTabla        CONSTANT VARCHAR2(70) :=   upper('ldc_metas_cont_gestcobr');
    csbEsquema       CONSTANT VARCHAR2(30) :=   'OPEN';
    csbTipoObjeto    CONSTANT VARCHAR2(30) :=   'TABLE';
    csbColumna       CONSTANT VARCHAR2(30) :=   upper('cantidad_contratos');
              
    nuError          NUMBER;
    sbError          VARCHAR2(4000);
    
    CURSOR cuDBA_Tab_Columns
    IS
    SELECT *
    FROM DBA_TAB_COLUMNS
    WHERE owner = UPPER(csbEsquema) 
    AND table_name = UPPER(csbTabla)
    AND column_name = csbColumna;   

    TYPE tyDBA_Tab_Columns IS TABLE OF cuDBA_Tab_Columns%ROWTYPE INDEX BY BINARY_INTEGER;
    tbDBA_TAB_COLUMNS tyDBA_Tab_Columns;
    
    sbComando   VARCHAR2(4000);
    
    PROCEDURE prcExeImm( isbSent VARCHAR2)
    IS
    BEGIN

        EXECUTE IMMEDIATE isbSent;
        dbms_output.put_line('Ok Sentencia[' || isbSent || ']');
                
        EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('Error Sentencia[' || isbSent || '][' || sqlerrm || ']');
    END prcExeImm;

begin


    OPEN cuDBA_Tab_Columns;
    FETCH cuDBA_Tab_Columns BULK COLLECT INTO tbDBA_TAB_COLUMNS;
    CLOSE cuDBA_Tab_Columns;

    IF tbDBA_TAB_COLUMNS.COUNT > 0 THEN

        dbms_output.put_line('Ya existe la columna [' || csbEsquema || '.' || csbTabla ||  '.' || csbColumna || ']'); 
        
    ELSE
    
        sbComando := 'ALTER TABLE ' || csbEsquema || '.' || csbTabla || ' ';
        sbComando := sbComando || 'ADD ' || csbColumna  || ' NUMBER(8)';
        
        prcExeImm( sbComando );

        dbms_output.put_line('Ok Creada ' || csbTipoObjeto || '  [' || csbEsquema || '.' || csbTabla ||  '.' || csbColumna || ']'); 

        sbComando := 'COMMENT ON COLUMN ' || csbEsquema || '.' || csbTabla || '.' || csbColumna || ' IS ';
        sbComando := sbComando ||  '''' || 'Cantidad de Contratos'  || '''';
        
        prcExeImm( sbComando );

        dbms_output.put_line('Ok Creado comentario columna [' || csbEsquema || '.' || csbTabla ||  '.' || csbColumna || ']'); 

        
    END IF;
    
    
    EXCEPTION
        WHEN OTHERS THEN        
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            dbms_output.put_line('sbError => ' || sbError );
            RAISE pkg_error.Controlled_Error;
END;
/