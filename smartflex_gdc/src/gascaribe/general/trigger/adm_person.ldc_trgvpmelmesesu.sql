CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVPMELMESESU
  AFTER INSERT on ELMESESU
  REFERENCING
    NEW AS NEW
    OLD AS OLD
  FOR EACH ROW
DECLARE
/**************************************************************************
Propiedad Intelectual de Gases del caribe S.A E.S.P

  Funcion     : LDC_TRGVPMELMESESU
  Descripcion : trigger que valida si en la tabla ELMESESU se registra o actualiza un medidor y registra en la tabla LDC_VPM
  Autor       : Horbath
  Ticket      : 132
  Fecha       : 9-12-2020

Historia de Modificaciones
Fecha               Autor                Modificacion
=========           =========           ====================
21/10/2024          jpinedc             OSF-3450: Se migra a ADM_PERSON
**************************************************************************/



  cursor CUTTMEDPRO (sbSerie varchar2) is
  select count(1)
from open.or_order o, open.ge_causal c, open.or_related_order r, open.or_order_items oi, open.or_order o2
where o.task_type_id in (SELECT to_number(column_value)
                                from table (ldc_boutilities.SPLITstrings(DALD_PARAMETER.FSBGETVALUE_CHAIN('TTMEDIPROV'),',')))
  and c.causal_id=o.causal_id
  and c.class_causal_id=1
  and r.order_id=o.order_id
  and oi.order_id=r.related_order_id
  and serie is not null
  and out_='Y'
  and serie=sbSerie
  and o2.order_id=r.related_order_id
  and trunc(o2.execution_final_date)=trunc(:new.emssfein)
  and o.order_status_id!=12
  and o2.order_Status_id!=12
  and exists(select null from open.or_order_activity a where a.order_id=r.related_order_id and a.product_id=:new.emsssesu);

  nuExiste number;


BEGIN



  if :new.EMSSSERV = 7014 and fblaplicaentregaxcaso('0000132') then
        nuExiste := 0;

        OPEN CUTTMEDPRO(:new.EMSSCOEM);
        FETCH CUTTMEDPRO INTO nuExiste;
        CLOSE CUTTMEDPRO;

        if nuExiste =0 then

          LDC_PRVPMDATA(:new.EMSSSESU,:new.EMSSCOEM,:new.emssfein);

        end if;
  end if;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
END LDC_TRGVPMELMESESU;
/
