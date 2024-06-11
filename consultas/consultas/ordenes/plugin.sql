 SELECT * --TASK_TYPE_ID,CAUSAL_ID,PROCEDIMIENTO,ORDEN_EJEC
      FROM open.ldc_procedimiento_obj
      WHERE
       TASK_TYPE_ID in (1079  )
      ORDER BY TASK_TYPE_ID , ORDEN_EJEC;
      

select i.item_id, it.description, o.object_id, o.name_,i.is_active
from open.ldc_item_obj i
inner join  open.ge_object o on o.object_id=i.object_id
inner join open.ge_items it on it.items_id=i.item_id
where item_id in (4000050,4294537,4295757,4000052,4295273,4295150,4295271,100002373,100002319,4000063,4295758,100002510,4295761,4000051,4000053,4000064,4294344,4294588,4295751,4295760,100002512,100002514,4295270,4295272,4295759,100002509,100002511,100002513,100002515,100002516)
  and i.is_active='Y';


SELECT TASK_TYPE_ID,(SELECT DESCRIPTION FROM OPEN.OR_TASK_TYPE T WHERE T.TASK_TYPE_ID=O.TASK_TYPE_ID ) DESC_TITR,
        CAUSAL_ID,(SELECT DESCRIPTION FROM OPEN.GE_CAUSAL C WHERE C.CAUSAL_ID=O.CAUSAL_ID) DESC_CAUSAL,
        PROCEDIMIENTO,ORDEN_EJEC,activo,
        NVL((select 'S' FROM OPEN.OR_TASK_TYPE_CAUSAL TC WHERE TC.TASK_TYPE_ID=O.TASK_TYPE_ID AND TC.CAUSAL_ID=O.CAUSAL_ID),'N') EXISTE_CONFIG_CAUSAL,
        o.descripcion
      FROM open.ldc_procedimiento_obj O
      WHERE
       /*upper(procedimiento) like upper('%ldcproccreatramirepprptxml%') /*or
       upper(procedimiento) like '%LDCPROCCREATRAMIREVPRPXML%'*/
       task_type_id in (11157)

      and activo='S'
      ORDER BY TASK_TYPE_ID , causal_id,ORDEN_EJEC;


select *
from open.ge_object
where object_id=56324;
