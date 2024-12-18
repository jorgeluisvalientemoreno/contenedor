BEGIN

    -- OSF-2606
    update  master_personalizaciones set COMENTARIO = 'BORRADO'
    where  NOMBRE in ('LDCMOSACA', 'LDCCAMASO', 'DLRHCCI','DLRAPIR','LDRPLAM');
	
    commit;
END;
/