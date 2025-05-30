declare

  sbEntidad      VARCHAR2(4000);
  sbPaqueteOPEN  VARCHAR2(4000);
  sbPaqueteNuevo VARCHAR2(4000);

  sbEsquemaOPEN  VARCHAR2(4000);
  sbEsquemaNuevo VARCHAR2(4000);

  CURSOR cuge_entity_attributes is
  select b.technical_name,
         b.comment_,
         gat.attribute_type_id,
         gat.description,
         gat.internal_type,
         gat.internal_java_type
    from ge_entity_attributes b, Ge_Attributes_Type gat
   where b.entity_id in
         (select a.entity_id from ge_entity a where a.name_ = upper(sbEntidad))
     and gat.attribute_type_id = b.attribute_type_id;
  rfcuge_entity_attributes cuge_entity_attributes%rowtype;

  CURSOR cuMetodoGetOPEN(sbAtributo VARCHAR2) is
    select procedure_name
      from all_procedures
     where owner = sbEsquemaOPEN
       and upper(object_name) = upper(sbPaqueteOPEN)
       and upper(procedure_name) like upper('%Get' || sbAtributo || '%')
     group by procedure_name;
  rfcuMetodoGetOPEN cuMetodoGetOPEN%rowtype;

  CURSOR cuMetodoObtNuevo(sbAtributo VARCHAR2) is
    select procedure_name
      from all_procedures
     where owner = sbEsquemaNuevo
       and upper(object_name) = upper(sbPaqueteNuevo)
       and upper(procedure_name) like upper('%Obt' || sbAtributo || '%')
     group by procedure_name;
  rfcuMetodoObtNuevo cuMetodoObtNuevo%rowtype;

  CURSOR cuMetodoUpdOPEN(sbAtributo VARCHAR2) is
    select procedure_name
      from all_procedures
     where owner = sbEsquemaOPEN
       and upper(object_name) = upper(sbPaqueteOPEN)
       and upper(procedure_name) like upper('%Upd' || sbAtributo || '%')
     group by procedure_name;
  rfcuMetodoUpdOPEN cuMetodoUpdOPEN%rowtype;

  CURSOR cuMetodoAcNuevo(sbAtributo VARCHAR2) is
    select procedure_name
      from all_procedures
     where owner = sbEsquemaNuevo
       and upper(object_name) = upper(sbPaqueteNuevo)
       and upper(procedure_name) like upper('%Ac' || sbAtributo || '%')
     group by procedure_name;
  rfcuMetodoAcNuevo cuMetodoAcNuevo%rowtype;

  sbTipo VARCHAR2(100);
  
