CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRGUPDTLDCUSUCARTESP before update on LDC_USUCARTERAESP REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
/*
    Propiedad intelectual de Gases del Caribe. (c).

    Trigger     : ldcTrgupdtldcusucartesp

    Descripcion : Define segun parametrizacion si notifica o no al usuario en el reporte (setea campo NOTIFICA)


    Parametros  :

    Retorno     :

    Autor       : HORBATH TECHNOLOGIES.
    Fecha       : 22-11-2018

    Historia de Modificaciones
    Fecha          IDEntrega
    16-11-2018     200-2241 Creacion
    19-01-2019     MODIFICACION PARA MANEJAR CAMBIO DE CAMPOS ESPECIFICOS DEFINIDOS POR EL USUARIO
    Modificacion
*/
declare
    nuErrCode           number;
    SBERRMSG            GE_ERROR_LOG.DESCRIPTION%TYPE;
    veri                ld_parameter.value_chain%type;
    cursor campos is select * from ldccamposvericart;
    flag number;
    nuCambio NUMBER := 0;

BEGIN
--{
    pkErrors.Push('ldcTrgupdtldcusucartesp ');
    VERI := dald_parameter.fsbGetValue_Chain('PARVERICUALQ',null);
    IF VERI='S' AND
       (:NEW.DIRECCION               <> :OLD.DIRECCION OR
        :NEW.CARTERA_FECHA           <> :OLD.CARTERA_FECHA OR
        :NEW.EDAD_MORA               <> :OLD.EDAD_MORA OR
        :NEW.NO_FACTURAS_DEUDA       <> :OLD.NO_FACTURAS_DEUDA OR
        :NEW.VALOR_CONSUMO           <> :OLD.VALOR_CONSUMO OR
        :NEW.M3_DEUDA                <> :OLD.M3_DEUDA OR
        :NEW.CONSUMO_PROMEDIO_M3     <> :OLD.CONSUMO_PROMEDIO_M3 OR
        :NEW.VALOR_PROMEDIO_FACTURA  <> :OLD.VALOR_PROMEDIO_FACTURA OR
        :NEW.FECH_VENC_ULT_FACT      <> :OLD.FECH_VENC_ULT_FACT OR
        :NEW.VECES_MORA_ANO          <> :OLD.VECES_MORA_ANO OR
        :NEW.ESTADO_PRODUCTO         <> :OLD.ESTADO_PRODUCTO OR
        :NEW.FECHA_SUSPENSION        <> :OLD.FECHA_SUSPENSION OR
        :NEW.HACE_SUSPENDIDO         <> :OLD.HACE_SUSPENDIDO OR
        :NEW.VIOLA_SERVICIO          <> :OLD.VIOLA_SERVICIO OR
        :NEW.VALOR_RECLAMO           <> :OLD.VALOR_RECLAMO OR
        :NEW.FECHA_RECLAMO           <> :OLD.FECHA_RECLAMO OR
        :NEW.DETALLE_RECLAMO         <> :OLD.DETALLE_RECLAMO OR
        :NEW.PROMEDIO_PAGOS          <> :OLD.PROMEDIO_PAGOS OR
        :NEW.FECHA_PAGO              <> :OLD.FECHA_PAGO OR
        :NEW.DIAS_PAGO_FACTURA       <> :OLD.DIAS_PAGO_FACTURA OR
        :NEW.REFINANCIACION_ACTIVA   <> :OLD.REFINANCIACION_ACTIVA OR
        :NEW.FECHA_REFINANCIACION    <> :OLD.FECHA_REFINANCIACION ) then
       insert into ldc_notificacartesp values(:new.codigo_producto);
       nuCambio := 1;
    else

       flag:=0;
       for c in campos loop
           if c.verifica=1 and c.descripcion = 'DIRECCION' and :NEW.DIRECCION <> :OLD.DIRECCION  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'CARTERA_FECHA' and :NEW.CARTERA_FECHA <> :OLD.CARTERA_FECHA  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'EDAD_MORA' and :NEW.EDAD_MORA <> :OLD.EDAD_MORA  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'NO_FACTURAS_DEUDA' and :NEW.NO_FACTURAS_DEUDA <> :OLD.NO_FACTURAS_DEUDA  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'VALOR_CONSUMO' and :NEW.VALOR_CONSUMO <> :OLD.VALOR_CONSUMO  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'M3_DEUDA' and :NEW.M3_DEUDA <> :OLD.M3_DEUDA  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'CONSUMO_PROMEDIO_M3' and :NEW.CONSUMO_PROMEDIO_M3 <> :OLD.CONSUMO_PROMEDIO_M3  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'VALOR_PROMEDIO_FACTURA' and :NEW.VALOR_PROMEDIO_FACTURA <> :OLD.VALOR_PROMEDIO_FACTURA  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'FECH_VENC_ULT_FACT' and :NEW.FECH_VENC_ULT_FACT <> :OLD.FECH_VENC_ULT_FACT  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'VECES_MORA_ANO' and :NEW.VECES_MORA_ANO <> :OLD.VECES_MORA_ANO  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'ESTADO_PRODUCTO' and :NEW.ESTADO_PRODUCTO <> :OLD.ESTADO_PRODUCTO  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'FECHA_SUSPENSION' and :NEW.FECHA_SUSPENSION <> :OLD.FECHA_SUSPENSION  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'HACE_CUANTO_SUSPENDIDO' and :NEW.HACE_SUSPENDIDO <> :OLD.HACE_SUSPENDIDO  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'VIOLA_SERVICIO' and :NEW.VIOLA_SERVICIO <> :OLD.VIOLA_SERVICIO  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'VALOR_RECLAMO' and :NEW.VALOR_RECLAMO <> :OLD.VALOR_RECLAMO  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'FECHA_RECLAMO' and :NEW.FECHA_RECLAMO <> :OLD.FECHA_RECLAMO  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'DETALLE_RECLAMO' and :NEW.DETALLE_RECLAMO <> :OLD.DETALLE_RECLAMO  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'PROMEDIO_PAGOS' and :NEW.PROMEDIO_PAGOS <> :OLD.PROMEDIO_PAGOS  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'FECHA_PAGO' and :NEW.FECHA_PAGO <> :OLD.FECHA_PAGO  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'DIAS_PAGO_FACTURA' and :NEW.DIAS_PAGO_FACTURA <> :OLD.DIAS_PAGO_FACTURA  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'REFINANCIACION_ACTIVA' and :NEW.REFINANCIACION_ACTIVA <> :OLD.REFINANCIACION_ACTIVA  then
              flag:=1;
           end if;

           if c.verifica=1 and c.descripcion = 'FECHA_REFINANCIACION' and :NEW.FECHA_REFINANCIACION <> :OLD.FECHA_REFINANCIACION  then
              flag:=1;
           end if;

       end loop;
       IF FLAG=1 THEN
          insert into ldc_notificacartesp values(:new.codigo_producto);
         nuCambio :=1;
       END IF;

    END IF;

    IF nuCambio = 1 THEN
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
    END IF;
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

end;
/
