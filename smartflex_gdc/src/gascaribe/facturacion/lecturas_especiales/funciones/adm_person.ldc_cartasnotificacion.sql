CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_CARTASNOTIFICACION(nunoti NUMBER) 
RETURN VARCHAR2 IS
/**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  ldc_cartasnotificacion

  Descripción  : Muestra el texto para las notificaciones de las criticas

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 14-02-2013

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  07/02/2023     Adrianavg            OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON
                                      Se declaran variables para la gestión de trazas
                                      Se adiciona bloque de exceptiones when others según pautas técnicas 
  **************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzApi; 
    csbInicio   	       CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;		
    Osberrormessage      VARCHAR2(2000);
    
    SBtexto varchar2(3000);
    
BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' nunoti: ' || nunoti, csbNivelTraza); 

 SELECT decode(nunoti,NVL(dald_parameter.fnuGetNumeric_Value('COD_DESV_SIGN',NULL),-1),'Nos permitimos informarle, que al realizar el proceso de toma de lectura para medir  el consumo a facturar de '||NVL((SELECT pefadesc FROM perifact WHERE pefacodi = obtenervalorinstancia('CM_NOTICRIT','NOCRPEFA')),'DICIEMBRE13')||', se detectó una desviación significativa con un consumo a facturar por encima del promedio con relación a los periodos anteriores.
      Por lo anterior la Empresa expedirá la factura para el presente período de facturación, con base en consumos de  períodos anteriores, mientras se hace la respectiva investigación de la desviación con visita técnica, tal como lo establece el artículo 149 de la Ley 142 de 1994 De la Revisión Previa: Al preparar las facturas, es obligación de las empresas investigar las desviaciones significativas  frente a consumos anteriores.   Mientras se establezca la causa, la factura se hará con base en la de periodos anteriores o en la de suscriptores o usuarios en circunstancias semejantes o mediante aforo individual; y al aclarar la causa de las desviaciones, las diferencias frente  a los valores que se cobraron se abonaran  o cargaran al suscriptor  o usuario según sea el caso.
      Realizada la inspección técnica, se determinará si es necesario o no realizar un ajuste por concepto de consumo y en su próxima factura se vería reflejado el valor de dicho ajuste.
      Agradecemos su comprensión y cualquier inquietud al respecto no dude en comunicarse con nuestra línea de atencion al cliente  01-8000-528-888 en la que con gusto será atendido.
      Yo __________________con cedula de ciudadanía No._____________ de _________ y número telefónico _________________
      bajo la gravedad del juramento doy fe que visite el predio el día ____________ y no encontré al usuario.
      Nombre testigo 1                           		Nombre testigo 1                          
      Cedula  		Cedula  
      Teléfono  		Teléfono  
      Departamento de Facturacion',NVL(dald_parameter.fnuGetNumeric_Value('COD_PROM_CAUS_NO_LECT',NULL),-1),'Nos permitimos informarle, que al realizar el proceso de toma de lectura el dia '||(SELECT leemfele
  FROM lectelme l,obselect o
 WHERE leemsesu   = obtenervalorinstancia('CM_NOTICRIT','NOCRSESU')
   AND leempefa   = obtenervalorinstancia('CM_NOTICRIT','NOCRPEFA')
   AND leemclec   = 'F'
   AND leemleto   IS NULL
   AND leemoble   = o.oblecodi
   AND o.oblecanl = 'S'
   AND leemfele   = (SELECT MAX(leemfele)
                       FROM lectelme t
                      WHERE leemsesu = l.leemsesu
                        AND leempefa = l.leempefa
                        AND leemclec = 'F'
                        AND leemleto   IS NULL
                        AND leemoble   = o.oblecodi
                        AND o.oblecanl = 'S'))
||' para determinar el consumo a facturar de el mes de '||NVL((SELECT pefadesc FROM perifact WHERE pefacodi = obtenervalorinstancia('CM_NOTICRIT','NOCRPEFA')),'DICIEMBRE13')||', no fue posible tener acceso al centro de medición por la causal de no lectura '||(SELECT o.oblecodi||'-'||o.obledesc
  FROM lectelme l,obselect o
 WHERE leemsesu   = obtenervalorinstancia('CM_NOTICRIT','NOCRSESU')
   AND leempefa   = obtenervalorinstancia('CM_NOTICRIT','NOCRPEFA')
   AND leemclec   = 'F'
   AND leemleto   IS NULL
   AND leemoble   = o.oblecodi
   AND o.oblecanl = 'S'
   AND leemfele   = (SELECT MAX(leemfele)
                       FROM lectelme t
                      WHERE leemsesu = l.leemsesu
                        AND leempefa = l.leempefa
                        AND leemclec = 'F'
                        AND leemleto   IS NULL
                        AND leemoble   = o.oblecodi
                        AND o.oblecanl = 'S'))
 ||', por lo cual la liquidacion de su consumo para este mes será con base en consumos de  períodos anteriores.
      Lo anterior es de carácter ineludible de acuerdo al contrato de condiciones uniformes capitulo V numeral 34 parágrafos f: ¿Permitir la revisión de los medidores y reguladores, y la lectura periódica de los consumos, y destinar para la instalación de los medidores, sitios de fácil acceso para los funcionarios y/o personal debidamente autorizado por la EMPRESA. Para tal efecto el usuario proporcionara y mantendrá un espacio adecuado para el medidor y equipo conexo¿.
      Comedidamente  le solicitamos tener presente las fechas de toma de lectura mensual que oscila entre los '||(SELECT TO_NUMBER(to_char(p.pefaffmo-3,'dd')) FROM perifact p WHERE p.pefacodi = obtenervalorinstancia('CM_NOTICRIT','NOCRPEFA'))||' y '||(select TO_NUMBER(to_char(p.pefaffmo-3,'dd')) FROM perifact p WHERE p.pefacodi = obtenervalorinstancia('CM_NOTICRIT','NOCRPEFA'))||' de cada mes permitiendo así el libre acceso de nuestros funcionarios al centro de medición para que estos tomen la lectura, evitando realizar cobros de consumos promedios.
      RECUERDE: Debe tener un libre acceso al centro de medición y su odómetro estar visible para permitir la toma de lectura, si al término de treinta (30) días no se ha solucionado la causal de no lectura, la empresa procederá a realizar la suspension del servicio, de acuerdo al contrato de condiciones uniformes capítulo VII Caso C. Suspension por incumplimiento del contrato. parágrafo i: ¿ Impedir a los funcionarios autorizados por la EMPRESA y debidamente identificados, la inspección de las instalaciones internas, equipos de regulación y medida o lectura de contadores.
      Departamento de Facturacion ',NVL(dald_parameter.fnuGetNumeric_Value('COD_SUSP_NO_PERM_LECT',NULL),-1),'Nos permitimos informarle que en varios periodos de consumo se ha dectectado que no se ha podido ejecutar la toma de lectura encontrando en el centro de medicion un impedimento para la toma de lectura por lo cual le informamos que para el proximo periodo se realizara la suspension del servicio de gas por no permitir lectura. En ocasiones anteriores se le ha notificado mediante comunicados sobre el impedimento que existe en su predio el cual no permite la toma de lectura, obligando a la empresa a realizar liquidación de consumo por cobro promedio. Segun lo expresado en el Contrato de Condiciones Uniformes Capítulo VII  Supension del servicio Caso C, literal t : Cuando por accion u omision del USUARIO y/o SUSCRIPTOR sea imposible medir el consumo.
      Para evitar la suspension del  SERVICIO DE GAS, debera adecuar y limpiar el centro de medicion con el fin de permitir una toma de lectura clara y sin impedimentos para la proxima fecha de lectura, de no ser así la empresa programará la orden de suspensión del servicio.
      Cualquier inquietud no dude en comunicarse con nuestra linea de servicio al cliente 01-8000-528-888 en la que con gusto sera atendido Departamento de Facturacion','NO EXISTE EL ASUNTO') INTO SBtexto
  FROM dual;
  
  pkg_traza.trace(csbMetodo ||' SBtexto: ' || SBtexto, csbNivelTraza);
  pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
  RETURN SBtexto;

EXCEPTION
    WHEN OTHERS THEN  
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RETURN SBtexto;
END LDC_CARTASNOTIFICACION;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_CARTASNOTIFICACION
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CARTASNOTIFICACION', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion LDC_CARTASNOTIFICACION
GRANT EXECUTE ON ADM_PERSON.LDC_CARTASNOTIFICACION TO REPORTES;
/