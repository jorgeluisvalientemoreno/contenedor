CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKCRMCONSULTA AS
  /*
   * Propiedad Intelectual Gases del Caribe
   *
   *
   * Autor   : F.Castro
   * Fecha   : 5-05-2016
   * Descripcion : Paquete que devuelve informacion de los Contratos
                   para los sistemas moviles

   *
   * Historia de Modificaciones
   * Autor                   Fecha         Descripcion
   */
PROCEDURE procConsultaDatosCliente (ISBSISTEMA      IN   VARCHAR2,
                                    ISBXML          IN   CLOB,
                                    CUCLIENTE       OUT  SYS_REFCURSOR,
                                    CUCONTRATO      OUT  SYS_REFCURSOR,
                                    CUPRODUCTO      OUT  SYS_REFCURSOR,
                                    CUBRILLA        OUT  SYS_REFCURSOR,
                                    CUFACTURACION   OUT  SYS_REFCURSOR,
                                    CUCARTERA       OUT  SYS_REFCURSOR,
                                    onuErrorCode    OUT  NUMBER,
                                    osbErrorMessage OUT  VARCHAR2);

PROCEDURE procValidaParametros (idCliente        in out number,
                                idContrato       in out number,
                                idProducto      in out number,
                                idMatricula     in number,
                                idOrden         in number,
                                idMedidor       in varchar2,
                                infoFacturacion in varchar2,
                                infoCartera     in varchar2,
                                infoBrilla      in varchar2,
                                onuErrorCode     OUT NUMBER,
                                osbErrorMessage  OUT VARCHAR2);

FUNCTION fnuGetClienCont      (inuProducto      IN servsusc.sesunuse%type,
                               onuCliente       OUT suscripc.suscclie%type,
                               onuContrato      OUT suscripc.susccodi%type,
                               onuErrorCode     OUT NUMBER,
                               osbErrorMessage  OUT VARCHAR2) return boolean;

FUNCTION fnuGetServGas        (inuCliente       IN suscripc.suscclie%type,
                               onuErrorCode     OUT NUMBER,
                               osbErrorMessage  OUT VARCHAR2) return number;

FUNCTION fsbGetPlanUltRefi  (inuNuse IN suscripc.suscclie%type) return varchar2;


FUNCTION fnuGetCliente        (inuContrato      IN servsusc.sesunuse%type,
                               onuCliente       OUT suscripc.suscclie%type,
                               onuErrorCode     OUT NUMBER,
                               osbErrorMessage  OUT VARCHAR2) return boolean;

FUNCTION fnuGetSubscriber     (inuCliente       IN  suscripc.suscclie%type,
                               onuErrorCode     OUT NUMBER,
                               osbErrorMessage  OUT VARCHAR2) return boolean;

PROCEDURE procConsDatosCliente(inuClie          IN  suscripc.suscclie%type,
                               CUCLIENTE        OUT SYS_REFCURSOR,
                               onuErrorCode     OUT NUMBER,
                               osbErrorMessage  OUT VARCHAR2);

PROCEDURE procConsDatosContrato(inuClie          IN  suscripc.suscclie%type,
                                inuSusc          IN  suscripc.susccodi%type,
                                CUCONTRATO       OUT SYS_REFCURSOR,
                                onuErrorCode     OUT NUMBER,
                                osbErrorMessage  OUT VARCHAR2);

PROCEDURE procConsDatosProducto(inuClie          IN  suscripc.suscclie%type,
                                inuSusc          IN  suscripc.susccodi%type,
                                inunuse          IN  servsusc.sesunuse%type,
                                CUPRODUCTO        OUT SYS_REFCURSOR,
                                onuErrorCode     OUT NUMBER,
                                osbErrorMessage  OUT VARCHAR2);

PROCEDURE procBrilla (inuClie          IN  suscripc.suscclie%type,
                      inuSusc          IN  suscripc.susccodi%type,
                      CUBRILLA         OUT SYS_REFCURSOR,
                      onuErrorCode     OUT NUMBER,
                      osbErrorMessage  OUT VARCHAR2);

PROCEDURE procConsDatosBrilla (inuSusc          IN  suscripc.susccodi%type,
                               onuCupo_asignado out number,
                               onuCupo_Usado    out number,
                               onuCupo_Disponible out number,
                               onunroComprasBrillaUltAno out number,
                               onunroComprasBrillaTotal out number,
                               onuErrorCode     OUT NUMBER,
                               osbErrorMessage  OUT VARCHAR2);

PROCEDURE procConsDatosCartera (inuClie          IN  suscripc.suscclie%type,
                                inuSusc          IN  suscripc.susccodi%type,
                                inunuse          IN  servsusc.sesunuse%type,
                                CUCARTERA        OUT SYS_REFCURSOR,
                                onuErrorCode     OUT NUMBER,
                                osbErrorMessage  OUT VARCHAR2);

PROCEDURE procFacturacion (inuClie          IN  suscripc.suscclie%type,
                           inuSusc          IN  suscripc.susccodi%type,
                           CUFACTURACION    OUT SYS_REFCURSOR,
                           onuErrorCode     OUT NUMBER,
                           osbErrorMessage  OUT VARCHAR2);


PROCEDURE procConsDatosFacturacion (inuSusc               IN  suscripc.susccodi%type,
                                    inunuse               IN  servsusc.sesunuse%type,
                                    onuconsumopromedio    out number,
                                    osbNumeroMedidor      out varchar2,
                                    onulecturaanterior    out number,
                                    onulecturaactual      out number,
                                    odtfechalectura       out date,
                                    onuconsumo            out number,
                                    onufactorcorreccion   out number,
                                    onuconsumofacturado   out number,
                                    osbfactpromedio       out varchar2,
                                    odtfechafactura       out date,
                                    onuvalorfacturado     out number,
                                    onuidcupon            out number,
                                    odtfechalimitepago    out date,
                                    onudiasmora           out number,
                                    onuvalorpagado        out number,
                                    odtfechapago          out date,
                                    onuErrorCode          OUT NUMBER,
                                    osbErrorMessage       OUT VARCHAR2);

PROCEDURE procSetCursorBrillaNull (CUBRILLA    OUT SYS_REFCURSOR);


END LDCI_PKCRMCONSULTA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKCRMCONSULTA AS
  -- Carga variables globales


PROCEDURE prcCierraCursor(CUCURSOR IN OUT SYS_REFCURSOR) AS
  /************************************************************************
      FUNCTION : prcCierraCursor
       AUTOR   : Hector Fabio Dominguez
       FECHA   : 10/09/2013
       RICEF   : I045
   DESCRIPCION : Esta funcion se encarga de cerrar los cursores

   Historia de Modificaciones
   Autor                Fecha             Descripcion.
   HECTORFDV    10/09/2013  Creacion del paquete
  ************************************************************************/
BEGIN
  IF NOT CUCURSOR%ISOPEN THEN
    OPEN CUCURSOR FOR
      SELECT * FROM dual where 1 = 2;
  END IF;

END;

