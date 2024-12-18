CREATE OR REPLACE Package ld_bcfilegeneration Is

  /************************************************************************
   Propiedad intelectual de Ludycom S.A.

       Unidad         : ld_bcfilegeneration
       Descripcion    : Componente de negocio que lleva a cabo la generacion de los archivos de la central de riesgo

       Autor          : LUDYSANLEM
       Fecha          : 22/09/2012 02:49:43 p.m.

       Metodos

   Historia de Modificaciones (De la mas reciente a la mas antigua)

   Fecha           IDEntrega

   22-01-2014      JsilveraSAO223723
   Los campos numericos no vacios se deben imprimir con ceros a la izquierda para CIFIN.
   Procedimiento modificado: generatePrintCreditBureau


   21-11-2013      smunozSAO223793
   Los campos numericos vacios se deben imprimir en espacios para CIFIN.
   Procedimiento modificado: generatePrintCreditBureau

   12-08-2013      smunozSAO212516
   Se muestra un mensaje claro al usuario que indica que la impresion
   no se puede realizar porque la informacion del reporte no se genero completa.
   Procedimiento modificado: generatePrintBureau

    03-08-2013      smunozSAO213438
    Se realizan modificaciones para hacer uso de las nuevas columnas creadas en
    la tabla ld_novelty.
    Se realizan modificaciones para que se controle el ingreso de informacion
    dependiendo de la central que se esta procesando.
    Procedimientos y funciones modificadas: f_Registros_a_Procesar_Firad,
    Generateprintrenumbering, Generateprintnovelty


   01-08-2013      JsilveraSAO212461
   * Se actualiza procedimiento generateprintcreditbureau para recibir parametros de entrada que le enviara el Proceso Stand alone de
     FGRCP. Esto se realizo porque se necesitaba que el aplicativo no quedara bloqueado una vez este proceso se
     ejecutara. Se queria liberar pantalla despues de que el usuario presionara el boton Procesar.
  * Creacion del Proceso  Provalidaproprogramado

   29-07-2013      smunozSAO212456
   * Se envian los cursores curegformat curep curepor2 a nivel de declaracion del
   paquete ya que se usan en varias partes del paquete y es importante tenerlos
   unificados y asi facilite el mantenimiento.
   * Se eliminan los cursores de los procedimientos generateprintcreditbureau,
   generateprintrenumbering, generateprintnovelty, generateprintblocked.


   26-07-2013      smunozSAO212457
   * Creacion de las unidades de programa: f_registros_a_procesar_fgrcp,
     f_registros_a_procesar_firad, pro_uno_por_ciento, pro_actualizaavance
   * Modificacion de los procesos: generateprintcreditbureau,
     generateprintrenumbering, generateprintnovelty, generateprintblocked,
     pbogeneratefile.



   DD-MM-2013      usuarioSAO######
   Descripcion breve, precisa y clara de la modificacion realizada.

       ******************************************************************/

  Procedure generateprintcreditbureau(sbcredit_bureau Varchar2,
                                      sbsector_type   Varchar2,
                                      sbsample_id     Varchar2);

  Procedure generateprintrenumbering(nucredit_bureau ld_credit_bureau.credit_bureau_id%Type,
                                     nuformat_id     ld_reporting_format.format_id%Type);

  Procedure generateprintnovelty(nucredit_bureau ld_credit_bureau.credit_bureau_id%Type,
                                 nuformat_id     ld_reporting_format.format_id%Type);

  Function fboupdatereport(indate     ld_random_sample.generation_date%Type,
                           inusector  ld_random_sample.type_sector%Type,
                           inuproduct ld_sample.type_product_id%Type)

   Return Boolean;

  Procedure generateprintblocked(nucredit_bureau ld_credit_bureau.credit_bureau_id%Type,
                                 nuformat_id     ld_reporting_format.format_id%Type);

  Function fsbversion Return Varchar2;

  Procedure pbogeneratefile(sbcredit_bureau Varchar2, sbformat_id Varchar2);

  Function ldvalidategeneration(nusample ld_sample.sample_id%Type)
    Return Number;
  Procedure provalidaproprogramado;
  Procedure provalidaproprogramadofirad;

