CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRGINSERTMATEQUI 
before INSERT ON or_ope_uni_item_bala 
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
/*
    Propiedad intelectual de Gases del Caribe. (c).

    Trigger     : LDCTRGINSERTMATEQUI

    Descripcion : Valida si la clasificacion del material esta dentro de lo parametrizado en el parametro LDCLASIFMATE y el items no esta dentro de la tabla
LDC_SALITEMSUNIDOP para la bodega , inserte un registro en la tabla LDC_SALITEMSUNIDOP

    Parametros  :       Descripcion

    Retorno     :

    Autor       : HORBATH TECHNOLOGIES.
    Fecha       : 25-11-2018

    Historia de Modificaciones
    Fecha           IDEntrega   Modificacion
    25-11-2018      200-2266    Creacion
    21/10/2024      OSF-3450    Se migra a ADM_PERSON
*/
DECLARE
    nuErrCode           number;
    SBERRMSG            GE_ERROR_LOG.DESCRIPTION%TYPE;
    sbParClasif         ld_parameter.value_chain%type;
    nucount             number;
    nucount1            number;
BEGIN

-- VERIFICA SI APLICA PARA GASERA

if (fblaplicaentrega('OSS_MNT_VHMR_2002266_1')) Then
--{
    pkErrors.Push('LDCTRGINSERTMATEQUI');

    -- determino parametro de clasificacion

    sbParClasif := dald_parameter.fsbGetValue_Chain('LDCLASIFMATE',null);

    if ( sbparclasif  is not null ) then
    --{

      -- verifica si la clasificacion del item esta configurada en el parametro
      select count(1)
             into nucount
             from ge_items
             where items_id=:NEW.items_id and
                   item_classif_id in (Select to_number(column_value) From Table(ldc_boutilities.splitstrings(sbparclasif,',')));

       if nucount<>0 then
          select count(1)
                 into nucount1
                 from LDC_SALITEMSUNIDOP L
                 where L.ITEMS_ID=:new.items_id and
                       L.operating_unit_id=:NEW.OPERATING_UNIT_ID;
          if nucount1=0 then
             insert into LDC_SALITEMSUNIDOP (operating_unit_id,items_id) values (:NEW.OPERATING_UNIT_ID,:new.items_id);
          end if;
      end if;

    --}
    else
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'No se ha configurado el valor tipo cadena del parámetro LDCLASIFMATE');
        raise ex.CONTROLLED_ERROR;
    END if;

    pkErrors.Pop;
END IF;
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
