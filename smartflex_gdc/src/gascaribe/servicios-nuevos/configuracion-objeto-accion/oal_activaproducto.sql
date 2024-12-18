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
                      'OAL_ACTIVAPRODUCTO',
                      12152,
                      NULL,
                      9944,
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
         'OAL_ACTIVAPRODUCTO',
         12152,
         NULL,
         9944,
         NULL,
         'ACTIVA PRODUCTO Y FECHA DE INSTALACION',
         1,
         1,
         'S',
         sysdate);
      commit;
      dbms_output.put_line('El registro del Objeto Accion llamado OAL_ACTIVAPRODUCTO en la Tipo de Accion POST para el tipo de trabajo 12152 fue realizado con exito.');
    exception
      when others then
        rollback;
        dbms_output.put_line('Error al insertar el registro del Objeto Accion OAL_ACTIVAPRODUCTO para Tipo de Accion POST con el tipo de trabajo 12152.');
    END;
  else
    dbms_output.put_line('La configuracion del Objeto Accion OAL_ACTIVAPRODUCTO en la Tipo de Accion POST para el tipo de trabajo 12152 ya existe.');
  end if;

  open cuObjetoAccion(7,
                      'POST',
                      'OAL_ACTIVAPRODUCTO',
                      12150,
                      NULL,
                      9944,
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
         'OAL_ACTIVAPRODUCTO',
         12150,
         NULL,
         9944,
         NULL,
         'ACTIVA PRODUCTO Y FECHA DE INSTALACION',
         1,
         1,
         'S',
         sysdate);
      commit;
      dbms_output.put_line('El registro del Objeto Accion llamado OAL_ACTIVAPRODUCTO en la Tipo de Accion POST para el tipo de trabajo 12150 fue realizado con exito.');
    exception
      when others then
        rollback;
        dbms_output.put_line('Error al insertar el registro del Objeto Accion OAL_ACTIVAPRODUCTO para Tipo de Accion POST con el tipo de trabajo 12150.');
    END;
  else
    dbms_output.put_line('La configuracion del Objeto Accion OAL_ACTIVAPRODUCTO en la Tipo de Accion POST para el tipo de trabajo 12150 ya existe.');
  end if;

  open cuObjetoAccion(7,
                      'POST',
                      'OAL_ACTIVAPRODUCTO',
                      12153,
                      NULL,
                      9944,
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
         'OAL_ACTIVAPRODUCTO',
         12153,
         NULL,
         9944,
         NULL,
         'ACTIVA PRODUCTO Y FECHA DE INSTALACION',
         1,
         1,
         'S',
         sysdate);
      commit;
      dbms_output.put_line('El registro del Objeto Accion llamado OAL_ACTIVAPRODUCTO en la Tipo de Accion POST para el tipo de trabajo 12153 fue realizado con exito.');
    exception
      when others then
        rollback;
        dbms_output.put_line('Error al insertar el registro del Objeto Accion OAL_ACTIVAPRODUCTO para Tipo de Accion POST con el tipo de trabajo 12153.');
    END;
  else
    dbms_output.put_line('La configuracion del Objeto Accion OAL_ACTIVAPRODUCTO en la Tipo de Accion POST para el tipo de trabajo 12153 ya existe.');
  end if;

END;
/