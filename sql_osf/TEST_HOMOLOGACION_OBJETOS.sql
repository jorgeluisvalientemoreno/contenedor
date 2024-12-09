DECLARE

  CURSOR cuHOMOLOGACIONES IS
    select servicio_origen, servicio_destino
      from homologacion_servicios
     where servicio_origen is not null
     group by servicio_origen, servicio_destino;

  rfHOMOLOGACIONES cuHOMOLOGACIONES%ROWTYPE;

  CURSOR cuCODIGOFUENTE(sbOBJETO VARCHAR2) IS
    select ds.TEXT
      from dba_source ds
     where upper(ds.name) = upper(sbOBJETO);

  rfCODIGOFUENTE cuCODIGOFUENTE%ROWTYPE;

  nuExisteHomologacion NUMBER;

BEGIN

  FOR rfCODIGOFUENTE in cuCODIGOFUENTE('pkg_bocambio_de_uso') LOOP
  
    FOR rfHOMOLOGACIONES in cuHOMOLOGACIONES LOOP
    
        dbms_output.put_line(upper(rfHOMOLOGACIONES.servicio_destino));
      nuExisteHomologacion := instr(upper(rfHOMOLOGACIONES.servicio_destino),
                                    upper(rfCODIGOFUENTE.TEXT));
    
      IF nuExisteHomologacion = 1 THEN
        dbms_output.put_line(rfHOMOLOGACIONES.servicio_origen);
      END IF;
    
    END LOOP;
  
  END LOOP;

END;
/
