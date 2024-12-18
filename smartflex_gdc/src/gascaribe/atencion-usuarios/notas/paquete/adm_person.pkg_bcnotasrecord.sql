CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_bcnotasrecord
IS
/*****************************************************************
Propiedad Intelectual de Gases del Caribe

Unidad         : pkg_bcnotasrecord
Descripción    : Paquete que contiene las consultas necesarias para
                 hacer el de una nota y el detalle.
Autor           : Diana Patricia Montes Hurtado
Fecha           : 07-07-2023


Historia de Modificaciones
Fecha             Autor                 Modificación
==========        ==================    ===============================
07-07-2023        diana.montes            Creacion.
******************************************************************/


    
    /*****************************************************************
    Propiedad Intelectual de Gases del Caribe

    Unidad         : tyrcNota
    Descripción    : Tipo record con datos de la nota.

    Parámetros     :
        sbPrograma                  Identificador del programa
         nuProducto                 Identificador del producto
         nuCuencobr                 Identificador de la cuenta de cobro
         nuNotacons                 Tipo de nota 70 71
         dtNotafeco                 Fecha de la nota
         sbNotaobse                 Observacion de la nota
         sbNotaToken                Prefijo del documento de soporte 'NC-' 'ND-'  

    Historia de Modificaciones
    Fecha       Autor                   Modificación
    =========   =========               ====================
    07-07-2023        diana.montes            Creacion.
    ******************************************************************/
      TYPE tyrcNota IS RECORD(
         sbPrograma VARCHAR2(10), 
         nuProducto NUMBER(10),
         nuCuencobr NUMBER(10),
         nuNotacons NUMBER(15), 
         dtNotafeco DATE, 
         sbNotaobse VARCHAR(180),
         sbNotaToken varchar2(10)   
        );
        
    /*****************************************************************
    Propiedad Intelectual de Gases del Caribe

    Unidad         : tyrcCargos
    Descripción    : Tipo record con datos de los cargos asociados a la nota.

    Parámetros     :
        nuProducto            Identificador del producto
        nuContrato            Identificador del contrato
        nuCuencobr            Identificador de la cuenta de cobro
        nuConcepto            Identificador del Concepto
        NuCausaCargo          Identificador de la causa del cargo
        nuValor               Valor del cargo
        nuValorBase           Valor base
        sbCargdoso            Documento de Soporte
   	    sbSigno               Signo
        sbAjustaCuenta        Ajusta cuenta
        sbNotaDocu            Documento de la nota
       	sbBalancePostivo      Balance Positivo, por defecto N 
      	boApruebaBal          Aprueba balance por defecto FALSE 

    Historia de Modificaciones
    Fecha       Autor                   Modificación
    =========   =========               ====================
    07-07-2023        diana.montes            Creacion.
    ******************************************************************/

       TYPE tyrcCargos IS RECORD(
        nuProducto            NUMBER(10),
        nuContrato            NUMBER(10),
        nuCuencobr            NUMBER(10),
        nuConcepto            NUMBER(4),
        NuCausaCargo          NUMBER(2),
        nuValor               NUMBER(13,2),
        nuValorBase           NUMBER(13,2),
        sbCargdoso            VARCHAR2(30),
   	    sbSigno               VARCHAR2(2),
        sbAjustaCuenta        VARCHAR2(1),
        sbNotaDocu            VARCHAR2(30),
       	sbBalancePostivo      VARCHAR2(2) DEFAULT  'N',
      	boApruebaBal          BOOLEAN DEFAULT FALSE);
        type tytbCargos IS TABLE OF tyrcCargos INDEX BY BINARY_INTEGER;
        tCargos tytbCargos;
    
    FUNCTION fsbVersion  return varchar2;
END pkg_bcnotasrecord;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_bcnotasrecord
IS
/*****************************************************************
Propiedad Intelectual de Gases del Caribe

Unidad         : pkg_bcnotasrecord
Descripción    : Paquete que contiene las consultas necesarias para
                 hacer el de una nota y el detalle.
Autor           : Diana Patricia Montes Hurtado
Fecha           : 07-07-2023


Historia de Modificaciones
Fecha             Autor                 Modificación
==========        ==================    ===============================
07-07-2023        diana.montes            Creacion.
******************************************************************/

  --------------------------------------------
    -- Constantes
    --------------------------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete.
    csbVersion        constant VARCHAR2(10) := 'OSF-1252';

    --------------------------------------------
    -- Declaracion de Tipos de datos
    --------------------------------------------

    /**************************************************************
    Propiedad Intelectual de Gases del Caribe

    Unidad         : fsbVersion
    Descripcion    : Obtiene la version del paquete.

    Autor           : Diana Patricia Montes Hurtado
    Fecha           : 07-07-2023


    Historia de Modificaciones
    Fecha             Autor                 Modificación
    ==========        ==================    ===============================
    07-07-2023        diana.montes            Creacion.
    ***************************************************************/
    FUNCTION fsbVersion
    RETURN varchar2
    IS
    BEGIN
        RETURN (csbVersion);
    END fsbVersion;
END pkg_bcnotasrecord;
/
PROMPT Otorgando permisos de ejecución a pkg_bcnotasrecord
BEGIN
    pkg_utilidades.prAplicarPermisos('pkg_bcnotasrecord', 'ADM_PERSON'); 
END;
/
