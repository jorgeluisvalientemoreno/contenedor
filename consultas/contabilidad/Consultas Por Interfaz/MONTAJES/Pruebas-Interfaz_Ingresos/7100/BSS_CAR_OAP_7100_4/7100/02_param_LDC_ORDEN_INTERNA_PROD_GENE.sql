DECLARE

    csbNitGDO   sistema.sistnitc%type := '800167643-5';
    nuCont      NUMBER := 0;
    sbNit       sistema.sistnitc%type;
    sbValor     ld_parameter.value_chain%type;

BEGIN

    sbNit   := pktblsistema.fsbgetsistnitc(99);
    
    if sbNit is not null then
        if sbNit = csbNitGDO then
            sbValor := sbNit;
        else
           sbValor := null;
        end if;
    end if;

    begin
        SELECT COUNT(1)
        INTO nuCont
        FROM ld_parameter
        WHERE parameter_id = 'LDC_ORDEN_INTERNA_PROD_GENE';

        IF(nuCont = 0) THEN
           INSERT INTO ld_parameter (parameter_id,value_chain,description) VALUES ('LDC_ORDEN_INTERNA_PROD_GENE',sbValor,'NIT DE LA GASERA, SI APLICA ORDEN INTERNA PARA PRODUCTO GENERICO');
           COMMIT;
        END IF;
    end;
    
END;
/
