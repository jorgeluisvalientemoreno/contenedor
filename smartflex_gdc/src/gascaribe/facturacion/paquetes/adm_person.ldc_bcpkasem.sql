CREATE OR REPLACE PACKAGE adm_person.ldc_bcpkasem
AS
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  20/06/2024   Adrianavg   OSF-2848: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
    PROCEDURE PRASEM;


END LDC_BCPKASEM;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BCPKASEM
AS

  ------------------------------------------------------------------------
  PROCEDURE PRASEM
  IS

      /*****************************************************************
      Propiedad intelectual de Efigas-Gascaribe.

      Nombre del Paquete: LDC_BCPKASEM
      Descripcion: Proceso que permite actualizar medidores

      Autor  : Ing.Viviana Barrag?n G?mez, Horbath Technologies.
      Fecha  : 18-05-2016 (Fecha Creacion Paquete)  No Tiquete CA 200-156

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.        Modificacion
      -----------  -------------------    -------------------------------------

      ******************************************************************/
      nusession               NUMBER;                                     --Numero de sesion
      cnuNULL_ATTRIBUTE constant number := 2126;

      sbPRODUCT_ID ge_boInstanceControl.stysbValue;
      sbELMECODI ge_boInstanceControl.stysbValue;

      sbexisteELEMMEDI          varchar2(50);
      sbexisteGE_ITEMS_SERIADO  varchar2(50);
      sbexisteELMESESU          varchar2(50);

      sbmedidorerrado           varchar2(50);
      sbmedidorUO1              varchar2(50);

      dtfechaSalida             date;
      dtfechaInsta              date;


      -- Cursor tabla ELEMMEDI
      CURSOR cuELEMMEDI(isbElem_medi VARCHAR2)
      IS
      select e.elmecodi
      from ELEMMEDI e
      where e.elmecodi = isbElem_medi;

      -- Cursor tabla GE_ITEMS_SERIADO
      CURSOR cuGE_ITEMS_SERIADO (isbElem_medi VARCHAR2)
      IS
      select g.serie
      from GE_ITEMS_SERIADO g
      where g.serie = isbElem_medi;

      --Cursor tabla ELMESESU
      CURSOR cuELMESESU (isbElem_medi VARCHAR2)
      IS
      SELECT e.emsscoem
      FROM ELMESESU E
      WHERE E.EMSSCOEM = isbElem_medi;

      --Medidor errado
      CURSOR cuMedidorerrado (inuProducto number)
      IS
      SELECT e.emsscoem, e.emssfein
      FROM ELMESESU E
      WHERE E.EMSSSESU = inuProducto;

      --Medidor de la unidad operativa
      CURSOR cuMedidorUO (inuProducto number)
      IS
      select g.serie
      from GE_ITEMS_SERIADO g
      where g.numero_servicio = inuProducto
        and g.operating_unit_id = open.dald_parameter.fnuGetNumeric_Value('UNIDAD_OPER_200156')
        and ','||open.dald_parameter.fsbgetvalue_chain('ESTADO_DISPONIBLE_200156')||',' LIKE '%,'||to_char(g.id_items_estado_inv)||',%';


  BEGIN
       --Dbms_Output.Put_Line('LA TABLA A BORRAR NO EXISTE');
      --Control de registro que inicio y fin satisfactorio del proceso
      SELECT userenv('sessionid') INTO nusession FROM dual;
      ldc_proinsertaestaprog(to_number(to_char(sysdate,'YYYY')),to_number(to_char(sysdate,'MM')),'PRASEM','Inicia ejecucion..',nusession,USER);

      --Obtenemos los datos que vienen de filtro del PB
     sbPRODUCT_ID := ge_boInstanceControl.fsbGetFieldValue ('PR_PRODUCT', 'PRODUCT_ID');
     sbELMECODI := ge_boInstanceControl.fsbGetFieldValue ('ELEMMEDI', 'ELMECODI');

      --Validacion de atributos o filtros requeridos:
      if (sbPRODUCT_ID is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'C?digo del Producto');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (sbELMECODI is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'C?digo del Elemento de Medici?n');
        raise ex.CONTROLLED_ERROR;
    end if;
      -----------------------------------------------
      --Cuerpo
      -----------------------------------------------

      dtfechaSalida := to_date(open.dald_parameter.fsbgetvalue_chain('FECHA_SALIDA_ENVIVOEFG')) ;

      FOR dtDatos1 in cuELEMMEDI (sbELMECODI) loop
        sbexisteELEMMEDI := dtDatos1.Elmecodi;
      END LOOP;

      FOR dtDatos2 in cuGE_ITEMS_SERIADO (sbELMECODI) loop
        sbexisteGE_ITEMS_SERIADO := dtDatos2.Serie;
      END LOOP;

      FOR dtDatos3 in cuELMESESU (sbELMECODI) loop
        sbexisteELMESESU := dtDatos3.Emsscoem;
      END LOOP;

      FOR dtDatos4 in cuMedidorerrado (to_number(sbPRODUCT_ID)) loop
        sbmedidorerrado := dtDatos4.Emsscoem;
        dtfechaInsta    := dtDatos4.Emssfein;
      END LOOP;

      IF dtfechaInsta < dtfechaSalida THEN

      IF (sbexisteELEMMEDI IS NULL
         AND sbexisteGE_ITEMS_SERIADO IS NULL
         AND sbexisteELMESESU IS NULL) THEN

         UPDATE OPEN.GE_ITEMS_SERIADO SET  SERIE=sbELMECODI WHERE SERIE=sbmedidorerrado;
         UPDATE OPEN.ELMESESU SET EMSSCOEM=sbELMECODI WHERE EMSSCOEM=sbmedidorerrado;
         UPDATE OPEN.ELEMMEDI SET  ELMECODI=sbELMECODI WHERE ELMECODI=sbmedidorerrado;
         commit;
      else

      FOR dtDatos5 in cuMedidorUO (to_number(sbPRODUCT_ID)) loop
        sbmedidorUO1 := dtDatos5.Serie;
      END LOOP;

      IF sbmedidorUO1 IS NOT NULL THEN

        UPDATE OPEN.GE_ITEMS_SERIADO SET  SERIE='123-inter' WHERE SERIE=sbmedidorUO1;
        UPDATE OPEN.GE_ITEMS_SERIADO SET  SERIE=sbmedidorUO1 WHERE SERIE=sbmedidorerrado;
        UPDATE OPEN.GE_ITEMS_SERIADO SET  SERIE=sbmedidorerrado WHERE SERIE='123-inter' AND ID_ITEMS_ESTADO_INV =open.dald_parameter.fsbgetvalue_chain('ESTADO_OBSOLETO_200156');

        UPDATE OPEN.ELMESESU SET EMSSCOEM=sbmedidorUO1 WHERE EMSSCOEM=sbmedidorerrado;

        UPDATE OPEN.ELEMMEDI SET  ELMECODI='123-inter' WHERE ELMECODI=sbmedidorUO1;
        UPDATE OPEN.ELEMMEDI SET  ELMECODI=sbmedidorUO1 WHERE ELMECODI=sbmedidorerrado;
        UPDATE OPEN.ELEMMEDI SET  ELMECODI=sbmedidorerrado WHERE ELMECODI='123-inter';

        commit;
      END IF;
      end if;
      ELSE
        Dbms_Output.Put_Line('LA FECHA DE INSTALACI?N DEBE SER MENOR A LA FECHA DE SALIDA EN VIVO');
        RAISE_APPLICATION_ERROR(-20010,'LA FECHA DE INSTALACI?N DEBE SER MENOR A LA FECHA DE SALIDA EN VIVO ');
      END IF;


      --Se indica en la tabla de estado de proceso que termina
      ldc_proactualizaestaprog(nusession,'Proceso Finalizado','PRASEM','Ok');



  EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
      ldc_proactualizaestaprog(nusession,SUBSTR('ERROR: '||sqlerrm,1,2000),'PRASEM','Termino con Error');

  WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
      ldc_proactualizaestaprog(nusession,SUBSTR('ERROR: '||sqlerrm,1,2000),'PRASEM','Termino con Error');
  END PRASEM;



  ------------------------------------------------------------------------

END LDC_BCPKASEM;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_BCPKASEM
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BCPKASEM', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_BCPKASEM
GRANT EXECUTE ON ADM_PERSON.LDC_BCPKASEM TO REXEREPORTES;
/