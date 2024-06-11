SELECT o.order_id, o.legalization_date, T.*
FROM OR_ORDER O, OR_TASK_TYPE T
WHERE ORDER_STATUS_ID=8
  AND O.TASK_TYPE_ID=T.TASK_TYPE_ID
  AND TASK_TYPE_CLASSIF=209
  AND LEGALIZATION_dATE>='01/ABR/2016'
  order by 2;


SELECT * FROM LDC_DATOS_CERTIFICADO_MET;
select LDC_BOmetrologia.fnugetElemntoPatron(42873409) from dual;
select  from dual;
select * from ge_items_Seriado
where id_items_seriado=44;
select *
from ge_error_log
where error_log_id=478881093;


SELECT * FROM ge_items_tipo_at_val v,ge_items_tipo_atr atr
          WHERE v.id_items_seriado = LDC_BOmetrologia.fnugetElemntoPatron(42873409)
          AND v.id_items_tipo_atr = atr.id_items_tipo_atr
          AND atr.entity_attribute_id = 90008865;

select *
from ge_entity_attributes
where entity_attribute_id = 90008865;   

      


LDC_OSSGENERACERT
SELECT GE_ITEMS_TIPO_AT_VAL.*, GE_ITEMS_SERIADO.*, GE_BOItemsSeriado.fsbIsPattern(GE_ITEMS_SERIADO.ID_ITEMS_SERIADO)
                FROM    GE_ENTITY_ATTRIBUTES,
                        GE_ITEMS_TIPO_ATR,
                        GE_ITEMS_TIPO_AT_VAL,
                        GE_ITEMS_SERIADO
                WHERE   GE_ITEMS_TIPO_ATR.ENTITY_ATTRIBUTE_ID = GE_ENTITY_ATTRIBUTES.ENTITY_ATTRIBUTE_ID
                AND     GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR = GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_ATR
--                and ID_ITEMS_SERIADO=44
--                and technical_name='MARCA_MET'
                AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_ATR=1000022
                AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_SERIADO=GE_ITEMS_SERIADO.ID_ITEMS_sERIADO;
select *
from ge_items_attributes
where items_id=44;
SELECT LDC_BOMETROLOGIA.FNUGETUEXP_INCERTIDUMBRE(42873409) FROM DUAL
SELECT o.variable_id,
c.incertidumbre,o.pattern_value,
LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre, o.pattern_value),LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) PATTERN,
LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre, o.pattern_value)||' '||LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) PATTERN,
LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre, O.item_value)||' '||LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) TEMP_ITEM,
LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre,(O.item_value - o.pattern_value))||' '||LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) ERROR,
c.incertidumbre ||' '||LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) INCERTIDUMBRE
FROM OR_order_act_measure o, LDC_DATOS_CERTIFICADO_MET c
WHERE o.order_id  = 42873409
and o.order_id = c.order_id
and o.variable_id = 34
;
select null variable_id, null PATTERN, null TEMP_ITEM, null ERROR, null INCERTIDUMBRE,NULL,NULL
FROM OR_order_act_measure   o
WHERE o.order_id  = 42873409
and o.variable_id = 214
and o.pattern_value is not null
and rownum = 1
;
SELECT o.variable_id,
LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre, o.pattern_value),LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) PATTERN,
LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre, o.pattern_value)||' '||LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) PATTERN,
LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre, O.item_value)||' '||LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) TEMP_ITEM,
LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre,(O.item_value - o.pattern_value))||' '||LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) ERROR,
LDC_BOmetrologia.fsbGetIncertidumbreConcNomi(o.ORDER_ID) INCERTIDUMBRE
FROM OR_order_act_measure o, LDC_DATOS_CERTIFICADO_MET c
WHERE o.order_id  = 42873409
and o.order_id = c.order_id
and o.variable_id = 214;
select decode (fsbAplicaEntrega('OSS_SMS_CA_100-7394'), 'S',
'Las incertidumbres antes reportadas se encuentran asociadas respectivamente a las concentraciones de los gases de
referencia mencionados en la tabla de resultados de la comprobación, siendo la primera incertidumbre la asociada al
gas de mayor concentración y la segunda incertidumbre la asociada al gas de menor concentración.', 'N', 'Las incertidumbres antes reportadas se encuentran asociadas respectivamente a las concentraciones de los gases de
referencia mencionados en la tabla de resultados de la comprobación, siendo la primera incertidumbre la asociada al
gas de menor concentración y la segunda incertidumbre la asociada al gas de mayor concentración.') INCERT_DATA
FROM OR_order_act_measure   o
WHERE o.order_id  = 42873409
and o.variable_id = 214
and o.pattern_value is not null
and rownum = 1;






select *
from or_order o, or_operating_unit u
where order_status_id=8
  and is_pending_liq='Y'
  and o.operating_unit_id=u.operating_unit_id
  and u.contractor_id is not null
  and legalization_Date>='01/04/2016';
  
  LDC_FNUGETCAUSALTRAMITERECONRP 
  
