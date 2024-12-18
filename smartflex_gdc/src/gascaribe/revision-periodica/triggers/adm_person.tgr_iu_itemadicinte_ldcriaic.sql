CREATE OR REPLACE TRIGGER ADM_PERSON.TGR_IU_ITEMADICINTE_LDCRIAIC
BEFORE UPDATE OR INSERT ON LDC_ITEMADICINTE_LDCRIAIC
REFERENCING old AS old new AS new for each row
DECLARE

    sbDescripcionOld LDC_ITEMADICINTE_LDCRIAIC.descripcion%type;
    sbDescripcionNew LDC_ITEMADICINTE_LDCRIAIC.descripcion%type;
    nuValorUnitarioOld  LDC_ITEMADICINTE_LDCRIAIC.valor_unitario%type;
    nuValorUnitarioNew  LDC_ITEMADICINTE_LDCRIAIC.valor_unitario%type;
    nuCantidadOld LDC_ITEMADICINTE_LDCRIAIC.cantidad%type;
    nuCantidadNew LDC_ITEMADICINTE_LDCRIAIC.cantidad%type;
    sbUser LDC_ITEMADICINTE_LOG.USER_%type;
    sbTerminal LDC_ITEMADICINTE_LOG.TERMINAL%type;
    nuCodigo LDC_ITEMADICINTE_LDCRIAIC.codigo%type;
    nuSecuencia LDC_ITEMADICINTE_LDCRIAIC.secuencia%type;
    nuOrder ldc_itemcotiinte_ldcriaic.order_id%type;
    nuCotizacion ldc_itemcotiinte_ldcriaic.cotizacion_id%type;
    nuItemCotizado ldc_itemcotiinte_ldcriaic.item_cotizado%type;

    cursor curitemcotizados(inucodigo number)
    is
        select order_id,cotizacion_id,item_cotizado
        from ldc_itemcotiinte_ldcriaic
        where ldc_itemcotiinte_ldcriaic.codigo = inucodigo;

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

    INSERT INTO LDC_ITEMADICINTE_LOG(ITEMADICINTE_LOG_ID,ORDER_ID,COTIZACION_ID,ITEM_COTIZADO,DESCRIPCION_OLD,DESCRIPCION_NEW,
            VALOR_UNITARIO_OLD,VALOR_UNITARIO_NEW,CANTIDAD_OLD,CANTIDAD_NEW,FECHA_REGISTRO,USER_,TERMINAL)
    VALUES(SEQ_LDC_ITEMADICINTE_LOG.NEXTVAL,nuOrder,nuCotizacion,nuItemCotizado,sbDescripcionOld,sbDescripcionNew,nuValorUnitarioOld,nuValorUnitarioNew,nuCantidadOld,nuCantidadNew,
            ut_date.fdtsysdate,sbUser,sbTerminal);


EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

end;
/
