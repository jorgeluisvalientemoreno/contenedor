CREATE OR REPLACE PACKAGE IC_BCLisimProvRev AS
/*
    Propiedad intelectual de Open International Systems. (c).

    Paquete	    :   IC_BCLisimProvRev
    Descripcion	:   Componente para obtener consultas para el proceso de
                    Provision de Cartera usando el metodo LISIM.

    Autor	    :   German Alexis Duque
    Fecha	    :   11-05-2012

    Historia de Modificaciones
    Fecha	    IDEntrega

    17-07-2013  hlopez.SAO212472
    Se adiciona el atributo Clasificacion Contable del Contrato.
    - Se modifica el metodo <DelProvRetMovements> y <MassiveInsertion>

    29-08-2012  gduqueSAO188287
    Se adiciona los metodos <MassiveInsertion> y <GetConfigInAccounts>.
    Se adiciona el type  rtyConfig y la tabla tytbConfig

    11-05-2012  crodriguezSAO180613
    Creacion.
*/


  	---------------
	-- VARIABLES
	---------------
    type tytbCuentaxProd is record
		(
		CUCOCODI pktblcuencobr.tyCUCOCODI,
    	CUCOVAAP pktblcuencobr.tyCUCOVAAP,
		CUCOVARE pktblcuencobr.tyCUCOVARE,
		CUCOVAAB pktblcuencobr.tyCUCOVAAB,
		CUCOVATO pktblcuencobr.tyCUCOVATO,
		CUCOFEPA pktblcuencobr.tyCUCOFEPA,
		CUCONUSE pktblcuencobr.tyCUCONUSE,
		CUCOSACU pktblcuencobr.tyCUCOSACU,
		CUCOVRAP pktblcuencobr.tyCUCOVRAP,
		CUCOFACT pktblcuencobr.tyCUCOFACT,
		CUCOFEVE pktblcuencobr.tyCUCOFEVE,
		CUCOVAFA pktblcuencobr.tyCUCOVAFA,
        CUCOFEGE pktblfactura.tyFACTFEGE,
        CUCODIMO pktblic_detlisim.tyDelidimo
		 );

    -- Record Config
    type rtyConfig is record
    (
        Corccons    ic_confreco.corccons%type,
        Corccoco    ic_confreco.corccoco%type,
        Ccrccamp    ic_crcoreco.ccrccamp%type,
        Ccrcvalo    ic_crcoreco.ccrcvalo%type
    );

    -- Tabla Procesos
    type tytbConfig IS table of rtyConfig;


    ----------------------------------------------------------------------------
    -- Metodos
    ----------------------------------------------------------------------------

    -- Obtiene version actual de paquete
    FUNCTION fsbVersion
        return varchar2;

    -- Eliminar Registros de Provision de Cartera
    PROCEDURE DeleteLisimProv
    (
         idtFechGen   in  ic_cartprov.caprfeco%type,
         isbTyPrEx    in varchar2,
         odlFlagDatos out boolean
    );

    -- Eliminar registros de Detalle LISIM

    PROCEDURE DeleteDetLisimProv
    (
      idtFechGen   in  ic_detlisim.delifeco%type,
      odlFlagDatos out boolean
    );

    -- Elimina Movimientos de Provision tmp_ic_moviprov de Cartera
    PROCEDURE DelTmpMovProvision
    (
        inuTipDocu    in  ic_tipodoco.tidccodi%type,
        isbTyPrEx     in  varchar2,
        odlFlagDatos  out boolean
    );

    -- Elimina hechos economicos de devolucion provision de Cartera
    PROCEDURE DelProvRetMovements
    (
        idtFechaFinal           in          ic_movimien.movifeco%type              ,
        inuTipoDocum            in          ic_movimien.movitido%type              ,
        inuTipoMovim            in          ic_movimien.movitimo%type              ,
        inuLimiteObt            in          number                                 ,
        isbTyPrEx               in          varchar2                               ,
        isbTiheDes              in          ic_movimien.movitihe%type              ,
        oblMasDatos             out         boolean                                ,
        orctbTmp_Ic_Moviprov    out nocopy  IC_BCTmp_Ic_Moviprov.rtyTmp_Ic_Moviprov
    );

    -- Elimina hechos economicos de provision de Cartera
    PROCEDURE DelProvMovements
    (
        idtFechaFinal   in  ic_movimien.movifeco%type,
        inuTipoDocum    in  ic_movimien.movitido%type,
        inuTipoMovim    in  ic_movimien.movitimo%type,
        isbTyPrEx       in  varchar2                 ,
        isbTiheProv      in  ic_movimien.movitihe%type,
        inuLimiteObt    in  number                   ,
        oblMasDatos     out boolean
    );

    --Inserta hechos economicos masivamente.
    PROCEDURE MassiveInsertion
    (
        irctbTmp_Ic_Moviprov    in  IC_BCTmp_Ic_Moviprov.rtyTmp_Ic_Moviprov
    );

    PROCEDURE GetConfigInAccounts
    (
         inuTido        in ic_tipodoco.tidccodi%type,
         inuTimo        in ic_tipomovi.timocodi%type,
         nuCompany      in sistema.sistcodi%type,
         idtDateProcess in ic_encoreco.ecrcfech%type,
         otbConfig      out nocopy tytbConfig
    );