/***********************************************************************/
PROCEDURE procConsultaDatosCliente (ISBSISTEMA      IN   VARCHAR2,
                                    ISBXML          IN   CLOB,
                                    CUCLIENTE       OUT  SYS_REFCURSOR,
                                    CUCONTRATO      OUT  SYS_REFCURSOR,
                                    CUPRODUCTO      OUT  SYS_REFCURSOR,
                                    CUBRILLA        OUT  SYS_REFCURSOR,
                                    CUFACTURACION   OUT  SYS_REFCURSOR,
                                    CUCARTERA       OUT  SYS_REFCURSOR,
                                    onuErrorCode    OUT  NUMBER,
                                    osbErrorMessage OUT  VARCHAR2) is

  /**************************************************************************
  * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
  *
  * Procedimiento  : procConsultaDatosCliente
  * Autor   :        Sincecomp / F.Castro
  * Fecha   :        10-05-2016
  * Descripcion :    Procedimiento que devuelve Informacion del Contrato
  *
  * Historia de Modificaciones
  * Autor          Fecha       Descripcion
  * FCastro        10-05-2016  Version inicial
    Eduagu         06/07/2016  Se adicionan excepciones para que los cursores
                               queden abiertos pero envíen informacion vacía.
  ***************************************************************************/

  idCliente        number(15);  --  C?digo del cliente.
  idContrato       number(15);   --  Contrato.
  idProducto       number(15);   --Producto.
  idMatricula      number(15);  -- Matricula.
  idOrden          number(15);  -- Orden
  idMedidor        varchar2(50); -- medidor
  infoFacturacion  varchar2(1); -- indica si desea generar informaci?n de facturaci?n (S o N)
  infoCartera      varchar2(1); --  indica si se desea generar informaci?n de facturaci?n (S o N)
  infoBrilla       varchar2(1); --  indica si se desea consultar brilla (S o N)
  --nuServGas        servsusc.sesunuse%type;
  nuErrorCode      number;
  sbErrorMessage   varchar2(4000);
  --ISBXML2          clob;  -- se crea para pruebas
  exVAL_PARAM      exception;
  exERROR          exception;

BEGIN

  SELECT  x.*
  into idCliente, idContrato, idProducto, idMatricula, idOrden,
       idMedidor, infoBrilla, infoFacturacion, infoCartera
   FROM (select xmltype (/*ISBXML2*/ISBXML) data from dual) t,
        XMLTABLE ('/DatosEntrada'
                  PASSING t.data
                  COLUMNS idCliente number PATH 'idCliente',
                          idContrato number PATH 'IdContrato',
                          idProducto number PATH 'idProducto',
                          idMatricula number PATH 'idMatricula',
                          idOrden number PATH 'idOrden',
                          idMedidor VARCHAR2(50) PATH 'idMedidor',
                          infoBrilla VARCHAR2(1) PATH 'infoBrilla',
                          infoFacturacion VARCHAR2(1) PATH 'infoFacturacion',
                          infoCartera VARCHAR2(1) PATH 'infoCartera') x;


  --Evalua los parametros de Entrada
  procValidaParametros (idCliente,
                        idContrato,
                        idProducto,
                        idMatricula,
                        idOrden,
                        idMedidor,
                        infoFacturacion,
                        infoCartera,
                        infoBrilla,
                        nuErrorCode,
                        sbErrorMessage);

   --Si hubo error regresa con los valores del error
   if nuErrorCode = -1 then
     raise exVAL_PARAM;
   end if;

  --Consulta Datos del Cliente
  procConsDatosCliente(idCliente,CUCLIENTE,nuErrorCode,sbErrorMessage);
  if nuErrorCode != 0 then
    raise exERROR;
  end if;

  --Consulta Datos del Contrato
  procConsDatosContrato(idCliente,idContrato,CUCONTRATO,nuErrorCode,sbErrorMessage);
  if nuErrorCode != 0 then
    raise exERROR;
  end if;

  --Consulta Datos del Producto
  procConsDatosProducto(idCliente,idContrato,idProducto,CUPRODUCTO,nuErrorCode,sbErrorMessage);
  if nuErrorCode != 0 then
    raise exERROR;
  end if;

  --Consulta Datos Brilla
  if infoBrilla in ('S','s') then
    procBrilla(idCliente,idContrato,CUBRILLA,nuErrorCode,sbErrorMessage);
    if nuErrorCode != 0 then
      raise exERROR;
    end if;
  end if;

  --Consulta Datos de Cartera
  if infoCartera in ('S','s') then
    procConsDatosCartera(idCliente,idContrato,idProducto,CUCARTERA,nuErrorCode,sbErrorMessage);
    if nuErrorCode != 0 then
      raise exERROR;
    end if;
  end if;

  --Consulta Datos de Facturacion
  if infoFacturacion in ('S','s') then
    procFacturacion(idCliente,idContrato,CUFACTURACION,nuErrorCode,sbErrorMessage);
    if nuErrorCode != 0 then
      raise exERROR;
    end if;
  end if;

  prcCierraCursor(CUCLIENTE);
  prcCierraCursor(CUCONTRATO);
  prcCierraCursor(CUPRODUCTO);
  prcCierraCursor(CUBRILLA);
  prcCierraCursor(CUCARTERA);
  prcCierraCursor(CUFACTURACION);
  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Ok';

EXCEPTION
  When exVAL_PARAM then
    onuErrorCode := nuErrorCode;
    osbErrorMessage := sbErrorMessage;
    prcCierraCursor(CUCLIENTE);
    prcCierraCursor(CUCONTRATO);
    prcCierraCursor(CUPRODUCTO);
    prcCierraCursor(CUBRILLA);
    prcCierraCursor(CUCARTERA);
    prcCierraCursor(CUFACTURACION);

  When exERROR then
    onuErrorCode := nuErrorCode;
    osbErrorMessage := sbErrorMessage;
    prcCierraCursor(CUCLIENTE);
    prcCierraCursor(CUCONTRATO);
    prcCierraCursor(CUPRODUCTO);
    prcCierraCursor(CUBRILLA);
    prcCierraCursor(CUCARTERA);
    prcCierraCursor(CUFACTURACION);

  When others then
    onuErrorCode := -1;
    osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.procConsultaDatosCliente: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

END procConsultaDatosCliente;
-----------------------------------------------------------------------------
PROCEDURE procValidaParametros (idCliente        in out number,
                                idContrato       in out number,
                                idProducto      in out number,
                                idMatricula     in number,
                                idOrden         in number,
                                idMedidor       in varchar2,
                                infoFacturacion in varchar2,
                                infoCartera     in varchar2,
                                infoBrilla      in varchar2,
                                onuErrorCode     OUT NUMBER,
                                osbErrorMessage  OUT VARCHAR2) AS

nucliente  suscripc.suscclie%type;
nucontrato suscripc.susccodi%type;
nuproducto servsusc.sesunuse%type;
nucliente2 suscripc.suscclie%type;

cursor cuMatricula is
Select b.SUBSCRIPTION_ID CONTRATO
  from open.mo_PACKAGEs        a,
       open.or_order_activity  b,
       open.GE_SUBSCRIBER      c,
       open.AB_ADDRESS         d,
       open.GE_GEOGRA_LOCATION e
 WHERE a.document_key = idMatricula
   and a.PACKAGE_ID = b.PACKAGE_ID
   and c.SUBSCRIBER_ID = b.SUBSCRIBER_ID
   and rownum = 1
   and b.ADDRESS_ID = d.ADDRESS_ID
   and d.geograp_location_id = e.geograp_location_id;

cursor cuMedidor is
 select leemsesu
  from open.lectelme l
 where l.leemelme = (select m.elmeidem
                       from open.elemmedi m
                      where m.elmecodi = idMedidor)
order by l.leemfele desc;

cursor cuOrden is
 SELECT OA.PRODUCT_ID, OA.SUBSCRIPTION_ID, OA.SUBSCRIBER_ID, O.SUBSCRIBER_ID
  FROM OPEN.OR_ORDER O
LEFT OUTER JOIN OPEN.OR_ORDER_ACTIVITY OA ON (O.ORDER_ID = OA.ORDER_ID)
WHERE O.ORDER_ID=idOrden;

