DECLARE

  CURSOR cuObjetoAccion(InuIDACCION        number,
                        IsbTIPOACCION      varchar2,
                        IsbNOMBREOBJETO    varchar2,
                        InuTIPOTRABAJO     number,
                        InuIDACTIVIDAD     number,
                        InuIDCAUSAL        number,
                        InuUNIDADOPERATIVA number) IS
    select count(1)
      from PERSONALIZACIONES.Objetos_Accion
     where IDACCION = InuIDACCION
       and TIPOACCION = IsbTIPOACCION
       and NOMBREOBJETO = IsbNOMBREOBJETO
       and nvl(TIPOTRABAJO, 0) = nvl(InuTIPOTRABAJO, 0)
       and nvl(IDACTIVIDAD, 0) = nvl(InuIDACTIVIDAD, 0)
       and nvl(IDCAUSAL, 0) = nvl(InuIDCAUSAL, 0)
       and nvl(UNIDADOPERATIVA, 0) = nvl(InuUNIDADOPERATIVA, 0);

  nuExiste number;

BEGIN

  open cuObjetoAccion(7,
                      'PRE',
                      'OAL_VALIDATRANSITOENTRANTEBOD',
                      NULL,
                      NULL,
                      NULL,
                      NULL);
  fetch cuObjetoAccion
    into nuExiste;
  close cuObjetoAccion;
  if nuExiste = 0 then
    BEGIN
      INSERT INTO PERSONALIZACIONES.OBJETOS_ACCION
        (IDACCION,
         TIPOACCION,
         NOMBREOBJETO,
         TIPOTRABAJO,
         IDACTIVIDAD,
         IDCAUSAL,
         UNIDADOPERATIVA,
         DESCRIPCION,
         PROCESONEGOCIO,
         ORDENEJECUCION,
         ACTIVO,
         FECHACREACION)
      VALUES
        (7,
         'PRE',
         'OAL_VALIDATRANSITOENTRANTEBOD',
         NULL,
         NULL,
         NULL,
         NULL,
         'VALIDA TRANSITO ENTRANTE DE ITEMS EN BODEGAS',
         15,
         1,
         'S',
         sysdate);
      commit;
      dbms_output.put_line('El registro del Objeto Accion llamado OAL_VALIDATRANSITOENTRANTEBOD en el Tipo de Accion PRE fue registrada con exito.');
    exception
      when others then
        rollback;
        dbms_output.put_line('Error al registrar del Objeto Accion llamado OAL_VALIDATRANSITOENTRANTEBOD en el Tipo de Accion PRE.');
    END;
  else
    dbms_output.put_line('La configuracion del Objeto Accion llamado OAL_VALIDATRANSITOENTRANTEBOD en el Tipo de Accion PRE ya existe.');
  end if;
  
END;
/
