CREATE OR REPLACE trigger ADM_PERSON.TRG_ITEMCOTI_LDCRIAIC
  before insert or update or delete on LDC_ITEMCOTI_LDCRIAIC
  for each row

declare

  cursor cuordencerradoanulado is
    select count(oo.order_id)
      from or_order oo
     where oo.order_id = :new.order_id
       and oo.order_status_id IN
           (select to_number(column_value)
              from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_ESTORD_LDCRIAIC',
                                                                                       NULL),
                                                      ',')));
  nucuordencerradoanulado number;

  cursor cuordentaskitem is
    select count(oo.order_id)
      from or_order oo, or_task_type ott, or_task_types_items otti
     where oo.order_id = :new.order_id
       and oo.task_type_id = ott.task_type_id
       and ott.task_type_id = otti.task_type_id
       and otti.items_id = :new.item_cotizado;

  nucuordentaskitem number;

  cursor cuorden is
    select oo.order_status_id
      from or_order oo
     where oo.order_id = :new.order_id;

  rfcuorden cuorden%rowtype;

begin

  if INSERTING then

    open cuordencerradoanulado;
    fetch cuordencerradoanulado
      into nucuordencerradoanulado;
    close cuordencerradoanulado;

    IF nucuordencerradoanulado > 0 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'La orden [' || :new.order_id ||
                                       '] tiene un estado [' ||
                                       daor_order.fnugetorder_status_id(:new.order_id,
                                                                        null) ||
                                       '] no validao.');
    else
      open cuordentaskitem;
      fetch cuordentaskitem
        into nucuordentaskitem;
      close cuordentaskitem;

      IF nucuordentaskitem = 0 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'El Item Cotizado [' ||
                                         :new.item_cotizado ||
                                         '] no esta relacionado con el tipo de trabajo de la orden.');
      else
        open cuorden;
        fetch cuorden
          into rfcuorden;
        close cuorden;

        :new.order_status_id := rfcuorden.order_status_id;

      end if;
    end if;

  elsif DELETING then
    null;
  elsif UPDATING then

    IF :OLD.order_status_id = :NEW.order_status_id THEN

      open cuordencerradoanulado;
      fetch cuordencerradoanulado
        into nucuordencerradoanulado;
      close cuordencerradoanulado;

      IF nvl(nucuordencerradoanulado, 0) > 0 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'La orden [' || :new.order_id ||
                                         '] tiene un estado [' ||
                                         daor_order.fnugetorder_status_id(:new.order_id,
                                                                          null) ||
                                         '] no validao.');
      else
        open cuordentaskitem;
        fetch cuordentaskitem
          into nucuordentaskitem;
        close cuordentaskitem;

        IF nvl(nucuordentaskitem, 0) = 0 then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'El Item Cotizado [' ||
                                           :new.item_cotizado ||
                                           '] no esta relacionado con el tipo de trabajo de la orden.');
        else
          open cuorden;
          fetch cuorden
            into rfcuorden;
          close cuorden;

          :new.order_status_id := rfcuorden.order_status_id;

        end if;
      end if;
    END IF;

  end if;

end TRG_ITEMCOTI_LDCRIAIC;
/
