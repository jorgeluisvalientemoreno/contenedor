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
       and TIPOTRABAJO = InuTIPOTRABAJO
       and nvl(IDACTIVIDAD, 0) = nvl(InuIDACTIVIDAD, 0)
       and nvl(IDCAUSAL, 0) = nvl(InuIDCAUSAL, 0)
       and nvl(UNIDADOPERATIVA, 0) = nvl(InuUNIDADOPERATIVA, 0);

  nuExiste number;

BEGIN

  open cuObjetoAccion(7,
                      'POST',
                      'OAL_CERTIFICADO_DANO_PRODUCTO',
                      10444,
                      NULL,
                      9265,
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
         'POST',
         'OAL_CERTIFICADO_DANO_PRODUCTO',
         10444,
         NULL,
         9265,
         NULL,
         'GENERA REGISTRO DANO A PRODUCTO',
         1,
         1,
         'S',
         sysdate);
      commit;
      dbms_output.put_line('El registro del Objeto Accion llamado OAL_CERTIFICADO_DANO_PRODUCTO en la Tipo de Accion POST para el tipo de trabajo 10444 fue realizado con exito.');
    exception
      when others then
        rollback;
        dbms_output.put_line('Error al insertar el registro del Objeto Accion OAL_CERTIFICADO_DANO_PRODUCTO para Tipo de Accion POST con el tipo de trabajo 10444.');
    END;
  else
    dbms_output.put_line('La configuracion del Objeto Accion OAL_CERTIFICADO_DANO_PRODUCTO en la Tipo de Accion POST para el tipo de trabajo 10444 ya existe.');
  end if;

  open cuObjetoAccion(7,
                      'POST',
                      'OAL_CERTIFICADO_DANO_PRODUCTO',
                      10795,
                      NULL,
                      9265,
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
         'POST',
         'OAL_CERTIFICADO_DANO_PRODUCTO',
         10795,
         NULL,
         9265,
         NULL,
         'GENERA REGISTRO DANO A PRODUCTO',
         1,
         1,
         'S',
         sysdate);
      commit;
      dbms_output.put_line('El registro del Objeto Accion llamado OAL_CERTIFICADO_DANO_PRODUCTO en la Tipo de Accion POST para el tipo de trabajo 10795 fue realizado con exito.');
    exception
      when others then
        rollback;
        dbms_output.put_line('Error al insertar el registro del Objeto Accion OAL_CERTIFICADO_DANO_PRODUCTO para Tipo de Accion POST con el tipo de trabajo 10795.');
    END;
  else
    dbms_output.put_line('La configuracion del Objeto Accion OAL_CERTIFICADO_DANO_PRODUCTO en la Tipo de Accion POST para el tipo de trabajo 10795 ya existe.');
  end if;

END;
/