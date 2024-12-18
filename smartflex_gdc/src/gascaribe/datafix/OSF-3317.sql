begin
  update master_personalizaciones
     set comentario=null
   where nombre = 'TRUNC_LD_QUOTA_BY_SUBSC_TEMP';
  commit;
end;
/
