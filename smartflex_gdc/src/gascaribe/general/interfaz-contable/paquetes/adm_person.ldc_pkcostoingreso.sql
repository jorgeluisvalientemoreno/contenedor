CREATE OR REPLACE PACKAGE adm_person.ldc_pkcostoingreso
  /*****************************************************************************
  Propiedad intelectual Gases del Caribe .
  Function:     LDC_PKCOSTOINGRESO
  Descripcion:  Paquete encargado de generar el proceso de costo ingreso mensual
  Autor:        HORBATH TECHNOLOGIES
  Fecha:        23-04-2020

  Historia de modificaciones
  Fecha        Autor     Modificacion

  19/07/2020    HT       CA-0000447 Se modifica el proceso de buscar el ingreso por los servicios cumplidos, funcion
                         FnuGeneIngreServCump, se reportara por orden de trabajo legalizada en el mes indicado.
                         Se omitira el ingreso reportado por productos conectados antes del 7 de julio/2020 y de las
                         ordenes de interna reportadas por orden de apoyo.
  27/05/2024   jpinedc   OSF-2603: Se reemplaza LDC_ENVIAMAIL por pkg_Correo.prcEnviaCorreo
  18/06/2024   Adrianavg OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON

  27/09/2024    EDMLAR   OSF-3284 - Se modifica la funcion FnuGeneIngreServCump, el WITH de CARGOS, se optimiza la consulta 
                         para que no se demore la ejecucion de este proceso.
  **************************************************************************************************************/
  IS

    osbErrorMessage          VARCHAR2(2000);
    errorPara01              EXCEPTION;      --Manejo de exception para el paquete

    nucontareg              NUMBER(15) DEFAULT 0;
    nucantiregcom           NUMBER(15) DEFAULT 0;
    nucantiregtot           NUMBER(15) DEFAULT 0;
    sbmail                  ld_parameter.value_chain%type;
    sbMes                   VARCHAR2(2000);


   FUNCTION FSBGETDESCMES(nuMES NUMBER) return varchar2;

  -- Procedimiento Principal que ejecuta el proceso
  PROCEDURE ProcGeneCostoIng(  inuAno      IN NUMBER,
                               inuMes      IN NUMBER,
                               isbpro      IN VARCHAR2,
                               sbmensa     OUT VARCHAR2,
                               error       OUT NUMBER
                            );

 -- Funcion que ejecuta el proceso de costos
  FUNCTION FnuGeneCostosOrd(  inuAno      IN number,
                              inuMes      IN number,
                              sbCorreo    IN VARCHAR2,
                              dtfefein    IN DATE,
                              dtfefefin   IN DATE,
                              sbTipoBD    IN VARCHAR2,
                              sbmensa     OUT VARCHAR2,
                              error       OUT NUMBER
                            )
  RETURN NUMBER;
 --Funcion que Clasifica las ordenes
  FUNCTION fnuClasificaOt ( inuAno      IN number,
                            inuMes      IN number,
                            dtfefein    IN DATE,
                            dtfefefin   IN DATE,
                            sbCorreo    IN VARCHAR2,
                            nuCommit    IN NUMBER,
                            sbTipoBD    IN VARCHAR2,
                            sbmensa     OUT VARCHAR2,
                            error       OUT NUMBER
                          )
  RETURN NUMBER;
 --Funcion que procesa los datos del usuario
  FUNCTION fnuProcesaDatosUsu ( inuAno      IN number,
                                inuMes      IN number,
                                dtfefein    IN DATE,
                                dtfefefin   IN DATE,
                                sbCorreo    IN VARCHAR2,
                                nuCommit    IN NUMBER,
                                sbTipoBD    IN VARCHAR2,
                                sbmensa     OUT VARCHAR2,
                                error       OUT NUMBER
                              )
  RETURN NUMBER;

 --Funcion que procesa el costo de las ordenes
  FUNCTION fnuCosto ( inuAno      IN number,
                      inuMes      IN number,
                      dtfefein    IN DATE,
                      dtfefefin   IN DATE,
                      sbCorreo    IN VARCHAR2,
                      nuCommit    IN NUMBER,
                      sbClasiExcluir IN VARCHAR2,
                      sbTipoBD    IN VARCHAR2,
                      sbmensa     OUT VARCHAR2,
                      error       OUT NUMBER
                    )
  RETURN NUMBER;

 -- Funcion que ejecuta el proceso de costos de Materiales
  FUNCTION FnuGeneCostosMat(  inuAno      IN number,
                              inuMes      IN number,
                              dtfefein    IN DATE,
                              dtfefefin   IN DATE,
                              sbCorreo    IN VARCHAR2,
                              nuCommit    IN NUMBER,
                              sbTipoBD    IN VARCHAR2,
                              sbmensa     OUT VARCHAR2,
                              error       OUT NUMBER
                            )
  RETURN NUMBER;


 -- Funcion que ejecuta el proceso de ingresos desde cargos
  FUNCTION FnuGeneIngresos(  inuAno      IN number,
                             inuMes      IN number,
                             dtfefein    IN DATE,
                             dtfefefin   IN DATE,
                             sbCorreo    IN VARCHAR2,
                             sbTipoBD    IN VARCHAR2,
                             sbmensa     OUT VARCHAR2,
                             error       OUT NUMBER
                           )
  RETURN NUMBER;

 -- Funcion que ejecuta el proceso del ingreso de servicios cumplidos
  FUNCTION FnuGeneIngreServCump(  inuAno      IN number,
                                  inuMes      IN number,
                                  dtfefein    IN DATE,
                                  dtfefefin   IN DATE,
                                  sbCorreo    IN VARCHAR2,
                                  sbTipoBD    IN VARCHAR2,
                                  sbmensa     OUT VARCHAR2,
                                  error       OUT NUMBER
                                )
  RETURN NUMBER;

 END LDC_PKCOSTOINGRESO;
