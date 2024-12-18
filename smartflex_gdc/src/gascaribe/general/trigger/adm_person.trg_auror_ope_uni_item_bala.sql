CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_AUROR_OPE_UNI_ITEM_BALA

    AFTER UPDATE ON Or_Ope_Uni_Item_Bala
  /* Propiedad intelectual de Gases de Occidente

      Trigger     :   TRG_AUROR_OPE_UNI_ITEM_BALA



      Historial de modificaciones

        Autor            Fecha           Descripcion
        ------          --------        ---------------------------------
        LJLB            14-nov-2018     200-2271 -- se aplica trigger de la entrega
                                        OSS_CON_MAL_200833_1 para solucionar problema del release
                                        597
        dsaltarin		05-mar-2019	    200-2470 Se modifica para que si el número de movimiento
                                        es nulo no realice actualización del costo del movimiento,
                                        sino que inserte un nuevo registro
        jpinedc		    21-oct-2024	    OSF-3450: Se migra a ADM_PERSON
  ************************************************************************/
REFERENCING old AS old new AS new for each row

Declare

  --------------

  -- Variable

  --------------

  rcopeuniitembala daor_uni_item_bala_mov.styor_uni_item_bala_mov;

  rcitemsdocumneto dage_items_documento.styge_items_documento;

  nuitemamount     or_uni_item_bala_mov.amount%Type;

  sbmovementtype   or_uni_item_bala_mov.movement_type%Type;

  numoveitemcause  or_item_moveme_caus.item_moveme_caus_id%Type;

  nutotalcosts     or_ope_uni_item_bala.total_costs%Type;



  nuiditemsdoc      or_uni_item_bala_mov.id_items_documento%Type;

  nuiditemsseriado  or_uni_item_bala_mov.id_items_seriado%Type;

  sbestadoinv       or_uni_item_bala_mov.id_items_estado_inv%Type;

  nuvalorventa      or_uni_item_bala_mov.valor_venta%Type;

  nuoperunittarget  or_uni_item_bala_mov.target_oper_unit_id%Type;

  nuinitstatus      or_uni_item_bala_mov.init_inv_stat_items%Type;

  nuorder_id        or_order.order_id%Type;

  sbsupportdocument or_uni_item_bala_mov.support_document%Type;



  -- ara8732. Se crea la variable

  nunromov or_uni_item_bala_mov.uni_item_bala_mov_id%Type;
  --200-2470---------
  csbEnt2002470  ldc_versionentrega.nombre_entrega%type:='OSS_OYM_DSS_200_2470_4';
  --200-2470---------

Begin



If :old.balance = :new.balance And :old.quota = :new.quota And

     :old.total_costs = :new.total_costs And

     :old.occacional_quota = :new.occacional_quota And

     :old.transit_in = :new.transit_in And

     :old.transit_out = :new.transit_out And :old.items_id = :new.items_id And

     :old.operating_unit_id = :new.operating_unit_id Then --CA 200-833 se adiciona condicion para que no se dispare el trigger multiples veces.



     ut_trace.trace('No se ejecutará TRG_AUROR_OPE_UNI_ITEM_BALA' , 10);