begin

  sbEsquemaOPEN  := 'OPEN';
  sbEsquemaNuevo := 'ADM_PERSON';

  sbEntidad      := 'ldc_titrdocu';
  sbPaqueteOPEN  := 'daldc_titrdocu';--'pktblplandife';--
  sbPaqueteNuevo := 'pkg_ldc_titrdocu';

  for rfcuge_entity_attributes in cuge_entity_attributes loop
    ---Servicios GET
    for rfcuMetodoGetOPEN in cuMetodoGetOPEN(rfcuge_entity_attributes.technical_name) loop
      for rfcuMetodoObtNuevo in cuMetodoObtNuevo(rfcuge_entity_attributes.technical_name) loop
        DBMS_OUTPUT.put_line('
DECLARE
  NUCANTIDAD NUMBER;
BEGIN
  
  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('''||sbPaqueteNuevo || '.' ||rfcuMetodoObtNuevo.procedure_name||''');
  
  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('''||sbEsquemaOPEN||''',
       UPPER('''||sbPaqueteOPEN || '.' ||rfcuMetodoGetOPEN.procedure_name||'''),
       ''Obtener '||rfcuge_entity_attributes.comment_||''',
       '''||sbEsquemaNuevo||''',
       UPPER('''||sbPaqueteNuevo || '.' ||rfcuMetodoObtNuevo.procedure_name||'''),
       ''Obtener '||rfcuge_entity_attributes.comment_||''',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line(''El servicio destino ' || sbPaqueteNuevo || '.' ||
                         rfcuMetodoObtNuevo.procedure_name ||
                         ' fue homologado al servicio origen ' ||
                         sbPaqueteOPEN || '.' ||
                         rfcuMetodoGetOPEN.procedure_name ||
                         ' de forma exisosa'');
  ELSE
    DBMS_OUTPUT.put_line(''El servicio destino ' || sbPaqueteNuevo || '.' ||
                         rfcuMetodoObtNuevo.procedure_name ||
                         ' ya fue homologado a un servicio origen.'');
  END IF;
  
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line(''El servicio destino ' || sbPaqueteNuevo || '.' ||
                         rfcuMetodoObtNuevo.procedure_name ||
                         ' ya fue homologado a un servicio origen.'');
END;
/');
      end loop;
    end loop;
  
    ---Servicios UPDATE
    for rfcuMetodoUpdOPEN in cuMetodoUpdOPEN(rfcuge_entity_attributes.technical_name) loop
      for rfcuMetodoAcNuevo in cuMetodoAcNuevo(rfcuge_entity_attributes.technical_name) loop                               
        DBMS_OUTPUT.put_line('
DECLARE
  NUCANTIDAD NUMBER;
BEGIN
  
  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('''||sbPaqueteNuevo || '.' ||rfcuMetodoAcNuevo.procedure_name||''');
  
  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('''||sbEsquemaOPEN||''',
       UPPER('''||sbPaqueteOPEN || '.' ||rfcuMetodoUpdOPEN.procedure_name||'''),
       ''Actualizar '||rfcuge_entity_attributes.comment_||''',
       '''||sbEsquemaNuevo||''',
       UPPER('''||sbPaqueteNuevo || '.' ||rfcuMetodoAcNuevo.procedure_name||'''),
       ''Actualizar '||rfcuge_entity_attributes.comment_||''',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line(''El servicio destino ' || sbPaqueteNuevo || '.' ||
                         rfcuMetodoAcNuevo.procedure_name ||
                         ' fue homologado al servicio origen ' ||
                         sbPaqueteOPEN || '.' ||
                         rfcuMetodoUpdOPEN.procedure_name ||
                         ' de forma exisosa'');
  ELSE
    DBMS_OUTPUT.put_line(''El servicio destino ' || sbPaqueteNuevo || '.' ||
                         rfcuMetodoAcNuevo.procedure_name ||
                         ' ya fue homologado a un servicio origen.'');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line(''El servicio destino ' || sbPaqueteNuevo || '.' ||
                         rfcuMetodoAcNuevo.procedure_name ||
                         ' ya fue homologado a un servicio origen.'');
END;
/');  
      end loop;
    end loop;
  
  end loop;


----------------------------------
  for rfcuge_entity_attributes in cuge_entity_attributes loop

      IF rfcuge_entity_attributes.description = 'NUMBER' THEN
        sbTipo := 'fnu';
      ELSIF rfcuge_entity_attributes.description = 'VARCHAR2' THEN
        sbTipo := 'fsb';
      ELSIF rfcuge_entity_attributes.description = 'BOOLEAN' THEN
        sbTipo := 'fbl';
      ELSIF rfcuge_entity_attributes.description = 'DATE' THEN
        sbTipo := 'fdt';
      END IF;

      for rfcuMetodoObtNuevo in cuMetodoObtNuevo(rfcuge_entity_attributes.technical_name) loop
    ---Servicios GET
        DBMS_OUTPUT.put_line('
DECLARE
  NUCANTIDAD NUMBER;
BEGIN
  
  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('''||sbPaqueteNuevo || '.'|| sbTipo ||'get' ||rfcuge_entity_attributes.technical_name||''');
  
  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('''||sbEsquemaOPEN||''',
       UPPER('''||sbPaqueteOPEN || '.'|| sbTipo ||'get' ||rfcuge_entity_attributes.technical_name||'''),
       ''Obtener '||rfcuge_entity_attributes.comment_||''',
       '''||sbEsquemaNuevo||''',
       UPPER('''||sbPaqueteNuevo || '.' ||rfcuMetodoObtNuevo.procedure_name||'''),
       ''Obtener '||rfcuge_entity_attributes.comment_||''',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line(''El servicio destino ' || sbPaqueteNuevo || '.'|| 
                         rfcuMetodoObtNuevo.procedure_name ||
                         ' fue homologado al servicio origen ' ||
                         sbPaqueteOPEN || '.' ||sbTipo ||'get' ||
                         rfcuge_entity_attributes.technical_name ||
                         ' de forma exisosa'');
  ELSE
    DBMS_OUTPUT.put_line(''El servicio destino ' || sbPaqueteNuevo ||'.'|| sbTipo ||'get' ||
                         rfcuge_entity_attributes.technical_name ||
                         ' ya fue homologado a un servicio origen.'');
  END IF;
  
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line(''El servicio destino ' || sbPaqueteNuevo || '.' ||
                         rfcuge_entity_attributes.technical_name ||
                         ' ya fue homologado a un servicio origen.'');
END;
/');
      end loop;                        
        /*DBMS_OUTPUT.put_line('
DECLARE
  NUCANTIDAD NUMBER;
BEGIN
  
  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('''||sbPaqueteNuevo || '.' ||rfcuge_entity_attributes.technical_name||''');
  
  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('''||sbEsquemaOPEN||''',
       UPPER('''||sbPaqueteOPEN || '.' ||rfcuge_entity_attributes.technical_name||'''),
       ''Actualizar '||rfcuge_entity_attributes.comment_||''',
       '''||sbEsquemaNuevo||''',
       UPPER('''||sbPaqueteNuevo || '.' ||rfcuge_entity_attributes.technical_name||'''),
       ''Actualizar '||rfcuge_entity_attributes.comment_||''',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line(''El servicio destino ' || sbPaqueteNuevo || '.' ||
                         rfcuge_entity_attributes.technical_name ||
                         ' fue homologado al servicio origen ' ||
                         sbPaqueteOPEN || '.' ||
                         rfcuge_entity_attributes.technical_name ||
                         ' de forma exisosa'');
  ELSE
    DBMS_OUTPUT.put_line(''El servicio destino ' || sbPaqueteNuevo || '.' ||
                         rfcuge_entity_attributes.technical_name ||
                         ' ya fue homologado a un servicio origen.'');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line(''El servicio destino ' || sbPaqueteNuevo || '.' ||
                         rfcuge_entity_attributes.technical_name ||
                         ' ya fue homologado a un servicio origen.'');
END;
/');*/  
    
  end loop;

end;
