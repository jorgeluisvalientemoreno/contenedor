
create or replace PROCEDURE      LDC_CAMBIO_ESTADO_PROD
(
    inuProduct  pr_product.product_id%type
)
IS
/*************************************************************************************

Historial      

fecha             autor                   descripcion          
 15/04/2019       ELAL                    CA 200-2467  se adiciona validacion de solicitudes 
                                          de RP en estado en proceso.
 18/06/2019       Miguel Ballesteros      CA 200-2681 se comentan los cambios hechos por el caso
                                          CA 200-2467 
 10/10/2022       dsaltarin               SN-602: Se cambiar el parametro que valdia las suspensiones
                                          LDC_TIPO_SUSPENSION_RP-->TIPO_SUS_RECONEC_CAMBIO_ESTADO
*************************************************************************************/
    nuFlag   number;
    nuSusp   number;

    -- Cursor que consulta si el producto esta en estado 2-Suspendido
    cursor cuExistProduct(inuprod pr_product.product_id%type)
    is
        select 1
        from open.pr_product
        where product_id = inuprod
        and product_status_id = 2;
   
   sbTipoSuspension VARCHAR2(2000) := DALD_PARAMETER.fsbGetValue_Chain('TIPO_SUS_RECONEC_CAMBIO_ESTADO',NULL);
    -- Cursor que consulta si el producto tiene una suspension diferente a la de RP
    cursor cuSuspension(inuprod pr_product.product_id%type)
    is
        select 1
        from open.pr_prod_suspension
        where product_id = inuprod
        and suspension_type_id not in (  select to_number(regexp_substr(sbTipoSuspension,'[^,]+', 1, level))  tipo_susp
                                          from   dual 
                                          connect by regexp_substr(sbTipoSuspension, '[^,]+', 1, level) is not null) /*(SELECT TO_NUMBER(COLUMN_VALUE)
                                       FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('LDC_TIPO_SUSPENSION_RP',NULL),',')))*/
                                       
        and active = 'Y';
   
   --------------------------------  CASO 200-2681  ------------------------------------ 
   
   /*nuEstadoRegis    NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('ESTADO_SOL_REGISTRADA',NULL); --TICKET 200-2467 ELAL -- se alamcena estado registrado de la soli
   sbTipoSolirp     VARCHAR2(2000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('VAL_TIPO_PAQUETE_OTREV'); --TICKET 200-2467 ELAL -- se almacena tipo de solicitudes de RP
   
   sbdatos     VARCHAR2(1); --TICKET 200-2467 ELAL -- se almacena valor si existe RP
   csbNumeroCaso CONSTANT VARCHAR2(30) := '200-2467'; --TICKET 200-2467 ELAL -- se almacena numero de caso
   sbAplicaEntrega  VARCHAR2(1) := 'N'; --TICKET 200-2467 ELAL --se almacena si aplica o no la entrega
   
   --TICKET 200-2467 ELAL --se consulta tramite de rp pendientes
   CURSOR cuValidaTramiRp IS
   SELECT 'X'
   FROM OPEN.MO_PACKAGES P, OPEN.MO_MOTIVE M
   WHERE P.PACKAGE_ID = M.PACKAGE_ID
        AND PACKAGE_TYPE_ID IN( select to_number(regexp_substr(sbTipoSolirp,'[^,]+', 1, level))  tipo_soli
                                from   dual 
                                connect by regexp_substr(sbTipoSolirp, '[^,]+', 1, level) is not null
                                  )
        AND M.PRODUCT_ID = inuProduct
        and P.MOTIVE_STATUS_ID  = nuEstadoRegis;*/
        
  --------------------------------  FIN CASO 200-2681  ------------------------------------ 
   