/
CREATE OR REPLACE package body adm_person.LDC_PKCOSTOINGRESO is

  /*****************************************************************************
  Propiedad intelectual Gases del Caribe .
  Function:     LDC_PKCOSTOINGRESO
  Descripcion:  Paquete encargado de generar el proceso de costo ingreso mensual
  Autor:        HORBATH TECHNOLOGIES
  Fecha:        23-04-2020

  Historia de modificaciones
  Fecha       Autor    Modificacion

  19/07/2020    HT      CA-0000447 Se modifica el proceso de buscar el ingreso por los servicios cumplidos, funcion
                        FnuGeneIngreServCump, se reportara por orden de trabajo legalizada en el mes indicado.
                        Se omitira el ingreso reportado por productos conectados antes del 7 de julio/2020 y de las
                        ordenes de interna reportadas por orden de apoyo.
  18/11/2020    HT      CA-576 se controla que solo se busque el clasificador de costo solo cuando es de una solicitud,
                        esto con el fin de evitar error en la busqueda esta. Aplica solo para los clasificadores de
                        servicios nuevos.

  27/09/2024  EDMLAR    OSF-3284 - Se modifica la funcion FnuGeneIngreServCump, el WITH de CARGOS, se optimiza la consulta 
                        para que no se demore la ejecucion de este proceso.

  **************************************************************************************************************/

  FUNCTION FSBGETDESCMES(nuMES NUMBER) return varchar2 is
  /*****************************************************************************
  Propiedad intelectual Gases del Caribe.

  Function:     FSBGETDESCMES
  Descripcion:  Funcion que devuelve el nombre del mes

  Autor:        HORBATH TECHNOLOGIES
  Fecha:        23-04-2020

  Historia de modificaciones
  Fecha Autor Modificacion





  **************************************************************************************************************/
  begin


        if sbMes is not null then
          return sbMes;
        else
         begin
           execute immediate 'ALTER SESSION SET NLS_LANGUAGE= ''SPANISH''';
           SELECT TO_CHAR(TO_DATE('01/'||numes||'/2020','DD/MM/YYYY'), 'MONTH') into sbMes FROM DUAL;
         exception
           when others then
             sbMes:=null;
         end;
        end if;
        return sbMes;
  exception
     when others then
          dbms_output.put_line(sqlerrm);
          return null;
  end;


  -- Procedimiento Principal que ejecuta el proceso
  PROCEDURE ProcGeneCostoIng(  inuAno      IN NUMBER,
                               inuMes      IN NUMBER,
                               isbpro      IN VARCHAR2,
                               sbmensa     OUT VARCHAR2,
                               error       OUT NUMBER
                            ) IS

  /*****************************************************************************
  Propiedad intelectual Gases del Caribe.

  Function:     ProcGeneCostoIng
  Descripcion:  Procedimiento encargado de controlar el proceso a ejecutar
                1 = Proceso Completo Costo e Ingreso
                2 = Proceso solo Costos
                3 = Proceso solo Ingresos

  Autor:        HORBATH TECHNOLOGIES
  Fecha:        23-04-2020

  Historia de modificaciones
  Fecha Autor Modificacion


  **************************************************************************************************************/


  nuerror         number;
  sbmensaje       varchar2(2000);
  numensaje       number;
  dtfefein        ldc_ciercome.cicofein%TYPE;
  dtfefefin       ldc_ciercome.cicofech%TYPE;
  pmensa          VARCHAR2(1000);
  nuok            NUMBER(2);
  sbmenproc       varchar2(30);
  nupano          NUMBER(4) DEFAULT 0;
  nupmes          NUMBER(2) DEFAULT 0;
  sbTipoBd        varchar2(100);

  BEGIN

    -- Se incializan Variables de trabajo
    nucantiregcom := 0;
    nucantiregtot := 0;
    nucontareg    := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_CANTIDAD_REG_GUARDAR');
    ldc_cier_prorecupaperiodocont(inuAno,inuMes,dtfefein,dtfefefin,pmensa,nuok);
    nupano        := inuAno;
    nupmes        := inuMes;
    sbmail    := dald_parameter.fsbGetValue_Chain('CORREO_COSTO_INGRESO');
    sbTipoBd  := UT_DBINSTANCE.FSBGETCURRENTINSTANCETYPE;
    if sbTipoBd != 'P' then
       sbTipoBd :='PRUEBA: ';
    end if;
    -- ---------
    -- Si la Opcion Elegida es 1, se ejecuta todo el proceso
    -- ---------
    If isbpro = 1 then

      -- Borramos registros de tablas

      nuerror := FnuGeneCostosOrd(nupano, nupmes, sbmail, dtfefein, dtfefefin, sbTipoBd,sbmensaje, numensaje);
      If nuerror = 0 then
        -- Ejecutamos costos de Materiales
        nuerror := FnuGeneCostosMat(nupano, nupmes, dtfefein, dtfefefin, sbmail, nucontareg,sbTipoBd,  sbmensaje, numensaje);
        If nuerror = 0 then
          -- Ejecutamos Ingresos
          nuerror := FnuGeneIngresos(nupano, nupmes, dtfefein, dtfefefin, sbmail, sbTipoBd, sbmensaje, numensaje);
          If nuerror = 0 then
            nuerror := FnuGeneIngreServCump(nupano, nupmes, dtfefein, dtfefefin, sbmail, sbTipoBd, sbmensaje, numensaje);
            If nuerror != 0 then
               sbmenproc := ' FnuGeneIngreServCump : ';
               RAISE errorPara01;
            end if;
          else
            sbmenproc := ' FnuGeneIngresos : ';
            RAISE errorPara01;
          end if;
        else
          sbmenproc := ' FnuGeneCostosMat : ';
          RAISE errorPara01;
        end if;
      else
        sbmenproc := ' FnuGeneCostosOrd : ';
        RAISE errorPara01;
      end if;
    End if;

    -- -----
    -- Si la Opcion Elegida es 2, se ejecuta el proceso de costos
    -- -----
    If isbpro = 2 then

      -- Borramos registros de tablas

      -- Ejecutamos costos de Ordenes
      nuerror := FnuGeneCostosOrd(nupano, nupmes, sbmail,dtfefein, dtfefefin, sbTipoBd, sbmensaje, numensaje);
      If nuerror = 0 then
        -- Ejecutamos costos de Materiales
        nuerror := FnuGeneCostosMat(nupano, nupmes, dtfefein, dtfefefin, sbmail, nucontareg, sbTipoBd, sbmensaje, numensaje);
        if nuerror != 0 then
          sbmenproc := ' FnuGeneCostosMat : ';
          RAISE errorPara01;
        end if;
      else
        sbmenproc := ' FnuGeneCostosOrd : ';
        RAISE errorPara01;
      end if;

    End if;

    -- --------
    -- Si la Opcion Elegida es 3, se ejecuta el proceso de Ingresos
    -- --------
    If isbpro = 3 then

      -- Borramos registros de tablas
      DELETE ldc_osf_costingr l WHERE l.nuano = inuAno AND l.numes = inuAno AND l.tipo ='INGRESO';
      COMMIT;

      -- Ejecutamos ingresos desde cargos
      nuerror := FnuGeneIngresos(nupano, nupmes, dtfefein, dtfefefin, sbmail,sbTipoBd,  sbmensaje, numensaje);
      If nuerror = 0 then
         -- Ejecutamos ingreso de servicios cumplidos
         nuerror := FnuGeneIngreServCump(nupano, nupmes, dtfefein, dtfefefin, sbTipoBd, sbmail, sbmensaje, numensaje);
         If nuerror != 0 then
            sbmenproc := ' FnuGeneIngreServCump : ';
            RAISE errorPara01;
         end if;
      Else
         sbmenproc := ' FnuGeneIngresos : ';
         RAISE errorPara01;
      end if;

    End if;


  Exception
     When Errorpara01 then
      Errors.seterror (-1, 'ERROR: [ProcGeneCostoIng]: ' || sbmenproc || osbErrorMessage);
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbmail,
            isbAsunto           => 'Costo Ingreso  ',
            isbMensaje          => 'Error:'||sbmensaje
        );

     when others then
       Errors.seterror (-1, 'ERROR: [ProcGeneCostoIng]: ' ||sqlerrm);
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbmail,
            isbAsunto           => 'Costo Ingreso  ',
            isbMensaje          => '[ProcGeneCostoIng] Error:'||sqlerrm
        );
  END;


  -- Funcion que ejecuta el proceso de costos de Ordenes
  FUNCTION FnuGeneCostosOrd(  inuAno      IN number,
                              inuMes      IN number,
                              sbCorreo    IN VARCHAR2,
                              dtfefein    IN DATE,
                              dtfefefin   IN DATE,
                              sbTipoBD    IN VARCHAR2,
                              sbmensa     OUT VARCHAR2,
                              error       OUT NUMBER
                           )
  RETURN NUMBER IS

  /*****************************************************************************
  Propiedad intelectual Gases del Caribe.

  Function:     FnuGeneCostosOrd
  Descripcion:  Funcion encargada de generar todo el Costo

  Autor:        HORBATH TECHNOLOGIES
  Fecha:        23-04-2020

  Historia de modificaciones
  Fecha Autor Modificacion


  **************************************************************************************************************/
  nuCantid number;
  sbClasiExcluir  LDCI_CARASEWE.CASEVALO%type;
  osbErrorMessage ge_error_log.description%TYPE;
  errorPara01     exception;        -- Excepcion que verifica que ingresen los parametros de entrada
  nuCommit        number:=1000;
  nuOk            number;


  cursor cuOrdenesNormales is
  select /*+index(o2 IDX_OR_ORDER_012) */
       o2.rowid,
       o2.order_id,
       decode(o2.task_type_id, 10336, o2.real_task_type_id, o2.task_type_id) task_type_id,
       u.contractor_id,
       u.name
from or_order o2
inner join ge_causal c on c.causal_id=o2.causal_id and c.class_causal_id=1
inner join or_operating_unit u on u.operating_unit_id=o2.operating_unit_id and u.es_externa='Y'
where o2.order_status_id=8
  and task_type_id in ( select tt.clcttitr  from ic_clascott tt where ',' || sbClasiExcluir || ',' NOT LIKE '%,' || tt.clctclco || ',%')
  and o2.rowid in (
select /*+index(o IDX_OR_ORDER16) */  o.rowid
from or_order o
where trunc(legalization_date)>=dtfefein
  and trunc(legalization_date)<=dtfefefin
  and o.order_status_id=8
  and trunc(o.created_date)<=dtfefefin
  and ((o.is_pending_liq is null and exists(select null from ct_order_certifica c where c.order_id=o.order_id)) or o.is_pending_liq is not null));

  cursor cuOrdenesOtroMes is
  select /*+index(o2 IDX_OR_ORDER_012) */
       o2.rowid,
       o2.order_id,
       decode(o2.task_type_id, 10336, o2.real_task_type_id, o2.task_type_id) task_type_id,
       u.contractor_id,
       u.name
