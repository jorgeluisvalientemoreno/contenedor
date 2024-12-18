CREATE OR REPLACE package ADM_PERSON.LDC_CA_NOTI is

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_CA_NOTI
    Descripcion    : Paquete donde Obtienen datos para la notificacion de cartera
    Autor          : Diego Roderiguez
    Fecha          : 19/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    15-02-2016        YENTHO            fsbNumMedidor: se modifica el cursor cuNumMedidor para que la consulta
                                        valide que el medidor a visualizar sea el vigente.
    18-04-2016        KCienfuegos       Se crea método <<fnuCantTotCuentasConSaldo>> (CA200-215)
                                        Se modifica método <<fnuNuCuenSaldo>>
  ******************************************************************/

function fnuNombre (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
return Varchar2;

function fnuDire   (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
return Varchar2;

function fnuBarrio (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
return Varchar2;

function fnuLoca   (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
return Varchar2;

function fnuContrato(nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                     nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                     nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
return Varchar2;

function fnuNuCuenSaldo(nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                        nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                        nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
return Varchar2;
function fnuValSaldoPen(nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                        nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                        nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
return Varchar2;
function fsbSectorOperativo(nuSectorOperativo   or_operating_sector.operating_sector_id%type)
return Varchar2;
function fsbUnidadOperativa(nuUnidadOperativa   or_operating_unit.operating_unit_id%type)
return Varchar2;
function fsbProductos(nuContrato   servsusc.sesususc%type)
return Varchar2;
function fsbTipoTrab(nuTipoTrab   or_task_type.task_type_id%type)
return Varchar2;
function fsbActTipoTrab(nuActTipoTrab   ge_items.items_id%type)
return Varchar2;
function fsbTipoClie(nuContrato   ge_subscriber.subscriber_id%type)
return Varchar2;
function fsbTipoPred(inuProduct   pr_product.product_id%type)
return Varchar2;
function fsbCiclo(nuContrato   suscripc.susccodi%type)
return Varchar2;
function fsbCate(nuContrato   suscripc.susccodi%type)
return Varchar2;
function fsbLocalidad(nuContrato   suscripc.susccodi%type)
return Varchar2;
function fsbSubCate(nuContrato   suscripc.susccodi%type)
return Varchar2;
function fsbNumMedidor(nuContrato   suscripc.susccodi%type)
return Varchar2;
function fsbRefeCatast(nuContrato   suscripc.susccodi%type)
return Varchar2;
function fsbEstadoMedidor(nuContrato   suscripc.susccodi%type)
return Varchar2;
function fsbEdadDeuda(nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
return Varchar2;
function fsbRutaLectura(nuContrato   suscripc.susccodi%type)
return Varchar2;
function fsbPlaCarAsig(nuOrden   or_order.order_id%type)
return Varchar2;
function fsbUltLectToma(nuContrato   suscripc.susccodi%type)
return Varchar2;
function fsbNumRefina(nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                      nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                      nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
return Varchar2;
function fnuValSaldoPenTot (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
return Varchar2;
function fsbFechUltiRefi(nuContrato   suscripc.susccodi%type)
return Varchar2;
function fsbSaldoDifer(nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                       nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                       nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
return Varchar2;

function fsbEstadoCuenta1(nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                         nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                         nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
return Varchar2;

function fsbUltComentarioOT (inuOrden or_order.order_id%type)
return Varchar2;

function fsbUltTipoComentOT (inuOrden or_order.order_id%type)
return Varchar2;

function fsbUltFechComentOT (inuOrden or_order.order_id%type)
return Varchar2;

/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : fsbEstCort
Descripcion    : Retorna el estado de corte del servicio
Autor          : Jorge Valiente
Fecha          : 19/06/2014
******************************************************************/
function fsbEstCortServicio(nuContrato servsusc.sesususc%type)
  return Varchar2;

function fsbMetodoSuspencion(nuProduct or_order_activity.product_id%type) return Varchar2;

/*****************************************************************
Propiedad intelectual de CSC.

Unidad         : fnuCantTotCuentasConSaldo
Descripcion    : Función para obtener la cantidad de cuentas con saldo
                 (vencidas y no vencidas) de un producto.
Autor          : KCienfuegos
Fecha          : 15/04/2016

Parametros           Descripcion
============       ===================
nuSUBSCRIBER_ID     Cliente
nuSUBSCRIPTION_ID   Contrato
nuPRODUCT_ID        Producto

Historia de Modificaciones
Fecha             Autor             Modificacion
=========         =========         ====================

******************************************************************/
FUNCTION fnuCantTotCuentasConSaldo (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
RETURN VARCHAR2;

end LDC_CA_NOTI;
/
CREATE OR REPLACE package body ADM_PERSON.LDC_CA_NOTI is

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCFinesSales
    Descripcion    : Paquete donde se implementa la l?gica para la generaci?n de multas
					 para procesos del ?rea de ventas
    Autor          : Sayra Ocoro
    Fecha          : 04/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor                      Modificacion
    =========         =========                  ====================
    18-04-2016    KCienfuegos.CA200-215          Se crea método <<fnuCantTotCuentasConSaldo>>
                                                 Se modifica método <<fnuNuCuenSaldo>>
  ******************************************************************/

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuNombre
    Descripcion    : Funcion que retorna el nombre
    Autor          : Diego Fernando Rodriguez
    Fecha          : 19/03/2013
  ******************************************************************/
function fnuNombre (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
    return Varchar2
is

    sbCadeana Varchar2(2000);

    cursor cuCliete is
    select g.subscriber_name||' '||g.subs_last_name nombre
                          from ge_subscriber g
                          where g.subscriber_id = nuSUBSCRIBER_ID;

    cursor cuContrato is
    select g.subscriber_name||' '||g.subs_last_name  nombre
                        from ge_subscriber g,suscripc s
                        where g.subscriber_id = s.suscclie
                        and s.susccodi = nuSUBSCRIPTION_ID;

    cursor cuProducto is
    select g.subscriber_name||' '||g.subs_last_name nombre
                          from ge_subscriber g,suscripc s,servsusc ss
                          where g.subscriber_id = s.suscclie
                          and s.susccodi = ss.sesususc
                          and ss.sesunuse = nuPRODUCT_ID;
begin
    -- Retorna a nivel de cliete
    if (nuSUBSCRIBER_ID is not null and nuSUBSCRIPTION_ID is null) then
        for rcCliete in cuCliete loop
            sbCadeana := rcCliete.nombre;
        end loop;
    -- Retorna a nivel de Contrato
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then
        for rcContrato in cuContrato loop
            sbCadeana := rcContrato.nombre;
        end loop;
    -- Retorna a nivel de producto
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
        for rcProducto in cuProducto loop
            sbCadeana := rcProducto.nombre;
        end loop;
    end if;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fnuNombre;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuDire
    Descripcion    : Funcion que retorna la  direccion
    Autor          : Diego Fernando Rodriguez
    Fecha          : 19/03/2013
  ******************************************************************/
function fnuDire (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
    return Varchar2
is

    sbCadeana Varchar2(2000);

    cursor cuCliete is
    select ab.address_parsed DIRE
                      from ab_address ab, ge_subscriber g
                      where ab.address_id = g.address_id
                        and g.subscriber_id = nuSUBSCRIBER_ID;

    cursor cuContrato is
    select ab.address_parsed DIRE
                    from ab_address ab,ge_subscriber g,suscripc s
                    where ab.address_id = g.address_id
                     and g.subscriber_id = s.suscclie
                     and s.susccodi = nuSUBSCRIPTION_ID;

    cursor cuProducto is
    select ab.address_parsed DIRE
                      from ab_address ab,ge_subscriber g,suscripc s,servsusc ss
                      where ab.address_id = g.address_id
                      and g.subscriber_id = s.suscclie
                      and s.susccodi = ss.sesususc
                      and ss.sesunuse = nuPRODUCT_ID;
begin
    -- Retorna a nivel de cliete
    if (nuSUBSCRIBER_ID is not null and nuSUBSCRIPTION_ID is null) then
        for rcCliete in cuCliete loop
            sbCadeana := rcCliete.DIRE;
        end loop;
    -- Retorna a nivel de Contrato
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then
        for rcContrato in cuContrato loop
            sbCadeana := rcContrato.DIRE;
        end loop;
    -- Retorna a nivel de producto
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
        for rcProducto in cuProducto loop
            sbCadeana := rcProducto.DIRE;
        end loop;
    end if;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fnuDire;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuBarrio
    Descripcion    : Funcion que retorna el Barrio
    Autor          : Diego Fernando Rodriguez
    Fecha          : 19/03/2013
  ******************************************************************/
function fnuBarrio (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
    return Varchar2
is

    sbCadeana Varchar2(2000);

    cursor cuCliete is
    select gg.description Barrio
                      from ge_geogra_location gg, ab_address ab, ge_subscriber g
                      where gg.geograp_location_id = ab.neighborthood_id
                        and ab.address_id = g.address_id
                        and g.subscriber_id = nuSUBSCRIBER_ID;

    cursor cuContrato is
    select  gg.description Barrio
                    from ge_geogra_location gg,ab_address ab,ge_subscriber g,suscripc s
                    where gg.geograp_location_id = ab.neighborthood_id
                     and ab.address_id = g.address_id
                     and g.subscriber_id = s.suscclie
                     and s.susccodi = nuSUBSCRIPTION_ID;

    cursor cuProducto is
    select gg.description Barrio
                      from ge_geogra_location gg,ab_address ab,ge_subscriber g,suscripc s,servsusc ss
                      where gg.geograp_location_id = ab.neighborthood_id
                      and ab.address_id = g.address_id
                      and g.subscriber_id = s.suscclie
                      and s.susccodi = ss.sesususc
                      and ss.sesunuse = nuPRODUCT_ID;
begin
    -- Retorna a nivel de cliete
    if (nuSUBSCRIBER_ID is not null and nuSUBSCRIPTION_ID is null) then
        for rcCliete in cuCliete loop
            sbCadeana := rcCliete.Barrio;
        end loop;
    -- Retorna a nivel de Contrato
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then
        for rcContrato in cuContrato loop
            sbCadeana := rcContrato.Barrio;
        end loop;
    -- Retorna a nivel de producto
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
        for rcProducto in cuProducto loop
            sbCadeana := rcProducto.Barrio;
        end loop;
    end if;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fnuBarrio;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuLoca
    Descripcion    : Funcion que retorna el Localidad
    Autor          : Diego Fernando Rodriguez
    Fecha          : 19/03/2013
  ******************************************************************/
function fnuLoca (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
    return Varchar2
is

    sbCadeana Varchar2(2000);

    cursor cuCliete is
    select gg.description Loca
                      from ge_geogra_location gg, ab_address ab, ge_subscriber g
                      where gg.geograp_location_id = ab.geograp_location_id
                        and ab.address_id = g.address_id
                        and g.subscriber_id = nuSUBSCRIBER_ID;

    cursor cuContrato is
    select  gg.description Loca
                    from ge_geogra_location gg,ab_address ab,ge_subscriber g,suscripc s
                    where gg.geograp_location_id = ab.geograp_location_id
                     and ab.address_id = g.address_id
                     and g.subscriber_id = s.suscclie
                     and s.susccodi = nuSUBSCRIPTION_ID;

    cursor cuProducto is
    select gg.description Loca
                      from ge_geogra_location gg,ab_address ab,ge_subscriber g,suscripc s,servsusc ss
                      where gg.geograp_location_id = ab.geograp_location_id
                      and ab.address_id = g.address_id
                      and g.subscriber_id = s.suscclie
                      and s.susccodi = ss.sesususc
                      and ss.sesunuse = nuPRODUCT_ID;
begin
    -- Retorna a nivel de cliete
    if (nuSUBSCRIBER_ID is not null and nuSUBSCRIPTION_ID is null) then
        for rcCliete in cuCliete loop
            sbCadeana := rcCliete.Loca;
        end loop;
    -- Retorna a nivel de Contrato
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then
        for rcContrato in cuContrato loop
            sbCadeana := rcContrato.Loca;
        end loop;
    -- Retorna a nivel de producto
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
        for rcProducto in cuProducto loop
            sbCadeana := rcProducto.Loca;
        end loop;
    end if;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fnuLoca;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuContrato
    Descripcion    : Funcion que retorna el contrato
    Autor          : Diego Fernando Rodriguez
    Fecha          : 19/03/2013
  ******************************************************************/
function fnuContrato (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
    return Varchar2
is

    sbCadeana Varchar2(2000);

    cursor cuCliete is
    select g.subscriber_id Contra
                      from ge_subscriber g
                      where g.subscriber_id = nuSUBSCRIBER_ID;

    cursor cuContrato is
    select s.susccodi Contra
                    from ge_subscriber g,suscripc s
                    where g.subscriber_id = s.suscclie
                    and s.susccodi = nuSUBSCRIPTION_ID;

    cursor cuProducto is
    select s.susccodi Contra
                      from ge_subscriber g,suscripc s,servsusc ss
                      where g.subscriber_id = s.suscclie
                      and s.susccodi = ss.sesususc
                      and ss.sesunuse = nuPRODUCT_ID;
begin
    -- Retorna a nivel de cliete
    if (nuSUBSCRIBER_ID is not null and nuSUBSCRIPTION_ID is null) then
        for rcCliete in cuCliete loop
            sbCadeana := rcCliete.Contra;
        end loop;
    -- Retorna a nivel de Contrato
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then
        for rcContrato in cuContrato loop
            sbCadeana := rcContrato.Contra;
        end loop;
    -- Retorna a nivel de producto
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
        for rcProducto in cuProducto loop
            sbCadeana := rcProducto.Contra;
        end loop;
    end if;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fnuContrato;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuNuCuenSaldo
    Descripcion    : Funcion que retorna el numeor de cuentas con saldo
    Autor          : Diego Fernando Rodriguez
    Fecha          : 19/03/2013
    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    18-04-2016        KCienfuegos       Se agrega el llamado a la función fnuCantTotCuentasConSaldo.
  ******************************************************************/
  function fnuNuCuenSaldo (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                      nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                      nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
      return Varchar2
  is
      nuValor number := 0;

      cursor cuDatos is
        select ss.sesunuse from SUSCRIPC s, servsusc ss
         where s.susccodi = ss.sesususc
           and s.SUSCCLIE = decode(nuSUBSCRIBER_ID,null,SUSCCLIE,nuSUBSCRIBER_ID)
           and s.susccodi = decode(nuSUBSCRIPTION_ID,null,s.susccodi,nuSUBSCRIPTION_ID);

  begin

      IF(fblaplicaentrega('BSS_CAR_KCM_200215_1'))THEN

        nuValor := fnuCantTotCuentasConSaldo(nuSUBSCRIBER_ID,nuSUBSCRIPTION_ID,nuPRODUCT_ID);

      ELSE
       -- Retorna a nivel de cliete
        if (nuSUBSCRIBER_ID is not null and nuSUBSCRIPTION_ID is null) then

            for rcDatos in cuDatos loop
                nuValor := nuValor + FA_BOServiciosLiqPorProducto.fnuObtCuentasVencidas(rcDatos.Sesunuse);
            end loop;

        -- Retorna a nivel de Contrato
        elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then

            for rcDatos in cuDatos loop
                nuValor := nuValor + FA_BOServiciosLiqPorProducto.fnuObtCuentasVencidas(rcDatos.Sesunuse);
            end loop;

        -- Retorna a nivel de producto
        elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
                nuValor := FA_BOServiciosLiqPorProducto.fnuObtCuentasVencidas(nuPRODUCT_ID);
        end if;
      END IF;

      -- Retorna el valor calculado
      return nuValor;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      raise;
    when others then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'error al obtener el valor');
      raise;
  end fnuNuCuenSaldo;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuValSaldoPen
    Descripcion    : Funcion que retorna el valor del saldo pendiente
    Autor          : Diego Fernando Rodriguez
    Fecha          : 19/03/2013
  ******************************************************************/
function fnuValSaldoPen (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
    return Varchar2
is
    sbCadeana Varchar2(2000);
begin
    -- Retorna a nivel de cliete
    if (nuSUBSCRIBER_ID is not null and nuSUBSCRIPTION_ID is null) then

            sbCadeana := GC_BODEBTMANAGEMENT.FNUGETDEFDEBTBYCLIE(nuSUBSCRIBER_ID);

    -- Retorna a nivel de Contrato
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then

            sbCadeana := GC_BODEBTMANAGEMENT.FNUGETEXPIRDEBTBYSUSC(nuSUBSCRIPTION_ID);

    -- Retorna a nivel de producto
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
            sbCadeana := GC_BODEBTMANAGEMENT.fnuGetExpirDebtByProd(nuPRODUCT_ID);

    end if;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fnuValSaldoPen;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbSectorOperativo
    Descripcion    : Funcion que retorna el valor del sector operativo
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbSectorOperativo(nuSectorOperativo   or_operating_sector.operating_sector_id%type)
    return Varchar2
is
    cursor cuSectOpere is
        select (os.operating_sector_id||'-'||os.description) Sector from or_operating_sector os where  os.operating_sector_id = nuSectorOperativo;

    sbCadeana Varchar2(2000);
begin

    for rcSectOpere in cuSectOpere loop
         sbCadeana := rcSectOpere.Sector;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbSectorOperativo;


    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbUnidadOperativa
    Descripcion    : Funcion que retorna el valor del unidad operativa
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbUnidadOperativa(nuUnidadOperativa   or_operating_unit.operating_unit_id%type)
    return Varchar2
is
    cursor cuUnidadOperativa is
        select ou.name from or_operating_unit ou where ou.operating_unit_id = nuUnidadOperativa;

    sbCadeana Varchar2(2000);
begin

    for rcUnidadOperativa in cuUnidadOperativa loop
         sbCadeana := nuUnidadOperativa||'-'||rcUnidadOperativa.name;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbUnidadOperativa;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbProductos
    Descripcion    : Funcion que retorna el valor de los productos asociados a un contrato
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbProductos(nuContrato   servsusc.sesususc%type)
    return Varchar2
is
    cursor cuContrato is
        select ss.sesunuse from servsusc ss where ss.sesususc = nuContrato;

    sbCadeana Varchar2(2000);
begin

    for rcContrato in cuContrato loop
         sbCadeana := sbCadeana||' '||rcContrato.sesunuse;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbProductos;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbTipoTrab
    Descripcion    : Funcion que retorna el valor del tipo de trabajo
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbTipoTrab(nuTipoTrab   or_task_type.task_type_id%type)
    return Varchar2
is
    cursor cuTipoTrab is
        select ott.description  from or_task_type ott where ott.task_type_id = nuTipoTrab;

    sbCadeana Varchar2(2000);
begin

    for rcTipoTrab in cuTipoTrab loop
         sbCadeana := nuTipoTrab||'-'||rcTipoTrab.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbTipoTrab;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbActTipoTrab
    Descripcion    : Funcion que retorna el valor del }Actividad tipo de trabajo
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbActTipoTrab(nuActTipoTrab   ge_items.items_id%type)
    return Varchar2
is
    cursor cuActTipoTrab is
        select gi.description  from ge_items gi where gi.items_id = nuActTipoTrab;

    sbCadeana Varchar2(2000);
begin

    for rcActTipoTrab in cuActTipoTrab loop
         sbCadeana := nuActTipoTrab||'-'||rcActTipoTrab.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbActTipoTrab;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbTipoClie
    Descripcion    : Funcion que retorna el valor del Tipo de Cliente
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbTipoClie(nuContrato   ge_subscriber.subscriber_id%type)
    return Varchar2
is
    cursor cuTipoclie is
      select gt.description
         from ge_subscriber gs,ge_subscriber_type gt
        where gt.subscriber_type_id = gs.subscriber_type_id
          and gs.subscriber_id = nuContrato and rownum < 2;

    sbCadeana Varchar2(2000);
begin

    for rcTipoclie in cuTipoclie loop
         sbCadeana := rcTipoclie.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbTipoClie;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbTipoPred
    Descripcion    : Funcion que retorna el valor del Tipo de predio
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
    --------------------------------------------------------------
    Modificaciones
    --------------------------------------------------------------
    Fecha       autor
    Modificacion
    ----------  -----------
    20-12-2013  carlosr.arquitecsosft
    Se cambia para que busque a partir de la direccion del producto
  ******************************************************************/
function fsbTipoPred(inuProduct   pr_product.product_id%type)
    return Varchar2
is
    cursor cuTipoPred is
      select apt.premise_type_id||'-'||apt.description description
            from ab_address ad, pr_product pr, ab_premise ap,ab_premise_type apt
           where ad.address_id = pr.product_id
             and ad.estate_number = ap.premise_id
             and ap.premise_type_id = apt.premise_type_id
             and pr.product_id =  inuProduct and rownum < 2;

    sbCadena Varchar2(2000);
begin

    for rcTipoPred in cuTipoPred loop
         sbCadena := rcTipoPred.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadena;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbTipoPred;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbCiclo
    Descripcion    : Funcion que retorna el valor del Ciclo
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbCiclo(nuContrato   suscripc.susccodi%type)
    return Varchar2
is
    cursor cuCiclo is
       select s.susccicl||'-'||cc.cicldesc description
                    from suscripc s, ciclo cc
                    where s.susccicl = cc.ciclcodi
                     and s.susccodi = nuContrato and rownum < 2;

    sbCadeana Varchar2(2000);
begin

    for rcCiclo in cuCiclo loop
         sbCadeana := rcCiclo.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbCiclo;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbCate
    Descripcion    : Funcion que retorna el valor de la categoria
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbCate(nuContrato   suscripc.susccodi%type)
    return Varchar2
is
    cursor cuCate is
       select cg.catecodi||'-'||cg.catedesc   description
         from servsusc ss,categori cg
         where ss.sesucate = cg.catecodi and ss.sesususc = nuContrato and rownum < 2;

    sbCadeana Varchar2(2000);
begin

    for rcCate in cuCate loop
         sbCadeana := rcCate.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbCate;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbLocalidad
    Descripcion    : Funcion que retorna el valor de la localidad
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbLocalidad(nuContrato   suscripc.susccodi%type)
    return Varchar2
is
    cursor cuLocalidad is
      select  gg.description
       from ge_geogra_location gg,ab_address ab,ge_subscriber g,suscripc s
                    where gg.geograp_location_id = ab.geograp_location_id
                     and ab.address_id = g.address_id
                     and g.subscriber_id = s.suscclie
                     and s.susccodi = nuContrato
                     and rownum < 2;

    sbCadeana Varchar2(2000);
begin

    for rcLocalidad in cuLocalidad loop
         sbCadeana := rcLocalidad.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbLocalidad;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbSubCate
    Descripcion    : Funcion que retorna el valor de la localidad
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbSubCate(nuContrato   suscripc.susccodi%type)
    return Varchar2
is
    cursor cuSubCategor is
      select sc.sucacodi||'-'||sc.sucadesc  description
        from servsusc ss,subcateg sc
        where ss.sesusuca = sc.sucacodi
          and ss.sesucate = sc.sucacate
          and ss.sesususc = nuContrato and rownum <2;

    sbCadeana Varchar2(2000);
begin

    for rcSubCategor in cuSubCategor loop
         sbCadeana := rcSubCategor.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbSubCate;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbNumMedidor
    Descripcion    : Funcion que retorna el valor del numero del medidor
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    15/02/2016        YENTHO            fsbNumMedidor: se modifica el cursor cuNumMedidor para que la consulta
                                        valide que el medidor a visualizar sea el vigente.
  ******************************************************************/
function fsbNumMedidor(nuContrato   suscripc.susccodi%type)
    return Varchar2
is
    cursor cuNumMedidor is
        select el.emsscoem  description
          from servsusc ss,elmesesu el
         where ss.sesunuse = el.emsssesu
           and ss.sesususc = nuContrato
           and ss.sesuserv = 7014
           and el.emssfere > sysdate
           and rownum < 2;

    sbCadeana Varchar2(2000);
begin

    for rcNumMedidor in cuNumMedidor loop
         sbCadeana := rcNumMedidor.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbNumMedidor;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbRefeCatast
    Descripcion    : Funcion que retorna el valor del numero del medidor
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbRefeCatast(nuContrato   suscripc.susccodi%type)
    return Varchar2
is
    cursor cuRefCatastar is
        select aa.cadastral_id  description
          from pr_product pp, ab_address aa
          where pp.address_id = aa.address_id
           and pp.subscription_id = nuContrato
           and  rownum < 2;

    sbCadeana Varchar2(2000);
begin

    for rcRefCatastar in cuRefCatastar loop
         sbCadeana := rcRefCatastar.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbRefeCatast;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbEstadoMedidor
    Descripcion    : Funcion que retorna el valor del estado del medidor
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbEstadoMedidor(nuContrato   suscripc.susccodi%type)
    return Varchar2
is
    cursor cuEstadoMedicor is
      select  pps.product_status_id||' - '||pps.description  description
         from PR_PRODUCT pr, PS_PRODUCT_STATUS pps
         where pr.PRODUCT_STATUS_ID = pps.product_status_id
            and pr.subscription_id = nuContrato and rownum < 2;

    sbCadeana Varchar2(2000);
begin

    for rcEstadoMedicor in cuEstadoMedicor loop
         sbCadeana := rcEstadoMedicor.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbEstadoMedidor;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbEdadDeuda
    Descripcion    : Funcion que retorna el valor de la edad de la deuda
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbEdadDeuda(nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
    return Varchar2
is

    sbCadeana Varchar2(2000);
begin

    -- Retorna a nivel de Contrato
    if (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then

            sbCadeana := GC_BODEBTMANAGEMENT.fnuGetDebtAgeByClie(nuSUBSCRIPTION_ID);

    -- Retorna a nivel de producto
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
            sbCadeana := GC_BODEBTMANAGEMENT. fnuGetDebtAgeBySusc(nuSUBSCRIPTION_ID);

    end if;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbEdadDeuda;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbRutaLectura
    Descripcion    : Funcion que retorna el valor de la ruta de lectura
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbRutaLectura(nuContrato   suscripc.susccodi%type)
    return Varchar2
is
    cursor cuRutaLectura is
      select oro.name description
      from ab_address ad, suscripc sc, ab_premise ap,OR_ROUTE_PREMISE orp,or_route oro
     where orp.route_id = oro.route_id
       and ap.premise_id = orp.premise_id
       and ad.address_id = sc.susciddi
       and ad.estate_number = ap.premise_id
       and sc.susccodi = nuContrato
       and rownum < 2;

    sbCadeana Varchar2(2000);
begin

    for rcRutaLectura in cuRutaLectura loop
         sbCadeana := rcRutaLectura.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbRutaLectura;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbPlaCarAsig
    Descripcion    : Funcion que retorna el valor del plan de Cartera asignado
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbPlaCarAsig(nuOrden   or_order.order_id%type)
    return Varchar2
is
    cursor cuPlanCarAsig is
      select gc.financing_plan_id  description
        from GC_COLL_MGMT_PRO_DET gc
        where gc.order_id = nuOrden and rownum < 2;

    sbCadeana Varchar2(2000);
begin

    for rcPlanCarAsig in cuPlanCarAsig loop
         sbCadeana := rcPlanCarAsig.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbPlaCarAsig;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbUltLectToma
    Descripcion    : Funcion que retorna el valor de la ultima lectura tomada
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbUltLectToma(nuContrato   suscripc.susccodi%type)
    return Varchar2
is
    cursor cuUltimaLectToma is
    select l.leemleto  description
      from lectelme l,servsusc ss
     where l.leemsesu = ss.sesunuse
       and ss.sesususc = nuContrato
       and sesuserv = 7014
       and l.leemfele = (select max(l.leemfele)
                           from lectelme l2,servsusc ss2
                          where l2.leemsesu = ss2.sesunuse
                            and ss2.sesususc = nuContrato
                            and ss2.sesuserv = 7014);

    sbCadeana Varchar2(2000);
begin

    for rcUltimaLectToma in cuUltimaLectToma loop
         sbCadeana := rcUltimaLectToma.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbUltLectToma;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbNumRefina
    Descripcion    : Funcion que retorna el valor del numeor de refinanciaciones
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbNumRefina(nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                      nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                      nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
    return Varchar2
is

    sbCadeana Varchar2(2000);
begin

    -- Retorna a nivel de Contrato
    if (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then

            sbCadeana := gc_bodebtmanagement.fnuGetRefinanOfSusc(nuSUBSCRIPTION_ID,12);

    -- Retorna a nivel de producto
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
            sbCadeana := gc_bodebtmanagement.fnugetrefinanofproduct(nuPRODUCT_ID);

    end if;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbNumRefina;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuValSaldoPenTot
    Descripcion    : Funcion que retorna el valor del saldo pendiente Co
    Autor          : Diego Fernando Rodriguez
    Fecha          : 19/03/2013
  ******************************************************************/
function fnuValSaldoPenTot (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                    nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                    nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
    return Varchar2
is
    sbCadeana Varchar2(2000);
begin
    -- Retorna a nivel de cliete
    if (nuSUBSCRIBER_ID is not null and nuSUBSCRIPTION_ID is null) then

            sbCadeana := GC_BODEBTMANAGEMENT.FNUGETDEBTBYCLIE(nuSUBSCRIPTION_ID);

    -- Retorna a nivel de Contrato
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then

            sbCadeana := GC_BODEBTMANAGEMENT.Fnugetdebtbysusc(nuSUBSCRIPTION_ID);

    -- Retorna a nivel de producto
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
            sbCadeana := GC_BODEBTMANAGEMENT.FNUGETDEBTBYPROD(nuSUBSCRIPTION_ID);

    end if;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fnuValSaldoPenTot;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbFechUltiRefi
    Descripcion    : Funcion que retorna el valor de la ultima refinanciacion
    Autor          : Diego Fernando Rodriguez
    Fecha          : 21/03/2013
  ******************************************************************/
function fsbFechUltiRefi(nuContrato   suscripc.susccodi%type)
    return Varchar2
is
    cursor cuFechUltimaRefina is
      SELECT  max(request_date) Fecha_Ultima_Refi
      FROM    cc_financing_request fr, mo_packages pa
      WHERE   fr.package_id = pa.package_id
              AND pa.motive_status_id = 14 -- Estado Atendido
              AND fr.subscription_id = nuContrato;

    sbCadeana Varchar2(2000);
begin

    for rcFechUltimaRefina in cuFechUltimaRefina loop
         sbCadeana := rcFechUltimaRefina.Fecha_Ultima_Refi;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbFechUltiRefi;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbSaldoDifer
    Descripcion    : Funcion que retorna el valor del saldo pendiente Co
    Autor          : Diego Fernando Rodriguez
    Fecha          : 19/03/2013
  ******************************************************************/
function fsbSaldoDifer(nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                       nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                       nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
    return Varchar2
is
    sbCadeana Varchar2(2000);
begin
    -- Retorna a nivel de cliete
    if (nuSUBSCRIBER_ID is not null and nuSUBSCRIPTION_ID is null) then

            sbCadeana := GC_BODEBTMANAGEMENT.FNUGETDEFDEBTBYCLIE(nuSUBSCRIPTION_ID);

    -- Retorna a nivel de Contrato
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then

            sbCadeana := GC_BODEBTMANAGEMENT.Fnugetdefdebtbysusc(nuSUBSCRIPTION_ID);

    -- Retorna a nivel de producto
    elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
            sbCadeana := GC_BODEBTMANAGEMENT.FNUGETDEFDEBTBYPROD(nuSUBSCRIPTION_ID);

    end if;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbSaldoDifer;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbEstadoCuenta1
    Descripcion    : Funcion que retorna el valor del saldo pendiente Co
    Autor          : Diego Fernando Rodriguez
    Fecha          : 19/03/2013
  ******************************************************************/
function fsbEstadoCuenta1(nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                         nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                         nuPRODUCT_ID in or_order_activity.PRODUCT_ID%type)

    return Varchar2
is

    onuCurrentAccountTotal  number;
    onuDeferredAccountTotal number;
    onuCreditBalance        number;
    onuClaimValue           number;
    onuDefClaimValue        number;
    otbBalanceAccounts      fa_boaccountstatustodate.tytbBalanceAccounts;
    otbDeferredBalance      fa_boaccountstatustodate.tytbDeferredBalance;
    pos                     varchar2(1000);
    sbConcepts              varchar2(10000) := '';
    sbTab                   varchar2(2) := chr(9);
    sbTab2                  varchar2(6) := chr(9)||chr(9)||chr(9)||chr(9);
    sbLine                  varchar2(2) := chr(10);

    cursor cuDatos is
      select ss.sesunuse from SUSCRIPC s, servsusc ss
       where s.susccodi = ss.sesususc
         and s.SUSCCLIE = decode(nuSUBSCRIBER_ID,null,SUSCCLIE,nuSUBSCRIBER_ID)
         and s.susccodi = decode(nuSUBSCRIPTION_ID,null,s.susccodi,nuSUBSCRIPTION_ID);

    -- Calcula el estado de cuenta por producto
    procedure prEstaProducto (nuFunPRODUCT_ID in or_order_activity.PRODUCT_ID%type)
      is
        cursor cuConc (inuConcepto in concepto.conccodi%type) is
           select c.concdesc from concepto c where c.conccodi = inuConcepto;

          sbDecConc concepto.concdesc%type;
      begin
          fa_boaccountstatustodate.ProductBalanceAccountsToDate
          (
          nuFunPRODUCT_ID,
          sysdate,
          onuCurrentAccountTotal,
          onuDeferredAccountTotal,
          onuCreditBalance,
          onuClaimValue,
          onuDefClaimValue,
          otbBalanceAccounts,
          otbDeferredBalance
          );
          pos:= otbBalanceAccounts.first;

          while pos IS not null loop

              sbDecConc := null;
              for rcConc in cuConc(otbBalanceAccounts(pos).conccodi) loop
                  sbDecConc := rcConc.Concdesc;
              end loop;

              sbConcepts := sbConcepts || to_char(otbBalanceAccounts(pos).cucocodi) || sbTab2 ||
                           to_char(otbBalanceAccounts(pos).conccodi)||'-'||
                            sbDecConc||
                            sbTab2 || to_char(otbBalanceAccounts(pos).cucodive) ||
                           sbTab2 || to_char(otbBalanceAccounts(pos).saldvalo) || sbLine;
              pos := otbBalanceAccounts.next(pos);
          END loop;

      end prEstaProducto;


BEGIN                         -- ge_module
/*    errors.Initialize;
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(99);
    ut_trace.Trace('INICIO');
    */
    sbConcepts := 'Cuenta Cobro' || sbTab || 'Concepto' || sbTab || 'Dias Vencimiento' || sbTab || 'Valor' || sbLine;

    if (nuPRODUCT_ID is not null) then
        prEstaProducto(nuPRODUCT_ID);
    elsif (nuSUBSCRIBER_ID is not null or nuSUBSCRIPTION_ID is not null) then
        for rcDatos in cuDatos loop
            prEstaProducto(rcDatos.Sesunuse);
        end loop;
    end if;

    return sbConcepts;


EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbEstadoCuenta1;


/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : fsbUltComentarioOT
Descripcion    : Retorna el ultimo comentario de una OT
Autor          : Diego Fernando Rodriguez
Fecha          : 17/05/2013
******************************************************************/
function fsbUltComentarioOT (inuOrden or_order.order_id%type)
return Varchar2 IS

   -- Obtiene valores tabla comentario
   cursor cuComentario is
      select order_comment,register_date,comment_type_id
       from
         (
          select c.order_comment,c.register_date,c.comment_type_id
            from or_order_comment c
           where c.order_id = inuOrden
          order by c.register_date desc
          )
        where rownum < 2;

    sbCadena or_order_comment.order_comment%type;
begin

    for rcComentario in cuComentario loop
       sbCadena  := rcComentario.Order_Comment;
    end loop;

    return sbCadena;

end fsbUltComentarioOT;

/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : fsbUltTipoComentOT
Descripcion    : Retorna el ultimo tipo de comentario de una OT
Autor          : Diego Fernando Rodriguez
Fecha          : 17/05/2013
******************************************************************/
function fsbUltTipoComentOT (inuOrden or_order.order_id%type)
return Varchar2 IS

   -- Obtiene valores tabla comentario
   cursor cuComentario is
      select order_comment,register_date,comment_type_id
       from
         (
          select c.order_comment,c.register_date,c.comment_type_id
            from or_order_comment c
           where c.order_id = inuOrden
          order by c.register_date desc
          )
        where rownum < 2;

   sbCadena or_order_comment.order_comment%type;
begin

    for rcComentario in cuComentario loop
       sbCadena  := rcComentario.Comment_Type_Id;
    end loop;

    return sbCadena;

end fsbUltTipoComentOT;


/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : fsbUltFechComentOT
Descripcion    : Retorna el ultimo fecha de registro de un comentario de una OT
Autor          : Diego Fernando Rodriguez
Fecha          : 17/05/2013
******************************************************************/
function fsbUltFechComentOT (inuOrden or_order.order_id%type)
return Varchar2 IS

   -- Obtiene valores tabla comentario
   cursor cuComentario is
      select order_comment,register_date,comment_type_id
       from
         (
          select c.order_comment,c.register_date,c.comment_type_id
            from or_order_comment c
           where c.order_id = inuOrden
          order by c.register_date desc
          )
        where rownum < 2;

    sbCadena or_order_comment.order_comment%type;

begin

    for rcComentario in cuComentario loop
       sbCadena  := to_char(rcComentario.Register_Date,'DD-MM-YYYY');
    end loop;

    return sbCadena;

end fsbUltFechComentOT;

/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad         : fsbEstCort
Descripcion    : Retorna el estado de corte del servicio
Autor          : Jorge Valiente
Fecha          : 19/06/2014
******************************************************************/
function fsbEstCortServicio(nuContrato servsusc.sesususc%type)
  return Varchar2 IS

  cursor cuservsusc is
    select ss.sesuesco || ' - ' || daestacort.fsbgetescodesc(ss.sesuesco) Estado_Corte
      from servsusc ss
     where ss.sesususc = nuContrato
       and ss.sesuserv =
           dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS', null);

  sbCadena varchar2(250);

begin

  for rccuservsusc in cuservsusc loop
    sbCadena := rccuservsusc.Estado_Corte;
  end loop;

  return sbCadena;

end fsbEstCortServicio;


    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbEstCort
    Descripcion    : Retorna el Metodo de Suspencion del producto
    Autor          : Alexandra Gordillo
    Fecha          : 29/08/2014
    ******************************************************************/
    function fsbMetodoSuspencion(nuProduct or_order_activity.product_id%type) return Varchar2 IS
        nuProducto         or_order_activity.product_id%type;
        sbTTSuspencion      varchar2(1000);
        nuOrdenSuspencion   or_order.order_id%type;
        sbMetodoSuspencion  varchar2(100);
        sbSQL               varchar2(1000);

    begin
    --sbTTSuspencion := dald_parameter.fsbGetValue_Chain('TIPOS_TRABAJO_SUSPENCION');

    sbTTSuspencion :=  'SELECT column_value
                        from table (ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain(''TIPOS_TRABAJO_SUSPENCION''),'',''))';

    -- Obtiene la ultima orden de suspencion generada para el producto
    sbSQL := ' select orden
               from (  select or_order_activity.order_id orden from or_order_activity, or_order
                        where product_id= '||nuProduct||
                      ' and or_order_activity.task_type_id in ('||sbTTSuspencion||') '||
                       'and status=''F''
                        and or_order_activity.order_id = or_order.order_id
                        order by or_order.created_date desc)
               where rownum=1';


    EXECUTE IMMEDIATE sbSQL into nuOrdenSuspencion;

    ut_trace.trace('Consulta: '||sbSQL , 10);
    ut_trace.trace('Orden de Suspension: '||nuOrdenSuspencion , 10);

        -- Se obtiene el dato adicional de Metodo de Suspencion
    IF (nuOrdenSuspencion is not null) THEN
        BEGIN
            select value_1 into sbMetodoSuspencion
            from or_requ_data_value
            where order_id=nuOrdenSuspencion
            and name_1='METODO_SUSPENSION'
            and rownum=1;
        EXCEPTION
            when no_data_found then
                sbMetodoSuspencion := ' - ';
        END;
    END IF;

    RETURN sbMetodoSuspencion;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            return ' - ';
        when others then
            return ' - ';
    end fsbMetodoSuspencion;

    /*****************************************************************
    Propiedad intelectual de CSC.

    Unidad         : fnuCantTotCuentasConSaldo
    Descripcion    : Función para obtener la cantidad de cuentas con saldo
                     (vencidas y no vencidas) de un producto.
    Autor          : KCienfuegos
    Caso           : CA200-215
    Fecha          : 15/04/2016

    Parametros           Descripcion
    ============       ===================
    nuSUBSCRIBER_ID     Cliente
    nuSUBSCRIPTION_ID   Contrato
    nuPRODUCT_ID        Producto

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    ******************************************************************/
    FUNCTION fnuCantTotCuentasConSaldo (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                                        nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                                        nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
    RETURN VARCHAR2 IS
      nuValor number := 0;

      CURSOR CuDatos is
        SELECT ss.sesunuse from SUSCRIPC s, servsusc ss
         WHERE s.susccodi = ss.sesususc
           AND s.SUSCCLIE = decode(nuSUBSCRIBER_ID,null,SUSCCLIE,nuSUBSCRIBER_ID)
           AND s.susccodi = decode(nuSUBSCRIPTION_ID,null,s.susccodi,nuSUBSCRIPTION_ID);

    BEGIN
        -- Retorna a nivel de cliete
        if (nuSUBSCRIBER_ID is not null and nuSUBSCRIPTION_ID is null) then

            for rcDatos in cuDatos loop
                nuValor := nuValor + cc_boBssProductData.fnuAccountWithBalance(rcDatos.Sesunuse);
            end loop;

        -- Retorna a nivel de Contrato
        elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then

            for rcDatos in cuDatos loop
                nuValor := nuValor + cc_boBssProductData.fnuAccountWithBalance(rcDatos.Sesunuse);
            end loop;

        -- Retorna a nivel de producto
        elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
                nuValor := cc_boBssProductData.fnuAccountWithBalance(nuPRODUCT_ID);
        end if;

        -- Retorna el valor calculado
        return nuValor;

    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        RAISE;
      WHEN OTHERS THEN
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'error al obtener el valor');
       RAISE;
    END fnuCantTotCuentasConSaldo;

end LDC_CA_NOTI;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CA_NOTI', 'ADM_PERSON');
END;
/