End ld_bcfilegeneration;
/
CREATE OR REPLACE Package Body ld_bcfilegeneration Is

  -- Esta constante se debe modificar cada vez que se entregue el
  -- paquete con un SAO
  csbversion Constant Varchar2(250) := '223723';

  -- Variables globales
  g_reg_a_procesar Number; -- Cantidad de registros a procesar
  g_uno_por_ciento Number; -- Numero de registros que corresponden al 1% procesado
  g_reg_procesados Number := 0; -- Numero de registros procesados
  g_program_id     estaprog.esprprog%Type; -- Identificador del programa que se esta ejecutando

  -- Cursores
  Cursor curegformat(nuformat ld_repo_format_regis.format_id%Type) Is
    Select *
      From ld_repo_format_regis
     Where format_id = nuformat
     Order By register_order;

  Cursor curep(cont         Number,
               nuformat     ld_reporting_format.format_id%Type,
               nucrediburea ld_type_financial_repo.credit_bureau%Type) Is
    Select field_report_name,
           number_length,
           field_type,
           initial_position,
           end_position,
           r.format_id
      From ld_reporting_format f, ld_type_financial_repo r -- SMUNOZ: No se le crea indice porque la tabla es muy peque?a
     Where r.credit_bureau = nucrediburea
       And r.format_id = nuformat
       And r.format_id = f.format_id
       And f.register_type = cont
     Order By initial_position;

  CURSOR curepor2(nufield      ld_reporting_format.field_report_id%TYPE,
                  cont         NUMBER,
                  nuformat     ld_reporting_format.format_id%TYPE,
                  nucrediburea ld_type_financial_repo.credit_bureau%TYPE)
  IS
  --Cursor encargado de obtener el formato del archivo plano mediante parametros
  SELECT field_report_name, field_type, number_length, field_type_write
    FROM ld_reporting_format f, ld_type_financial_repo r
    WHERE r.credit_bureau = nucrediburea
      AND f.format_id = nuformat
      AND field_report_id = To_Number(nufield)
      AND f.register_type = cont
      AND r.format_id = f.format_id
    ORDER BY initial_position;

  FUNCTION f_registros_a_procesar_fgrcp(p_sample_id ld_sample.sample_id%TYPE)
  RETURN NUMBER
  IS
    /*******************************************************************************
    Propiedad intelectual:   LUDYCOM
    Autor:                   Sandra Mu?oz
    Fecha creacion:          26-07-2013
    Nombre:                  f_registros_a_procesar_fgrcp

    Proposito:
    Calcula el numero de registros a procesar para el proceso FGRCP

    Parametros:
    * p_sample_id: Codigo del reporte

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    26-07-2013      smunozSAO212457
    Creacion.


    DD-MM-2013      usuarioSAO######
    Descripcion breve, precisa y clara de la modificacion realizada.
    *******************************************************************************/

    v_reg_a_procesar Number; -- Registros a procesar

    CURSOR cuSample
    IS
    SELECT *
      FROM  ld_sample
      WHERE sample_id = p_sample_id;

    rccuSample cuSample%ROWTYPE;
  BEGIN

    OPEN cuSample;
    FETCH cuSample INTO rccuSample;
    CLOSE cuSample;

    IF(rccuSample.type_sector = 2)THEN
      -- Numero de registros de la tabla ld_sample
      Select Count(1)
        Into v_reg_a_procesar
        From ld_sample_detai
      Where sample_id = p_sample_id
      AND IS_APPROVED = 'Y';
    ELSE
      -- Numero de registros de la tabla ld_sample
      Select Count(1)
        Into v_reg_a_procesar
        From ld_sample_detai
      Where sample_id = p_sample_id;
    END IF;

    -- Se agregan dos registros qu corresponden a ld_sample_cont y ld_sample_fin que
    -- tambien se imprimen en el archivo
    v_reg_a_procesar := v_reg_a_procesar + 2;

    RETURN v_reg_a_procesar;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END f_registros_a_procesar_fgrcp;

  Function f_registros_a_procesar_firad(p_credit_bureau ld_sample.credit_bureau_id%Type, -- Central de riesgo
                                        p_formato       ld_reporting_format.format_id%Type -- Formato de reporte
                                        ) Return Number Is
    /*******************************************************************************
    Propiedad intelectual:   LUDYCOM
    Autor:                   Sandra Mu?oz
    Fecha creacion:          26-07-2013
    Nombre:                  f_registros_a_procesar_firad

    Proposito:
    Calcular el numero de registros a procesar para el proceso FIRAD

    Parametros:
    * p_credit_bureau: Central
    * p_formato:       Formato a usar

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    03-08-2013      smunozSAO212518
    Se realizan modificaciones para hacer uso de las nuevas columnas creadas en
    la tabla ld_novelty.
    Se realizan modificaciones para que se controle el ingreso de informacion
    dependiendo de la central que se esta procesando.

    26-07-2013      smunozSAO212457
    Creacion.


    DD-MM-2013      usuarioSAO######
    Descripcion breve, precisa y clara de la modificacion realizada.
    *******************************************************************************/

    -- Variables
    v_reg_a_procesar        Number := 0; -- Registros a procesar
    v_reg_por_tabla         Number := 0; -- Registros a procesar en una tabla
    v_codform               ld_reporting_format.format_id%Type;
    v_dummy                 ld_general_parameters.text_value%Type;
    v_tiene_parametrizacion Number := 0; -- Indica si se tiene parametrizacion
    v_blockcode             ld_blocked.blocked_id%Type; -- Codigo de reporte
  Begin

    -- Se recorren los tipos de registro que se incluiran en el archivo
    For regformar In curegformat(p_formato) Loop

      v_reg_por_tabla := 0;

      -- Se obtienen los parametros

      -- Renumeracion
      If p_formato In (4, 5) Then
        If p_credit_bureau = 1 Then
          provapatapa('CODIGO_FORMATO_REENUMERA_DATA',
                      'N',
                      v_codform,
                      v_dummy);
        Elsif p_credit_bureau = 2 Then
          provapatapa('CODIGO_FORMATO_REENUMERA_CIFIN',
                      'N',
                      v_codform,
                      v_dummy);
        End If;
        -- Novedades
      Elsif p_formato In (6, 7) Then
        If p_credit_bureau = 1 Then
          provapatapa('CODIGO_FORMATO_NOVEDAD_DATA',
                      'N',
                      v_codform,
                      v_dummy);
        Elsif p_credit_bureau = 2 Then
          provapatapa('CODIGO_FORMATO_NOVEDAD_CIFIN',
                      'N',
                      v_codform,
                      v_dummy);
        End If;
        -- Bloqueados
      Elsif p_formato In (8) Then
        If p_credit_bureau = 1 Then
          provapatapa('CODIGO_FORMATO_BLOQUEADOS_DATA',
                      'N',
                      v_codform,
                      v_dummy);
        End If; -- If p_credit_bureau = 1 Then
      End If; --If p_formato In (4, 5) Then

      -- Obtengo columnas de la sentencia dinamica
      v_tiene_parametrizacion := 0;

      For reg In curep(regformar.type_register, v_codform, p_credit_bureau) Loop
        v_tiene_parametrizacion := v_tiene_parametrizacion + 1;
      End Loop; -- For reg In curep(regformar.type_register, v_codform, p_credit_bureau) Loop

      -- Se verifica si hay parametrizacion para el encabezado del archivo
      If regformar.type_register = 1 Then
        If p_formato = '8' And p_credit_bureau = 1 Then
          Select Max(blocked_id)
            Into v_blockcode
            From ld_blocked b
           Where b.credit_bureau = 1
             And managed = 'G';

          If v_blockcode > 0 Then
            v_reg_a_procesar := v_reg_a_procesar + 1;
          End If;
        Elsif v_tiene_parametrizacion > 0 Then
          v_reg_a_procesar := v_reg_a_procesar + 1;
        End If; -- If  p_formato = '8' And p_credit_bureau = 1 Then
      End If; -- If (regformar.type_register = 1) Then

      -- Renumeracion
      If p_formato In (4, 5) And regformar.type_register = 6 Then

        -- Se ajusta la consulta para que tome las nuevas columnas de la
        -- tabla ld_renumbering. smunozSAO212518
        Begin
          Select Count(1)
            Into v_reg_por_tabla
            From ld_renumbering lr
           Where lr.credit_bureau_id = p_credit_bureau
             And lr.flag_envio = 'N';
        Exception
          When Others Then
            v_reg_a_procesar := 0;
        End;

        -- Novedades
      Elsif p_formato In (6, 7) And (regformar.type_register = 7) Then
        -- Se hace uso de las nuevas columnas que se crean en ld_novelty
        -- para identificar a que central estan asociados los registros.
        -- smunozSAO212518.
        Begin
          Select Count(1)
            Into v_reg_por_tabla
            From ld_novelty ln
           Where p_credit_bureau = ln.credit_bureau_id
             And ln.flag_envio = 'N';
        Exception
          When Others Then
            v_reg_a_procesar := 0;
        End;

        -- Bloqueados
      Elsif p_formato In (8) And regformar.type_register = 5 Then

        Select Count(1)
          Into v_reg_por_tabla
          From ld_blocked_detail
         Where (p_credit_bureau = 1 And blocked_id = v_blockcode)
            Or p_credit_bureau = 2;
      End If; -- If (regformar.type_register = 7) Then

      v_reg_a_procesar := v_reg_a_procesar + v_reg_por_tabla;

      -- Solo se calcula para renumeraciones y novedades, y para bloqueados
      -- solo para dtacredito
      If regformar.type_register = 3 And
         (p_formato In (4, 5, 6, 7) Or
         (p_formato = 8 And p_credit_bureau = 1)) Then
        v_reg_a_procesar := v_reg_a_procesar + 1;
      End If; -- If regformar.type_register = 3 And p_formato In (4, 5, 6, 7) Then
    End Loop; -- For regformar In curegformat(nuformat_id) Loop

    Return v_reg_a_procesar;
  Exception
    When Others Then
      Return 0;
  End f_registros_a_procesar_firad;

  Procedure pro_uno_por_ciento Is
    /*******************************************************************************
    Propiedad intelectual:   LUDYCOM
    Autor:                   Sandra Mu?oz
    Fecha creacion:          26-07-2013
    Nombre:                  pro_uno_por_ciento

    Proposito:
    Calcula el numero de registros que corresponden al 1% del total de registros a
    procesar

    Parametros:
    Ninguno.

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    21-07-2013      usuarioSAO212457
    Creacion.

    DD-MM-2013      usuarioSAO######
    Descripcion breve, precisa y clara de la modificacion realizada.

    *******************************************************************************/
  Begin
    g_uno_por_ciento := trunc(nvl(g_reg_a_procesar, 0) / 100);

    If g_uno_por_ciento < 1 Then
      g_uno_por_ciento := 1;
    End If;
  End pro_uno_por_ciento;

  Procedure pro_actualizaavance(p_fin_proceso Varchar2 Default 'N') Is

    /*******************************************************************************
    Propiedad intelectual:   LUDYCOM
    Autor:                   Sandra Mu?oz
    Fecha creacion:          26-07-2013
    Nombre:                  pro_actualizaavance

    Proposito:
    Actualizar el porcentaje de registros procesados en la tabla estaprog

    Parametros:
    * p_fin_proceso: Indica si si va a registrar el fin del proceso actualizando
                     el numero de registros procesados.  Si no se indica, se asume
                     que debe incrementarse el contador de registros procesados y
                     evaluar si con este se completa un nuevo 1% y se actualiza el
                     porcentaje de avance en staprog

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    26-07-2013      usuarioSAO212457
    Creacion.

    DD-MM-2013      usuarioSAO######
    Descripcion breve, precisa y clara de la modificacion realizada.

    *******************************************************************************/

  Begin
    -- Solo incrementa el contador si aun no se ha terminado de ejecutar el proceso
    If p_fin_proceso = 'N' Then
      g_reg_procesados := g_reg_procesados + 1;
    End If; -- If p_fin_proceso = 'N' Then

    -- Se actualiza estaprog si se completo un nuevo 1% en el procesamiento o si se terminaron de
    -- procesar todos los registros
    If Mod(g_reg_procesados, g_uno_por_ciento) = 0 Or p_fin_proceso = 'S' Then
      pkstatusexeprogrammgr.upstatusexeprogramat(isbprog       => g_program_id,
                                                 isbmens       => 'Ultima linea procesada: ' ||
                                                                  g_reg_procesados,
                                                 inutotalreg   => g_reg_a_procesar,
                                                 inucurrentreg => g_reg_procesados);
      pkgeneralservices.committransaction;
    End If; -- If Mod(nucount, cregistrosparacommit) = 0 Then
  Exception
    When Others Then
      Null;
  End pro_actualizaavance;

  Procedure generateprintcreditbureau(sbcredit_bureau Varchar2,
                                      sbsector_type   Varchar2,
                                      sbsample_id     Varchar2) Is

    /****************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Nombre         :  generateprintcreditbureau
    Descripcion    : procedimiento encargado de la Generacion de archivo para centrales de riesgo.

    Parametros     :

    Nombre Parametro  Tipo de Parametro        Tipo de dato del parametro            Descripcion



    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega
   22-01-2014      JsilveraSAO223723
   Los campos numericos no vacios se deben imprimir con ceros a la izquierda para CIFIN.
   Procedimiento modificado: generatePrintCreditBureau


    21-11-2013      smunozSAO223793
    Los campos numericos vacios se deben imprimir en espacios para CIFIN.

    16-08-2013     slemusSAO214733
    Se modifica el paquete para que escriba el nombre del archivo de Cifin dependiendo del Sector, como se especifica en
    el archivo.

    16-08-2013     kcienfuegosSAO212456
    Se modifican las excepciones, para incluir los mensajes del archivo de errores en ge_error_log.
    16-08-2013    kcienfuegosSAO212460
    Se modifican el manejo de archivo de log, para que el nombre lleve la hora

    13-08-2013      slemusSAO213001
    Se modifica la impresion de los reportes para que trabajen con el nuevo campo field_type_write
    que se crea en la tabla ld_reporting_format, que especifica la manera de esritura del campo en reporte.


    12-08-2013      smunozSAO212516
    Se muestra un mensaje claro al usuario que indica que la impresion
    no se puede realizar porque la informacion del reporte no se genero completa


    01-08-2013      JsilveraSAO212461
    Se actualiza procedimiento para recibir parametros de entrada que le enviara el Proceso Stand alone de
    FGRCP. Esto se realizo porque se necesitaba que el aplicativo no quedara bloqueado una vez este proceso se
    ejecutara. Se queria liberar pantalla despues de que el usuario presionara el boton Procesar.

    29-07-2013      smunozSAO212456
    * Se envian los cursores curegformat curep curepor2 a nivel de declaracion del
    paquete ya que se usan en varias partes del paquete y es importante tenerlos
    unificados y asi facilite el mantenimiento.
    * Se eliminan los cursores del procedimiento.


    26-07-2013      smunozSAO212457
    Se ajusta el procedimiento para marcar el avance del proceso

    DD-MM-2013      usuarioSAO######

    02-03-2018    Elkin Alvarez
    Colocamos en comentario la instruccion Update ld_sample Set flag = 'S' Where sample_id = sbsample_id;
    para que se puede generar el reporte las veces que sea posible.

    Descripcion breve, precisa y clara de la modificacion realizada.
    *****************************************************************************/

    cnunull_attribute Constant Number := 2126;
    -- <<Jsilvera SAO 212461 -- Estas variables no se van a obtener desde instancia sino de obtiene  como parametros que sera enviados desde el proceso Satand lone FGRCP>>
    /* sbcredit_bureau   ge_boinstancecontrol.stysbvalue;
    sbsector_type     ge_boinstancecontrol.stysbvalue;
    sbsample_id       ge_boinstancecontrol.stysbvalue;*/
    sbproduct_type_id ld_product_type.typrcodi%Type;

    sbformat_id ld_type_format.id_format%Type;
    -- Declara varibles para generacion del Archivo Plano
    vnuadmarc       utl_file.file_type;
    vnulogarc       utl_file.file_type;
    sbnomlog        Varchar2(200);
    sbnomarc        Varchar2(200);
    sbrutarep       Varchar2(200);
    nucodcifin      ld_general_parameters.numercial_value%Type;
    nucoddata       ld_general_parameters.numercial_value%Type;
    nucodentfin     ld_general_parameters.numercial_value%Type;
    cursor_name     Integer;
    i               Integer;
    inexec_sql      Integer;
    val_char        Varchar2(2000);
    val_number      Number;
    val_dato        Varchar2(2000);
    val_date        Date;
    numreg          Number;
    sbcadena        Varchar2(32000);
    sbwhere         Varchar2(32000);
    sbsentencia     Varchar2(32000);
    sbtipodato      ld_reporting_format.field_type%Type;
    sbnomcampo      ld_reporting_format.field_report_name%Type;
    nulargo         ld_reporting_format.number_length%Type;
    nudatesc        ld_reporting_format.field_type_write%Type;
    nuformat        ld_reporting_format.format_id%Type;
    nufecgen        Number(8);
    sbdummy         ld_general_parameters.text_value%Type;
    nudummy         ld_general_parameters.numercial_value%Type;
    sbextarch       ld_general_parameters.text_value%Type;
    nuexists        Number;
    v_seq_estaprog  Number; --                                           Secuencia del programa
    v_programa      estaprog.esprprog%Type := 'FGRCP'; --                Nombre de la pantalla que invoca al proceso
    fecha           Number(8);
    v_mensaje_error Varchar2(1000); --                                   Mensaje de error
    confignotfound Exception;
    nodata         Exception;
    sbsigpack ld_information_packets_cf.acronym%Type;

    Cursor cu_credit_bureau(nu_credit_bureau_id ld_credit_bureau.credit_bureau_id%Type) Is
      Select *
        From ld_credit_bureau
       Where credit_bureau_id =
             decode(nu_credit_bureau_id,
                    -1,
                    credit_bureau_id,
                    nu_credit_bureau_id)
         And credit_bureau_id <> -1;

    rg_credit_bureau cu_credit_bureau%Rowtype;

  Begin

    pkerrors.push('ld_bcfilegeneration.generateprintcreditbureau');
    ut_trace.trace('Antes de inicializar variables', 0);

    /* Parametros pasados desde el Procedimiento Stand alone FGRCP */

    --<<Jsilvera 01-08-2013 SAO 212461>>
    /* Se comenta inicializacion de Variable Sector, Central  e identificador del rporte porque este proceso
    para manejo de liberacion de pantalla se cambio a programado*/

    /*sbcredit_bureau := ge_boinstancecontrol.fsbgetfieldvalue('LD_SAMPLE_CONT',
    'CREDIT_BUREAU');*/

    ut_trace.trace('Centrales de Riesgos ' || sbcredit_bureau, 1);

    --<<Jsilvera 01-08-2013 SAO 212461>>
    /* sbsector_type := ge_boinstancecontrol.fsbgetfieldvalue('LD_SAMPLE_CONT',
                                                             'SECTOR_TYPE');
    */
    ut_trace.trace('Sector ' || sbsector_type, 2);

    --<<Jsilvera 01-08-2013 SAO 212461>>
    /*sbsample_id := ge_boinstancecontrol.fsbgetfieldvalue('LD_SAMPLE_CONT',
                                                           'SAMPLE_ID');
    */

    -- Obtener el total de registros a procesar
    g_reg_a_procesar := f_registros_a_procesar_fgrcp(sbsample_id);

    /*Se inicializa el atributo donde se almacenara el id de la secuencia de la entidad estaprog*/
    v_seq_estaprog := sqesprprog.nextval;

    g_program_id := v_programa || v_seq_estaprog;

    -- Iniciar el registro en estaprog indicando el numero de registros a procesar
    pkstatusexeprogrammgr.addrecord(g_program_id,
                                    'Proceso en ejecucion ...',
                                    g_reg_a_procesar);
    pkgeneralservices.committransaction;

    -- Calcular el numero de registros que corresponden al 1% del total de registros a procesar
    pro_uno_por_ciento;

    ut_trace.trace('Muestra ' || sbsample_id, 3);

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    If (sbcredit_bureau Is Null) Then
      errors.seterror(cnunull_attribute, 'Central de Riesgo');
      Raise ex.controlled_error;
    End If;

    If (sbsector_type Is Null) Then
      errors.seterror(cnunull_attribute, 'Sector');
      Raise ex.controlled_error;
    End If;

    If (sbsample_id Is Null) Then
      errors.seterror(cnunull_attribute, 'Id. Reporte Maestro');
      Raise ex.controlled_error;
    End If;
    ut_trace.trace('Antes de Obtener el producto ', 4);
    pkld_general_rules.progetproduct(sbcredit_bureau,
                                     sbsector_type,
                                     sbproduct_type_id);
    ut_trace.trace('Despues de Obtener el producto ', 5);

    /* Ruta del archivo */
    ut_trace.trace('Antes de Obtener la ruta de impresion ', 6);
    provapatapa('RUTA_IMPRESION', 'S', nudummy, sbrutarep);
    provapatapa('EXTENSION_DE_ARCHIVO', 'S', nudummy, sbextarch);
    ut_trace.trace('Despues de Obtener parametros impresion ', 7);

    nuexists := ldvalidategeneration(sbsample_id);

    If nuexists = 0 Then
      Raise nodata;
    End If;

    Open cu_credit_bureau(sbcredit_bureau);
    ut_trace.trace('Entro al cursor Cu_Credit_Bureau ', 8);
    Loop
      Fetch cu_credit_bureau
        Into rg_credit_bureau;

      Exit When cu_credit_bureau%Notfound;

      Select to_char(generation_date, 'yyyymmdd')
        Into nufecgen
        From ld_sample
       Where sample_id = sbsample_id;

      ut_trace.trace('Obtiene la fecha de generacion del reporte ' ||
                     nufecgen,
                     9);

      If rg_credit_bureau.credit_bureau_id = 1 Then
        ut_trace.trace('Central de Riesgos es Datacedito ' ||
                       rg_credit_bureau.credit_bureau_id,
                       9);
        provapatapa('CODIGO_DATACREDITO', 'N', nucoddata, sbdummy);
        ut_trace.trace('Codigo de la central ' || nucoddata, 10);

        sbnomarc    := nucoddata || '.' || nufecgen || '.' || 'T';
        sbformat_id := 1;
        ut_trace.trace('Nombre del archivo ' || sbnomarc, 11);
        ut_trace.trace('Fin del condicional central datacredito ', 12);
      Elsif rg_credit_bureau.credit_bureau_id = 2 Then
        ut_trace.trace('Central de Riesgos es Cifin ' ||
                       rg_credit_bureau.credit_bureau_id,
                       9);
        provapatapa('CODIGO_CIFIN', 'N', nucodcifin, sbdummy);
        ut_trace.trace('Codigo Cifin ' || nucodcifin, 10);

        sbformat_id := 2;
        provapatapa('ENTITY_TYPE', 'N', nucodentfin, sbdummy);
        ut_trace.trace('Codigo de la entidad ' || nucodentfin, 11);

        sbsigpack := ld_bcequivalreport.fsbgetsiglpackage(sbsector_type);

        sbnomarc := 'C' || sbsigpack || nucodentfin || nucodcifin ||
                    nufecgen;
        ut_trace.trace('Nombre del archivo ' || sbnomarc, 12);

      End If;
      dbms_output.put_line('Nombre Archivo: ' || sbnomarc);
      ut_trace.trace('ld_bcfilegeneration.generateprintcreditbureau Abre el archivo ruta '||sbrutarep, 13);
      vnuadmarc := utl_file.fopen(sbrutarep,
                                  sbnomarc || '.' || sbextarch,
                                  'w');

      ut_trace.trace('ld_bcfilegeneration.generateprintcreditbureau sbformat_id '||sbformat_id, 13);
      For regformar In curegformat(sbformat_id) Loop
        /* Inicializo sentencia dinamica */
        ut_trace.trace('Entro al cursor Curegformat, formato: ' ||
                       sbformat_id,
                       14);
        sbsentencia := 'select ';

        /* Obtengo columnas de la sentencia dinamica */

        For reg In curep(regformar.register_order,
                         sbformat_id,
                         sbcredit_bureau) Loop
          nuformat    := reg.format_id;
          sbsentencia := sbsentencia || reg.field_report_name || ',';
          ut_trace.trace('Entro al cursor Curep, Sentencia: ' ||
                         sbsentencia,
                         15);
        End Loop;

        If sbsentencia = 'select ' Then
          Raise confignotfound;
        End If;

        /* Paso la cadena almacenada en sbsentencia a minuscula */
        sbsentencia := lower(sbsentencia);

        /* Retiro la coma que tengo al final de la sentencia obtenida en la linea dentro del loop curep */
        sbsentencia := substr(sbsentencia, 1, length(sbsentencia) - 1);

        /* Para tipo de registro 1 haga */
        If (regformar.register_order = 1) Then

          /* contateno la tabla */
          sbsentencia := sbsentencia || ' FROM ld_sample_cont ';

          /* le asigno a la variable where la siguiente cadena */
          sbwhere := ' where sample_id  = ' || sbsample_id;

        End If;

        /* Para tipo de registro 1 haga */
        If (regformar.register_order = 2) Then

          /* contateno la tabla */
          sbsentencia := sbsentencia || ' FROM ld_sample_detai ';

          /* le asigno a la variable where la siguiente cadena */
          sbwhere := ' where sample_id  = ' || sbsample_id;

          /* le asigno a la variable where la siguiente cadena */
          sbwhere := sbwhere  || ' AND ( IS_APPROVED  = ''Y'' OR IS_APPROVED IS NULL) AND 0 = (SELECT COUNT(1) FROM ld_send_authorized lsa WHERE lsa.identification = identification_number AND lsa.authorized = ''N'' AND lsa.product_id = to_number(TRIM(account_number)) AND (lsa.sample_id = '||sbsample_id||' OR lsa.sample_id = -1))';

        End If;

        /* Para tipo de registro 1 haga */
        If (regformar.register_order = 3) Then

          /* contateno la tabla */
          sbsentencia := sbsentencia || ' FROM ld_sample_fin ';

          /* le asigno a la variable where la siguiente cadena */
          sbwhere := ' where sample_id  = ' || sbsample_id;
        End If;

        /* Concateno where con sbsentencia */
        sbsentencia := sbsentencia || sbwhere;

        /* Definicion del cursor */
        cursor_name := dbms_sql.open_cursor;

        /* Revision de sintaxis  */
        dbms_sql.parse(cursor_name, sbsentencia, 1);

        /* Definicion de columnas que se van a retornar del cursor */
        i := 1;

        For reg In curep(regformar.register_order,
                         sbformat_id,
                         sbcredit_bureau) Loop

          --Dependiendo del valor de field_type haga

          /* Si es de tipo NUMBER */
          If reg.field_type = 1 Then
            dbms_sql.define_column(cursor_name, i, val_number);
            /* Si es de tipo VARCHAR */
          Elsif reg.field_type = 2 Then
            dbms_sql.define_column(cursor_name,
                                   i,
                                   val_char,
                                   reg.number_length);

            /* Si es de tipo DATE */
          Elsif reg.field_type = 3 Then
            dbms_sql.define_column(cursor_name, i, val_date);
          End If;

          -- Incremento
          i := i + 1;

          numreg := i - 1;

        End Loop;

        /* Ejecucion del cursor */
        inexec_sql := dbms_sql.execute(cursor_name);

        /* Si obtiene registros */
        Loop

          /* Inicializo la cadena */
          sbcadena := Null;

          Exit When dbms_sql.fetch_rows(cursor_name) = 0;

          /* Inicio loop numreg */
          For i In 1 .. numreg Loop

            /* Llamo a cursor curepor2 con parametros para saber el tipo de variable */
            Open curepor2(i,
                          regformar.register_order,
                          sbformat_id,
                          sbcredit_bureau);
            Fetch curepor2
            /* Tipo de dato / longitu */
              Into sbnomcampo, sbtipodato, nulargo, nudatesc;

            /* Finalizo el cursor */
            Close curepor2;

            /* Si obtengo un tipo NUMBER haga */
            If sbtipodato = 1 Then
              dbms_sql.column_value(cursor_name, i, val_number);
              val_dato := val_number;
              /* Si obtengo un tipo VARCHAR haga */
            Elsif sbtipodato = 2 Then
              dbms_sql.column_value(cursor_name, i, val_char);
              val_dato := val_char;
              /* Si obtengo un tipo DATE haga */
            Elsif sbtipodato = 3 Then
              dbms_sql.column_value(cursor_name, i, val_date);
              fecha    := to_number(to_char(val_date, 'yyyymmdd'));
              val_dato := fecha;
            End If;

            If nudatesc = 1 Then
              -- Los campos numericos vacios se deben imprimir en espacios para CIFIN
              -- smunozSAO223793
              If sbCredit_Bureau = 1 Then
                -- Datacredito
                sbcadena := sbcadena || lpad(nvl(val_dato, 0), nulargo, 0);
              Elsif sbCredit_Bureau = 2 Then
                -- Cifin
                if (val_dato is null) then

                  sbcadena := sbcadena ||
                              lpad(nvl(val_dato, ' '), nulargo, ' ');
                 else
                  sbcadena := sbcadena || lpad(val_dato, nulargo, 0);
                end if;
              end if;
            Elsif nudatesc = 2 Then
              sbcadena := sbcadena ||
                          rpad(nvl(val_dato, ' '), nulargo, ' ');
            Elsif nudatesc = 3 Then
              sbcadena := sbcadena ||
                          lpad(nvl(val_dato, ' '), nulargo, ' ');
            End If;

          /* Finalizo loop numreg */
          End Loop;

          utl_file.put_line(vnuadmarc, sbcadena);
          dbms_output.put_line(sbcadena);

          -- Actualizar el porcentaje de avance
          g_reg_procesados := g_reg_procesados + 1;

          If Mod(g_reg_procesados, g_uno_por_ciento) = 0 Then
            pkstatusexeprogrammgr.upstatusexeprogramat(isbprog       => g_program_id,
                                                       isbmens       => 'Ultima linea procesada: ' ||
                                                                        g_reg_procesados,
                                                       inutotalreg   => g_reg_a_procesar,
                                                       inucurrentreg => g_reg_procesados);
            Commit;
          End If; -- If Mod(nucount, cregistrosparacommit) = 0 Then

        End Loop;

      End Loop;
    End Loop;
    ut_trace.trace('Sentencia Final: ' || sbsentencia, 16);

    utl_file.fclose(vnuadmarc);

    Begin
      null;
      Update ld_sample Set flag = 'S' Where sample_id = sbsample_id;
    End;

    Begin
      Commit;
    End;

    -- Actualiza el registro de seguimiento del proceso en ESTAPROG a Terminado OK
    pro_actualizaavance(p_fin_proceso => 'S');
    pkstatusexeprogrammgr.processfinishok(g_program_id);
    -- Finaliza la transaccion del proceso
    pkgeneralservices.committransaction;

    pkerrors.pop;

  Exception
    When nodata Then
      Rollback;
      -- Finaliza la transaccion del proceso
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           'La informacion no es valida para enviar a la Central ya que el reporte ' ||
                           sbsample_id || ' se encuentra incompleto.',
                           v_mensaje_error);

      pro_actualizaavance(p_fin_proceso => 'S');
      pkstatusexeprogrammgr.processfinishnok(g_program_id,
                                             substr('Proceso terminado con errores: ' ||
                                                    v_mensaje_error,
                                                    1,
                                                    2000));
      pkgeneralservices.committransaction;
       /*errors.sbAplicacion := 'FGRCP';*/
      dbms_application_info.set_module(module_name => 'FGRCP',
                                       action_name => Null);
      errors.seterror(8013,
                      'La informacion no es valida para enviar a la Central ya que el reporte ' ||
                      sbsample_id || ' se encuentra incompleto.');
      pkerrors.pop;
      sbnomlog  := 'Error_Generacion' || to_char(Sysdate, 'yyyymmdd') || '_' ||
                   to_char(Sysdate, 'HH:MI:SS') || '.txt';
      vnulogarc := utl_file.fopen(sbrutarep, sbnomlog, 'w');
      -- Mostrar un mensaje claro al usuario que indique que la impresion
      -- no se puede realizar porque la informacion no se genero completa. smunozSAO212516.
     utl_file.put_line(vnulogarc,
                        'La informacion no es valida para enviar a la Central ya que el reporte ' ||
                        sbsample_id || ' se encuentra incompleto.');
      dbms_output.put_line('La informacion no es valida para enviar a la Central ya que el reporte ' ||
                           sbsample_id || ' se encuentra incompleto.');
      utl_file.fclose(vnulogarc);
      If utl_file.is_open(vnuadmarc) Then
       utl_file.fremove(sbrutarep, sbnomarc);
      End If;

      Raise ex.controlled_error;

    When confignotfound Then
      -- Finaliza la transaccion del proceso
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           'No se Encontro Configuracion',
                           v_mensaje_error);
      pro_actualizaavance(p_fin_proceso => 'S');
      pkstatusexeprogrammgr.processfinishnok(g_program_id,
                                             substr('Proceso terminado con errores: ' ||
                                                    v_mensaje_error,
                                                    1,
                                                    2000));
      pkgeneralservices.committransaction;
      pkerrors.pop;
      sbnomlog  := 'Error_Generacion' || to_char(Sysdate, 'yyyymmdd') || '_' ||
                   to_char(Sysdate, 'HH:MI:SS') || '.txt';
     vnulogarc := utl_file.fopen(sbrutarep, sbnomlog, 'w');
     utl_file.put_line(vnulogarc, 'No se Encontro Configuracion');
      dbms_output.put_line('No se Encontro Configuracion');
     utl_file.fclose(vnulogarc);
      If utl_file.is_open(vnuadmarc) Then
        utl_file.fremove(sbrutarep, sbnomarc);
      End If;
      dbms_application_info.set_module(module_name => 'FGRCP',
                                       action_name => Null);
      errors.seterror;
      Raise ex.controlled_error;

    When Others Then
      -- Finaliza la transaccion del proceso
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           Sqlerrm,
                           v_mensaje_error);
      pro_actualizaavance(p_fin_proceso => 'S');
      pkstatusexeprogrammgr.processfinishnok(g_program_id,
                                             substr('Proceso terminado con errores: ' ||
                                                    v_mensaje_error,
                                                    1,
                                                    2000));
      pkgeneralservices.committransaction;
      pkerrors.pop;
      sbnomlog  := 'Error_Generacion' || to_char(Sysdate, 'yyyymmdd') || '_' ||
                   to_char(Sysdate, 'HH:MI:SS') || '.txt';
      vnulogarc := utl_file.fopen(sbrutarep, sbnomlog, 'w');
      utl_file.put_line(vnulogarc, 'Se presento el error' || Sqlerrm);
      dbms_output.put_line('Se presento el error' || Sqlerrm);
      utl_file.fclose(vnulogarc);
      If utl_file.is_open(vnuadmarc) Then
        utl_file.fremove(sbrutarep, sbnomarc);
      End If;
      dbms_application_info.set_module(module_name => 'FGRCP',
                                       action_name => Null);
      errors.seterror;
      Raise ex.controlled_error;
  End;

  Procedure generateprintrenumbering(nucredit_bureau ld_credit_bureau.credit_bureau_id%Type,
                                     nuformat_id     ld_reporting_format.format_id%Type) Is

    /**************************************************************************************************************************************

       Nombre         :  generateprintrenumbering
       Descripcion    : Procedimiento encargado de la Generacion de archivo para enviar reenumeracion a las centrales de riesgo.

       Parametros     :


       Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro                  Descripcion
         nucredit_bureau    Entrada              ld_credit_bureau.credit_bureau_id%Type       Codigo de la central de riesgo
         nuformat_id        Entrada              ld_reporting_format.format_id%Type           CODIGO DEL FORMATO


    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega
    16-08-2013     kcienfuegosSAO212456
    Se modifican las excepciones, para incluir los mensajes del archivo de errores en ge_error_log
    16-08-2013    kcienfuegosSAO212460
    Se modifican el manejo de archivo de log, para que el nombre lleve la hora

    13-08-2013      slemusSAO213001
    Se modifica la impresion de los reportes para que trabajen con el nuevo campo field_type_write
    que se crea en la tabla ld_reporting_format, que especifica la manera de esritura del campo en reporte.

    03-08-2013      smunozSAO212518
    Se realizan modificaciones para hacer uso de las nuevas columnas creadas en
    la tabla ld_novelty.
    Se realizan modificaciones para que se controle el ingreso de informacion
    dependiendo de la central que se esta procesando.

    29-07-2013      smunozSAO212456
    Se envian los cursores curegformat curep curepor2 a nivel de declaracion del
    paquete ya que se usan en varias partes del paquete y es importante tenerlos
    unificados y asi facilite el mantenimiento.
    * Se eliminan los cursores del procedimiento.

    26-07-2013      smunozSAO212457
    Se ajusta el procedimiento para marcar el avance del proceso

    DD-MM-2013      usuarioSAO######
    Descripcion breve, precisa y clara de la modificacion realizada.
    **************************************************************************************************************************************/

    -- Declara varibles para generacion del Archivo Plano
    cnunull_attribute Constant Number := 4705;
    vnuadmarc   utl_file.file_type;
    vnulogarc   utl_file.file_type;
    sbnomarc    Varchar2(100);
    sbnomlog    Varchar2(100);
    sbrutarep   Varchar2(200);
    nucodcifin  ld_general_parameters.numercial_value%Type;
    nucoddata   ld_general_parameters.numercial_value%Type;
    nucodentfin ld_general_parameters.numercial_value%Type;
    nucodform   ld_general_parameters.numercial_value%Type;

    cursor_name Integer;
    i           Integer;
    inexec_sql  Integer;
    val_char    Varchar2(2000);
    val_number  Number;
    val_dato    Varchar2(2000);
    val_date    Date;
    numreg      Number := 0;
    sbcadena    Varchar2(32000);
    sbwhere     Varchar2(32000);
    sbsentencia Varchar2(32000);
    sbnomarlog  Varchar2(200);
    sbtipodato  ld_reporting_format.field_type%Type;
    sbnomcampo  ld_reporting_format.field_report_name%Type;
    nulargo     ld_reporting_format.number_length%Type;
    nudatesc    ld_reporting_format.field_type_write%Type;
    nuformat    ld_reporting_format.format_id%Type;
    nufecgen    Number(8);
    sbdummy     ld_general_parameters.text_value%Type;
    nudummy     ld_general_parameters.numercial_value%Type;
    confignotfound Exception;
    nodata         Exception;
    sbnomemp        sistema.sistempr%Type;
    sbextarch       ld_general_parameters.text_value%Type;
    gsberrmsg       ge_error_log.description%Type;
    fecha           Number(8);
    nutotalsend     Number(5);
    v_mensaje_error Varchar2(1000); --                                   Mensaje de error

  Begin

    /* Parametros pasados desde el FrameWork FWCPB de nombre FGRCP */

    pkerrors.push('ld_bcfilegeneration.generateprintrenumbering');

    /* Ruta del archivo */
    provapatapa('RUTA_IMPRESION', 'S', nudummy, sbrutarep);
    provapatapa('EXTENSION_DE_ARCHIVO', 'S', nudummy, sbextarch);

    Select sistempr Into sbnomemp From sistema Where sistcodi = 99;
    nufecgen := to_number(to_char(Sysdate, 'yyyymmdd'));

    If nucredit_bureau = 1 Then
      provapatapa('CODIGO_DATACREDITO', 'N', nucoddata, sbdummy);
      provapatapa('CODIGO_FORMATO_REENUMERA_DATA', 'N', nucodform, sbdummy);

      sbnomarc   := 'RENUMERACION-' || upper(sbnomemp) || '_' || nufecgen || '-' ||
                    to_char(Sysdate, 'HH_MI_SS');
      sbnomarlog := sbnomarc || '.txt';
    Elsif nucredit_bureau = 2 Then
      provapatapa('ENTITY_TYPE', 'N', nucodentfin, sbdummy); --tipo de entidad
      provapatapa('CODIGO_CIFIN', 'N', nucodcifin, sbdummy);
      provapatapa('CODIGO_FORMATO_REENUMERA_CIFIN',
                  'N',
                  nucodform,
                  sbdummy);
      sbnomarc   := 'C' || 'RS' || nucodentfin || nucodcifin || nufecgen;
      sbnomarlog := sbnomarc || '_' || to_char(Sysdate, 'HH_MI_SS') ||
                    '.txt';
    End If;

    /* le asigno a la variable where la siguiente cadena */

    -- Se hace uso de las nuevas variables definidas en ld_renumbering. smunozSAO212518
    sbwhere := ' where flag_envio   = ''N'' And   credit_bureau_id = ' ||
               nucredit_bureau;

    Begin
      Select Count(*)
        Into nutotalsend
        From ld_renumbering lr
       Where flag_envio = 'N'
         And lr.credit_bureau_id = nucredit_bureau;
    Exception
      When no_data_found Then
        nutotalsend := 0;
    End;

    If nutotalsend = 0 Then
      Raise nodata;
    End If;

    vnuadmarc := utl_file.fopen(sbrutarep,
                                sbnomarc || '.' || sbextarch,
                                'w');

    For regformar In curegformat(nuformat_id) Loop
      /* Inicializo sentencia dinamica */
      sbsentencia := 'select ';

      /* Obtengo columnas de la sentencia dinamica */
      For reg In curep(regformar.type_register, nucodform, nucredit_bureau) Loop
        nuformat    := reg.format_id;
        sbsentencia := sbsentencia || reg.field_report_name || ',';
      End Loop;

      If sbsentencia = 'select ' Then
        Raise confignotfound;
      End If;

      /* Paso la cadena almacenada en sbsentencia a minuscula */
      sbsentencia := lower(sbsentencia);

      /* Retiro la coma que tengo al final de la sentencia obtenida en la linea dentro del loop curep */
      sbsentencia := substr(sbsentencia, 1, length(sbsentencia) - 1);

      If (regformar.type_register = 1) Then

        sbsentencia := '1' || lpad(7, 2, 0) || lpad(nucodentfin, 3, 0) ||
                       lpad(nucodcifin, 3, 0) || '          ' || '02' ||
                       to_char(Sysdate, 'YYYYMMDD');

        utl_file.put_line(vnuadmarc, sbsentencia);
        dbms_output.put_line(sbsentencia);
        pro_actualizaavance;
      End If;

      /* Para tipo de registro 2 haga */
      If (regformar.type_register = 6) Then

        /* contateno la tabla */
        sbsentencia := sbsentencia || ' FROM ld_renumbering ';

        /* Concateno where con sbsentencia */
        sbsentencia := sbsentencia || sbwhere;

        /* Definicion del cursor */
        cursor_name := dbms_sql.open_cursor;

        /* Revision de sintaxis  */
        dbms_sql.parse(cursor_name, sbsentencia, 1);

        /* Definicion de columnas que se van a retornar del cursor */
        i := 1;
        For reg In curep(regformar.type_register,
                         nucodform,
                         nucredit_bureau) Loop

          --Dependiendo del valor de field_type haga

          /* Si es de tipo NUMBER */
          If reg.field_type = 1 Then
            dbms_sql.define_column(cursor_name, i, val_number);
            /* Si es de tipo VARCHAR */
          Elsif reg.field_type = 2 Then
            dbms_sql.define_column(cursor_name,
                                   i,
                                   val_char,
                                   reg.number_length);

            /* Si es de tipo DATE */
          Elsif reg.field_type = 3 Then
            dbms_sql.define_column(cursor_name, i, val_date);
            fecha := to_number(to_char(val_date, 'yyyymmdd'));
          End If;

          -- Incremento
          i := i + 1;

          numreg := i - 1;

        End Loop;

        /* Ejecucion del cursor */
        inexec_sql := dbms_sql.execute(cursor_name);

        /* Si obtiene registros */
        Loop

          Exit When dbms_sql.fetch_rows(cursor_name) = 0;
          /* Inicializo la cadena */
          sbcadena := Null;
          /* Inicio loop numreg */
          For i In 1 .. numreg Loop

            /* Llamo a cursor curepor2 con parametros para saber el tipo de variable */
            Open curepor2(i,
                          regformar.type_register,
                          nucodform,
                          nucredit_bureau);
            Fetch curepor2
            /* Tipo de dato / longitu */
              Into sbnomcampo, sbtipodato, nulargo, nudatesc;

            /* Finalizo el cursor */
            Close curepor2;

            /* Si obtengo un tipo NUMBER haga */
            If sbtipodato = 1 Then
              dbms_sql.column_value(cursor_name, i, val_number);
              val_dato := val_number;
              /* Si obtengo un tipo VARCHAR haga */
            Elsif sbtipodato = 2 Then
              dbms_sql.column_value(cursor_name, i, val_char);
              val_dato := val_char;
              /* Si obtengo un tipo DATE haga */
            Elsif sbtipodato = 3 Then
              dbms_sql.column_value(cursor_name, i, val_date);
              fecha    := to_number(to_char(val_date, 'yyyymmdd'));
              val_dato := fecha;
            End If;

            If nudatesc = 1 Then
              sbcadena := sbcadena || lpad(nvl(val_dato, 0), nulargo, 0);
            Elsif nudatesc = 2 Then
              sbcadena := sbcadena ||
                          rpad(nvl(val_dato, ' '), nulargo, ' ');
            Elsif nudatesc = 3 Then
              sbcadena := sbcadena || lpad(nvl(val_dato, 0), nulargo, ' ');
            End If;

          /* Finalizo loop numreg */
          End Loop;
          If sbcadena Is Not Null Then
            utl_file.put_line(vnuadmarc, sbcadena);
            dbms_output.put_line(sbsentencia);
          End If;
          pro_actualizaavance;
        End Loop;

      End If;

      /* Para tipo de registro 3 haga */
      If (regformar.type_register = 3) Then
        sbsentencia := '9' || lpad(nutotalsend + 2, 8, 0) || lpad(0, 8, 0) ||
                       lpad(nutotalsend, 8, 0) || lpad(0, 8, 0);

        utl_file.put_line(vnuadmarc, sbsentencia);
        dbms_output.put_line(sbsentencia);
        pro_actualizaavance;
      End If;

    End Loop;
    utl_file.fclose(vnuadmarc);

    -- Se hace uso de las nuevas variables definidas en ld_renumbering. smunozSAO212518
    Update ld_renumbering
       Set flag_envio = 'S'
     Where flag_envio = 'N'
       And credit_bureau_id = nucredit_bureau;
    Commit;
    pkerrors.pop;
  Exception
    When nodata Then
      gsberrmsg := 'No Se Encontro Informacion que Reportar';
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           'No Se Encontro Informacion que Reportar',
                           v_mensaje_error);
      pkerrors.pop;
      sbnomlog  := 'Error_' || sbnomarlog;
      vnulogarc := utl_file.fopen(sbrutarep, sbnomlog, 'w');

      utl_file.put_line(vnulogarc, v_mensaje_error);
      dbms_output.put_line('No Se Encontro Informacion que Reportar');
      utl_file.fclose(vnulogarc);
      If utl_file.is_open(vnuadmarc) Then
        utl_file.fremove(sbrutarep, sbnomarc);
      End If;
      dbms_application_info.set_module(module_name => 'FIRAD',
                                       action_name => Null);
      errors.seterror(cnunull_attribute,
                      'No Se Encontro Informacion que Reportar');
      Raise ex.controlled_error;
    When confignotfound Then
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           'No Se Encontro Configuracion',
                           v_mensaje_error);
      pkerrors.pop;
      sbnomlog  := 'Error_' || sbnomarlog;
      vnulogarc := utl_file.fopen(sbrutarep, sbnomlog, 'w');
      utl_file.put_line(vnulogarc, v_mensaje_error);
      dbms_output.put_line('No Se Encontro Configuracion');
      utl_file.fclose(vnulogarc);
      If utl_file.is_open(vnuadmarc) Then
        utl_file.fremove(sbrutarep, sbnomarc);
      End If;
      dbms_application_info.set_module(module_name => 'FIRAD',
                                       action_name => Null);
      errors.seterror;
      Raise ex.controlled_error;
    When Others Then
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           Sqlerrm,
                           v_mensaje_error);
      pkerrors.pop;
      sbnomlog  := 'Error_' || sbnomarlog;
      vnulogarc := utl_file.fopen(sbrutarep, sbnomlog, 'w');
      utl_file.put_line(vnulogarc, v_mensaje_error);
      dbms_output.put_line('Se presento el error' || Sqlerrm);
      utl_file.fclose(vnulogarc);
      If utl_file.is_open(vnuadmarc) Then
        utl_file.fremove(sbrutarep, sbnomarc);
      End If;
      dbms_application_info.set_module(module_name => 'FIRAD',
                                       action_name => Null);
      errors.seterror;
      Raise ex.controlled_error;
  End;

  Procedure generateprintnovelty(nucredit_bureau ld_credit_bureau.credit_bureau_id%Type,
                                 nuformat_id     ld_reporting_format.format_id%Type) Is

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
     Nombre         : generateprintnovelty
        Descripcion    : Procedimiento encargado de la Generacion de
                         archivo para enviar Novedades.

        Parametros     :


        Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro                  Descripcion
          nucredit_bureau    Entrada              ld_credit_bureau.credit_bureau_id%Type       Codigo de la central de riesgo
          nuformat_id        Entrada              ld_reporting_format.format_id%Type           CODIGO DEL FORMATO


    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega
    19-08-2013      slemusSAO213256
    Se corrige el llenado de la variable nufecgen

    16-08-2013     kcienfuegosSAO212456
    Se modifican las excepciones, para incluir los mensajes del archivo de errores en ge_error_log
    16-08-2013    kcienfuegosSAO212460
    Se modifican el manejo de archivo de log, para que el nombre lleve la hora
     13-08-2013      slemusSAO213001
    *Se modifica la impresion de los reportes para que trabajen con el nuevo campo field_type_write
     que se crea en la tabla ld_reporting_format, que especifica la manera de esritura del campo en reporte.


    03-08-2013      smunozSAO212518
    Se realizan modificaciones para hacer uso de las nuevas columnas creadas en
    la tabla ld_novelty.
    Se realizan modificaciones para que se controle el ingreso de informacion
    dependiendo de la central que se esta procesando.

    29-07-2013      smunozSAO212456
    * Se envian los cursores curegformat curep curepor2 a nivel de declaracion del
    paquete ya que se usan en varias partes del paquete y es importante tenerlos
    unificados y asi facilite el mantenimiento.
    * Se eliminan los cursores del procedimiento.

    26-07-2013      smunozSAO212457
    Se ajusta el procedimiento para marcar el avance del proceso

    DD-MM-2013      usuarioSAO######
    Descripcion breve, precisa y clara de la modificacion realizada.

    *******************************************************************/
    -- Declara varibles para generacion del Archivo Plano
    cnunull_attribute Constant Number := 4705;
    vnuadmarc   utl_file.file_type;
    vnulogarc   utl_file.file_type;
    sbnomarc    Varchar2(100);
    sbnomlog    Varchar2(100);
    sbrutarep   Varchar2(200);
    nucodcifin  ld_general_parameters.numercial_value%Type;
    nucoddata   ld_general_parameters.numercial_value%Type;
    nucodentfin ld_general_parameters.numercial_value%Type;
    nucodform   ld_general_parameters.numercial_value%Type;

    cursor_name     Integer;
    i               Integer;
    inexec_sql      Integer;
    val_char        Varchar2(2000);
    val_dato        Varchar2(2000);
    val_number      Number;
    val_date        Date;
    numreg          Number := 0;
    sbcadena        Varchar2(32000);
    sbwhere         Varchar2(32000);
    sbsentencia     Varchar2(32000);
    v_mensaje_error Varchar2(1000); --                                   Mensaje de error
    sbnomarlog      Varchar2(100);
    sbtipodato      ld_reporting_format.field_type%Type;
    sbnomcampo      ld_reporting_format.field_report_name%Type;
    nulargo         ld_reporting_format.number_length%Type;
    nudatesc        ld_reporting_format.field_type_write%Type;
    nuformat        ld_reporting_format.format_id%Type;
    nufecgen        Number(8);
    sbdummy         ld_general_parameters.text_value%Type;
    nudummy         ld_general_parameters.numercial_value%Type;
    confignotfound Exception;
    nodata         Exception;
    sbnomemp    sistema.sistempr%Type;
    sbextarch   ld_general_parameters.text_value%Type;
    fecha       Number(8);
    nutotalsend Number(5);

  Begin

    /* Parametros pasados desde el FrameWork FWCPB de nombre FGRCP */

    pkerrors.push('ld_bcfilegeneration.generateprintnovelty');
    /* Ruta del archivo */
    provapatapa('RUTA_IMPRESION_NOVEDADES', 'S', nudummy, sbrutarep);
    provapatapa('EXTENSION_DE_ARCHIVO', 'S', nudummy, sbextarch);
    nufecgen := to_number(to_char(Sysdate, 'yyyymmdd'));

    Select sistempr Into sbnomemp From sistema Where sistcodi = 99;

    If nucredit_bureau = 1 Then
      provapatapa('CODIGO_DATACREDITO', 'N', nucoddata, sbdummy);
      provapatapa('CODIGO_FORMATO_NOVEDAD_DATA', 'N', nucodform, sbdummy);
      sbnomarc   := 'NOVEDADES-' || upper(sbnomemp);
      sbnomarlog := 'Log_NOVEDADES-' || upper(sbnomemp) || '_' || nufecgen || '-' ||
                    to_char(Sysdate, 'HH_MI_SS');
    Elsif nucredit_bureau = 2 Then

      provapatapa('ENTITY_TYPE', 'N', nucodentfin, sbdummy); --tipo de entidad
      provapatapa('CODIGO_CIFIN', 'N', nucodcifin, sbdummy);
      provapatapa('CODIGO_FORMATO_NOVEDAD_CIFIN', 'N', nucodform, sbdummy);
      sbnomarc   := 'C' || 'RS' || nucodentfin || nucodcifin || nufecgen;
      sbnomarlog := 'log_C' || 'RS' || nucodentfin || nucodcifin ||
                    nufecgen || '-' || to_char(Sysdate, 'HH_MI_SS');
    End If; -- If Nucredit_Bureau = 1 Then
    /* le asigno a la variable where la siguiente cadena */

    -- Se hace ajuste a las columnas usadas en la columna para que
    -- correspondan a las creadas en la tabla ld_novelty. smunozSAO212518
    sbwhere := ' where flag_envio = ''N'' and credit_bureau_id = ' ||
               nucredit_bureau;

    Begin
      Select Count(*)
        Into nutotalsend
        From ld_novelty
       Where flag_envio = 'N'
         And credit_bureau_id = nucredit_bureau;
    Exception
      When no_data_found Then
        nutotalsend := 0;
    End;

    If nutotalsend = 0 Then
      Raise nodata;
    End If;

    vnuadmarc := utl_file.fopen(sbrutarep,
                                sbnomarc || '.' || sbextarch,
                                'w');

    For regformar In curegformat(nuformat_id) Loop
      /* Inicializo sentencia dinamica */
      sbsentencia := 'select ';

      /* Obtengo columnas de la sentencia dinamica */
      For reg In curep(regformar.type_register, nucodform, nucredit_bureau) Loop
        nuformat    := reg.format_id;
        sbsentencia := sbsentencia || reg.field_report_name || ',';
      End Loop;

      If sbsentencia = 'select ' Then
        Raise confignotfound;
      End If;

      /* Paso la cadena almacenada en sbsentencia a minuscula */
      sbsentencia := lower(sbsentencia);

      /* Retiro la coma que tengo al final de la sentencia obtenida en la linea dentro del loop curep */
      sbsentencia := substr(sbsentencia, 1, length(sbsentencia) - 1);

      If (regformar.type_register = 1) Then

        sbsentencia := '1' || lpad(7, 2, 0) || lpad(nucodentfin, 3, 0) ||
                       lpad(nucodcifin, 3, 0) || '          ' || '02' ||
                       to_char(Sysdate, 'YYYYMMDD');

        utl_file.put_line(vnuadmarc, sbsentencia);
        dbms_output.put_line(sbsentencia);
        pro_actualizaavance;
      End If;

      /* Para tipo de registro 7 haga */
      If (regformar.type_register = 7) Then

        If sbsentencia = 'select ' Then
          Raise confignotfound;
        End If;

        /* contateno la tabla */
        sbsentencia := sbsentencia || ' FROM ld_novelty ';

        /* Concateno where con sbsentencia */
        sbsentencia := sbsentencia || sbwhere;

        /* Definicion del cursor */
        cursor_name := dbms_sql.open_cursor;

        /* Revision de sintaxis  */
        dbms_sql.parse(cursor_name, sbsentencia, 1);

        /* Definicion de columnas que se van a retornar del cursor */
        i := 1;
        For reg In curep(regformar.type_register,
                         nucodform,
                         nucredit_bureau) Loop

          --Dependiendo del valor de field_type haga

          /* Si es de tipo NUMBER */
          If reg.field_type = 1 Then
            dbms_sql.define_column(cursor_name, i, val_number);
            /* Si es de tipo VARCHAR */
          Elsif reg.field_type = 2 Then
            dbms_sql.define_column(cursor_name,
                                   i,
                                   val_char,
                                   reg.number_length);

            /* Si es de tipo DATE */
          Elsif reg.field_type = 3 Then
            dbms_sql.define_column(cursor_name, i, val_date);
            fecha := to_number(to_char(val_date, 'yyyymmdd'));
          End If;

          -- Incremento
          i := i + 1;

          numreg := i - 1;

        End Loop;

        /* Ejecucion del cursor */
        inexec_sql := dbms_sql.execute(cursor_name);

        /* Si obtiene registros */
        Loop

          Exit When dbms_sql.fetch_rows(cursor_name) = 0;
          /* Inicializo la cadena */
          sbcadena := Null;
          /* Inicio loop numreg */
          For i In 1 .. numreg Loop

            /* Llamo a cursor curepor2 con parametros para saber el tipo de variable */
            Open curepor2(i,
                          regformar.type_register,
                          nucodform,
                          nucredit_bureau);
            Fetch curepor2
            /* Tipo de dato / longitu */
              Into sbnomcampo, sbtipodato, nulargo, nudatesc;

            /* Finalizo el cursor */
            Close curepor2;

            /* Si obtengo un tipo NUMBER haga */
            If sbtipodato = 1 Then
              dbms_sql.column_value(cursor_name, i, val_number);
              val_dato := val_number;
              /* Si obtengo un tipo VARCHAR haga */
            Elsif sbtipodato = 2 Then
              dbms_sql.column_value(cursor_name, i, val_char);
              val_dato := val_char;
              /* Si obtengo un tipo DATE haga */
            Elsif sbtipodato = 3 Then
              dbms_sql.column_value(cursor_name, i, val_date);
              fecha    := to_number(to_char(val_date, 'yyyymm'));
              val_dato := fecha;
            End If;

            If nudatesc = 1 Then
              sbcadena := sbcadena || lpad(nvl(val_dato, 0), nulargo, 0);
            Elsif nudatesc = 2 Then
              sbcadena := sbcadena ||
                          rpad(nvl(val_dato, ' '), nulargo, ' ');
            Elsif nudatesc = 3 Then
              sbcadena := sbcadena || lpad(nvl(val_dato, 0), nulargo, ' ');
            End If;

          /* Finalizo loop numreg */
          End Loop;
          If sbcadena Is Not Null Then

            utl_file.put_line(vnuadmarc, sbcadena);
            dbms_output.put_line(sbcadena);
          End If;
          pro_actualizaavance;

        End Loop;

      End If;

      /* Para tipo de registro 3 haga */
      If (regformar.type_register = 3) Then
        sbsentencia := '9' || lpad(nutotalsend + 2, 8, 0) ||
                       lpad(0, 8, '0') || lpad(0, 8, '0') ||
                       lpad(nutotalsend, 8, 0);

        utl_file.put_line(vnuadmarc, sbsentencia);
        dbms_output.put_line(sbcadena);
        pro_actualizaavance;
      End If;

    End Loop;
    utl_file.fclose(vnuadmarc);

    -- Se hace uso de las nuevas columnas creadas en ld_novelty  que permiten
    -- identificar en realidad a que central estan asociados los registros.
    -- smunozSAO212518
    Update ld_novelty
       Set flag_envio = 'S'
     Where flag_envio = 'N'
       And credit_bureau_id = nucredit_bureau;

    Commit;
    pkerrors.pop;
  Exception
    When nodata Then
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           'No Se Encontro Informacion para Reportar.',
                           v_mensaje_error);
      pkerrors.pop;
      sbnomlog  := 'Error_' || sbnomarlog || '.txt';
      vnulogarc := utl_file.fopen(sbrutarep, sbnomlog, 'w');
      utl_file.put_line(vnulogarc,
                        'No Se Encontro Informacion para Reportar.');
      dbms_output.put_line('No Se Encontro Informacion para Reportar.');
      utl_file.fclose(vnulogarc);
      If utl_file.is_open(vnuadmarc) Then
        utl_file.fremove(sbrutarep, sbnomarc);
      End If;
      dbms_application_info.set_module(module_name => 'FIRAD',
                                       action_name => Null);
      ge_boerrors.seterrorcodeargument(2741,
                                       'No Se Encontro Informacion para Reportar.');
    When confignotfound Then
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           'No se Encontro Configuracion',
                           v_mensaje_error);
      pkerrors.pop;
      sbnomlog  := 'Error_' || sbnomarlog || '.txt';
      vnulogarc := utl_file.fopen(sbrutarep, sbnomlog, 'w');
      utl_file.put_line(vnulogarc, 'No se Encontro Configuracion');
      dbms_output.put_line('No se Encontro Configuracion');
      utl_file.fclose(vnulogarc);
      If utl_file.is_open(vnuadmarc) Then
        utl_file.fremove(sbrutarep, sbnomarc);
      End If;
      dbms_application_info.set_module(module_name => 'FIRAD',
                                       action_name => Null);
      ge_boerrors.seterrorcodeargument(2741,
                                       'No se Encontro Configuracion');

    When Others Then
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           Sqlerrm,
                           v_mensaje_error);
      pkerrors.pop;
      sbnomlog  := 'Error_' || sbnomarlog || '.txt';
      vnulogarc := utl_file.fopen(sbrutarep, sbnomlog, 'w');
      utl_file.put_line(vnulogarc, 'Se presento el error' || Sqlerrm);
      dbms_output.put_line('Se presento el error' || Sqlerrm);
      utl_file.fclose(vnulogarc);
      If utl_file.is_open(vnuadmarc) Then
        utl_file.fremove(sbrutarep, sbnomarc);
      End If;
      dbms_application_info.set_module(module_name => 'FIRAD',
                                       action_name => Null);
      ge_boerrors.seterrorcodeargument(2741,
                                       'Se presento el error' || Sqlerrm);
  End;

  Procedure generateprintblocked(nucredit_bureau ld_credit_bureau.credit_bureau_id%Type,
                                 nuformat_id     ld_reporting_format.format_id%Type) Is

    /**************************************************************************
    Nombre         : generateprintblocked
    Descripcion    : Procedimiento encargado de la Generacion de archivo de bloqueados.

    Parametros     :


    Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro                 Descripcion
     nucredit_bureau    Entrada               ld_credit_bureau.credit_bureau_id%Type      Codigo de la central de riesgo
     nuformat_id        Entrada               ld_reporting_format.format_id%Type          CODIGO DEL FORMATO

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    16-08-2013      kcienfuegosSAO212456
    Se modifican las excepciones, para incluir los mensajes del archivo de errores en ge_error_log

    16-08-2013    kcienfuegosSAO212460
    Se modifican el manejo de archivo de log, para que el nombre lleve la hora

    13-08-2013      slemusSAO213001
    *Se modifica la impresion de los reportes para que trabajen con el nuevo campo field_type_write
     que se crea en la tabla ld_reporting_format, que especifica la manera de esritura del campo en reporte.

    29-07-2013      smunozSAO212456
    * Se envian los cursores curegformat curep curepor2 a nivel de declaracion del
    paquete ya que se usan en varias partes del paquete y es importante tenerlos
    unificados y asi facilite el mantenimiento.
    * Se eliminan los cursores del procedimiento.

    26-07-2013      smunozSAO212457
    Se ajusta el procedimiento para marcar el avance del proceso

    10-08-2013      kcienfuegosSAO212068
    Se cambia de lugar la invocacion del procedimiento Pro_Actualizaavance dentro del loop
    Se agrega el parametro RUTA_IMPRESION_FRENADOS para la ruta de frenados

    DD-MM-2013      usuarioSAO######
    Descripcion breve, precisa y clara de la modificacion realizada.

    *************************************************************************/

    -- Declara varibles para generacion del Archivo Plano
    cnunull_attribute Constant Number := 4705;
    vnuadmarc   utl_file.file_type;
    vnulogarc   utl_file.file_type;
    sbnomarc    Varchar2(100);
    sbnomarlog  Varchar2(100);
    sbnomlog    Varchar2(100);
    sbrutarep   Varchar2(200);
    nucoddata   ld_general_parameters.numercial_value%Type;
    nucodform   ld_general_parameters.numercial_value%Type;
    cursor_name Integer;
    i           Integer;
    inexec_sql  Integer;
    val_char    Varchar2(2000);
    val_number  Number;
    val_dato    Varchar2(2000);
    val_date    Date;
    numreg      Number := 0;
    sbcadena    Varchar2(32000);
    sbwhere     Varchar2(32000);
    sbsentencia Varchar2(32000);
    sbtipodato  ld_reporting_format.field_type%Type;
    sbnomcampo  ld_reporting_format.field_report_name%Type;
    nulargo     ld_reporting_format.number_length%Type;
    nudatesc    ld_reporting_format.field_type_write%Type;
    nuformat    ld_reporting_format.format_id%Type;
    nufecgen    Number(8);
    sbdummy     ld_general_parameters.text_value%Type;
    nudummy     ld_general_parameters.numercial_value%Type;
    sbnomemp    sistema.sistempr%Type;
    sbextarch   ld_general_parameters.text_value%Type;
    nublockcode ld_blocked.blocked_id%Type;
    confignotfound Exception;
    nodata         Exception;
    fecha Number(8);

  Begin

    /* Parametros pasados desde el FrameWork FWCPB de nombre FGRCP */

    pkerrors.push('ld_bcfilegeneration.generateprintblocked');
    /* Ruta del archivo */
    provapatapa('RUTA_IMPRESION_FRENADOS', 'S', nudummy, sbrutarep);
    provapatapa('EXTENSION_DE_ARCHIVO', 'S', nudummy, sbextarch);
    nufecgen := to_number(to_char(Sysdate, 'yyyymmdd'));

    Select sistempr Into sbnomemp From sistema Where sistcodi = 99;

    If nucredit_bureau = 1 Then
      provapatapa('CODIGO_DATACREDITO', 'N', nucoddata, sbdummy);
      provapatapa('CODIGO_FORMATO_BLOQUEADOS_DATA',
                  'N',
                  nucodform,
                  sbdummy);
      sbnomarc   := 'FRENADOS-' || upper(sbnomemp) || '-' || nufecgen;
      sbnomarlog := 'FRENADOS-' || nucoddata || '_' || nufecgen || '_' ||
                    to_char(Sysdate, 'HH:MI:SS');
      Select Max(blocked_id)
        Into nublockcode
        From ld_blocked b
       Where b.credit_bureau = 1
         And managed = 'G';

      /* le asigno a la variable where la siguiente cadena */
      sbwhere := ' where blocked_id = ' || nublockcode;

      If nublockcode Is Null Then
        Raise nodata;
      End If;

      ut_trace.trace('Centrales de Riesgos ' || nucredit_bureau, 1);
      ut_trace.trace('Formato de Central ' || nuformat_id, 2);

      /* Elsif nucredit_bureau = 2 Then

      provapatapa('CODIGO_CIFIN', 'N', nucodcifin, sbdummy);
      provapatapa('CODIGO_ENTIDAD_CIFIN', 'N', nucodentfin, sbdummy);
      provapatapa('CODIGO_FORMATO_NOVEDAD_CIFIN', 'N', nucodform, sbdummy);
      sbnomarc := 'C' || 'RS' || nucodentfin || nucodcifin || nufecgen;

      If nutotalsend = 0 Then
        Raise nodata;
      End If;

      \* le asigno a la variable where la siguiente cadena *\
      sbwhere := ' where flag_envio_cifin  = ''N''';*/

    End If;

    vnuadmarc := utl_file.fopen(sbrutarep,
                                sbnomarc || '.' || sbextarch,
                                'w');

    For regformar In curegformat(nuformat_id) Loop
      /* Inicializo sentencia dinamica */
      sbsentencia := 'select ';

      /* Obtengo columnas de la sentencia dinamica */
      For reg In curep(regformar.type_register, nucodform, nucredit_bureau) Loop
        nuformat    := reg.format_id;
        sbsentencia := sbsentencia || reg.field_report_name || ',';
      End Loop;

      /* Paso la cadena almacenada en sbsentencia a minuscula */
      sbsentencia := lower(sbsentencia);

      /* Retiro la coma que tengo al final de la sentencia obtenida en la linea dentro del loop curep */
      sbsentencia := substr(sbsentencia, 1, length(sbsentencia) - 1);
      ut_trace.trace('Sentencia ' || sbsentencia, 3);

      If (regformar.type_register = 1) Then

        pro_actualizaavance;

        Select header
          Into sbsentencia
          From ld_blocked
         Where blocked_id = nublockcode;

        utl_file.put_line(vnuadmarc, sbsentencia);
        dbms_output.put_line(sbsentencia);

      End If;

      /* Para tipo de registro 5 haga */
      If (regformar.type_register = 5) Then

        If sbsentencia = 'select ' Then
          Raise confignotfound;
        End If;

        /* contateno la tabla */
        sbsentencia := sbsentencia || ' FROM ld_blocked_detail ';

        /* Concateno where con sbsentencia */
        sbsentencia := sbsentencia || sbwhere;

        /* Definicion del cursor */
        cursor_name := dbms_sql.open_cursor;

        /* Revision de sintaxis  */
        dbms_sql.parse(cursor_name, sbsentencia, 1);

        /* Definicion de columnas que se van a retornar del cursor */
        i := 1;
        For reg In curep(regformar.type_register,
                         nucodform,
                         nucredit_bureau) Loop

          --Dependiendo del valor de field_type haga

          /* Si es de tipo NUMBER */
          If reg.field_type = 1 Then
            dbms_sql.define_column(cursor_name, i, val_number);
            /* Si es de tipo VARCHAR */
          Elsif reg.field_type = 2 Then
            dbms_sql.define_column(cursor_name,
                                   i,
                                   val_char,
                                   reg.number_length);

            /* Si es de tipo DATE */
          Elsif reg.field_type = 3 Then
            dbms_sql.define_column(cursor_name, i, val_date);
            fecha := to_number(to_char(val_date, 'yyyymmdd'));
          End If;

          -- Incremento
          i := i + 1;

          numreg := i - 1;

        End Loop;

        /* Ejecucion del cursor */
        inexec_sql := dbms_sql.execute(cursor_name);

        /* Si obtiene registros */
        Loop

          Exit When dbms_sql.fetch_rows(cursor_name) = 0;

          /*Actualizo el numero de registros procesados*/
          pro_actualizaavance;

          /* Inicializo la cadena */
          sbcadena := Null;
          /* Inicio loop numreg */
          For i In 1 .. numreg Loop

            /* Llamo a cursor curepor2 con parametros para saber el tipo de variable */
            Open curepor2(i,
                          regformar.type_register,
                          nucodform,
                          nucredit_bureau);
            Fetch curepor2
            /* Tipo de dato / longitu */
              Into sbnomcampo, sbtipodato, nulargo, nudatesc;

            /* Finalizo el cursor */
            Close curepor2;

            /* Si obtengo un tipo NUMBER haga */
            If sbtipodato = 1 Then
              dbms_sql.column_value(cursor_name, i, val_number);
              val_dato := val_number;
              /* Si obtengo un tipo VARCHAR haga */
            Elsif sbtipodato = 2 Then
              dbms_sql.column_value(cursor_name, i, val_char);
              val_dato := val_char;
              /* Si obtengo un tipo DATE haga */
            Elsif sbtipodato = 3 Then
              dbms_sql.column_value(cursor_name, i, val_date);
              fecha    := to_number(to_char(val_date, 'yyyymmdd'));
              val_dato := fecha;
            End If;

            If val_dato = '00057404376' Then
              Null;
            End If;

            If val_dato Is Not Null Then
              If nudatesc = 1 Then
                If sbcadena Is Not Null Then
                  sbcadena := sbcadena || '|' ||
                              lpad(nvl(val_dato, 0), nulargo, 0);
                Else
                  sbcadena := lpad(nvl(val_dato, 0), nulargo, 0);
                End If;
              Elsif nudatesc = 2 Then
                If sbcadena Is Not Null Then
                  sbcadena := sbcadena || '|' ||
                              rpad(nvl(upper(val_dato), ' '), nulargo, ' ');
                Else
                  sbcadena := rpad(nvl(upper(val_dato), ' '), nulargo, ' ');
                End If;
              End If;
            Else
              /* If Nudatesc = 1 Then
                Sbcadena := Sbcadena || Lpad(Nvl(Val_Dato, 0), Nulargo, 0);
              Elsif Nudatesc = 2 Then*/
              sbcadena := sbcadena ||
                          rpad(nvl(upper(val_dato), ' '), nulargo, ' ');

              --End If;
            End If;

          /* Finalizo loop numreg */
          End Loop;

          If sbcadena Is Not Null Then
            utl_file.put_line(vnuadmarc, sbcadena);
            dbms_output.put_line(sbcadena);
          End If;

        End Loop;

      End If;

    End Loop;

    utl_file.fclose(vnuadmarc);
    If nucredit_bureau = 1 Then
      Update ld_blocked Set managed = 'I' Where blocked_id = nublockcode;
    End If;

    Commit;
    pkerrors.pop;
  Exception
    When nodata Then
      pkerrors.pop;
      sbnomlog := 'ErrorLog_' || sbnomarlog || '.txt';
      --archivo
      vnulogarc := utl_file.fopen(sbrutarep, sbnomlog, 'w');
      utl_file.put_line(vnulogarc,
                        'No Se Encontro Informacion para Imprimir.');
      dbms_output.put_line('No Se Encontro Informacion para Imprimir.');
      utl_file.fclose(vnulogarc);

      If utl_file.is_open(vnuadmarc) Then
        utl_file.fremove(sbrutarep, sbnomarc);
      End If;
      dbms_application_info.set_module(module_name => 'FIRAD',
                                       action_name => Null);
      errors.seterror(cnunull_attribute,
                      'No Se Encontro Informacion que Reportar');
      Raise ex.controlled_error;
    When confignotfound Then
      pkerrors.pop;
      sbnomlog  := 'ErrorLog_' || sbnomarlog || '.txt';
      vnulogarc := utl_file.fopen(sbrutarep, sbnomlog, 'w');
      utl_file.put_line(vnulogarc, 'No se Encontro Configuracion');
      dbms_output.put_line('No se Encontro Configuracion');
      utl_file.fclose(vnulogarc);
      If utl_file.is_open(vnuadmarc) Then
        utl_file.fremove(sbrutarep, sbnomarc);
      End If;
      dbms_application_info.set_module(module_name => 'FIRAD',
                                       action_name => Null);
      errors.seterror(cnunull_attribute, 'No se Encontro Configuracion');
      Raise ex.controlled_error;
    When Others Then
      pkerrors.pop;
      sbnomlog  := 'ErrorLog_' || sbnomarlog || '.txt';
      vnulogarc := utl_file.fopen(sbrutarep, sbnomlog, 'w');
      utl_file.put_line(vnulogarc, 'Se presento el error' || Sqlerrm);
      dbms_output.put_line('Se presento el error' || Sqlerrm);
      utl_file.fclose(vnulogarc);
      If utl_file.is_open(vnuadmarc) Then
        utl_file.fremove(sbrutarep, sbnomarc);
      End If;
      dbms_application_info.set_module(module_name => 'FIRAD',
                                       action_name => Null);
      errors.seterror;
      Raise ex.controlled_error;
  End;

  Function fboupdatereport(indate     ld_random_sample.generation_date%Type,
                           inusector  ld_random_sample.type_sector%Type,
                           inuproduct ld_sample.type_product_id%Type)
    Return Boolean Is

    /****************************************************************
    Nombre         : fboupdatereport
       Descripcion    : Procedimiento encargado de la Generacion de
                        archivo para actualizar flag de impresion.

       Parametros     :


       Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro                 Descripcion
        indate             Entrada              ld_random_sample.generation_date%Type        FECHA DE LA GENERACION DE LA MUESTRA ALEATORIA
        inusector          Entrada              ld_random_sample.type_sector%Type            TIPO DE SECTOR: COMERCIAL o SERVICIOS
        inuproduct         Entrada              ld_sample.type_product_id%Type               TIPO DE PRODUCTO
    *********************************************************************/

    gsberrmsg ge_error_log.description%Type;
    nosample Exception;

  Begin
    pkerrors.push('ld_bcfilegeneration.fboupdatereport');
    Update ld_sample
       Set flag = 'S'
     Where generation_date = indate
       And type_sector = inusector
       And type_product_id = inuproduct;
    pkerrors.pop;
    If Sql%Notfound Then
      Return(False);
    Else
      Return(True);
    End If;
  Exception
    When Others Then
      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  End;

  Function fsbversion Return Varchar2 Is
    /*********************************************************************
     Nombre         :  fsbversion
        Descripcion    : Funcion encargada de Retornar el SAO con que se realizo la ultima entrega del paquete

        Parametros     :


        Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro            Descripcion

    *********************************************************************/

  Begin
    --{
    -- Retorna el SAO con que se realizo la ultima entrega del paquete
    Return(csbversion);
    --}
  End fsbversion;

  Procedure pbogeneratefile(sbcredit_bureau Varchar2, sbformat_id Varchar2) Is

    /**********************************************************************
     Nombre         :  pbogeneratefile
        Descripcion    : Procedimiento Encargado de generar un archivo

        Parametros     :


        Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro            Descripcion


    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega
     01-08-2013      JsilveraSAO212461
     * Se actualiza procedimiento Proouploadfileincons para recibir parametros de entrada que le enviara el Proceso Stand alone de
       FPMIC. Esto se realizo porque se necesitaba que el aplicativo no quedara bloqueado una vez este proceso se
       ejecutara. Se queria liberar pantalla despues de que el usuario presionara el boton Procesar.
    * Creacion del Proceso  Provalidaproprogramado
    * Manejo de Log de Proceso. Secrea un archivo para identificar si el proceso de carga se realizo de forma exitosa o no.


    26-07-2013      smunozSAO212457
    Se ajusta el procedimiento para marcar el avance del proceso

    DD-MM-2013      usuarioSAO######
    Descripcion breve, precisa y clara de la modificacion realizada.

    ************************************************************************/

    -- Constantes
    cnunull_attribute Constant Number := 2126;

    -- Variables

    gsberrmsg      ge_error_log.description%Type;
    v_seq_estaprog Number; -- Secuencia con la que se crea el programa en estalog
    v_programa     estaprog.esprprog%Type := 'FIRAD'; -- Nombre del proceso

    -- Excepciones
    nosample Exception;
  Begin
    pkerrors.push('ld_bcfilegeneration.pbogeneratefile');

    /*Se inicializa el atributo donde se almacenara el id de la secuencia de la entidad estaprog*/
    v_seq_estaprog := sqesprprog.nextval;
    g_program_id   := v_programa || v_seq_estaprog;

    ------------------------------------------------
    -- Required Attributes
    -----------------------------e-------------------

    If (sbcredit_bureau Is Null) Then
      errors.seterror(cnunull_attribute, 'Central de Riesgo');
      Raise ex.controlled_error;
    End If;

    If (sbformat_id Is Null) Then
      errors.seterror(cnunull_attribute, 'Tipo de Formato');
      Raise ex.controlled_error;
    End If;

    -- Calculo del numero de registros a procesar
    g_reg_a_procesar := f_registros_a_procesar_firad(p_credit_bureau => sbcredit_bureau,
                                                     p_formato       => sbformat_id);

    -- Iniciar el registro en estaprog indicando el numero de registros a procesar
    pkstatusexeprogrammgr.addrecord(g_program_id,
                                    'Proceso en ejecucion ...',
                                    g_reg_a_procesar);
    pkgeneralservices.committransaction;

    -- Calcular el numero de registros que corresponden al 1% del total de registros a procesar
    pro_uno_por_ciento;

    If sbformat_id In (4, 5) Then
      generateprintrenumbering(sbcredit_bureau, sbformat_id);
    Elsif sbformat_id In (6, 7) Then
      generateprintnovelty(sbcredit_bureau, sbformat_id);
    Elsif sbformat_id In (8) Then
      generateprintblocked(sbcredit_bureau, sbformat_id);
    End If;

    -- Actualiza el registro de seguimiento del proceso en ESTAPROG a Terminado OK
    pro_actualizaavance(p_fin_proceso => 'S');
    pkstatusexeprogrammgr.processfinishok(g_program_id);
    -- Finaliza la transaccion del proceso
    pkgeneralservices.committransaction;
    pkerrors.pop;
  Exception
    When Others Then
      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pro_actualizaavance(p_fin_proceso => 'S');
      pkstatusexeprogrammgr.processfinishnok(g_program_id, gsberrmsg);
      pkgeneralservices.committransaction;
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  End;

  Function ldvalidategeneration(nusample ld_sample.sample_id%Type)
    Return Number Is

    /***********************************************************************

        Nombre         :  ldvalidategeneration
        Descripcion    : Funcion encargada de validar si existe  la informacion en la entidad ld_sample_fin

        Parametros     :


        Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro            Descripcion
           nusample          Entrada              ld_sample.sample_id%Type               CODIGO DE LA MUESTRA

    *************************************************************************/
    nuexiste Number;
  Begin
    pkerrors.push('ld_bcfilegeneration.ldvalidategeneration');
    Select Count(*)
      Into nuexiste
      From ld_sample_fin
     Where sample_id = nusample;
    pkerrors.pop;
    Return nuexiste;

  End;
  Procedure provalidaproprogramado Is
    /****************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Nombre         :  Provalidaproprogramado
    Descripcion    : Procso que se encarga de realizar las validaciones necesarias de las variables o
    parametros de la pantalla de ejecucion de este proceso

    Parametros     :

    Nombre Parametro  Tipo de Parametro        Tipo de dato del parametro            Descripcion



    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    01-08-2013      JsilveraSAO212461
    * Creacion del Proceso  Provalidaproprogramado
    *****************************************************************************/

    cnunull_attribute Constant Number := 2126;

    sbcredit_bureau ge_boinstancecontrol.stysbvalue;
    sbsector_type   ge_boinstancecontrol.stysbvalue;
    sbsample_id     ge_boinstancecontrol.stysbvalue;
  Begin
    sbcredit_bureau := ge_boinstancecontrol.fsbgetfieldvalue('LD_SAMPLE_CONT',
                                                             'CREDIT_BUREAU');
    sbsector_type   := ge_boinstancecontrol.fsbgetfieldvalue('LD_SAMPLE_CONT',
                                                             'SECTOR_TYPE');
    sbsample_id     := ge_boinstancecontrol.fsbgetfieldvalue('LD_SAMPLE_CONT',
                                                             'SAMPLE_ID');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    If (sbcredit_bureau Is Null) Then
      errors.seterror(cnunull_attribute, 'Central de Riesgo');
      Raise ex.controlled_error;
    End If;

    If (sbsector_type Is Null) Then
      errors.seterror(cnunull_attribute, 'Sector');
      Raise ex.controlled_error;
    End If;

    If (sbsample_id Is Null) Then
      errors.seterror(cnunull_attribute, 'Id. Reporte Maestro');
      Raise ex.controlled_error;
    End If;

    ------------------------------------------------
    -- User code
    ------------------------------------------------

  Exception
    When ex.controlled_error Then
      Raise;

    When Others Then
      errors.seterror;
      Raise ex.controlled_error;
  End provalidaproprogramado;

  Procedure provalidaproprogramadofirad Is
    /****************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Nombre         :  ProvalidaproprogramadoFIRAD
    Descripcion    : Procso que se encarga de realizar las validaciones necesarias de las variables o
    parametros de la pantalla de ejecucion de este proceso

    Parametros     :

    Nombre Parametro  Tipo de Parametro        Tipo de dato del parametro            Descripcion



    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    01-08-2013      JsilveraSAO212461
    * Creacion del Proceso  Provalidaproprogramado
    *****************************************************************************/

    cnunull_attribute Constant Number := 2126;

    sbcredit_bureau_id ge_boinstancecontrol.stysbvalue;
    sbid_format        ge_boinstancecontrol.stysbvalue;

  Begin
    sbcredit_bureau_id := ge_boinstancecontrol.fsbgetfieldvalue('LD_CREDIT_BUREAU',
                                                                'CREDIT_BUREAU_ID');
    sbid_format        := ge_boinstancecontrol.fsbgetfieldvalue('LD_TYPE_FORMAT',
                                                                'ID_FORMAT');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    If (sbcredit_bureau_id Is Null) Then
      errors.seterror(cnunull_attribute, 'Central de Riesgo');
      Raise ex.controlled_error;
    End If;

    If (sbid_format Is Null) Then
      errors.seterror(cnunull_attribute, 'Formato');
      Raise ex.controlled_error;
    End If;

    ------------------------------------------------
    -- User code
    ------------------------------------------------

  Exception
    When ex.controlled_error Then
      Raise;

    When Others Then
      errors.seterror;
      Raise ex.controlled_error;
  End provalidaproprogramadofirad;

End ld_bcfilegeneration;
/
GRANT EXECUTE on LD_BCFILEGENERATION to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LD_BCFILEGENERATION to REXEOPEN;
GRANT EXECUTE on LD_BCFILEGENERATION to RSELSYS;
/
