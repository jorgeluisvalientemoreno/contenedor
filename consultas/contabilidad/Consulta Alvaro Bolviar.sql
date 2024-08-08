 SELECT c.clctclco clasificador,
        (select cl.clcodesc from open.ic_clascont cl where cl.clcocodi=c.clctclco) desc_clasificador,
        C.CLCTTITR codigo_tipo_trabajo, 
        open.daor_task_type.fsbgetdescription(c.CLCTTITR, null) desc_tipo_trab,
        tt.ttivinco "Tipo de indicador iva costo",
        tt.ttivinga "Tipo de indicador iva gasto",
        B.ITEMS_ID, 
        open.dage_items.fsbgetdescription(b.items_id, null) desc_item, 
        A.Porcentaje, DECODE(COLUMN_VALUE,'S','SERVICIOS','OC','OBRA CIVIL') TIPO
        FROM open.LDC_TIPO_ACTIVIDAD a, 
        open.LDC_CONSTRUCTION_SERVICE b,
        open.ic_clascott c
         left join open.ldci_titrindiva tt on tt.ttivtitr=c.clcttitr, 
         TABLE(open.Ldc_Boutilities.splitstrings(B.TYPE_ ,'-'))
     

       WHERE A.TIPO_RETENCION = 'RI'

         AND A.tipo_actividad_id = B.type_

         AND B.CLAS_CONTABLE = C.CLCTCLCO
         and column_value in ('OC','S')
         ;
         
with titr as(         
 SELECT C.CLCTTITR codigo_tipo_trabajo
        FROM open.LDC_TIPO_ACTIVIDAD a, open.LDC_CONSTRUCTION_SERVICE b,open.ic_clascott c

       WHERE A.TIPO_RETENCION = 'RI'

         AND A.tipo_actividad_id = B.type_

         AND B.CLAS_CONTABLE = C.CLCTCLCO
        )
select tc.task_type_id tipo_trabajo,
       open.daor_task_type.fsbgetdescription(tc.task_type_id, null) desc_titr,
       co.id_tipo_contrato,
       co.descripcion descripcion_tipo_contrato
from titr, open.ct_tasktype_contype tc, open.ge_tipo_contrato co
where titr.codigo_tipo_trabajo=tc.task_type_id 
  and tc.contract_type_id=co.id_tipo_contrato
  and exists(select null from open.ge_contrato c where c.id_tipo_contrato=co.id_tipo_contrato and c.status='AB')
  union 
select tc.task_type_id tipo_trabajo,
       open.daor_task_type.fsbgetdescription(tc.task_type_id, null) desc_titr,
       co.id_tipo_contrato,
       co.descripcion descripcion_tipo_contrato
from titr, open.ct_tasktype_contype tc, open.ge_contrato c, open.ge_tipo_contrato co
where titr.codigo_tipo_trabajo=tc.task_type_id
  and tc.contract_id=c.id_contrato
  and c.id_tipo_contrato=co.id_tipo_contrato
  and c.status='AB';
         
  
SELECT * FROM open.ldci_titrindiva, open.ic_clascott t WHERE ttivtitr = 12192 and t.clcttitr = ttivtitr;


         
---------------------------------------------------------------------         
         SELECT C.CLCTTITR  , B.ITEMS_ID, B.TYPE_, A.Porcentaje

        FROM open.LDC_TIPO_ACTIVIDAD a, open.LDC_CONSTRUCTION_SERVICE b,open.ic_clascott c

       WHERE A.TIPO_RETENCION = 'RI'

         AND A.tipo_actividad_id = B.type_

         AND B.CLAS_CONTABLE = C.CLCTCLCO;
