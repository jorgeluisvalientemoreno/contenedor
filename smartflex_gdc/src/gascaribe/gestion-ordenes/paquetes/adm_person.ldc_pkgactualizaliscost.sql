CREATE OR REPLACE PACKAGE adm_person.LDC_PKGACTUALIZALISCOST IS

	/******************************************************************************************
	Autor: Miguel Ballesteros / Horbath
	Fecha: 23-04-2021
	Ticket: 200-2433
	Descripcion: 	Paquete que contiene los metodos para el PB LDCALCI

	Historia de modificaciones
	Fecha		Autor			Descripcion
	25/06/2024  PAcosta         OSF-2878: Cambio de esquema ADM_PERSON
    26-07-2021	horbath			Ajustes a la funcion FRCGETLISTACOSTVIG para que permita la
								consulta por tipo de incremento cuando el nivel es 4-Unidad Operativa

	******************************************************************************************/

    dtFecha_Inicial VARCHAR2(100);
    nivel NUMBER;

    FUNCTION FRCGETLISTACOSTVIG
    RETURN  PKCONSTANTE.TYREFCURSOR ;

    PROCEDURE PRACTULISTACOST
    (
        inucodlp       In GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%type,
        inucurrent   In Number,
        inutotal     In Number,
        coderror Out ge_error_log.message_id%Type,
        messerror Out ge_error_log.description%Type
    );

    FUNCTION FSBVERSION
    RETURN VARCHAR2;