from or_order o2
inner join ge_causal c on c.causal_id=o2.causal_id and c.class_causal_id=1
inner join or_operating_unit u on u.operating_unit_id=o2.operating_unit_id and u.es_externa='Y'
where o2.order_status_id=8
  and task_type_id in ( select tt.clcttitr  from ic_clascott tt where ',' || sbClasiExcluir || ',' NOT LIKE '%,' || tt.clctclco || ',%')
  and o2.rowid in (
select /*+index(o IDX_OR_ORDER04) */  o.rowid
from or_order o
where trunc(created_date)>=dtfefein
  and trunc(created_date)<=dtfefefin
  and o.order_status_id=8
  and trunc(o.legalization_Date)<dtfefein);

  cursor cuConfConta is
  select /*+ index(ci MES_TIPO)*/
         distinct ci.titr,
         cl.clcocodi,
         cl.clcodesc,
         lc.cuctcodi,
         lc.cuctdesc,
         t.concept
    from ldc_osf_costingr ci
   inner join ic_clascott ic on ic.clcttitr=ci.titr
   inner join ic_clascont cl on cl.clcocodi=ic.clctclco
   inner join ldci_cugacoclasi lg on lg.cuenclasifi = ic.clctclco
   inner join ldci_cuentacontable lc on lc.cuctcodi=lg.cuencosto
   inner join or_task_type t on t.task_type_id=ci.titr
    where ci.nuano=inuAno
      and ci.numes=inuMes
      and ci.tipo='COSTO';






  BEGIN

    --Se cargan los parametros
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASCONT_FNB', sbClasiExcluir, osbErrorMessage);

    if(osbErrorMessage != '0') then
           RAISE errorPara01;
    end if;--if(osbErrorMessage != '0') then
    nuCommit:=nvl(nucontareg,nuCommit);


    DELETE ldc_osf_costingr l WHERE l.nuano = inuAno AND l.numes = inuMes AND l.tipo IN  ('ACTA_FRA','ACTA_S_F','SIN_ACTA','COSTO','IVA_FRA');
    COMMIT;

    --Empieza el proceso de seleccion de ordenes
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Empieza Seleccion Ordenes'
    );

    nuCantid:=0;
    for reg in cuOrdenesNormales loop
        insert into ldc_osf_costingr(nuano, numes,contratista,nombre, titr,order_id, tipo, iva, ing_otro, notas, ing_int_mig, ing_cxc_mig, ing_rp_mig, ing_int_osf, ing_cxc_osf, ing_rp_osf, ing_int_con, ing_cxc_con, ing_rp_con, total_ingreso) values(inuAno, inuMes, reg.contractor_id, reg.name, reg.task_type_id, reg.order_id,'COSTO', 0,0,0,0,0,0,0,0,0,0,0,0,0);
        nuCantid:=nuCantid+1;
        if nuCantid>=nuCommit then
           Commit;
           nuCantid:=0;
        end if;
    end loop;
    commit;
    nuCantid:=0;
    for reg in cuOrdenesOtroMes loop
        insert into ldc_osf_costingr(nuano, numes,contratista,nombre, titr,order_id, tipo, iva, ing_otro, notas, ing_int_mig, ing_cxc_mig, ing_rp_mig, ing_int_osf, ing_cxc_osf, ing_rp_osf, ing_int_con, ing_cxc_con, ing_rp_con, total_ingreso) values(inuAno, inuMes, reg.contractor_id, reg.name, reg.task_type_id, reg.order_id,'COSTO', 0,0,0,0,0,0,0,0,0,0,0,0,0);
        nuCantid:=nuCantid+1;
        if nuCantid>=nuCommit then
           Commit;
        end if;
    end loop;
    commit;
    --Se actualiza información contable
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Empieza Información Contable'
    );
    for reg in cuConfConta loop
      update ldc_osf_costingr c
        set c.cuenta=reg.cuctcodi,
            c.nom_cuenta=reg.cuctdesc,
            c.clasificador=reg.Clcocodi,
            c.concept=reg.concept
      where c.nuano=inuAno
        and c.numes=inuMes
        and c.tipo='COSTO'
        and c.titr=reg.titr;
        commit;
    end loop;

    --Se actualizan datos de los productos
    nuOk:=fnuProcesaDatosUsu(inuAno,
                              inuMes,
                              dtfefein,
                              dtfefefin,
                              sbmail,
                              nuCommit,
                              sbTipoBD,
                              sbmensa,
                              error);
    if nuOk != 0 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       sbmensa);
      raise ex.CONTROLLED_ERROR;
    end if;

    --Se clasifican las ordenes
    nuOk:=fnuClasificaOt(inuAno,
                          inuMes,
                          dtfefein,
                          dtfefefin,
                          sbmail,
                          nuCommit,
                          sbTipoBD,
                          sbmensa,
                          error);
    if nuOk != 0 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       sbmensa);
      raise ex.CONTROLLED_ERROR;
    end if;

    --Se busca el costo
    nuOk:=fnuCosto(inuAno,
                    inuMes,
                    dtfefein,
                    dtfefefin,
                    sbmail,
                    nuCommit,
                    sbClasiExcluir,
                    sbTipoBD,
                    sbmensa,
                    error);
    if nuOk != 0 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       sbmensa);
      raise ex.CONTROLLED_ERROR;
    end if;

    return 0;
  Exception
     When Errorpara01 then
      sbmensa:='ERROR: [LDCI_PKRESERVAMATERIAL.proCargaVarGlobal]: Cargando el parametro :' || osbErrorMessage;
      return -1;
     When ex.CONTROLLED_ERROR then
       return -1;
     When others then
       sbmensa:=sqlerrm;
       return -1;
  END FnuGeneCostosOrd;

  FUNCTION fnuProcesaDatosUsu ( inuAno      IN number,
                                inuMes      IN number,
                                dtfefein    IN DATE,
                                dtfefefin   IN DATE,
                                sbCorreo    IN VARCHAR2,
                                nuCommit    IN NUMBER,
                                sbTipoBD    IN VARCHAR2,
                                sbmensa     OUT VARCHAR2,
                                error       OUT NUMBER
                              )
  RETURN NUMBER IS

  /*****************************************************************************
  Propiedad intelectual Gases del Caribe.

  Function:     FnuGeneCostosMat
  Descripcion:  Funcion encargada de generar todo el Costo de materiales

  Autor:        HORBATH TECHNOLOGIES
  Fecha:        23-04-2020

  Historia de modificaciones
  Fecha Autor Modificacion


  **************************************************************************************************************/
  cursor cuDatosProd is
  select /*+ INDEX(CI MES_TIPO)*/
       ci.rowid,
       ci.order_id,
       a.product_id,
       a.activity_id,
       (select category_id from pr_product p where p.product_id=a.product_id) categ
  from ldc_osf_costingr ci
 inner join or_order_Activity a on a.order_id=ci.order_id and a.task_type_id=ci.titr
 where ci.nuano = inuAno
   and ci.numes = inuMes
   and ci.tipo in ('ACTA_FRA','ACTA_S_F','SIN_ACTA','COSTO')
   and final_date is null;

  nuCantid number;
  sbClasiExcluir  LDCI_CARASEWE.CASEVALO%type;
  osbErrorMessage ge_error_log.description%TYPE;
  errorPara01     exception;        -- Excepcion que verifica que ingresen los parametros de entrada
  nuOk            number;
  nuOrden         number;

   Begin
    --Se actualiza informaci?n del producto y actividad
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Empieza informacion producto'
    );

    nuCantid:=0;
    for reg in cuDatosProd loop
      nuOrden:=reg.order_id;
      update ldc_osf_costingr c
         set c.product_id=reg.product_id,
             c.actividad=reg.activity_id,
             c.cate=reg.categ
       where c.nuano=inuAno
         and c.numes=inuMes
         and c.tipo in ('ACTA_FRA','ACTA_S_F','SIN_ACTA','COSTO')
         and c.rowid=reg.rowid;
      nuCantid:=nuCantid+1;
      if nuCantid>=nuCommit then
         Commit;
         nuCantid:=0;
      end if;
    end loop;
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Termina informacion producto'
    );
    return 0;
    EXCEPTION
      WHEN OTHERS THEN
        sbmensa:='fnuProcesaDatosUsu : Error procesando Orden :'||nuOrden||'-'||SQLERRM;
        return -1;
End fnuProcesaDatosUsu;

  FUNCTION fnuClasificaOt ( inuAno      IN number,
                            inuMes      IN number,
                            dtfefein    IN DATE,
                            dtfefefin   IN DATE,
                            sbCorreo    IN VARCHAR2,
                            nuCommit    IN NUMBER,
                            sbTipoBD    IN VARCHAR2,
                            sbmensa     OUT VARCHAR2,
                            error       OUT NUMBER
                          )
  RETURN NUMBER IS

  /*****************************************************************************
  Propiedad intelectual Gases del Caribe.

  Function:     FnuGeneCostosMat
  Descripcion:  Funcion encargada de generar todo el Costo de materiales

  Autor:        HORBATH TECHNOLOGIES
  Fecha:        23-04-2020

  Historia de modificaciones
  Fecha Autor Modificacion


  **************************************************************************************************************/
  cursor cuInfoActa is
  select /*+ index(ci MES_TIPO)*/
         ci.rowid,
         ci.order_id,
         c.certificate_id,
         a.extern_invoice_num,
         a.extern_pay_date,
         Case
           When c.certificate_id is null then 'SIN_ACTA'
           When a.extern_invoice_num is null or a.extern_pay_date>dtfefefin then 'ACTA_S_F'
           Else 'ACTA_FRA'
           End tipo
  from ldc_osf_costingr ci
  left join ct_order_certifica c on ci.order_id=c.order_id
  left join ge_acta a on a.id_acta=c.certificate_id
  where ci.nuano=inuAno
    and ci.numes=inuMes
    and ci.tipo in ('ACTA_FRA','ACTA_S_F','SIN_ACTA','COSTO');

  nuCantid number;
  sbClasiExcluir  LDCI_CARASEWE.CASEVALO%type;
  osbErrorMessage ge_error_log.description%TYPE;
  errorPara01     exception;        -- Excepcion que verifica que ingresen los parametros de entrada
  nuOk            number;
  nuOrden         number;
   Begin
    --Se clasifican las ordenes
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Empieza Clasificacion Ordenes'
    );
    nuCantid:=0;
    for reg in cuInfoActa loop
      nuOrden:=reg.order_id;
      update ldc_osf_costingr c
         set c.tipo=reg.tipo,
             c.acta=reg.certificate_id,
             c.factura=reg.extern_invoice_num,
             c.fecha=reg.extern_pay_date
       where c.nuano=inuAno
         and c.numes=inuMes
         and c.tipo in ('ACTA_FRA','ACTA_S_F','SIN_ACTA','COSTO')
         and c.rowid=reg.rowid;
      nuCantid:=nuCantid+1;
      if nuCantid>=nuCommit then
         Commit;
         nuCantid:=0;
      end if;
    end loop;
    commit;
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Termina Clasificacion Ordenes'
    );
    return 0;
    EXCEPTION
      WHEN OTHERS THEN
        sbmensa:='fnuClasificaOt : Error procesando Orden :'||nuOrden||'-'||SQLERRM;
        return -1;