else



  ut_trace.trace('Inicio TRG_AUROR_OPE_UNI_ITEM_BALA' , 10);



  ut_trace.trace('No sólo se modifica el costo' , 10);



  -- Se determina la cantidad de items movidos (Valor absoluto)

  ut_trace.trace('nuItemAmount := abs('||:old.Balance||' - '||:new.Balance||'); ' || nuitemamount || ' := abs(' ||

                 :old.balance || ' - ' || :new.balance || ');' , 10);

  nuitemamount := abs(:old.balance - :new.balance);



  nutotalcosts := abs(:old.total_costs - :new.total_costs);





  -- ARA8732. No realiza actualizaciones sobre la tabla uni_item_bala_mov

  -- si lo que se está modificando sólo es costo ya que el api

  -- or_boAdjustmentOrder.createorder sólo está modificando las unidades

  -- del inventario y no modifica el costo, así que toca realizar esta actualización

  -- manualmente en pkOrdenesSinActa.proMueveInventarioUnidOper

  If :old.balance = :new.balance And :old.quota = :new.quota And

     :old.total_costs <> :new.total_costs And

     :old.occacional_quota = :new.occacional_quota And

     :old.transit_in = :new.transit_in And

     :old.transit_out = :new.transit_out And :old.items_id = :new.items_id And

     :old.operating_unit_id = :new.operating_unit_id Then



    ut_trace.trace('Sólo se está modificando el costo' , 10);



    Null;

  Else



    -- SAO44004 Ref asamboni

    -- Se valida si la cantidad de items movidos es 0

    -- para que no se inserte en la tabla OR_UNI_ITEM_BALA_MOV

    If (nvl(nuitemamount, 0) = 0) Then

      ut_trace.trace('nuItemAmount ' || nuitemamount, 10 );



      Return;

    End If;



  End If;



  ut_trace.trace(nutotalcosts || ':= abs(' || :old.total_costs || '- ' ||

                 :new.total_costs || ');', 10);



  -- ARA8732. Se traslada el código al sino de la evaluación de los campos que

  -- se están modificando en item_bala



  /*

      -- SAO44004 Ref asamboni

          -- Se valida si la cantidad de items movidos es 0

          -- para que no se inserte en la tabla OR_UNI_ITEM_BALA_MOV

          IF (nvl(nuItemAmount, 0) = 0)

              THEN

              ut_trace.trace('nuItemAmount ' || nuItemAmount );



              RETURN;

          END IF;



  */



  -- Se valida que el balance no quede negativo.

  ut_trace.trace(':new.Balance ' || :new.balance ||

                 'GE_BOItemClassif.fblOperateQuota(' || :new.items_id, 10);

  If (:new.balance < 0 And ge_boitemclassif.fbloperatequota(:new.items_id)) Then

    errors.seterror(1965, :new.items_id || '|' || :new.operating_unit_id);

    Raise ex.controlled_error;

  End If;

  -- Se determina el tipo de operación

  ut_trace.trace(':new.Balance < :old.Balance' , 10);

  ut_trace.trace(:new.balance || '<' || :old.balance , 10);

  If (:new.balance < :old.balance) Then

    -- Se realizó una operación de disminución

    ut_trace.trace('sbMovementType ' || sbmovementtype ||

                   ':= or_boItemsMove.csbDecreaseMoveType' ||

                   or_boitemsmove.csbdecreasemovetype, 10);

    sbmovementtype := or_boitemsmove.csbdecreasemovetype;

  Else
    --200--2470
    IF fblaplicaentrega(csbEnt2002470) THEN
      IF :NEW.BALANCE > :OLD.BALANCE THEN
         ut_trace.trace('sbMovementType ' || sbmovementtype, 10 );
         ut_trace.trace('or_boitemsmove.csbIncreaseMoveType ' ||or_boitemsmove.csbincreasemovetype, 10);
         sbmovementtype := or_boitemsmove.csbincreasemovetype;
      ELSE
         IF :NEW.TOTAL_COSTS < :OLD.TOTAL_COSTS THEN
            sbmovementtype := or_boitemsmove.csbdecreasemovetype;
         ELSE
            sbmovementtype := or_boitemsmove.csbincreasemovetype;
         END IF;
      END IF;
    ELSE
    -- Se realizó una operación de aumento
    ut_trace.trace('sbMovementType ' || sbmovementtype, 10 );
    ut_trace.trace('or_boitemsmove.csbIncreaseMoveType ' ||
                   or_boitemsmove.csbincreasemovetype, 10);
    sbmovementtype := or_boitemsmove.csbincreasemovetype;
    END IF;
    --200--2470
  End If;



  -- Se obtiene la causa del movimiento de los Items

  numoveitemcause := or_boitems.fnugetitemmovecaus;

  ut_trace.trace(numoveitemcause || ':= ' ||

                 or_boitems.fnugetitemmovecaus, 10);



  If (numoveitemcause Is Null) Then

    -- Causa de movimiento desconocida del Item

    ut_trace.trace(numoveitemcause || ':= ' ||

                   ge_boparameter.fnuget(or_boconstants.csbunknownmovecause), 10);

    numoveitemcause := ge_boparameter.fnuget(or_boconstants.csbunknownmovecause);

  End If;



  ut_trace.trace('or_boItemsMove.getTempValues(' || nuiditemsdoc || ',

                                     ' ||

                 nuiditemsseriado || ',

                                     ' || sbestadoinv || ',

                                     ' || nuvalorventa || ',

                                     ' ||

                 nuoperunittarget || ',

                                     ' || nuinitstatus || ');', 10);



  or_boitemsmove.gettempvalues(nuiditemsdoc,

                               nuiditemsseriado,

                               sbestadoinv,

                               nuvalorventa,

                               nuoperunittarget,

                               nuinitstatus);







 --200-833

  Begin

    nuorder_id := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER',

                                                        'ORDER_ID');

  Exception

    When Others Then

      nuorder_id := Null;

  End;

  If nuorder_id Is Not Null Then

    Begin

      rcitemsdocumneto.id_items_documento  := seq_ge_items_documento.nextval;

      rcitemsdocumneto.document_type_id    := 118;

      rcitemsdocumneto.documento_externo   := nuorder_id;

      rcitemsdocumneto.fecha               := Sysdate;

      rcitemsdocumneto.estado              := 'C';

      rcitemsdocumneto.operating_unit_id   := :new.operating_unit_id;

      rcitemsdocumneto.destino_oper_uni_id := :new.operating_unit_id;

      rcitemsdocumneto.terminal_id         := ut_session.getterminal;

      rcitemsdocumneto.user_id             := ut_session.getuser;

      rcitemsdocumneto.comentario          := ut_session.getmodule || ': ' ||

                                              nuorder_id;

      rcitemsdocumneto.causal_id           := Null;

      rcitemsdocumneto.delivery_date       := Null;

      rcitemsdocumneto.package_id          := Null;



      dage_items_documento.insrecord(rcitemsdocumneto);



    End;

  End If;



  If rcitemsdocumneto.id_items_documento Is Null Then

    rcopeuniitembala.support_document := ' ';

  Else

    rcopeuniitembala.support_document := rcitemsdocumneto.id_items_documento;

  End If;

  -- Se arma el record de la tabla OR_Uni_Item_Bala_Mov

  rcopeuniitembala.uni_item_bala_mov_id := or_bosequences.fnunextor_uni_item_bala_mov;

  rcopeuniitembala.items_id             := :new.items_id;

  rcopeuniitembala.operating_unit_id    := :new.operating_unit_id;

  rcopeuniitembala.item_moveme_caus_id  := numoveitemcause;

  rcopeuniitembala.movement_type        := sbmovementtype;

  rcopeuniitembala.amount               := nuitemamount;

  rcopeuniitembala.comments             := ' ';

  rcopeuniitembala.move_date            := Sysdate;

  rcopeuniitembala.terminal             := ut_session.getterminal;

  rcopeuniitembala.user_id              := ut_session.getuser;

  rcopeuniitembala.total_value          := nutotalcosts;

  rcopeuniitembala.id_items_documento   := nuiditemsdoc;

  rcopeuniitembala.id_items_seriado     := nuiditemsseriado;

  rcopeuniitembala.id_items_estado_inv  := sbestadoinv;

  rcopeuniitembala.valor_venta          := nuvalorventa;

  rcopeuniitembala.target_oper_unit_id  := nuoperunittarget;

  rcopeuniitembala.init_inv_stat_items  := nuinitstatus;



   ut_trace.trace('rcOpeUniItemBala.Uni_Item_Bala_Mov_Id := ' ||

                 or_bosequences.fnunextor_uni_item_bala_mov || ';

        rcOpeUniItemBala.Items_Id             := ' ||

                 :new.items_id || ';

        rcOpeUniItemBala.Operating_Unit_Id    := ' ||

                 :new.operating_unit_id || ';

        rcOpeUniItemBala.Item_Moveme_Caus_Id  := ' ||

                 numoveitemcause || ';

        rcOpeUniItemBala.Movement_Type        := ' ||

                 sbmovementtype || ';

        rcOpeUniItemBala.Amount               := ' ||

                 nuitemamount || ';

        rcOpeUniItemBala.Comments             := ;

        rcOpeUniItemBala.Move_Date            := ' ||

                 Sysdate || ';

        rcOpeUniItemBala.Terminal             := ' ||

                 ut_session.getterminal || ';

        rcOpeUniItemBala.User_Id              := ' ||

                 ut_session.getuser || ';

        rcOpeUniItemBala.Support_Document     := ;

        rcOpeUniItemBala.total_value          := ' ||

                 nutotalcosts || ';

        rcOpeUniItemBala.id_items_documento  := ' ||

                 nuiditemsdoc || ';

        rcOpeUniItemBala.id_items_seriado    := ' ||

                 nuiditemsseriado || ';

        rcOpeUniItemBala.id_items_estado_inv := ' ||

                 sbestadoinv || ';

        rcOpeUniItemBala.valor_venta         := ' ||

                 nuvalorventa || ';

        rcOpeUniItemBala.target_oper_unit_id := ' ||

                 nuoperunittarget || ';

        rcOpeUniItemBala.init_inv_stat_items := ' ||

                 nuinitstatus || ';');



  -- Se instancia el id

  or_boitemsmove.setbalamoveid(rcopeuniitembala.uni_item_bala_mov_id);



  -- ARA8732. No realiza actualizaciones sobre la tabla uni_item_bala_mov

  -- si lo que se está modificando sólo es costo ya que el api

  -- or_boAdjustmentOrder.createorder sólo está modificando las unidades

  -- del inventario y no modifica el costo, así que toca realizar esta actualización

  -- manualmente en pkOrdenesSinActa.proMueveInventarioUnidOper

  If :old.balance = :new.balance And :old.quota = :new.quota And

     :old.total_costs <> :new.total_costs And

     :old.occacional_quota = :new.occacional_quota And

     :old.transit_in = :new.transit_in And

     :old.transit_out = :new.transit_out And :old.items_id = :new.items_id And

     :old.operating_unit_id = :new.operating_unit_id Then



    ut_trace.trace('Se actualiza el registro', 10 );



    Begin



      Select Max(ouibm.uni_item_bala_mov_id)

        Into nunromov

        From or_uni_item_bala_mov ouibm

       Where ouibm.items_id = :new.items_id

         And ouibm.operating_unit_id = :new.operating_unit_id

         And ouibm.user_id = ut_session.getuser

         And ouibm.terminal = ut_session.getterminal;



    Exception

      When Others Then

        Raise ex.controlled_error;

    End;

    IF fblaplicaentrega(csbEnt2002470) THEN
		if nunromov is not null then
		  BEGIN
			daor_uni_item_bala_mov.updtotal_value(inuuni_item_bala_mov_id => nunromov,
												  inutotal_value$         => nutotalcosts);

		  EXCEPTION
			WHEN OTHERS THEN
				daor_uni_item_bala_mov.insrecord(rcopeuniitembala);
		  END;
		else
			daor_uni_item_bala_mov.insrecord(rcopeuniitembala);
		end if;
    ELSE
        daor_uni_item_bala_mov.updtotal_value(inuuni_item_bala_mov_id => nunromov,
                                              inutotal_value$         => nutotalcosts);
    END IF;

  Else



    -- Se Inserta en la tabla Or_Uni_Item_Bala_Mov

    daor_uni_item_bala_mov.insrecord(rcopeuniitembala);



  End If;



  --    END IF;



  ut_trace.trace('FIN TRG_AUROR_OPE_UNI_ITEM_BALA', 10 );

end if;

Exception

  When ex.controlled_error Then

    Raise;

  When Others Then

    errors.seterror;

    Raise ex.controlled_error;

End;
/