END LDC_PKGACTUALIZALISCOST;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGACTUALIZALISCOST IS

    CSBVERSION                  CONSTANT VARCHAR2(100) := 'OSS_HT_0000709_1';

    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END;

    FUNCTION FRCGETLISTACOSTVIG
    RETURN PKCONSTANTE.TYREFCURSOR
    IS
    /************************************************************************************************
    Propiedad Intelectual de HORBATH TECHNOLOGIES

    Funcion     :  LDCFULLGRID
    Descripcion :  Funcion que retorna las listas de costos de acuerdo al grupo seleccionado y la fecha inicial
	Ticket      : 200-2433
    Autor       : Miguel Ballesteros
    Fecha       : 23-04-2019

    Fecha       Autor       Modificaciones
    -----------------------------------------------------------
    27/07/2021  horbath      CA709: Se acondiciona sentencia de manera dinamica para poder obtener
                            registros con tipo de incremento cuando el nivel seleccionado es 4-Unidad Operativa
                            y se ha seleccionado el tipo de incremento en el PB LDCALCI
    **********************************************************************************************/

        sbProceso   VARCHAR2(500) := 'FRCGETLISTACOSTVIG';
        sbError     VARCHAR2(4000);
        cuLista     PKCONSTANTE.TYREFCURSOR;
        sbSql       VARCHAR2(4000);
        nuTipoInc   NUMBER;
        sbTipoInc   VARCHAR2(1);

    BEGIN
        nivel           := TO_NUMBER(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER_ITEMS', 'ORDER_ITEMS_ID'));
        dtFecha_Inicial   := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER', 'EXECUTION_FINAL_DATE');
        --inicio 709
		nuTipoInc       := TO_NUMBER(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('LDC_TIPOINC_BYCON', 'INCREMENT_TYPE'));
		--fin 709

        ut_trace.trace('INICIO ' || dtFecha_Inicial, 10);

		--inicio 709
        IF FBLAPLICAENTREGAXCASO('0000709') THEN
            IF (nivel = 4) THEN
                IF (nuTipoInc IS NOT NULL) THEN

                    SELECT decode(nuTipoInc,1,'I',2,'S',3,'N','O') INTO sbTipoInc
                    FROM DUAL;

                    sbSql := 'select  LIST_UNITARY_COST_ID codigo,
                           DESCRIPTION descripcion,
                           VALIDITY_START_DATE fecha_inicial,
                           VALIDITY_FINAL_DATE fecha_final,
                           OPERATING_UNIT_ID||'||''' - '''||'||DAOR_OPERATING_UNIT.FSBGETNAME(OPERATING_UNIT_ID,null) unidad,
                           CONTRACTOR_ID||'||''' - '''||'||DAGE_CONTRATISTA.FSBGETDESCRIPCION(CONTRACTOR_ID, null) contratista,
                           CONTRACT_ID||'||''' - '''||'||DAGE_CONTRATO.FSBGETDESCRIPCION(CONTRACT_ID,null) contrato,
                           GEOGRAP_LOCATION_ID||'||''' - '''||'||DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION(GEOGRAP_LOCATION_ID,null) localidad,
                           (SELECT DECODE(a.increment_type,'||'''I'''||','||'''IPC'''||','||'''S'''||','||'''SMMLV'''||','||'''N'''||','||'''NO APLICA'''||','||'''OTROS'''||' )
                           FROM ldc_tipoinc_bycon a, ldc_uo_bytipoinc b
                           WHERE a.id_contrato = b.id_contrato
                           AND b.operating_unit_id = gl.operating_unit_id
                           AND ROWNUM = 1) tipo_incremento
                           from GE_LIST_UNITARY_COST gl
                           where trunc(to_date('''||dtFecha_Inicial||''','||'''dd/mm/yyyy hh24:mi:ss'''||')) BETWEEN gl.VALIDITY_START_DATE AND  gl.VALIDITY_FINAL_DATE
                           and gl.OPERATING_UNIT_ID IN (SELECT b.operating_unit_id
                                                           FROM ldc_tipoinc_bycon a, ldc_uo_bytipoinc b
                                                           WHERE a.id_contrato = b.id_contrato
                                                           AND a.increment_type = '''||sbTipoInc||''')
                          order by LIST_UNITARY_COST_ID';

                    ut_trace.trace('dtFecha_Inicial: '||dtFecha_Inicial,1);
                    ut_trace.trace('sbTipoInc: '||sbTipoInc,1);
                    ut_trace.trace(sbSql,1);

                    OPEN cuLista FOR sbSql;

                ELSE
                    ge_boerrors.seterrorcodeargument
                    (
                        Ld_Boconstans.cnuGeneric_Error,
                        'Para consultar registros por nivel 4-Unidad Operativa debe seleccionar un tipo de incremento.'
                    );
                    RAISE ex.CONTROLLED_ERROR;
                END IF;
            ELSE
                sbSql := 'select  LIST_UNITARY_COST_ID codigo,
                       DESCRIPTION descripcion,
                       VALIDITY_START_DATE fecha_inicial,
                       VALIDITY_FINAL_DATE fecha_final,
                       OPERATING_UNIT_ID||'||''' - '''||'||DAOR_OPERATING_UNIT.FSBGETNAME(OPERATING_UNIT_ID,null) unidad,
                       CONTRACTOR_ID||'||''' - '''||'||DAGE_CONTRATISTA.FSBGETDESCRIPCION(CONTRACTOR_ID, null) contratista,
                       CONTRACT_ID||'||''' - '''||'||DAGE_CONTRATO.FSBGETDESCRIPCION(CONTRACT_ID,null) contrato,
                       GEOGRAP_LOCATION_ID||'||''' - '''||'||DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION(GEOGRAP_LOCATION_ID,null) localidad, '||
                       '''-'''||'tipo_incremento
                       from GE_LIST_UNITARY_COST gl
                       where trunc(to_date('''||dtFecha_Inicial||''','||'''dd/mm/yyyy hh24:mi:ss'''||')) BETWEEN gl.VALIDITY_START_DATE AND  gl.VALIDITY_FINAL_DATE
                       and ( (case when ('||nivel||' = 1) then
                                     gl.CONTRACTOR_ID
                                when ('||nivel||' = 2) then
                                     gl.CONTRACT_ID
                                when ('||nivel||' = 3) then
                                     gl.GEOGRAP_LOCATION_ID
                                when ('||nivel||' = 4) then
                                     gl.OPERATING_UNIT_ID
                                end ) is not null or
                                ('||nivel||' = -1 AND gl.CONTRACTOR_ID IS NULL AND  gl.CONTRACT_ID IS NULL AND gl.GEOGRAP_LOCATION_ID IS NULL AND  gl.OPERATING_UNIT_ID IS NULL))
                      order by LIST_UNITARY_COST_ID';

                OPEN cuLista FOR sbSql;

            END IF;
            --Fin 709
        ELSE
            sbSql := 'select  LIST_UNITARY_COST_ID codigo,
                       DESCRIPTION descripcion,
                       VALIDITY_START_DATE fecha_inicial,
                       VALIDITY_FINAL_DATE fecha_final,
                       OPERATING_UNIT_ID||'||''' - '''||'||DAOR_OPERATING_UNIT.FSBGETNAME(OPERATING_UNIT_ID,null) unidad,
                       CONTRACTOR_ID||'||''' - '''||'||DAGE_CONTRATISTA.FSBGETDESCRIPCION(CONTRACTOR_ID, null) contratista,
                       CONTRACT_ID||'||''' - '''||'||DAGE_CONTRATO.FSBGETDESCRIPCION(CONTRACT_ID,null) contrato,
                       GEOGRAP_LOCATION_ID||'||''' - '''||'||DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION(GEOGRAP_LOCATION_ID,null) localidad, '||
                       '''-'''||'tipo_incremento
                       from GE_LIST_UNITARY_COST gl
                       where trunc(to_date('''||dtFecha_Inicial||''','||'''dd/mm/yyyy hh24:mi:ss'''||')) BETWEEN gl.VALIDITY_START_DATE AND  gl.VALIDITY_FINAL_DATE
                       and ( (case when ('||nivel||' = 1) then
                                     gl.CONTRACTOR_ID
                                when ('||nivel||' = 2) then
                                     gl.CONTRACT_ID
                                when ('||nivel||' = 3) then
                                     gl.GEOGRAP_LOCATION_ID
                                when ('||nivel||' = 4) then
                                     gl.OPERATING_UNIT_ID
                                end ) is not null or
                                ('||nivel||' = -1 AND gl.CONTRACTOR_ID IS NULL AND  gl.CONTRACT_ID IS NULL AND gl.GEOGRAP_LOCATION_ID IS NULL AND  gl.OPERATING_UNIT_ID IS NULL))
                      order by LIST_UNITARY_COST_ID';

                OPEN cuLista FOR sbSql;
        END IF;

        RETURN cuLista;

        --ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso, 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
 END FRCGETLISTACOSTVIG;

 PROCEDURE PRACTULISTACOST (inucodlp       In GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%type,
                             inucurrent   In Number,
                            inutotal     In Number,
                            coderror Out ge_error_log.message_id%Type,
                            messerror Out ge_error_log.description%Type) IS
/**************************************************************************
  Autor       : Horbath
  Fecha       : 2019-04-04
  Ticket      : 200-2433
  Descripcion : Procedimiento que actualiza una lista de precio, creando una nueva a partir de la original
                Y copiando todos los items de GE_UNIT_COST_ITE_LIS actualizandolos todos excepto aquellos
                que esten marcados como exentos en la tabla LDC_ITEMEXENAUM

  Parametros Entrada
  inucodlp     codigo de la lista de costos original


  Parametros de salida
  coderror     Indica si hubo error (1) , sino hubo error (0)
  messerror    Descripcion del error
  nucodlistn   Codigo de la nueva lista creada

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  08/03/2022   Jorval      CAMBIO 960: Agregar validacion de comparacion de fecha Inicial de Vigentacia
                                       utilizada en la busqueda y compararlo con la fecha inicial de vigencia
                                       utilizada para procesar nueva listas de costos
***************************************************************************/

  inuporcinc number;
  dtfechaini date;

  inuNewCodList  number;

  prueba   number;

  sberror       varchar2(3000);
  nucodlistn    GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%type;
  vDESCRIPTION GE_LIST_UNITARY_COST.DESCRIPTION%type;
  vVALIDITY_START_DATE GE_LIST_UNITARY_COST.VALIDITY_START_DATE%type;
  vVALIDITY_FINAL_DATE GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE%type;
  vCOMPANY_KEY GE_LIST_UNITARY_COST.COMPANY_KEY%TYPE;
  vOPERATING_UNIT_ID GE_LIST_UNITARY_COST.OPERATING_UNIT_ID%TYPE;
  vCONTRACTOR_ID GE_LIST_UNITARY_COST.CONTRACTOR_ID%TYPE;
  vCONTRACT_ID GE_LIST_UNITARY_COST.CONTRACT_ID%TYPE;
  vGEOGRAP_LOCATION_ID GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID%TYPE;


CURSOR CUITEMS IS SELECT * FROM GE_UNIT_COST_ITE_LIS WHERE LIST_UNITARY_COST_ID=inucodlp;
sw boolean;
fp LDC_ITEMEXENAUM.exauprec%type;
fc LDC_ITEMEXENAUM.exaucost%type;
 dtFecha_Inicial1 varchar2(100);
-- cursor lista de descuent de unidad operativa pasada por parametro , segun levantamiento nivel 1 se debe validar que
-- la vigencia de la lista de descuento sea la misma que la que tiene la lista de precio pasada por parametro
cursor cudesc is
  select *
  from LDC_CONST_LIQTARRAN
  where unidad_operativa=vOPERATING_UNIT_ID and
       trunc(to_date(dtFecha_Inicial,'dd/mm/yyyy hh24:mi:ss')) BETWEEN fecha_ini_vigen and  fecha_fin_vige
       ;
  factorp number;
  factorc number;

  dtfechaFin date;
  nuItems number;
begin

    inuporcinc           := TO_NUMBER(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER_ITEMS', 'TOTAL_PRICE'));
    dtFecha_Inicial1   := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER', 'EXECUTION_FINAL_DATE');

    IF inuporcinc NOT BETWEEN 1 AND 100 THEN
       messerror := 'El porcetaje de IPC debe se un numero comprendido de 1 a 100';
       coderror := -1;
       GE_BOERRORS.SETERRORCODEARGUMENT(2417, messerror);
    END IF;

    if dtFecha_Inicial <> dtFecha_Inicial1 then
       --CAMBIO 960
       messerror := 'La fecha inicial de vigencia ' || dtFecha_Inicial1 || ' a utilizar, difiere de la fecha inicial de vigencia ' || dtFecha_Inicial || ' utilizada al momento de consultar.';
       --coderror := -1;
       GE_BOERRORS.SETERRORCODEARGUMENT(2741, messerror);
       ---------------------------------------
    else
      dtFecha_Inicial1 := dtFecha_Inicial;
    end if;

    dtfechaini := to_date(to_char(to_date(dtFecha_Inicial,'dd/mm/yyyy hh24:mi:ss'), 'dd/mm/yyyy')||' 00:00:00', 'dd/mm/yyyy hh24:mi:ss');
     -- setea valores de parametros de salida
     --coderror :=0;
    -- messerror:=;
     -- busca valores de la lista de precios original
     select  DESCRIPTION,VALIDITY_FINAL_DATE, COMPANY_KEY, OPERATING_UNIT_ID, CONTRACTOR_ID, CONTRACT_ID, GEOGRAP_LOCATION_ID
       into vDESCRIPTION,vVALIDITY_FINAL_DATE,vCOMPANY_KEY,vOPERATING_UNIT_ID,vCONTRACTOR_ID,vCONTRACT_ID,vGEOGRAP_LOCATION_ID
       from GE_LIST_UNITARY_COST
       where LIST_UNITARY_COST_ID=inucodlp;
     -- setea nuevo codigo de lista de precio/costo
     select SEQ_GE_LIST_UNITARY_COST.nextval into nucodlistn from dual;
     inuNewCodList := nucodlistn;
     -- crea nueva lista de precio/costo
     insert into GE_LIST_UNITARY_COST
                (LIST_UNITARY_COST_ID,
                 DESCRIPTION,
                 VALIDITY_START_DATE,
                 VALIDITY_FINAL_DATE,
                 COMPANY_KEY,
                 OPERATING_UNIT_ID,
                 USER_ID,
                 TERMINAL,
                 CONTRACTOR_ID,
                 CONTRACT_ID,
                 GEOGRAP_LOCATION_ID)
         values (nucodlistn,
                 vDESCRIPTION,
                 dtfechaini,
				 to_date(to_char(vVALIDITY_FINAL_DATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss') ,
                 vCOMPANY_KEY,
                 vOPERATING_UNIT_ID,
                 user,
                 USERENV('TERMINAL'),
                 vCONTRACTOR_ID,
                 vCONTRACT_ID,
                 vGEOGRAP_LOCATION_ID);
     -- RECORRE LOS ITEMS DE LA LISTA ANTERIOR


     for c in CUITEMS loop
         sw:=false;
         fp:='N';
         fc:='N';
         factorp:=(100+inuporcinc)/100;
         factorc:=(100+inuporcinc)/100;

         begin


              select exauprec , exaucost
                     into fp, fc
                     from LDC_ITEMEXENAUM
                     where items_id=c.ITEMS_ID;
              sw:=true;
         exception
             when no_data_found then
                  sw:=false;
         end;
         if fp='Y' then
            factorp:=1;
         end if;
         if fc='Y' then
            factorc:=1;
         end if;
         -- CREA ITEMS EN LA LISTA NUEVA
         insert into GE_UNIT_COST_ITE_LIS
                (ITEMS_ID,
                 LIST_UNITARY_COST_ID,
                 PRICE,
                 LAST_UPDATE_DATE,
                 USER_ID,
                 TERMINAL,
                 SALES_VALUE)
          values(c.items_id,
                 nucodlistn,
                 round(c.price*factorc,0),
                 sysdate,
                 user,
                USERENV('TERMINAL'),
                 round(C.SALES_VALUE*FACTORP,0));
     end loop;
     -- CIERRA LA LISTA ANTERIOR COLOCANDOLE FECHA FINAL EL DIA INMEDIATAMENTE ANTERIOR A LA FECHA INICIAL DE LA NUEVA

     dtfechaFin := to_date(to_char(DTFECHAINI-1,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');

     UPDATE
        GE_LIST_UNITARY_COST
        SET VALIDITY_FINAL_DATE=dtfechaFin
        WHERE LIST_UNITARY_COST_ID=inucodlp;
     -- actualiza las lista de descuento de tarifas por rango siempre y cuando la lista pasada por parametro sea de una unidad operativa
     if vOPERATING_UNIT_ID is not null then
        for d in cudesc loop
         fc:='N';
         factorc:=(100+inuporcinc)/100;

         begin
              nuItems := D.ITEMS;
              if D.ITEMS = -1 then
                nuItems := d.ACTIVIDAD_ORDEN;
              end if;

              select exaucost
                     into fc
                     from LDC_ITEMEXENAUM
                     where items_id=nuItems;
              sw:=true;
         exception
             when no_data_found then
                  sw:=false;
         end;

         if fc='Y' then
            factorc:=1;
         end if;

            -- CIERRA EL REGISTRO DE LA LISTA DE DESCUENTO
            UPDATE ldc_const_liqtarran SET FECHA_FIN_VIGE=dtfechaFin WHERE IDEN_REG=D.IDEN_REG;
            -- CREA NUEVO REGISTRO DE LA LISTA DE DESCUENTO
            insert into ldc_const_liqtarran
                    (IDEN_REG,
                     UNIDAD_OPERATIVA,
                     ACTIVIDAD_ORDEN,
                     CANTIDAD_INICIAL,
                     CANTIDAD_FINAL,
                     VALOR_LIQUIDAR,
                     NOVEDAD_GENERAR,
                     FECHA_INI_VIGEN,
                     FECHA_FIN_VIGE,
                     ITEMS,
                     ZONA_OFERTADOS)
              VALUES(LDC_SEQLCTARAN.NEXTVAL,
                     D.UNIDAD_OPERATIVA,
                     D.ACTIVIDAD_ORDEN,
                     D.CANTIDAD_INICIAL,
                     D.CANTIDAD_FINAL,
                     round(D.VALOR_LIQUIDAR*factorc,0),
                     D.NOVEDAD_GENERAR,
                     dtfechaini,
                     to_date(to_char(D.FECHA_FIN_VIGE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss') ,
                     D.ITEMS,
                     D.ZONA_OFERTADOS);
        END LOOP;
     end if;

     --se inserta log
     INSERT INTO LDC_LOGPROACLISCOST
      (
        CODILISNEW,    CODILISOLD,   PORCENTAJE,    FECHINIVIG,    NIVEL,    FECHPROC,    USUARIO,    TERMINAL
      )
      VALUES
      (
        nucodlistn,    inucodlp,      inuporcinc,    dtfechaini, nivel, SYSDATE,   USER,  USERENV('TERMINAL'));

    messerror := 'Se creo lista de costo '||nucodlistn||' con exito';
  --   COMMIT;
exception
   when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
     when others then
          rollback;
          sberror:=sqlerrm;
          coderror:= -1;
          messerror:='Error actualizando la lista de precios # '||to_char(inucodlp)||'. '||substr(sberror,1,100);
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
end PRACTULISTACOST;
END LDC_PKGACTUALIZALISCOST;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGACTUALIZALISCOST
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKGACTUALIZALISCOST', 'ADM_PERSON');
END;
/