begin
  idCliente := nvl(idCliente,-1);
  idContrato := nvl(idContrato,-1);
  idProducto := nvl(idProducto,-1);

  -- valida si los parametros son S o N
  if nvl(infoFacturacion,'N') not in ('S','N','s','n') then
    onuErrorCode := -1;
    osbErrorMessage := 'Error: Parametro infoFacturacion Invalido';
    return;
  end if;

  if nvl(infoCartera,'N') not in ('S','N','s','n') then
    onuErrorCode := -1;
    osbErrorMessage := 'Error: Parametro infoCartera Invalido';
    return;
  end if;

  if nvl(infoBrilla,'N') not in ('S','N','s','n') then
    onuErrorCode := -1;
    osbErrorMessage := 'Error: Parametro infoBrilla Invalido';
    return;
  end if;

  if idCliente != -1 or idContrato!= -1 or idProducto != -1 then    -- no se requieren los parametros idmatricula, idorder o idmedidor
     if idProducto != -1 then
        -- valida cliente y contrato a partir del producto
        if not fnuGetClienCont(idProducto,nuCliente,nuContrato,onuErrorCode,osbErrorMessage) then
          return;
        end if;
        -- si encontro producto valida que el cliente y contrato sean validos
        if idContrato != -1 then
           if idContrato != nuContrato then
             onuErrorCode := -1;
             osbErrorMessage := 'Error: Contrato del Producto no corresponde';
             return;
          end if;  -- else es que idContrato esta correcto
        else
          idContrato := nuContrato;
        end if;

        if idCliente != -1 then
           if idCliente != nuCliente then
             onuErrorCode := -1;
             osbErrorMessage := 'Error: Cliente del Contrato no corresponde';
            return;
          end if;  -- else es que idCliente esta correcto
        else
          idCliente := nuCliente;
        end if;

      else
         idProducto := -1;

         if idContrato != -1 then
           -- valida cliente a partir del contrato
           if not fnuGetCliente(idContrato,nuCliente,onuErrorCode,osbErrorMessage) then
             return;
           end if;

           if idCliente != -1 then
              if idCliente != nuCliente then
                 onuErrorCode := -1;
                 osbErrorMessage := 'Error: Cliente del Contrato no corresponde';
               return;
              end if;  -- else es que idCliente esta correcto
           else
              idCliente := nuCliente;
           end if;

         else
           idContrato := -1;

            --valida que el cliente exista
           if not fnuGetSubscriber(idCliente,onuErrorCode,osbErrorMessage) then
             return;
           end if;

           idContrato := -1;
           idProducto := -1;
           return;

         end if;

   end if;
   return; -- con al menos uno de estos 3 parametros con datos se obtiene producto, contrato y cliente
  end if;  -- no es necesario validar los demas parametros


  -- Si no hay datos de cliente contrato o producto, los halla con los otros parametros
  -- busca por la matricula
  if nvl(idMatricula,-1) != -1 then
     open cuMatricula;
     fetch cuMatricula into nuContrato;
     if cuMatricula%notfound then
        close cuMatricula;
        onuErrorCode := -1;
        osbErrorMessage := 'Error: Matricula no Existe';
        return;
      else
        close cuMatricula;
        -- halla el cliente
        if not fnuGetCliente(nuContrato,nuCliente,onuErrorCode,osbErrorMessage) then
           return;
        else
          idCliente := nuCliente;
          idProducto := -1;
        end if;

      end if;
      return;
  end if;

  -- busca por la orden
  if nvl(idOrden,-1) != -1 then
     open cuOrden;
     fetch cuOrden into nuProducto, nuContrato, nuCliente, nuCliente2;
     if cuOrden%notfound then
        close cuOrden;
        onuErrorCode := -1;
        osbErrorMessage := 'Error: Orden no Existe';
        return;
      else
      close cuOrden;
      if nvl(nuProducto,-1) != -1 then
        -- valida cliente y contrato a partir del producto
        if not fnuGetClienCont(nuProducto,nuCliente,nuContrato,onuErrorCode,osbErrorMessage) then
          return; --onuerrcode y osberror tienen el error
        end if;
        idProducto := nuProducto;
        idContrato := nuContrato;
        idCliente  := nuCliente;
        return; -- si hallo datos, se regresa
      else
        idProducto := -1;
        if nvl(nuContrato,-1) != -1 then
           -- valida cliente a partir del contrato
           if not fnuGetCliente(nuContrato,nuCliente,onuErrorCode,osbErrorMessage) then
             return;
           end if; -- si hallo datos, se regresa
           idContrato := nuContrato;
           idCliente  := nuCliente;
           return;
        else
          idContrato := -1;
           if not fnuGetSubscriber(nuCliente,onuErrorCode,osbErrorMessage) then
             if not fnuGetSubscriber(nuCliente2,onuErrorCode,osbErrorMessage) then
               return;
             else
               idCliente := nuCliente2;
             end if;
           else
             idCliente := nuCliente;
           end if;
         end if;
      end if;
   end if;
   return;
  end if;

  -- busca por el medidor
  if idMedidor is null then
     onuErrorCode := -1;
     osbErrorMessage := 'Error: No se recibieron parametros';
     return;
  else
    open cuMedidor;
    fetch cuMedidor into nuProducto;
    if cuMedidor%notfound then
       close cuMedidor;
       onuErrorCode := -1;
       osbErrorMessage := 'Error: Medidor no Existe o no Asignado a un Producto';
       return;
    else
      close cuMedidor;
      idProducto := nuProducto;
      -- halla cliente y contrato a partir del producto
        if not fnuGetClienCont(nuProducto,nuCliente,nuContrato,onuErrorCode,osbErrorMessage) then
          return; --onuerrcode y osberror tienen el error
        end if;
        idContrato := nuContrato;
        idCliente  := nuCliente;
        return; -- si hallo datos, se regresa
      end if;
  end if;

  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Ok';

EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.procValidaParametros: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
END procValidaParametros;
-----------------------------------------------------------------------------
FUNCTION fnuGetClienCont      (inuProducto      IN servsusc.sesunuse%type,
                               onuCliente       OUT suscripc.suscclie%type,
                               onuContrato      OUT suscripc.susccodi%type,
                               onuErrorCode     OUT NUMBER,
                               osbErrorMessage  OUT VARCHAR2) return boolean AS

blResp  boolean;


cursor cuServsusc is
 select sc.suscclie, ss.sesususc
  from OPEN.servsusc ss, open.suscripc sc
  where ss.sesususc = sc.susccodi
   and ss.sesunuse=inuProducto;

begin
  open cuServsusc;
  fetch cuServsusc into onuCliente, onuContrato;
  if cuServsusc%notfound then
     blResp := false;
     onuErrorCode := -1;
     osbErrorMessage := 'No Existe Producto: ' || inuProducto;
  else
     blResp := true;
     onuErrorCode := 0;
     osbErrorMessage := 'Proceso Ok';
  end if;
  close cuServsusc;

  return (blResp);

EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.fnuGetClienCont: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      return false;
END fnuGetClienCont;
-----------------------------------------------------------------------------
FUNCTION fnuGetServGas        (inuCliente       IN suscripc.suscclie%type,
                               onuErrorCode     OUT NUMBER,
                               osbErrorMessage  OUT VARCHAR2) return number AS

nuProducto      servsusc.sesunuse%type;


cursor cuServsusc is
 select ss.sesunuse
  from OPEN.servsusc ss, open.suscripc sc
  where ss.sesususc = sc.susccodi
    and sc.suscclie = inuCliente
    and ss.sesuserv = 7014;

