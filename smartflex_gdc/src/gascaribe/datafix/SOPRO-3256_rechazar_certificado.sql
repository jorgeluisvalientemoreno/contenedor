BEGIN
  update open.ldc_certificados_oia c
    set c.status_certificado = 'R',
        c.obser_rechazo = 'Datafix solicitado caso SOPRO-3256',
        c.fecha_apro_osf = sysdate
  where c.certificados_oia_id  = 4037248
  and c.order_id = 287681448;
  commit;
EXCEPTION
  WHEN others THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END;
/