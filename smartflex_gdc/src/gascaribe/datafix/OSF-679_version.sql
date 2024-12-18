DECLARE
  nuCodigoEntrega NUMBER; -- C�digo de la entrega
  
  cursor cuLDC_VERSIONENTREGA is
   select count(1) from LDC_VERSIONENTREGA a where a.nombre_entrega = 'CRM_JV_OSF-679';
  
  nuCantidad number;
  
BEGIN

  open cuLDC_VERSIONENTREGA;
  fetch cuLDC_VERSIONENTREGA into nuCantidad;
  close cuLDC_VERSIONENTREGA;

  if nvl(nuCantidad,0) = 0 then
    -- Calcula consecutivo de entrega
    nuCodigoEntrega := SEQ_LDC_VERSIONENTREGA.NEXTVAL;
    DBMS_OUTPUT.PUT_LINE('Secuencia ['|| nuCodigoEntrega ||'] de la entrega');

    -- VERSION ENTREGA
    insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, 'CRM_JV_OSF-679', sysdate, 'OSF-679', 'INTERACCION SIN FLUJOS');

    --ENTREGA APLICA POR EMPRESA?
    insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
    insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','N');

    -- RELACION DE OBJETOS ENTREGADOS
    insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('cod_tip_sol_per_inter'), 'PARAMETRO');
    insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ldc_interaccion_sin_flujo'), 'TABLA');
    insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ldc_prJobinteraccionsinflujo'), 'PROCEDIMIENTO');
    insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ldc_trg_interaccion'), 'TRIGGER');
    insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ldc_trg_fechaintersinflujo'), 'TRIGGER');
    insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ldc_job_interaccion_sin_flujo'), 'JOB');
    insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ld_bortainteraccion'), 'PAQUETE');
    insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ge_object_121667'), 'FWCOB');
    insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ge_object_121696'), 'FWCOB');
    insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ge_object_121669'), 'FWCOB');
    insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ps_package_type_268'), 'PSCRE');


    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Entrega CRM_JV_OSF-679 creada con �xito');
  else
    DBMS_OUTPUT.PUT_LINE('Ya esta registrada la entrega CRM_JV_OSF-679');
  end if;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error al aplicar la entrega CRM_JV_OSF-679');
  
END;
/