begin
  open cuServsusc;
  fetch cuServsusc into nuProducto;
  if cuServsusc%notfound then
     nuProducto := -1;
     onuErrorCode := -1;
     osbErrorMessage := 'No Existe Producto de Gas para el Cliente ' || inuCliente;
  else
     onuErrorCode := 0;
     osbErrorMessage := 'Proceso Ok';
  end if;
  close cuServsusc;

  return (nuProducto);

EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.fnuGetServGas: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      return (-1);
END fnuGetServGas;
-----------------------------------------------------------------------------
FUNCTION fsbGetPlanUltRefi  (inuNuse IN suscripc.suscclie%type) return varchar2 AS

sbUltPlanRefi  varchar2(200);

-- Cursor para obtener ultimo plan de refinanciacion
cursor cuUltPlanRefi is
SELECT financing_plan_id || ' - ' || pldidesc ult_plan_refi
    FROM(
         SELECT
               distinct d.difecofi,pd.pldidesc,rf.financing_plan_id,so.attention_date
           FROM open.diferido d
               ,open.cc_financing_request rf
               ,open.plandife pd
               ,open.mo_packages so
          WHERE difenuse = inunuse
            AND d.difecofi = rf.financing_id
            AND rf.financing_plan_id = pd.pldicodi
            AND difeprog = 'GCNED'
            AND rf.package_id = so.package_id
         ORDER BY so.attention_date DESC)
       WHERE rownum <= 1;

begin
  open cuUltPlanRefi;
  fetch cuUltPlanRefi into sbUltPlanRefi;
  if cuUltPlanRefi%notfound then
     sbUltPlanRefi := null;
  end if;
  close cuUltPlanRefi;

  return (sbUltPlanRefi);

EXCEPTION
    WHEN OTHERS THEN
     sbUltPlanRefi := 'Error: ' || substr(sqlerrm,1,192);
     return (sbUltPlanRefi);
END fsbGetPlanUltRefi;
-----------------------------------------------------------------------------
FUNCTION fnuGetCliente        (inuContrato      IN servsusc.sesunuse%type,
                               onuCliente       OUT suscripc.suscclie%type,
                               onuErrorCode     OUT NUMBER,
                               osbErrorMessage  OUT VARCHAR2) return boolean AS

blResp  boolean;


cursor cuSuscripc is
 select sc.suscclie
  from open.suscripc sc
  where sc.susccodi=inuContrato;

begin
  open cuSuscripc;
  fetch cuSuscripc into onuCliente;
  if cuSuscripc%notfound then
     blResp := false;
     onuErrorCode := -1;
     osbErrorMessage := 'No Existe Contrato: ' || inuContrato;
  else
     blResp := true;
     onuErrorCode := 0;
     osbErrorMessage := 'Proceso Ok';
  end if;
  close cuSuscripc;

  return (blResp);

EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.fnuGetCliente: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      return false;
END fnuGetCliente;
-----------------------------------------------------------------------------
FUNCTION fnuGetSubscriber     (inuCliente       IN  suscripc.suscclie%type,
                               onuErrorCode     OUT NUMBER,
                               osbErrorMessage  OUT VARCHAR2) return boolean AS

blResp  boolean;
nuCliente suscripc.suscclie%type;

cursor cuSubscriber is
select gs.subscriber_id
  from open.GE_SUBSCRIBER gs
 where gs.subscriber_id = inuCliente;

begin
  open cuSubscriber;
  fetch cuSubscriber into nuCliente;
  if cuSubscriber%notfound then
     blResp := false;
     onuErrorCode := -1;
     osbErrorMessage := 'No Existe Cliente: ' || inuCliente;
  else
     blResp := true;
     onuErrorCode := 0;
     osbErrorMessage := 'Proceso Ok';
  end if;
  close cuSubscriber;

  return (blResp);

EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.fnuGetSubscriber: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      return false;
END fnuGetSubscriber;
-----------------------------------------------------------------------------
PROCEDURE procConsDatosCliente(inuClie          IN  suscripc.suscclie%type,
                               CUCLIENTE        OUT SYS_REFCURSOR,
                               onuErrorCode     OUT NUMBER,
                               osbErrorMessage  OUT VARCHAR2) AS

begin
  /* Se carga la informacion en un cursor referenciado */
  open CUCLIENTE for
  select DISTINCT  gs.subscriber_id idCliente
       ,it.description tipoIdentifcacion
       ,gs.identification identificacion
       ,gs.subscriber_name nombre
       ,gs.subs_last_name apellido
       ,gs.e_mail mail
       ,ad.address_id idDireccion
       ,ad.address descDireccion
       ,gs.phone telefono
       ,gs.economic_activity_id idActividadEconomica
       ,ea.description descActividadEconomica
       ,gs.subs_status_id estado
       ,st.description desc_estado
       ,gl.description desc_localidad
       ,gs.vinculate_date fechaVinculacion
       ,gd.date_birth fechaNacimiento
       ,gd.gender genero
       ,cs.description estadoCivil
  from GE_SUBSCRIBER gs
  left outer join GE_IDENTIFICA_TYPE it on (gs.ident_type_id = it.ident_type_id)
  left outer join AB_ADDRESS ad on (ad.address_id = gs.address_id)
  left outer join GE_GEOGRA_LOCATION gl on (ad.geograp_location_id = gl.geograp_location_id)
  left outer join GE_ECONOMIC_ACTIVITY ea on (gs.economic_activity_id = ea.economic_activity_id)
  left outer join GE_SUBS_STATUS st on (gs.subs_status_id = st.subs_status_id)
  left outer join GE_SUBS_GENERAL_DATA gd on (gs.subscriber_id = gd.subscriber_id)
  left outer join GE_CIVIL_STATE cs on (gd.civil_state_id = cs.civil_state_id)
 where gs.subscriber_id = inuClie;

  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Ok';
EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.procConsDatosCliente: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
END procConsDatosCliente;

-----------------------------------------------------------------------------
PROCEDURE procConsDatosContrato(inuClie          IN  suscripc.suscclie%type,
                                inuSusc          IN  suscripc.susccodi%type,
                                CUCONTRATO       OUT SYS_REFCURSOR,
                                onuErrorCode     OUT NUMBER,
                                osbErrorMessage  OUT VARCHAR2) AS

begin
  /* Se carga la informacion en un cursor referenciado */
  open CUCONTRATO for
  select sc.suscclie idCliente
         ,sc.susccodi idContrato
         ,sc.susccicl idCiclo
         ,sc.susciddi idDireccion
         ,ad.address_parsed descDireccionDeCobro
  from suscripc sc
left outer join ab_address ad on (sc.susciddi = ad.address_id)
 where sc.suscclie = inuClie
   and sc.susccodi = decode(inuSusc,-1,sc.susccodi,inuSusc);

  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Ok';
EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.procConsDatosContrato: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
END procConsDatosContrato;

-----------------------------------------------------------------------------
PROCEDURE procConsDatosProducto(inuClie          IN  suscripc.suscclie%type,
                                inuSusc          IN  suscripc.susccodi%type,
                                inunuse          IN  servsusc.sesunuse%type,
                                CUPRODUCTO        OUT SYS_REFCURSOR,
                                onuErrorCode     OUT NUMBER,
                                osbErrorMessage  OUT VARCHAR2) AS

