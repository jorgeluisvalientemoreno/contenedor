--consulta las interacciones para generar el eform
select distinct rec.interaccion
  from open.LDC_ORDEELDORCD@smartflexpruebas Rec;

--consulta los datos para llenar la kw 
with data as ( select   Rec.interaccion,rec.orden_id,Rec.contrato,
       Rec.categoria,Rec.subcategoria,Rec.descripcion_localidad,Rec.nombre_cliente,
       Rec.direccion,Rec.telefono,Rec.email
        from open.LDC_ORDEELDORCD@smartflexpruebas Rec  where rec.interaccion=144397897
        order by rec.contrato)
select * from data where rownum=1;

--consulta todos los comentarios de la interacción y los unifica en un solo campo
SELECT comen, LISTAGG (texto, chr(13)) WITHIN GROUP (ORDER BY comeordor_id) from( 
       select   
       coment.comeordor_id,
       coment.orden_id,
       'comentario' comen,
       coment.comentario texto
        from open.LDC_ORDEELDORCD@smartflexpruebas Rec, open.LDC_COMEORDORCD@smartflexpruebas coment  where rec.interaccion=144398218
               and rec.orden_id=coment.orden_id
               order by coment.comeordor_id
               )
GROUP BY comen
