CREATE OR REPLACE TRIGGER ADM_PERSON.TGR_IU_ITEMADIC_LDCRIAIC
BEFORE UPDATE OR INSERT ON LDC_ITEMADIC_LDCRIAIC
REFERENCING old AS old new AS new for each row
DECLARE

    sbDescripcionOld LDC_ITEMADIC_LDCRIAIC.descripcion%type;
    sbDescripcionNew LDC_ITEMADIC_LDCRIAIC.descripcion%type;
    nuValorUnitarioOld  LDC_ITEMADIC_LDCRIAIC.valor_unitario%type;
    nuValorUnitarioNew  LDC_ITEMADIC_LDCRIAIC.valor_unitario%type;
    nuCantidadOld LDC_ITEMADIC_LDCRIAIC.cantidad%type;
    nuCantidadNew LDC_ITEMADIC_LDCRIAIC.cantidad%type;
    sbUser LDC_ITEMADIC_LOG.USER_%type;
    sbTerminal LDC_ITEMADIC_LOG.TERMINAL%type;
    nuCodigo LDC_ITEMADIC_LDCRIAIC.codigo%type;
    nuSecuencia LDC_ITEMADIC_LDCRIAIC.secuencia%type;
    nuOrder ldc_itemcoti_ldcriaic.order_id%type;
    nuCotizacion ldc_itemcoti_ldcriaic.cotizacion_id%type;
    nuItemCotizado ldc_itemcoti_ldcriaic.item_cotizado%type;

    cursor curitemcotizados(inucodigo number)
    is
        select order_id,cotizacion_id,item_cotizado
        from ldc_itemcoti_ldcriaic
        where ldc_itemcoti_ldcriaic.codigo = inucodigo;

BEGIN

    sbDescripcionOld := :old.descripcion;
    sbDescripcionNew := :new.descripcion;
    nuValorUnitarioOld := :old.valor_unitario;
    nuValorUnitarioNew := :new.valor_unitario;
    nuCantidadOld := :old.cantidad;
    nuCantidadNew := :new.cantidad;
    nuCodigo := :new.codigo;
    nuSecuencia := :new.secuencia;

    select user
    into sbUser
    from dual;

    select SYS_CONTEXT('USERENV','TERMINAL')
    into sbTerminal
    from dual;

    open curitemcotizados(nuCodigo);
    fetch curitemcotizados
    into nuOrder,nuCotizacion,nuItemCotizado;
    close curitemcotizados;

    INSERT INTO LDC_ITEMADIC_LOG(ITEMCOTI_ID,ORDER_ID,COTIZACION_ID,ITEM_COTIZADO,DESCRIPCION_OLD,DESCRIPCION_NEW,
                                VALOR_UNITARIO_OLD,VALOR_UNITARIO_NEW,CANTIDAD_OLD,CANTIDAD_NEW,FECHA_REGISTRO,USER_,TERMINAL)
    VALUES(SEQ_LDC_ITEMADIC_LDCRIAIC_LOG.NEXTVAL,nuOrder,nuCotizacion,nuItemCotizado,sbDescripcionOld,sbDescripcionNew,nuValorUnitarioOld,nuValorUnitarioNew,nuCantidadOld,nuCantidadNew,
            ut_date.fdtsysdate,sbUser,sbTerminal);


EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

end;
/
