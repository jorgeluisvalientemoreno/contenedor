SELECT * FROM OPEN.ge_notifi_statement WHERE NOTIFICATION_ID=100311;
select * from OPEN.GE_STATEMENT where statement_id in (120009842,120009835,120027746);

SELECT * FROM open.LDC_DATOS_CERTIFICADO_MET
SELECT DISTINCT  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),ob1.pattern_value) PATTERN,  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),os1.item_value) PSUB1,    case    when open.LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(ob1.Order_id) = 'A' OR         open.LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(ob1.Order_id) = 'B'    then  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),subida_2.item_value)    else 'N/A'    end  PSUB2,   OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),ob1.Item_value) VALBAJ1,   case   when open.LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(ob1.Order_id) = 'A'   then OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),ob2.Item_value)   else 'N/A'   end  VALBAJ2,    case    when open.LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(ob1.Order_id) = 'A'    then  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),           ((((os1.item_value + subida_2.item_value)/2) + ((ob1.item_value + ob2.item_value)/2))/2)           - ob1.pattern_value)    when open.LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(ob1.Order_id) = 'B'    then  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),          ((((os1.item_value + subida_2.item_value)/2) + ob1.item_value)/2)          - ob1.pattern_value)    else OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),         ((ob1.Item_value + os1.item_value)/2)         - ob1.pattern_value)    end  ERROR_PROM,    case    when open.LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(ob1.Order_id) = 'A'    then  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),          ABS(((ob1.Item_value + ob2.item_value)/2) - ((os1.item_value + subida_2.item_value)/2)) )    else OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),         ABS(ob1.Item_value - os1.item_value) )    end  HISTERESIS  FROM open.OR_order_act_measure  ob1  left join  open.OR_order_act_measure  ob2  ON ob1.pattern_value = ob2.pattern_value   and ob2.variable_id = 15    and ob1.order_id = ob2.order_id,  open.OR_order_act_measure os1  left join  open.OR_order_act_measure subida_2  ON os1.pattern_value = subida_2.pattern_value   and subida_2.variable_id = 13    and os1.order_id = subida_2.order_id  WHERE  ob1.Order_id = 55581796   AND ob1.variable_id =14  AND os1.variable_id = 12  and ob1.pattern_value = os1.pattern_value  AND ob1.order_id = os1.order_id  order by  to_number(  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),ob1.pattern_value))




SELECT *
FROM OPEN.OR_NOTIF_TIPO_TRABA
where id_notificacion=100328;
WHERE ID_TIPO_TRABAJO=12669;

select *
from OPEN.GE_NOTIFICATION
where notification_id=100311;


SELECT tt.id_tipo_trabajo,n.notification_id, n.description, x.xsl_template_id, x.description, x.template_source, x.template_xsl, s.statement_id, s.description, s.statement
FROM open.GE_XSL_TEMPLATE x, open.ge_notification n, open.ge_statement s, open.ge_notifi_statement ns, open.or_notif_tipo_traba tt
WHERE tt.id_tipo_trabajo =:TT AND tt.id_notificacion = n.notification_id AND ns.notification_id = n.notification_id AND ns.statement_id = s.statement_id AND x.xsl_template_id(+) = n.xsl_template_id

SELECT n.notification_id, n.description, x.xsl_template_id, x.description, x.template_source, x.template_xsl, s.statement_id, s.description, s.statement
FROM open.ge_xsl_template x, open.ge_notification n, open.ge_statement s, open.ge_notifi_statement ns
WHERE n.notification_id=100311 AND ns.notification_id = n.notification_id AND ns.statement_id = s.statement_id AND x.xsl_template_id(+) = n.xsl_template_id


SELECT DISTINCT  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),ob1.pattern_value) PATTERN,  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),os1.item_value) PSUB1,    case    when open..LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(ob1.Order_id) = 'A' OR         open..LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(ob1.Order_id) = 'B'    then  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),subida_2.item_value)    else 'N/A'    end  PSUB2,   OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),ob1.Item_value) VALBAJ1,   case   when open..LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(ob1.Order_id) = 'A'   then OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),ob2.Item_value)   else 'N/A'   end  VALBAJ2,    case    when open..LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(ob1.Order_id) = 'A'    then  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),           ((((os1.item_value + subida_2.item_value)/2) + ((ob1.item_value + ob2.item_value)/2))/2)           - ob1.pattern_value)    when open..LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(ob1.Order_id) = 'B'    then  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),          ((((os1.item_value + subida_2.item_value)/2) + ob1.item_value)/2)          - ob1.pattern_value)    else OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),         ((ob1.Item_value + os1.item_value)/2)         - ob1.pattern_value)    end  ERROR_PROM,    case    when open..LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(ob1.Order_id) = 'A'    then  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),          ABS(((ob1.Item_value + ob2.item_value)/2) - ((os1.item_value + subida_2.item_value)/2)) )    else OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),         ABS(ob1.Item_value - os1.item_value) )    end  HISTERESIS  FROM open.OR_order_act_measure  ob1  left join  open.OR_order_act_measure  ob2  ON ob1.pattern_value = ob2.pattern_value   and ob2.variable_id = 15    and ob1.order_id = ob2.order_id,  open.OR_order_act_measure os1  left join  open.OR_order_act_measure subida_2  ON os1.pattern_value = subida_2.pattern_value   and subida_2.variable_id = 13    and os1.order_id = subida_2.order_id  WHERE  ob1.Order_id = :ORDER_ID   AND ob1.variable_id =14  AND os1.variable_id = 12  and ob1.pattern_value = os1.pattern_value  AND ob1.order_id = os1.order_id  order by  to_number(  OPEN.LDC_BOMETROLOGIA.fsbCifrasDeci(OPEN.LDC_BOMETROLOGIA.fsbGetIncertidumbreSig(ob1.Order_id),ob1.pattern_value))
select *
from GE_NOTIFICATION_LOG;