End fnuClasificaOt;

  FUNCTION fnuCosto ( inuAno      IN number,
                      inuMes      IN number,
                      dtfefein    IN DATE,
                      dtfefefin   IN DATE,
                      sbCorreo    IN VARCHAR2,
                      nuCommit    IN NUMBER,
                      sbClasiExcluir IN VARCHAR2,
                      sbTipoBD    IN VARCHAR2,
                      sbmensa     OUT VARCHAR2,
                      error       OUT NUMBER
                    )
  RETURN NUMBER IS

  /*****************************************************************************
  Propiedad intelectual Gases del Caribe.

  Function:     FnuGeneCostosMat
  Descripcion:  Funcion encargada de generar todo el Costo de materiales

  Autor:        HORBATH TECHNOLOGIES
  Fecha:        23-04-2020

  Historia de modificaciones
  Fecha Autor Modificacion


  **************************************************************************************************************/


  cursor cuCostoActa is
  select /*+ index(ci MES_TIPO)*/
       ci.rowid,
       ci.order_id,
       sum(d.valor_total) costo
   from ldc_osf_costingr ci
  inner join ge_detalle_acta d on d.id_acta = ci.acta and d.id_orden=ci.order_id
  inner join ge_items i  on i.items_id = d.id_items and i.item_classif_id != 23
  where ci.nuano = inuAno
    and ci.numes = inuMes
    and ci.tipo in ('ACTA_FRA', 'ACTA_S_F')
   group by ci.rowid, ci.order_id;
  cursor cuCostoSinActaNormal is
  select /*+ index(ci MES_TIPO)*/
       ci.rowid,
       ci.order_id,
       sum(oi.value *
           (CASE
             WHEN OUT_ = 'N' THEN -1
             ELSE  1
             END)) costo
   from ldc_osf_costingr ci
  inner join or_order_items oi on oi.order_id = ci.order_id
  inner join ge_items i on i.items_id = oi.items_id and i.item_classif_id not in (3,8,21)
  where ci.nuano = inuAno
    and ci.numes = inuMes
    and ci.tipo in ('SIN_ACTA')
    and not exists(select null from ct_item_novelty n where n.items_id=ci.actividad)
   group by ci.rowid, ci.order_id;

   cursor cuCostoSinActaNovedad is
  select /*+ index(ci MES_TIPO)*/
       ci.rowid,
       ci.order_id,
       sum(nvl(a.value_reference * cn.liquidation_sign* nvl((select -1 from or_related_order where related_order_id=ci.order_id and RELA_ORDER_TYPE_ID=15),1),0)) Costo
   from ldc_osf_costingr ci
  inner join or_order_activity a on a.order_id = ci.order_id
  inner join ct_item_novelty cn on cn.items_id=a.activity_id
  where ci.nuano = inuAno
    and ci.numes = inuMes
    and ci.tipo in ('SIN_ACTA')
    and exists(select null from ct_item_novelty n where n.items_id=ci.actividad)
   group by ci.rowid, ci.order_id;

  --iva mayor costo
  cursor cuIvaCosto is
    select /*+ index(a IDX_GE_ACTA02) index(o PK_OR_ORDER)*/
         a.id_acta acta,
         ic.clcttitr,
         ic.clctclco,
         lg.cuencosto,
         g.ttivcico,
         (select a.product_id from or_order_activity a where a.order_id=o.order_id and rownum=1) producto,
         --categoria
         'ACTA_FRA' tipo,
         a.extern_invoice_num factura,
         a.extern_pay_date fechaFact,
         u.contractor_id,
         dage_contratista.fsbgetdescripcion(u.contractor_id,null) nombre,
         decode(o.task_type_id,10336, o.real_task_type_id, o.task_type_id) task_type_id,
         ic.clctclco clasificador,
         lg.cuencosto cuenta,
         (select lc.cuctdesc from ldci_cuentacontable lc where lc.cuctcodi=lg.cuencosto) nom_cuenta,
         d.valor_total iva,
         (select a.activity_id from or_order_activity a where a.order_id=o.order_id and a.task_type_id=o.task_type_id and a.final_date is null) activity,
         o.order_id
    from ge_acta a
   inner join ge_Detalle_acta d on d.id_acta=a.id_acta and d.id_items=4001293
   inner join or_order o on o.order_id=d.id_orden
   inner join or_operating_unit u on u.operating_unit_id=o.operating_unit_id
   inner join ic_clascott ic on ic.clcttitr=decode(o.task_type_id,10336, o.real_task_type_id, o.task_type_id)
   inner join ldci_cugacoclasi lg on lg.cuenclasifi = ic.clctclco
   inner join ldci_titrindiva G on g.ttivtitr =ic.clcttitr
   where a.extern_invoice_num is not null
     and a.extern_pay_date>=dtfefein
     and a.extern_pay_date<=dtfefefin
     and g.ttivcico is null
     and sbClasiExcluir NOT LIKE '%,' || ic.clctclco || ',%';


  nuCantid number;
  osbErrorMessage ge_error_log.description%TYPE;
  errorPara01     exception;        -- Excepcion que verifica que ingresen los parametros de entrada
  nuOk            number;
  nuOrden         number;
  sbProceso       varchar2(100);
   Begin
--Se hace la busqueda del costo
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Empieza Costo no Material'
    );
    nuCantid:=0;
    sbProceso:='CostoActa';
    for reg in cuCostoActa loop
      nuOrden:=reg.order_id;
      update ldc_osf_costingr c
         set c.costo=reg.costo
       where c.nuano=inuAno
         and c.numes=inuMes
         and c.rowid=reg.rowid;
      nuCantid:=nuCantid+1;
      if nuCantid>=1000 then
        commit;
        nuCantid:=0;
      end if;
    end loop;
    commit;
    sbProceso:='CostoSinActaNormal';
    nuCantid:=0;
    for reg in cuCostoSinActaNormal loop
      nuOrden:=reg.order_id;
      update ldc_osf_costingr c
         set c.costo=reg.costo
       where c.nuano=inuAno
         and c.numes=inuMes
         and c.rowid=reg.rowid;
      nuCantid:=nuCantid+1;
      if nuCantid>=1000 then
        commit;
        nuCantid:=0;
      end if;
    end loop;
    commit;
    sbProceso:='CostoSinActaNovedad';
    nuCantid:=0;
    for reg in cuCostoSinActaNovedad loop
      nuOrden:=reg.order_id;
      update ldc_osf_costingr c
         set c.costo=reg.costo
       where c.nuano=inuAno
         and c.numes=inuMes
         and c.rowid=reg.rowid;
      nuCantid:=nuCantid+1;
      if nuCantid>=1000 then
        commit;
        nuCantid:=0;
      end if;
    end loop;
    commit;
    --Empieza el iva mayor costo
    sbProceso:='CostoIvaMayorCosto';
    nuCantid:=0;
    for reg in cuIvaCosto loop
        nuOrden:=reg.order_id;
        insert into ldc_osf_costingr(nuano,numes,product_id,cate,tipo,acta,factura,fecha,contratista,nombre,titr,cuenta,nom_cuenta,clasificador,actividad,concept,costo,iva,
                                     ing_otro,notas,ing_int_mig,ing_cxc_mig,ing_rp_mig,ing_int_osf,ing_cxc_osf,ing_rp_osf,ing_int_con,ing_cxc_con,ing_rp_con,total_ingreso,utilidad,margen,order_id)
                             values(inuano, inumes, reg.producto, dapr_product.fnugetcategory_id(reg.producto,null),reg.tipo,reg.acta, reg.factura, reg.fechafact, reg.contractor_id, reg.nombre,reg.task_type_id, reg.cuenta, reg.nom_cuenta,reg.clctclco, reg.activity,daor_task_type.fnugetconcept(reg.task_type_id,null), 0, reg.iva,0,0,0,0,0,0,0,0,0,0,0,0,0,0,reg.order_id);
        nuCantid:=nuCantid+1;
        if nuCantid>=nuCommit then
           Commit;
           nuCantid:=0;
        end if;
    end loop;

    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Termina Costo no Material'
    );
    return 0;
    EXCEPTION
      WHEN OTHERS THEN
        sbmensa:='fnuCosto : Error procesando Orden :'||nuOrden||'- Proceso : '||sbProceso||'-'||SQLERRM;
        return -1;