END IC_BCLisimProvRev;
/
CREATE OR REPLACE PACKAGE BODY IC_BCLisimProvRev AS
/*
    Propiedad intelectual de Open International Systems. (c).

    Paquete	    :   IC_BCLisimProvRev
    Descripcion	:   Variables, procedimientos y funciones privados del
		            paquete IC_BCLisimProv.

    Autor	    :   German Alexis Duque
    Fecha	    :   11-05-2012

    Historia de Modificaciones
    Fecha	    IDEntrega

    17-07-2013  hlopez.SAO212472
    Se adiciona el atributo Clasificacion Contable del Contrato.
    - Se modifica el metodo <DelProvRetMovements> y <MassiveInsertion>

    08-04-2013   sgomez.SAO205719
    Se modifica <Provision LISIM> por impacto en <Hechos Economicos>
    (adicion de atributo <Item>).

    29-08-2012  gduqueSAO188287
    Se adiciona los metodos <MassiveInsertion> y <GetConfigInAccounts>.

    29-08-2012  sgomez.SAO188677
    Se eliminan referencias a la columna <IC_MOVIPROV.MVPRTIAC>.

    16-08-2012  arendon.SAO188612
    NOTA:   Revision "Fantasma" para entrega del SAO185243 por cambios de esquema
            en IC_MOVIMIEN. NO usar para ningun tipo de analisis.

    11-05-2012  crodriguezSAO180613
    Creacion.
*/

    ----------------------------------------------------------------------------
    -- Constantes
    ----------------------------------------------------------------------------

    -- Version de paquete
    csbVersion constant varchar2(250) := 'SAO212472';
    -- Limite de datos a Procesar
    cnulimit   constant number := 100;

    ----------------------------------------------------------------------------
    -- Variables
    ----------------------------------------------------------------------------
    -- Descripcion mensaje de error
    sbMensajeError      ge_error_log.description%type;


    ----------------------------------------------------------------------------
    -- Metodos
    ----------------------------------------------------------------------------

    /*
        Propiedad intelectual de Open International Systems. (c).

        Funcion 	:   fsbVersion
        Descripcion	:   Obtiene SAO que identifica version asociada a ultima
                        entrega del paquete.

        Retorno     :
            csbVersion      Version de paquete.

        Autor	    :   German Alexis Duque
        Fecha	    :   11-05-2012

        Historia de Modificaciones
        Fecha	    IDEntrega

        11-05-2012  crodriguezSAO180613
        Creacion.
    */

        FUNCTION fsbVersion
            return varchar2
        IS
        BEGIN

            pkErrors.Push
            (
                'IC_BCLisimProvRev.fsbVersion'
            );

            pkErrors.Pop;

            return IC_BCLisimProvRev.csbVersion;

        EXCEPTION
            when LOGIN_DENIED OR ex.CONTROLLED_ERROR then
                pkErrors.Pop;
                raise LOGIN_DENIED;
            when pkConstante.exERROR_LEVEL2 then
                pkErrors.Pop;
                raise pkConstante.exERROR_LEVEL2;
            when OTHERS then
            	pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject  ,
                    sqlerrm                 ,
                    sbMensajeError
                );
                pkErrors.Pop;
            	raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    sbMensajeError
                );

        END fsbVersion;


        /*Propiedad intelectual de Open International Systems (c).

        Funcion     : DeleteLisimProv
        Descripcion : Elimina los registros de Provision de Cartera

        Parametros    :
                 idtFechGen    Fecha de Contabilizacion
                 odlFlagDatos  Flag de existencia de registros

        Autor	    :   German Alexis Duque
        Fecha	    :   11-05-2012

        Historia de Modificaciones
        Fecha	    IDEntrega

        11-05-2012  crodriguezSAO180613
        Creacion.
    */
        PROCEDURE DeleteLisimProv
          (
            idtFechGen   in ic_cartprov.caprfeco%type,
            isbTyPrEx    in varchar2,
            odlFlagDatos out boolean
          )
       IS

       BEGIN
          pkerrors.Push ('IC_BCLisimProvRev.DeleteLisimProv');

          odlFlagDatos := TRUE;

          DELETE --+ index(ic_cartprov, IX_IC_CARTPROV01)
                 ic_cartprov /*+ IC_BCLisimProvRev.DeleteLisimProv */
          WHERE  caprfeco = idtFechGen
            AND  instr(','||isbTyPrEx||',',','||caprserv||',',1,1) <> 0
           AND ROWNUM <= cnuLimit;

          if(SQL%ROWCOUNT = 0) then
            odlFlagDatos := FALSE;
            pkGeneralServices.TraceData ('Eliminacion Cartera Provisionada ic_cartprov');
            pkGeneralServices.TraceData ('Fecha: '||idtFechGen);
          end if;

          pkerrors.Pop;

        EXCEPTION
            when LOGIN_DENIED OR ex.CONTROLLED_ERROR then
                pkErrors.Pop;
                raise LOGIN_DENIED;
            when pkConstante.exERROR_LEVEL2 then
                pkErrors.Pop;
                raise pkConstante.exERROR_LEVEL2;
            when OTHERS then
            	pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject  ,
                    sqlerrm                 ,
                    sbMensajeError
                );
                pkErrors.Pop;
            	raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    sbMensajeError
                );

       END DeleteLisimProv;

       /*
       Propiedad intelectual de Open International Systems (c).

       Funcion     : DeleteDetLisimProv
       Descripcion : Elimina los registros de Provision de Cartera

       Parametros    :
                 idtFechGen    Fecha de Contabilizacion
                 odlFlagDatos  Flag de existencia de registros

        Autor	    :   German Alexis Duque
        Fecha	    :   11-05-2012

        Historia de Modificaciones
        Fecha	    IDEntrega

        11-05-2012  crodriguezSAO180613
        Creacion.
       */
       PROCEDURE DeleteDetLisimProv
         (
            idtFechGen   in  ic_detlisim.delifeco%type,
            odlFlagDatos out boolean
          )
       IS

       BEGIN
          pkerrors.Push ('IC_BCLisimProvRev.DeleteDetLisimProv');

          odlFlagDatos := TRUE;

          DELETE /*+ INDEX (ic_detlisim IX_IC_DETLISIM01)*/
                 ic_detlisim  /*+ IC_BCLisimProvRev.DeleteDetLisimProv */
           WHERE delifeco = idtFechGen
             AND ROWNUM <= cnuLimit;

          if(SQL%ROWCOUNT = 0) then
            odlFlagDatos := FALSE;
            pkGeneralServices.TraceData ('Eliminacion Detalle LISIM');
            pkGeneralServices.TraceData ('Fecha: '||idtFechGen);
          end if;



          pkerrors.Pop;

        EXCEPTION
            when LOGIN_DENIED OR ex.CONTROLLED_ERROR then
                pkErrors.Pop;
                raise LOGIN_DENIED;
            when pkConstante.exERROR_LEVEL2 then
                pkErrors.Pop;
                raise pkConstante.exERROR_LEVEL2;
            when OTHERS then
            	pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject  ,
                    sqlerrm                 ,
                    sbMensajeError
                );
                pkErrors.Pop;
            	raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    sbMensajeError
                );

       END DeleteDetLisimProv;

    /*
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: DelTmpMovProvision

    Descripcion	: Eliminar movimientos provisionados de la entidad temporal

    Parametros	:	Descripcion
        inuTipDocu  Tipo de Documento
        isbTyPrEx   Tipos de Producto a Excluir
    Retorno     :
        odlFlagDatos  Exito

    Autor	    :   German Alexis Duque
    Fecha	    :   11-05-2012

    Historia de Modificaciones
    Fecha	    IDEntrega

    11-05-2012  crodriguezSAO180613
    Creacion.
    */
    PROCEDURE DelTmpMovProvision
    (
        inuTipDocu    in  ic_tipodoco.tidccodi%type,
        isbTyPrEx     in  varchar2,
        odlFlagDatos  out boolean
    )
    IS
    BEGIN
        pkErrors.Push('IC_BCLisimProvRev.DelTmpMovProvision');

        odlFlagDatos := TRUE;

        DELETE  --+ index(tmp_ic_moviprov, IX_TMP_IC_MOVIPROV01)
        tmp_ic_moviprov /*+IC_BCLisimProvRev.DelTmpMovProvision*/
        WHERE mvprtido = inuTipDocu
        AND    instr(','||isbTyPrEx||',',','||mvprserv||',',1,1) <> 0
        AND ROWNUM <= cnuLimit;

        if(SQL%ROWCOUNT = 0) then
            odlFlagDatos := FALSE;
        end if;

        pkErrors.Pop;


    EXCEPTION
        when LOGIN_DENIED OR ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise LOGIN_DENIED;
        when pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;
        when OTHERS then
        	pkErrors.NotifyError
            (
                pkErrors.fsbLastObject  ,
                sqlerrm                 ,
                sbMensajeError
            );
            pkErrors.Pop;
        	raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                sbMensajeError
            );

    END DelTmpMovProvision;

    /*
        Propiedad intelectual de Open International Systems. (c).

        Procedimiento :   DelProvRetMovements
        Descripcion	  :   Elimina hechos economicos de devolucion provision.

        Parametros    :
            idtFechaFinal       Fecha final de mes de devolucion provision.
            inuTipoDocum        Tipo documento.
            inuTipoMovim        Tipo movimiento.
            inuLimiteObt        Limite de obtencion de registros.
            isbTyPrEx           Tipos de Producto a excluir
            isbTiheDes          Tipo de HE Desprovision
        Retorno       :
            oblMasDatos                 Indica si existen mas datos por obtener.
            orctbTmp_Ic_Moviprov        Hechos economicos.

        Autor	    :   German Alexis Duque
        Fecha	    :   11-05-2012

        Historia de Modificaciones
        Fecha	    IDEntrega
        27-02-2018  rcolpas.SAO200192
        Se modifica para que la eliminaci?n se haga por registro.
        utilizando bull collect con limt de 1000

        17-07-2013  hlopez.SAO212472
        Se adiciona el atributo Clasificacion Contable del Contrato.

        08-04-2013   sgomez.SAO205719
        Se modifica <Provision LISIM> por impacto en <Hechos Economicos>
        (adicion de atributo <Item>).

        11-05-2012  crodriguezSAO180613
        Creacion.
    */

    PROCEDURE DelProvRetMovements
    (
        idtFechaFinal           in          ic_movimien.movifeco%type              ,
        inuTipoDocum            in          ic_movimien.movitido%type              ,
        inuTipoMovim            in          ic_movimien.movitimo%type              ,
        inuLimiteObt            in          number                                 ,
        isbTyPrEx               in          varchar2                               ,
        isbTiheDes              in          ic_movimien.movitihe%type              ,
        oblMasDatos             out         boolean                                ,
        orctbTmp_Ic_Moviprov    out nocopy  IC_BCTmp_Ic_Moviprov.rtyTmp_Ic_Moviprov
    )
    IS

        ------------------------------------------------------------------------
        -- Constantes
        ------------------------------------------------------------------------


        ----------------------------------------------------------------------------
        -- Variables
        ----------------------------------------------------------------------------
        TYPE ic_movimien_TYPE is record(
                                  movicons	ic_movimien.movicons%type
                                );

        TYPE t_array_ic_movimien IS TABLE OF ic_movimien_TYPE;

        itab       t_array_ic_movimien;
        rtmovimien SYS_REFCURSOR;

        sbQuery    Varchar2(5000);
        nuCant     Number:=0;
    BEGIN

        pkErrors.Push
        (
            'IC_BCLisimProvRev.DelProvRetMovements'
        );

        oblMasDatos := TRUE;

       sbQuery := 'SELECT  --+ index(ic_movimien IX_IC_MOVIMIEN02)
                            movicons
                    FROM    ic_movimien
                            /*+IC_BCLisimProvRev.DelProvRetMovements*/
                    WHERE   movifeco = '''|| idtFechaFinal ||
                   ''' AND     movitido = '|| inuTipoDocum  ||
                   '   AND     movitimo = '|| inuTipoMovim  ||
                   '   AND     movitihe = '''|| isbTiheDes    ||
                   ''' AND     instr('',''||'''|| isbTyPrEx ||'''||'','','',''||moviserv||'','',1,1) <> 0
                       AND     rownum < '|| inuLimiteObt ||' + 1';

       OPEN rtmovimien FOR sbQuery;
       LOOP
         FETCH rtmovimien BULK COLLECT
         INTO itab LIMIT 1000;
         BEGIN
           FOR i IN 1..itab.count LOOP
              /*Eliminamos el registro*/
              DELETE ic_movimien WHERE movicons = itab(i).movicons
              returning     moviancb,
                            movibanc,
                            movibatr,
                            movicaca,
                            movicate,
                            moviceco,
                            movicicl,
                            movicldp,
                            moviconc,
                            movicuba,
                            moviempr,
                            movifeap,
                            movifeco,
                            movifetr,
                            movifeve,
                            movifopa,
                            moviimp1,
                            moviimp2,
                            moviimp3,
                            movimecb,
                            movinips,
                            movinudo,
                            movinutr,
                            moviserv,
                            movisici,
                            movisifa,
                            movisign,
                            movisipr,
                            movisire,
                            movisivr,
                            movisuba,
                            movisuca,
                            movisusc,
                            movitdsr,
                            moviterc,
                            moviterm,
                            movitica,
                            movitidi,
                            movitido,
                            movitihe,
                            movitimo,
                            movititb,
                            movitoim,
                            moviubg1,
                            moviubg2,
                            moviubg3,
                            moviubg4,
                            moviubg5,
                            moviusua,
                            movivalo,
                            movivatr,
                            movivir1,
                            movivir2,
                            movivir3,
                            movivtir,
                            moviproy,
                            moviclit,
                            moviunid,
                            movidipr,
                            movinaca,
                            movicons,
                            moviitem,
                            moviclcc
                  bulk collect
            into            orctbTmp_Ic_Moviprov.mvprancb,
                            orctbTmp_Ic_Moviprov.mvprbanc,
                            orctbTmp_Ic_Moviprov.mvprbatr,
                            orctbTmp_Ic_Moviprov.mvprcaca,
                            orctbTmp_Ic_Moviprov.mvprcate,
                            orctbTmp_Ic_Moviprov.mvprceco,
                            orctbTmp_Ic_Moviprov.mvprcicl,
                            orctbTmp_Ic_Moviprov.mvprcldp,
                            orctbTmp_Ic_Moviprov.mvprconc,
                            orctbTmp_Ic_Moviprov.mvprcuba,
                            orctbTmp_Ic_Moviprov.mvprempr,
                            orctbTmp_Ic_Moviprov.mvprfeap,
                            orctbTmp_Ic_Moviprov.mvprfeco,
                            orctbTmp_Ic_Moviprov.mvprfetr,
                            orctbTmp_Ic_Moviprov.mvprfeve,
                            orctbTmp_Ic_Moviprov.mvprfopa,
                            orctbTmp_Ic_Moviprov.mvprimp1,
                            orctbTmp_Ic_Moviprov.mvprimp2,
                            orctbTmp_Ic_Moviprov.mvprimp3,
                            orctbTmp_Ic_Moviprov.mvprmecb,
                            orctbTmp_Ic_Moviprov.mvprnips,
                            orctbTmp_Ic_Moviprov.mvprnudo,
                            orctbTmp_Ic_Moviprov.mvprnutr,
                            orctbTmp_Ic_Moviprov.mvprserv,
                            orctbTmp_Ic_Moviprov.mvprsici,
                            orctbTmp_Ic_Moviprov.mvprsifa,
                            orctbTmp_Ic_Moviprov.mvprsign,
                            orctbTmp_Ic_Moviprov.mvprsipr,
                            orctbTmp_Ic_Moviprov.mvprsire,
                            orctbTmp_Ic_Moviprov.mvprsivr,
                            orctbTmp_Ic_Moviprov.mvprsuba,
                            orctbTmp_Ic_Moviprov.mvprsuca,
                            orctbTmp_Ic_Moviprov.mvprsusc,
                            orctbTmp_Ic_Moviprov.mvprtdsr,
                            orctbTmp_Ic_Moviprov.mvprterc,
                            orctbTmp_Ic_Moviprov.mvprterm,
                            orctbTmp_Ic_Moviprov.mvprtica,
                            orctbTmp_Ic_Moviprov.mvprtidi,
                            orctbTmp_Ic_Moviprov.mvprtido,
                            orctbTmp_Ic_Moviprov.mvprtihe,
                            orctbTmp_Ic_Moviprov.mvprtimo,
                            orctbTmp_Ic_Moviprov.mvprtitb,
                            orctbTmp_Ic_Moviprov.mvprtoim,
                            orctbTmp_Ic_Moviprov.mvprubg1,
                            orctbTmp_Ic_Moviprov.mvprubg2,
                            orctbTmp_Ic_Moviprov.mvprubg3,
                            orctbTmp_Ic_Moviprov.mvprubg4,
                            orctbTmp_Ic_Moviprov.mvprubg5,
                            orctbTmp_Ic_Moviprov.mvprusua,
                            orctbTmp_Ic_Moviprov.mvprvalo,
                            orctbTmp_Ic_Moviprov.mvprvatr,
                            orctbTmp_Ic_Moviprov.mvprvir1,
                            orctbTmp_Ic_Moviprov.mvprvir2,
                            orctbTmp_Ic_Moviprov.mvprvir3,
                            orctbTmp_Ic_Moviprov.mvprvtir,
                            orctbTmp_Ic_Moviprov.mvprproy,
                            orctbTmp_Ic_Moviprov.mvprclit,
                            orctbTmp_Ic_Moviprov.mvprunid,
                            orctbTmp_Ic_Moviprov.mvprdipr,
                            orctbTmp_Ic_Moviprov.mvprnaca,
                            orctbTmp_Ic_Moviprov.mvprcons,
                            orctbTmp_Ic_Moviprov.mvpritem,
                            orctbTmp_Ic_Moviprov.mvprclcc;
             nuCant := nuCant + 1;
           END LOOP;
         END;
       EXIT WHEN rtmovimien%NOTFOUND;
       END LOOP;

        /*DELETE  --+ index(ic_movimien IX_IC_MOVIMIEN02)
                ic_movimien
                \*+IC_BCLisimProvRev.DelProvRetMovements*\
        WHERE   movifeco = idtFechaFinal
        AND     movitido = inuTipoDocum
        AND     movitimo = inuTipoMovim
        AND     movitihe =  isbTiheDes
        AND     instr(','||isbTyPrEx||',',','||moviserv||',',1,1) <> 0
        AND     rownum < inuLimiteObt + 1
            returning       moviancb,
                            movibanc,
                            movibatr,
                            movicaca,
                            movicate,
                            moviceco,
                            movicicl,
                            movicldp,
                            moviconc,
                            movicuba,
                            moviempr,
                            movifeap,
                            movifeco,
                            movifetr,
                            movifeve,
                            movifopa,
                            moviimp1,
                            moviimp2,
                            moviimp3,
                            movimecb,
                            movinips,
                            movinudo,
                            movinutr,
                            moviserv,
                            movisici,
                            movisifa,
                            movisign,
                            movisipr,
                            movisire,
                            movisivr,
                            movisuba,
                            movisuca,
                            movisusc,
                            movitdsr,
                            moviterc,
                            moviterm,
                            movitica,
                            movitidi,
                            movitido,
                            movitihe,
                            movitimo,
                            movititb,
                            movitoim,
                            moviubg1,
                            moviubg2,
                            moviubg3,
                            moviubg4,
                            moviubg5,
                            moviusua,
                            movivalo,
                            movivatr,
                            movivir1,
                            movivir2,
                            movivir3,
                            movivtir,
                            moviproy,
                            moviclit,
                            moviunid,
                            movidipr,
                            movinaca,
                            movicons,
                            moviitem,
                            moviclcc
            bulk collect
            into            orctbTmp_Ic_Moviprov.mvprancb,
                            orctbTmp_Ic_Moviprov.mvprbanc,
                            orctbTmp_Ic_Moviprov.mvprbatr,
                            orctbTmp_Ic_Moviprov.mvprcaca,
                            orctbTmp_Ic_Moviprov.mvprcate,
                            orctbTmp_Ic_Moviprov.mvprceco,
                            orctbTmp_Ic_Moviprov.mvprcicl,
                            orctbTmp_Ic_Moviprov.mvprcldp,
                            orctbTmp_Ic_Moviprov.mvprconc,
                            orctbTmp_Ic_Moviprov.mvprcuba,
                            orctbTmp_Ic_Moviprov.mvprempr,
                            orctbTmp_Ic_Moviprov.mvprfeap,
                            orctbTmp_Ic_Moviprov.mvprfeco,
                            orctbTmp_Ic_Moviprov.mvprfetr,
                            orctbTmp_Ic_Moviprov.mvprfeve,
                            orctbTmp_Ic_Moviprov.mvprfopa,
                            orctbTmp_Ic_Moviprov.mvprimp1,
                            orctbTmp_Ic_Moviprov.mvprimp2,
                            orctbTmp_Ic_Moviprov.mvprimp3,
                            orctbTmp_Ic_Moviprov.mvprmecb,
                            orctbTmp_Ic_Moviprov.mvprnips,
                            orctbTmp_Ic_Moviprov.mvprnudo,
                            orctbTmp_Ic_Moviprov.mvprnutr,
                            orctbTmp_Ic_Moviprov.mvprserv,
                            orctbTmp_Ic_Moviprov.mvprsici,
                            orctbTmp_Ic_Moviprov.mvprsifa,
                            orctbTmp_Ic_Moviprov.mvprsign,
                            orctbTmp_Ic_Moviprov.mvprsipr,
                            orctbTmp_Ic_Moviprov.mvprsire,
                            orctbTmp_Ic_Moviprov.mvprsivr,
                            orctbTmp_Ic_Moviprov.mvprsuba,
                            orctbTmp_Ic_Moviprov.mvprsuca,
                            orctbTmp_Ic_Moviprov.mvprsusc,
                            orctbTmp_Ic_Moviprov.mvprtdsr,
                            orctbTmp_Ic_Moviprov.mvprterc,
                            orctbTmp_Ic_Moviprov.mvprterm,
                            orctbTmp_Ic_Moviprov.mvprtica,
                            orctbTmp_Ic_Moviprov.mvprtidi,
                            orctbTmp_Ic_Moviprov.mvprtido,
                            orctbTmp_Ic_Moviprov.mvprtihe,
                            orctbTmp_Ic_Moviprov.mvprtimo,
                            orctbTmp_Ic_Moviprov.mvprtitb,
                            orctbTmp_Ic_Moviprov.mvprtoim,
                            orctbTmp_Ic_Moviprov.mvprubg1,
                            orctbTmp_Ic_Moviprov.mvprubg2,
                            orctbTmp_Ic_Moviprov.mvprubg3,
                            orctbTmp_Ic_Moviprov.mvprubg4,
                            orctbTmp_Ic_Moviprov.mvprubg5,
                            orctbTmp_Ic_Moviprov.mvprusua,
                            orctbTmp_Ic_Moviprov.mvprvalo,
                            orctbTmp_Ic_Moviprov.mvprvatr,
                            orctbTmp_Ic_Moviprov.mvprvir1,
                            orctbTmp_Ic_Moviprov.mvprvir2,
                            orctbTmp_Ic_Moviprov.mvprvir3,
                            orctbTmp_Ic_Moviprov.mvprvtir,
                            orctbTmp_Ic_Moviprov.mvprproy,
                            orctbTmp_Ic_Moviprov.mvprclit,
                            orctbTmp_Ic_Moviprov.mvprunid,
                            orctbTmp_Ic_Moviprov.mvprdipr,
                            orctbTmp_Ic_Moviprov.mvprnaca,
                            orctbTmp_Ic_Moviprov.mvprcons,
                            orctbTmp_Ic_Moviprov.mvpritem,
                            orctbTmp_Ic_Moviprov.mvprclcc;
*/
        if(nuCant < inuLimiteObt) then
            oblMasDatos := FALSE;
        end if;

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED OR ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise LOGIN_DENIED;
        when pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;
        when OTHERS then
        	pkErrors.NotifyError
            (
                pkErrors.fsbLastObject  ,
                sqlerrm                 ,
                sbMensajeError
            );
            pkErrors.Pop;
        	raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                sbMensajeError
            );
    END DelProvRetMovements;

    /*
        Propiedad intelectual de Open International Systems. (c).

        Procedimiento :   DelProvMovements
        Descripcion	  :   Elimina hechos economicos de provision.

        Parametros    :
            idtFechaFinal       Fecha final de mes de provision.
            inuTipoDocum        Tipo documento.
            inuTipoMovim        Tipo movimiento.
            inuLimiteObt        Limite de obtencion de registros.
            isbTyPrEx           Tipos de productos a excluir.
            isbTiheProv         Tipo de HE a excluir.

        Retorno       :
            oblMasDatos     Indica si existen mas datos por obtener.

        Autor	    :   Santiago Gomez Rico
        Fecha	    :   28-12-2011 10:57:12

        Historia de Modificaciones
        Fecha	    IDEntrega

        10-05-2012  gduqueAO180610
        Adiciona los siguientes parametros de entrada
        - isbTyPrEx    : Tipos de productos a excluir
        - isbTiheProv  : Tipo de HE a excluir


        28-12-2011  arendonSAO178960
        Creacion.
    */

    PROCEDURE DelProvMovements
    (
        idtFechaFinal   in  ic_movimien.movifeco%type,
        inuTipoDocum    in  ic_movimien.movitido%type,
        inuTipoMovim    in  ic_movimien.movitimo%type,
        isbTyPrEx       in  varchar2                 ,
        isbTiheProv     in  ic_movimien.movitihe%type,
        inuLimiteObt    in  number                   ,
        oblMasDatos     out boolean
    )
    IS

        ------------------------------------------------------------------------
        -- Constantes
        ------------------------------------------------------------------------
    BEGIN

        pkErrors.Push
        (
            'pkBCIc_Movimien.DelProvMovements'
        );

        oblMasDatos := TRUE;

        DELETE  --+ index(ic_movimien IX_IC_MOVIMIEN02)
                ic_movimien
                /*+pkBCIc_Movimien.DelProvMovements*/
        WHERE   movifeco = idtFechaFinal
        AND     movitido = inuTipoDocum
        AND     movitimo = inuTipoMovim
        AND     movitihe = isbTiheProv
        AND     instr(','||isbTyPrEx||',',','||moviserv||',',1,1) <> 0
        AND     rownum < inuLimiteObt + 1;

        if(sql%rowcount < inuLimiteObt) then
            oblMasDatos := FALSE;
        end if;

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED OR ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise LOGIN_DENIED;
        when pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;
        when OTHERS then
        	pkErrors.NotifyError
            (
                pkErrors.fsbLastObject  ,
                sqlerrm                 ,
                sbMensajeError
            );
            pkErrors.Pop;
        	raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                sbMensajeError
            );
    END DelProvMovements;


    /*
        Propiedad intelectual de Open International Systems. (c).

        Procedimiento :   MassiveInsertion
        Descripcion   :   Inserta hechos economicos masivamente.

        Parametros    :
            irctbTmp_Ic_Moviprov        Hechos economicos.

        Autor       :   German Alexis Duque
        Fecha       :   25-08-2012

        Historia de Modificaciones
        Fecha       IDEntrega

        17-07-2013  hlopez.SAO212472
        Se adiciona el atributo Clasificacion Contable del Contrato.

        08-04-2013   sgomez.SAO205719
        Se modifica <Provision LISIM> por impacto en <Hechos Economicos>
        (adicion de atributo <Item>).

        28-08-2012  hlopezSAO188287
        Se modifica para eliminar el uso del campo Tipo de Acta, que no es
        necesario por la creacion de Tipos de movimiento para los Tipos de Actas
        (Tipo de Documeto Actas).

        25-08-2012  gduqueSAO188287
        Creacion.
    */
    PROCEDURE MassiveInsertion
    (
        irctbTmp_Ic_Moviprov    in  IC_BCTmp_Ic_Moviprov.rtyTmp_Ic_Moviprov
    )
    IS
    BEGIN

        pkErrors.Push
        (
            'IC_BCLisimProvRev.MassiveInsertion'
        );

        if( irctbTmp_Ic_Moviprov.mvprnudo.first is null ) then
            pkErrors.Pop;
            return;
        end if;

        forall nuInd in irctbTmp_Ic_Moviprov.mvprnudo.first .. irctbTmp_Ic_Moviprov.mvprnudo.last
            INSERT INTO tmp_ic_moviprov
            (
                mvprancb,
                mvprbanc,
                mvprbatr,
                mvprcaca,
                mvprcate,
                mvprceco,
                mvprcicl,
                mvprcldp,
                mvprconc,
                mvprcons,
                mvprcuba,
                mvprempr,
                mvprfeap,
                mvprfeco,
                mvprfetr,
                mvprfeve,
                mvprfopa,
                mvprimp1,
                mvprimp2,
                mvprimp3,
                mvprmecb,
                mvprnips,
                mvprnudo,
                mvprnutr,
                mvprserv,
                mvprsici,
                mvprsifa,
                mvprsign,
                mvprsipr,
                mvprsire,
                mvprsivr,
                mvprsuba,
                mvprsuca,
                mvprsusc,
                mvprtdsr,
                mvprterc,
                mvprterm,
                mvprtica,
                mvprtidi,
                mvprtido,
                mvprtihe,
                mvprtimo,
                mvprtitb,
                mvprtoim,
                mvprubg1,
                mvprubg2,
                mvprubg3,
                mvprubg4,
                mvprubg5,
                mvprusua,
                mvprvalo,
                mvprvatr,
                mvprvir1,
                mvprvir2,
                mvprvir3,
                mvprvtir,
                mvprproy,
                mvprclit,
                mvprunid,
                mvprdipr,
                mvpritem,
                mvprclcc
            )
            VALUES
            (
                irctbTmp_Ic_Moviprov.mvprancb(nuInd),
                irctbTmp_Ic_Moviprov.mvprbanc(nuInd),
                irctbTmp_Ic_Moviprov.mvprbatr(nuInd),
                irctbTmp_Ic_Moviprov.mvprcaca(nuInd),
                irctbTmp_Ic_Moviprov.mvprcate(nuInd),
                irctbTmp_Ic_Moviprov.mvprceco(nuInd),
                irctbTmp_Ic_Moviprov.mvprcicl(nuInd),
                irctbTmp_Ic_Moviprov.mvprcldp(nuInd),
                irctbTmp_Ic_Moviprov.mvprconc(nuInd),
                irctbTmp_Ic_Moviprov.mvprproy(nuInd),
                irctbTmp_Ic_Moviprov.mvprcuba(nuInd),
                irctbTmp_Ic_Moviprov.mvprempr(nuInd),
                irctbTmp_Ic_Moviprov.mvprfeap(nuInd),
                irctbTmp_Ic_Moviprov.mvprfeco(nuInd),
                irctbTmp_Ic_Moviprov.mvprfetr(nuInd),
                irctbTmp_Ic_Moviprov.mvprfeve(nuInd),
                irctbTmp_Ic_Moviprov.mvprfopa(nuInd),
                irctbTmp_Ic_Moviprov.mvprimp1(nuInd),
                irctbTmp_Ic_Moviprov.mvprimp2(nuInd),
                irctbTmp_Ic_Moviprov.mvprimp3(nuInd),
                irctbTmp_Ic_Moviprov.mvprmecb(nuInd),
                irctbTmp_Ic_Moviprov.mvprnips(nuInd),
                irctbTmp_Ic_Moviprov.mvprnudo(nuInd),
                irctbTmp_Ic_Moviprov.mvprnutr(nuInd),
                irctbTmp_Ic_Moviprov.mvprserv(nuInd),
                irctbTmp_Ic_Moviprov.mvprsici(nuInd),
                irctbTmp_Ic_Moviprov.mvprsifa(nuInd),
                irctbTmp_Ic_Moviprov.mvprsign(nuInd),
                irctbTmp_Ic_Moviprov.mvprsipr(nuInd),
                irctbTmp_Ic_Moviprov.mvprsire(nuInd),
                irctbTmp_Ic_Moviprov.mvprsivr(nuInd),
                irctbTmp_Ic_Moviprov.mvprsuba(nuInd),
                irctbTmp_Ic_Moviprov.mvprsuca(nuInd),
                irctbTmp_Ic_Moviprov.mvprsusc(nuInd),
                irctbTmp_Ic_Moviprov.mvprtdsr(nuInd),
                irctbTmp_Ic_Moviprov.mvprterc(nuInd),
                irctbTmp_Ic_Moviprov.mvprterm(nuInd),
                irctbTmp_Ic_Moviprov.mvprtica(nuInd),
                irctbTmp_Ic_Moviprov.mvprtidi(nuInd),
                irctbTmp_Ic_Moviprov.mvprtido(nuInd),
                irctbTmp_Ic_Moviprov.mvprtihe(nuInd),
                irctbTmp_Ic_Moviprov.mvprtimo(nuInd),
                irctbTmp_Ic_Moviprov.mvprtitb(nuInd),
                irctbTmp_Ic_Moviprov.mvprtoim(nuInd),
                irctbTmp_Ic_Moviprov.mvprubg1(nuInd),
                irctbTmp_Ic_Moviprov.mvprubg2(nuInd),
                irctbTmp_Ic_Moviprov.mvprubg3(nuInd),
                irctbTmp_Ic_Moviprov.mvprubg4(nuInd),
                irctbTmp_Ic_Moviprov.mvprubg5(nuInd),
                irctbTmp_Ic_Moviprov.mvprusua(nuInd),
                irctbTmp_Ic_Moviprov.mvprvalo(nuInd),
                irctbTmp_Ic_Moviprov.mvprvatr(nuInd),
                irctbTmp_Ic_Moviprov.mvprvir1(nuInd),
                irctbTmp_Ic_Moviprov.mvprvir2(nuInd),
                irctbTmp_Ic_Moviprov.mvprvir3(nuInd),
                irctbTmp_Ic_Moviprov.mvprvtir(nuInd),
                NULL,
                irctbTmp_Ic_Moviprov.mvprclit(nuInd),
                irctbTmp_Ic_Moviprov.mvprunid(nuInd),
                irctbTmp_Ic_Moviprov.mvprdipr(nuInd),
                irctbTmp_Ic_Moviprov.mvpritem(nuInd),
                irctbTmp_Ic_Moviprov.mvprclcc(nuInd)
            );

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.Pop;
            raise LOGIN_DENIED;
        when pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;
        when OTHERS then
        	pkErrors.NotifyError
            (
                pkErrors.fsbLastObject             ,
                sqlerrm                            ,
                sbMensajeError
            );
        	pkErrors.Pop;
        	raise_application_error
            (
                pkConstante.nuERROR_LEVEL2         ,
                sbMensajeError
            );
    END MassiveInsertion;

    /***************************************************************************
        Propiedad intelectual de Open International Systems. (c).

        Procedure	        :   GetProgrammingProcess
        Descripcion	        :   Obtiene los procesos a programar

        Parametros          :   Descripcion

        Retorno             :   Descripcion
            otbConfig           Tabla con la configuracion de Comprobantes
                                Generados


        Autor               :   German Alexis Duque
        Fecha               :   10-08-2012

        Historia de Modificaciones
        Fecha               ID Entrega
        25-08-2012          gduqueSAO189287
        Creacion
    ***************************************************************************/
    PROCEDURE GetConfigInAccounts
    (
         inuTido        in ic_tipodoco.tidccodi%type,
         inuTimo        in ic_tipomovi.timocodi%type,
         nuCompany      in sistema.sistcodi%type,
         idtDateProcess in ic_encoreco.ecrcfech%type,
         otbConfig      out nocopy tytbConfig
    )
    IS

        CURSOR cuConfig
        (
         inuTido        in ic_tipodoco.tidccodi%type,
         inuTimo        in ic_tipomovi.timocodi%type,
         nuCompany      in sistema.sistcodi%type,
         idtDateProcess in ic_encoreco.ecrcfech%type
        )
            IS
        SELECT  /*+
                ORDERED
                use_nl ( ic_confreco, ic_crcoreco )
                use_nl ( ic_encoreco, ic_compgene )
                index ( ic_crcoreco, IX_IC_CRCORECO01 )
                index ( ic_confreco, IX_IC_CONFRECO01 )
                index ( ic_encoreco, IX_IC_ENCORECO01 )
                index ( ic_compgene, PK_IC_COMPGENE )
                */
                corccons,corccoco,ccrccamp,ccrcvalo
        FROM    ic_confreco,ic_crcoreco, ic_encoreco,ic_compgene
        WHERE   corctido = inuTido
        AND     corctimo = inuTimo
        AND     ccrccorc (+) = corccons
        AND     ecrccoco = corccoco
        AND     cogecons = ecrccoge
        AND     cogesist = nuCompany
        AND     ecrcfech = idtDateProcess;


    BEGIN
        pkErrors.Push( 'IC_BCFinancialConsole.GetConfigInAccounts' );

            if (cuConfig%isopen) then
                close cuConfig;
            END if;

            open cuConfig(inuTido,
                          inuTimo,
                          nuCompany,
                          idtDateProcess
                         );

            fetch cuConfig
            bulk collect INTO otbConfig;

            close cuConfig;
            pkerrors.Pop;

        pkErrors.Pop;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
        	pkErrors.Pop;
        	 if( cuConfig%isopen ) then
                close cuConfig;
             end if;
        	RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
        	pkErrors.Pop;
        	 if( cuConfig%isopen ) then
                close cuConfig;
             end if;
        	RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
        	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbMensajeError );
        	pkErrors.Pop;
        	 if( cuConfig%isopen ) then
                close cuConfig;
             end if;
        	raise_application_error( pkConstante.nuERROR_LEVEL2, sbMensajeError );
    END GetConfigInAccounts;

END IC_BCLisimProvRev;
/
GRANT EXECUTE on IC_BCLISIMPROVREV to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on IC_BCLISIMPROVREV to REXEOPEN;
GRANT EXECUTE on IC_BCLISIMPROVREV to RSELSYS;
/
