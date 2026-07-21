SELECT SYS_CONTEXT('USERENV', 'TERMINAL') terminal,
       SYS_CONTEXT('USERENV', 'CURRENT_USER') usuario,
       UT_SESSION.GETUSER,
       PKG_SESSION.FNUGETUSERIDBYMASK Obtiene_id_mascara_usuario,
       PKG_SESSION.FSBGETTERMINAL Retorna_terminal_usuario,
       --PKG_BCPERSONAL.FNUOBTIENEUSUARIO(PKG_SESSION.GETUSERID) Obtiene_id_usuario_persona,
       --PKG_BOPERSONAL.FNUOBTPERSONAPORUSUARIO(PKG_SESSION.GETUSERID) Retorna_configurada_conectado,
       PKG_SESSION.GETUSERID Consultar_id_usuario,
       PKG_SESSION.GETUSER mascara_usuario_conectado,
       --API_GETCUSTUSERSBYPROD( Informacion_Usuarios_Producto,
       PKG_SESSION.GETUSERID Retorna_id_usuario_conectado,
       --PKG_BCUNIDADOPERATIVA.FSBGETNOMBRE() nombre_de_usuario_conectado,
       PKG_SESSION.FNUGETEMPRESADEUSUARIO empresa_del_usuario_conectado

  FROM DUAL;
