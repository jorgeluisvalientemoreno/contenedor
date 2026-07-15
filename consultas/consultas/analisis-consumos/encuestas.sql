select *
from open.ldc_encuesta   e, open.LDC_GRUPO_PREGUNTA gp, open.ldc_pregunta p, open.ldc_respuesta r
where orden_id=13364869
  and e.grupo_pregunta_id=gp.grupo_pregunta_id
   and e.pregunta_id=p.pregunta_id
   and e.respuesta=r.respuesta_id(+)         
   
   --Tablas del módulo --------------------------------------------
--Encuestas
select * from open.ldc_encuesta_gasera;
--Encuestas por grupo de preguntas
select * from open.ldc_encuesta_grupo_pregunta;
--Encuestas por tipo de trabajo
select * from open.ldc_encuesta_tipo_trabajo;
--Grupos de preguntas
select * from open.LDC_GRUPO_PREGUNTA;
--Grupos de respuestas
select * from open.LDC_GRUPO_RESPUESTA;
--Pregunta por grupo de respuesta

--Preguntas
select * from open.ldc_pregunta;
--Pregunta por grupo de pregunta
select * from open.LDC_PREGUNTA_GRUPO;
--Respuestas
select * from open.ldc_respuesta;
--Respuesta por grupo de respuesta
select * from open.ldc_respuesta_grupo;
--Tipo de respuestas
select * from open.LDC_TIPO_RESPUESTA_PREGUNTA;

--Resultado encuesta
select * from open.ldc_encuesta;


select *
from LDC_ENCUESTA
where orden_id=141755372
for update;


select *
from open.ldci_infgestotmov m
where order_id in (176594004, 176594300);
