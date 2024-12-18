CREATE OR REPLACE trigger ADM_PERSON.TRG_ITEMADICINTE_LDCRIAIC
  before insert or update or delete on LDC_ITEMADICINTE_LDCRIAIC
  for each row

declare

  nutotal number(13, 2);

  cursor cuordencerradoanulado is
    select count(oo.order_id) CANTIDAD,
           oo.order_id ORDEN,
           oo.order_status_id ESTADO
      from or_order oo
     where oo.order_id in
           (select LIL.ORDER_ID
              FROM LDC_ITEMCOTIINTE_LDCRIAIC LIL
             WHERE LIL.CODIGO = nvl(:OLD.CODIGO, :new.codigo))
       and oo.order_status_id IN
           (select to_number(column_value)
              from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_ESTORD_LDCRIAIC',
                                                                                       NULL),
                                                      ',')))
     group by oo.order_id, oo.order_status_id;

  RFcuordencerradoanulado cuordencerradoanulado%ROWTYPE;

begin

  if INSERTING then

    open cuordencerradoanulado;
    fetch cuordencerradoanulado
      into RFcuordencerradoanulado;
    close cuordencerradoanulado;

    IF nvl(RFcuordencerradoanulado.CANTIDAD, 0) > 0 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'La orden [' ||
                                       RFcuordencerradoanulado.ORDEN ||
                                       '] tiene un estado [' ||
                                       RFcuordencerradoanulado.ESTADO ||
                                       '] no valido para registrar el Item adicional');
    else
      nutotal    := :new.valor_unitario * :new.cantidad;
      :new.total := nutotal;
    end if;

  elsif DELETING or UPDATING then

    open cuordencerradoanulado;
    fetch cuordencerradoanulado
      into RFcuordencerradoanulado;
    close cuordencerradoanulado;

    IF nvl(RFcuordencerradoanulado.CANTIDAD, 0) > 0 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'La orden [' ||
                                       RFcuordencerradoanulado.ORDEN ||
                                       '] tiene un estado [' ||
                                       RFcuordencerradoanulado.ESTADO ||
                                       '] no valido para cambios en el Item adicional');
    else
      if UPDATING then
        nutotal    := :new.valor_unitario * :new.cantidad;
        :new.total := nutotal;
      end if;
    end if;

  end if;

end TRG_ITEMADICINTE_LDCRIAIC;
/