End fnuCosto;
 -- Funcion que ejecuta el proceso de costos de Materiales
  FUNCTION FnuGeneCostosMat(  inuAno      IN number,
                              inuMes      IN number,
                              dtfefein    IN DATE,
                              dtfefefin   IN DATE,
                              sbCorreo    IN VARCHAR2,
                              nuCommit    IN NUMBER,
                              sbTipoBD    IN VARCHAR2,
                              sbmensa     OUT VARCHAR2,
                              error       OUT NUMBER
                            )
  RETURN NUMBER IS

  /*****************************************************************************
  Propiedad intelectual Gases del Caribe.

  Function:     FnuGeneCostosMat
  Descripcion:  Funcion encargada de generar todo el Costo de materiales

  Autor:        HORBATH TECHNOLOGIES
  Fecha:        23-04-2020

  Historia de modificaciones
  Fecha Autor Modificacion


  **************************************************************************************************************/


  Cursor CUmateriales IS
    SELECT PRODUCTO, ORDER_ID, DEPTO, LOCALI, TIPOTRABAJO, CLASIFICADOR, CATEGORIA,
           SUM(TOTAL + IVA) TOTAL,
           CUENTA, (SELECT C.CUCTDESC FROM LDCI_CUENTACONTABLE C WHERE C.CUCTCODI = CUENTA) NOMCUENTA

      FROM
      (
      SELECT PRODUCTO, ORDER_ID,
             SUM(DECODE(SIGNO, 'D', VALUE, -VALUE)) TOTAL,
             Round((SUM(DECODE(SIGNO, 'D', VALUE, -VALUE))  * (pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_VALOR_IVA') / 100)), 4) IVA,
             DEPTO, LOCALI, TIPOTRABAJO, CLASIFICADOR, CATEGORIA,
             (SELECT CU.CUENCOSTO
               FROM LDCI_CUGACOCLASI CU
              WHERE CU.CUENCLASIFI = CLASIFICADOR
             ) CUENTA

      FROM
      (
      SELECT (SELECT ORAC.PRODUCT_ID FROM OR_ORDER_ACTIVITY ORAC
               WHERE ORAC.ORDER_ID = O.ORDER_ID AND ROWNUM = 1) PRODUCTO,
              O.ORDER_ID, Decode(OT.OUT_, 'Y', 'D', 'N', 'C') SIGNO,
              OT.legal_item_amount, OT.VALUE,
              GI.ITEMS_ID || ' - ' || GI.DESCRIPTION IT,
              (SELECT D.GEO_LOCA_FATHER_ID
                FROM GE_GEOGRA_LOCATION D, OR_ORDER_ACTIVITY ORAC, AB_ADDRESS AD
               WHERE D.GEOGRAP_LOCATION_ID = AD.GEOGRAP_LOCATION_ID AND
              ORAC.ADDRESS_ID = AD.ADDRESS_ID(+) AND (ORAC.ORDER_ID = O.ORDER_ID AND
              ROWNUM = 1)) DEPTO,
              (SELECT D.GEOGRAP_LOCATION_ID
                 FROM GE_GEOGRA_LOCATION D, OR_ORDER_ACTIVITY ORAC, AB_ADDRESS AD
                WHERE D.GEOGRAP_LOCATION_ID = AD.GEOGRAP_LOCATION_ID AND
                      ORAC.ADDRESS_ID = AD.ADDRESS_ID(+) AND
                      (ORAC.ORDER_ID = O.ORDER_ID AND ROWNUM = 1)) LOCALI,
              O.TASK_TYPE_ID TIPOTRABAJO,
              GI.ITEM_CLASSIF_ID, OT.ITEMS_ID ITEM,
              ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(O.ORDER_ID), 0, O.TASK_TYPE_ID, ldci_pkinterfazactas.fnuGetTipoTrab(O.ORDER_ID))) CLASIFICADOR,
              O.CHARGE_STATUS ESTADO, OU.OPERATING_UNIT_ID,
              (SELECT K.CATECODI FROM CATEGORI K, OR_ORDER_ACTIVITY ORAC, SERVSUSC SS
                WHERE K.CATECODI = SS.SESUCATE AND ORAC.PRODUCT_ID = SS.SESUNUSE AND (ORAC.ORDER_ID = O.ORDER_ID AND ROWNUM = 1)) CATEGORIA
        FROM OR_ORDER O,
             OR_ORDER_ITEMS OT,
             GE_ITEMS GI,
             OR_OPERATING_UNIT OU,
             GE_CAUSAL GC
       WHERE OT.ORDER_ID = O.ORDER_ID
         AND GI.ITEMS_ID = OT.ITEMS_ID
         AND OU.OPERATING_UNIT_ID(+) = O.OPERATING_UNIT_ID
         AND OT.VALUE <> 0
         AND GI.ITEM_CLASSIF_ID IN (SELECT item_classif_id
                                      FROM ge_item_classif WHERE ',' || (SELECT casevalo
                                                                                FROM ldci_carasewe
                                                                               WHERE casecodi = 'MATERIHERRA') ||
                                                                              ',' LIKE '%,' || item_classif_id ||
                                    ',%')
         AND O.TASK_TYPE_ID <> 0
         AND O.ORDER_STATUS_ID = 8
         AND O.CAUSAL_ID = GC.CAUSAL_ID
         AND GC.CLASS_CAUSAL_ID = 1
         AND O.LEGALIZATION_DATE >= dtfefein --dtfefein
         AND O.LEGALIZATION_DATE <= dtfefefin --dtfefefin
      )
      GROUP BY PRODUCTO, ORDER_ID, DEPTO, LOCALI, TIPOTRABAJO, CLASIFICADOR, CATEGORIA
      ) WHERE CUENTA LIKE '7%'
      GROUP BY PRODUCTO, ORDER_ID, DEPTO, LOCALI, TIPOTRABAJO, CLASIFICADOR, CATEGORIA, CUENTA;

       cursor cuCostMaterial is
       with clasificador as(
  select distinct
         cl.clcocodi,
         cl.clcodesc,
         lc.cuctcodi,
         lc.cuctdesc,
         t.task_type_id,
         t.concept
    from ic_clascott ic
   inner join ic_clascont cl on cl.clcocodi=ic.clctclco
   inner join ldci_cugacoclasi lg on lg.cuenclasifi = ic.clctclco
   inner join ldci_cuentacontable lc on lc.cuctcodi=lg.cuencosto
   inner join or_task_type t on t.task_type_id=ic.clcttitr
   where lc.cuctcodi like '7%'),
  items as( select /*+ index (i IDX_GE_ITEMS_02)*/ i.items_id, i.description from ge_items i where i.item_classif_id in (3,8,21))
  select /*+ index(o IDX_OR_ORDER16) index(oi IDX_OR_ORDER_ITEMS_01)*/
         o.order_id,
         decode(o.task_type_id, 10336, o.real_task_type_id, o.task_type_id) task_type_id,
         sum(Decode(OI.OUT_, 'N', -1, 1)*OI.VALUE)+sum( round(Decode(OI.OUT_, 'N', -1, 1)*OI.VALUE*(pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_VALOR_IVA') / 100), 4)) ,
         (select a.product_id from or_order_activity a where a.order_id=o.order_id and rownum=1) producto,
         (select a.activity_id from or_order_activity a where a.order_id=o.order_id and a.task_type_id=decode(o.task_type_id, 10336, o.real_task_type_id, o.task_type_id) and a.final_date is null and rownum=1) actividad,
         cl.clcocodi,
         cl.clcodesc,
         cl.cuctcodi cuenta,
         cl.cuctdesc nom_cuenta,
         cl.concept,
         o.operating_unit_id unidad,
         daor_operating_unit.fsbgetname(o.operating_unit_id,null) nombre
  from or_order o
  inner join clasificador cl on cl.task_type_id=decode(o.task_type_id, 10336, o.real_task_type_id, o.task_type_id)
  inner join or_order_items oi on oi.order_id=o.order_id
  inner join items i on i.items_id=oi.items_id
  where o.order_status_id=8
    and trunc(o.legalization_date)>=dtfefein
    and trunc(o.legalization_Date)<=dtfefefin
    and oi.value!=0
    group by o.order_id,
         decode(o.task_type_id, 10336, o.real_task_type_id, o.task_type_id),
         cl.clcocodi,
         cl.clcodesc,
         cl.cuctcodi,
         cl.cuctdesc,
         cl.concept,
         o.operating_unit_id;



      nuOrden  number;
      nuCantid number;
  BEGIN

    -- Se incializan Variables de trabajo
    nucantiregcom := 0;
    nucantiregtot := 0;
    DELETE ldc_osf_costingr l WHERE l.nuano = inuAno AND l.numes = inuMes AND l.tipo IN  ('COST_MAT');
    COMMIT;
    --

    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Empieza Costo Materiales'
    );

    for reg in cuCostMaterial loop
      nuOrden:=reg.order_id;
        insert into ldc_osf_costingr(nuano,numes,product_id,cate,tipo,acta,factura,fecha,contratista,nombre,titr,cuenta,nom_cuenta,clasificador,actividad,concept,costo,iva,
                                     ing_otro,notas,ing_int_mig,ing_cxc_mig,ing_rp_mig,ing_int_osf,ing_cxc_osf,ing_rp_osf,ing_int_con,ing_cxc_con,ing_rp_con,total_ingreso,utilidad,margen,order_id)
                             values(inuano, inumes, reg.producto, dapr_product.fnugetcategory_id(reg.producto,null),'COST_MAT',null, null, null, reg.unidad, reg.nombre, reg.task_type_id, reg.cuenta, reg.nom_cuenta,reg.clcocodi, reg.actividad,reg.concept, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,reg.order_id);
        nuCantid:=nuCantid+1;
        if nuCantid>=nuCommit then
           Commit;
           nuCantid:=0;
        end if;
    end loop;
    --
    COMMIT;
    --
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Termina Costo Materiales'
    );
    return 0;
    --
    EXCEPTION
      WHEN OTHERS THEN
        sbmensa:='FnuGeneCostosMat : Error procesando Orden :'||nuOrden||'-'||sqlerrm;
        return -1;
  END FnuGeneCostosMat;

 -- Funcion que ejecuta el proceso de ingresos
  FUNCTION FnuGeneIngresos(  inuAno      IN number,
                             inuMes      IN number,
                             dtfefein    IN DATE,
                             dtfefefin   IN DATE,
                             sbCorreo    IN VARCHAR2,
                             sbTipoBD    IN VARCHAR2,
                             sbmensa     OUT VARCHAR2,
                             error       OUT NUMBER
                           )
  RETURN NUMBER IS

  /*****************************************************************************
  Propiedad intelectual Gases del Caribe.

  Function:     FnuGeneIngresos
  Descripcion:  Funcion encargada de generar todo el Ingreso

  Autor:        HORBATH TECHNOLOGIES
  Fecha:        23-04-2020

  Historia de modificaciones

  Fecha       Autor     Modificacion
  18/11/2020  HT        CA-576 se controla que solo se busque el clasificador de costo solo cuando es de una
                        solicitud, esto con el fin de evitar error en la busqueda esta.

  **************************************************************************************************************/


  sbClasiIngresos  LDCI_CARASEWE.CASEVALO%type;
  osbErrorMessage  ge_error_log.description%TYPE;
  errorPara01      EXCEPTION;        -- Excepcion que verifica que ingresen los parametros de entrada

   Cursor CuIngresos IS
    -- Consulta unificada del INgreso.
    -- Facturacion
    SELECT ESTADO, CARGNUSE, SESUCATE, TIPO, CLASITT, CARGCONC, CLASIFICADOR,
           CUENTA_COS,
           CASE WHEN CUENTA_COS IS NULL THEN
               CUENTA
             ELSE
               CUENTA_COS
           END CUENTA,
           (SELECT CU.CUCTDESC FROM LDCI_CUENTACONTABLE CU
             WHERE CU.CUCTCODI = (CASE WHEN CUENTA_COS IS NULL THEN
                                       CUENTA
                                     ELSE
                                       CUENTA_COS
                                  END)
           ) NOMCUENTA,
           SUM(ING_OTRO) ING_OTRO,
           SUM(NOTAS) NOTAS,
           SUM(ING_CXC_OSF) ING_CXC_OSF,
           SUM(ING_INT_OSF) ING_INT_OSF,
           SUM(ING_RP_OSF)ING_RP_OSF,
           SUM(TOT_INGRESO) TOT_INGRESO,
           SOLICITUD, ORDEN
    FROM
    (
    SELECT ESTADO, CARGNUSE, SESUCATE, TIPO, CLASITT, CARGCONC, CLASIFICADOR,
           (SELECT lg.cuencosto from ldci_cugacoclasi lg
             WHERE lg.cuenclasifi = CLASIFICADOR) CUENTA_COS, CUENTA,
           SUM(ING_OTRO) ING_OTRO,
           SUM(NOTAS) NOTAS,
           SUM(ING_CXC_OSF) ING_CXC_OSF,
           SUM(ING_INT_OSF) ING_INT_OSF,
           SUM(ING_RP_OSF)ING_RP_OSF,
           SUM(TOT_INGRESO) TOT_INGRESO,
           SOLICITUD, ORDEN
    FROM
    (
    SELECT ESTADO, CARGNUSE, SESUCATE, TIPO, CLASITT, CARGCONC,
           CASE WHEN CLASITT IS NULL THEN
               CLASIFICADOR
             ELSE
               CLASITT
           END CLASIFICADOR,
           (SELECT C.CUENINGRESO FROM LDCI_CUINGRECLASI C WHERE C.CUENCLASIFI = CLASIFICADOR) CUENTA,
           SUM(ING_OTRO) ING_OTRO,
           SUM(NOTAS) NOTAS,
           SUM(ING_CXC_OSF) ING_CXC_OSF,
           SUM(ING_INT_OSF) ING_INT_OSF,
           SUM(ING_RP_OSF)ING_RP_OSF,
           SUM(TOT_INGRESO) TOT_INGRESO,
           SOLICITUD, ORDEN
    FROM
    (
    select /*+ index (cr PK_CUENCOBR) */
           /*+ index (ss PK_SERVSUSC) */
           null ESTADO, cargnuse, sesucate, 'INGRESO' TIPO,
           CASE
              WHEN Concclco NOT IN (4,19,400) THEN
                 (select /*+ index (l K_LDC_OSF_COSTING)*/
                         clasificador
                    from ldc_osf_costingr l
                   where l.nuano = inuAno
                     and l.numes = inuMes
                     and product_id = cargnuse
                     and l.concept = cargconc
                     and l.tipo in ('ACTA_FRA','ACTA_S_F','SIN_ACTA','COSTO','IVA_FRA')
                     and rownum = 1)
              --<< CA-576
              WHEN Concclco IN (4,19,400) AND cargdoso like 'PP-%' THEN
              --ELSE
              -->>
                 (SELECT /*+ index (A IDX_OR_ORDER_ACTIVITY_06)*/
                         TT.CLCTCLCO
                    FROM OR_ORDER_ACTIVITY A, OR_TASK_TYPE T, IC_CLASCOTT TT
                   WHERE A.PACKAGE_ID = SUBSTR(cargdoso, 4)
                     AND A.PRODUCT_ID = CARGNUSE
                     AND A.TASK_TYPE_ID = T.TASK_TYPE_ID
                     AND T.CONCEPT = CARGCONC
                     AND T.TASK_TYPE_ID = TT.CLCTTITR
                     AND ROWNUM = 1)
           END Clasitt,
           cargconc, concclco clasificador,
           CASE WHEN
             concclco NOT IN (4,19,400) THEN
                sum(decode(cargsign, 'DB',cargvalo, cargvalo*-1))
             ELSE
               0
           END ING_OTRO,
           0 NOTAS,
           -- Servicios Nuevos
           CASE WHEN
             concclco IN (4) THEN
                sum(decode(cargsign, 'DB',cargvalo, cargvalo*-1))
             ELSE
               0
           END ING_CXC_OSF,
           CASE WHEN
             concclco IN (19) THEN
                sum(decode(cargsign, 'DB',cargvalo, cargvalo*-1))
             ELSE
               0
           END ING_INT_OSF,
           CASE WHEN
             concclco IN (400) THEN
                sum(decode(cargsign, 'DB',cargvalo, cargvalo*-1))
             ELSE
               0
           END ING_RP_OSF,
           SUBSTR(cargdoso, 4) SOLICITUD,
           cargcodo orden,
           sum(decode(cargsign, 'DB',cargvalo, cargvalo*-1)) TOT_INGRESO
      from cargos c, servsusc ss, concepto oo, cuencobr cr, factura f
     where cucocodi =  cargcuco
       AND cucofact =  factcodi
       AND cargnuse =  sesunuse
       AND factfege >= dtfefein --to_Date('01/03/2020 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
       AND factfege <= dtfefefin --to_Date('31/03/2020 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
       And sesuserv = 7014
       AND cargfecr <= dtfefefin --to_Date('31/03/2020 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
       AND cargcuco > 0
       AND cargtipr = 'A'
       AND cargsign in ('DB','CR')
       and cargcaca in (4,41,53)
       and cargconc = conccodi
       and concclco in (select tt.clcocodi from ic_clascont tt where ',' || sbClasiIngresos || ',' LIKE '%,' || tt.clcocodi || ',%')
                --       (4, 19, 400, -- Conceptos de la venta
                --       17,         -- Reconexion.
                --        22,         -- Reinstalacion.
                --        27,         -- S.A. Red Interna.
                --        28, 89,     -- Mtto Industrial y modif. centro de medicion.
                --        81, 118,    -- Serv Varios Grabados.
                --        401         -- Revision Periodica
                --        )
    Group by cargnuse, cargconc, sesucate, cargcodo, concdesc, concclco, cargdoso
    --
    UNION ALL
    --
    -- Notas /*+ index(c IX_CARG_NUSE_CUCO_CONC) */
    select
           NULL ESTADO, cargnuse, sesucate, 'INGRESO' TIPO,
           (select clasificador from ldc_osf_costingr l
             where l.nuano = inuAno
               and l.numes = inuMes
               and product_id = cargnuse
               and l.concept = cargconc
               and l.tipo in ('ACTA_FRA','ACTA_S_F','SIN_ACTA','COSTO','IVA_FRA')
               and rownum = 1
            ) Clasitt,
           cargconc, concclco clasificador,
           0 ING_OTRO,
           Sum(decode(cargsign, 'DB',cargvalo, cargvalo*-1)) NOTAS,
           0 ING_CXC_OSF,
           0 ING_INT_OSF,
           0 ING_RP_OSF,
           NULL Solicitud,
           NULL orden,
           sum(decode(cargsign, 'DB',cargvalo, cargvalo*-1)) TOT_INGRESO
      from cargos c, servsusc ss, concepto oo
     where cargnuse =  sesunuse
       and cargcuco >  1
       and cargconc =  conccodi
       and concclco in (select tt.clcocodi from ic_clascont tt where ',' || sbClasiIngresos || ',' LIKE '%,' || tt.clcocodi || ',%')
           --            (4, 19, 400, -- Conceptos de la venta
           --             17,         -- Reconexion.
           --             22,         -- Reinstalacion.
           --             27,         -- S.A. Red Interna.
           --             28, 89,     -- Mtto Industrial y modif. centro de medicion.
           --             81, 118,    -- Serv Varios Grabados.
           --             401         -- Revision Periodica
           --             )
       and sesuserv =  7014
       and cargfecr >= dtfefein --dtfefein --dtcurfein
       and cargfecr <= dtfefefin --'01-04-2020' --dtcurfefi
       and cargtipr = 'P'
       and cargcaca IN (SELECT CACACODI
                          FROM CAUSCARG
                         WHERE ',' || (SELECT casevalo
                                          FROM ldci_carasewe
                                         WHERE casecodi = 'CACA_INGRESO_COSTO') || ',' LIKE '%,' || CACACODI || ',%')
       and cargsign IN ('DB','CR')
       and cargdoso like 'N%'
    Group by cargnuse, cargconc, sesucate, concclco, concdesc
    ) GROUP BY ESTADO, CARGNUSE, SESUCATE, TIPO, CLASITT, CARGCONC, CLASIFICADOR, SOLICITUD, ORDEN
    ) GROUP BY ESTADO, CARGNUSE, SESUCATE, TIPO, CLASITT, CARGCONC, CLASIFICADOR, SOLICITUD, ORDEN, CUENTA
    ) GROUP BY ESTADO, CARGNUSE, SESUCATE, TIPO, CLASITT, CARGCONC, CLASIFICADOR, SOLICITUD, ORDEN, CUENTA,CUENTA_COS ;


  BEGIN
    --Se cargan los parametros
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASCONT_INGRE_COSTOS', sbClasiIngresos, osbErrorMessage);
    if(osbErrorMessage != '0') then
           RAISE errorPara01;
    end if;--if(osbErrorMessage != '0') then

    DELETE ldc_osf_costingr l WHERE l.nuano = inuAno AND l.numes = inuMes and l.tipo in ('INGRESO','NOTAS');
    COMMIT;
    -- Se incializan Variables de trabajo
    nucantiregcom := 0;
    nucantiregtot := 0;

    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Empieza Ingresos'
    );

    --
    For I In CuINgresos Loop

    			INSERT INTO ldc_osf_costingr
							 (
							  nuano
							 ,numes
				  --           ,estado
							 ,product_id
							 ,cate
							 ,tipo
							 ,acta
							 ,factura
							 ,fecha
							 ,contratista
							 ,nombre
							 ,titr
							 ,cuenta
							 ,nom_cuenta
							 ,clasificador
							 ,actividad
							 ,concept
							 ,costo
							 ,iva
							 ,ing_otro
							 ,notas
							 ,ing_int_mig
							 ,ing_cxc_mig
							 ,ing_rp_mig
							 ,ing_int_osf
							 ,ing_cxc_osf
							 ,ing_rp_osf
							 ,ing_int_con
							 ,ing_cxc_con
							 ,ing_rp_con
							 ,total_ingreso
							 ,utilidad
							 ,margen
							 ,order_id
							 )
					  VALUES
							(
							 inuAno
						   ,inuMes
					  --     ,i.estado
						   ,i.cargnuse
						   ,i.sesucate
						   ,'INGRESO'
						   ,NULL
						   ,NULL
						   ,NULL
						   ,NULL  -- i.contratista
						   ,NULL  -- i.nombre
						   ,NULL -- i.tipotrabajo
						   ,i.cuenta
						   ,i.nomcuenta
						   ,i.clasificador
						   ,NULL
						   ,I.CARGCONC
						   ,0
						   ,0
						   ,i.ING_OTRO
						   ,i.Notas
						   ,0 --i.ing_int_mig
						   ,0 --i.ing_cxc_mig
						   ,0 --i.ing_rp_mig
						   ,i.ING_INT_OSF
						   ,i.ING_CXC_OSF
						   ,i.ING_RP_OSF
						   ,0 --i.ing_int_con
						   ,0 --i.ing_cxc_con
						   ,0 --i.ing_rp_con
						   ,i.TOT_INGRESO
						   ,0 --i.utilidad
						   ,0 --round(i.margen,2)
						   ,i.ORDEN --
						   );
			--
			nucantiregcom := nucantiregcom + 1;
			IF nucantiregcom >= nucontareg THEN
				COMMIT;
				nucantiregtot := nucantiregtot + nucantiregcom;
				nucantiregcom := 0;
			END IF;
      --
    END LOOp;
    --
    COMMIT;
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Termina Ingresos'
    );


    --
    return 0;
    --
  Exception
     When Errorpara01 then
      sbmensa := ('ERROR: [FnuGeneIngresos]: ' || sqlerrm);
      return -1;
  END FnuGeneIngresos;

 -- Funcion que ejecuta el proceso del ingreso de servicios cumplidos
  FUNCTION FnuGeneIngreServCump(  inuAno      IN number,
                                  inuMes      IN number,
                                  dtfefein    IN DATE,
                                  dtfefefin   IN DATE,
                                  sbCorreo    IN VARCHAR2,
                                  sbTipoBD    IN VARCHAR2,
                                  sbmensa     OUT VARCHAR2,
                                  error       OUT NUMBER
                                )
  RETURN NUMBER IS

  /*****************************************************************************
  Propiedad intelectual Gases del Caribe.

  Function:     FnuGeneIngreServCump
  Descripcion:  Funcion encargada de generar el Ingreso de los servicios cumplidos.

  Autor:        HORBATH TECHNOLOGIES
  Fecha:        23-04-2020

  Historia de modificaciones
  Fecha       Autor     Modificacion

  19/07/2020    HT      CA-0000447 Se modifica el proceso de buscar el ingreso por los servicios cumplidos, funcion
                        FnuGeneIngreServCump, se reportara por orden de trabajo legalizada en el mes indicado.
                        Se omitira el ingreso reportado por productos conectados antes del 7 de julio/2020 y de las
                        ordenes de interna reportadas por orden de apoyo.

  27/09/2024  EDMLAR    OSF-3284 - Se modifica la funcion FnuGeneIngreServCump, el WITH de CARGOS, se optimiza la consulta 
                        para que no se demore la ejecucion de este proceso.

  **************************************************************************************************************/


  sbClasiIngresos  LDCI_CARASEWE.CASEVALO%type;
  osbErrorMessage  ge_error_log.description%TYPE;
  errorPara01      EXCEPTION;

  -- Cursor de servicios cumplidos..
  Cursor CuCumplidos IS
    -- SC UNIFICADO
        select PRODUCT_ID, sesucate, cargconc, orden, clasificador, TITR, CLASITT,
               (SELECT lg.cuencosto from ldci_cugacoclasi lg
                 WHERE lg.cuenclasifi = CLASITT) CUENTA,
               (select cb.cuctdesc from ldci_cuentacontable cb
                 where cb.cuctcodi in (SELECT lg.cuencosto from ldci_cugacoclasi lg
                                        WHERE lg.cuenclasifi = CLASITT)
               ) nomcuenta,
               --cuenta,  nomcuenta,
               -- MIGRADOS
               SUM(ING_CXC_M) ING_CXC_M,
               SUM(ING_INT_M) ING_INT_M,
               SUM(ING_CER_M) ING_CER_M,
               -- CONSTRUCTORAS
               SUM(ING_CXC) ING_CXC,
               SUM(ING_INT) ING_INT,
               SUM(ING_CER) ING_CER,
               -- TOTAL INGRESO
               SUM(TOT_INGRE) TOT_INGRE
        from
        (
        -- Constructoras
        -- OSF-1402
        with cargo as
        (
          Select  cargdoso, concclco, cargconc, concdesc, cargsign, sum(decode(cargsign,'CR',-cargvalo,cargvalo)) cargvalo, sum(decode(cargsign, 'DB', cargunid, -cargunid)) cargunid
           FROM   cargos c,
                  servsusc,
                  cuencobr,
                  factura,
                  concepto
          WHERE   factfege >= to_date('01-01-2021', 'dd-mm-yyyy')
                  AND factfege <= dtfefefin 
                  AND cucofact = factcodi
                  AND cucocodi = cargcuco
                  AND cargcuco != -1
                  AND sesunuse = cargnuse
                  And sesuserv = 6121
                  AND cargfecr <= dtfefefin 
                  AND cargcuco > 0
                  AND cargtipr = 'A'
                  AND cargsign in ('DB','CR')
                  and cargcaca in (53)
                  and cargdoso like 'PP-%'
                  and cargdoso not like 'PP-%-ADD'
          --        AND CARGDOSO = 'PP-205324480'
                  and cargconc = conccodi
                  and concclco in (4,19,400)
          Group by cargdoso, cargconc, concdesc, cargsign, concclco  
         )
        select 'CONSTRUCTORAS' TIPO, A.PRODUCT_ID, sesucate, cargconc, concclco clasificador, o2.order_id orden, o2.task_type_id TITR,
               (select tt.clctclco from ic_clascott tt where tt.clcttitr = o2.task_type_id) clasitt,
               CASE WHEN
                 concclco IN (4) THEN
                    ((ca.cargvalo/ca.cargunid))
                 ELSE
                   0
               END ING_CXC,
               CASE WHEN
                 concclco IN (19) THEN
                    ((ca.cargvalo/ca.cargunid))
                 ELSE
                   0
               END ING_INT,
               CASE WHEN
                 concclco IN (400) THEN
                    ((ca.cargvalo/ca.cargunid))
                 ELSE
                   0
               END ING_CER,
               0 ING_CXC_M,
               0 ING_INT_M,
               0 ING_CER_M,
               ((ca.cargvalo/ca.cargunid)) TOT_INGRE
          from or_order o2
         inner join ge_causal c ON c.causal_id = o2.causal_id and c.class_causal_id = 1
         inner join or_order_activity a ON a.order_id = o2.order_id
         inner join or_task_type tt ON tt.task_type_id = o2.task_type_id
         inner join mo_packages m ON m.package_id = a.package_id and m.package_type_id = 323
         inner join cargo ca ON cargdoso = 'PP-'||a.package_id and cargconc = tt.concept
         --inner join concepto ON conccodi = cargconc and concclco in (4,19,400)
         inner join servsusc sc ON sc.sesunuse = a.product_id
         inner join suscripc su ON su.susccodi = sc.sesususc
         inner join ab_address ab ON ab.address_id = su.susciddi
         where trunc(o2.legalization_date) >= dtfefein --'01-03-2019'
           and trunc(o2.legalization_date) <= dtfefefin --'01-04-2019'
           and o2.order_status_id = 8
        --   and trunc(o2.created_date ) <   dtfefefin + 1
           and (
                (o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                 FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo FROM LDCI_CARASEWE C
                                                                                 WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_INTERNA'),',') )) and
                 concclco in (19) and -- Interna
                 a.product_id not in (select act.product_id
                                        from or_order_activity act, or_order oo
                                       where act.product_id = a.product_id
                                         and oo.task_type_id in (SELECT (COLUMN_VALUE)
                                                                   FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                                             FROM LDCI_CARASEWE C
                                                                                                            WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_OT_APOYO'),',') ))
                                         and act.order_id = oo.order_id
                                         and oo.legalization_date < to_date((SELECT casevalo
                                                                               FROM LDCI_CARASEWE C
                                                                              WHERE C.CASECODI = 'FECHA_FIN_ORDEN_DE_APOYO'))
                                     )
                )
              OR
                (
                  o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                        FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                FROM LDCI_CARASEWE C
                                                                               WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_C_X_C'),',') )) and
                  concclCo = 4 -- cxc
                )
              OR
                (
                  o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                        FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                FROM LDCI_CARASEWE C
                                                                               WHERE C.CASECODI = 'TIPO_DE_TRABAJO_CERTIF_PREVIA'),',')) ) and
                  concclco = 400 -- Cert Previa
                )
               )
           AND o2.order_id not in (select oo.related_order_id
                                     from OR_related_order oo
                                    where oo.related_order_id = o2.order_id
                                      and oo.rela_order_type_id in (13,14)
                                  )
           AND a.product_id NOT IN (SELECT hcecnuse
                                      FROM hicaesco h
                                     WHERE hcecfech < to_date((SELECT casevalo
                                                                 FROM LDCI_CARASEWE C
                                                                WHERE C.CASECODI = 'FECHA_INICIO_INGRESO_X_ORDEN'))
                                       AND hcecnuse = a.product_id
                                       AND hcececan = 96
                                       AND hcececac = 1
                                       AND hcecserv = 7014)
        --
        UNION ALL
        --
        -- Consulta Servicio Cumplido Migrado
        select 'MIGRADOS' TIPO,  A.PRODUCT_ID, sesucate, conccodi, concclco clasificador, o2.order_id, o2.task_type_id TITR,
               (select tt.clctclco from ic_clascott tt where tt.clcttitr = o2.task_type_id) clasitt,
               0 ING_CXC,
               0 ING_INT,
               0 ING_CER,
               CASE WHEN
                 concclco IN (4) THEN
                    (mi.invmvain)
                 ELSE
                   0
               END ING_CXC_M,
               CASE WHEN
                 concclco IN (19) THEN
                    (mi.invmvain)
                 ELSE
                   0
               END ING_INT_M,
               CASE WHEN
                 concclco IN (400) THEN
                    (mi.invmvain)
                 ELSE
                   0
               END ING_CER_M,
               (mi.invmvain) TOT_INGRE
         from or_order o2
         inner join ge_causal c ON c.causal_id = o2.causal_id and c.class_causal_id = 1
         inner join or_order_activity a ON a.order_id = o2.order_id
         inner join mo_packages m on m.package_id = a.package_id and m.package_type_id = 100271 -- 323
         inner join Ldci_Ingrevemi mi ON mi.invmsesu = a.product_id
         inner join concepto o ON conccodi = mi.invmconc
         inner join servsusc sc ON sc.sesunuse = a.product_id
         inner join suscripc su ON su.susccodi = sc.sesususc
         inner join ab_address ab ON ab.address_id = su.susciddi
         where trunc(o2.legalization_date) >= dtfefein -- '01-03-2019'
           and trunc(o2.legalization_date) < dtfefefin --'01-04-2019'
           and o2.order_status_id = 8
        --   and trunc(o2.created_date ) <=  '01-03-2019' --dtfefefin
           and (
                  (o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                         FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo FROM LDCI_CARASEWE C
                                                                                         WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_INTERNA'),',') )) and
                   concclco in (19) and -- Interna
                   a.product_id not in (select act.product_id
                                           from or_order_activity act, or_order oo
                                          where act.product_id = a.product_id
                                            and oo.task_type_id in (SELECT (COLUMN_VALUE)
                                                                     FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                                                     FROM LDCI_CARASEWE C
                                                                                                                    WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_OT_APOYO'),',') ))
                                            and act.order_id = oo.order_id
                                            and oo.legalization_date < to_date((SELECT casevalo
                                                                                  FROM LDCI_CARASEWE C
                                                                                 WHERE C.CASECODI = 'FECHA_FIN_ORDEN_DE_APOYO'))
                                        )
                  )

              OR
                (
                 o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                       FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                        FROM LDCI_CARASEWE C
                                                                                       WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_C_X_C'),',') )) and
                 concclCo = 4 -- cxc
                )
              OR
                (
                 o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                       FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                        FROM LDCI_CARASEWE C
                                                                                       WHERE C.CASECODI = 'TIPO_DE_TRABAJO_CERTIF_PREVIA'),',')) ) and
                 concclco = 400 -- Cert Previa
                )

              )
           AND o2.order_id not in (select oo.related_order_id
                                     from OR_related_order oo
                                    where oo.related_order_id = o2.order_id
                                      and oo.rela_order_type_id in (13,14)
                                  )
           AND a.product_id NOT IN (SELECT hcecnuse
                                      FROM hicaesco h
                                     WHERE hcecfech < to_date((SELECT casevalo
                                                                 FROM LDCI_CARASEWE C
                                                                WHERE C.CASECODI = 'FECHA_INICIO_INGRESO_X_ORDEN'))
                                       AND hcecnuse = a.product_id
                                       AND hcececan = 96
                                       AND hcececac = 1
                                       AND hcecserv = 7014)
        ) GROUP BY PRODUCT_ID, sesucate, cargconc, orden, clasificador, TITR, CLASITT; --, cuenta, nomcuenta;
   -- END CA-447
   -->>

  Begin

    -- Se incializan Variables de trabajo
    nucantiregcom := 0;
    nucantiregtot := 0;
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Empieza ServCumplidos'
    );

    DELETE ldc_osf_costingr l WHERE l.nuano = inuAno AND l.numes = inuMes and l.tipo='ING_CUMP';
    COMMIT;
    For I in CuCumplidos loop

    			INSERT INTO ldc_osf_costingr
							 (
							  nuano
							 ,numes
				  --           ,estado
							 ,product_id
							 ,cate
							 ,tipo
							 ,acta
							 ,factura
							 ,fecha
							 ,contratista
							 ,nombre
							 ,titr
							 ,cuenta
							 ,nom_cuenta
							 ,clasificador
							 ,actividad
							 ,concept
							 ,costo
							 ,iva
							 ,ing_otro
							 ,notas
							 ,ing_int_mig
							 ,ing_cxc_mig
							 ,ing_rp_mig
							 ,ing_int_osf
							 ,ing_cxc_osf
							 ,ing_rp_osf
							 ,ing_int_con
							 ,ing_cxc_con
							 ,ing_rp_con
							 ,total_ingreso
							 ,utilidad
							 ,margen
							 ,order_id
							 )
					  VALUES
							(
							 inuAno
						   ,inuMes
					  --     ,i.estado
						   ,i.product_id   --i.invmsesu
						   ,i.sesucate
						   ,'ING_CUMP'
						   ,NULL
						   ,NULL
						   ,NULL
						   ,NULL  -- i.contratista
						   ,NULL  -- i.nombre
						   ,i.TITR -- NULL -- i.tipotrabajo
						   ,i.cuenta
						   ,i.nomcuenta
						   ,i.clasificador
						   ,NULL
						   ,i.cargconc  --i.invmconc
						   ,0
						   ,0
						   ,0 --i.ING_OTRO
						   ,0 --i.Notas
						   ,i.ing_int_m
						   ,i.ing_cxc_m
						   ,i.ing_cer_m
						   ,0 --i.ING_INT_OSF
						   ,0 --i.ING_CXC_OSF
						   ,0 --i.ING_RP_OSF
						   ,i.ing_int
						   ,i.ing_cxc
						   ,i.ing_cer
						   ,i.TOT_INGRE
						   ,0 --i.utilidad
						   ,0 --round(i.margen,2)
						   ,i.ORDEN --
						   );
        --
        nucantiregcom := nucantiregcom + 1;
        IF nucantiregcom >= nucontareg THEN
          COMMIT;
          nucantiregtot := nucantiregtot + nucantiregcom;
          nucantiregcom := 0;
        END IF;

    end loop;

    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbmail,
        isbAsunto           => 'Costo Ingreso  :'||FSBGETDESCMES(inuMes),
        isbMensaje          => 'Termina ServCumplidos'
    );

    return 0;
  Exception
     When others then
      sbmensa := ('ERROR: [FnuGeneIngreServCump]: ' || sqlerrm);
      return -1;
  end;


end LDC_PKCOSTOINGRESO;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKCOSTOINGRESO
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKCOSTOINGRESO', 'ADM_PERSON'); 
END;
/  