SELECT OPEN.ldc_bometrologia.valCertAjuste(36854434) FROM DUAL;
SELECT OPEN.ldc_bometrologia. select notification_id FROM OPEN.ge_notification
        WHERE xsl_template_id = 2159
        AND rownum  = 1;fnugetIdPlanilla(36854434) FROM DUAL;
SELECT OPEN.ldc_bometrologia.fsbTipoClienteCertif(36854434) FROM DUAL;
SELECT OPEN.ldc_bometrologia.fnugetIdNotificacion(2158) FROM DUAL;

  select PLTEXSTE FROM  OPEN.ldc_plantemp
        WHERE  pltevate = 12
        AND pltetipo =  'I'
         AND pltelabo not like '%0'
        AND rownum  = 1;
----parametros para emitir alertas
select *
from OPEN.GE_MESG_ALERT;

select *
from OPEN.GE_PERSON_ALERT al, open.ge_person p
where al.mesg_alert_id in (669,689,929,969,989)
and p.person_id=al.person_id
---        
        
SELECT o.variable_id,
OPEN.LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre, o.pattern_value)||' '||OPEN.LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) PATTERN,
OPEN.LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre, O.item_value)||' '||OPEN.LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) TEMP_ITEM,
OPEN.LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre,(O.item_value - o.pattern_value))||' '||OPEN.LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) ERROR,
c.incertidumbre ||' '||OPEN.LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) INCERTIDUMBRE
FROM OPEN.OR_order_act_measure o, OPEN.LDC_DATOS_CERTIFICADO_MET c
WHERE o.order_id  = 52074207--36854434
and o.order_id = c.order_id
and o.variable_id = 34
union all
select null variable_id, null PATTERN, null TEMP_ITEM, null ERROR, null INCERTIDUMBRE
FROM OPEN.OR_order_act_measure   o
WHERE o.order_id  = 52074207--36854434
--and o.variable_id = 214
and o.pattern_value is not null
and rownum = 1
union all
SELECT o.variable_id,
OPEN.LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre, o.pattern_value)||' '||OPEN.LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) PATTERN,
OPEN.LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre, O.item_value)||' '||OPEN.LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) TEMP_ITEM,
OPEN.LDC_BOmetrologia.fsbCifrasDeci(c.incertidumbre,(O.item_value - o.pattern_value))||' '||OPEN.LDC_BOMETROLOGIA.fsbgetUnidadMedida(o.ORDER_ID) ERROR,
OPEN.LDC_BOmetrologia.fsbGetIncertidumbreConcNomi(o.ORDER_ID) INCERTIDUMBRE
FROM OPEN.OR_order_act_measure o, OPEN.LDC_DATOS_CERTIFICADO_MET c
WHERE o.order_id  = 52074207 --36854434
and o.order_id = c.order_id
and o.variable_id = 214        
      
SELECT * FROM open.LDC_DATOS_CERTIFICADO_MET;
select *
from OPEN.sa_executable
where UPPER(name) like ('%LAB%');

select *
from open.ge_object
where object_id=121098
select *
from open.or_order
where order_id=36854434;

select *
from open.or_uni_item_bala_mov m,open.ge_items_documento d 
where m.operating_unit_id=3102
  and m.items_id=10004070
--  and m.movement_type='D'
  and m.id_items_documento=d.id_items_documento;
SELECT *
FROM OPEN.OR_ORDER
WHERE ORDER_ID=49093292;  
SELECT *
FROM OPEN.OR_RELATED_ORDER
WHERE ORDER_ID=49093292 OR
      RELATED_ORDER_ID=49093292;
      
SELECT *
FROM OPEN.OR_ORDER_sTAT_CHANGE
WHERE ORDER_ID=49093292;
SELECT *
FROM OPEN.SA_USER S,OPEN.GE_PERSON P
WHERE S.USER_ID=P.USER_ID
  AND S.MASK='BLACAMBA';
select *
from open.ge_causal
where causal_id in (3369,3370)
select *
from open.or_operating_unit
where operating_unit_id in (2013,1858);


SELECT *
FROM OPEN.OR_ORDER
WHERE ORDER_ID=51611003;

select * from open.cupon c, open.suscripc s, open.mo_motive m, open.mo_packages p
where  c.cupoflpa='N' and c.cupoprog not in ('MIGRA') and c.cupotipo in ('AF','CA','FA','DE') and c.cupofech > to_date ('30/11/2015','dd/mm/yyyy')
      and p.user_id='ABRARI'
      and trunc(c.cupofech)=trunc(p.attention_date)
      and c.cuposusc=s.susccodi
      and m.subscription_id= s.susccodi
      and p.package_id=m.package_id;
      
      