BEGIN

    UT_Trace.Trace( 'Inicia LDC_CAMBIO_ESTADO_PROD['||inuProduct||']', 1);

    -- valida que el producto capturado desde la instancia no sea nulo
    if (inuProduct is not null) then
        open cuExistProduct(inuProduct);
        fetch cuExistProduct into nuFlag;
        close cuExistProduct;

        -- valida que el producto exista y este en estado suspendido
        if (nuFlag = 1) then
            
            open cuSuspension(inuProduct);
            fetch cuSuspension into nuSusp;
            close cuSuspension;
            --------------------------------  CASO 200-2681  ------------------------------------ 
            --TICKET 200-2467 ELAL -- se valida si aplica o no la entrega del caso 200-2467
            /*IF FBLAPLICAENTREGAXCASO(csbNumeroCaso) THEN
              sbAplicaEntrega := 'S';
            END IF;
            */
            --------------------------------  FIN CASO 200-2681  ------------------------------------ 
            -- valida marca de suspension
            if (nuSusp is not null and nuSusp = 1 ) then
               --------------------------------  CASO 200-2681  ------------------------------------ 
                --TICKET 200-2467 ELAL -- si la entrega aplica a la gasera generar error 
               /* IF sbAplicaEntrega = 'S' THEN
                    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'El producto ['||inuProduct||'] no se encuentra suspendido por RP');
                    raise ex.CONTROLLED_ERROR;
                END IF;*/
               --------------------------------  FIN CASO 200-2681  ------------------------------------ 
                begin
                    update open.pr_prod_suspension
                    set inactive_date = sysdate,
                        active = 'N'
                    where product_id = inuProduct
                    and suspension_type_id in (  select to_number(regexp_substr(sbTipoSuspension,'[^,]+', 1, level))  tipo_susp
                                          from   dual 
                                          connect by regexp_substr(sbTipoSuspension, '[^,]+', 1, level) is not null)/*(SELECT TO_NUMBER(COLUMN_VALUE)
                                       FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('LDC_TIPO_SUSPENSION_RP',NULL),',')))*/
                    and active = 'Y';


                    -- actualizar suspension componente
                    update open.pr_comp_suspension
                    set inactive_date = sysdate,
                        active = 'N'
                    where component_id in (select component_id
                                           from pr_component
                                           where product_id = inuProduct)
                    and suspension_type_id in (  select to_number(regexp_substr(sbTipoSuspension,'[^,]+', 1, level))  tipo_susp
                                                  from   dual 
                                                  connect by regexp_substr(sbTipoSuspension, '[^,]+', 1, level) is not null) 
                                                  /*(SELECT TO_NUMBER(COLUMN_VALUE)
                                       FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('LDC_TIPO_SUSPENSION_RP',NULL),',')))*/
                    and active = 'Y';

                     --commit;

                exception
                    when others then
                        rollback;
                end;

            elsif (nuSusp is null or nuSusp <> 1) then
            
               --------------------------------  CASO 200-2681  ------------------------------------ 
                --TICKET 200-2467 ELAL -- si la entrega aplica a la gasera validar solicitudes de RP pendientes
                /*IF sbAplicaEntrega = 'S' THEN
                    OPEN cuValidaTramiRp;
                    FETCH cuValidaTramiRp INTO sbDatos;
                    IF cuValidaTramiRp%FOUND THEN
                       ge_boerrors.seterrorcodeargument(2741, 'El producto['||inuProduct||'] tiene solicitudes de RP en proceso');
                      raise ex.CONTROLLED_ERROR;
                    END IF;
                    CLOSE cuValidaTramiRp;
                    
                END IF;*/
                --------------------------------  FIN CASO 200-2681  ------------------------------------ 
                
                begin
                    update open.pr_product
                    set product_status_id = 1,
                        suspen_ord_act_id = null
                    where product_id = inuProduct;

                    update open.pr_component
                    set component_status_id = 5
                    where product_id = inuProduct;

                    update open.compsesu
                    set cmssescm = 5
                    where cmsssesu = inuProduct;

                    update open.pr_prod_suspension
                    set inactive_date = sysdate,
                        active = 'N'
                    where product_id = inuProduct
                    and suspension_type_id in (  select to_number(regexp_substr(sbTipoSuspension,'[^,]+', 1, level))  tipo_susp
                                          from   dual 
                                          connect by regexp_substr(sbTipoSuspension, '[^,]+', 1, level) is not null)/*(SELECT TO_NUMBER(COLUMN_VALUE)
                                       FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('LDC_TIPO_SUSPENSION_RP',NULL),',')))*/
                    and active = 'Y';

                    -- actualizar suspension componente
                    update open.pr_comp_suspension
                    set inactive_date = sysdate,
                        active = 'N'
                    where component_id in (select component_id
                                           from pr_component
                                           where product_id = inuProduct)
                    and suspension_type_id in (  select to_number(regexp_substr(sbTipoSuspension,'[^,]+', 1, level))  tipo_susp
                                          from   dual 
                                          connect by regexp_substr(sbTipoSuspension, '[^,]+', 1, level) is not null)/*(SELECT TO_NUMBER(COLUMN_VALUE)
                                       FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('LDC_TIPO_SUSPENSION_RP',NULL),',')))*/
                    and active = 'Y';

                    --commit;

                exception
                    when others then
                        rollback;
                end;

            end if;
            -- fin validacion prod_suspension
        else
            -- El producto no esta suspendido
            ge_boerrors.seterrorcodeargument(2741, 'El producto['||inuProduct||'] no se encuentra suspendido');
        end if;
    else
        -- No se capturo el producto de la instancia
        ge_boerrors.seterrorcodeargument(2741, 'No se logro capturar el producto de la instancia!!');
    end if;

    UT_Trace.Trace( 'Fin LDC_CAMBIO_ESTADO_PROD', 1);

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

END LDC_CAMBIO_ESTADO_PROD;

/
GRANT EXECUTE ON LDC_CAMBIO_ESTADO_PROD TO SYSTEM_OBJ_PRIVS_ROLE;
/