begin
  /* Se carga la informacion en un cursor referenciado */
  open CUPRODUCTO for
  select scp.suscclie idCliente
      ,scp.susccodi idContrato
      ,pr.product_id idProducto
      ,pr.product_type_id idServicio
      ,sv.servdesc descServicio
      ,OPEN.dage_geogra_location.fsbgetdescription
             (OPEN.dage_geogra_location.fnugetgeo_loca_father_id
                  (OPEN.daab_address.fnugetgeograp_location_id (ad.address_id,
                                                                NULL
                                                               ),
                   NULL
                  ),
              NULL
             ) descDepartamento
       ,OPEN.dage_geogra_location.fsbgetdescription
             (OPEN.daab_address.fnugetgeograp_location_id (ad.address_id, NULL),
              NULL
             ) descLocalidad
      ,OPEN.dage_geogra_location.fsbgetdescription
             (OPEN.daab_address.fnugetneighborthood_id (ad.address_id, NULL),
              NULL
             ) descBarrio
      ,pr.address_id idDireccionInstalacion
      ,ad.address_parsed descDireccionInstalacion
      ,pr.creation_date fechaCreacion
      ,ss.sesufein fechaInstalacion
      ,ss.sesufere fechaRetiro
      ,(SELECT MAX (review_date)
             FROM pr_certificate
            WHERE product_id = ss.sesunuse) fechaUltRevPeriodica
      , (SELECT c.catedesc
             FROM categori c
            WHERE c.catecodi = pr.category_id) idCategoria
      , (SELECT sc.sucadesc
             FROM subcateg sc
            WHERE sc.sucacate = pr.category_id
              AND sc.sucacodi = pr.subcategory_id) idSubcategoria
      ,ss.sesuesco estadoDeCorte
      ,ec.escodesc descripcionEstadoCorte
      ,pr.product_status_id idEstado
      ,ps.description descEstadoProducto
      ,decode(ss.sesuesfn,'A','AL DIA','D','CON DEUDA','M','EN MORA','C','CASTIGADO','SIN DESCRIPCION') descEstadoFinanciero
  from pr_product pr
 inner join servsusc ss on (pr.product_id = ss.sesunuse)
 inner join OPEN.suscripc scp on (ss.sesususc = scp.susccodi)
 inner join servicio sv on (pr.product_type_id = sv.servcodi)
 left outer join AB_ADDRESS ad on (ad.address_id = pr.address_id)
 left outer join GE_GEOGRA_LOCATION gl on (ad.geograp_location_id = gl.geograp_location_id)
 left outer join estacort ec on (ss.sesuesco = ec.escocodi)
 left outer join ps_product_status ps on (pr.product_status_id = ps.product_status_id)
 where scp.suscclie = decode(inuclie,-1,scp.suscclie ,inuclie)
   and ss.sesususc = decode(inususc,-1,ss.sesususc ,inususc)
   and ss.sesunuse = decode(inunuse,-1,ss.sesunuse ,inunuse);

  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Ok';
EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.procConsDatosProducto: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
END procConsDatosProducto;

-----------------------------------------------------------------------------
PROCEDURE procBrilla (inuClie          IN  suscripc.suscclie%type,
                      inuSusc          IN  suscripc.susccodi%type,
                      CUBRILLA         OUT SYS_REFCURSOR,
                      onuErrorCode     OUT NUMBER,
                      osbErrorMessage  OUT VARCHAR2) AS

sbSql  varchar2(4000);
i      number(3);
Cupo_asignado number;
Cupo_Usado    number;
Cupo_Disponible number;
nroComprasBrillaUltAno number;
nroComprasBrillaTotal number;
nuErrorCode           NUMBER;
sbErrorMessage        varchar2(4000);

cursor cuSusc is
 select susccodi
  from suscripc
 where suscclie = decode(inuclie,-1,suscclie,inuclie)
   and susccodi = decode(inususc,-1,susccodi,inususc)  ;

begin
  i := 0;
  sbSql := null;
  for rg in cuSusc loop
    i := i + 1;
    procConsDatosBrilla(rg.susccodi, cupo_asignado, cupo_usado, cupo_disponible,
                         nroComprasBrillaUltAno, nroComprasBrillaTotal,
                        nuErrorCode, sbErrorMessage);
    if nuErrorCode != 0 then
       onuErrorCode := nuErrorCode;
       osbErrorMessage := sbErrorMessage;
    else

    if i > 1 then
      sbSql := sbSql || ' UNION ';
    end if;
    sbSql :=  sbSql || 'select ' || rg.susccodi     || ' idContrato, '
                                 || cupo_Asignado   || ' cupoAsignado, '
                                 || cupo_Usado   || ' cupoUsado, '
                                 || cupo_Disponible   || ' cupoDisponible, '
                                 || NroComprasBrillaUltAno   || ' nroComprasBrillaUltAno, '
                                 || NroComprasBrillaTotal   || ' nroComprasBrillaTotal '
                                 || ' from dual';

    end if;
  end loop;

  if i > 0 and sbSql is not null  then
   open CUBRILLA for sbSql;
  else -- asgina -1 a las columnas del cursor de salida para que no haya error con el PI
    procSetCursorBrillaNull(CUBRILLA);
  end if;

  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Ok';
EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.procBrilla: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
END procBrilla;

-----------------------------------------------------------------------------
PROCEDURE procConsDatosBrilla (inuSusc          IN  suscripc.susccodi%type,
                               onuCupo_asignado out number,
                               onuCupo_Usado    out number,
                               onuCupo_Disponible out number,
                               onunroComprasBrillaUltAno out number,
                               onunroComprasBrillaTotal out number,
                               onuErrorCode     OUT NUMBER,
                               osbErrorMessage  OUT VARCHAR2) AS

begin

  select Cupo_asignado, Cupo_Usado, (Cupo_asignado - Cupo_Usado),
       nroComprasBrillaUltAno,  nroComprasBrillaTotal
    into onuCupo_asignado, onuCupo_Usado, onuCupo_Disponible,
         onunroComprasBrillaUltAno, onunroComprasBrillaTotal
    from
(select qh.assigned_quote Cupo_asignado,
       Open.ld_bononbankfinancing.fnugetusedquote(sc.susccodi) Cupo_Usado,

 (SELECT COUNT(DISTINCT(P.PACKAGE_ID))
 FROM OPEN.MO_PACKAGES P, OPEN.OR_ORDER_ACTIVITY OA, OPEN.OR_ORDER O
WHERE P.PACKAGE_ID = OA.PACKAGE_ID AND OA.ORDER_ID = O.ORDER_ID
  AND OA.SUBSCRIPTION_ID = inuSusc
  AND P.PACKAGE_TYPE_ID = 100264
  AND P.MOTIVE_STATUS_ID = 14
  AND O.TASK_TYPE_ID = 12590
  AND O.ORDER_STATUS_ID = 8
  AND O.CAUSAL_ID = 9724
  AND P.ATTENTION_DATE >= SYSDATE - 365
  AND EXISTS (SELECT 'X'
               FROM OPEN.LD_ITEM_WORK_ORDER WO
              WHERE WO.ORDER_ACTIVITY_ID = OA.ORDER_ACTIVITY_ID
                AND WO.STATE IN ('EP','RE') AND NVL(DIFECODI,0) > 0)) nroComprasBrillaUltAno,

  (SELECT COUNT(DISTINCT(P.PACKAGE_ID))
 FROM OPEN.MO_PACKAGES P, OPEN.OR_ORDER_ACTIVITY OA, OPEN.OR_ORDER O
WHERE P.PACKAGE_ID = OA.PACKAGE_ID AND OA.ORDER_ID = O.ORDER_ID
  AND OA.SUBSCRIPTION_ID = inuSusc
  AND P.PACKAGE_TYPE_ID = 100264
  AND P.MOTIVE_STATUS_ID = 14
  AND O.TASK_TYPE_ID = 12590
  AND O.ORDER_STATUS_ID = 8
  AND O.CAUSAL_ID = 9724
  AND EXISTS (SELECT 'X'
               FROM OPEN.LD_ITEM_WORK_ORDER WO
              WHERE WO.ORDER_ACTIVITY_ID = OA.ORDER_ACTIVITY_ID
                AND WO.STATE IN ('EP','RE') AND NVL(DIFECODI,0) > 0))  nroComprasBrillaTotal

  from Open.ld_quota_historic qh, open.suscripc sc
 where sc.susccodi = qh.subscription_id
   and qh.register_date = (SELECT max(h.register_date)
                                          FROM Open.ld_quota_historic h
                                           WHERE h.subscription_id = sc.susccodi)
  AND qh.result = 'Y'
  and sc.susccodi = inuSusc);

  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Ok';
EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.procConsDatosBrilla: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
END procConsDatosBrilla;

-----------------------------------------------------------------------------
PROCEDURE procConsDatosCartera (inuClie          IN  suscripc.suscclie%type,
                                inuSusc          IN  suscripc.susccodi%type,
                                inunuse          IN  servsusc.sesunuse%type,
                                CUCARTERA        OUT SYS_REFCURSOR,
                                onuErrorCode     OUT NUMBER,
                                osbErrorMessage  OUT VARCHAR2) AS




begin


  /* Se carga la informacion en un cursor referenciado */
  open CUCARTERA for
   select suscclie idCliente,
       susccodi idContrato,
       sesunuse idProducto,
       decode(sign(cantrefivigentes),1,'S','N')  estaRefinanciado,
       fechaUltSuspension fechaUltSuspension,
       nroSuspUltAno nroSuspUltAno,
       nroSuspTotal nroSuspTotal,
       fechaUltRefi fechaUltRefi,
       planUltRefi planUltRefi,
       fechaPenultimaRefi fechaPenultimaRefi,
       nroRefiUltAno nroRefiUltAno,
       nroRefiTotal nroRefiTotal,
       cuentasConSaldo cuentasConSaldo,
       nvl(deudaCorr,0) - nvl(deudaCorrienteNoVencida,0) deudaCorrienteVencida,
       deudaCorrienteNoVencida deudaCorrienteNoVencida,
       carteraNoVencida carteraNoVencida,
       edadDeuda edadDeuda,
       edadMora edadMora,
       fechaUltPago fechaUltPago,
       valorEnReclamo valorEnReclamo

from (
select suscclie, susccodi, sesunuse,
(Select Max(Cucofepa) fec_ult_pago
   From open.Factura, open.Cuencobr
  Where Factsusc = sesususc
    And Factprog = 6 -- Corresponda al programa FGCC
    And Cucofact = Factcodi
    And (Nvl(Cucosacu, 0) - Cucovare - Nvl(Cucovrap, 0)) = 0) fechaUltPago,
(SELECT SUM(difesape)
   FROM open.diferido
  WHERE difenuse = sesunuse
    AND difesape > 0) carteraNoVencida,
(SELECT open.ldc_edad_mes(trunc(SYSDATE) - trunc(MIN(cucofeve)))
  FROM open.cuencobr, open.factura
 WHERE cucosacu > 0
   AND cucofact = factcodi
   AND cuconuse = sesunuse) edadMora,
(select open.ldc_edad_mes(trunc(SYSDATE) - trunc(MIN(factfege)))
  FROM open.cuencobr, open.factura
 WHERE cucosacu > 0
   AND cucofact = factcodi
   AND cuconuse = sesunuse) edadDeuda,
(select SUM(cucosacu)
  FROM open.cuencobr, open.factura
 WHERE cucosacu > 0
   AND cucofact = factcodi
   AND cuconuse = sesunuse) deudaCorr,
(select SUM(cucosacu) - open.gc_bodebtmanagement.fnugetexpirdebtbyprod(sesunuse)
  FROM open.cuencobr, open.factura
 WHERE cucosacu > 0
   AND cucofact = factcodi
   AND cuconuse = sesunuse) deudaCorrienteNoVencida,
(select COUNT(cucocodi)
  FROM open.cuencobr, open.factura
 WHERE cucosacu > 0
   AND cucofact = factcodi
   AND cuconuse = sesunuse) cuentasConSaldo,
(SELECT count(distinct(f.difecofi))
           FROM open.diferido f
           where f.difenuse = sesunuse
             and f.difeprog = 'GCNED'
             and difevatd>0
             AND f.difefein > (sysdate-365)) nroRefiUltAno,
(SELECT count(distinct(f.difecofi))
           FROM open.diferido f
           where f.difenuse = sesunuse
             and f.difeprog = 'GCNED'
             and difevatd>0) nroRefiTotal,
(SELECT max(difefein) fec_ult_refi
           FROM open.diferido f
           where f.difenuse = sesunuse
             and f.difeprog = 'GCNED'
             and f.difevatd > 0
             AND f.difefein > (sysdate-365)) fechaUltRefi  ,

LDCI_PKCRMCONSULTA.fsbGetPlanUltRefi(sesunuse) planUltRefi,

(SELECT max(difefein)
           FROM open.diferido f
           where f.difenuse = sesunuse
             and f.difeprog = 'GCNED'
             and f.difevatd > 0
             and f.difefein < (SELECT max(trunc(difefein))
                                 FROM open.diferido f2
                                where f2.difenuse = sesunuse
                                  and f2.difeprog = 'GCNED'
                                  and f2.difevatd > 0)) fechaPenultimaRefi,
(select count(1) cant
  from open.diferido
 where difenuse=sesunuse
    and difesape > 0
    AND difeprog = 'GCNED') cantrefivigentes,

(SELECT Count(1)
    FROM open.pr_prod_suspension s, OPEN.GE_SUSPENSION_TYPE ST
   WHERE product_id = sesunuse
     and s.suspension_type_id = st.suspension_type_id
     AND ST.CLASS_SUSPENSION IN ('A','D','P')
     and aplication_date > sysdate - 365) nroSuspUltAno,
(SELECT Count(1)
    FROM open.pr_prod_suspension s, OPEN.GE_SUSPENSION_TYPE ST
   WHERE product_id = sesunuse
     and s.suspension_type_id = st.suspension_type_id
     AND ST.CLASS_SUSPENSION IN ('A','D','P')) nroSuspTotal,
(SELECT MAX(S.APLICATION_DATE)
    FROM open.pr_prod_suspension s, OPEN.GE_SUSPENSION_TYPE ST
   WHERE product_id = sesunuse
     and s.suspension_type_id = st.suspension_type_id
     AND ST.CLASS_SUSPENSION IN ('A','D','P')) fechaUltSuspension,

pkBCCuencobr.fnuGetClaimValue(sesunuse) valorEnReclamo

from open.servsusc, open.suscripc
where sesususc = susccodi
  and suscclie = decode(inuclie,-1,suscclie, inuclie)
  and susccodi = decode(inususc,-1,susccodi, inususc)
  and sesunuse = decode(inunuse,-1,sesunuse, inunuse)
);

  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Ok';
EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.procConsDatosCartera: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
END procConsDatosCartera;

-----------------------------------------------------------------------------
PROCEDURE procFacturacion (inuClie          IN  suscripc.suscclie%type,
                           inuSusc          IN  suscripc.susccodi%type,
                           CUFACTURACION    OUT SYS_REFCURSOR,
                           onuErrorCode     OUT NUMBER,
                           osbErrorMessage  OUT VARCHAR2) AS


