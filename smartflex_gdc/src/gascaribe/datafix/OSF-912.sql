begin
  delete LDC_PROTECCION_DATOS r where r.rowid in (
    with base as(select r.rowid iden, r.id_cliente,r.cod_estado_ley,r.estado,r.fecha_creacion,r.usuario_creacion,r.package_id, row_number() over ( partition by r.id_cliente,r.cod_estado_ley,r.estado,r.fecha_creacion,r.usuario_creacion,r.package_id order by r.id_cliente) fila
                 from open.LDC_PROTECCION_DATOS r
                )
    select b.iden
    from base b
    where fila>1);
end;
/
