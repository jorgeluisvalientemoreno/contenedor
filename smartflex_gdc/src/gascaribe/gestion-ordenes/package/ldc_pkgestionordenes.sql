create or replace PACKAGE      LDC_PKGESTIONORDENES is

  TYPE tyRefCursor IS REF CURSOR;


  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfOrdenTrabajo
  Descripcion    : Obtiene datos de la orden de trabajo

  Autor          : Jorge Valiente
  Fecha          : 04/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfOrdenTrabajo(OrdenTrabajo number) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoOrdenLegalizar
  Descripcion    : Registrar la orden a legalizar

  Autor          : Jorge Valiente
  Fecha          : 08/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoOrdenLegalizar(v_order_id          number,
                                    v_causal_id         number,
                                    v_order_comment     varchar2,
                                    v_exec_initial_date date,
                                    v_exec_final_date   date,
                                    v_tecnico_unidad    number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoOrdenAdicional
  Descripcion    : Registrar las ordenes adicionales a crear

  Autor          : Jorge Valiente
  Fecha          : 08/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoOrdenAdicional(v_order_id     number,
                                    v_task_type_id number,
                                    v_actividad    number,
                                    v_material     number,
                                    v_cantidad     number,
                                    v_causal_id    number); --,
  --v_valormaterial number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfOrdenGestion
  Descripcion    : Obtiene datos de la orden de trabajo gestionadas en LEGO

  Autor          : Jorge Valiente
  Fecha          : 09/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfOrdenGestion(inuTipoTrab number,
                           idtDesde    date,
                           idtHasta    date) RETURN tyRefCursor;

  ----Inicio Servcicios para proceso y legalizacion de Orden Gestionada y Trabajos Adcicionales
  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PrConfirmarOrden
  Descripcion    : Servicio para legalizacion de orden gestionada y sus trabajos adicionales

  Autor          : Jorge Valiente
  Fecha          : 10/08/2017

  Parametros              Descripcion
  ============         ===================
  ******************************************************************/
  PROCEDURE PrConfirmarOrden(isbId number);
  -----------------------------------------------------------------------------

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosBasicos
  Descripcion    : Obtiene datos de la orden de trabajo

  Autor          : Jorge Valiente
  Fecha          : 11/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDatosBasicos(OrdenTrabajo number) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfOrdenAdicional
  Descripcion    : Obtiene datos de la orden de trabajo adicional de la orden de gestion

  Autor          : Jorge Valiente
  Fecha          : 04/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfOrdenAdicional(OrdenTrabajo number) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrEditarOrdenAdicional
  Descripcion    : Editar las ordenes adicionales para actualizar las nuevas

  Autor          : Jorge Valiente
  Fecha          : 14/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrEliminarOrdenAdicional(v_order_id number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FsbAgente
  Descripcion    : Agente relacionado con la orden de gestion

  Autor          : Jorge Valiente
  Fecha          : 22/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FsbAgente(OrdenTrabajo number) RETURN varchar2;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfOrdenGestionExcel
  Descripcion    : Obtiene datos de la orden en gestion para ser plasmados en un archivo excel

  Autor          : Jorge Valiente
  Fecha          : 09/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfOrdenGestionExcel(inuTipoTrab number,
                                idtDesde    date,
                                idtHasta    date) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrHistorialTTLEGO
  Descripcion    : Historial de ordenes LEGO

  Autor          : Jorge Valiente
  Fecha          : 04/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrHistorialTTLEGO(onuOTRegistradas  out number,
                              onuOTAsignadas    out number,
                              onuOTSinFinalizar out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuExisteFuncional
  Descripcion    : Valida si existe el funcional configurado el LDCLEGO

  Autor          : Jorge Valiente
  Fecha          : 08/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuExisteFuncional RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfFuncionalLEGO
  Descripcion    : Obtiene datos de la configuracion de LDCLEGO

  Autor          : Jorge Valiente
  Fecha          : 08/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfFuncionalLEGO RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfTipoTrabLEGO
  Descripcion    : Obtiene datos de la configuracion del Tipo de Trabajo Principal de LDCLEGO

  Autor          : Jorge Valiente
  Fecha          : 09/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfTipoTrabLEGO RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoTipoTrabLEGO
  Descripcion    : Registrar el tipo de trabajo principal para LEGO

  Autor          : Jorge Valiente
  Fecha          : 09/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoTipoTrabLEGO(v_tipotrablego_id number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuUOACOfertados
  Descripcion    : Valida si existe la undiad operativa para actividades e items opfertadas en LDCUAI

  Autor          : Jorge Valiente
  Fecha          : 11/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuUOACOfertados(inuUOACOfertados number) RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuTotalDatosAdicionales
  Descripcion    : Obtiene la cantidad de datos adicionales configurados
                   en el tipo de trabajo de la orden a gestionar

  Autor          : Jorge Valiente
  Fecha          : 12/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuTotalDatosAdicionales(nutask_type_id number,
                                    NUCAUSAL_ID    number) RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosAdicionales
  Descripcion    : Obtiene los registros de datos adicionales configurados
                   en el tipo de trabajo de la orden a gestionar

  Autor          : Jorge Valiente
  Fecha          : 12/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDatosAdicionales(nutask_type_id number, NUCAUSAL_ID number)
    RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoDatoAdicional
  Descripcion    : Registrar los datos adicioanles de la orden a gestionar

  Autor          : Jorge Valiente
  Fecha          : 13/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoDatoAdicional(v_order_id       number,
                                   v_name_attribute varchar2,
                                   v_value          varchar2,
                                   v_task_type_id   number,
                                   v_causal_id      number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosAdicionales
  Descripcion    : Obtiene los registros de datos adicionales configurados
                   en el tipo de trabajo de la orden a gestionar

  Autor          : Jorge Valiente
  Fecha          : 12/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDatoAdicional(v_order_id       number,
                            v_name_attribute varchar2,
                            v_task_type_id   number,
                            v_causal_id      number) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrDesgestionarOT
  Descripcion    : Servicio para eliminar OT qeu no este relacionadas a ninguna unidad operativa
                   del funcionario conectado a LEGO

  Autor          : Jorge Valiente
  Fecha          : 14/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrDesgestionarOT;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrEliminarDatosAdicionales
  Descripcion    : Eliminar datos adcionales para registrar nuevos cambios realizados

  Autor          : Jorge Valiente
  Fecha          : 15/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrEliminarDatosAdicionales(v_order_id number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoItemOrdenGestion
  Descripcion    : Registrar el o los items relacionados de la orden a gestionar

  Autor          : Jorge Valiente
  Fecha          : 19/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoItemOrdenGestion(v_order_id number,
                                      v_item     number,
                                      v_cantidad number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosAdicionales
  Descripcion    : Obtiene los registros del o los items registrados para
                   la orden a gestionar en LEGO

  Autor          : Jorge Valiente
  Fecha          : 19/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfItemOrdenGestion(v_order_id number) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrEliminarItemOrdenGestion
  Descripcion    : Eliminar item de la orden a gestionar

  Autor          : Jorge Valiente
  Fecha          : 19/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrEliminarItemOrdenGestion(v_order_id number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoDatoAdicionalOTA
  Descripcion    : Registrar los datos adicioanles de la orden adicional

  Autor          : Jorge Valiente
  Fecha          : 24/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  /*
  PROCEDURE PrRegistoDatoAdicionalOTA(v_order_id       number,
                                      v_name_attribute varchar2,
                                      v_value          varchar2,
                                      v_task_type_id   number,
                                      v_causal_id      number);
    */

  PROCEDURE PrRegistoDatoAdicionalOTA(v_order_id       number,
                                      v_name_attribute varchar2,
                                      v_value          varchar2,
                                      v_task_type_id   number,
                                      v_causal_id      number,
                                      v_actividad      number,
                                      v_material       number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosAdicionalesOTA
  Descripcion    : Obtiene los registros de datos adicionales configurados
                   en el el tipo de trabajo adicional

  Autor          : Jorge Valiente
  Fecha          : 25/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDatosAdicionalesOTA(v_order_id     number,
                                  v_task_type_id number,
                                  v_causal_id    number,
                                  v_actividad    number,
                                  v_material     number) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrEliminarDatosAdicionalesOTA
  Descripcion    : Eliminar datos adcionales del los tipos de trabajo adicional

  Autor          : Jorge Valiente
  Fecha          : 26/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrEliminarDatosAdicionalesOTA(v_order_id number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuTipoTrab
  Descripcion    : Obtiene la causal de legalizacion para LEGO

  Autor          : Jorge Valiente
  Fecha          : 26/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuTipoTrab(InuTIPOTRABLEGO_ID     NUMBER,
                       InuTIPOTRABADICLEGO_ID NUMBER) RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuDatoInicialListaValores
  Descripcion    : Obtiene la causal de legalizacion para LEGO

  Autor          : Jorge Valiente
  Fecha          : 26/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuDatoInicialListaValores(IsbLista VARCHAR2,
                                      InuDato1 number,
                                      InuDato2 number) RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosActividad
  Descripcion    : Obtiene Datos configurados en la actividad de la orden gestionada

  Autor          : Jorge Valiente
  Fecha          : 03/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDatosActividad(InuActividad number) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoDatoActividad
  Descripcion    : Registrar los datos de la actividad principal de la
                   orden gestionada

  Autor          : Jorge Valiente
  Fecha          : 03/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoDatoActividad(v_order_id             number,
                                   v_name_attribute       varchar2,
                                   v_name_attribute_value varchar2,
                                   v_component_id         varchar2,
                                   v_component_id_value   varchar2);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosActividad
  Descripcion    : Obtiene Datos configurados en la actividad de la orden gestionada

  Autor          : Jorge Valiente
  Fecha          : 03/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDatosActividadGestionado(InuActividad number,
                                       InuOrden     number)
    RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrEliminarDatosActividad
  Descripcion    : Eliminar datos adcionales del los tipos de trabajo adicional

  Autor          : Jorge Valiente
  Fecha          : 03/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrEliminarDatosActividad(v_order_id number);

  --Inicio CASO 200-1258
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoActividadAdicional
  Descripcion    : Registrar los datos de la actividad principal de la
                   orden gestionada

  Autor          : Jorge Valiente
  Fecha          : 19/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoActividadAdicional(v_order_id             NUMBER,
                                        v_ACTIVIDAD            NUMBER,
                                        v_MATERIAL             NUMBER,
                                        v_name_attribute       varchar2,
                                        v_name_attribute_value varchar2,
                                        v_component_id         varchar2,
                                        v_component_id_value   varchar2);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosActividadAdicional
  Descripcion    : Obtiene los registros de datos actividad configurados
                   en el el tipo de trabajo adicional

  Autor          : Jorge Valiente
  Fecha          : 19/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDatosActividadAdicional(v_order_id  NUMBER,
                                      v_ACTIVIDAD NUMBER,
                                      v_MATERIAL  NUMBER) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrEliminarActividadAdicional
  Descripcion    : Eliminar datos Actividad del los tipos de trabajo adicional

  Autor          : Jorge Valiente
  Fecha          : 03/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrEliminarActividadAdicional(v_order_id number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuClasificadorCausal
  Descripcion    : Valida si el clasificador de la causal es de EXITO en LEGO

  Autor          : Jorge Valiente
  Fecha          : 30/11/2017

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuClasificadorCausal(InuCausal number) RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfOrdenLEGO
  Descripcion    : Obtiene datos de la orden en gestion para ser plasmados en un archivo excel

  Autor          : Jorge Valiente
  Fecha          : 12/12/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfOrdenLEGO(inuTipoTrab number, idtDesde date, idtHasta date)
    RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfItemOrdenLEGO
  Descripcion    : Obtiene los items de la orden principal en un archivo excel

  Autor          : Jorge Valiente
  Fecha          : 12/12/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfItemOrdenLEGO(InuOrden number) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfTAOrdenLEGO
  Descripcion    : Obtiene los trabajos adicionales de la orden en gestion para ser plasmados en un archivo excel

  Autor          : Jorge Valiente
  Fecha          : 09/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfTAOrdenLEGO(InuOrden number) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDAOrdenLEGO
  Descripcion    : Obtiene datos adicionales de la orden en gestion para ser plasmados en un archivo excel

  Autor          : Jorge Valiente
  Fecha          : 12/12/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDAOrdenLEGO(InuOrden number) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfOrdenGestionExcel
  Descripcion    : Obtiene datos adicionles del trabajo adicional de la orden en gestion para ser plasmados en un archivo excel

  Autor          : Jorge Valiente
  Fecha          : 12/12/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDATAOrdenLEGO(InuOrden        number,
                            Inutask_type_id number,
                            Inuactividad    number,
                            Inumaterial     number) RETURN tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfCAOTAdicionalLEGO
  Descripcion    : Obtiene componentes de la actividades de los datos adicionales

  Autor          : Jorge Valiente
  Fecha          : 14/12/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfCAOTAdicionalLEGO(InuOrden number, Inuactividad number)
    RETURN tyRefCursor;
  --Fin CASO 200-1258

  -- INICIO CASO 200-1580
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuExistenciaGarantia
  Descripcion    : Establece si existe configuraci?n de garant?a para el tipo de trabajo y causal establecido en la orden adicional definida en LEGO

  Autor          : Daniel Valiente
  Fecha          : 23/04/2018

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuExistenciaGarantia(InuTipoTrabajo number, InuCausal number)
    RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : rFrfOrdenesGarantia
  Descripcion    : Retorna las ordenes de garant?a relacionadas con el producto de la orden gestionada en LEGO

  Autor          : Daniel Valiente
  Fecha          : 23/04/2018

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  17/03/2020	  HORBATH			  146. Se agrega el parametro IdtExcutdate que almacenara la fecha de ejecucion
										   y la validacion de la vigencia de la garantia se realizara con esta fecha.
  ******************************************************************/
  PROCEDURE rFrfOrdenesGarantia(InuOrden    number,
                                InuTaskType number,
								IdtExcutdate date,--caso:146
                                rfQuery     OUT constants.tyrefcursor);

--FIN CASO 200-1580

  /*****************************************************************
  Propiedad intelectual de Horbath

  Unidad         : FnClasificadorCausalActivitdad
  Descripcion    : valida la clasificacion de la causal de legalizacion para legalizar actividades

  Autor          : Josh Brito
  Fecha          : 07/09/2018

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnClasificadorCausalActivitdad(nuCausalID GE_CAUSAL.CAUSAL_ID%TYPE) RETURN number;

  sbAplicaEnt2002688 varchar2(1):=null; --2002688

  FUNCTION fsbVersion RETURN VARCHAR2;

End LDC_PKGESTIONORDENES;
/
CREATE OR REPLACE PACKAGE BODY LDC_PKGESTIONORDENES AS

  csbVersion     VARCHAR2(15) := 'OSF-3357';

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 09/05/2024
    Modificaciones  :
    Autor               Fecha       Caso     Descripcion
    felipe.valencia     09/05/2024  OSF-2511 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LDC_PKGESTIONORDENES
  Descripcion    : Paquete para manejo de generacion y legalizacion de ordenes adicionales
  Autor          : Jorge Valiente
  Fecha          : 04/08/2017
  CASO           : 200-1369

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================

  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfOrdenTrabajo
  Descripcion    : Obtiene datos de la orden de trabajo

  Autor          : Jorge Valiente
  Fecha          : 04/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  17/10/2018      Eduardo Cer?n       CASO 200-2218: Se modifica el cursor rfQuery para que tenga en
                                                     cuenta ?nicamente las ?rdenes abiertas y que no
                                                     sean novedad
  09/Julio/2018   Jorge Valiente      CASO 200-1679: Modificar los servicios para que las sentencias
                                                     con OR_ORDER_ACTIVITY manejen las restricciones
                                                     mencionadas por la N1 incluyen el ROWNUM = 1
  ******************************************************************/
  FUNCTION FrfOrdenTrabajo(OrdenTrabajo number) RETURN tyRefCursor IS
    rfQuery tyRefCursor;

    nuPersonID ge_person.person_id%type;

    ---Inicio CASO 200-1528
    cursor cuelmesesu is
      select emss.*
        from elmesesu emss
       where emss.emsssesu = (select ooa.product_id
                                from open.Or_Order_Activity ooa
                               where ooa.order_id = OrdenTrabajo
                                 and ROWNUM = 1)
       order by emss.emssfein desc;

    rfcuelmesesu cuelmesesu%rowtype;

    cursor cumarcaproducto is
      SELECT LDC_MARCA_PRODUCTO.ID_PRODUCTO,
             LDC_MARCA_PRODUCTO.ORDER_ID,
             LDC_MARCA_PRODUCTO.CERTIFICADO,
             LDC_MARCA_PRODUCTO.FECHA_ULTIMA_ACTU,
             LDC_MARCA_PRODUCTO.INTENTOS,
             decode(LDC_MARCA_PRODUCTO.MEDIO_RECEPCION,
                    'I',
                    'I - Interna',
                    'E - Externa') MEDIO_RECEPCION,
             LDC_MARCA_PRODUCTO.REGISTER_POR_DEFECTO,
             nvl(LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID, 101) || ' - ' ||
             dage_suspension_type.fsbgetdescription(nvl(LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID,
                                                        101)) SUSPENSION_TYPE_ID
        FROM LDC_MARCA_PRODUCTO
       WHERE ldc_marca_producto.ID_PRODUCTO =
             (select ooa.product_id
                from open.Or_Order_Activity ooa
               where ooa.order_id = OrdenTrabajo
                 and ROWNUM = 1);

    rfcumarcaproducto cumarcaproducto%rowtype;
    ---Fin CASO 200-1528

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfOrdenTrabajo', 10);
    ut_trace.trace('Orden a consulta [' || OrdenTrabajo || ']', 10);

    nuPersonID := OPEN.GE_BOPERSONAL.FNUGETPERSONID;

    ut_trace.trace('Person ID [' || nuPersonID || ']', 10);

    ---Inicio CASO 200-1528
    open cuelmesesu;
    fetch cuelmesesu
      into rfcuelmesesu;
    close cuelmesesu;

    open cumarcaproducto;
    fetch cumarcaproducto
      into rfcumarcaproducto;
    close cumarcaproducto;
    ---Fin CASO 200-1528

    open rfQuery for
      select /*+ index (o PK_OR_ORDER)*/
       dage_geogra_location.fnugetgeo_loca_father_id(aa.geograp_location_id) || ' ' ||
       dage_geogra_location.fsbgetdescription(dage_geogra_location.fnugetgeo_loca_father_id(aa.geograp_location_id)) departamento,
       dage_geogra_location.fnugetgeograp_location_id(aa.geograp_location_id) || ' ' ||
       dage_geogra_location.fsbgetdescription(dage_geogra_location.fnugetgeograp_location_id(aa.geograp_location_id)) localidad,
       oo.task_type_id || ' ' ||
       daor_task_type.fsbgetdescription(oo.task_type_id, null) tipotrabajo,
       oo.created_date fechacreacion,
       oo.assigned_date fechaasignacion,
       aa.address direccion,
       oo.task_type_id tipotrabajo_id,
       oo.operating_unit_id operating_unit_id,
       daor_operating_unit.fsbgetname(oo.operating_unit_id, null) operating_unit_name,
       ooa.subscription_id subscription_id,
       ooa.package_id package_id,
       ooa.product_id product_id,
       (select s.susccicl
          from suscripc s
         where s.susccodi = ooa.subscription_id
           and rownum = 1) susccicl,
       (select c.cicldesc
          from ciclo c
         where c.ciclcodi = (select s.susccicl
                               from suscripc s
                              where s.susccodi = ooa.subscription_id
                                and rownum = 1)
           and rownum = 1) cicldesc,
       aa.geograp_location_id ubicacion_geografica,
       decode(OO.ORDER_STATUS_ID,
              DALD_PARAMETER.fnuGetNumeric_Value('COD_ESTA_EJEC', NULL),
              oo.exec_initial_date) fecha_ini_ejecucion,
       decode(OO.ORDER_STATUS_ID,
              DALD_PARAMETER.fnuGetNumeric_Value('COD_ESTA_EJEC', NULL),
              oo.execution_final_date) fecha_fin_ejecucion,
       ooa.activity_id actividad,
       nvl(rfcuelmesesu.emsscoem, 0) medidor,
       nvl(rfcumarcaproducto.suspension_type_id, 0) marca
        from open.or_order oo, open.Or_Order_Activity ooa, ab_address aa
       where oo.order_id = OrdenTrabajo
         and oo.order_id = ooa.order_id
         and ooa.status = 'R'
         and not exists(select 1 from open.ct_item_novelty n where n.items_id=ooa.activity_id)
         and aa.address_id = decode(nvl(ooa.address_id, 0),
                                    0,
                                    (select s.susciddi
                                       from suscripc s
                                      where s.susccodi = ooa.subscription_id),
                                    ooa.address_id)
         AND OO.ORDER_STATUS_ID IN
             (DALD_PARAMETER.fnuGetNumeric_Value('ESTADO_ASIGNADO', NULL),
              DALD_PARAMETER.fnuGetNumeric_Value('COD_ESTA_EJEC', NULL))
         and (select count(nvl(lol.order_id, 0))
                from LDC_OTLEGALIZAR lol
               where lol.order_id = OrdenTrabajo) = 0
         and (select count(ooup.operating_unit_id)
                from or_oper_unit_persons ooup
               where ooup.person_id = nuPersonID
                 and ooup.operating_unit_id = oo.operating_unit_id) > 0
         and (SELECT count(1)
                FROM DUAL
               WHERE oo.task_type_id IN
                     (select to_number(column_value)
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('HIST_TIPO_TRAB_LEGO',
                                                                                                 NULL),
                                                                ',')))) > 0;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfOrdenTrabajo', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfOrdenTrabajo;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoOrdenLegalizar
  Descripcion    : Registrar la orden a legalizar

  Autor          : Jorge Valiente
  Fecha          : 08/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/07/2018      Jorge Valiente      CASO 200-1679: Se cambia el formato de fecha de 00:00:00 por 12:00:00
  ******************************************************************/
  PROCEDURE PrRegistoOrdenLegalizar(v_order_id          number,
                                    v_causal_id         number,
                                    v_order_comment     varchar2,
                                    v_exec_initial_date date,
                                    v_exec_final_date   date,
                                    v_tecnico_unidad    number) IS

    cursor culdc_otlegalizar is
      select Count(lol.order_id) cantidad
        from ldc_otlegalizar lol
       where lol.order_id = v_order_id;

    rfculdc_otlegalizar culdc_otlegalizar%rowtype;

    v_task_type_id number;

    cursor culdc_usualego is
      select lu.*
        from ldc_usualego lu
       where lu.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID
         and rownum = 1;

    rfculdc_usualego culdc_usualego%rowtype;

    --CASO 200-1679
    sb_exec_initial_date varchar2(4000);
    sb_exec_final_date   varchar2(4000);
    dt_exec_initial_date date;
    dt_exec_final_date   date;
    --CASO 200-1679

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrRegistoOrdenLegalizar',
                   10);
    ut_trace.trace('Orden a registrar [' || v_order_id || ']', 10);
    ut_trace.trace('Causal [' || v_causal_id || ']', 10);
    ut_trace.trace('Comentario [' || v_order_comment || ']', 10);
    ut_trace.trace('Fecha inicial ejecucion [' || v_exec_initial_date || ']',
                   10);
    ut_trace.trace('Fecha final ejecucion [' || v_exec_final_date || ']',
                   10);
    ut_trace.trace('Tecnico Legaliza [' || v_tecnico_unidad || ']', 10);

    v_task_type_id := nvl(daor_order.fnugettask_type_id(v_order_id, null),
                          0);

    --CASO 200-1679
    --Manejo de fecha para reemplazar Hora, Minuto y Segundo
    dt_exec_initial_date := v_exec_initial_date;
    dt_exec_final_date   := v_exec_final_date;

    sb_exec_initial_date := v_exec_initial_date;
    sb_exec_final_date   := v_exec_final_date;
    if (instr(sb_exec_initial_date, '00:00:00') > 0) then
      dt_exec_initial_date := TO_DATE(replace(sb_exec_initial_date,
                                              '00:00:00',
                                              '12:00:00'),
                                      'DD/MM/YYYY HH24:MI:SS');
    end if;

    if (instr(sb_exec_final_date, '00:00:00') > 0) then
      dt_exec_final_date := TO_DATE(replace(sb_exec_final_date,
                                            '00:00:00',
                                            '12:00:00'),
                                    'DD/MM/YYYY HH24:MI:SS');
    end if;

    ut_trace.trace('Fecha inicial ejecucion Despues [' ||
                   dt_exec_initial_date || ']',
                   10);
    ut_trace.trace('Fecha final ejecucion Despues [' || dt_exec_final_date || ']',
                   10);
    --CASO 200-1679

    open culdc_usualego;
    fetch culdc_usualego
      into rfculdc_usualego;
    close culdc_usualego;

    open culdc_otlegalizar;
    fetch culdc_otlegalizar
      into rfculdc_otlegalizar;
    if nvl(rfculdc_otlegalizar.cantidad, 0) = 0 then

      ut_trace.trace('Inserto OT Legalizar', 10);

      insert into ldc_otlegalizar
        (order_id,
         causal_id,
         order_comment,
         exec_initial_date,
         exec_final_date,
         fecha_registro,
         task_type_id)
      values
        (v_order_id,
         v_causal_id,
         v_order_comment,
         dt_exec_initial_date, --v_exec_initial_date,
         dt_exec_final_date, --v_exec_final_date,
         sysdate,
         v_task_type_id);

      insert into ldc_anexolegaliza
        (order_id, agente_id, tecnico_unidad)
      values
        (v_order_id, rfculdc_usualego.agente_id, v_tecnico_unidad);

    else
      ut_trace.trace('Actualizo OT Legalizar', 10);
      update ldc_otlegalizar
         set causal_id         = v_causal_id,
             order_comment     = v_order_comment,
             exec_initial_date = dt_exec_initial_date, --v_exec_initial_date,
             exec_final_date   = dt_exec_final_date --v_exec_final_date
       where order_id = v_order_id;

      UPDATE ldc_anexolegaliza
         SET tecnico_unidad = v_tecnico_unidad
       WHERE order_id = v_order_id;

    end if;
    close culdc_otlegalizar;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrRegistoOrdenLegalizar', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrRegistoOrdenLegalizar;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoOrdenAdicional
  Descripcion    : Registrar las ordenes adicionales a crear

  Autor          : Jorge Valiente
  Fecha          : 08/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoOrdenAdicional(v_order_id     number,
                                    v_task_type_id number,
                                    v_actividad    number,
                                    v_material     number,
                                    v_cantidad     number,
                                    v_causal_id    number) IS
    --,
    --v_valormaterial number) IS

    cursor culdc_otadicional is
      select Count(loa.order_id) cantidad
        from LDC_OTADICIONAL loa
       where loa.order_id = v_order_id
         and loa.task_type_id = v_task_type_id
         and loa.actividad = v_actividad
         and loa.material = v_material;

    rfculdc_otadicional culdc_otadicional%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrRegistoOrdenAdicional',
                   10);
    ut_trace.trace('Orden a relacionar [' || v_order_id || ']', 10);

    open culdc_otadicional;
    fetch culdc_otadicional
      into rfculdc_otadicional;
    if nvl(rfculdc_otadicional.cantidad, 0) = 0 then

      ut_trace.trace('Inserto OT Adicional', 10);

      insert into ldc_otadicional
        (order_id, task_type_id, actividad, material, cantidad, causal_id) --,
      --valormaterial)
      values
        (v_order_id,
         v_task_type_id,
         v_actividad,
         v_material,
         v_cantidad,
         v_causal_id); --,
      --v_valormaterial);

    else
      ut_trace.trace('Actualizo OT Adicional', 10);

      update ldc_otadicional
         set cantidad = v_cantidad, causal_id = v_causal_id
       where order_id = v_order_id
         and task_type_id = v_task_type_id
         and actividad = v_actividad
         and material = v_material;
    end if;
    close culdc_otadicional;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrRegistoOrdenAdicional', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrRegistoOrdenAdicional;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfOrdenGestion
  Descripcion    : Obtiene datos de la orden de trabajo gestionadas en LEGO

  Autor          : Jorge Valiente
  Fecha          : 09/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  17/10/2018      Eduardo Cer?n       CASO 200-2218: Se modifica el cursor rfQuery para que tenga en
                                                     cuenta ?nicamente las ?rdenes abiertas y que no
                                                     sean novedad
  09/Julio/2018   Jorge Valiente      CASO 200-1679: Modificar los servicios para que las sentencias
                                                     con OR_ORDER_ACTIVITY manejen las restricciones
                                                     mencionadas por la N1 incluyen el ROWNUM = 1
  07/09/2018      JOSH BRITO          CASO 200-2089: condicion para las ordenes gestionadas para legalizar solo se
                                                     muestren las ordenes del mismo agente siempre y cuando la orden
                                                     gestionada pertenezca a la misma UT que la Persona
   18/07/2022    LJLB                 CASO OSF-439 se coloca nuevo campo de localidad de la orden
  ******************************************************************/
  FUNCTION FrfOrdenGestion(inuTipoTrab number,
                           idtDesde    date,
                           idtHasta    date) RETURN tyRefCursor IS
    rfQuery tyRefCursor;

    nuPersonID ge_person.person_id%type;

  BEGIN

    nuPersonID := OPEN.GE_BOPERSONAL.FNUGETPERSONID;

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfOrdenGestion', 10);
    ut_trace.trace('Tipo trabajo [' || inuTipoTrab || ']', 10);
    ut_trace.trace('Desde [' || idtDesde || ']', 10);
    ut_trace.trace('Hasta [' || idtHasta || ']', 10);

    open rfQuery for
    select  Orden,
            TipoTrab,
            Agente,
            daab_address.fsbgetaddress(Direccion, null) Direccion,
            (select L.Description
              from Ge_Geogra_Location  l
              where L.Geograp_Location_Id = ( select d.Geograp_Location_Id
                                              from ab_address d
                                              where d.address_id = Direccion)) localidad,
            FechaGestion,
            Contrato,
            Observacion,
            RespuestaOSF
    from (
          select distinct lol.order_id Orden,
                          lol.task_type_id TipoTrab,
                          FsbAgente(lol.order_id) Agente,
                          decode(nvl(ooa.address_id, 0), 0,
                                                            (select s.susciddi
                                                               from suscripc s
                                                              where s.susccodi =
                                                                    ooa.subscription_id),
                                                            ooa.address_id) Direccion,

                          lol.fecha_registro FechaGestion,
                          nvl(ooa.subscription_id, 0) Contrato,
                          lol.order_comment Observacion,
                          lol.mensaje_legalizado RespuestaOSF
            from ldc_otlegalizar lol, or_order_activity ooa
           where lol.legalizado = 'N'
             and ooa.status = 'R'
             and not exists(select 1 from open.ct_item_novelty n where n.items_id=ooa.activity_id)
             and lol.task_type_id =
                 decode(inuTipoTrab, -1, lol.task_type_id, inuTipoTrab)
             and trunc(lol.fecha_registro) >= trunc(idtDesde)
             and trunc(lol.fecha_registro) <= trunc(idtHasta)
             and lol.order_id = ooa.order_id
             and (select count(lol.order_id)
                    from ldc_anexolegaliza la, ldc_usualego lu
                   where la.order_id = lol.order_id
                     and la.agente_id = lu.agente_id
                     and lu.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID) > 0
             and (select count(1)
                  from OR_OPER_UNIT_PERSONS ooup, OR_ORDER oo
                  where ooup.operating_unit_id = OO.operating_unit_id
                  and oo.order_id = lol.order_id
                  and ooup.person_id = nuPersonID)  > 0 );

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfOrdenGestion', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfOrdenGestion;

  PROCEDURE PROVALIINTECOTI ( inuOrden IN or_order.order_id%type,
                              onuError   OUT NUMBER,
                              osbError  OUT VARCHAR2) IS
 /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

    Unidad         : PROVALIINTECOTI
    Descripcion    : Servicio para validar items cotizados
    Ticket          : 200-2404
    Autor          : Elkin Alvarez
    Fecha          : 16/03/2019

    Parametros              Descripcion
    ============         ===================
      inuOrden            numero de orden
      onuError            codigo de errror 0-exito -1 - error
      osbError            mensaje de error


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    15/03/2019       ELAL               Creacion
	17/06/2019		 dsaltarin	 		200-2688 Se modifica para que no se tenga en cuenta las ordenes adicionales
										que estan registradas en las formas de cotizacion
   *****************************************************************/

   sbDatos VARCHAR2(1);--se almacena resultado de los cursores

   sbItems VARCHAR2(4000); --se almacena item con errores


   -- se valida si se encuentran configurado el plugin LDC_PRVALIDAITEMCOTIZADO en el tt de la orden
   CURSOR cuValidaPlugin IS
   SELECT 'X'
   FROM LDC_PROCEDIMIENTO_OBJ pl , or_order o
   WHERE o.order_id = inuOrden
     AND pl.TASK_TYPE_ID = o.task_type_id
     AND pl.PROCEDIMIENTO = 'LDC_PRVALIDAITEMCOTIZADO'
     AND pl.ACTIVO = 'S'
	 AND (pl.causal_id IS NULL OR pl.causal_id = o.causal_id)
     AND NOT EXISTS (SELECT 1 FROM or_related_order ore WHERE ore.order_id = o.order_id AND ore.RELA_ORDER_TYPE_ID = 13)
	;

   --se valida que los items configurados LDCRIAICI se legalicen
   CURSOR cuValiItemConf IS
   SELECT item_cotizado||'-'||i.description items
   FROM ldc_itemcotiinte_ldcriaic, ge_items i
   WHERE order_id = inuOrden
     AND item_cotizado = i.items_id
     AND NOT EXISTS (  SELECT ooi.items_id
                       FROM or_order_items ooi
                       WHERE ooi.order_id = inuOrden
                        AND ooi.items_id = item_cotizado
                        UNION ALL
                        SELECT ooi.items_id
                        FROM or_order_items ooi, or_related_order ore
                        WHERE ore.order_id  = inuOrden
                         AND ooi.order_id = ore.related_order_id
						 AND ore.RELA_ORDER_TYPE_ID = 13
                         AND ooi.items_id = item_cotizado);

    --se valida que items asociado en el parametro COD_ITEMCOTI_LDCRIAIC que se esten legalizando esten configurado en LDCRIAIC
    CURSOR cuvaliitemlenoconf  IS
    SELECT ITEMS||'-'||I.DESCRIPTION ITEMS
    FROM (
       SELECT ooi.order_id orden, ooi.items_id items
        FROM or_order_items ooi
       WHERE ooi.order_id = inuOrden
          AND ooi.items_id IN
          ( SELECT to_number(COLUMN_VALUE)
            FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_ITEMCOTI_LDCRIAIC',
                                                                                 NULL),

                                                ',')))
          UNION ALL
          SELECT ore.order_id, ooi.items_id
          FROM or_order_items ooi, or_related_order ore
          WHERE ore.order_id  = inuOrden
           AND ooi.order_id = ore.related_order_id
		   AND ore.RELA_ORDER_TYPE_ID = 13
           AND ooi.items_id IN
          ( SELECT to_number(COLUMN_VALUE)
            FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_ITEMCOTI_LDCRIAIC',
                                                                                 NULL),

                                                ','))

                                                )
		  --200-2688
		  and not exists(select null from open.ldc_itemcotiinte_ldcriaic l where l.order_id=ore.related_order_id and l.item_cotizado=ooi.items_id
						 union all
						 select null from open.ldc_itemcoti_ldcriaic l where l.order_id=ore.related_order_id and l.item_cotizado=ooi.items_id )
		  --200-2688
          ) da, ge_items i
    WHERE  da.items = i.items_id
       AND NOT EXISTS ( SELECT 1
                        FROM ldc_itemcotiinte_ldcriaic ic
                        WHERE ic.order_id = da.orden AND ic.item_cotizado = da.items);

    --se valida que los item cotizados configurados y legalizados sean iguales
    CURSOR cuValiValorLega IS
    SELECT items||' - '||dage_items.fsbgetdescription(items,NULL) items, totalitemadicional, valor_lega
    FROM (
            select items, sum(totalitemadicional) totalitemadicional, sum(valor_lega) valor_lega
			from (
					select licl.item_cotizado items,sum(nvl(lial.total,0)) totalitemadicional, 0 valor_lega
					from ldc_itemcotiinte_ldcriaic licl,
						   ldc_itemadicinte_ldcriaic lial
					where licl.order_id = inuorden
					   and lial.codigo = licl.codigo
					group by  licl.item_cotizado
					UNION all
					select ooi.items_id items,0 totalitemadicional, sum(nvl(ooi.value,0)) valor_lega
					from or_order_items   ooi
					where ooi.order_id = inuorden
					 --and exists(select 1 from ldc_itemcotiinte_ldcriaic c where c.order_id=ooi.order_id and c.item_cotizado=ooi.items_id)
					 AND ooi.items_id IN ( SELECT to_number(COLUMN_VALUE)
											FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('COD_ITEMCOTI_LDCRIAIC',
																												 NULL),

																				',')))
					group by  ooi.items_id
					union all
					select ooi.items_id items,0 totalitemadicional, sum(nvl(ooi.value,0)) valor_lega
					from or_order_items ooi, or_related_order ore
					where ore.order_id = inuOrden
					 AND ore.RELA_ORDER_TYPE_ID = 13
					 AND	ooi.order_id = ore.related_order_id
					 --and exists(select 1 from ldc_itemcotiinte_ldcriaic c where c.order_id=ore.order_id and c.item_cotizado=ooi.items_id)
					 AND ooi.items_id IN ( SELECT to_number(COLUMN_VALUE)
											FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('COD_ITEMCOTI_LDCRIAIC',
																												 NULL),

																				',')))
					and not exists(select null from open.ldc_itemcotiinte_ldcriaic l where l.order_id=ore.related_order_id and l.item_cotizado=ooi.items_id
						 union all
						 select null from open.ldc_itemcoti_ldcriaic l where l.order_id=ore.related_order_id and l.item_cotizado=ooi.items_id )
					group by  ooi.items_id
			   )
			group by items)
    WHERE totalitemadicional <> valor_lega;

    erDatos EXCEPTION;
  BEGIN
	   --se valida que el plugin este configurado
	OPEN cuValidaPlugin;
	FETCH cuValidaPlugin INTO sbdatos;
	CLOSE cuValidaPlugin;

	-- si no se encuentra configurado se realiza las siguientes validaciones
	IF sbDatos IS NULL THEN
	  -- se valida items configurados en LDCRIAICI se legalicen
	  FOR reg IN cuValiItemConf LOOP
		IF sbItems IS NULL THEN
		   sbItems :=reg.items;
		ELSE
		  sbItems := substr(sbItems||','||reg.items,1,3999);
		END IF;
	  END LOOP;

	  IF sbItems IS NOT NULL THEN
		 osbError := 'No se han registrado los Items '||sbItems||' los cuales estan asociado a la cotizacion';
		 RAISE erDatos;
	  END IF;

	  -- se valida items legalizados y esten el parametro COD_ITEMCOTI_LDCRIAIC se encuentren registrados  en LDCRIAICI
	  FOR reg IN cuvaliitemlenoconf LOOP
		IF sbItems IS NULL THEN
		   sbItems :=reg.items;
		ELSE
		  sbItems := substr(sbItems||','||reg.items,1,3999);
		END IF;
	  END LOOP;

	  IF sbItems IS NOT NULL THEN
		 osbError := 'Los Items '||sbItems||' no se encuentran asociado a una cotizacion en LDCRIAICI';
		 RAISE erDatos;
	  END IF;

	  FOR reg IN cuValiValorLega LOOP
		 IF sbItems IS NULL THEN
		   sbItems := 'El valor legalizado ['||reg.valor_lega||'] del Item['||reg.items||'] no coincide con el valor de la cotizacion['||reg.totalitemadicional||'].';
		ELSE
		  sbItems := substr(sbItems||'|'||'El valor legalizado ['||reg.valor_lega||'] del Item['||reg.items||'] no coincide con el valor de la cotizacion['||reg.totalitemadicional||'].',1,3999);
		END IF;

	  END LOOP;

	  IF sbItems IS NOT NULL THEN
		 osbError := sbItems;
		 RAISE erDatos;
	  END IF;
	END IF;
    --se actualiza la orden
	 UPDATE ldc_itemcotiinte_ldcriaic LIL
       SET LIL.ORDER_STATUS_ID = 8
     WHERE LIL.ORDER_ID = inuOrden;

    onuError := 0;
  EXCEPTION
    WHEN erDatos THEN
         onuError := -1;
    WHEN OTHERS THEN
       onuError := -1;
       osbError := 'Error no controlado en LDC_PKGESTIONORDENES.PROVALIINTECOTI '||SQLERRM;
  END PROVALIINTECOTI;

  ----Inicio Servcicios para proceso y legalizacion de Orden Gestionada y Trabajos Adcicionales
  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PrConfirmarOrden
  Descripcion    : Servicio para legalizacion de orden gestionada y sus trabajos adicionales

  Autor          : Jorge Valiente
  Fecha          : 10/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  08/05/2024      felipe.valencia     OSF-2511 Se agrega lectura al componente 9
  26/06/2023      DSALTARIN      	  OSF-1264: Se reemplaza el servicio personalizaciones.api_legalizeorder por api_legalizeorders
  14/06/2023      CGONZALEZ      	  OSF-1217: Se reemplaza el servicio open.os_legalizeorders con el servicio personalizaciones.api_legalizeorder
  24/10/2022      Jorge Valiente      OSF-630: Se reemplaza el servicio OS_CREATEORDERACTIVITIES con el servicio or_boorderactivities.createactivity
  21/04/2022      DSALTARIN           OSF-259: Se modifica para que al validar la garantia no se validen garantias de ordenes dentro de la solicitud que se esa legalizando
  09/09/2020      DSALTARIN           GLPI 482: se corrige el error que sale al validar la garantia en la orden padre
                                                tambien para que solo se genere la orden de garantias si no hay error nen la legalizaci?n
  15/03/2019       HORBATH               CA 146: Se agrega validacion en la orden actual no tenga una orden de validacion de garantia.

  15/03/2019       ELAL               CA 200-2404: Se adiciona proceso PROVALIINTECOTI  que se encarga de validar los items cotizado
                                      forma LDCRIAICI

  17/10/2018      Eduardo Cer?n       CASO 200-2218: Se modifican los cursores CUCADENALEGALIZACION y
                                                     CuActividadOrden para que tenga en cuenta ?nicamente
                                                     las ?rdenes abiertas y que no sean novedad
                                                     Adem?s se valida que despu?s de abrir el cursor cuLDC_ORDTIPTRAADI
                                                     el tipo de trabajo del cursor sea igual al de la orden
  24-04-18        Daniel Valiente     Caso 200-1580: Despu?s de haber legalizado la OT
                                                     adicional con ?xito se debe validar
                                                     la causal de legalizaci?n con el tipo
                                                     de trabajo en caso de estar en la
                                                     configuraci?n, se realizar?
                                                     la inserci?n de los datos en la tabla
                                                     de auditoria.
  30/05/2018      Jorge Valiente      CASO 200-1932: Cambio de logica de indetificacion
                                                     de clasificador de causal en lugar de
                                                     el tipo de causal.
  09/Julio/2018   Jorge Valiente      CASO 200-1679: Cambiar los caracteres especiales a la observacion
                                                     de la OT gestionada y confirmada en LEGO
                                                     Modificar los servicios para que las sentencias
                                                     con OR_ORDER_ACTIVITY manejen las restricciones
                                                     mencionadas por la N1 incluyen el ROWNUM = 1
  13/09/2018      josh Brito          CASO 200-2089  Se modico el UPDATE para que al legalizar las ordenes gestionadas
                                                      no se actualice el comentarios en or_order_activity sino en or_order_comment
                                                      cuando el campo LEGALIZE_COMMENT = Y
  ******************************************************************/
  PROCEDURE PrConfirmarOrden(isbId number) IS

    --isbId           VARCHAR2(4000) := '67726981';
    inuCurrent      NUMBER := 1;
    inuTotal        NUMBER := 1;
    onuErrorCode    NUMBER;
    osbErrorMessage VARCHAR2(4000);
	salir 			NUMBER := 1;

    NuOrder_Ir or_order.ORDER_ID%type;

    ---Cursor para obtener el comentario y la direccion
    Cursor CurOrdenActi(NUORDER_ID or_order.ORDER_ID%TYPE) is
      select ADDRESS_ID,
             COMMENT_,
             DAOR_ORDER.FNUGETOPERATING_UNIT_ID(NUORDER_ID, NULL)
        FROM or_order_activity
       where ORDER_ID = NUORDER_ID
         and ROWNUM = 1;

    sBcOMENTARIO      VARCHAR2(2000);
    NuCodDir          number;
    NUUNIDADOPERATIVA NUMBER;

    ---Cursor para obtener la cantidad de actividades configuradas en la orden principal
    Cursor CurcantidadACTIVIDAD(NUORDEN or_order.ORDER_ID%TYPE) is
      select count(LR.ACTIVIDAD) cantidadactividades
        FROM LDC_OTADICIONAL LR
       where LR.ORDER_ID = NUORDEN;

    nucantidadACTIVIDAD number;

    ---Cursor para obtener cantidad trabajo adcionales generados de la orden principal
    Cursor CurCANTIDADtrabajo(NUORDEN or_order.ORDER_ID%TYPE) is
      select count(*) cantidadtabajos
        FROM or_related_order oro
       where oro.ORDER_ID = NUORDEN;
    /*select count(*) cantidadtabajos
     FROM LDC_OTADICIONAL LR, or_related_order oro
    where LR.ORDER_ID = NUORDEN
      and lr.order_id = oro.related_order_id
      and lr.actividad in
          (SELECT OOA.Activity_Id
             FROM OPEN.OR_ORDER_ACTIVITY OOA
            WHERE OOA.Activity_Id = lr.actividad
              and ooa.order_id = oro.order_id);*/

    nuCANTIDADtrabajo number;

    ---Cursor para obtener LAS ACTIVIDADES
    Cursor CurACTIVIDAD(NUORDEN or_order.ORDER_ID%TYPE) is
      select LR.TASK_TYPE_ID, LR.ACTIVIDAD, LR.CAUSAL_ID --, LR.MATERIAL
        FROM ldc_otadicional LR
       where LR.ORDER_ID = NUORDEN
       GROUP BY LR.TASK_TYPE_ID, LR.ACTIVIDAD, LR.CAUSAL_ID --, LR.MATERIAL
       ORDER BY LR.TASK_TYPE_ID, LR.ACTIVIDAD;

    TEMPCurACTIVIDAD CurACTIVIDAD%ROWTYPE;

    ---Cursor para VALIDAR SI LA ACTIVIDAD YA EXISTE COMO UN TRABAJO ADICIONAL
    --RELACIONADO CON LA ORDEN PRINCIPAL.
    Cursor CurEXISTEACTIVIDAD(NUORDEN    or_order.ORDER_ID%TYPE,
                              NUITEMS_ID GE_ITEMS.ITEMS_ID%TYPE) is
      select COUNT(LR.ACTIVIDAD) CANTIDAD
        FROM LDC_OTADICIONAL LR, OR_RELATED_ORDER ORO
       where LR.ORDER_ID = NUORDEN
         AND LR.ACTIVIDAD = NUITEMS_ID
         AND ORO.RELATED_ORDER_ID = LR.ORDER_ID
         and lr.actividad in (SELECT OOA.Activity_Id
                                FROM OPEN.OR_ORDER_ACTIVITY OOA
                               WHERE OOA.Activity_Id = lr.actividad
                                 AND ORO.ORDER_ID = OOA.ORDER_ID
                                 AND ROWNUM = 1)
       ORDER BY LR.ACTIVIDAD;

    ---Cursor para obtener LOS MATERIALES
    Cursor CurMATERIAL(NUORDEN        or_order.ORDER_ID%TYPE,
                       NUTask_Type_Id or_order.Task_Type_Id%TYPE,
                       NUACTIVIDAD    OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE) is
      select LI.MATERIAL, LI.CANTIDAD
        FROM LDC_OTADICIONAL LI
       where LI.ORDER_ID = NUORDEN
         AND LI.TASK_TYPE_ID = NUTask_Type_Id
         AND LI.ACTIVIDAD = NUACTIVIDAD
       ORDER BY LI.MATERIAL;

    TEMPCurMATERIAL CurMATERIAL%ROWTYPE;

    --CURSOR PARA GENERAR CADENA QUE SERA TULIZADA PARA LEGALIZAR LA ORDEN
    CURSOR CUCADENALEGALIZACION(NUORDER_ID          OPEN.OR_ORDER.ORDER_ID%TYPE,
                                NUCAUSAL_ID         GE_CAUSAL.CAUSAL_ID%TYPE,
                                SBTEXTO             VARCHAR2,
                                SBDATOS             VARCHAR2,
                                TECNICO_UNIDAD      LDC_REGTIPOTRAADI.TECNICO_UNIDAD%TYPE,
                                Isbcadenamateriales VARCHAR2,
                                IsbATRIBUTO         VARCHAR2,
                                IsbLECTURAS         VARCHAR2) IS
      SELECT O.ORDER_ID || '|' || NUCAUSAL_ID || '|' || TECNICO_UNIDAD || '|' ||
             SBDATOS || '|' || A.ORDER_ACTIVITY_ID || '>' ||
             decode(nvl(dage_causal.fnugetclass_causal_id(NUCAUSAL_ID, null),
                        0),
                    1,
                    1,
                    0) --|| ';;;;|' || Isbcadenamateriales || '||1277;' ||
             || IsbATRIBUTO || '|' || Isbcadenamateriales || '|' ||
             IsbLECTURAS || '|1277;' || SBTEXTO CADENALEGALIZACION
        FROM OPEN.OR_ORDER O, OPEN.OR_ORDER_ACTIVITY A
       WHERE O.ORDER_ID = A.ORDER_ID
         AND O.ORDER_ID = TO_NUMBER(NUORDER_ID)
         and a.status = 'R'
         and not exists(select 1 from open.ct_item_novelty n where n.items_id=a.activity_id)
         AND ROWNUM = 1;

    SBCADENALEGALIZACION VARCHAR2(4000);

    ---Cursor para obtener LOS MATERIALES
    Cursor CuOR_ORDER_ACTIVITY(NUORDEN or_order.ORDER_ID%TYPE) is
      SELECT OOA.*
        FROM OPEN.OR_ORDER_ACTIVITY OOA
       WHERE OOA.ORDER_ID = NUORDEN
         AND ROWNUM = 1;

    RCCuOR_ORDER_ACTIVITY CuOR_ORDER_ACTIVITY%ROWTYPE;

    --CURSOR PARA OBTENER NOMRES DE DATOS ADICIONALES DE UN GRUPO DEL TIPO DE TRABAJO
    cursor cugrupo(nutask_type_id or_task_type.task_type_id%type,
                   NUCAUSAL_ID    GE_CAUSAL.CAUSAL_ID%TYPE) is
      select *
        from or_tasktype_add_data ottd
       where ottd.task_type_id = nutask_type_id
         and ottd.active = 'Y'
         and (SELECT count(1) cantidad
                FROM DUAL
               WHERE dage_causal.fnugetclass_causal_id(NUCAUSAL_ID, NULL) IN
                     (select column_value
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',
                                                                                                 NULL),
                                                                ',')))) = 1
            --/*
            --CASO 200-1932
            --and (ottd.use_ = decode(dage_causal.fnugetcausal_type_id(NUCAUSAL_ID),
         and (ottd.use_ = decode(DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(NUCAUSAL_ID),
                                 1,
                                 'C',
                                 2,
                                 'I') or ottd.use_ = 'B') --*/
      ;

    cursor cudatoadicional(nuattribute_set_id ge_attributes_set.attribute_set_id%type) is
      select *
        from ge_attributes b
       where b.attribute_id in
             (select a.attribute_id
                from ge_attrib_set_attrib a
               where a.attribute_set_id = nuattribute_set_id);

    RCGRUPO cugrupo%ROWTYPE;

    SBDATOSADICIONALES VARCHAR2(4000);

    ionuOrderId NUMBER(15);
    inuOrderActivityId number;

    onuValue       ge_unit_cost_ite_lis.price%type;
    onuPriceListId ge_list_unitary_cost.list_unitary_cost_id%type;
    idtDate        date;
    inuContract    ge_list_unitary_cost.contract_id%type;
    inuContractor  ge_list_unitary_cost.contractor_id%type;
    inuGeoLocation ge_list_unitary_cost.geograp_location_id%type;
    isbType        ge_acta.id_tipo_acta%type;
    nuTaskTypeId   or_task_type.task_type_id%type;

    nucantidad    number;
    SBOBSERVACION VARCHAR2(4000);
	  sbmessageerr VARCHAR2(4000);--caso: 146


    sbcadenamateriales VARCHAR2(4000);



    -- objetos pata legalizacion de la orden principal
    cursor cuLDC_ORDTIPTRAADI(NUORDER_ID OPEN.OR_ORDER.ORDER_ID%TYPE) is
      select * from open.ldc_otlegalizar lo where lo.order_id = NUORDER_ID;

    tempcuLDC_ORDTIPTRAADI cuLDC_ORDTIPTRAADI%rowtype;
    ---fin legalizacion de la orden principal

    cursor cuusualego is
      select lal.* from ldc_anexolegaliza lal where lal.order_id = isbId;
    /*
    select lu.*
      from ldc_usualego lu
     where lu.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID;
    */

    rfcuusualego cuusualego%rowtype;

    nuControlErrorActividad number := 0;

    --DATO ADICIONAL DESDE LEGO
    cursor cudatoadicionalLEGO(v_order_id     number,
                               v_task_type_id number,
                               v_causal_id    number) is
      select b.name_attribute name_attribute,
             (select lo.value
                from ldc_otdalegalizar lo
               where lo.order_id = v_order_id
                 and lo.name_attribute =
                     a.attribute_set_id || '_' || b.name_attribute
                 and lo.task_type_id = v_task_type_id
                 and lo.causal_id = v_causal_id) value
        from ge_attributes b, ge_attrib_set_attrib a
       where b.attribute_id = a.attribute_id
         and a.attribute_set_id in
             (select ottd.attribute_set_id
                from or_tasktype_add_data ottd
               where ottd.task_type_id = v_task_type_id
                 and ottd.active = 'Y'
                 and (SELECT count(1) cantidad
                        FROM DUAL
                       WHERE dage_causal.fnugetclass_causal_id(v_causal_id,
                                                               NULL) IN
                             (select column_value
                                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',
                                                                                                         NULL),
                                                                        ',')))) = 1
                    --/*
                    --CASO 200-1932
                    --and (ottd.use_ = decode(dage_causal.fnugetcausal_type_id(v_causal_id,null),
                 and (ottd.use_ = decode(DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(v_causal_id,
                                                                           null),
                                         1,
                                         'C',
                                         2,
                                         'I') or ottd.use_ = 'B') --*/
              )
       order by a.attribute_set_id, a.attribute_id;
    /*
    select *
      from ldc_otdalegalizar lodl
     where lodl.order_id = inuordenLEGO;
    */

    rfcudatoadicionalLEGO cudatoadicionalLEGO%rowtype;
    ---------------------------------------

    ---Cursor para obtener los items de la orden a gestionar
    Cursor CuItem(NUORDEN or_order.ORDER_ID%TYPE) is
      select LOI.ITEM, LOI.CANTIDAD
        FROM LDC_OTITEM LOI
       where LOI.ORDER_ID = NUORDEN
       ORDER BY Loi.Item;

    rfCuItem CuItem%ROWTYPE;

    --DATO ADICIONAL DESDE LEGO
    cursor culdc_otadicionalda(v_order_id     number,
                               v_task_type_id number,
                               v_causal_id    number,
                               v_actividad    number,
                               v_mateial      number) is
      select b.name_attribute name_attribute,
             (select lo.value
                from ldc_otadicionalda lo
               where lo.order_id = v_order_id
                 and lo.name_attribute =
                     a.attribute_set_id || '_' || b.name_attribute
                 and lo.task_type_id = v_task_type_id
                 and lo.causal_id = v_causal_id
                 and lo.actividad = v_actividad
                    --and lo.material = v_mateial
                 and rownum = 1) value,/*CA-672*/b.attribute_id
        from ge_attributes b, ge_attrib_set_attrib a
       where b.attribute_id = a.attribute_id
         and a.attribute_set_id in
             (select ottd.attribute_set_id
                from or_tasktype_add_data ottd
               where ottd.task_type_id = v_task_type_id
                 and ottd.active = 'Y'
                 and (SELECT count(1) cantidad
                        FROM DUAL
                       WHERE dage_causal.fnugetclass_causal_id(v_causal_id,
                                                               NULL) IN
                             (select column_value
                                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',
                                                                                                         NULL),
                                                                        ',')))) = 1
                    --/*
                    --CASO 200-1932
                    --and (ottd.use_ = decode(dage_causal.fnugetcausal_type_id(v_causal_id,null),
                 and (ottd.use_ = decode(DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(v_causal_id,
                                                                           null),
                                         1,
                                         'C',
                                         2,
                                         'I') or ottd.use_ = 'B') --*/
              )
       order by a.attribute_set_id, a.attribute_id;
    /*
    select *
      from ldc_otdalegalizar lodl
     where lodl.order_id = inuordenLEGO;
    */

    rfculdc_otadicionalda culdc_otadicionalda%rowtype;
    ---------------------------------------
    --Dato Actividad
    ----
    --cursor para identificar los datos actividad de la orden de gestion
    cursor culdc_otdatoactividad(InuActividad number, InuOrden number) is
      select 1 Ubicacion,
             a.component_1_id COMPONENTE,
             b.name_attribute NOMBRE,
             (select loda.name_attribute_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 1
                 and loda.order_id = InuOrden) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 1
                 and loda.order_id = InuOrden) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_1_id is not null
         and a.attribute_1_id = b.attribute_id
      union all
      select 2 Ubicacion,
             a.component_2_id COMPONENTE,
             b.name_attribute NOMBRE,
             (select loda.name_attribute_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 2
                 and loda.order_id = InuOrden) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 2
                 and loda.order_id = InuOrden) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_2_id is not null
         and a.attribute_2_id = b.attribute_id
      union all
      select 3 Ubicacion,
             a.component_3_id COMPONENTE,
             b.name_attribute NOMBRE,
             (select loda.name_attribute_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 3
                 and loda.order_id = InuOrden) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 3
                 and loda.order_id = InuOrden) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_3_id is not null
         and a.attribute_3_id = b.attribute_id
      union all
      select 4 Ubicacion,
             a.component_4_id COMPONENTE,
             b.name_attribute NOMBRE,
             (select loda.name_attribute_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 4
                 and loda.order_id = InuOrden) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 4
                 and loda.order_id = InuOrden) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_4_id is not null
         and a.attribute_4_id = b.attribute_id
       order by Ubicacion asc;

    rfculdc_otdatoactividad culdc_otdatoactividad%rowtype;

    Cursor CuActividadOrden(NUORDER_ID or_order.ORDER_ID%TYPE) is
      select or_order_activity.activity_id Actividad
        FROM or_order_activity
       where ORDER_ID = NUORDER_ID
         and or_order_activity.status = 'R'
         and not exists(select 1 from open.ct_item_novelty n where n.items_id=or_order_activity.activity_id)
         AND ROWNUM = 1;

    rfCuActividadOrden CuActividadOrden%rowtype;

    sbATRIBUTO   varchar2(4000);
    sbLECTURAS   varchar2(4000);
    sbATRIBUTO_1 varchar2(500);
    sbATRIBUTO_2 varchar2(500);
    sbATRIBUTO_3 varchar2(500);
    sbATRIBUTO_4 varchar2(500);
    sbLECTURAS_1 varchar2(500);
    sbLECTURAS_2 varchar2(500);
    sbLECTURAS_3 varchar2(500);
    sbLECTURAS_4 varchar2(500);

    CURSOR CUEXISTE(IsbATRIBUTO VARCHAR2, IsbParametro VARCHAR2) IS
      SELECT count(1) cantidad
        FROM DUAL
       WHERE IsbATRIBUTO IN
             (select column_value
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain(IsbParametro,
                                                                                         NULL),
                                                        ',')));

    nuCUEXISTE number;
    --------------------------------------------------------------------------------
    ------

    ---CASO 200-1528 Nace de un 300 Inicdente
    cursor cuelmesesu(inuorden number) is
      select emss.*
        from elmesesu emss
       where emss.emsssesu = (select ooa.product_id
                                from open.Or_Order_Activity ooa
                               where ooa.order_id = inuorden
                                 AND ROWNUM = 1)
       order by emss.emssfein desc;

    rfcuelmesesu cuelmesesu%rowtype;
    ----

    --CASO 200-1528
    --Generar Cadena de componentes de la actividad de la OT adicional
    --cursor para identificar los datos actividad de la orden de gestion
    cursor cuLDC_COMPONENTEOTADICIONAL(InuMaterial  number,
                                       InuActividad number,
                                       InuOrden     number) is
      select 1 Ubicacion,
             a.component_1_id COMPONENTE,
             b.name_attribute NOMBRE,
             (select loda.name_attribute_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 1
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 1
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_1_id is not null
         and a.attribute_1_id = b.attribute_id
      union all
      select 2 Ubicacion,
             a.component_2_id COMPONENTE,
             b.name_attribute NOMBRE,
             (select loda.name_attribute_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 2
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 2
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_2_id is not null
         and a.attribute_2_id = b.attribute_id
      union all
      select 3 Ubicacion,
             a.component_3_id COMPONENTE,
             b.name_attribute NOMBRE,
             (select loda.name_attribute_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 3
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 3
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_3_id is not null
         and a.attribute_3_id = b.attribute_id
      union all
      select 4 Ubicacion,
             a.component_4_id COMPONENTE,
             b.name_attribute NOMBRE,
             (select loda.name_attribute_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 4
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 4
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_4_id is not null
         and a.attribute_4_id = b.attribute_id
       order by Ubicacion asc;

    rfcuLDC_COMPONENTEOTADICIONAL cuLDC_COMPONENTEOTADICIONAL%rowtype;
    -----

    --Inicio Caso 200-1580
    ---Cursor para obtener los items con garantias
    CurItemWarranty         sys_refcursor;
    CIW_Item_Warranty_Id    GE_ITEM_WARRANTY.Item_Warranty_Id%type;
    CIW_Item_Id             GE_ITEM_WARRANTY.Item_Id%type;
    CIW_Element_Id          GE_ITEM_WARRANTY.Element_Id%type;
    CIW_Element_Code        GE_ITEM_WARRANTY.Element_Code%type;
    CIW_Product_Id          GE_ITEM_WARRANTY.Product_Id%type;
    CIW_ORDER_ID            GE_ITEM_WARRANTY.ORDER_ID%type;
    CIW_FINAL_WARRANTY_DATE GE_ITEM_WARRANTY.FINAL_WARRANTY_DATE%type;
    CIW_IS_ACTIVE           GE_ITEM_WARRANTY.IS_ACTIVE%type;
    CIW_ITEM_SERIED_ID      GE_ITEM_WARRANTY.ITEM_SERIED_ID%type;
    CIW_SERIE               GE_ITEM_WARRANTY.SERIE%type;
    CIW_ITEM                VARCHAR(4000);
    CIW_FLEGALIZACION       OR_ORDER.LEGALIZATION_DATE%TYPE;
    CIW_OBSERVACION         VARCHAR(4000);
    CIW_UNIDADOPERATIVA     OR_OPERATING_UNIT.NAME%TYPE;
    CIW_PACKAGE_ID          OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE;

    --Cursor para retornar un item del tipo de trabajo adicional legalizado
    cursor culdc_otadicional(NUORDEN or_order.ORDER_ID%TYPE) is
      select LR.TASK_TYPE_ID, LR.ACTIVIDAD, LR.CAUSAL_ID, LR.MATERIAL
        FROM OPEN.ldc_otadicional LR
       where LR.ORDER_ID = NUORDEN
         AND ROWNUM = 1
       GROUP BY LR.TASK_TYPE_ID, LR.ACTIVIDAD, LR.CAUSAL_ID, LR.MATERIAL
       ORDER BY LR.TASK_TYPE_ID, LR.ACTIVIDAD;

    rfculdc_otadicional culdc_otadicional%rowtype;

    NuControlGarantia number := 0;
    Sbcharge_status   or_order.charge_status%type := '1';
    --Fin Caso 200-1580

    --CASO 200-1679
    --Esta variable manejara la observacion original de la OT registrada en LEGO
    SBOBSERVACIONLEGO open.ldc_otlegalizar.order_comment%type;
    --Esta variable manejara la observacion original de la OT en LEGO sin caracteres especiales
    SBOBSERVACIONOSF open.ldc_otlegalizar.order_comment%type;
    --Parametro para los caracteres especiales a ser reemplazdos en el observacion
    --de la OT registrada en LEGO.
    CURSOR cuParaemtroCadena is
      select column_value
        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CAR_REP_OBS_LEGO',
                                                                                 NULL),
                                                ','));
    rfcuParaemtroCadena cuParaemtroCadena%rowtype;

    --Cursor para establecer que ordenes no tiene estado valido para confirmar
    --por parte de LEGO
    Cursor cuorder IS --(InuOrderID open.or_order.order_id%type) is
      select count(oo.order_id) cantidad --.*--,rowid
        from open.or_order oo
       where oo.order_id = isbId
         and oo.order_status_id IN
             (nvl(DALD_PARAMETER.fnuGetNumeric_Value('EST_LEG_OT_LEGO',
                                                     NULL),
                  0),
              nvl(DALD_PARAMETER.fnuGetNumeric_Value('EST_ANU_OT_LEGO', NULL),
                  0));
    rfcuorder cuorder%rowtype;
    --CASO 200-1679

    --146
    csbCaso146           varchar2(7):='0000146';
    sbAplica146          varchar2(1);
    sbInconsGara         varchar2(1);
    sbInconsPadr         varchar2(1);
    sbTitrIncons         open.or_order_activity.comment_%type;
    nuOtGarantia         open.or_order.order_id%type;
    nuExisOtGara         number;
    NuControlGPadre      number := 0;
    SbcharPadre          open.or_order.charge_status%type := '1';
    CurItemWarraPadre    sys_refcursor;
    sbValidaGaraPadre    varchar2(1):=nvl(open.dald_parameter.fsbgetvalue_chain('VALIDA_GARANTIA_OT_PADRE',null),'N');
    sbRegistraAudiGara   varchar2(1):=nvl(open.dald_parameter.fsbgetvalue_chain('REGISTRA_LDC_AUDIT_GARANTIA',null),'S');
    -- CA-672
    sbAplica672          VARCHAR2(1);
    nmvadaadusterocada   ld_parameter.numeric_value%TYPE := nvl(open.dald_parameter.fnuGetNumeric_Value('PARAM_DATADIC_USUTER_OCADANO',null),0);
    nmvadaadreppundist   ld_parameter.numeric_value%TYPE := nvl(open.dald_parameter.fnuGetNumeric_Value('PARAM_DATADIC_REPREA_PUNDIST',null),0);
    nmvadaadgdcocadano   ld_parameter.numeric_value%TYPE := nvl(open.dald_parameter.fnuGetNumeric_Value('PARAM_DATADIC_GDC_OCASI_DANO',null),0);
    nmvadaadsicbraugdc   ld_parameter.numeric_value%TYPE := nvl(open.dald_parameter.fnuGetNumeric_Value('PARAM_DATADIC_SINCOB_AUTO_GDC',null),0);
    sbvavldausteracdan   VARCHAR2(2) DEFAULT 'N';
    sbvavldareppundist   VARCHAR2(2) DEFAULT 'N';
    svvavaldagdcocadano  VARCHAR2(2) DEFAULT 'N';
    svvavaldasincoaugdc  VARCHAR2(2) DEFAULT 'N';
    nmcontaaprob         NUMBER(4);
    sbcorreos            VARCHAR2(4000) DEFAULT dald_parameter.fsbgetvalue_chain('PARAM_CORREO_APRRECH_ORDEN',NULL);
    sender               VARCHAR2(1000) DEFAULT dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER',NULL);
    sbmensajecue         VARCHAR2(1000);
    sbreqaproba          VARCHAR2(1);
    nmpacoderr           NUMBER;
    sbpamensaerr         VARCHAR2(1000);
    sbAutorizacion       VARCHAR2(1);

  BEGIN

    --caso 200-1679
    open cuorder;
    fetch cuorder
      into rfcuorder;
    close cuorder;

    --146
    if(fblAplicaEntregaxCaso('0000146'))then
          sbAplica146:='S';
          sbTitrIncons :=null;
          sbInconsPadr := 'N';
          nuExisOtGara := LDCPRBLOPORVAL(isbId);
    else
          sbAplica146:='N';
    end if;
    --146
    if(fblAplicaEntregaxCaso('0000672'))then
        sbAplica672 :='S';
        sbTitrIncons :=null;
        sbInconsPadr := 'N';
    else
        sbAplica672 :='N';
    end if;

    if sbAplica672 = 'S' and sbAplica146 = 'S' then
       update ldc_otlegalizar lol
         set  lol.mensaje_legalizado = 'Entregas 176 y 672 activas simulteanmente, apagar una de las 2'
       where lol.order_id = isbId;
      Commit;
      return;
    end if;

    if nvl(rfcuorder.cantidad, 0) = 0 then
      --caso 200-1679

      open cuusualego;
      fetch cuusualego
        into rfcuusualego;
      close cuusualego;

      ut_trace.trace('INICIO LDC_PKGESTIONORDENES.PrConfirmarOrden', 10);


      NuOrder_Ir := isbId;

      SBOBSERVACION := NULL;

      --------------------------------------------------------------------
      ---proceso de legalizacion de orden principal
      open cuLDC_ORDTIPTRAADI(NuOrder_Ir);
      fetch cuLDC_ORDTIPTRAADI
        into tempcuLDC_ORDTIPTRAADI;
      if cuLDC_ORDTIPTRAADI%notfound then
        onuErrorCode    := -1;
        osbErrorMessage := 'La orden [' || NuOrder_Ir ||
                           '] principal tiene inconvenientes en la configuracion de la forma LEGO';
        ut_trace.trace(osbErrorMessage, 10);
        close cuLDC_ORDTIPTRAADI;
        raise ex.CONTROLLED_ERROR;
      else
            if sbAplica146='S' and nuExisOtGara = 1 then
                  onuErrorCode    := -1;
                  if tempcuLDC_ORDTIPTRAADI.Mensaje_Legalizado like '%En proceso de validacion de garantias%' then
                    osbErrorMessage:=tempcuLDC_ORDTIPTRAADI.Mensaje_Legalizado;
                  else
                    osbErrorMessage:='En proceso de validacion de garantias';
                  end if;
            else

              nuTaskTypeId := daor_order.fnugetTask_Type_Id(NuOrder_Ir,0);
              IF tempcuLDC_ORDTIPTRAADI.task_type_id <> nuTaskTypeId THEN
                  tempcuLDC_ORDTIPTRAADI.task_type_id := nuTaskTypeId;
                  update open.ldc_otlegalizar set task_type_id = nuTaskTypeId where order_id = NuOrder_Ir;
              END IF;

              --Inicio CASO 200-1679
              SBOBSERVACIONLEGO := tempcuLDC_ORDTIPTRAADI.Order_Comment;
              --Ciclo para reemplazar lso caracteres especiales por espacios
              --para poder legalizar la OT en LEGO
              SBOBSERVACIONOSF := SBOBSERVACIONLEGO;
              FOR rfcuParaemtroCadena in cuParaemtroCadena loop
                SBOBSERVACIONOSF := replace(SBOBSERVACIONOSF,
                                            rfcuParaemtroCadena.Column_Value,
                                            ' ');
              END LOOP;
              --Fin CASO 200-1679

              --cadena datos adicionales
              SBDATOSADICIONALES := NULL;

              for rfcudatoadicionalLEGO in cudatoadicionalLEGO(NuOrder_Ir,
                                                               daor_order.fnugettask_type_id(NuOrder_Ir,
                                                                                             null),
                                                               tempcuLDC_ORDTIPTRAADI.Causal_Id) loop
                IF SBDATOSADICIONALES IS NULL THEN
                  SBDATOSADICIONALES := rfcudatoadicionalLEGO.NAME_ATTRIBUTE || '=' ||
                                        rfcudatoadicionalLEGO.Value;
                ELSE
                  SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                                        rfcudatoadicionalLEGO.NAME_ATTRIBUTE || '=' ||
                                        rfcudatoadicionalLEGO.Value;
                END IF;
              end loop;

              if SBDATOSADICIONALES is null then

                for rc in cugrupo(daor_order.fnugettask_type_id(NuOrder_Ir, null),
                                  tempcuLDC_ORDTIPTRAADI.Causal_Id) loop
                  dbms_output.put_line('Grupo de dato adicional [' ||
                                       rc.attribute_set_id ||
                                       '] asociado al tipo de trabajo [' ||
                                       rc.task_type_id || ']');
                  ut_trace.trace('Grupo de dato adicional [' ||
                                 rc.attribute_set_id ||
                                 '] asociado al tipo de trabajo [' ||
                                 rc.task_type_id || ']',
                                 10);

                  for rcdato in cudatoadicional(rc.attribute_set_id) loop
                    IF SBDATOSADICIONALES IS NULL THEN
                      SBDATOSADICIONALES := RCDATO.NAME_ATTRIBUTE || '=';
                    ELSE
                      SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                                            RCDATO.NAME_ATTRIBUTE || '=';
                    END IF;
                    dbms_output.put_line('Dato adicional[' ||
                                         rcdato.name_attribute || ']');
                    ut_trace.trace('Dato adicional[' || rcdato.name_attribute || ']',
                                   10);
                  end loop;
                end loop;

              end if; --if SBDATOSADICIONALES is null then
              --fin cadena datos adicionales

              ---Inicio de cadena para item de orden a gestionar
              sbcadenamateriales := null;
              FOR rfCuItem IN CuItem(NuOrder_Ir) LOOP

                if sbcadenamateriales is null then
                  sbcadenamateriales := rfCuItem.Item || '>' || rfCuItem.Cantidad || '>Y';
                else
                  sbcadenamateriales := sbcadenamateriales || ';' ||
                                        rfCuItem.Item || '>' || rfCuItem.Cantidad || '>Y';
                end if;

              END LOOP;
              ---Fin de cadena para item de orden a gestionar

              ---Cursor para armar cadena componentes actividad de la orden gestionada en LEGO
              --Dato Actividad

              if FnuClasificadorCausal(tempcuLDC_ORDTIPTRAADI.Causal_Id) = 0 then

                sbATRIBUTO := ';;;;';
                sbLECTURAS := null;

              else

                open CuActividadOrden(NuOrder_Ir);
                fetch CuActividadOrden
                  into rfCuActividadOrden;
                close CuActividadOrden;

                dbms_output.put_line('Actividad [' ||
                                     rfCuActividadOrden.Actividad || ']');
                ut_trace.trace('Actividad [' || rfCuActividadOrden.Actividad || ']',
                               10);

                for rfculdc_otdatoactividad in culdc_otdatoactividad(rfCuActividadOrden.Actividad,
                                                                     NuOrder_Ir) loop

                  dbms_output.put_line('Nombre Atributo [' ||
                                       rfculdc_otdatoactividad.nombre || ']');

                  if rfculdc_otdatoactividad.componente = 2 then
                    if sbATRIBUTO_1 is null then
                      if rfculdc_otdatoactividad.valor_atributo is not null then
                        sbATRIBUTO_1 := ';' || rfculdc_otdatoactividad.nombre || '>' ||
                                        rfculdc_otdatoactividad.valor_atributo || '>>';

                        open CUEXISTE(rfculdc_otdatoactividad.nombre,
                                      'COD_ATR_RET_LEGO');
                        fetch CUEXISTE
                          into nuCUEXISTE;
                        close CUEXISTE;

                        if nuCUEXISTE > 0 then
                          sbLECTURAS_1 := rfculdc_otdatoactividad.valor_atributo ||
                                          ';1=' || nvl(rfculdc_otdatoactividad.valor_componente,
                                                       0) || '=R===';
                        else
                          sbLECTURAS_1 := rfculdc_otdatoactividad.valor_atributo ||
                                          ';1=' || nvl(rfculdc_otdatoactividad.valor_componente,
                                                       0) || '=I===';
                        end if;
                      end if;
                    elsif sbATRIBUTO_2 is null then
                      if rfculdc_otdatoactividad.valor_atributo is not null then
                        sbATRIBUTO_2 := ';' || rfculdc_otdatoactividad.nombre || '>' ||
                                        rfculdc_otdatoactividad.valor_atributo || '>>';

                        open CUEXISTE(rfculdc_otdatoactividad.nombre,
                                      'COD_ATR_RET_LEGO');
                        fetch CUEXISTE
                          into nuCUEXISTE;
                        close CUEXISTE;

                        if nuCUEXISTE > 0 then
                          sbLECTURAS_2 := rfculdc_otdatoactividad.valor_atributo ||
                                          ';1=' || nvl(rfculdc_otdatoactividad.valor_componente,
                                                       0) || '=R===';
                        else
                          sbLECTURAS_2 := '<' ||
                                          rfculdc_otdatoactividad.valor_atributo ||
                                          ';1=' || nvl(rfculdc_otdatoactividad.valor_componente,
                                                       0) || '=I===';
                        end if;
                      end if;
                    end if;
                    ----CASO 200-1528 IDETNFIICACION DE OTROS COMPONENTES
                    --INICIO
                  else
                    if rfculdc_otdatoactividad.componente = 9 then
                      if sbATRIBUTO_1 is null then
                        if rfculdc_otdatoactividad.valor_atributo is not null OR rfculdc_otdatoactividad.valor_componente is not null  then
                          open cuelmesesu(NuOrder_Ir);
                          fetch cuelmesesu
                            into rfcuelmesesu;
                          close cuelmesesu;
                          sbATRIBUTO_1 := ';LECTURA>' ||
                                          nvl(rfculdc_otdatoactividad.valor_atributo,0) || '>>';

                          sbLECTURAS_1 := rfcuelmesesu.emsscoem || ';1=' ||
                                          nvl(rfculdc_otdatoactividad.valor_componente,
                                              0) || '=T===';
                        end if;
                      elsif sbATRIBUTO_2 is null then
                        if rfculdc_otdatoactividad.valor_atributo is not null OR rfculdc_otdatoactividad.valor_componente is not null then
                          open cuelmesesu(NuOrder_Ir);
                          fetch cuelmesesu
                            into rfcuelmesesu;
                          close cuelmesesu;

                          sbATRIBUTO_2 := ';LECTURA>' ||
                                          nvl(rfculdc_otdatoactividad.valor_atributo,0) || '>>';

                          sbLECTURAS_2 := rfcuelmesesu.emsscoem || ';1=' ||
                                          nvl(rfculdc_otdatoactividad.valor_componente,
                                              0) || '=T===';
                        end if;
                      end if;
                    end if;
                    --FIN
                    ----
                  end if;
                end loop;
                if sbATRIBUTO_1 is null then
                  sbATRIBUTO_1 := ';';
                end if;
                if sbATRIBUTO_2 is null then
                  sbATRIBUTO_2 := ';';
                end if;
                sbATRIBUTO_3 := ';';
                sbATRIBUTO_4 := ';';

                sbATRIBUTO := sbATRIBUTO_1 || sbATRIBUTO_2 || sbATRIBUTO_3 ||
                              sbATRIBUTO_4;
                sbLECTURAS := sbLECTURAS_1 || sbLECTURAS_2 || sbLECTURAS_3 ||
                              sbLECTURAS_4;

              end if;

              dbms_output.put_line('Dato ATRIBUTOS [' || sbATRIBUTO || ']');
              ut_trace.trace('Dato ATRIBUTOS [' || sbATRIBUTO || ']', 10);
              dbms_output.put_line('Dato LECTURAS [' || sbLECTURAS || ']');
              ut_trace.trace('Dato LECTURAS [' || sbLECTURAS || ']', 10);

              --Fin Dato Actividad----------------------------------------
              -------------------------------------------------------------

              --cadena legalizacion de orden prinipal
              SBCADENALEGALIZACION := NULL;
              OPEN CUCADENALEGALIZACION(NuOrder_Ir,
                                        tempcuLDC_ORDTIPTRAADI.Causal_Id,
                                        --'-Legalizacion por forma LEGO-' ||
                                        --nvl(tempcuLDC_ORDTIPTRAADI.Order_Comment,''),
                                        nvl(SBOBSERVACIONOSF, ''),
                                        SBDATOSADICIONALES,
                                        rfcuusualego.tecnico_unidad, --tempcuLDC_ORDTIPTRAADI.Tecnico_Unidad,
                                        sbcadenamateriales,
                                        sbATRIBUTO,
                                        sbLECTURAS);
              --null);
              FETCH CUCADENALEGALIZACION
                INTO SBCADENALEGALIZACION;
              CLOSE CUCADENALEGALIZACION;
              --fin cadena legalizacion de orden prinipal

              dbms_output.put_line('Cadena legalizacion orden principal [' ||
                                   SBCADENALEGALIZACION || '] ');
              ut_trace.trace('Cadena legalizacion orden principal [' ||
                             SBCADENALEGALIZACION || '] ',
                             10);

              ---INICIO LEGALIZAR TRABAJO ADICIONAL

              api_legalizeorders(SBCADENALEGALIZACION,
                                nvl(tempcuLDC_ORDTIPTRAADI.Exec_Initial_Date,
                                    sysdate),
                                nvl(tempcuLDC_ORDTIPTRAADI.Exec_Final_Date,
                                    sysdate),
                                sysdate,
                                onuErrorCode,
                                osbErrorMessage);

             if onuErrorCode = 0 then
                 if( sbAplica146 = 'S' and sbValidaGaraPadre = 'S' and open.dage_causal.fnugetclass_causal_id(tempcuLDC_ORDTIPTRAADI.Causal_Id, null ) = 1 and nuExisOtGara != 2) then

                      NuControlGPadre := 0;
                      SbcharPadre   := nvl(daor_order.fsbgetcharge_status(NuOrder_Ir,
                                                                              null),
                                               '0');
                      ut_trace.trace('rFrfOrdenesGarantia NuControlGPad'||NuControlGPadre, 10);
                      ut_trace.trace('rFrfOrdenesGarantia Sbcharge_status'||SbcharPadre, 10);
                      sbInconsPadr := 'N';
                      if FnuExistenciaGarantia(nuTaskTypeId,
                                               tempcuLDC_ORDTIPTRAADI.Causal_Id) = 1 then
                        rFrfOrdenesGarantia(NuOrder_Ir,
                                            nuTaskTypeId,
                        daor_order.FDTGETEXECUTION_FINAL_DATE(NuOrder_Ir),
                                              CurItemWarraPadre);
                        Loop
                          FETCH CurItemWarraPadre
                            INTO CIW_Item_Warranty_Id,
                                 CIW_Item_Id,
                                 CIW_Element_Id,
                                 CIW_Element_Code,
                                 CIW_Product_Id,
                                 CIW_ORDER_ID,
                                 CIW_FINAL_WARRANTY_DATE,
                                 CIW_IS_ACTIVE,
                                 CIW_ITEM_SERIED_ID,
                                 CIW_SERIE,
                                 CIW_ITEM,
                                 CIW_FLEGALIZACION,
                                 CIW_OBSERVACION,
                                 CIW_UNIDADOPERATIVA,
                                 CIW_PACKAGE_ID;

                          EXIT WHEN CurItemWarraPadre%NOTFOUND;
                          IF (CIW_ORDER_ID <> NuOrder_Ir) THEN

                             NuControlGPadre := 1;
                            --if nvl(daor_order.fsbgetcharge_status(ionuOrderId,null),0) = 3 then
                            ut_trace.trace('rFrfOrdenesGarantia CIW_ORDER_ID:'||CIW_ORDER_ID, 10);
                            if SbcharPadre = '3' then
                              ut_trace.trace('rFrfOrdenesGarantia SbcharPade = 3', 10);
                              if sbRegistraAudiGara = 'S' then
                                insert into LDC_AUDIT_GARANTIA
                                values
                                  (CIW_ORDER_ID, --CIW_Item_Warranty_Id,
                                   CIW_Item_Id,
                                   NuOrder_Ir, --NuOrder_Ir,
                                   rfCuActividadOrden.Actividad, --rfculdc_otadicional.material,--TEMPCurACTIVIDAD.Material,
                                   rfcuusualego.tecnico_unidad,
                                   open.daor_order.fnugetoperating_unit_id(ionuOrderId, null));
                                   sbInconsPadr :='S';
                              end if;
                            end if;
                          END IF;
                        END LOOP;

                        --if NuControlGarantia = 0 and nvl(daor_order.fsbgetcharge_status(ionuOrderId,null),0) <> 3 then
                        if NuControlGPadre = 0 and SbcharPadre <> '3' then

                          if sbRegistraAudiGara = 'S' then
                            insert into LDC_AUDIT_GARANTIA
                            values
                              (NULL, --CIW_Item_Warranty_Id,
                               NULL,
                               NuOrder_Ir, --482 se deja la orden padre
                               rfCuActividadOrden.Actividad , --rfculdc_otadicional.material,--TEMPCurACTIVIDAD.Material,
                               rfcuusualego.tecnico_unidad,
                               open.daor_order.fnugetoperating_unit_id(NuOrder_Ir, null));
                           end if;
                           sbInconsPadr :='S';
                        end if;

                      end if;
                 end if;
             end if;

              /*
              OS_LEGALIZEORDERALLACTIVITIES(NuOrder_Ir,
                                            tempcuLDC_ORDTIPTRAADI.Causal_Id,
                                            rfcuusualego.tecnico_unidad,
                                            tempcuLDC_ORDTIPTRAADI.Exec_Initial_Date,
                                            tempcuLDC_ORDTIPTRAADI.Exec_Final_Date,
                                            tempcuLDC_ORDTIPTRAADI.Order_Comment,
                                            SYSDATE,
                                            onuErrorCode,
                                            osbErrorMessage);
              */
              ---FIN LEGALIZACION TRABAJO ADICIONAL
               end if; --if sbAplica146='S' and nuExisOtGara = 2 then
            end if;
      close cuLDC_ORDTIPTRAADI;

      dbms_output.put_line('onuErrorCode[' || onuErrorCode || ']');
      ut_trace.trace('onuErrorCode[' || onuErrorCode || ']', 10);

      ---fin proceso para legalizar orden principal
      -----------------------------------------------------------------------

      if onuErrorCode = 0 then
        OPEN CurOrdenActi(NuOrder_Ir);
        FETCH CurOrdenActi
          INTO NuCodDir, sbCOMENTARIO, NUUNIDADOPERATIVA;
        close CurOrdenActi;

        --Ciclo para crear actividades para trabajos adicionales
        FOR TEMPCurACTIVIDAD IN CurACTIVIDAD(NuOrder_Ir) LOOP

          --No permitir seguri creando trabajos adicionales si al menos uno tubo un error
          if (nuControlErrorActividad = 0) then

            nucantidad := 0;

            OPEN CurEXISTEACTIVIDAD(NuOrder_Ir, TEMPCurACTIVIDAD.Actividad);
            FETCH CurEXISTEACTIVIDAD
              INTO nucantidad;
            CLOSE CurEXISTEACTIVIDAD;

            IF nucantidad = 0 THEN

              /*
              dbms_output.put_line('**********************************************');
              ut_trace.trace('**********************************************',
                             10);
              dbms_output.put_line('ORDEN ORIGINAL --> ' || NuOrder_Ir);
              ut_trace.trace('ORDEN ORIGINAL --> ' || NuOrder_Ir, 10);
              dbms_output.put_line('ACTIVIDAD --> ' ||
                                   TEMPCurACTIVIDAD.Actividad);
              ut_trace.trace('ACTIVIDAD --> ' || TEMPCurACTIVIDAD.Actividad,
                             10);
              dbms_output.put_line('**********************************************');
              ut_trace.trace('**********************************************',
                             10);
                */

              --se inicializa la variable para que genere la orden pro cada activdad para el trabajo adicional
              ionuOrderId := null;
              inuOrderActivityId := null;

              --/* CREAR ORDEN CON LA ACTIVIDAD DEL TRABAJO ADICIONAL
              --Incio OSF-630
              OPEN CuOR_ORDER_ACTIVITY(NuOrder_Ir);
                FETCH CuOR_ORDER_ACTIVITY
                  INTO RCCuOR_ORDER_ACTIVITY;
                CLOSE CuOR_ORDER_ACTIVITY;
              or_boorderactivities.CreateActivity(TEMPCurACTIVIDAD.Actividad,
                                                  RCCuOR_ORDER_ACTIVITY.Package_Id,
                                                  RCCuOR_ORDER_ACTIVITY.Motive_Id,
                                                  RCCuOR_ORDER_ACTIVITY.Component_Id,
                                                  null,
                                                  NuCodDir,
                                                  null,
                                                  RCCuOR_ORDER_ACTIVITY.Subscriber_Id,
                                                  RCCuOR_ORDER_ACTIVITY.Subscription_Id,
                                                  RCCuOR_ORDER_ACTIVITY.Product_Id,
                                                  RCCuOR_ORDER_ACTIVITY.Operating_Sector_Id,
                                                  null,
                                                  null,
                                                  null,
                                                  nvl(SBOBSERVACIONOSF, ''),
                                                  null,
                                                  null,
                                                  ionuOrderId,
                                                  inuOrderActivityId,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  0,
                                                  null,
                                                  null,
                                                  null,
                                                  null);
              --Fin OSF-630

              IF NVL(ionuOrderId,0) > 0 THEN

                ---ACTUALIZAR DATOS DE OR_ORDER_ACTIVITY
                

               /* UPDATE OR_ORDER_ACTIVITY OOA
                   SET OOA.PACKAGE_ID      = RCCuOR_ORDER_ACTIVITY.Package_Id,
                       OOA.MOTIVE_ID       = RCCuOR_ORDER_ACTIVITY.Motive_Id,
                       OOA.SUBSCRIBER_ID   = RCCuOR_ORDER_ACTIVITY.Subscriber_Id,
                       OOA.SUBSCRIPTION_ID = RCCuOR_ORDER_ACTIVITY.Subscription_Id,
                       OOA.PRODUCT_ID      = RCCuOR_ORDER_ACTIVITY.Product_Id
                 WHERE OOA.ORDER_ID = ionuOrderId;*/

                ---OR_ORDER_ACTIVITY

                dbms_output.put_line('ORDEN GENERADA --> ' || ionuOrderId);
                ut_trace.trace('ORDEN GENERADA --> ' || ionuOrderId, 10);

                ---INICIO RELACIONAR MATERIALES CON LA ORDEN ADICIONAL
                sbcadenamateriales := null;
                FOR TEMPCurMATERIAL IN CurMATERIAL(NuOrder_Ir,
                                                   TEMPCurACTIVIDAD.Task_Type_Id,
                                                   TEMPCurACTIVIDAD.Actividad) LOOP

                  if sbcadenamateriales is null then
                    sbcadenamateriales := TEMPCurMATERIAL.Material || '>' ||
                                          TEMPCurMATERIAL.Cantidad || '>Y';
                  else
                    sbcadenamateriales := sbcadenamateriales || ';' ||
                                          TEMPCurMATERIAL.Material || '>' ||
                                          TEMPCurMATERIAL.Cantidad || '>Y';
                  end if;

                END LOOP;
                ------FIN RELACIONAR MATERIALES CON LA ORDEN ADICIONAL

                -------INICIO RELACIONAR ORDEN ORIGEN CON LA ORDEN ADICIONAL
                OS_RELATED_ORDER(NuOrder_Ir,
                                 ionuOrderId,
                                 onuErrorCode,
                                 osbErrorMessage);

                IF onuErrorCode = 0 THEN
                  ---- ASIGNAR LA ORDEN A LA UNIDAD OPERATIVA
                  os_assign_order(ionuOrderId,
                                  NUUNIDADOPERATIVA,
                                  sysdate,
                                  sysdate,
                                  onuerrorcode,
                                  osberrormessage);

                  IF onuErrorCode = 0 THEN

                    --CADENA DE LEGALIZAICION ORDEN
                    --cadena datos adicionales de ordenes adicionales

                    --cadena datos adicionales
                    SBDATOSADICIONALES := NULL;
                    if sbAplica672 = 'S' then
                       sbvavldausteracdan:='N';
                       sbvavldareppundist:='N';
                       svvavaldagdcocadano:='N';
                       svvavaldasincoaugdc:='N';
                    end if;
                    for rfculdc_otadicionalda in culdc_otadicionalda(NuOrder_Ir,
                                                                     TEMPCurACTIVIDAD.Task_Type_Id,
                                                                     TEMPCurACTIVIDAD.Causal_Id,
                                                                     TEMPCurACTIVIDAD.Actividad,
                                                                     --TEMPCurACTIVIDAD.Material
                                                                     0) loop

                      -- Inicio -- CA-672
                      if sbAplica672 = 'S' then
                        IF rfculdc_otadicionalda.attribute_id = nmvadaadusterocada THEN
                           sbvavldausteracdan := nvl(rfculdc_otadicionalda.Value,'N');
                           sbvavldausteracdan := TRIM(sbvavldausteracdan);
                           rfculdc_otadicionalda.Value:=nvl(rfculdc_otadicionalda.Value,'N');
                        ELSIF rfculdc_otadicionalda.attribute_id = nmvadaadreppundist THEN
                           sbvavldareppundist := nvl(rfculdc_otadicionalda.Value,'N');
                           sbvavldareppundist := TRIM(sbvavldareppundist);
                           rfculdc_otadicionalda.Value:=nvl(rfculdc_otadicionalda.Value,'N');
                        ELSIF rfculdc_otadicionalda.attribute_id = nmvadaadgdcocadano THEN
                           svvavaldagdcocadano := nvl(rfculdc_otadicionalda.Value,'N');
                           svvavaldagdcocadano := TRIM(svvavaldagdcocadano);
                           rfculdc_otadicionalda.Value:=nvl(rfculdc_otadicionalda.Value,'N');
                        ELSIF rfculdc_otadicionalda.attribute_id = nmvadaadsicbraugdc THEN
                           svvavaldasincoaugdc := nvl(rfculdc_otadicionalda.Value,'N');
                           svvavaldasincoaugdc := TRIM(svvavaldasincoaugdc);
                           rfculdc_otadicionalda.Value:=nvl(rfculdc_otadicionalda.Value,'N');
                        END IF;
                      end if;

                      -- tempcuLDC_ORDTIPTRAADI.Causal_Id) loop
                      --IF rfculdc_otadicionalda.Value is not null then
                      IF SBDATOSADICIONALES IS NULL THEN
                        SBDATOSADICIONALES := rfculdc_otadicionalda.NAME_ATTRIBUTE || '=' ||
                                              rfculdc_otadicionalda.Value;
                      ELSE
                        SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                                              rfculdc_otadicionalda.NAME_ATTRIBUTE || '=' ||
                                              rfculdc_otadicionalda.Value;
                      END IF;
                      --end if;
                    end loop;

                    --SBDATOSADICIONALES := NULL;
                    if SBDATOSADICIONALES is null then
                      for rc in cugrupo(TEMPCurACTIVIDAD.Task_Type_Id,
                                        TEMPCurACTIVIDAD.Causal_Id) loop
                        -- tempcuLDC_ORDTIPTRAADI.Causal_Id) loop
                        dbms_output.put_line('Grupo de dato adicional [' ||
                                             rc.attribute_set_id ||
                                             '] asociado al tipo de trabajo [' ||
                                             rc.task_type_id || ']');
                        dbms_output.put_line('Grupo de dato adicional [' ||
                                             rc.attribute_set_id ||
                                             '] asociado al tipo de trabajo [' ||
                                             rc.task_type_id || ']');

                        for rcdato in cudatoadicional(rc.attribute_set_id) loop
                          IF SBDATOSADICIONALES IS NULL THEN
                            SBDATOSADICIONALES := RCDATO.NAME_ATTRIBUTE || '=';
                          ELSE
                            SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                                                  RCDATO.NAME_ATTRIBUTE || '=';
                          END IF;
                          dbms_output.put_line('Dato adicional[' ||
                                               rcdato.name_attribute || ']');
                          ut_trace.trace('Dato adicional[' ||
                                         rcdato.name_attribute || ']',
                                         10);
                        end loop;
                      end loop;
                    end if; --if SBDATOSADICIONALES is null then
                    --fin cadena datos adicionales

                    dbms_output.put_line('DATOS ADICIONALES[' ||
                                         SBDATOSADICIONALES || ']');
                    ut_trace.trace('DATOS ADICIONALES[' ||
                                   SBDATOSADICIONALES || ']',
                                   10);

                    SBCADENALEGALIZACION := NULL;

                    --dbms_output.put_line('Causal OT Adicional [' || TEMPCurACTIVIDAD.Causal_Id || ']');
                    --ut_trace.trace('Causal OT Adicional [' || TEMPCurACTIVIDAD.Causal_Id || ']',10);

                    --dbms_output.put_line('Causal OT Adicional FnuClasificadorCausal(TEMPCurACTIVIDAD.Causal_Id)[' || FnuClasificadorCausal(TEMPCurACTIVIDAD.Causal_Id) || ']');
                    --ut_trace.trace('Causal OT Adicional FnuClasificadorCausal(TEMPCurACTIVIDAD.Causal_Id)[' || FnuClasificadorCausal(TEMPCurACTIVIDAD.Causal_Id) || ']',10);

                    if FnuClasificadorCausal(TEMPCurACTIVIDAD.Causal_Id) = 0 then

                      sbATRIBUTO := ';;;;';
                      sbLECTURAS := null;

                    else

                      sbATRIBUTO_1 := null;
                      sbATRIBUTO_2 := null;
                      sbATRIBUTO_3 := null;
                      sbATRIBUTO_4 := null;

                      sbLECTURAS_1 := null;
                      sbLECTURAS_2 := null;
                      sbLECTURAS_3 := null;
                      sbLECTURAS_4 := null;

                      --CASO 200-1528
                      --Inicio Proceso de generacion de cadena para componentes de actividad de la OT adicional
                      ---Cursor para armar cadena componentes actividad de la orden gestionada en LEGO
                      --Dato Actividad
                      /*dbms_output.put_line('Actividad OT Adicional[' ||
                                           TEMPCurACTIVIDAD.Actividad || ']');
                      ut_trace.trace('Actividad OT Adicional[' ||
                                     TEMPCurACTIVIDAD.Actividad || ']',
                                     10);
                      dbms_output.put_line('Material OT Adicional[' ||
                                           TEMPCurACTIVIDAD.Material || ']');
                      ut_trace.trace('Material OT Adicional[' ||
                                     TEMPCurACTIVIDAD.Material || ']',
                                     10);*/
                      dbms_output.put_line('Orden Padre[' || NuOrder_Ir || ']');
                      ut_trace.trace('Orden Padre[' || NuOrder_Ir || ']',
                                     10);

                      for rfcuLDC_COMPONENTEOTADICIONAL in cuLDC_COMPONENTEOTADICIONAL(0, --TEMPCurACTIVIDAD.Material,
                                                                                       TEMPCurACTIVIDAD.Actividad,
                                                                                       NuOrder_Ir) loop

                        dbms_output.put_line('Nombre Atributo [' ||
                                             rfcuLDC_COMPONENTEOTADICIONAL.nombre || ']');

                        if rfcuLDC_COMPONENTEOTADICIONAL.componente = 2 then
                          if sbATRIBUTO_1 is null then
                            if rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo is not null then
                              sbATRIBUTO_1 := ';' ||
                                              rfcuLDC_COMPONENTEOTADICIONAL.nombre || '>' ||
                                              rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo || '>>';

                              open CUEXISTE(rfcuLDC_COMPONENTEOTADICIONAL.nombre,
                                            'COD_ATR_RET_LEGO');
                              fetch CUEXISTE
                                into nuCUEXISTE;
                              close CUEXISTE;

                              if nuCUEXISTE > 0 then
                                sbLECTURAS_1 := rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo ||
                                                ';1=' || nvl(rfcuLDC_COMPONENTEOTADICIONAL.valor_componente,
                                                             0) || '=R===';
                              else
                                sbLECTURAS_1 := rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo ||
                                                ';1=' || nvl(rfcuLDC_COMPONENTEOTADICIONAL.valor_componente,
                                                             0) || '=I===';
                              end if;
                            end if;
                          elsif sbATRIBUTO_2 is null then
                            if rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo is not null then
                              sbATRIBUTO_2 := ';' ||
                                              rfcuLDC_COMPONENTEOTADICIONAL.nombre || '>' ||
                                              rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo || '>>';

                              open CUEXISTE(rfcuLDC_COMPONENTEOTADICIONAL.nombre,
                                            'COD_ATR_RET_LEGO');
                              fetch CUEXISTE
                                into nuCUEXISTE;
                              close CUEXISTE;

                              if nuCUEXISTE > 0 then
                                sbLECTURAS_2 := rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo ||
                                                ';1=' || nvl(rfcuLDC_COMPONENTEOTADICIONAL.valor_componente,
                                                             0) || '=R===';
                              else
                                sbLECTURAS_2 := '<' ||
                                                rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo ||
                                                ';1=' || nvl(rfcuLDC_COMPONENTEOTADICIONAL.valor_componente,
                                                             0) || '=I===';
                              end if;
                            end if;
                          end if;
                          ----CASO 200-1528 IDETNFIICACION DE OTROS COMPONENTES
                          --INICIO
                        else
                          if rfcuLDC_COMPONENTEOTADICIONAL.componente = 9 then
                            if sbATRIBUTO_1 is null then
                              if rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo is not null then
                                open cuelmesesu(NuOrder_Ir);
                                fetch cuelmesesu
                                  into rfcuelmesesu;
                                close cuelmesesu;
                                sbATRIBUTO_1 := ';LECTURA>' ||
                                                rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo || '>>';

                                sbLECTURAS_1 := rfcuelmesesu.emsscoem ||
                                                ';1=' || nvl(rfcuLDC_COMPONENTEOTADICIONAL.valor_componente,
                                                             0) || '=T===';
                              end if;
                            elsif sbATRIBUTO_2 is null then
                              if rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo is not null then
                                open cuelmesesu(NuOrder_Ir);
                                fetch cuelmesesu
                                  into rfcuelmesesu;
                                close cuelmesesu;

                                sbATRIBUTO_2 := ';LECTURA>' ||
                                                rfcuLDC_COMPONENTEOTADICIONAL.valor_atributo || '>>';

                                sbLECTURAS_2 := rfcuelmesesu.emsscoem ||
                                                ';1=' || nvl(rfcuLDC_COMPONENTEOTADICIONAL.valor_componente,
                                                             0) || '=T===';
                              end if;
                            end if;
                          end if;
                          --FIN
                          ----
                        end if;
                      end loop;

                      if sbATRIBUTO_1 is null then
                        sbATRIBUTO_1 := ';';
                      end if;
                      if sbATRIBUTO_2 is null then
                        sbATRIBUTO_2 := ';';
                      end if;
                      sbATRIBUTO_3 := ';';
                      sbATRIBUTO_4 := ';';

                      sbATRIBUTO := sbATRIBUTO_1 || sbATRIBUTO_2 ||
                                    sbATRIBUTO_3 || sbATRIBUTO_4;
                      sbLECTURAS := sbLECTURAS_1 || sbLECTURAS_2 ||
                                    sbLECTURAS_3 || sbLECTURAS_4;
                    end if;
                    dbms_output.put_line('Dato ATRIBUTOS [' || sbATRIBUTO || ']');
                    ut_trace.trace('Dato ATRIBUTOS [' || sbATRIBUTO || ']',
                                   10);
                    dbms_output.put_line('Dato LECTURAS [' || sbLECTURAS || ']');
                    ut_trace.trace('Dato LECTURAS [' || sbLECTURAS || ']',
                                   10);

                    --Fin Dato Actividad----------------------------------------
                    -----------------------------------------------------------------------------

                    OPEN CUCADENALEGALIZACION(ionuOrderId,
                                              TEMPCurACTIVIDAD.Causal_Id, --tempcuLDC_ORDTIPTRAADI.Causal_Id,
                                              --tempcuLDC_ORDTIPTRAADI.Order_Comment,
                                              nvl(SBOBSERVACIONOSF, ''),
                                              SBDATOSADICIONALES,
                                              rfcuusualego.tecnico_unidad,
                                              sbcadenamateriales,
                                              sbATRIBUTO,
                                              sbLECTURAS);
                    FETCH CUCADENALEGALIZACION
                      INTO SBCADENALEGALIZACION;
                    CLOSE CUCADENALEGALIZACION;
                    --FIN CADENA LEGALIZACION ORDEN
                    dbms_output.put_line('CADENA LEGALIZACION[' ||
                                         SBCADENALEGALIZACION || ']');
                    ut_trace.trace('CADENA LEGALIZACION[' ||
                                   SBCADENALEGALIZACION || ']',
                                   10);

                    --relacionar orden con tecnico y unidad de trabajo
                    insert into ldc_asig_ot_tecn
                      (unidad_operativa, tecnico_unidad, orden)
                    values
                      (NUUNIDADOPERATIVA,
                       OPEN.GE_BOPERSONAL.FNUGETPERSONID,
                       ionuOrderId);
                    --fin relacion

                    --se realiza un proceso COMMIT antes de realizar el
                    --proceso de legalizacion de orden adcional
                    /*--CASO 200-1369*/
                    --commit;

                    --fin commit;

                    ---INICIO LEGALIZAR TRABAJO ADICIONAL
                    api_legalizeorders(SBCADENALEGALIZACION,
                                      nvl(tempcuLDC_ORDTIPTRAADI.Exec_Initial_Date,
                                          sysdate),
                                      nvl(tempcuLDC_ORDTIPTRAADI.Exec_Final_Date,
                                          sysdate),
                                      sysdate,
                                      onuErrorCode,
                                      osbErrorMessage);

                    --if (onuErrorCode = 0) then
                    --  commit;
                    --else
                    if (onuErrorCode <> 0) then
                      nuControlErrorActividad := 1;

                      dbms_output.put_line('ERROR AL LEGALIZAR LA ORDEN [' ||
                                           ionuOrderId || '] ' ||
                                           onuErrorCode || ' - ' ||
                                           osbErrorMessage);
                      ut_trace.trace('ERROR AL LEGALIZAR LA ORDEN [' ||
                                     ionuOrderId || '] ' || onuErrorCode ||
                                     ' - ' || osbErrorMessage,
                                     10);

                      SBOBSERVACION := 'Error al utilizar el servicio api_legalizeorders [' ||
                                       onuErrorCode || ' - ' ||
                                       osbErrorMessage || ']';

                      --reversar el proceso de legalizaion de orden adicional
                      rollback;

                      begin
                        update ldc_otlegalizar lol
                           set lol.legalizado         = 'N',
                               lol.mensaje_legalizado = SBOBSERVACION
                         where lol.order_id = NuOrder_Ir;
                        commit;
                      end;

                      --Caso 200-1580 - Insercion en tabla auditoria
                    else
                      --CAUSAL: TEMPCurACTIVIDAD.Causal_Id
                      --TIPO DE TRABAJO: TEMPCurACTIVIDAD.Task_Type_Id
                      --
                      --otgarantia
                      --itemgarantia
                      --otlegalizada: NuOrder_Ir
                      --itemlegalizado: TEMPCurACTIVIDAD.Material
                      --usuario: (p)rfcuusualego.tecnico_unidad
                      --unidadoperativa: NUUNIDADOPERATIVA

                      /*
                      open culdc_otadicional(NuOrder_Ir);
                      fetch culdc_otadicional into rfculdc_otadicional;
                      close culdc_otadicional;
                      */

                      NuControlGarantia := 0;
                      Sbcharge_status   := nvl(daor_order.fsbgetcharge_status(ionuOrderId,
                                                                              null),
                                               '0');
                      ut_trace.trace('rFrfOrdenesGarantia NuControlGarantia'||NuControlGarantia, 10);
                      ut_trace.trace('rFrfOrdenesGarantia Sbcharge_status'||Sbcharge_status, 10);
                      sbInconsGara:='N';
                      sbAutorizacion :='N';

                      if (FnuExistenciaGarantia(TEMPCurACTIVIDAD.Task_Type_Id,
                                               TEMPCurACTIVIDAD.Causal_Id) = 1  and open.dage_causal.fnugetclass_causal_id(TEMPCurACTIVIDAD.Causal_Id, null) = 1) and
                      ((nuExisOtGara != 2 and sbAplica146 = 'S') or sbAplica146 = 'N')  then

                        rFrfOrdenesGarantia(NuOrder_Ir,
                                            TEMPCurACTIVIDAD.Task_Type_Id,
                        daor_order.FDTGETEXECUTION_FINAL_DATE(NuOrder_Ir),
                                              CurItemWarranty);
                        Loop
                          FETCH CurItemWarranty
                            INTO CIW_Item_Warranty_Id,
                                 CIW_Item_Id,
                                 CIW_Element_Id,
                                 CIW_Element_Code,
                                 CIW_Product_Id,
                                 CIW_ORDER_ID,
                                 CIW_FINAL_WARRANTY_DATE,
                                 CIW_IS_ACTIVE,
                                 CIW_ITEM_SERIED_ID,
                                 CIW_SERIE,
                                 CIW_ITEM,
                                 CIW_FLEGALIZACION,
                                 CIW_OBSERVACION,
                                 CIW_UNIDADOPERATIVA,
                                 CIW_PACKAGE_ID;

                          EXIT WHEN CurItemWarranty%NOTFOUND;

						                   salir:=0; --caso: 146
                          IF (CIW_ORDER_ID <> ionuOrderId and RCCuOR_ORDER_ACTIVITY.Package_Id!=CIW_PACKAGE_ID) THEN

                             NuControlGarantia := 1;
                            --if nvl(daor_order.fsbgetcharge_status(ionuOrderId,null),0) = 3 then
                            ut_trace.trace('rFrfOrdenesGarantia CIW_ORDER_ID:'||CIW_ORDER_ID, 10);
                            if Sbcharge_status = '3' then
                              ut_trace.trace('rFrfOrdenesGarantia Sbcharge_status = 3', 10);
                              if sbRegistraAudiGara = 'S' then
                                insert into LDC_AUDIT_GARANTIA
                                values
                                  (CIW_ORDER_ID, --CIW_Item_Warranty_Id,
                                   CIW_Item_Id,
                                   ionuOrderId, --NuOrder_Ir,
                                   TEMPCurACTIVIDAD.Actividad, --rfculdc_otadicional.material,--TEMPCurACTIVIDAD.Material,
                                   rfcuusualego.tecnico_unidad,
                                   NUUNIDADOPERATIVA);
                               end if;
                                  -- Inicio: 146
                                  if( sbAplica146 = 'S' or (sbAplica672 = 'S' and sbvavldausteracdan ='N' and sbvavldareppundist ='N' ))then
                                      sbInconsGara:='S';
                                  end if;
                                  -- Fin: 146
                            end if;
                          END IF;
                        END LOOP;

                        --if NuControlGarantia = 0 and nvl(daor_order.fsbgetcharge_status(ionuOrderId,null),0) <> 3 then
                        if NuControlGarantia = 0 and Sbcharge_status <> '3' then

                          if sbRegistraAudiGara = 'S' then
                            insert into LDC_AUDIT_GARANTIA
                            values
                              (NULL, --CIW_Item_Warranty_Id,
                               NULL,
                               ionuOrderId, --NuOrder_Ir,
                               TEMPCurACTIVIDAD.Actividad, --rfculdc_otadicional.material,--TEMPCurACTIVIDAD.Material,
                               rfcuusualego.tecnico_unidad,
                               NUUNIDADOPERATIVA);
                          end if;
                             -- Inicio: 146
                                if( sbAplica146 = 'S' or (sbAplica672 = 'S' and svvavaldagdcocadano = 'N' and svvavaldasincoaugdc = 'N'))then
                                  sbInconsGara:='S';
                                end if;
                                if sbAplica672 = 'S' and (svvavaldagdcocadano = 'S' OR svvavaldasincoaugdc = 'S') then
                                   sbAutorizacion :='S';
                                else
                                   sbAutorizacion :='N';
                                end if;
                             -- Fin: 146
                        end if;

                      end if;
                      --Inicio 146
                       if( (sbAplica146 = 'S' or sbAplica672 = 'S') and sbInconsGara = 'S')then
                           if sbTitrIncons is null then
                             sbTitrIncons := 'Inconsistencias en Garantias tipos de trabajo Adicionales : '||TEMPCurACTIVIDAD.TASK_TYPE_ID;
                           else
                             	sbTitrIncons := sbTitrIncons||', '||TEMPCurACTIVIDAD.TASK_TYPE_ID;
                           end if;
                       end if;

                       if sbAplica672 ='S' and sbInconsGara='N' and sbAutorizacion ='S' then
                          --Se valida si esta pendiente alguna aprobacion
                          SELECT COUNT(1) INTO nmcontaaprob
                            FROM ldc_otscobleg h
                           WHERE h.nro_orden = NuOrder_Ir
                             and h.tipo_trab_adic = tempcuractividad.task_type_id
                             AND h.estado = 'APROBADA';
                          IF  nmcontaaprob = 0 THEN
                            --se valida si ya hay una solicitud registrada
                            --si hay no debe volver a registrar
                            --sino hay debe registrar
                            SELECT COUNT(1) INTO nmcontaaprob
                            FROM ldc_otscobleg h
                           WHERE h.nro_orden = NuOrder_Ir
                             and h.tipo_trab_adic = tempcuractividad.task_type_id
                             AND h.estado = 'PENDIENTE APROBACION';
                            nmpacoderr := 0;
                            IF  nmcontaaprob = 0 THEN

                               ldc_pkgotssincobsingar.ldc_prccrearegaproleg(
                                                                            NuOrder_Ir
                                                                           ,tempcuractividad.task_type_id
                                                                           ,svvavaldagdcocadano
                                                                           ,svvavaldasincoaugdc
                                                                           ,nmpacoderr
                                                                           ,sbpamensaerr
                                                                           );
                               IF nmpacoderr = 0 THEN
                                sbmensajecue := 'Orden : '||to_char(NuOrder_Ir)||' pendiente de aprobacion para que el contratista proceda a legalizarla.';
                                ldc_email.mail(sender, sbcorreos, 'Orden pendiente de aprobacion', sbmensajecue);
                               ELSE
                                sbTitrIncons := 'Inconsistencias tipos de trabajo Adicionales : '||tempcuractividad.task_type_id||' '||sbpamensaerr;
                               END IF;
                            End if;
                            if nmpacoderr = 0 then
                              if sbTitrIncons is null then
                                 sbTitrIncons := 'Inconsistencias en Garantias tipos de trabajo Adicionales : '||TEMPCurACTIVIDAD.TASK_TYPE_ID||' Pendiente aprobacion';
                               else
                                  sbTitrIncons := sbTitrIncons||', '||TEMPCurACTIVIDAD.TASK_TYPE_ID||' Pendiente aprobacion';
                               end if;
                            end if;

                            ---
                          end if;

                       end if;

                       --Fin 146
                      --Fin Caso 200-1580
                    end if;
                    ---FIN LEGALIZACION TRABAJO ADICIONAL

                  ELSE

                    nuControlErrorActividad := 1;

                    /*
                    dbms_output.put_line('ERROR AL ASIGNAR LA ORDEN [' ||
                                         ionuOrderId ||
                                         '] A LA UNIDAD OPERATIVA [' ||
                                         NUUNIDADOPERATIVA || '] ' ||
                                         onuErrorCode || ' - ' ||
                                         osbErrorMessage);
                    DBMS_OUTPUT.put_line('ERROR AL ASIGNAR LA ORDEN [' ||
                                         ionuOrderId ||
                                         '] A LA UNIDAD OPERATIVA [' ||
                                         NUUNIDADOPERATIVA || '] ' ||
                                         onuErrorCode || ' - ' ||
                                         osbErrorMessage);
                    */

                    SBOBSERVACION := 'Error en el servicio os_assign_order al asignar la nueva orden a la unidad [' ||
                                     NUUNIDADOPERATIVA || '] - [' ||
                                     onuErrorCode || ' - ' ||
                                     osbErrorMessage || ']';

                    rollback;

                    begin
                      update ldc_otlegalizar lol
                         set lol.legalizado         = 'N',
                             lol.mensaje_legalizado = SBOBSERVACION
                       where lol.order_id = NuOrder_Ir;
                      commit;
                    end;

                  END IF;
                  ----FIN ASIGNACION ORDEN
                ELSE

                  nuControlErrorActividad := 1;

                  /*
                  dbms_output.put_line('ERROR AL RELACIONAR LA ORDEN [' ||
                                       ionuOrderId ||
                                       '] A LA ORDEN ORIGINAL [' ||
                                       NuOrder_Ir || '] ' || onuErrorCode ||
                                       ' - ' || osbErrorMessage);
                  ut_trace.trace('ERROR AL RELACIONAR LA ORDEN [' ||
                                 ionuOrderId || '] A LA ORDEN ORIGINAL [' ||
                                 NuOrder_Ir || '] ' || onuErrorCode || ' - ' ||
                                 osbErrorMessage,
                                 10);
                    */

                  SBOBSERVACION := 'ERROR AL RELACIONAR LA ORDEN [' ||
                                   ionuOrderId || '] A LA ORDEN ORIGINAL [' ||
                                   NuOrder_Ir ||
                                   '] Utilizando el servicio OS_RELATED_ORDER';
                  rollback;

                  begin
                    update ldc_otlegalizar lol
                       set lol.legalizado         = 'N',
                           lol.mensaje_legalizado = SBOBSERVACION
                     where lol.order_id = NuOrder_Ir;
                    commit;
                  end;

                END IF;
                --FIN RELACIONAR ORDEN ORIGEN CON LA ORDEN ADICIONAL*/

                /*--CASO 200-1369*/
                --commit;

              ELSE
                --IF onuErrorCode = 0 THEN de la creacion de orden con OS_CREATEORDERACTIVITIES

                --Inicio OSF-630
                errors.GETERROR(onuErrorCode, osbErrorMessage);
                --Fin OSF-630

                nuControlErrorActividad := 1;

                dbms_output.put_line('ERROR AL GENERAR EL TRABAJO ADICIONAL CON LA ACTIVIDAD [' ||
                                     TEMPCurACTIVIDAD.Actividad || '] ' ||
                                     onuErrorCode || ' - ' ||
                                     osbErrorMessage);
                ut_trace.trace('ERROR AL GENERAR EL TRABAJO ADICIONAL CON LA ACTIVIDAD [' ||
                               TEMPCurACTIVIDAD.Actividad || '] ' ||
                               onuErrorCode || ' - ' || osbErrorMessage,
                               10);

                SBOBSERVACION := 'ERROR AL GENERAR EL TRABAJO ADICIONAL CON EL SERIVICIO OS_CREATEORDERACTIVITIES CON LA ACTIVIDAD [' ||
                                 TEMPCurACTIVIDAD.Actividad || '] ' ||
                                 onuErrorCode || ' - ' || osbErrorMessage || ']';
                rollback;

                begin
                  update ldc_otlegalizar lol
                     set lol.legalizado         = 'N',
                         lol.mensaje_legalizado = SBOBSERVACION
                   where lol.order_id = NuOrder_Ir;
                  commit;
                end;

              END IF;
              /*
              ELSE
                IF SBOBSERVACION IS NULL THEN
                  SBOBSERVACION := 'LA ACTIVIDAD [' || TEMPCurACTIVIDAD.Actividad ||
                                   '] YA TIENE TIPO DE TRABAJO ADICIONAL RELACIONADA CON LA ORDEN [' ||
                                   NuOrder_Ir || ']';
                ELSE
                  SBOBSERVACION := SBOBSERVACION || CHR(10) || ' LA ACTIVIDAD [' ||
                                   TEMPCurACTIVIDAD.Actividad ||
                                   '] YA TIENE TIPO DE TRABAJO ADICIONAL RELACIONADA CON LA ORDEN [' ||
                                   NuOrder_Ir || ']';
                END IF;
              */
            END IF; --FIN DE VALIDACION DE EXISTENCIA TRABAJO ADICIONAL
          END IF; --      if (nuControlErrorActividad = 0) then
        END LOOP;

        --INICIO CA 200-2404
       IF fblAplicaEntregaxcaso('200-2404') AND nuControlErrorActividad = 0 THEN

          PROVALIINTECOTI(NuOrder_Ir,onuErrorCode, osbErrorMessage);

          IF onuErrorCode <> 0 THEN
            SBOBSERVACION := osbErrorMessage;
            nuControlErrorActividad := 1;
            rollback;

            begin
              update ldc_otlegalizar lol
               set lol.legalizado         = 'N',
                   lol.mensaje_legalizado = SBOBSERVACION
              where lol.order_id = NuOrder_Ir;
              commit;
            end;
          END IF;
        END IF;
        --FIN CA 200-2404

        --146
        if( sbAplica146 = 'S' and (sbTitrIncons is not null or sbInconsPadr = 'S') and nuControlErrorActividad = 0)then --482 se valida que no haya error para generar la ot de validacion
            rollback;
            if sbInconsPadr = 'S' then
               sbTitrIncons :='Inconsistencias en la orden padre titr '||nuTaskTypeId||'.'||sbTitrIncons;
            end if;
            nuControlErrorActividad:=1;
            LDC_PKGVALGA.PRCRORVAL(NuOrder_Ir,sbTitrIncons, sbmessageerr, nuOtGarantia);
            if sbmessageerr is not null then
                 update ldc_otlegalizar lol -- insert en la tabla de ldc_otlegalizar
                     set lol.legalizado         = 'N',
                       lol.mensaje_legalizado = 'Error al intentar crear la orden de validacion ' || sbmessageerr
                   where lol.order_id = NuOrder_Ir;
                  commit;
            else
              update ldc_otlegalizar lol -- insert en la tabla de ldc_otlegalizar
                     set lol.legalizado         = 'N',
                       lol.mensaje_legalizado = 'En proceso de validacion de garantias, se ha generado la orden #[' || nuOtGarantia ||']'
                   where lol.order_id = NuOrder_Ir;
                  commit;
            end if;

        end if;

        if (sbAplica672 ='S' and (sbTitrIncons is not null or sbInconsPadr = 'S')) then
          rollback;
          if sbInconsPadr = 'S' then
               sbTitrIncons :='Inconsistencias en la orden padre titr '||nuTaskTypeId||'.'||sbTitrIncons;
          end if;
          nuControlErrorActividad:=1;
          UPDATE ldc_otlegalizar lol -- insert en la tabla de ldc_otlegalizar
             SET lol.legalizado         = 'N'
                ,lol.mensaje_legalizado = 'Error : ' || sbTitrIncons
           WHERE lol.order_id = nuorder_ir;
          COMMIT;
        end if;
        --146
        --if SBOBSERVACION is not null then
        if nuControlErrorActividad = 0 then
          update ldc_otlegalizar lol
             set lol.legalizado = 'S', lol.mensaje_legalizado = null
           where lol.order_id = NuOrder_Ir;
          dbms_output.put_line('ACTUALIZA ORDEN CON S');
          ut_trace.trace('ACTUALIZA ORDEN CON S', 10);
          commit;

          --CASO 200-1679
          --Actualizar la observacion retornando los caracteres especiales
          --a la observacion de la OT registrada en LEGO
          update open.or_order_comment ooa
             set ooa.ORDER_COMMENT = SBOBSERVACIONLEGO
           where ooa.ORDER_ID = NuOrder_Ir
           and ooa.LEGALIZE_COMMENT = 'Y';
          Commit;
          --Fin CASO 200-1679

        end if;

      else

        SBOBSERVACION := 'ERROR EN EL SERVICIO api_legalizeorders [' ||
                         onuErrorCode || ' - ' || osbErrorMessage || ']';

        rollback;

        begin
          update ldc_otlegalizar lol
             set lol.legalizado         = 'N',
                 lol.mensaje_legalizado = SBOBSERVACION
           where lol.order_id = NuOrder_Ir;
          commit;
        end;

        commit;

      end if;

      --CASO 200-1679
      --FIN CURSOR cuorder
    ELSE
      --Actualizar la observacion retornando los caracteres especiales
      --a la observacion de la OT registrada en LEGO
      update ldc_otlegalizar lol
         set lol.legalizado = 'S', lol.mensaje_legalizado = null
       where lol.order_id = isbId;
      Commit;
    END IF;
    --CASO 200-1679

    dbms_output.put_line('FIN LDC_PKGESTIONORDENES.PrConfirmarOrden');
    --ROLLBACK;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      ROLLBACK;
      raise;

    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := 'Error Controlado por Sistema Codigo[' ||
                         TO_CHAR(SQLCODE) || '] - Mensaje[' || SQLERRM || ']';
      DBMS_OUTPUT.put_line(osbErrorMessage);
      ROLLBACK;
      update ldc_otlegalizar lol
         set lol.legalizado         = 'N',
             lol.mensaje_legalizado = nvl(SBOBSERVACION, osbErrorMessage)
       where lol.order_id = NuOrder_Ir;
      commit;

  END PrConfirmarOrden;
  ---Fin

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosBasicos
  Descripcion    : Obtiene datos de la orden de trabajo

  Autor          : Jorge Valiente
  Fecha          : 11/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  17/10/2018      Eduardo Cer?n       CASO 200-2218: Se modifica el cursor rfQuery para que tenga en
                                                     cuenta ?nicamente las ?rdenes abiertas y que no
                                                     sean novedad
  09/Julio/2018   Jorge Valiente      CASO 200-1679: Modificar los servicios para que las sentencias
                                                     con OR_ORDER_ACTIVITY manejen las restricciones
                                                     mencionadas por la N1 incluyen el ROWNUM = 1
  ******************************************************************/
  FUNCTION FrfDatosBasicos(OrdenTrabajo number) RETURN tyRefCursor IS
    rfQuery    tyRefCursor;
    nuPersonID ge_person.person_id%type;

    ---Inicio CASO 200-1528
    cursor cuelmesesu is
      select emss.*
        from elmesesu emss
       where emss.emsssesu = (select ooa.product_id
                                from open.Or_Order_Activity ooa
                               where ooa.order_id = OrdenTrabajo
                                 and ooa.status = 'R'
                                 and not exists(select 1 from open.ct_item_novelty n where n.items_id=ooa.activity_id)
                                 and rownum = 1)
       order by emss.emssfein desc;

    rfcuelmesesu cuelmesesu%rowtype;

    cursor cumarcaproducto is
      SELECT LDC_MARCA_PRODUCTO.ID_PRODUCTO,
             LDC_MARCA_PRODUCTO.ORDER_ID,
             LDC_MARCA_PRODUCTO.CERTIFICADO,
             LDC_MARCA_PRODUCTO.FECHA_ULTIMA_ACTU,
             LDC_MARCA_PRODUCTO.INTENTOS,
             decode(LDC_MARCA_PRODUCTO.MEDIO_RECEPCION,
                    'I',
                    'I - Interna',
                    'E - Externa') MEDIO_RECEPCION,
             LDC_MARCA_PRODUCTO.REGISTER_POR_DEFECTO,
             nvl(LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID, 101) || ' - ' ||
             dage_suspension_type.fsbgetdescription(nvl(LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID,
                                                        101)) SUSPENSION_TYPE_ID
        FROM LDC_MARCA_PRODUCTO
       WHERE ldc_marca_producto.ID_PRODUCTO =
             (select ooa.product_id
                from open.Or_Order_Activity ooa
               where ooa.order_id = OrdenTrabajo
                 and ooa.status = 'R'
                 and not exists(select 1 from open.ct_item_novelty n where n.items_id=ooa.activity_id)
                 and rownum = 1);

    rfcumarcaproducto cumarcaproducto%rowtype;
    ---Fin CASO 200-1528

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfDatosBasicos', 10);
    ut_trace.trace('Orden a consulta [' || OrdenTrabajo || ']', 10);

    ut_trace.trace('Orden a consulta [' || OrdenTrabajo || ']', 10);

    nuPersonID := OPEN.GE_BOPERSONAL.FNUGETPERSONID;

    ut_trace.trace('Person ID [' || nuPersonID || ']', 10);

    ---Inicio CASO 200-1528
    open cuelmesesu;
    fetch cuelmesesu
      into rfcuelmesesu;
    close cuelmesesu;

    open cumarcaproducto;
    fetch cumarcaproducto
      into rfcumarcaproducto;
    close cumarcaproducto;
    ---Fin CASO 200-1528

    open rfQuery for
      select /*+ index (o PK_OR_ORDER)*/
       oo.task_type_id || ' ' ||
       daor_task_type.fsbgetdescription(oo.task_type_id, null) tipotrabajo,
       nvl(ooa.subscription_id, 0) Contrato,
       'Pendiente de Confirmaci?n' Estado,
       'De forma de confirguracion' Agente,
       oo.created_date fechacreacion,
       oo.assigned_date fechaasignacion,
       lol.fecha_registro fechaprogramacion,
       dage_geogra_location.fnugetgeo_loca_father_id(aa.geograp_location_id) || ' ' ||
       dage_geogra_location.fsbgetdescription(dage_geogra_location.fnugetgeo_loca_father_id(aa.geograp_location_id)) departamento,
       dage_geogra_location.fnugetgeograp_location_id(aa.geograp_location_id) || ' ' ||
       dage_geogra_location.fsbgetdescription(dage_geogra_location.fnugetgeograp_location_id(aa.geograp_location_id)) localidad,
       aa.address direccion,
       lol.causal_id causal,
       dage_causal.fsbgetdescription(lol.causal_id, null) desccausal,
       ooa.comment_ observacionorden,
       lol.order_comment observaciongestion,
       lol.exec_initial_date fechainieje,
       lol.exec_final_date fechafineje,
       oo.task_type_id tipotrabajo_id,
       oo.operating_unit_id operating_unit_id,
       daor_operating_unit.fsbgetname(oo.operating_unit_id, null) nameoperating_unit_id,
       ooa.product_id product_id,
       ooa.package_id package_id,
       (select c.cicldesc
          from ciclo c
         where c.ciclcodi = (select s.susccicl
                               from suscripc s
                              where s.susccodi = ooa.subscription_id
                                and rownum = 1)
           and rownum = 1) cicldesc,
       (SELECT NVL(LAL.tecnico_unidad, 0)
          FROM LDC_ANEXOLEGALIZA LAL
         WHERE LAL.ORDER_ID = OrdenTrabajo) tecnico_legaliza,
       aa.geograp_location_id ubicacion_geografica,
       oo.exec_initial_date fecha_ini_ejecucion,
       oo.execution_final_date fecha_fin_ejecucion,
       ooa.activity_id actividad,
       nvl(rfcuelmesesu.emsscoem, 0) medidor,
       nvl(rfcumarcaproducto.suspension_type_id, 0) marca
        from open.or_order          oo,
             open.Or_Order_Activity ooa,
             ab_address             aa,
             ldc_otlegalizar        lol
       where oo.order_id = OrdenTrabajo
         and oo.order_id = ooa.order_id
         and ooa.status = 'R'
         and not exists(select 1 from open.ct_item_novelty n where n.items_id=ooa.activity_id)
         and aa.address_id = decode(nvl(ooa.address_id, 0),
                                    0,
                                    (select s.susciddi
                                       from suscripc s
                                      where s.susccodi = ooa.subscription_id),
                                    ooa.address_id)
         AND OO.ORDER_STATUS_ID IN
             (DALD_PARAMETER.fnuGetNumeric_Value('ESTADO_ASIGNADO', NULL),
              DALD_PARAMETER.fnuGetNumeric_Value('COD_ESTA_EJEC', NULL))
         and lol.order_id = oo.order_id
         and (select count(ooup.operating_unit_id)
                from or_oper_unit_persons ooup
               where ooup.person_id = nuPersonID
                 and ooup.operating_unit_id = oo.operating_unit_id) > 0;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfDatosBasicos', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfDatosBasicos;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfOrdenAdicional
  Descripcion    : Obtiene datos de la orden de trabajo adicional de la orden de gestion

  Autor          : Jorge Valiente
  Fecha          : 04/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfOrdenAdicional(OrdenTrabajo number) RETURN tyRefCursor IS
    rfQuery tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfOrdenAdicional', 10);
    ut_trace.trace('Orden a consulta [' || OrdenTrabajo || ']', 10);

    open rfQuery for
      select loa.task_type_id tipotrabajo,
             loa.actividad    actividad,
             loa.material     material,
             loa.cantidad     cantidad,
             loa.causal_id    causal
      --loa.valormaterial valormaterial
        from ldc_otadicional loa
       where loa.order_id = OrdenTrabajo;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfOrdenAdicional', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfOrdenAdicional;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrEliminarOrdenAdicional
  Descripcion    : Editar las ordenes adicionales para actualizar las nuevas

  Autor          : Jorge Valiente
  Fecha          : 14/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrEliminarOrdenAdicional(v_order_id number) IS

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrEliminarOrdenAdicional',
                   10);
    ut_trace.trace('Orden a editar [' || v_order_id ||
                   '] con ot adicionales',
                   10);

    delete from LDC_OTAdicional t where t.order_id = v_order_id;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrEliminarOrdenAdicional', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrEliminarOrdenAdicional;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FsbAgente
  Descripcion    : Agente relacionado con la orden de gestion

  Autor          : Jorge Valiente
  Fecha          : 22/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FsbAgente(OrdenTrabajo number) RETURN varchar2 IS

    cursor cusbagente is
      select la.description AGENTE
        from ldc_usualego lu, LDC_ANEXOLEGALIZA lal, LDC_AGENLEGO la
       where lal.order_id = OrdenTrabajo
         and lal.agente_id = la.agente_id
         and la.agente_id = lu.agente_id
         and rownum = 1;

    rfcusbagente cusbagente%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FsbAgente', 10);
    ut_trace.trace('Orden a consulta [' || OrdenTrabajo || ']', 10);

    open cusbagente;
    fetch cusbagente
      into rfcusbagente;
    close cusbagente;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FsbAgente', 10);

    return(nvl(rfcusbagente.agente, 0));
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FsbAgente;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfOrdenGestionExcel
  Descripcion    : Obtiene datos de la orden en gestion para ser plasmados en un archivo excel

  Autor          : Jorge Valiente
  Fecha          : 09/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  17/10/2018      Eduardo Cer?n       CASO 200-2218: Se modifica el cursor rfQuery para que tenga en
                                                     cuenta ?nicamente las ?rdenes abiertas y que no
                                                     sean novedad
  ******************************************************************/
  FUNCTION FrfOrdenGestionExcel(inuTipoTrab number,
                                idtDesde    date,
                                idtHasta    date) RETURN tyRefCursor IS
    rfQuery tyRefCursor;

    nuPersonID ge_person.person_id%type;

  BEGIN

    nuPersonID := OPEN.GE_BOPERSONAL.FNUGETPERSONID;

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfOrdenGestionExcel', 10);
    ut_trace.trace('Desde [' || idtDesde || ']', 10);
    ut_trace.trace('Hasta [' || idtHasta || ']', 10);

    open rfQuery for
      select lol.order_id ORDEN,
             lol.causal_id || ' - ' ||
             dage_causal.fsbgetdescription(lol.causal_id, null) CAUSAL,
             la.tecnico_unidad TECNICO,
             lol.order_comment OBSERVACION,
             loi.item || ' - ' ||
             dage_items.fsbgetdescription(loi.item, null) ITEM,
             loi.cantidad ITEM_CANTIDAD,
             (select b.display_name
                from ge_attributes b, ge_attrib_set_attrib a
               where b.attribute_id = a.attribute_id
                 and a.attribute_set_id || '_' || b.name_attribute =
                     lda.name_attribute) DATO_ADICIONAL_GESTION,
             lda.value VALOR_DATO_ADICIONAL_GESTION,
             lo.task_type_id || ' - ' ||
             daor_task_type.fsbgetdescription(lo.task_type_id, null) TIPO_TRABAJO,
             lo.actividad || ' - ' ||
             dage_items.fsbgetdescription(lo.actividad, null) ACTIVIDAD,
             lo.material MATERIAL,
             lo.cantidad CANTIDAD,
             (select b.display_name
                from ge_attributes b, ge_attrib_set_attrib a
               where b.attribute_id = a.attribute_id
                 and a.attribute_set_id || '_' || b.name_attribute =
                     loda.name_attribute) DATO_ADICIONAL,
             loda.value VALOR_DATO_ADICIONAL,
             ooa.product_id PRODUCTO,
             ooa.package_id SOLICITUD,
             ooa.operating_unit_id UNIDAD_TRABAJO,
             daor_operating_unit.fsbgetname(ooa.operating_unit_id, null) UNIDAD_TRABAJO_DESCRIPCION,
             (select s.susccicl
                from suscripc s
               where s.susccodi = ooa.subscription_id
                 and rownum = 1) CICLO,
             lol.mensaje_legalizado ERROR
        from open.ldc_otlegalizar   lol,
             open.ldc_anexolegaliza la,
             open.ldc_otadicional   lo,
             open.ldc_usualego      lu,
             open.Or_Order_Activity ooa,
             open.ldc_otitem        loi,
             open.ldc_otadicionalda loda,
             open.ldc_otdalegalizar lda
       where lol.legalizado = 'N'
         and lol.task_type_id =
             decode(inuTipoTrab, -1, lol.task_type_id, inuTipoTrab)
         and trunc(lol.fecha_registro) >= trunc(idtDesde)
         and trunc(lol.fecha_registro) <= trunc(idtHasta)
         and lol.order_id = la.order_id
         and ooa.status = 'R'
         and not exists(select 1 from open.ct_item_novelty n where n.items_id=ooa.activity_id)
         and lol.order_id = lo.order_id(+)
         and lol.order_id = loi.order_id(+)
         and lol.order_id = loda.order_id(+)
         and lol.order_id = lda.order_id(+)
         and la.agente_id = lu.agente_id
         and lu.person_id = nuPersonID
         and ooa.order_id = lol.order_id
       order by lol.order_id;

    /*Sentencia comentariada por CASO 200-1528 para agregar nuevos datos
      select lol.order_id ORDEN,
          lol.causal_id || ' - ' || dage_causal.fsbgetdescription(lol.causal_id,null) CAUSAL,
          la.tecnico_unidad TECNICO,
          lol.order_comment OBSERVACION,
          loi.item || ' - ' || dage_items.fsbgetdescription(loi.item,null) ITEM,
          lo.task_type_id || ' - ' || daor_task_type.fsbgetdescription(lo.task_type_id,null) TIPO_TRABAJO,
          lo.actividad || ' - ' || dage_items.fsbgetdescription(lo.actividad,null) ACTIVIDAD,
          lo.material MATERIAL,
          lo.cantidad CANTIDAD,
          ooa.product_id PRODUCTO,
          ooa.package_id SOLICITUD,
          ooa.operating_unit_id UNIDAD_TRABAJO,
          daor_operating_unit.fsbgetname(ooa.operating_unit_id, null) UNIDAD_TRABAJO_DESCRIPCION,
          (select s.susccicl
             from suscripc s
            where s.susccodi = ooa.subscription_id
              and rownum = 1) CICLO,
          lol.mensaje_legalizado ERROR
     from open.ldc_otlegalizar   lol,
          open.ldc_anexolegaliza la,
          open.ldc_otadicional   lo,
          open.ldc_usualego      lu,
          open.Or_Order_Activity ooa,
          open.                  ldc_otitem loi
    where lol.legalizado = 'N'
      and lol.task_type_id =
          decode(inuTipoTrab, -1, lol.task_type_id, inuTipoTrab)
      and trunc(lol.fecha_registro) >= trunc(idtDesde)
      and trunc(lol.fecha_registro) <= trunc(idtHasta)
      and lol.order_id = la.order_id
      and lol.order_id = lo.order_id(+)
      and lol.order_id = loi.order_id(+)
      and la.agente_id = lu.agente_id
      and lu.person_id = nuPersonID
      and ooa.order_id = lol.order_id
    order by lol.order_id;*/

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfOrdenGestionExcel', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfOrdenGestionExcel;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrHistorialTTLEGO
  Descripcion    : Historial de ordenes LEGO

  Autor          : Jorge Valiente
  Fecha          : 04/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrHistorialTTLEGO(onuOTRegistradas  out number,
                              onuOTAsignadas    out number,
                              onuOTSinFinalizar out number) IS

    cursor cuordenescreadas is
      SELECT count(1) cantidad
        FROM open.or_order oo
       WHERE oo.task_type_id IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('HIST_TIPO_TRAB_LEGO',
                                                                                         NULL),
                                                        ',')))
         and oo.order_status_id =
             dald_parameter.fnuGetNumeric_Value('ESTADO_REGISTRADO')
      /*
      and (select count(1)
             from or_ope_uni_task_type ooutt, or_oper_unit_persons ooup
            where ooutt.task_type_id = oo.task_type_id
              and ooutt.operating_unit_id = ooup.operating_unit_id
              and ooup.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID) > 0*/
      ;

    rfcuordenescreadas cuordenescreadas%rowtype;

    cursor cuotasignadas is
      SELECT count(1) cantidad
        FROM open.or_order oo, or_oper_unit_persons ooup
       WHERE oo.task_type_id IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('HIST_TIPO_TRAB_LEGO',
                                                                                         NULL),
                                                        ',')))
         and oo.order_status_id =
             DALD_PARAMETER.fnuGetNumeric_Value('ESTADO_ASIGNADO', NULL)
         and ooup.operating_unit_id = oo.operating_unit_id
         and ooup.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID;

    rfcuotasignadas cuotasignadas%rowtype;

    cursor cuotejecutada is
      SELECT count(1) cantidad
        FROM open.or_order oo, or_oper_unit_persons ooup
       WHERE oo.task_type_id IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('HIST_TIPO_TRAB_LEGO',
                                                                                         NULL),
                                                        ',')))
         and oo.order_status_id =
             DALD_PARAMETER.fnuGetNumeric_Value('COD_ESTA_EJEC', NULL)
         and ooup.operating_unit_id = oo.operating_unit_id
         and ooup.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID;

    rfcuotejecutada cuotejecutada%rowtype;

    cursor cuotsinfinalizar is
      select count(nvl(lol.order_id, 0)) cantidad
        from LDC_OTLEGALIZAR lol, or_order oo
       where oo.order_id = lol.order_id
         and lol.legalizado = 'N'
         and oo.operating_unit_id in
             (select ooup.operating_unit_id
                from or_oper_unit_persons ooup
               where ooup.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID
               group by ooup.operating_unit_id);

    rfcuotsinfinalizar cuotsinfinalizar%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrHistorialTTLEGO', 10);

    onuOTRegistradas  := 0;
    onuOTAsignadas    := 0;
    onuOTSinFinalizar := 0;

    open cuordenescreadas;
    fetch cuordenescreadas
      into rfcuordenescreadas;
    if cuordenescreadas%found then
      if rfcuordenescreadas.cantidad > 0 then
        onuOTRegistradas := rfcuordenescreadas.cantidad;
      end if;
    end if;
    close cuordenescreadas;

    open cuotasignadas;
    fetch cuotasignadas
      into rfcuotasignadas;
    if cuotasignadas%found then
      if rfcuotasignadas.cantidad > 0 then
        onuOTAsignadas := rfcuotasignadas.cantidad;
      end if;
    end if;
    close cuotasignadas;

    open cuotejecutada;
    fetch cuotejecutada
      into rfcuotejecutada;
    if cuotejecutada%found then
      if rfcuotejecutada.cantidad > 0 then
        onuOTAsignadas := nvl(onuOTAsignadas, 0) + rfcuotejecutada.cantidad;
      end if;
    end if;
    close cuotejecutada;

    open cuotsinfinalizar;
    fetch cuotsinfinalizar
      into rfcuotsinfinalizar;
    if cuotsinfinalizar%found then
      if rfcuotsinfinalizar.cantidad > 0 then
        onuOTSinFinalizar := rfcuotsinfinalizar.cantidad;
      end if;
    end if;
    close cuotsinfinalizar;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrHistorialTTLEGO', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrHistorialTTLEGO;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuExisteFuncional
  Descripcion    : Valida si existe el funcional configurado el LDCLEGO

  Autor          : Jorge Valiente
  Fecha          : 08/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuExisteFuncional RETURN number IS

    cursor cuExisteFuncional is
      select count(1) cantidad
        from ldc_usualego lu
       where lu.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID
         and rownum = 1;

    rfcuExisteFuncional cuExisteFuncional%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FnuExisteFuncional', 10);

    open cuExisteFuncional;
    fetch cuExisteFuncional into rfcuExisteFuncional;
    close cuExisteFuncional;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FnuExisteFuncional', 10);

    return(nvl(rfcuExisteFuncional.Cantidad, 0));

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 0;
    when others then
      return 0;
  END FnuExisteFuncional;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfFuncionalLEGO
  Descripcion    : Obtiene datos de la configuracion de LDCLEGO

  Autor          : Jorge Valiente
  Fecha          : 08/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfFuncionalLEGO RETURN tyRefCursor IS

    rfQuery tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfFuncionalLEGO', 10);

    open rfQuery for
      select lu.person_id      person_id,
             lu.agente_id      agente_id,
             lu.tecnico_unidad tecnico_unidad,
             lu.unico_tecnico  unico_tecnico,
             lu.causal_id      causal_id
        from ldc_usualego lu
       where lu.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID
         and rownum = 1;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfFuncionalLEGO', 10);

    return(rfQuery);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfFuncionalLEGO;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfTipoTrabLEGO
  Descripcion    : Obtiene datos de la configuracion del Tipo de Trabajo Principal de LDCLEGO

  Autor          : Jorge Valiente
  Fecha          : 09/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfTipoTrabLEGO RETURN tyRefCursor IS

    rfQuery tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfTipoTrabLEGO', 10);

    open rfQuery for
      select lttl.tipotrablego_id from ldc_tipotrablego lttl;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfTipoTrabLEGO', 10);

    return(rfQuery);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfTipoTrabLEGO;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoTipoTrabLEGO
  Descripcion    : Registrar el tipo de trabajo principal para LEGO

  Autor          : Jorge Valiente
  Fecha          : 09/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoTipoTrabLEGO(v_tipotrablego_id number) IS

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrRegistoTipoTrabLEGO', 10);

    ut_trace.trace('Tipo de trabajo LEGO[' || v_tipotrablego_id || ']', 10);

    insert into ldc_tipotrablego
      (tipotrablego_id)
    values
      (v_tipotrablego_id);

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrRegistoTipoTrabLEGO', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrRegistoTipoTrabLEGO;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuUOACOfertados
  Descripcion    : Valida si existe la undiad operativa para actividades e items opfertadas en LDCUAI

  Autor          : Jorge Valiente
  Fecha          : 11/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuUOACOfertados(inuUOACOfertados number) RETURN number IS

    cursor cuFnuUOACOfertados is
      select count(1) cantidad
        from LDC_ITEM_UO_LR lu
       where lu.unidad_operativa = inuUOACOfertados;

    rfcuFnuUOACOfertados cuFnuUOACOfertados%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FnuUOACOfertados', 10);

    open cuFnuUOACOfertados;
    fetch cuFnuUOACOfertados
      into rfcuFnuUOACOfertados;
    close cuFnuUOACOfertados;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FnuExisteUOCotizada', 10);

    return(nvl(rfcuFnuUOACOfertados.Cantidad, 0));

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 0;
    when others then
      return 0;
  END FnuUOACOfertados;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuTotalDatosAdicionales
  Descripcion    : Obtiene la cantidad de datos adicionales configurados
                   en el tipo de trabajo de la orden a gestionar

  Autor          : Jorge Valiente
  Fecha          : 12/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  30/05/2018      Jorge Valiente      CASO 200-1932: Cambio de logica de indetificacion
                                                     de clasificador de causal en lugar de
                                                     el tipo de causal.
  ******************************************************************/
  FUNCTION FnuTotalDatosAdicionales(nutask_type_id number,
                                    NUCAUSAL_ID    number) RETURN number IS

    cursor cuTotalDatosAdicionales is
      select count(a.attribute_id) Cantidad
        from ge_attributes b, ge_attrib_set_attrib a
       where b.attribute_id = a.attribute_id
         and a.attribute_set_id in
             (select ottd.attribute_set_id
                from or_tasktype_add_data ottd
               where ottd.task_type_id = nutask_type_id
                 and ottd.active = 'Y'
                 and (SELECT count(1) cantidad
                        FROM DUAL
                       WHERE dage_causal.fnugetclass_causal_id(NUCAUSAL_ID,
                                                               NULL) IN
                             (select column_value
                                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',
                                                                                                         NULL),
                                                                        ',')))) = 1
                    --/*
                    --CASO 200-1932
                    --and (ottd.use_ = decode(dage_causal.fnugetcausal_type_id(NUCAUSAL_ID,null),
                 and (ottd.use_ = decode(DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(NUCAUSAL_ID,
                                                                           null),
                                         1,
                                         'C',
                                         2,
                                         'I') or ottd.use_ = 'B') --*/
              )
       order by a.attribute_set_id, a.attribute_id;

    rfcuTotalDatosAdicionales cuTotalDatosAdicionales%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FnuTotalDatosAdicionales',
                   10);

    open cuTotalDatosAdicionales;
    fetch cuTotalDatosAdicionales
      into rfcuTotalDatosAdicionales;
    close cuTotalDatosAdicionales;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FnuTotalDatosAdicionales', 10);

    return(nvl(rfcuTotalDatosAdicionales.Cantidad, 0));

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 0;
    when others then
      return 0;
  END FnuTotalDatosAdicionales;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosAdicionales
  Descripcion    : Obtiene los registros de datos adicionales configurados
                   en el tipo de trabajo de la orden a gestionar

  Autor          : Jorge Valiente
  Fecha          : 12/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  30/05/2018      Jorge Valiente      CASO 200-1932: Cambio de logica de indetificacion
                                                     de clasificador de causal en lugar de
                                                     el tipo de causal.
  ******************************************************************/
  FUNCTION FrfDatosAdicionales(nutask_type_id number, NUCAUSAL_ID number)
    RETURN tyRefCursor IS

    rfQuery tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfDatosAdicionales', 10);

    open rfQuery for
      select a.attribute_set_id attribute_set_id,
             a.attribute_id attribute_id,
             b.name_attribute name_attribute,
             b.display_name display_name,
             b.length length,
             b.precision precision,
             b.scale scale,
             dage_statement.fsbgetstatement(a.statement_id, null) statement_id,
             a.mandatory obligatorio
        from ge_attributes b, ge_attrib_set_attrib a
       where b.attribute_id = a.attribute_id
         and a.attribute_set_id in
             (select ottd.attribute_set_id
                from or_tasktype_add_data ottd
               where ottd.task_type_id = nutask_type_id
                 and ottd.active = 'Y'
                 and (SELECT count(1) cantidad
                        FROM DUAL
                       WHERE dage_causal.fnugetclass_causal_id(NUCAUSAL_ID,
                                                               NULL) IN
                             (select column_value
                                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',
                                                                                                         NULL),
                                                                        ',')))) = 1
                    --/*
                    --CASO 200-1932
                    --and (ottd.use_ = decode(dage_causal.fnugetcausal_type_id(NUCAUSAL_ID,null),
                 and (ottd.use_ = decode(DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(NUCAUSAL_ID,
                                                                           null),
                                         1,
                                         'C',
                                         2,
                                         'I') or ottd.use_ = 'B') --*/
              )
       order by a.attribute_set_id, a.capture_order; --, a.attribute_id;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfDatosAdicionales', 10);

    return(rfQuery);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfDatosAdicionales;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoDatoAdicional
  Descripcion    : Registrar los datos adicioanles de la orden a gestionar

  Autor          : Jorge Valiente
  Fecha          : 13/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoDatoAdicional(v_order_id       number,
                                   v_name_attribute varchar2,
                                   v_value          varchar2,
                                   v_task_type_id   number,
                                   v_causal_id      number) IS

    cursor culdc_otdalegalizar is
      select Count(lodal.name_attribute) cantidad
        from ldc_otdalegalizar lodal
       where lodal.order_id = v_order_id
         and lodal.name_attribute = v_name_attribute
         and lodal.task_type_id = v_task_type_id
         and lodal.causal_id = v_causal_id;

    rfculdc_otdalegalizar culdc_otdalegalizar%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrRegistoDatoAdicional',
                   10);
    ut_trace.trace('Orden [' || v_order_id || '] con datos adicionales',
                   10);

    open culdc_otdalegalizar;
    fetch culdc_otdalegalizar
      into rfculdc_otdalegalizar;
    if nvl(rfculdc_otdalegalizar.cantidad, 0) = 0 then

      ut_trace.trace('Inserto Datos adicionales', 10);

      insert into ldc_otdalegalizar
        (order_id, name_attribute, value, task_type_id, causal_id)
      values
        (v_order_id,
         v_name_attribute,
         v_value,
         v_task_type_id,
         v_causal_id);

    else
      ut_trace.trace('Actualizo Datos Adicionales', 10);

      update ldc_otdalegalizar
         set value = v_value
       where order_id = v_order_id
         and name_attribute = v_name_attribute
         and task_type_id = v_task_type_id
         and causal_id = v_causal_id;

    end if;
    close culdc_otdalegalizar;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrRegistoDatoAdicional', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrRegistoDatoAdicional;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatoAdicional
  Descripcion    : Obtiene los registros de datos adicionales configurados
                   en el tipo de trabajo de la orden a gestionar

  Autor          : Jorge Valiente
  Fecha          : 12/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  30/05/2018      Jorge Valiente      CASO 200-1932: Cambio de logica de indetificacion
                                                     de clasificador de causal en lugar de
                                                     el tipo de causal.
  ******************************************************************/
  FUNCTION FrfDatoAdicional(v_order_id       number,
                            v_name_attribute varchar2,
                            v_task_type_id   number,
                            v_causal_id      number) RETURN tyRefCursor IS

    rfQuery tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfDatoAdicional', 10);

    open rfQuery for
      select a.attribute_set_id attribute_set_id,
             a.attribute_id attribute_id,
             b.name_attribute name_attribute,
             b.display_name display_name,
             b.length length,
             b.precision precision,
             b.scale scale,
             dage_statement.fsbgetstatement(a.statement_id, null) statement_id,
             (select lo.value
                from ldc_otdalegalizar lo
               where lo.order_id = v_order_id
                 and lo.name_attribute =
                     a.attribute_set_id || '_' || b.name_attribute
                 and lo.task_type_id = v_task_type_id
                 and lo.causal_id = v_causal_id) value,
             a.mandatory obligatorio
        from ge_attributes b, ge_attrib_set_attrib a
       where b.attribute_id = a.attribute_id
         and a.attribute_set_id in
             (select ottd.attribute_set_id
                from or_tasktype_add_data ottd
               where ottd.task_type_id = v_task_type_id
                 and ottd.active = 'Y'
                 and (SELECT count(1) cantidad
                        FROM DUAL
                       WHERE dage_causal.fnugetclass_causal_id(v_causal_id,
                                                               NULL) IN
                             (select column_value
                                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',
                                                                                                         NULL),
                                                                        ',')))) = 1
                    --/*
                    --CASO 200-1932
                    --and (ottd.use_ = decode(dage_causal.fnugetcausal_type_id(v_causal_id,null),
                 and (ottd.use_ = decode(DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(v_causal_id,
                                                                           null),
                                         1,
                                         'C',
                                         2,
                                         'I') or ottd.use_ = 'B') --*/
              )
       order by a.attribute_set_id, a.capture_order; --, a.attribute_id;
    /*select lodal.value value
     from ldc_otdalegalizar lodal
    where lodal.order_id = v_order_id
      and lodal.name_attribute = v_name_attribute
      and lodal.task_type_id = v_task_type_id
      and lodal.causal_id = v_causal_id;*/

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfDatoAdicional', 10);

    return(rfQuery);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END FrfDatoAdicional;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrDesgestionarOT
  Descripcion    : Servicio para eliminar OT qeu no este relacionadas a ninguna unidad operativa
                   del funcionario conectado a LEGO

  Autor          : Jorge Valiente
  Fecha          : 14/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrDesgestionarOT IS

    cursor cudesgestionarOT is
      select distinct lol.order_id Orden
        from ldc_otlegalizar lol, or_order_activity ooa
       where lol.legalizado = 'N'
         and lol.order_id = ooa.order_id
         and (select count(lol.order_id)
                from ldc_anexolegaliza la, ldc_usualego lu
               where la.order_id = lol.order_id
                 and la.agente_id = lu.agente_id
                 and lu.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID) > 0
         and lol.order_id not in
             (select lan.order_id
                from ldc_usualego lu, ldc_anexolegaliza lan, or_order oo
               where lu.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID
                 and lu.agente_id = lan.agente_id
                 and lan.order_id = oo.order_id
                 and (select count(1)
                        from or_oper_unit_persons ooup
                       where ooup.operating_unit_id = oo.operating_unit_id
                         and ooup.person_id =
                             OPEN.GE_BOPERSONAL.FNUGETPERSONID) > 0);

    rfcudesgestionarOT cudesgestionarOT%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrDesgestionarOT', 10);

    for rfcudesgestionarOT in cudesgestionarOT loop

      ut_trace.trace('Orden a desgestionar [' || rfcudesgestionarOT.Orden || ']',
                     10);
      dbms_output.put_line('Orden a desgestionar [' ||
                           rfcudesgestionarOT.Orden || ']');

      /*
      delete from ldc_otlegalizar t
       where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otadicional t
       where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otdalegalizar t
       where order_id = rfcudesgestionarOT.Orden;
      delete from LDC_ANEXOLEGALIZA t
       where order_id = rfcudesgestionarOT.Orden;
       */

      delete from ldc_otlegalizar t
       where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otadicional t
       where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otdalegalizar t
       where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otadicionalda t
       where order_id = rfcudesgestionarOT.Orden;
      delete from LDC_ANEXOLEGALIZA t
       where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otitem t where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otdatoactividad t
       where order_id = rfcudesgestionarOT.Orden;
      delete from LDC_DATOACTIVIDADOTADICIONAL t
       where order_id = rfcudesgestionarOT.Orden;

    end loop;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrDesgestionarOT', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrDesgestionarOT;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrEliminarDatosAdicionales
  Descripcion    : Eliminar datos adcionales para registrar nuevos cambios realizados

  Autor          : Jorge Valiente
  Fecha          : 15/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrEliminarDatosAdicionales(v_order_id number) IS

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrEditarOrdenAdicional',
                   10);
    ut_trace.trace('Orden [' || v_order_id ||
                   '] para eliminar datos adicionales',
                   10);

    delete from Ldc_Otdalegalizar t where t.order_id = v_order_id;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrEliminarDatosAdicionales',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrEliminarDatosAdicionales;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoItemOrdenGestion
  Descripcion    : Registrar el o los items relacionados de la orden a gestionar

  Autor          : Jorge Valiente
  Fecha          : 19/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoItemOrdenGestion(v_order_id number,
                                      v_item     number,
                                      v_cantidad number) IS

    cursor culdc_otitem is
      select Count(loi.order_id) cantidad
        from ldc_otitem loi
       where loi.order_id = v_order_id
         and loi.item = v_item;

    rfculdc_otitem culdc_otitem%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrRegistoItemOrdenGestion',
                   10);
    ut_trace.trace('Orden [' || v_order_id || '] con datos adicionales',
                   10);

    open culdc_otitem;
    fetch culdc_otitem
      into rfculdc_otitem;
    if nvl(rfculdc_otitem.cantidad, 0) = 0 then

      ut_trace.trace('Insertar Item', 10);
      insert into ldc_otitem
        (order_id, item, cantidad)
      values
        (v_order_id, v_item, v_cantidad);

    else
      ut_trace.trace('Actualizacion Items', 10);

      update ldc_otitem loi
         set loi.cantidad = v_cantidad
       where loi.order_id = v_order_id
         and loi.item = v_item;

    end if;
    close culdc_otitem;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrRegistoItemOrdenGestion',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrRegistoItemOrdenGestion;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosAdicionales
  Descripcion    : Obtiene los registros del o los items registrados para
                   la orden a gestionar en LEGO

  Autor          : Jorge Valiente
  Fecha          : 19/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfItemOrdenGestion(v_order_id number) RETURN tyRefCursor IS

    rfQuery tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfItemOrdenGestion', 10);

    open rfQuery for
      select loi.item, loi.cantidad
        from ldc_otitem loi
       where loi.order_id = v_order_id;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfItemOrdenGestion', 10);

    return(rfQuery);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfItemOrdenGestion;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrEliminarItemOrdenGestion
  Descripcion    : Eliminar item de la orden a gestionar

  Autor          : Jorge Valiente
  Fecha          : 19/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrEliminarItemOrdenGestion(v_order_id number) IS

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrEliminarItemOrdenGestion',
                   10);
    ut_trace.trace('Orden [' || v_order_id ||
                   '] para eliminar datos adicionales',
                   10);

    delete from ldc_otitem t where t.order_id = v_order_id;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrEliminarItemOrdenGestion',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrEliminarItemOrdenGestion;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoDatoAdicionalOTA
  Descripcion    : Registrar los datos adicioanles de la orden adicional

  Autor          : Jorge Valiente
  Fecha          : 24/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  /*
  PROCEDURE PrRegistoDatoAdicionalOTA(v_order_id       number,
                                      v_name_attribute varchar2,
                                      v_value          varchar2,
                                      v_task_type_id   number,
                                      v_causal_id      number) IS
    */

  PROCEDURE PrRegistoDatoAdicionalOTA(v_order_id       number,
                                      v_name_attribute varchar2,
                                      v_value          varchar2,
                                      v_task_type_id   number,
                                      v_causal_id      number,
                                      v_actividad      number,
                                      v_material       number) IS

    cursor cuLDC_OTADICIONALDA is
      select Count(lodal.name_attribute) cantidad
        from LDC_OTADICIONALDA lodal
       where lodal.order_id = v_order_id
         and lodal.name_attribute = v_name_attribute
         and lodal.task_type_id = v_task_type_id
         and lodal.causal_id = v_causal_id
         and lodal.actividad = v_actividad
         and lodal.material = v_material;

    rfcuLDC_OTADICIONALDA cuLDC_OTADICIONALDA%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrRegistoDatoAdicionalOTA',
                   10);
    ut_trace.trace('Orden [' || v_order_id || '] con datos adicionales',
                   10);

    open cuLDC_OTADICIONALDA;
    fetch cuLDC_OTADICIONALDA
      into rfcuLDC_OTADICIONALDA;
    if nvl(rfcuLDC_OTADICIONALDA.cantidad, 0) = 0 then

      ut_trace.trace('Inserto Datos adicionales', 10);

      insert into LDC_OTADICIONALDA
        (order_id,
         name_attribute,
         value,
         task_type_id,
         causal_id,
         actividad,
         material)
      values
        (v_order_id,
         v_name_attribute,
         v_value,
         v_task_type_id,
         v_causal_id,
         v_actividad,
         v_material);

    else
      ut_trace.trace('Actualizo Datos Adicionales', 10);

      update LDC_OTADICIONALDA
         set value = v_value
       where order_id = v_order_id
         and name_attribute = v_name_attribute
         and task_type_id = v_task_type_id
         and causal_id = v_causal_id
         and actividad = v_actividad
         and material = v_material;

    end if;
    close cuLDC_OTADICIONALDA;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrRegistoDatoAdicionalOTA',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrRegistoDatoAdicionalOTA;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosAdicionalesOTA
  Descripcion    : Obtiene los registros de datos adicionales configurados
                   en el el tipo de trabajo adicional

  Autor          : Jorge Valiente
  Fecha          : 25/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDatosAdicionalesOTA(v_order_id     number,
                                  v_task_type_id number,
                                  v_causal_id    number,
                                  v_actividad    number,
                                  v_material     number) RETURN tyRefCursor IS

    rfQuery tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfDatosAdicionalesOTA',
                   10);

    open rfQuery for
      select loada.order_id,
             loada.task_type_id,
             loada.causal_id,
             loada.name_attribute,
             loada.value
        from ldc_otadicionalda loada
       where loada.order_id = v_order_id
         and loada.task_type_id = v_task_type_id
         and loada.causal_id = v_causal_id
         and loada.actividad = v_actividad
         and loada.material = v_material;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfDatosAdicionalesOTA', 10);

    return(rfQuery);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfDatosAdicionalesOTA;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrEliminarDatosAdicionalesOTA
  Descripcion    : Eliminar datos adcionales del los tipos de trabajo adicional

  Autor          : Jorge Valiente
  Fecha          : 26/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PrEliminarDatosAdicionalesOTA(v_order_id number) IS



  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrEliminarDatosAdicionalesOTA',
                   10);
    ut_trace.trace('Orden [' || v_order_id ||
                   '] para eliminar datos adicionales',
                   10);
    delete from ldc_otadicionalda t where t.order_id = v_order_id;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrEliminarDatosAdicionalesOTA',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrEliminarDatosAdicionalesOTA;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuTipoTrab
  Descripcion    : Obtiene la causal de legalizacion para LEGO

  Autor          : Jorge Valiente
  Fecha          : 26/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuTipoTrab(InuTIPOTRABLEGO_ID     NUMBER,
                       InuTIPOTRABADICLEGO_ID NUMBER) RETURN NUMBER IS

    cursor cuLDC_TIPOTRABLEGO is
      select lttl.causallego_id causal
        from LDC_TIPOTRABLEGO lttl
       where lttl.tipotrablego_id = InuTIPOTRABLEGO_ID;

    rfcuLDC_TIPOTRABLEGO cuLDC_TIPOTRABLEGO%rowtype;

    cursor cuLDC_TIPOTRABADICLEGO is
      select lttal.causaladiclego_id causal
        from LDC_TIPOTRABADICLEGO lttal
       where lttal.tipotrablego_id = InuTIPOTRABLEGO_ID
         and lttal.tipotrabadiclego_id = InuTIPOTRABADICLEGO_ID;

    rfcuLDC_TIPOTRABADICLEGO cuLDC_TIPOTRABADICLEGO%rowtype;

    nuCausal number;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FnuTipoTrab', 10);

    if nvl(InuTIPOTRABADICLEGO_ID, 0) = 0 then
      OPEN cuLDC_TIPOTRABLEGO;
      FETCH cuLDC_TIPOTRABLEGO
        INTO RFcuLDC_TIPOTRABLEGO;
      CLOSE cuLDC_TIPOTRABLEGO;
      nuCausal := NVL(RFcuLDC_TIPOTRABLEGO.Causal, 0);
    ELSE
      OPEN cuLDC_TIPOTRABADICLEGO;
      FETCH cuLDC_TIPOTRABADICLEGO
        INTO RFcuLDC_TIPOTRABADICLEGO;
      CLOSE cuLDC_TIPOTRABADICLEGO;
      nuCausal := NVL(RFcuLDC_TIPOTRABADICLEGO.Causal, 0);
    end if;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FnuTipoTrab', 10);

    return(nuCausal);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FnuTipoTrab;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuDatoInicialListaValores
  Descripcion    : Obtiene la causal de legalizacion para LEGO

  Autor          : Jorge Valiente
  Fecha          : 26/09/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuDatoInicialListaValores(IsbLista VARCHAR2,
                                      InuDato1 number,
                                      InuDato2 number) RETURN NUMBER IS

    cursor cuAtividadNoOfertado is
      SELECT nvl(CODIGO_ACTIVIDAD, 0)
        FROM LDC_OR_TASK_TYPES_ITEMS
       WHERE TIPO_TRABAJO = InuDato1
         and rownum = 1
       ORDER BY CODIGO_ACTIVIDAD ASC;

    rfcuAtividadNoOfertado cuAtividadNoOfertado%rowtype;

    cursor cuAtividadOfertado is
      SELECT nvl(CODIGO_ACTIVIDAD, 0)
        FROM LDC_OR_TASK_TYPES_ITEMS
       WHERE TIPO_TRABAJO = InuDato1
         AND CODIGO_ACTIVIDAD in
             (select LIUOL.ACTIVIDAD
                from LDC_ITEM_UO_LR LIUOL
               where LIUOL.UNIDAD_OPERATIVA = InuDato2)
         and rownum = 1
       ORDER BY CODIGO_ACTIVIDAD ASC;

    rfcuAtividadOfertado cuAtividadOfertado%rowtype;

    returnervalorlista number := 0;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FnuDatoInicialListaValores',
                   10);

    if (IsbLista = 'ActividadNoOfertado') then
      open cuAtividadNoOfertado;
      fetch cuAtividadNoOfertado
        into returnervalorlista;
      close cuAtividadNoOfertado;
    else
      if (IsbLista = 'ActividadOfertado') then
        open cuAtividadOfertado;
        fetch cuAtividadOfertado
          into returnervalorlista;
        close cuAtividadOfertado;
      end if;

    end if;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FnuDatoInicialListaValores',
                   10);

    return(returnervalorlista);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FnuDatoInicialListaValores;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosActividad
  Descripcion    : Obtiene Datos configurados en la actividad de la orden gestionada

  Autor          : Jorge Valiente
  Fecha          : 03/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDatosActividad(InuActividad number) RETURN tyRefCursor IS
    rfQuery tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfDatosActividad', 10);
    ut_trace.trace('Actividad a consulta [' || InuActividad || ']', 10);

    open rfQuery for
      select 1                       Ubicacion,
             a.attribute_1_id        CODIGO_ATRIBUTO,
             a.init_expression_1_id  REGLA_INICIALIZACION,
             a.valid_expression_1_id REGLA_VALIDACION,
             a.statement_1_id        SENTENCIA,
             a.component_1_id        COMPONENTE,
             a.required1             REQUERIDO,
             b.name_attribute        NOMBRE,
             b.length                LONGITUD,
             b.precision             PRESICION,
             b.scale                 ESCALA,
             b.display_name          NOMBRE_DESPLIEGUE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_1_id is not null
         and a.attribute_1_id = b.attribute_id
      union all
      select 2                       Ubicacion,
             a.attribute_2_id        CODIGO_ATRIBUTO,
             a.init_expression_2_id  REGLA_INICIALIZACION,
             a.valid_expression_2_id REGLA_VALIDACION,
             a.statement_2_id        SENTENCIA,
             a.component_2_id        COMPONENTE,
             a.required2             REQUERIDO,
             b.name_attribute        NOMBRE,
             b.length                LONGITUD,
             b.precision             PRESICION,
             b.scale                 ESCALA,
             b.display_name          NOMBRE_DESPLIEGUE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_2_id is not null
         and a.attribute_2_id = b.attribute_id
      union all
      select 3                       Ubicacion,
             a.attribute_3_id        CODIGO_ATRIBUTO,
             a.init_expression_3_id  REGLA_INICIALIZACION,
             a.valid_expression_3_id REGLA_VALIDACION,
             a.statement_3_id        SENTENCIA,
             a.component_3_id        COMPONENTE,
             a.required3             REQUERIDO,
             b.name_attribute        NOMBRE,
             b.length                LONGITUD,
             b.precision             PRESICION,
             b.scale                 ESCALA,
             b.display_name          NOMBRE_DESPLIEGUE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_3_id is not null
         and a.attribute_3_id = b.attribute_id
      union all
      select 4                       Ubicacion,
             a.attribute_4_id        CODIGO_ATRIBUTO,
             a.init_expression_4_id  REGLA_INICIALIZACION,
             a.valid_expression_4_id REGLA_VALIDACION,
             a.statement_4_id        SENTENCIA,
             a.component_4_id        COMPONENTE,
             a.required4             REQUERIDO,
             b.name_attribute        NOMBRE,
             b.length                LONGITUD,
             b.precision             PRESICION,
             b.scale                 ESCALA,
             b.display_name          NOMBRE_DESPLIEGUE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_4_id is not null
         and a.attribute_4_id = b.attribute_id
       order by Ubicacion asc;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfDatosActividad', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfDatosActividad;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoDatoActividad
  Descripcion    : Registrar los datos de la actividad principal de la
                   orden gestionada

  Autor          : Jorge Valiente
  Fecha          : 03/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoDatoActividad(v_order_id             number,
                                   v_name_attribute       varchar2,
                                   v_name_attribute_value varchar2,
                                   v_component_id         varchar2,
                                   v_component_id_value   varchar2) IS
    --,
    --v_valormaterial number) IS

    cursor culdc_otadicional is
      select Count(loda.order_id) cantidad
        from ldc_otdatoactividad loda
       where loda.order_id = v_order_id
         and loda.name_attribute = v_name_attribute;

    rfculdc_otadicional culdc_otadicional%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrRegistoDatoActividad',
                   10);
    ut_trace.trace('Orden a relacionar [' || v_order_id || ']', 10);
    ut_trace.trace('Atributo de la orden  [' || v_name_attribute || ']',
                   10);

    open culdc_otadicional;
    fetch culdc_otadicional
      into rfculdc_otadicional;
    if nvl(rfculdc_otadicional.cantidad, 0) = 0 then

      ut_trace.trace('Inserto OT Adicional', 10);

      insert into ldc_otdatoactividad
        (order_id,
         name_attribute,
         name_attribute_value,
         component_id,
         component_id_value)
      values
        (v_order_id,
         v_name_attribute,
         v_name_attribute_value,
         v_component_id,
         v_component_id_value);

    else
      ut_trace.trace('Actualizo OT Adicional', 10);

      update ldc_otdatoactividad
         set name_attribute_value = v_name_attribute_value,
             component_id         = v_component_id,
             component_id_value   = v_component_id_value
       where order_id = v_order_id
         and name_attribute = v_name_attribute;
    end if;
    close culdc_otadicional;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrRegistoDatoActividad', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrRegistoDatoActividad;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosActividad
  Descripcion    : Obtiene Datos configurados en la actividad de la orden gestionada

  Autor          : Jorge Valiente
  Fecha          : 03/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDatosActividadGestionado(InuActividad number,
                                       InuOrden     number)
    RETURN tyRefCursor IS
    rfQuery tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfDatosActividadGestionado',
                   10);
    ut_trace.trace('Orden a consulta [' || InuOrden || ']', 10);
    ut_trace.trace('Actividad a consulta [' || InuActividad || ']', 10);

    open rfQuery for
      select 1 Ubicacion,
             a.attribute_1_id CODIGO_ATRIBUTO,
             a.init_expression_1_id REGLA_INICIALIZACION,
             a.valid_expression_1_id REGLA_VALIDACION,
             a.statement_1_id SENTENCIA,
             a.component_1_id COMPONENTE,
             a.required1 REQUERIDO,
             b.name_attribute NOMBRE,
             b.length LONGITUD,
             b.precision PRESICION,
             b.scale ESCALA,
             b.display_name NOMBRE_DESPLIEGUE,
             (select loda.name_attribute_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 1
                 and loda.order_id = InuOrden) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 1
                 and loda.order_id = InuOrden) VALOR_COMPONENTE

        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_1_id is not null
         and a.attribute_1_id = b.attribute_id
      union all
      select 2 Ubicacion,
             a.attribute_2_id CODIGO_ATRIBUTO,
             a.init_expression_2_id REGLA_INICIALIZACION,
             a.valid_expression_2_id REGLA_VALIDACION,
             a.statement_2_id SENTENCIA,
             a.component_2_id COMPONENTE,
             a.required2 REQUERIDO,
             b.name_attribute NOMBRE,
             b.length LONGITUD,
             b.precision PRESICION,
             b.scale ESCALA,
             b.display_name NOMBRE_DESPLIEGUE,
             (select loda.name_attribute_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 2
                 and loda.order_id = InuOrden) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 2
                 and loda.order_id = InuOrden) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_2_id is not null
         and a.attribute_2_id = b.attribute_id
      union all
      select 3 Ubicacion,
             a.attribute_3_id CODIGO_ATRIBUTO,
             a.init_expression_3_id REGLA_INICIALIZACION,
             a.valid_expression_3_id REGLA_VALIDACION,
             a.statement_3_id SENTENCIA,
             a.component_3_id COMPONENTE,
             a.required3 REQUERIDO,
             b.name_attribute NOMBRE,
             b.length LONGITUD,
             b.precision PRESICION,
             b.scale ESCALA,
             b.display_name NOMBRE_DESPLIEGUE,
             (select loda.name_attribute_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 3
                 and loda.order_id = InuOrden) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 3
                 and loda.order_id = InuOrden) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_3_id is not null
         and a.attribute_3_id = b.attribute_id
      union all
      select 4 Ubicacion,
             a.attribute_4_id CODIGO_ATRIBUTO,
             a.init_expression_4_id REGLA_INICIALIZACION,
             a.valid_expression_4_id REGLA_VALIDACION,
             a.statement_4_id SENTENCIA,
             a.component_4_id COMPONENTE,
             a.required4 REQUERIDO,
             b.name_attribute NOMBRE,
             b.length LONGITUD,
             b.precision PRESICION,
             b.scale ESCALA,
             b.display_name NOMBRE_DESPLIEGUE,
             (select loda.name_attribute_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 4
                 and loda.order_id = InuOrden) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from ldc_otdatoactividad loda
               where loda.name_attribute = b.name_attribute || '_' || 4
                 and loda.order_id = InuOrden) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_4_id is not null
         and a.attribute_4_id = b.attribute_id
       order by Ubicacion asc;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfDatosActividadGestionado',
                   10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfDatosActividadGestionado;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrEliminarDatosActividad
  Descripcion    : Eliminar datos adcionales del los tipos de trabajo adicional

  Autor          : Jorge Valiente
  Fecha          : 03/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PrEliminarDatosActividad(v_order_id number) IS


  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrEliminarDatosActividad',
                   10);
    ut_trace.trace('Orden [' || v_order_id ||
                   '] para eliminar datos actividad',
                   10);
    delete from ldc_otdatoactividad t where t.order_id = v_order_id;

    commit;


    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrEliminarDatosActividad', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrEliminarDatosActividad;

  --Inicio 200-1258
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrRegistoActividadAdicional
  Descripcion    : Registrar los datos Actividad para la orden de trabajo adicional

  Autor          : Jorge Valiente
  Fecha          : 19/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrRegistoActividadAdicional(v_order_id             NUMBER,
                                        v_ACTIVIDAD            NUMBER,
                                        v_MATERIAL             NUMBER,
                                        v_name_attribute       varchar2,
                                        v_name_attribute_value varchar2,
                                        v_component_id         varchar2,
                                        v_component_id_value   varchar2) IS
    --,
    --v_valormaterial number) IS

    cursor cuLDC_DATOACTIVIDADOTADICIONAL is
      select Count(ldaota.order_id) cantidad
        from LDC_DATOACTIVIDADOTADICIONAL ldaota
       where ldaota.order_id = v_order_id
         and ldaota.actividad = v_ACTIVIDAD
         and ldaota.material = v_MATERIAL
         and ldaota.name_attribute = v_name_attribute;

    rfLDC_DATOACTIVIDADOTADICIONAL cuLDC_DATOACTIVIDADOTADICIONAL%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrRegistoActividadAdicional',
                   10);
    ut_trace.trace('Orden a relacionar [' || v_order_id || ']', 10);
    ut_trace.trace('ACTIVIDAD [' || v_ACTIVIDAD || ']', 10);
    ut_trace.trace('MATERIAL [' || v_MATERIAL || ']', 10);
    ut_trace.trace('Atributo de la ACTIVIDAD [' || v_name_attribute || ']',
                   10);

    open cuLDC_DATOACTIVIDADOTADICIONAL;
    fetch cuLDC_DATOACTIVIDADOTADICIONAL
      into rfLDC_DATOACTIVIDADOTADICIONAL;
    if nvl(rfLDC_DATOACTIVIDADOTADICIONAL.cantidad, 0) = 0 then

      ut_trace.trace('Inserto Dato Actividad OT Adicional', 10);

      insert into LDC_DATOACTIVIDADOTADICIONAL
        (order_id,
         actividad,
         material,
         name_attribute,
         name_attribute_value,
         component_id,
         component_id_value)
      values
        (v_order_id,
         v_actividad,
         v_material,
         v_name_attribute,
         v_name_attribute_value,
         v_component_id,
         v_component_id_value);

    else
      ut_trace.trace('Actualizo Dato Actividad OT Adicional', 10);

      update LDC_DATOACTIVIDADOTADICIONAL ldaota
         set ldaota.NAME_ATTRIBUTE_VALUE = v_name_attribute_value,
             ldaota.component_id         = v_component_id,
             ldaota.component_id_value   = v_component_id_value
       where ldaota.order_id = v_order_id
         and ldaota.actividad = v_ACTIVIDAD
         and ldaota.material = v_MATERIAL
         and ldaota.name_attribute = v_name_attribute;

    end if;
    close cuLDC_DATOACTIVIDADOTADICIONAL;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrRegistoActividadAdicional',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrRegistoActividadAdicional;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDatosActividadAdicional
  Descripcion    : Obtiene los registros de datos actividad configurados
                   en el el tipo de trabajo adicional

  Autor          : Jorge Valiente
  Fecha          : 19/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDatosActividadAdicional(v_order_id  NUMBER,
                                      v_ACTIVIDAD NUMBER,
                                      v_MATERIAL  NUMBER) RETURN tyRefCursor IS

    rfQuery tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfDatosActividadAdicional',
                   10);

    open rfQuery for
      select ldaota.order_id             order_id,
             ldaota.actividad            actividad,
             ldaota.material             material,
             ldaota.name_attribute       name_attribute,
             ldaota.name_attribute_value name_attribute_value,
             ldaota.component_id         component_id,
             ldaota.component_id_value   component_id_value
        from LDC_DATOACTIVIDADOTADICIONAL ldaota
       where ldaota.order_id = v_order_id
         and ldaota.actividad = v_ACTIVIDAD
         and ldaota.material = v_MATERIAL;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfDatosActividadAdicional',
                   10);

    return(rfQuery);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfDatosActividadAdicional;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PrEliminarActividadAdicional
  Descripcion    : Eliminar datos Actividad del los tipos de trabajo adicional

  Autor          : Jorge Valiente
  Fecha          : 03/10/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PrEliminarActividadAdicional(v_order_id number) IS


  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrEliminarActividadAdicional',
                   10);
    ut_trace.trace('Orden [' || v_order_id ||
                   '] para eliminar datos actividad',
                   10);


    delete from LDC_DATOACTIVIDADOTADICIONAL t
    where t.order_id = v_order_id;

    commit;
    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrEliminarActividadAdicional',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrEliminarActividadAdicional;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuClasificadorCausal
  Descripcion    : Valida si el clasificador de la causal es de EXITO en LEGO

  Autor          : Jorge Valiente
  Fecha          : 30/11/2017

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuClasificadorCausal(InuCausal number) RETURN number IS

    cursor cuClasificadorCausal is
      SELECT count(1) cantidad
        FROM DUAL
       WHERE dage_causal.fnugetclass_causal_id(InuCausal, NULL) IN
             (select column_value
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',
                                                                                         NULL),
                                                        ',')));
    rfcuClasificadorCausal cuClasificadorCausal%rowtype;

    nuRetornaValor number;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FnuClasificadorCausal', 10);

    open cuClasificadorCausal;
    fetch cuClasificadorCausal
      into rfcuClasificadorCausal;
    close cuClasificadorCausal;

    nuRetornaValor := nvl(rfcuClasificadorCausal.Cantidad, 0);

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FnuClasificadorCausal', 10);

    return(nuRetornaValor);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FnuClasificadorCausal;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfOrdenLEGO
  Descripcion    : Obtiene datos de la orden en gestion para ser plasmados en un archivo excel

  Autor          : Jorge Valiente
  Fecha          : 12/12/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  17/10/2018      Eduardo Cer?n       CASO 200-2218: Se modifica el cursor rfQuery para que tenga en
                                                     cuenta ?nicamente las ?rdenes abiertas y que no
                                                     sean novedad
  07/09/2018      JOSH BRITO          CASO 200-2089: condicion para las ordenes gestionadas para legalizar solo se
                                                     muestren las ordenes del mismo agente siempre y cuando la orden
                                                     gestionada pertenezca a la misma UT que la Persona
  ******************************************************************/
  FUNCTION FrfOrdenLEGO(inuTipoTrab number, idtDesde date, idtHasta date)
    RETURN tyRefCursor IS
    rfQuery tyRefCursor;

    nuPersonID ge_person.person_id%type;

  BEGIN

    nuPersonID := OPEN.GE_BOPERSONAL.FNUGETPERSONID;

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfOrdenLEGO', 10);
    ut_trace.trace('Desde [' || idtDesde || ']', 10);
    ut_trace.trace('Hasta [' || idtHasta || ']', 10);

    open rfQuery for
      select lol.order_id ORDEN,
             lol.causal_id || ' - ' ||
             dage_causal.fsbgetdescription(lol.causal_id, null) CAUSAL,
             la.tecnico_unidad TECNICO,
             dage_person.fsbgetname_(la.tecnico_unidad, null) NOMBRE_TECNICO,
             lol.order_comment OBSERVACION,
             ooa.product_id PRODUCTO,
             ooa.package_id SOLICITUD,
             ooa.operating_unit_id UNIDAD_TRABAJO,
             daor_operating_unit.fsbgetname(ooa.operating_unit_id, null) UNIDAD_TRABAJO_DESCRIPCION,
             (select s.susccicl
                from suscripc s
               where s.susccodi = ooa.subscription_id
                 and rownum = 1) CICLO,
             lol.mensaje_legalizado ERROR,
             lol.causal_id CODIGO_CAUSAL,
             lol.task_type_id TIPO_TRABAJO,
             daor_task_type.fsbgetdescription(lol.task_type_id, null) DESCRIPCION_TIPO_TRABAJO
        from open.ldc_otlegalizar   lol,
             open.ldc_anexolegaliza la,
             open.ldc_usualego      lu,
             open.Or_Order_Activity ooa
       where lol.legalizado = 'N'
         and lol.task_type_id =
             decode(inuTipoTrab, -1, lol.task_type_id, inuTipoTrab)
         and trunc(lol.fecha_registro) >= trunc(idtDesde)
         and trunc(lol.fecha_registro) <= trunc(idtHasta)
         and lol.order_id = la.order_id
         and la.agente_id = lu.agente_id
         and ooa.status = 'R'
         and not exists(select 1 from open.ct_item_novelty n where n.items_id=ooa.activity_id)
         and lu.person_id = nuPersonID
         and ooa.order_id = lol.order_id
         and (select count(1)
              from OR_OPER_UNIT_PERSONS ooup, OR_ORDER oo
              where ooup.operating_unit_id = OO.operating_unit_id
              and oo.order_id = lol.order_id
              and ooup.person_id = nuPersonID)  > 0
       order by lol.order_id;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfOrdenLEGO', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfOrdenLEGO;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfItemOrdenLEGO
  Descripcion    : Obtiene los items de la orden principal en un archivo excel

  Autor          : Jorge Valiente
  Fecha          : 12/12/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfItemOrdenLEGO(InuOrden number) RETURN tyRefCursor IS
    rfQuery tyRefCursor;

    --nuPersonID ge_person.person_id%type;

  BEGIN

    --nuPersonID := OPEN.GE_BOPERSONAL.FNUGETPERSONID;

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfItemOrdenLEGO', 10);
    ut_trace.trace('Orden [' || InuOrden || ']', 10);

    open rfQuery for
      select loi.item || ' - ' ||
             dage_items.fsbgetdescription(loi.item, null) ITEM,
             loi.cantidad ITEM_CANTIDAD
        from open.ldc_otitem loi
       where loi.order_id = InuOrden;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfItemOrdenLEGO', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfItemOrdenLEGO;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfTAOrdenLEGO
  Descripcion    : Obtiene los trabajos adicionales de la orden en gestion para ser plasmados en un archivo excel

  Autor          : Jorge Valiente
  Fecha          : 09/08/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfTAOrdenLEGO(InuOrden number) RETURN tyRefCursor IS
    rfQuery tyRefCursor;

    --nuPersonID ge_person.person_id%type;

  BEGIN

    --nuPersonID := OPEN.GE_BOPERSONAL.FNUGETPERSONID;

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfTAOrdenLEGO', 10);
    ut_trace.trace('Orden [' || InuOrden || ']', 10);

    open rfQuery for
      select lo.task_type_id || ' - ' ||
             daor_task_type.fsbgetdescription(lo.task_type_id, null) TIPO_TRABAJO,
             lo.actividad || ' - ' ||
             dage_items.fsbgetdescription(lo.actividad, null) ACTIVIDAD,
             lo.material MATERIAL,
             dage_items.fsbgetdescription(lo.material, null) DESCRIPCION_MATERIAL,
             lo.cantidad CANTIDAD,
             lo.causal_id CAUSAL,
             lo.task_type_id CODIGO_TIPO_TRABAJO,
             lo.actividad CODIGO_ACTIVIDAD,
             dage_causal.fsbgetdescription(lo.causal_id, null) DESCRIPCION_CAUSAL
        from open.ldc_otadicional lo
       where lo.order_id = InuOrden;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfTAOrdenLEGO', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfTAOrdenLEGO;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfDAOrdenLEGO
  Descripcion    : Obtiene datos adicionales de la orden en gestion para ser plasmados en un archivo excel

  Autor          : Jorge Valiente
  Fecha          : 12/12/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDAOrdenLEGO(InuOrden number) RETURN tyRefCursor IS
    rfQuery tyRefCursor;

    --nuPersonID ge_person.person_id%type;

  BEGIN

    --nuPersonID := OPEN.GE_BOPERSONAL.FNUGETPERSONID;

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfDAOrdenLEGO', 10);
    ut_trace.trace('Orden [' || InuOrden || ']', 10);

    open rfQuery for
      select (select b.display_name
                from ge_attributes b, ge_attrib_set_attrib a
               where b.attribute_id = a.attribute_id
                 and a.attribute_set_id || '_' || b.name_attribute =
                     lda.name_attribute) DATO_ADICIONAL_GESTION,
             lda.value VALOR_DATO_ADICIONAL_GESTION
        from open.ldc_otdalegalizar lda
       where lda.order_id = InuOrden;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfDAOrdenLEGO', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfDAOrdenLEGO;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfOrdenGestionExcel
  Descripcion    : Obtiene datos adicionles del trabajo adicional de la orden en gestion para ser plasmados en un archivo excel

  Autor          : Jorge Valiente
  Fecha          : 12/12/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfDATAOrdenLEGO(InuOrden        number,
                            Inutask_type_id number,
                            Inuactividad    number,
                            Inumaterial     number) RETURN tyRefCursor IS
    rfQuery tyRefCursor;

    --nuPersonID ge_person.person_id%type;

  BEGIN

    --nuPersonID := OPEN.GE_BOPERSONAL.FNUGETPERSONID;

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfDATAOrdenLEGO', 10);

    open rfQuery for
      select (select b.display_name
                from ge_attributes b, ge_attrib_set_attrib a
               where b.attribute_id = a.attribute_id
                 and a.attribute_set_id || '_' || b.name_attribute =
                     loda.name_attribute) DATO_ADICIONAL,
             loda.value VALOR_DATO_ADICIONAL
        from open.ldc_otadicionalda loda
       where loda.order_id = InuOrden
         and loda.task_type_id = Inutask_type_id
         and loda.actividad = Inuactividad
         and loda.material = Inumaterial;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfDATAOrdenLEGO', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfDATAOrdenLEGO;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FrfCAOTAicionalLEGO
  Descripcion    : Obtiene componentes de la actividades de los datos adicionales

  Autor          : Jorge Valiente
  Fecha          : 14/12/2017

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FrfCAOTAdicionalLEGO(InuOrden number, Inuactividad number)
    RETURN tyRefCursor IS
    rfQuery tyRefCursor;

    --nuPersonID ge_person.person_id%type;

  BEGIN

    --nuPersonID := OPEN.GE_BOPERSONAL.FNUGETPERSONID;

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfCAOTAdicionalLEGO', 10);

    open rfQuery for
      select 1 Ubicacion,
             a.component_1_id COMPONENTE,
             b.name_attribute NOMBRE,
             (select loda.name_attribute_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 1
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 1
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_1_id is not null
         and a.attribute_1_id = b.attribute_id
      union all
      select 2 Ubicacion,
             a.component_2_id COMPONENTE,
             b.name_attribute NOMBRE,
             (select loda.name_attribute_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 2
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 2
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_2_id is not null
         and a.attribute_2_id = b.attribute_id
      union all
      select 3 Ubicacion,
             a.component_3_id COMPONENTE,
             b.name_attribute NOMBRE,
             (select loda.name_attribute_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 3
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 3
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_3_id is not null
         and a.attribute_3_id = b.attribute_id
      union all
      select 4 Ubicacion,
             a.component_4_id COMPONENTE,
             b.name_attribute NOMBRE,
             (select loda.name_attribute_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 4
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_ATRIBUTO,
             (select loda.component_id_value
                from LDC_DATOACTIVIDADOTADICIONAL loda
               where loda.name_attribute = b.name_attribute || '_' || 4
                 and loda.order_id = InuOrden
                 and loda.actividad = InuActividad
              --and loda.material = InuMaterial
              ) VALOR_COMPONENTE
        from ge_items_attributes a, ge_attributes b
       where a.items_id = InuActividad
         and a.attribute_4_id is not null
         and a.attribute_4_id = b.attribute_id
       order by Ubicacion asc;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfCAOTAdicionalLEGO', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FrfCAOTAdicionalLEGO;

  --Fin 200-1258

  -- INICIO CASO 200-1580
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuExistenciaGarantia
  Descripcion    : Establece si existe configuraci?n de garant?a para el tipo de trabajo y causal establecido en la orden adicional definida en LEGO

  Autor          : Daniel Valiente
  Fecha          : 23/04/2018

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuExistenciaGarantia(InuTipoTrabajo number, InuCausal number)
    RETURN number IS

    cursor cuExistenciaGarantia is
      SELECT count(1) cantidad
        FROM LDC_GRUPTITRGARA A
       WHERE A.TASK_TYPE_ID = InuTipoTrabajo;
    --AND A.CAUSAL_ID = InuCausal;

    rfcuExistenciaGarantia cuExistenciaGarantia%rowtype;

    nuRetornaValor number;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FnuExistenciaGarantia', 10);

    open cuExistenciaGarantia;
    fetch cuExistenciaGarantia
      into rfcuExistenciaGarantia;
    close cuExistenciaGarantia;

    if nvl(rfcuExistenciaGarantia.Cantidad, 0) > 0 then
      nuRetornaValor := 1;
    else
      nuRetornaValor := 0;
    end if;
    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FnuExistenciaGarantia', 10);

    return(nuRetornaValor);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FnuExistenciaGarantia;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : rFrfOrdenesGarantia
  Descripcion    : Retorna las ordenes de garant?a relacionadas con el producto de la orden gestionada en LEGO

  Autor          : Daniel Valiente
  Fecha          : 23/04/2018

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  07/06/2019	  dsaltarin			  200-2688. Se modifica para mostrar el comentario de legalizaci?n.
  07/06/2019	  HORBATH			  146. Se agrega el parametro IdtExcutdate que almacenara la fecha de ejecucion
										   y la validacion de la vigencia de la garantia se realizara con esta fecha.
  21/04/2022   dsaltarin       OSF-259 Se agrega solicitud en el cursor
  ******************************************************************/
  PROCEDURE rFrfOrdenesGarantia(InuOrden    number,
                                InuTaskType number,
								IdtExcutdate date,--caso:146
                                rfQuery     OUT constants.tyrefcursor) as
	csbEnt2002688 open.ldc_versionentrega.nombre_entrega%type:='OSS_SAC_DSS_2002688_3';

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.rFrfOrdenesGarantia', 10);
	if sbAplicaEnt2002688 is null then
		if fblaplicaentrega(csbEnt2002688) then
			sbAplicaEnt2002688:='S';
		else
			sbAplicaEnt2002688:='N';
		end if;
	end if;

	if sbAplicaEnt2002688 = 'N' then

		open rfQuery for
		  select a.*,
				 (select gi.Description
					from open.ge_items gi
				   where gi.items_id = A.ITEM_ID
					 AND ROWNUM = 1) ITEM,
				 (select oo.LEGALIZATION_DATE
					from open.or_order oo
				   where oo.order_id = A.ORDER_ID
					 AND ROWNUM = 1) FLEGALIZACION,
				 (select ooa.COMMENT_
					from open.Or_Order_Activity ooa
				   where ooa.order_id = A.ORDER_ID
					 AND ROWNUM = 1) OBSERVACION,
				 (SELECT OOU.NAME
					FROM OPEN.OR_OPERATING_UNIT OOU
				   WHERE OOU.OPERATING_UNIT_ID =
						 (select oo.Operating_Unit_Id
							from open.or_order oo
						   where oo.order_id = A.ORDER_ID
							 AND ROWNUM = 1)) UNIDADOPERATIVA,
               ooa.package_id
			from GE_ITEM_WARRANTY A, or_order_activity ooa
		   where ooa.order_id = a.order_id
			 and a.final_warranty_date >= IdtExcutdate --caso:146
			 and a.product_id in
				 (select ooa.product_id
					from open.Or_Order_Activity ooa
				   where ooa.order_id = InuOrden)
			 and ooa.task_type_id in
				 (select b.task_type_id
					from open.LDC_GRUPTITRGARA B
				   where b.cod_group_warranty_id in
						 (select b.cod_group_warranty_id
							from open.LDC_GRUPTITRGARA B
						   where B.TASK_TYPE_ID = InuTaskType
							 and rownum = 1));
	else
		open rfQuery for
		  select a.*,
				 (select gi.description from open.ge_items gi where gi.items_id = A.ITEM_ID and rownum = 1) ITEM,
				 ot.legalization_date FLEGALIZACION,
				 (select c.order_comment from open.or_order_comment c where c.order_id=ot.order_id and c.legalize_comment='Y' and rownum=1) OBSERVACION,
				 (SELECT open.daor_operating_unit.fsbgetname(ot.operating_unit_id,null) from dual ) UNIDADOPERATIVA,
         ooa.package_id
			from open.ge_item_warranty A, open.or_order_activity ooa, open.or_order ot
		   where ooa.order_id = a.order_id
		     and ot.order_id=a.order_id
			 and a.final_warranty_date >= IdtExcutdate--caso:146
			 and a.product_id in
				 (select ooa1.product_id
					from open.Or_Order_Activity ooa1
				   where ooa1.order_id = InuOrden)
			 and ot.task_type_id in
				 (select b.task_type_id
					from open.LDC_GRUPTITRGARA B
				   where b.cod_group_warranty_id in
						 (select b.cod_group_warranty_id
							from open.LDC_GRUPTITRGARA B
						   where B.TASK_TYPE_ID = InuTaskType
							 and rownum = 1));

	end if;
    /*SELECT A.*,
          (select gi.Description
             from open.ge_items gi
            where gi.items_id = A.ITEM_ID
              AND ROWNUM = 1) ITEM,
          (select oo.LEGALIZATION_DATE
             from open.or_order oo
            where oo.order_id = A.ORDER_ID
              AND ROWNUM = 1) FLEGALIZACION,
          (select ooa.COMMENT_
             from open.Or_Order_Activity ooa
            where ooa.order_id = A.ORDER_ID
              AND ROWNUM = 1) OBSERVACION,
          (SELECT OOU.NAME
             FROM OPEN.OR_OPERATING_UNIT OOU
            WHERE OOU.OPERATING_UNIT_ID =
                  (select oo.Operating_Unit_Id
                     from open.or_order oo
                    where oo.order_id = A.ORDER_ID
                      AND ROWNUM = 1)) UNIDADOPERATIVA
     FROM GE_ITEM_WARRANTY A
    WHERE A.FINAL_WARRANTY_DATE > sysdate
      AND A.IS_ACTIVE = 'Y'
      AND A.Product_Id = (select ooa.product_id
                            from open.Or_Order_Activity ooa
                           where ooa.order_id = InuOrden
                             and rownum = 1);*/
    /*SELECT A.*,
          G.DESCRIPTION       ITEM,
          O.LEGALIZATION_DATE FLEGALIZACION,
          R.COMMENT_          OBSERVACION,
          U.NAME              UNIDADOPERATIVA
     FROM GE_ITEM_WARRANTY  A,
          OR_ORDER          O,
          OR_OPERATING_UNIT U,
          OR_ORDER_ACTIVITY R,
          OR_ORDER_ITEMS    I,
          GE_ITEMS          G
    WHERE A.FINAL_WARRANTY_DATE > sysdate
      AND A.IS_ACTIVE = 'Y'
      AND A.ORDER_ID = InuOrden
      AND O.order_id = A.ORDER_ID
      AND O.OPERATING_UNIT_ID = U.OPERATING_UNIT_ID
      AND R.ORDER_ID = A.ORDER_ID
      AND R.ORDER_ID = I.ORDER_ID
      AND G.ITEMS_ID = I.ITEMS_ID;*/

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.rFrfOrdenesGarantia', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END rFrfOrdenesGarantia;

--FIN CASO 200-1580

  /*****************************************************************
  Propiedad intelectual de Horbath

  Unidad         : FnClasificadorCausalActivitdad
  Descripcion    : valida la clasificacion de la causal de legalizacion para legalizar actividades

  Autor          : Josh Brito
  Fecha          : 07/09/2018

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnClasificadorCausalActivitdad(nuCausalID GE_CAUSAL.CAUSAL_ID%TYPE) RETURN number IS

    nuRetornaExiFal NUMBER := 0;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FnClasificadorCausalActivitdad', 10);
    SELECT COUNT(1) INTO nuRetornaExiFal
    FROM GE_CAUSAL
    WHERE CAUSAL_ID = nuCausalID
    AND CLASS_CAUSAL_ID IN (SELECT TO_NUMBER(COLUMN_VALUE)
                                FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS(OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN('CLASSCAUSALAVTIVITI_LEGO'), ','))
                                WHERE COLUMN_VALUE IS NOT NULL);
    ut_trace.trace('Fin LDC_PKGESTIONORDENES.FnClasificadorCausalActivitdad', 10);

    IF nuRetornaExiFal > 0 THEN
      nuRetornaExiFal := 1;
    END IF;

    return(nuRetornaExiFal);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FnClasificadorCausalActivitdad;

END LDC_PKGESTIONORDENES;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGESTIONORDENES', 'OPEN'); 
END;
/  