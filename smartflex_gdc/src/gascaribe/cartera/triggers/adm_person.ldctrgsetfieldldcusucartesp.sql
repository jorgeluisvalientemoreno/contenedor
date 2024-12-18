CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRGSETFIELDLDCUSUCARTESP before INSERT ON LDC_USUCARTERAESP REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
/*
    Propiedad intelectual de Gases del Caribe. (c).

    Trigger     : ldcTrgSetfieldldcusucartesp

    Descripcion : Setea los campos de la tabla que no son editables por la forma


    Parametros  :       Descripcion

    Retorno     :

    Autor       : HORBATH TECHNOLOGIES.
    Fecha       : 16-11-2018

    Historia de Modificaciones
    Fecha          IDEntrega
    16-11-2018     200-2241 Creacion

    Modificacion
*/
DECLARE
    nuErrCode           number;
    SBERRMSG            GE_ERROR_LOG.DESCRIPTION%TYPE;
BEGIN
--{
    pkErrors.Push('ldcTrgSetfieldldcusucartesp');

    -- Si el campo consecutivo o llave viene en not null, entonces se asignan valores del paquete
    if ( :new.consecutivo is not null ) then
    --{
        :new.DIRECCION                      := LDC_PKCALCDATCARTESP.FNC_DIRECCION(:NEW.CODIGO_PRODUCTO);
        :new.CARTERA_FECHA                  := LDC_PKCALCDATCARTESP.FNC_CARTERA_FECHA(:NEW.CODIGO_PRODUCTO);
        :new.EDAD_MORA                      := LDC_PKCALCDATCARTESP.FNC_EDAD_MORA(:NEW.CODIGO_PRODUCTO);
        :new.NO_FACTURAS_DEUDA              := LDC_PKCALCDATCARTESP.FNC_NO_FACTURAS_DEUDA(:NEW.CODIGO_PRODUCTO);
        :new.VALOR_CONSUMO                  := LDC_PKCALCDATCARTESP.FNC_VALOR_CONSUMO(:NEW.CODIGO_PRODUCTO);
        :new.M3_DEUDA                       := LDC_PKCALCDATCARTESP.FNC_M3_DEUDA(:NEW.CODIGO_PRODUCTO);
        :new.CONSUMO_PROMEDIO_M3            := LDC_PKCALCDATCARTESP.FNC_CONSUMO_PROMEDIO_M3(:NEW.CODIGO_PRODUCTO);
        :new.VALOR_PROMEDIO_FACTURA         := LDC_PKCALCDATCARTESP.FNC_VALOR_PROMEDIO_FACTURA(:NEW.CODIGO_PRODUCTO);
        :new.FECH_VENC_ULT_FACT             := LDC_PKCALCDATCARTESP.FNC_FECH_VENC_ULT_FACT(:NEW.CODIGO_PRODUCTO);
        :new.VECES_MORA_ANO                 := LDC_PKCALCDATCARTESP.FNC_VECES_MORA_ANO(:NEW.CODIGO_PRODUCTO);
        :new.ESTADO_PRODUCTO                := LDC_PKCALCDATCARTESP.FNC_ESTADO_PRODUCTO(:NEW.CODIGO_PRODUCTO);
        :new.FECHA_SUSPENSION               := LDC_PKCALCDATCARTESP.FNC_FECHA_SUSPENSION(:NEW.CODIGO_PRODUCTO);
        :new.HACE_SUSPENDIDO                := LDC_PKCALCDATCARTESP.FNC_HACE_SUSPENDIDO(:NEW.CODIGO_PRODUCTO);
        :new.VIOLA_SERVICIO                 := LDC_PKCALCDATCARTESP.FNC_VIOLA_SERVICIO(:NEW.CODIGO_PRODUCTO);
        :new.VALOR_RECLAMO                  := LDC_PKCALCDATCARTESP.FNC_VALOR_RECLAMO(:NEW.CODIGO_PRODUCTO);
        :new.FECHA_RECLAMO                  := LDC_PKCALCDATCARTESP.FNC_FECHA_RECLAMO(:NEW.CODIGO_PRODUCTO);
        :new.DETALLE_RECLAMO                := LDC_PKCALCDATCARTESP.FNC_DETALLE_RECLAMO(:NEW.CODIGO_PRODUCTO);
        :new.PROMEDIO_PAGOS                 := LDC_PKCALCDATCARTESP.FNC_PROMEDIO_PAGOS(:NEW.CODIGO_PRODUCTO);
        :new.FECHA_PAGO                     := LDC_PKCALCDATCARTESP.FNC_FECHA_PAGO(:NEW.CODIGO_PRODUCTO);
        :new.DIAS_PAGO_FACTURA              := LDC_PKCALCDATCARTESP.FNC_DIAS_PAGO_FACTURA(:NEW.CODIGO_PRODUCTO);
        :new.REFINANCIACION_ACTIVA          := LDC_PKCALCDATCARTESP.FNC_REFINANCIACION_ACTIVA(:NEW.CODIGO_PRODUCTO);
        :new.FECHA_REFINANCIACION           := LDC_PKCALCDATCARTESP.FNC_FECHA_REFINANCIACION(:NEW.CODIGO_PRODUCTO);
        :new.NOTIFICA                       := 'N';
        INSERT INTO LDC_USUCARTERAESPLOG
          (
            CONSECUTIVO,
            CODIGO_PRODUCTO,
            TIPO_NEGOCIO,
            PROPIETARIO_PROPIETARIO,
            HISTORIA_NEGOCIO,
            ALIAS,
            DIRECCION,
            CARTERA_FECHA,
            EDAD_MORA,
            NO_FACTURAS_DEUDA,
            VALOR_CONSUMO,
            M3_DEUDA,
            CONSUMO_PROMEDIO_M3,
            VALOR_PROMEDIO_FACTURA,
            FECH_VENC_ULT_FACT,
            VECES_MORA_ANO,
            ESTADO_PRODUCTO,
            FECHA_SUSPENSION,
            HACE_SUSPENDIDO,
            VIOLA_SERVICIO,
            VALOR_RECLAMO,
            FECHA_RECLAMO,
            DETALLE_RECLAMO,
            PROMEDIO_PAGOS,
            FECHA_PAGO,
            DIAS_PAGO_FACTURA,
            REFINANCIACION_ACTIVA,
            FECHA_REFINANCIACION,
            PROCESO_ESTADO,
            NOTIFICA,
            FECHA_REGISTRO
          )
          VALUES
          (
            :new.CONSECUTIVO,
            :new.CODIGO_PRODUCTO,
            :new.TIPO_NEGOCIO,
            :new.PROPIETARIO_PROPIETARIO,
            :new.HISTORIA_NEGOCIO,
            :new.ALIAS,
            :new.DIRECCION,
            :new.CARTERA_FECHA,
            :new.EDAD_MORA,
            :new.NO_FACTURAS_DEUDA,
            :new.VALOR_CONSUMO,
            :new.M3_DEUDA,
            :new.CONSUMO_PROMEDIO_M3,
            :new.VALOR_PROMEDIO_FACTURA,
            :new.FECH_VENC_ULT_FACT,
            :new.VECES_MORA_ANO,
            :new.ESTADO_PRODUCTO,
            :new.FECHA_SUSPENSION,
            :new.HACE_SUSPENDIDO,
            :new.VIOLA_SERVICIO,
            :new.VALOR_RECLAMO,
            :new.FECHA_RECLAMO,
            :new.DETALLE_RECLAMO,
            :new.PROMEDIO_PAGOS,
            :new.FECHA_PAGO,
            :new.DIAS_PAGO_FACTURA,
            :new.REFINANCIACION_ACTIVA,
            :new.FECHA_REFINANCIACION,
            :new.PROCESO_ESTADO,
           :new.NOTIFICA,
            SYSDATE
          );
    --}
    END if;

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
        pkErrors.GetErrorVar( nuErrCode, sbErrMsg );
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
End;
/
