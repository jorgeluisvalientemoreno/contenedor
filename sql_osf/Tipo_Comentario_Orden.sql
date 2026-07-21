select gct.comment_type_id || ' - ' || gct.description Tipo_Comentario,
       gct.comment_class_id || ' - ' || gcc.description Clasificacion_Comentario,
       gct.company_key,
       gct.printable,
       decode(gct.category,
              'C',
              'C: [CLIENTE]',
              'E',
              'E: [EMPRESA]',
              gct.category) Categoria
  from OPEN.GE_COMMENT_TYPE gct
 inner join OPEN.ge_comment_class gcc
    on gcc.comment_class_id = gct.comment_class_id
 where 1 = 1
   and gct.comment_type_id = 30
 order by gct.comment_type_id asc
