CREATE OR REPLACE PROCEDURE adm_person.ldc_procrearegasiunioprevper(nupaunidoper NUMBER,nupaproducto NUMBER,nupatiptrab NUMBER,nupaordeb NUMBER,nupasoli NUMBER) IS
    /**************************************************************************
    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    16/05/2024          Adrianavg          OSF-2675: Se migra del esquema OPEN al esquema ADM_PERSON
   **************************************************************************/
BEGIN
 INSERT INTO ldc_asigna_unidad_rev_per VALUES(nupaunidoper,nupaproducto,nupatiptrab,nupaordeb,nupasoli);
EXCEPTION
 WHEN OTHERS THEN
  NULL;
END;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PROCREAREGASIUNIOPREVPER
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROCREAREGASIUNIOPREVPER', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_PROCREAREGASIUNIOPREVPER
GRANT EXECUTE ON ADM_PERSON.LDC_PROCREAREGASIUNIOPREVPER TO REXEREPORTES;
/