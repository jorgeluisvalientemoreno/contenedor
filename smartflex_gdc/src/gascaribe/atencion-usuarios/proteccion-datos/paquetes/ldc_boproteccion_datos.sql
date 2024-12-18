CREATE OR REPLACE PACKAGE LDC_BOPROTECCION_DATOS

/*****************************************************************
  Unidad         : LDC_BOPROTECCION_DATOS
  Descripcion    : Paquete para la gestión de los datos de
                   protección de datos de un cliente
  Autor          : OL-Software
  Fecha          : 28/02/2021

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  28/02/2021        OL-Software       Creacion
  ******************************************************************/
IS

    FUNCTION fsbVersion
    RETURN VARCHAR2;

    PROCEDURE INSREGISTER
    (
        inuCliente          IN      LDC_PROTECCION_DATOS.id_cliente%type,
        inuEstaLey          IN      LDC_PROTECCION_DATOS.cod_estado_ley%type,
        isbEstado           IN      LDC_PROTECCION_DATOS.estado%type,
        idtFecha            IN      LDC_PROTECCION_DATOS.fecha_creacion%type,
        isbUsuario          IN      LDC_PROTECCION_DATOS.usuario_creacion%type
    );
    
    PROCEDURE COMMITREGISTER;


END LDC_BOPROTECCION_DATOS;
/
CREATE OR REPLACE PACKAGE BODY LDC_BOPROTECCION_DATOS
/*****************************************************************
  Unidad         : LDC_BOPROTECCION_DATOS
  Descripcion    : Paquete para la gestión de los datos de
                   protección de datos de un cliente
  Autor          : OL-Software
  Fecha          : 28/02/2021

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  28/02/2021        OL-Software       Creacion
  ******************************************************************/

IS

    csbVERSION          CONSTANT VARCHAR2(50) := 'CA618';
    
    TYPE TYTBPROTECCIONDATOS          IS TABLE OF LDC_PROTECCION_DATOS%ROWTYPE;
    
    gtbProteccionDatos      TYTBPROTECCIONDATOS := TYTBPROTECCIONDATOS();

    /*****************************************************************
      Unidad         : fsbVersion
      Descripcion    : Funcion que devuelve la versión del objeto
      Autor          : OL-Software
      Fecha          : 28/02/2021

      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
      28/02/2021        OL-Software       Creacion
      ******************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    
    IS
    
    BEGIN
    
        RETURN csbVERSION;
    
    END fsbVersion;

    /*****************************************************************
      Unidad         : INSREGISTER
      Descripcion    : Servicio que permite registrar los datos de
                        protección de datos para un cliente
      Autor          : OL-Software
      Fecha          : 28/02/2021

      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
      28/02/2021        OL-Software       Creacion
      ******************************************************************/
    PROCEDURE INSREGISTER
    (
        inuCliente          IN      LDC_PROTECCION_DATOS.id_cliente%type,
        inuEstaLey          IN      LDC_PROTECCION_DATOS.cod_estado_ley%type,
        isbEstado           IN      LDC_PROTECCION_DATOS.estado%type,
        idtFecha            IN      LDC_PROTECCION_DATOS.fecha_creacion%type,
        isbUsuario          IN      LDC_PROTECCION_DATOS.usuario_creacion%type
    )
    
    IS
    
        sbCaso618           VARCHAR2(30) := '0000618';

    
    BEGIN
    
        ut_trace.trace('Inicio del servicio LDC_BOPROTECCION_DATOS.INSREGISTER',10);
        ut_trace.trace('Cliente: ['||inuCliente||'] Estado Ley: ['||inuEstaLey||']
                        Estado: ['||isbEstado||'] Fecha: ['||idtFecha||']
                        Usuario: ['||isbUsuario||']',10);

                        
        IF fblaplicaentregaxcaso(sbCaso618) THEN
        
        
            IF inuCliente IS NULL THEN
            
                Errors.seterror
                (
                    2741,
                    'El código del cliente es requerido para ser registrado en Protección de Datos. Favor validar.'
                );
                RAISE ex.CONTROLLED_ERROR;

            END IF;
            
            IF inuEstaLey IS NULL THEN

                Errors.seterror
                (
                    2741,
                    'El estado de ley es requerido para ser registrado en Protección de Datos. Favor validar.'
                );
                RAISE ex.CONTROLLED_ERROR;

            END IF;
            
            gtbProteccionDatos.extend;
            gtbProteccionDatos(gtbProteccionDatos.last).ID_CLIENTE := inuCliente;
            gtbProteccionDatos(gtbProteccionDatos.last).COD_ESTADO_LEY := inuEstaLey;
            gtbProteccionDatos(gtbProteccionDatos.last).ESTADO := isbEstado;
            gtbProteccionDatos(gtbProteccionDatos.last).FECHA_CREACION := idtFecha;
            gtbProteccionDatos(gtbProteccionDatos.last).USUARIO_CREACION := isbUsuario;
            gtbProteccionDatos(gtbProteccionDatos.last).PACKAGE_ID := NULL;
        
        END IF;
        
        ut_trace.trace('Fin del servicio LDC_BOPROTECCION_DATOS.INSREGISTER',10);
    
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END INSREGISTER;
    /*****************************************************************
      Unidad         : COMMITREGISTER
      Descripcion    : Servicio para asentar los datos en la tabla de
                       LDC_PROTECCION_DATOS
      Autor          : OL-Software
      Fecha          : 01/03/2021

      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
      01/03/2021        OL-Software       Creacion
      ******************************************************************/
    PROCEDURE COMMITREGISTER
    
    IS
    
        sbCaso618           VARCHAR2(30) := '0000618';
    
    BEGIN
    
        ut_trace.trace('Inicio del servicio LDC_BOPROTECCION_DATOS.COMMITREGISTER',10);
    
        IF fblaplicaentregaxcaso(sbCaso618) THEN

            IF gtbProteccionDatos.COUNT > 0 THEN
            
            
                FOR i IN gtbProteccionDatos.FIRST .. gtbProteccionDatos.LAST LOOP
                
                
                    INSERT INTO LDC_PROTECCION_DATOS
                    (
                        ID_CLIENTE,
                        COD_ESTADO_LEY,
                        ESTADO,
                        FECHA_CREACION,
                        USUARIO_CREACION,
                        PACKAGE_ID
                    )
                    VALUES
                    (
                        gtbProteccionDatos(i).ID_CLIENTE,
                        gtbProteccionDatos(i).COD_ESTADO_LEY,
                        gtbProteccionDatos(i).ESTADO,
                        gtbProteccionDatos(i).FECHA_CREACION,
                        gtbProteccionDatos(i).USUARIO_CREACION,
                        gtbProteccionDatos(i).PACKAGE_ID
                    );
                
                
                END LOOP;
            
                pkgeneralservices.COMMITTRANSACTION;
            
            END IF;
        
        END IF;
        gtbProteccionDatos.DELETE;
        
        ut_trace.trace('Fin del servicio LDC_BOPROTECCION_DATOS.COMMITREGISTER',10);
    
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END COMMITREGISTER;

END LDC_BOPROTECCION_DATOS;

/
