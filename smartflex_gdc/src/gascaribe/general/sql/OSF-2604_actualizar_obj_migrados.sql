BEGIN

    -- OSF-2604
    update  master_personalizaciones set COMENTARIO = 'BORRADO'
    where  NOMBRE in ('LDCIREPINTCONTL');

    update  master_personalizaciones set COMENTARIO = 'BORRADO'
    where  NOMBRE in ('LDC_REPINTECONTABLE');
    
    update  master_personalizaciones set COMENTARIO = 'BORRADO'
    where  NOMBRE in  ('LDC_REPLEYVENTAATECLIE1');

    update  master_personalizaciones set COMENTARIO = 'BORRADO'
    where  NOMBRE in  ('LDC_REPPLANOATECLIE');
    
    update  master_personalizaciones set COMENTARIO = 'BORRADO'
    where  NOMBRE in  ('PKG_EMAILS');
    
    update  master_personalizaciones set COMENTARIO = 'BORRADO'
    where  NOMBRE in  ('LDC_BCPRELIQUIDACIONGC');
    
    update  master_personalizaciones set COMENTARIO = 'BORRADO'
    where  NOMBRE in  ('LD_BOPORTAFOLIO');

    update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
    where  NOMBRE in ('LDC_GENERAVTINGVIS');
    commit;
END;
/