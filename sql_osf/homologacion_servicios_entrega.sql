DECLARE
/*
    1. Encender salida por dbms_output
    2. Cambiar nombre de la variable ISBOBJETO por el objeto a revisar
    3. El resultado tiene las columnas separadas por el caracter |
*/

    ISBOBJETO         VARCHAR2(200) := 'LDCI_PKMOVIVENTMATE';
    
    csbPrueba         CONSTANT VARCHAR2(50) := 'Valida_dependencias';
    nuErrorCode       NUMBER;
    sbErrorMessage    VARCHAR2(4000);

begin
    
    dbms_output.put_line('Sesión para la traza:'|| SYS_CONTEXT('USERENV','SESSIONID'));
    pkg_traza.setlevel(99);----establece el nivel de traza a mostrar    
    pkg_traza.Init;--Borra las trazas generadas anteriormente para session current
    --pkg_traza.traza_tabla;--Indica que la traza se inserta en la tabla ge_log_trace
    pkg_traza.traza_dbms_output;--genera la traza en dbms_output

    pkg_traza.trace('Incio de la prueba funcionalidad: '||csbPrueba,1);
        
    --Escribe cuántos objetos están usando el objeto enviado
    --pkg_homologaserv_util.prValidaDependen(isbobjeto => isbobjeto);
 
    --Escribe el detalle de los objetos que usan el objeto enviado
    --pkg_homologaserv_util.prdetalleDependen(isbobjeto => isbobjeto);    

    --Escribe los objetos a homologar que está usando el objeto enviado.    
    pkg_homologaserv_util.prvalidahomologa(isbobjeto => isbobjeto);  
    
    
    --Escribe los objetos a homologar que está usando el objeto enviado
    --Incluyendo línea donde es usado
    --pkg_homologaserv_util.prvalidahomologaLinea(isbobjeto => isbobjeto);  


    --Escribe los objetos no homologados que usa el objeto  
    --pkg_homologaserv_util.prValidaUsadoNoHomologa(isbobjeto => isbobjeto);  
           
    --Escribe todos los objetos que está usando el objeto enviado
    --pkg_homologaserv_util.prValidaUsados(isbobjeto => isbobjeto);
    
    --Escribe la línea en la que se están usando los objetos de bd
    --pkg_homologaserv_util.prValidaUsadosLinea(isbobjeto => isbobjeto);
    
    
    --Escribe los objetos de producto usados en el objeto
    --pkg_homologaserv_util.prValidaProducto(isbobjeto => isbobjeto);
    

    pkg_traza.trace('Fin OK de la prueba funcionalidad: '||csbPrueba,1);
  
exception
    WHEN pkg_Error.CONTROLLED_ERROR THEN        
        pkg_traza.trace('Fin con ERROR CONTROLADO de la prueba funcionalidad: '||csbPrueba,1);
        pkg_Error.GETERROR(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('---------------error----------------------');
        dbms_output.put_line(nuErrorCode||'-'||sbErrorMessage);
        dbms_output.put_line('------------------------------------------');
    when others then
        pkg_traza.trace('Fin con ERRORES de la prueba funcionalidad: '||csbPrueba,1);
     
END;        

/