sbSql  varchar2(4000);
i      number(3);
nuconsumopromedio    number;
sbNumeroMedidor      varchar2(50);
nulecturaanterior    number;
nulecturaactual      number;
dtfechalectura       date;
nuconsumo            number;
nufactorcorreccion   number;
nuconsumofacturado   number;
sbfactpromedio       varchar2(1);
dtfechafactura       date;
nuvalorfacturado     number;
nuidcupon            number;
dtfechalimitepago    date;
nudiasmora           number;
nuvalorpagado        number;
dtfechapago          date;
nuErrorCode          NUMBER;
sbErrorMessage       varchar2(4000);

cursor cuSusc is
select susccodi, sesunuse
  from suscripc, servsusc
 where sesususc=susccodi
   and suscclie = decode(inuclie,-1,suscclie,inuclie)
   and susccodi = decode(inususc,-1,susccodi,inususc)
   and sesuserv=7014;

begin
  i := 0;
  sbSql := null;
  for rg in cuSusc loop
    i := i + 1;
    procConsDatosFacturacion(rg.susccodi, rg.sesunuse, nuconsumopromedio,
                             sbNumeroMedidor, nulecturaanterior, nulecturaactual,
                             dtfechalectura, nuconsumo, nufactorcorreccion,
                             nuconsumofacturado, sbfactpromedio, dtfechafactura,
                             nuvalorfacturado, nuidcupon, dtfechalimitepago,
                             nudiasmora, nuvalorpagado, dtfechapago,
                             nuErrorCode, sbErrorMessage);
    if nuErrorCode != 0 then
       onuErrorCode := nuErrorCode;
       osbErrorMessage := sbErrorMessage;
    else

    if i > 1 then
      sbSql := sbSql || ' UNION ';
    end if;
    sbSql :=  sbSql || 'select '  ||
              rg.susccodi         || ' idContrato, ' ||
              rg.sesunuse         || ' idProducto, ' ||

              'decode(' ||''''||nuconsumopromedio||''''|| ',null,null,' ||''''||
                nuconsumopromedio||''''|| ') consumoPromedio ,' ||

              '''' || sbNumeroMedidor || ''''   || ' numeroMedidor, ' ||

              'decode(' ||''''||nulecturaanterior||''''|| ',null,null,' ||''''||
                nulecturaanterior||''''|| ') lecturaAnterior ,' ||

              'decode(' ||''''||nulecturaactual||''''|| ',null,null,' ||''''||
                nulecturaactual||''''|| ') lecturaActual ,' ||

              'to_date(' || '''' || dtfechalectura ||'''' || ',' ||
                '''dd/mm/yyyy hh24:mi:ss''' || ')' || ' fechaLectura, ' ||

              'decode(' ||''''||nuconsumo||''''|| ',null,null,' ||''''||
                nuconsumo||''''|| ') consumo ,' ||

               'decode(' ||''''||nufactorcorreccion||''''|| ',null,null,' ||''''||
                nufactorcorreccion||''''|| ') factorCorreccion ,' ||


              'decode(' ||''''||nuconsumofacturado||''''|| ',null,null,' ||''''||
                nuconsumofacturado||''''|| ') consumoFacturado ,' ||


              '''' || sbfactpromedio || ''''   || ' factPromedio, ' ||

              'to_date(' || '''' || dtfechafactura ||'''' || ',' ||
                '''dd/mm/yyyy hh24:mi:ss''' || ')' || ' fechaFactura, ' ||

              'decode(' ||''''||nuvalorfacturado||''''|| ',null,null,' ||''''||
                nuvalorfacturado||''''|| ') valorFacturado ,' ||

             'decode(' ||''''||nuidcupon||''''|| ',null,null,' ||''''||
                nuidcupon||''''|| ') idCupon ,' ||

             'to_date(' || '''' || dtfechalimitepago ||'''' || ',' ||
               '''dd/mm/yyyy hh24:mi:ss''' ||  ')' || ' fechaLimitePago, ' ||


              'decode(' ||''''||nudiasmora||''''|| ',null,null,' ||''''||
                nudiasmora||''''|| ') diasMora ,' ||


              'decode(' ||''''||nuvalorpagado||''''|| ',null,null,' ||''''||
                nuvalorpagado||''''|| ') valorPagado ,' ||


              'to_date(' || '''' || dtfechapago ||'''' || ',' || '''dd/mm/yyyy hh24:mi:ss''' ||
              ')' || ' fechaPago ' ||

              ' from dual';
    dbms_output.put_line(sbSql);
     end if;
  end loop;
  -- to_date(to_char(dtFeve,'dd/mm/yyyy'),'dd/mm/yyyy')
  if i > 0 and sbSql is not null then
    open CUFACTURACION for sbSql;
  end if;

  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Ok';
EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.procFacturacion: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
END procFacturacion;

-----------------------------------------------------------------------------
PROCEDURE procConsDatosFacturacion (inuSusc               IN  suscripc.susccodi%type,
                                    inunuse               IN  servsusc.sesunuse%type,
                                    onuconsumopromedio    out number,
                                    osbNumeroMedidor      out varchar2,
                                    onulecturaanterior    out number,
                                    onulecturaactual      out number,
                                    odtfechalectura       out date,
                                    onuconsumo            out number,
                                    onufactorcorreccion   out number,
                                    onuconsumofacturado   out number,
                                    osbfactpromedio       out varchar2,
                                    odtfechafactura       out date,
                                    onuvalorfacturado     out number,
                                    onuidcupon            out number,
                                    odtfechalimitepago    out date,
                                    onudiasmora           out number,
                                    onuvalorpagado        out number,
                                    odtfechapago          out date,
                                    onuErrorCode          OUT NUMBER,
                                    osbErrorMessage       OUT VARCHAR2) AS


lecturaActual           lectelme.leemleto%type;
lecturaAnterior         lectelme.leemlean%type;
fechaLectura            lectelme.leemfele%type;
nuDifeLect              conssesu.cosscoca%type;
nuDiasMora              number(6);
nuConsFactPorCoss       conssesu.cosscoca%type;
nuConsFactPorCargos     conssesu.cosscoca%type;
nuConsPromedio          conssesu.cosscoca%type;
niDifeLectPorCoss       conssesu.cosscoca%type;
factorCorreccion        CM_FACOCOSS.FCCOFACO%type;
numeroMedidor           ELEMMEDI.ELMECODI%TYPE;
nuPromedio              conssesu.cosscoca%type;
factPromedio            varchar2(1);
idCupon                 cupon.cuponume%type;

-- Cursor para obtener datos de la ultima facturacion de Gas
cursor cuUltFact is
 select fa.factcodi, fa.factpefa, fa.factfege, cc.cucofeve, cc.cucofepa,
        cc.cucovato, cc.cucovaab, cc.cucosacu
  from open.factura fa, open.cuencobr cc, open.servsusc ss
 where cucofact = factcodi
   and cuconuse = sesunuse
   and sesuserv = 7014
   and factcodi = (select max(factcodi)
                     from open.factura
                    where factsusc = inususc
                      and factprog = 6);

rgUF cuUltFact%rowtype;

-- Cursor para obtener Numero de Cupon
cursor cuCupon (nufactura cupon.cupodocu%type) is
select cuponume
      from open.cupon c
     where c.cupotipo = 'FA'
       and c.cupoprog = 'FIDF'
       and c.cuposusc = inususc
       AND c.cupodocu = nufactura;


-- Cursor para obtener datos de lectura
cursor cuLecturas (nupefa factura.factpefa%type) is
select leemleto, leemlean, leemfele
  from OPEN.LECTELME
 where leemsesu=inunuse
   and leempefa = nupefa
   and leemclec = 'F'
  order by leemfele desc;

rgLe cuLecturas%rowtype;

-- Cursor para obtener datos de consumo por Dife de Lecturas
cursor cuConsumoDifLec (nupefa factura.factpefa%type) is
  select cosscoca
   from open.conssesu c
  where cosssesu = inunuse
    and cosspefa = nupefa
    --and cossflli = 'S'
    and c.cossmecc = 1
   order by c.cossfere desc;

-- Cursor para obtener datos de consumo Facturado
-- incluye consumos ajustados 1 mes despues
-- a menos que se halle el primero del periodo
cursor cuConsumoFact (nupefa factura.factpefa%type) is
 select sum(cosscoca) -- select cosscoca hallara el primero , O SEA QUE LO SE FACTURO EN SU MOMENTO
   from open.conssesu c
  where cosssesu = inunuse
    and cosspefa = nupefa
    and cossflli = 'S'
    and c.cossmecc = 4;

-- Cursor para obtener datos de consumo estimado o promedio
cursor cuConsumoProm (nupefa factura.factpefa%type) is
  select cosscoca
   from open.conssesu c
  where cosssesu = inunuse
    and cosspefa = nupefa
    --and cossflli = 'S'
    and c.cossmecc = 3
    and SUBSTR(COSSFUFA,1,8) = 'OBTECOPP';

-- Cursor para obtener datos de cargos facturados
cursor cuCargos (nupefa factura.factpefa%type) is
SELECT SUM(decode(CARGSIGN,'DB',CARGUNID,CARGUNID*(-1)))
  FROM OPEN.CARGOS C
 WHERE CARGNUSE=inunuse
   AND CARGPEFA =nupefa
--   AND CARGCONC = 31  -- 31 ES SOLO PARA REGULADOS
   AND CARGCONC IN (31,200,204,20,18,288)
   AND CARGPROG IN (5,2038);

-- Cursor para obtener Factor de Correccion
cursor cuFactCorr (nupefa factura.factpefa%type) is
SELECT fc.fccofaco
       FROM open.conssesu con, open.CM_FACOCOSS fc
       WHERE con.cosssesu = inunuse
       AND fc.fccocons = con.cossfcco
       AND con.cosstcon = 1
       AND con.COSSMECC = 4
       AND con.cosspefa = nupefa
       AND ROWNUM = 1 ;



begin

  -- se obtiene Datos de la Ultima Factura
  open cuUltFact;
  fetch cuUltFact into rgUF;
  if cuUltFact%notfound then
    null;
  end if;
  close cuUltFact;

  nuDiasMora := nvl(rgUF.Cucofepa,trunc(sysdate)) - rgUF.cucofeve;
  if nuDiasMora < 0 then
     nuDiasMora := 0;
  end if;

   -- se obtiene numero del medidor
  numeroMedidor := open.pkbcelmesesu.fsbgetlastmeaselembyprod(inunuse);

  -- se obtiene l consumo promedio del ultimo periodo facturado
  nuPromedio := round(CM_BOHicoprpm.fnuGetLastConsbyProd(inunuse, 1, rgUF.Factpefa),0);


  -- se obtiene Numero de Cupon
  open cuCupon(rgUF.Factcodi);
  fetch cuCupon into idCupon;
  if cuCupon%notfound then
    idCupon := null;
  end if;
  close cuCupon;

  -- se obtiene Datos de la ultima lectura
  open cuLecturas(rgUF.Factpefa);
  fetch cuLecturas into lecturaActual, lecturaAnterior, fechaLectura;
  if cuLecturas%notfound then
    null;
  end if;
  close cuLecturas;

  -- se halla diferencia de lecturas segun LECTELME
  if nvl(lecturaActual,0) = 0 then
    nuDifeLect := 0;
  else
    nuDifeLect := round(lecturaActual - nvl(lecturaAnterior,0),0);
  end if;

  -- se halla diferencia de Lecturas segun COSSSESU (ya tiene fact de corr)
  open cuConsumoDifLec(rgUF.Factpefa);
  fetch cuConsumoDifLec into niDifeLectPorCoss;
  if cuConsumoDifLec%notfound then
    niDifeLectPorCoss := null;
  end if;
  close cuConsumoDifLec;

  -- se halla Factor de Correccion
  open cuFactCorr(rgUF.Factpefa);
  fetch cuFactCorr into factorCorreccion;
  if cuFactCorr%notfound then
    factorCorreccion := 1;
  end if;
  close cuFactCorr;


  -- se obtiene Datos del consumo facturado segun COSSSESU (ya tiene fact de corr)
  open cuConsumoFact(rgUF.Factpefa);
  fetch cuConsumoFact into nuConsFactPorCoss;
  if cuConsumoFact%notfound then
    nuConsFactPorCoss := 0;
  end if;
  close cuConsumoFact;

  -- se obtiene Datos del consumo facturado segun CARGOS
  open cuCargos(rgUF.Factpefa);
  fetch cuCargos into nuConsFactPorCargos;
  if cuCargos%notfound then
    nuConsFactPorCargos := 0;
  end if;
  close cuCargos;

   -- se obtiene Datos del consumo promedio o estimado
  open cuConsumoProm(rgUF.Factpefa);
  fetch cuConsumoProm into nuConsPromedio;
  if cuConsumoProm%notfound then
    nuConsPromedio := null;
  end if;
  close cuConsumoProm;

  if nvl(nuConsPromedio,0) = nuConsFactPorCargos and
    nuConsFactPorCargos != 0 and
    round(nvl(nuDifeLect,0) * nvl(factorCorreccion,1)) != nuConsFactPorCargos
    then
    factPromedio := 'S';
  else
    factPromedio := 'N';
  end if;

  if factPromedio = 'S' then
      nuPromedio := nuConsPromedio;
  end if;

  select nuPromedio,
          numeroMedidor,
          lecturaAnterior,
          lecturaActual,
          trunc(fechaLectura),
          nuDifeLect, --consumoPorDifLect,
          factorCorreccion,
         -- niDifeLectPorCoss as niDifeLectPorCoss,
         -- nuConsFactPorCoss as "consumo_por_coss",
          nuConsFactPorCargos,
          --nuPromedio as "nuPromedio",
          factPromedio,
          rgUF.Factfege,
          rgUF.Cucovato,
          idCupon,
          rgUF.Cucofeve,
          nuDiasMora,
          rgUF.Cucovaab,
          rgUF.Cucofepa
     into onuconsumopromedio,  osbNumeroMedidor,    onulecturaanterior,
          onulecturaactual,    odtfechalectura,     onuconsumo,
          onufactorcorreccion, onuconsumofacturado, osbfactpromedio,
          odtfechafactura,     onuvalorfacturado,   onuidcupon,
          odtfechalimitepago,  onudiasmora,         onuvalorpagado,
          odtfechapago
     from dual;

  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Ok';
EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode := -1;
      osbErrorMessage := 'Error en LDCI_PKCRMCONSULTA.procConsDatosFacturacion: ' ||
                       SQLERRM || ' - ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
END procConsDatosFacturacion;

-----------------------------------------------------------------------------
PROCEDURE procSetCursorBrillaNull (CUBRILLA    OUT SYS_REFCURSOR) AS


begin
 open CUBRILLA for
select -1 idContrato,
       -1 cupoAsignado,
       -1 cupoUsado,
       -1 cupoDisponible,
       -1 nroComprasBrillaUltAno,
       -1 nroComprasBrillaTotal
  from dual;

END procSetCursorBrillaNull;
-----------------------------------------------------------------------------

End LDCI_PKCRMCONSULTA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKCRMCONSULTA', 'ADM_PERSON'); 
END;
/

