CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BCPORTAFOLIO is
  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Package : <LD_BOPortafolio>
  Descripcion : Manejo de articulos para FNB.

  Autor : Jorge Valiente.
  Fecha : 25-10-2012 SAO156917

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
  -----------  -------------------    -------------------------------------
  18-09-2014    KCienfuegos.NC2256    Se modifica metodo <<FnuGetMailNameSupplier>>
  30-07-2014   KCienfuegos.NC329      Se crea el método <<FblSupplierSubline>>
  10-09-2013 vhurtadoSAO214992        Se modifica la setencia de FtrfPromissory
                                  para elimina dos full sobre GE_GEOGRA_LOCATION
  ***************************************************************/

  csbVERSION CONSTANT VARCHAR2(10) := 'SAO227806';

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbVersion
    Descripcion    : Retorna el SAO con que se realizo la ultima entrega

    Autor          : Jorge Valiente
    Fecha          : 18/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FsbVersion RETURN varchar2;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FtbPropertArticle
    Descripcion    : Retorna los datos existentes de la entidad
                     Propiedad por Articulo

    Autor          : Jorge Valiente
    Fecha          : 25/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FtrcPropertArticle(nuArticleId  in ld_article.article_id%type,
                              nuPropertyId ld_property.property_id%type)
    RETURN ld_propert_by_article.propert_by_article_id%type;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProSuppliModificaDate
    Descripcion    : Retorna la fecha de permiso de vigencia para
                     que el proveedor pueda subir o realizar
                     modificaciones a su articulo con un archivo plano.

    Autor          : Jorge Valiente
    Fecha          : 25/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  Procedure ProSuppliModificaDate(nuSupplierId  in Ld_SUPPLI_MODIFICA_DATE.Supplier_Id%type,
                                  dtInitialDate out Ld_SUPPLI_MODIFICA_DATE.Initial_Date%type,
                                  dtFinalDate   out Ld_SUPPLI_MODIFICA_DATE.Final_Date%type);

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProPriceList
    Descripcion    : Retorna el codigo de la lista de
                     precio perteneciente al proveedor que este
                     activa y que sea la mas reciente.

    Autor          : Jorge Valiente
    Fecha          : 25/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  Procedure ProPriceList(nuSupplierId  in ld_Price_List.Supplier_Id%type,
                         nuPriceListId out ld_Price_List.Price_List_Id%type);

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuGeograLocation
    Descripcion    : Retorna el codigo de la ubicacion
                     geografica mediante el nombre
                     de la ubicacion geografica.

    Autor          : Jorge Valiente
    Fecha          : 25/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FnuGeograLocation(sbDescription in ge_geogra_location.description%type)
    RETURN ge_geogra_location.geograp_location_id%type;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuPriceListDeta
    Descripcion    : Retorna el codigo de la lista de precios
                     en detalle para actualizar el precio o insertar
                     el precio del articulo con sus respectivos datos.

    Autor          : Jorge Valiente
    Fecha          : 26/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FnuPriceListDeta(nuPriceListId        Ld_Price_List_Deta.Price_List_Id%type,
                            nuArticleId          Ld_Price_List_Deta.Article_Id%type,
                            nuGeGeograLocationId Ld_Price_List_Deta.Geograp_Location_Id%type,
                            nuSaleChanelId       Ld_Price_List_Deta.Sale_Chanel_Id%type)
    RETURN Ld_Price_List_Deta.price_list_deta_id%type;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuGeOrganizatArea
    Descripcion    : Retorna el codigo del canal de venta.

    Autor          : Jorge Valiente
    Fecha          : 26/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FnuGeOrganizatArea(sbDisplayDescription ge_reception_type.description%type)
    RETURN ge_reception_type.reception_type_id%type;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuArticle
    Descripcion    : Retorna el codigo del articulo por medio de
                     la refencia del articulo y el codigo del proveedor .

    Autor          : Jorge Valiente
    Fecha          : 26/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FnuArticle(sbReference  Ld_Article.Reference%type,
                      nuSupplierId Ld_Article.Supplier_Id%type)
    RETURN Ld_Article.Article_Id%type;

   /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblArticlePriceList
    Descripcion    : Retorna true, si el articulo, esta aprobado,
                     activo y con control de precios
                     para ser configurado en una lista de precios,
                     de lo contrario retorna false .

    Autor          : Erika A. Montenegro G.
    Fecha          : 12/08/2013

    Parametros       Descripcion
    ============     ===================
    nuArticleId       id del articulo

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
   FUNCTION FblArticlePriceList(inuArticleId  Ld_Article.article_id%type)
    RETURN boolean;


  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuSubLine
    Descripcion    : Retorna si existe o no la sublinea a la
                     que se asociara el articulo.

    Autor          : Jorge Valiente
    Fecha          : 29/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblSubLine(nusublineid Ld_subline.subline_id%type) RETURN Boolean;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblBrand
    Descripcion    : Retorna si existe o no la marca a la
                     que se asociara el articulo.

    Autor          : Jorge Valiente
    Fecha          : 29/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblBrand(nuBrandId Ld_brand.Brand_Id%type) RETURN Boolean;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblServicio
    Descripcion    : Retorna si existe o no la empresa que
                     financiaria el articulo.

    Autor          : Jorge Valiente
    Fecha          : 29/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblServicio(nuServcodi Servicio.Servcodi%type) RETURN Boolean;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblConcepto
    Descripcion    : Retorna si existe o no el concepto
                     asociado al articulo.

    Autor          : Jorge Valiente
    Fecha          : 29/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblConcepto(nuConccodi Concepto.Conccodi%type) RETURN Boolean;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblSegmenSupplier
    Descripcion    : Retorna si existe o no la sublinea en
                     la entidad LD_SEGMEN_SUPPLIER.

    Autor          : Jorge Valiente
    Fecha          : 30/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblSegmenSupplier(nuSubLineId LD_SEGMEN_SUPPLIER.SUBLINE_ID%type)
    RETURN Boolean;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : FblSupplierSubline
    Descripcion    : Valida si la sublínea está asociada al proveedor

    Autor          : Katherine Cienfuegos
    Fecha          : 30/07/2014

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblSupplierSubline(inuSubLineId in LD_SEGMEN_SUPPLIER.SUBLINE_ID%type,
							  inuSupplierId in LD_SEGMEN_SUPPLIER.SUPPLIER_ID%type)
    RETURN Boolean;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuCommision
    Descripcion    : Retorna el codigo de la comision.

    Autor          : Jorge Valiente
    Fecha          : 26/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
 FUNCTION FnuCommision( nuLine                  ld_commission.Line_Id%type,
                        nuSublinea              ld_commission.subline_id%type,
                        nuArticleId             ld_commission.article_id%type,
                        nuSaleChanelId          ld_commission.Sale_Chanel_Id%type,
                        nuGeGeograLocationId    ld_commission.geograp_location_id%type,
                        nuContratorId           ld_commission.contrator_id%type,
                        nuSupplier              ld_commission.supplier_id%type
                        )
    RETURN ld_commission.commission_id%type;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FtrfPromissory
    Descripcion    : Retorna los datos del deudor o codeudor.

    Autor          : Jorge Valiente
    Fecha          : 01/11/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FtrfPromissory(nuPackageId in ld_promissory.package_id%type,
                          --sbPromissoryType in ld_promissory.promissory_type%type)
                          sbPromissoryTypeDebtor   in ld_promissory.promissory_type%type,
                          sbPromissoryTypeCosigner in ld_promissory.promissory_type%type)
    RETURN constants.tyRefCursor;
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FsbPropertArticle
    Descripcion    : Retorna las propiedades del articulo
                     en una cadena.

    Autor          : Jorge Valiente
    Fecha          : 06/11/2012

    Parametros       Descripcion
    ============     ===================
    nuArticleId      Codigo del articulo a consultar

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FsbPropertArticle(nuArticleId ld_propert_by_article.article_id%type)
    RETURN varchar2;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuAmountPrintOuts
    Descripcion    : Actualiza la cantidad de impresiones
                     realizadas a una lsta de precios.

    Autor          : Jorge Valiente
    Fecha          : 07/11/2012

    Parametros       Descripcion
    ============     ===================
    nuArticleId      Codigo del articulo a consultar

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FnuAmountPrintOuts(nuPriceListId Ld_Price_List.Price_List_Id%type)
    RETURN Ld_Price_List.Amount_Printouts%type;
/*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuAmountArt
    Descripcion    : Servicio que valida que a partir de una orden  busca todos los articulos de todos
                     los proveedores y tengan estado PA(Pendiente de aprobación) si trae (0) significa
                     que el estado de la orden ya puede ser cambiada a A(Aprobada), ya que todos los articulos
                     de todos los proveedores se encuentra como no PA(Pendiente de aprobación)

    Autor          : AAcuna
    Fecha          : 23/05/2013

    Parametros       Descripcion
    ============     ===================
    inuRaiseError    Número de error
    inuOrder         Número de orden

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    23/05/2013       AAcuna                Creación
  ******************************************************************/

  FUNCTION FnuAmountArt(inuOrder      or_order.order_id%type,
                        inuRaiseError in number default 1) return number;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : bocopylist
  Descripcion    : Consultar la lista a partir del c?digo de lista que entra y crear
                   una lista la descripci?n y fecha inicial y final de vigencia

  Autor          : Evens Herard
  Fecha          : 30/10/2012

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE bocopylist(inuPrice_List_Id in ld_Price_List.price_list_id%type,
                       isbDescription   in Ld_Price_List.Description%type,
                       idtInitial_date  in Ld_Price_List.Initial_Date%type,
                       idtFinal_date    in Ld_Price_List.Final_Date%type,
                       inuSupplier_id   in Ld_Price_List.Price_List_Id%type);
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FtrfArticle
    Descripcion    : Retorna los articulos del pagare.

    Autor          : Jorge Valiente
    Fecha          : 01/11/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FtrfArticle(nuPackageId in ld_promissory.package_id%type)
    RETURN constants.tyRefCursor;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblLine
    Descripcion    : Retorna si existe o no la linea a la
                     que se asociara el articulo.

    Autor          : Jorge Valiente
    Fecha          : 29/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblLine(nulineid Ld_line.line_id%type) RETURN Boolean;

  FUNCTION fnuGetDupliDate(identificador   in LD_EXTRA_QUOTA.EXTRA_QUOTA_ID%type,
                           proveedor       in LD_EXTRA_QUOTA.supplier_id%type,
                           categoria       in LD_EXTRA_QUOTA.category_id%type,
                           subcatega       in LD_EXTRA_QUOTA.subcategory_id%type,
                           ubica_geo       in LD_EXTRA_QUOTA.geograp_location_id%type,
                           canal_ven       in LD_EXTRA_QUOTA.sale_chanel_id%type,
                           linea           in LD_EXTRA_QUOTA.line_id%type,
                           sublinea        in LD_EXTRA_QUOTA.subline_id%type,
                           fecha_ini       in LD_EXTRA_QUOTA.Initial_Date%type,
                           fecha_fin       in LD_EXTRA_QUOTA.Final_Date%type)
    RETURN NUMBER;
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuArticleInPriceList
    Descripcion    : Indica si un articulo con una determinada ubicacion geografica
                     se encuentra en otra lista de precios.

    Autor          : Alex Valencia
    Fecha          : 19/03/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/


  FUNCTION FnuArticleInPriceList
           (
                     nuArticleId           IN ld_price_list_deta.article_id%TYPE,
                     nuGeoLocatId          IN ld_price_list_deta.geograp_location_id%TYPE,
                     inuSupplier           IN ld_price_list.supplier_id%type,
                     inuSalesChannel       IN ld_price_list_deta.sale_chanel_id%type,
                     inuInitialDate        IN ld_price_list.initial_date%type,
                     inuFinalDate          IN ld_price_list.final_date%type,
                     inuPriceListId        in ld_price_list.price_list_id%type
           )
   RETURN PLS_INTEGER;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FsbgetApprove_Sales_OrderRowid
    Descripcion    : Marca como aprobada una orden de venta pendiente
                     por aprobaacion
    Autor          : jonathan alberto consuegra lara
    Fecha          : 19/03/2013

    Parametros                Descripcion
    ============              ===================
    inuApprove_Sales_Order_Id identificador unico de registro


    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    19/03/2013       jconsuegra.SAO156917  Creacion
  ******************************************************************/
  Function FsbgetApprove_Sales_OrderRowid(inuApprove_Sales_Order_Id in LD_approve_sales_order.Approve_Sales_Order_Id%type,
                                          inuRaiseError             in number default 1)
    return varchar2;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnugetApprove_Sales_OrderId
    Descripcion    : Obtiene el ID de un registro de la tabla
                     approve_sales_order

    Autor          : jonathan alberto consuegra lara
    Fecha          : 19/03/2013

    Parametros       Descripcion
    ============     ===================
    inuorder         identificador de la orden
    inuRaiseError    controlador de error

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    19/03/2013       jconsuegra.SAO156917  Creacion
  ******************************************************************/
  Function FnugetApprove_Sales_OrderId(inuorder      in or_order.order_id%type,
                                       inuRaiseError in number default 1)
    return LD_approve_sales_order.Approve_Sales_Order_Id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad :         frfGetArticleOrder
  Descripcion    : Retorna el valor de las pólizas que fueron adquiridadas despues de la edad maxima para
                   coger un seguro
  Autor          : AAcuna
  Fecha          : 22/05/2013 SAO

  Parametros         Descripción
  ============   ===================
  inuorden:      Número de orden

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  FUNCTION frfGetArticleOrder(inuorden in or_order.order_id%type)

   RETURN constants.tyrefcursor;



  FUNCTION FnuGetSupplierPerson
           RETURN number;

 /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad :         FnuGetMailNameSupplier
  Descripcion    : Retorna el Nombre y Mail de la persona conectada
  Autor          : Evelio Sanjuanelo
  Fecha          : 18/Jun/2013

  Parametros           Descripción
  ============         ===================
  inuorden:            Número de orden

  Historia de Modificaciones
  Fecha               Autor            Modificación
  ==============      ============     ====================
  18-09-2014         KCienfuegos.NC2256   Se modifica ya que no estaba enviando la informacion correcta
                                          del contratista conectado.
  ******************************************************************/
PROCEDURE  FnuGetMailNameSupplier
  (
      osMail out ge_contratista.correo_electronico%TYPE,
      osName out ge_contratista.nombre_contratista%TYPE
   );

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fblSegSupplierbyLine
    Descripcion    : Retorna si existe configuración para la línea y el
                     proveedor dado en la entidad LD_SEGMEN_SUPPLIER.

    Autor          : Jorge Alejandro Carmona Duque
    Fecha          : 15/10/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha           Autor                   Modificacion
    =========       =========               ====================
    15/10/2013      JCarmona.SAO219877      Creación.
    ******************************************************************/
    FUNCTION fblSegSupplierbyLine
    (
        nuLineId        LD_SEGMEN_SUPPLIER.LINE_ID%type,
        nuSupplierId    LD_SEGMEN_SUPPLIER.supplier_id%type
    )
    RETURN Boolean;

end LD_BCPORTAFOLIO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BCPORTAFOLIO IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Package : <LD_BOPortafolio>
  Descripcion : Manejo de articulos para FNB.

  Autor : Jorge Valiente.
  Fecha : 18-10-2012 SAO156917

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
  -----------  -------------------    -------------------------------------
  17-10-2014    KCienfuegos.NC3091     Se modifica método <<FnuGetSupplierPerson>>
  18-Ene-2014   AEcheverrySAO230039    se modifica <<frfGetArticleOrder>>
  17-12-2013    LDiuza.SAO227806       Se modifica el metodo <<FtrfPromissory>>
  12-12-2013    sgomez.SAO227111       Se modifica consulta para obtención de
                                      información de impresión de pagaré.
  04-09-2013   jaricapa.SAO214357    Creación.
  ******************************************************************/

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbVersion
    Descripcion    : Retorna el SAO con que se realizo la ultima entrega

    Autor          : Jorge Valiente
    Fecha          : 18/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FsbVersion RETURN varchar2 IS
  BEGIN
    pkErrors.Push('Ld_BcSecureManagement.FsbVersion');
    pkErrors.Pop;
    RETURN(csbVersion);
  END fsbVersion;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FtbPropertArticle
    Descripcion    : Retorna los datos existentes de la entidad
                     Propiedad por Articulo

    Autor          : Jorge Valiente
    Fecha          : 25/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FtrcPropertArticle(nuArticleId  in ld_article.article_id%type,
                              nuPropertyId ld_property.property_id%type)
    RETURN ld_propert_by_article.propert_by_article_id%type IS

    nuPropertArticleId ld_propert_by_article.propert_by_article_id%type;

    cursor cuProperyArticle is
      SELECT propert_by_article_id
        FROM Ld_Propert_By_Article
       WHERE article_id = nuArticleId
         AND property_id = nuPropertyId
       Group by propert_by_article_id;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FtrcPropertArticle', 10);

    OPEN cuProperyArticle;
    fetch cuProperyArticle
      into nuPropertArticleId;
    if cuProperyArticle%notfound then
      nuPropertArticleId := null;
    end if;
    close cuProperyArticle;

    ut_trace.trace('Fin LD_BCPortafolio.FtrcPropertArticle', 10);

    RETURN nuPropertArticleId;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuPropertArticleId := null;
      RETURN nuPropertArticleId;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      nuPropertArticleId := null;
      RETURN nuPropertArticleId;
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;

  END FtrcPropertArticle;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProSuppliModificaDate
    Descripcion    : Retorna la fecha de permiso de vigencia para
                     que el proveedor pueda subir o realizar
                     modificaciones a su articulo con un archivo plano.

    Autor          : Jorge Valiente
    Fecha          : 25/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  Procedure ProSuppliModificaDate(nuSupplierId  in Ld_SUPPLI_MODIFICA_DATE.Supplier_Id%type,
                                  dtInitialDate out Ld_SUPPLI_MODIFICA_DATE.Initial_Date%type,
                                  dtFinalDate   out Ld_SUPPLI_MODIFICA_DATE.Final_Date%type) IS

    cursor cuSuppliModificaDate is
      SELECT Initial_Date, Final_Date
        FROM Ld_SUPPLI_MODIFICA_DATE
       WHERE Supplier_Id = nuSupplierId;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.ProSuppliModificaDate', 10);

    open cuSuppliModificaDate;
    fetch cuSuppliModificaDate
      into dtInitialDate, dtFinalDate;
    if cuSuppliModificaDate%notfound then
      dtInitialDate := null;
      dtFinalDate   := null;
    end if;
    close cuSuppliModificaDate;

    ut_trace.trace('Fin LD_BCPortafolio.ProSuppliModificaDate', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      dtInitialDate := null;
      dtFinalDate   := null;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      dtInitialDate := null;
      dtFinalDate   := null;
      RAISE ex.CONTROLLED_ERROR;

  END ProSuppliModificaDate;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProPriceList
    Descripcion    : Retorna el codigo de la lista de
                     precio perteneciente al proveedor que este
                     activa y que sea la mas reciente.

    Autor          : Jorge Valiente
    Fecha          : 25/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  Procedure ProPriceList(nuSupplierId  in ld_Price_List.Supplier_Id%type,
                         nuPriceListId out ld_Price_List.Price_List_Id%type) IS

    cursor cuPriceList is
      SELECT MAX(Price_List_Id) nuPrice_List_Id,
             MAX(final_date) dtfinal_date
        FROM ld_Price_List
       WHERE supplier_id = nuSupplierId
         AND approved = 'Y';

    dtfinaldate ld_Price_List.Final_Date%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.ProPriceList', 10);

    open cuPriceList;
    fetch cuPriceList
      into nuPriceListId, dtfinaldate;
    if cuPriceList%notfound then
      nuPriceListId := null;
      dtFinalDate   := null;
    end if;
    close cuPriceList;

    ut_trace.trace('Fin LD_BCPortafolio.ProPriceList', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuPriceListId := null;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuPriceListId := null;
      RAISE ex.CONTROLLED_ERROR;

  END ProPriceList;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuGeograLocation
    Descripcion    : Retorna el codigo de la ubicacion
                     geografica mediante el nombre
                     de la ubicacion geografica.

    Autor          : Jorge Valiente
    Fecha          : 25/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FnuGeograLocation(sbDescription in ge_geogra_location.description%type)
    RETURN ge_geogra_location.geograp_location_id%type IS

    cursor cuGeograLocation is
      SELECT geograp_location_id
        FROM ge_geogra_location
       WHERE upper(description) = upper(sbDescription);

    nuGeograpLocationId ge_geogra_location.geograp_location_id%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FnuGeograLocation', 10);

    open cuGeograLocation;
    fetch cuGeograLocation
      into nuGeograpLocationId;
    if cuGeograLocation%notfound then
      nuGeograpLocationId := null;
    end if;
    close cuGeograLocation;

    ut_trace.trace('Fin LD_BCPortafolio.FnuGeograLocation', 10);

    RETURN nuGeograpLocationId;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuGeograpLocationId := null;
      RETURN nuGeograpLocationId;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuGeograpLocationId := null;
      RETURN nuGeograpLocationId;
      RAISE ex.CONTROLLED_ERROR;

  END FnuGeograLocation;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuPriceListDeta
    Descripcion    : Retorna el codigo de la lista de precios
                     en detalle para actualizar el precio o insertar
                     el precio del articulo con sus respectivos datos.

    Autor          : Jorge Valiente
    Fecha          : 26/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    15-08-2013     emontenegro       Se modifica la consulta, para que tenga en cuenta
                                     el detalle de la lista, cuando el canal de venta
                                     y la ubicación sean null, ya que estos parametros
                                     pueden venir null.
  ******************************************************************/
  FUNCTION FnuPriceListDeta(nuPriceListId        Ld_Price_List_Deta.Price_List_Id%type,
                            nuArticleId          Ld_Price_List_Deta.Article_Id%type,
                            nuGeGeograLocationId Ld_Price_List_Deta.Geograp_Location_Id%type,
                            nuSaleChanelId       Ld_Price_List_Deta.Sale_Chanel_Id%type)
    RETURN Ld_Price_List_Deta.price_list_deta_id%type IS

    cursor cuPriceListDeta is
      SELECT price_list_deta_id
        FROM Ld_Price_List_Deta
       WHERE price_list_id = nuPriceListId
         AND article_id = nuArticleId
         AND nvl(geograp_location_id,1.1) = nvl(nuGeGeograLocationId,1.1)
         AND nvl(sale_chanel_id,1.1) = nvl(nuSaleChanelId,1.1);

    nuPriceListDetaId Ld_Price_List_Deta.Price_List_Deta_Id%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FnuPriceListDeta', 10);

    open cuPriceListDeta;
    fetch cuPriceListDeta
      into nuPriceListDetaId;
    if cuPriceListDeta%notfound then
      nuPriceListDetaId := null;
    end if;
    close cuPriceListDeta;

    ut_trace.trace('Fin LD_BCPortafolio.FnuPriceListDeta', 10);

    RETURN nuPriceListDetaId;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuPriceListDetaId := null;
      RETURN nuPriceListDetaId;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuPriceListDetaId := null;
      RETURN nuPriceListDetaId;
      RAISE ex.CONTROLLED_ERROR;

  END FnuPriceListDeta;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuGeOrganizatArea
    Descripcion    : Retorna el codigo del canal de venta.

    Autor          : Jorge Valiente
    Fecha          : 26/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FnuGeOrganizatArea(sbDisplayDescription ge_reception_type.description%type)
    RETURN ge_reception_type.reception_type_id%type IS

    cursor cuGeOrganizatArea is
      SELECT g.reception_type_id
        FROM ge_reception_type g
       WHERE upper(g.description) = upper(sbDisplayDescription)
       AND REGEXP_INSTR(dald_parameter.fsbGetValue_Chain('SALES_CHANNEL_FNB'),
                    '(\W|^)' || reception_type_id || '(\W|$)') > 0;

    nuOrganizatAreaId ge_reception_type.reception_type_id%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FnuGeOrganizatArea', 10);

    open cuGeOrganizatArea;
    fetch cuGeOrganizatArea
      into nuOrganizatAreaId;
    if cuGeOrganizatArea%notfound then
      nuOrganizatAreaId := null;
    end if;
    close cuGeOrganizatArea;

    ut_trace.trace('Fin LD_BCPortafolio.FnuGeOrganizatArea', 10);

    RETURN nuOrganizatAreaId;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuOrganizatAreaId := null;
      RETURN nuOrganizatAreaId;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuOrganizatAreaId := null;
      RETURN nuOrganizatAreaId;
      RAISE ex.CONTROLLED_ERROR;

  END FnuGeOrganizatArea;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuArticle
    Descripcion    : Retorna el codigo del articulo por medio de
                     la refencia del articulo y el codigo del proveedor .

    Autor          : Jorge Valiente
    Fecha          : 26/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FnuArticle(sbReference  Ld_Article.Reference%type,
                      nuSupplierId Ld_Article.Supplier_Id%type)
    RETURN Ld_Article.Article_Id%type IS

    cursor cuArticle is
      SELECT Article_Id
        FROM Ld_Article
       WHERE Reference = sbReference
         and Supplier_Id = nuSupplierId;

    nuArticleId Ld_Article.Article_Id%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FnuArticle', 10);

    open cuArticle;
    fetch cuArticle
      into nuArticleId;
    if cuArticle%notfound then
      nuArticleId := null;
    end if;
    close cuArticle;

    ut_trace.trace('Fin LD_BCPortafolio.FnuArticle', 10);

    RETURN nuArticleId;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuArticleId := null;
      RETURN nuArticleId;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuArticleId := null;
      RETURN nuArticleId;
      RAISE ex.CONTROLLED_ERROR;

  END FnuArticle;

   /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblArticlePriceList
    Descripcion    : Retorna true, si el articulo, esta aprobado,
                     activo y con control de precios
                     para ser configurado en una lista de precios,
                     de lo contrario retorna false .

    Autor          : Erika A. Montenegro G.
    Fecha          : 12/08/2013

    Parametros       Descripcion
    ============     ===================
    nuArticleId       id del articulo
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblArticlePriceList(inuArticleId  Ld_Article.article_id%type)

    RETURN boolean IS

    cursor cuArticle is
      SELECT Article_Id
        FROM Ld_Article
       WHERE article_id = inuArticleId
         AND active = ld_boconstans.csbYesFlag
         AND approved = ld_boconstans.csbYesFlag
         AND price_control = ld_boconstans.csbYesFlag;

    nuArticleId Ld_Article.Article_Id%type;
    blReturn  Boolean;
  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FblArticlePriceList', 10);

    open cuArticle;
    fetch cuArticle
      into nuArticleId;
    if cuArticle%found then
      blReturn :=  true;
    else
       blReturn :=  false;
    end if;
    close cuArticle;

    ut_trace.trace('Fin LD_BCPortafolio.FblArticlePriceList', 10);

    RETURN blReturn;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RETURN false;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RETURN false;
      RAISE ex.CONTROLLED_ERROR;

  END FblArticlePriceList;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblSubLine
    Descripcion    : Retorna si existe o no la sublinea a la
                     que se asociara el articulo.

    Autor          : Jorge Valiente
    Fecha          : 29/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblSubLine(nusublineid Ld_subline.subline_id%type) RETURN Boolean IS

    cursor cuSubline is
      select subline_id
        from ld_subline
       where subline_id = nusublineid
         and approved = 'Y';

    nuReturn  Boolean;
    nuSubline Ld_subline.subline_id%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FblSubLine', 10);

    open cuSubline;
    fetch cuSubline
      into nuSubline;
    if cuSubline%found then
      nuReturn := true;
    else
      nuReturn := false;
    end if;
    close cuSubline;

    ut_trace.trace('Fin LD_BCPortafolio.FblSubLine', 10);

    RETURN nuReturn;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;

  END FblSubLine;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblBrand
    Descripcion    : Retorna si existe o no la marca a la
                     que se asociara el articulo.

    Autor          : Jorge Valiente
    Fecha          : 29/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblBrand(nuBrandId Ld_brand.Brand_Id%type) RETURN Boolean IS

    cursor cuBrand is
      select Brand_Id
        from Ld_brand
       where Brand_Id = nuBrandId
         and Approved = 'Y';

    nuReturn Boolean;
    nuBrand  Ld_brand.Brand_Id%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FblBrand', 10);

    open cuBrand;
    fetch cuBrand
      into nuBrand;
    if cuBrand%found then
      nuReturn := true;
    else
      nuReturn := false;
    end if;
    close cuBrand;

    ut_trace.trace('Fin LD_BCPortafolio.FblBrand', 10);

    RETURN nuReturn;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;

  END FblBrand;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblServicio
    Descripcion    : Retorna si existe o no la empresa que
                     financiaria el articulo.

    Autor          : Jorge Valiente
    Fecha          : 29/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblServicio(nuServcodi Servicio.Servcodi%type) RETURN Boolean IS

    cursor cuServicio is
      select Servcodi from Servicio where Servcodi = nuServcodi;

    nuReturn   Boolean;
    nuServicio Servicio.Servcodi%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FblServicio', 10);

    open cuServicio;
    fetch cuServicio
      into nuServicio;
    if cuServicio%found then
      nuReturn := true;
    else
      nuReturn := false;
    end if;
    close cuServicio;

    ut_trace.trace('Fin LD_BCPortafolio.FblServicio', 10);

    RETURN nuReturn;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;

  END FblServicio;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblConcepto
    Descripcion    : Retorna si existe o no el concepto
                     asociado al articulo.

    Autor          : Jorge Valiente
    Fecha          : 29/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblConcepto(nuConccodi Concepto.Conccodi%type) RETURN Boolean IS

    cursor cuConcepto is
      select Conccodi from Concepto where Conccodi = nuConccodi;

    nuReturn   Boolean;
    nuServicio Concepto.Conccodi%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FblConcepto', 10);

    open cuConcepto;
    fetch cuConcepto
      into nuServicio;
    if cuConcepto%found then
      nuReturn := true;
    else
      nuReturn := false;
    end if;
    close cuConcepto;

    ut_trace.trace('Fin LD_BCPortafolio.FblConcepto', 10);

    RETURN nuReturn;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;

  END FblConcepto;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblSegmenSupplier
    Descripcion    : Retorna si existe o no la sublinea en
                     la entidad LD_SEGMEN_SUPPLIER.

    Autor          : Jorge Valiente
    Fecha          : 30/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblSegmenSupplier(nuSubLineId LD_SEGMEN_SUPPLIER.SUBLINE_ID%type)
    RETURN Boolean IS

    cursor cuSegmenSupplier is
      select SUBLINE_ID
        from LD_SEGMEN_SUPPLIER
       where SUBLINE_ID = nuSubLineId;

    nuReturn  Boolean;
    nuSubLine LD_SEGMEN_SUPPLIER.SUBLINE_ID%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FblConcepto', 10);

    open cuSegmenSupplier;
    fetch cuSegmenSupplier
      into nuSubLine;
    if cuSegmenSupplier%found then
      nuReturn := true;
    else
      nuReturn := false;
    end if;
    close cuSegmenSupplier;

    ut_trace.trace('Fin LD_BCPortafolio.FblConcepto', 10);

    RETURN nuReturn;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;

  END FblSegmenSupplier;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : FblSupplierSubline
    Descripcion    : Valida si la sublínea está asociada al proveedor

    Autor          : Katherine Cienfuegos
    Fecha          : 30/07/2014

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblSupplierSubline(inuSubLineId in LD_SEGMEN_SUPPLIER.SUBLINE_ID%type,
							                inuSupplierId in LD_SEGMEN_SUPPLIER.SUPPLIER_ID%type)
    RETURN Boolean IS

    cursor cuSupplierSubline is
      select SUBLINE_ID
        from LD_SEGMEN_SUPPLIER
       where SUBLINE_ID = inuSubLineId
         and SUPPLIER_ID = inuSupplierId;

    nuReturn  Boolean;
    nuSubLine LD_SEGMEN_SUPPLIER.SUBLINE_ID%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FblSupplierSubline', 10);

    open cuSupplierSubline;
    fetch cuSupplierSubline
      into nuSubLine;
    if cuSupplierSubline%found then
      nuReturn := true;
    else
      nuReturn := false;
    end if;
    close cuSupplierSubline;

    ut_trace.trace('Fin LD_BCPortafolio.FblSupplierSubline', 10);

    RETURN nuReturn;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;

  END FblSupplierSubline;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuCommision
    Descripcion    : Retorna el codigo de la comision.

    Autor          : Jorge Valiente
    Fecha          : 26/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FnuCommision(nuLine                  ld_commission.Line_Id%type,
                        nuSublinea              ld_commission.subline_id%type,
                        nuArticleId             ld_commission.article_id%type,
                        nuSaleChanelId          ld_commission.Sale_Chanel_Id%type,
                        nuGeGeograLocationId    ld_commission.geograp_location_id%type,
                        nuContratorId           ld_commission.contrator_id%type,
                        nuSupplier              ld_commission.supplier_id%type
                        )
    RETURN ld_commission.commission_id%type IS

    cursor cuCommision is
      SELECT commission_id
        FROM ld_commission c
       WHERE c.line_id                      = nuLine
         AND c.subline_id                   = nuSublinea
         AND nvl(article_id,-99)            = decode(nuArticleId,null,-99,nuArticleId)
         AND nvl(sale_chanel_id,-99)        = decode(nuSaleChanelId,null,-99,nuSaleChanelId)
         AND nvl(geograp_location_id,-99)   = decode(nuGeGeograLocationId,null,-99,nuGeGeograLocationId)
         AND nvl(contrator_id,-99)          = decode(nuContratorId,null,-99,nuContratorId)
         AND nvl(c.supplier_id,99)          = decode(nuSupplier,null,-99,nuSupplier);
    nuCommissionId ld_commission.commission_id%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FnuCommision', 10);

    open cuCommision;
    fetch cuCommision
      into nuCommissionId;
    if cuCommision%notfound then
      nuCommissionId := null;
    end if;
    close cuCommision;

    ut_trace.trace('Fin LD_BCPortafolio.FnuCommision', 10);

    RETURN nuCommissionId;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuCommissionId := null;
      RETURN nuCommissionId;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuCommissionId := null;
      RETURN nuCommissionId;
      RAISE ex.CONTROLLED_ERROR;

  END FnuCommision;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FtrfPromissory
    Descripcion    : Retorna los datos del deudor o codeudor.

    Autor          : Jorge Valiente
    Fecha          : 01/11/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    17-12-2013       LDiuza.SAO227806      Se modifica la consulta para agregar/modificar
                                            campos.
    12-12-2013       sgomez.SAO227111      Se adiciona obtención de campos:
                                             - Valor total
                                             - Fecha futuro
                                             - Interés (3)
    04-09-2013       jaricapa.SAO214357    Se agrega índices
    10-09-2013 vhurtadoSAO214992        Se modifica la setencia para eliminar
                                        dos full sobre GE_GEOGRA_LOCATION
  ******************************************************************/
  FUNCTION FtrfPromissory(nuPackageId in ld_promissory.package_id%type,
                          --sbPromissoryType in ld_promissory.promissory_type%type)
                          sbPromissoryTypeDebtor   in ld_promissory.promissory_type%type,
                          sbPromissoryTypeCosigner in ld_promissory.promissory_type%type)

   RETURN constants.tyRefCursor IS

    trfPromissory constants.tyRefCursor;
    MaxQuotaNumber number;
    InterestPct number;
  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FtrfPromissory', 10);

    SELECT max (quotas_number) INTO MaxQuotaNumber
                           FROM ld_non_ban_fi_item
                           WHERE non_ba_fi_requ_id = nuPackageId;

    SELECT max(ld_bcnonbankfinancing.fnuGetInterestPct(plditain, dald_non_ba_fi_requ.fdtGetSale_Date(nuPackageId)))
                INTO InterestPct
                FROM ld_non_ban_fi_item, plandife
                WHERE finan_plan_id = pldicodi
                AND non_ba_fi_requ_id = nuPackageId;

    open trfPromissory for
        SELECT
            /*+
             use_nl(ld_non_ban_fi_item)
             index(ld_non_ban_fi_item ix_ld_non_ban_fi_item02)
             leading(ld_non_ban_fi_item)
             */
             a.Article_Id,
             a.reference,
             a.description,
             deu.*,
             cod.*,
             (add_months(request_date,MaxQuotaNumber)) loan_fin_date,
             InterestPct rem_interest,
             a.article_id,
             reference,
             description,
             amount,
             unit_value,
             MaxQuotaNumber quotas_number,
             --EVESAN 18/Julio/2013
             trim(to_char(dald_non_ba_fi_requ.fnuGetQuota_Aprox_Month(ld_non_ban_fi_item.non_ba_fi_requ_id, 0), '$999G999G999G999G999D99')) "cuota_mensual_aprox",
             trim(to_char(dald_aditional_fnb_info.fnuGetAPROX_MONTH_INSURANCE(ld_non_ban_fi_item.non_ba_fi_requ_id, 0), '$999G999G999G999G999D99')) "valor_seguro"


        FROM (SELECT
                /*+ use_nl(ld_promissory)
                   index(ld_promissory IDX_LD_PROMISSORY02)
                   leading(ld_promissory)
                */
                   promissory_id,
                   holder_bill,
                   debtorname||' '||last_name debtorname,
                   identification,
                   DAge_geogra_location.fsbGetDescription(forwardingplace) forwardingplace,
                   trunc(forwardingdate) forwardingdate,
                   gender,
                   DAge_civil_state.fsbGetDescription(civil_state_id) civil_state_id,
                   trunc(birthdaydate) birthdaydate,
                   DAge_school_degree.fsbGetDescription(school_degree_) school_degree_,
                   (select address_parsed from ab_address where ab_address.address_id = ld_promissory.address_id) address_id,

                   (select
                           ge_geogra_location.description
                      from ab_address, ge_geogra_location
                      where ab_address.neighborthood_id = ge_geogra_location.geograp_location_id
                      AND ab_address.address_id = ld_promissory.address_id) neighborthood_id,

                   (select ge_geogra_location.description
                      from ab_address, ge_geogra_location
                     where ab_address.address_id = ld_promissory.address_id
                       and ab_address.geograp_location_id =
                           ge_geogra_location.geograp_location_id) city,

                   (SELECT A.DESCRIPTION
                      FROM GE_GEOGRA_LOCATION A, GE_GEOGRA_LOCATION B, AB_ADDRESS C
                     WHERE C.ADDRESS_ID = ld_promissory.address_id
                       AND C.GEOGRAP_LOCATION_ID = B.GEOGRAP_LOCATION_ID
                       AND A.GEOGRAP_LOCATION_ID = B.GEO_LOCA_FATHER_ID) department,
                   propertyphone_id,
                   dependentsnumber "DEU_PERSONAS_CARGO",
                   DAGE_HOUSE_TYPE.fsbGetDescription(housingtype) housingtype,
                   housingmonth,
                   holderrelation,
                   (select description
                      from ge_profession
                     where profession_id = to_number(occupation)) occupation,
                   companyname,
                   (select address
                      from ab_address
                     where ab_address.address_id =
                           ld_promissory.companyaddress_id) companyaddress_id,
                   phone1_id,
                   phone2_id,
                   movilphone_id,
                   oldlabor,
                   activity,
                   monthlyincome,
                   expensesincome,
                   commerreference,
                   phonecommrefe,
                   movilphocommrefe,
                   daab_address.fsbgetaddress_parsed(addresscommrefe, 0) addresscommrefe,
                   familiarreference,
                   phonefamirefe,
                   movilphofamirefe,
                   daab_address.fsbgetaddress_parsed(addressfamirefe, 0) addressfamirefe,
                   personalreference,
                   phonepersrefe,
                   movilphopersrefe,
                   addresspersrefe,
                   email,
                   package_id,
                   promissory_type,
                   --santiman_START
                    (select mo_packages.subscription_pend_id from mo_packages where mo_packages.package_id = nuPackageId) Subscription_id,
                    (SELECT ld_bcnonbankfinancing.fnuGetInterestPct(pktblparametr.fnugetvaluenumber('BIL_TASA_USURA'), dald_non_ba_fi_requ.fdtGetSale_Date(nuPackageId)) FROM dual) max_interest,
                    (select value_total FROM ld_non_ba_fi_requ where non_ba_fi_requ_id = nuPackageId) tot_sale_value,
                   --santiman_END
                   (select digital_prom_note_cons
                      from ld_non_ba_fi_requ t
                     where non_ba_fi_requ_id = nuPackageId) digital_prom_note_cons,
                   (select trunc(request_date)
                      from mo_packages
                     where package_id = nuPackageId) request_date,
                   (select trunc(request_date) +
                           DALD_PARAMETER.FNUGETNUMERIC_VALUE('DAYS_AVAILABLE_PAGARE')
                      from mo_packages
                     where package_id = nuPackageId) effective_date,
                   (select person_id
                      from mo_packages
                     where package_id = nuPackageId) person_id,
                   (select payment
                      from ld_non_ba_fi_requ
                     where non_ba_fi_requ_id = nuPackageId) payment,
                   (select subscriber_name || ' ' || subs_last_name
                      from ge_subscriber
                     where subscriber_id in
                           (select mo_packages.subscriber_id
                              from mo_packages
                             where mo_packages.package_id = nuPackageId)) subscriber_name,
                   contract_type_id,
                   (select catedesc from categori where catecodi = category_id) categoria,
                   (select sucadesc
                      from subcateg
                     where sucacate = category_id
                       and sucacodi = subcategory_id) subcategoria,
                   (select description
                      from ge_identifica_type
                     where ge_identifica_type.ident_type_id =
                           ld_promissory.ident_type_id) ident_type_id

              FROM ld_promissory
              WHERE package_id = nuPackageId
              AND promissory_type = sbPromissoryTypeDebtor
        ) deu,
        --FIN DEUDOR
        (   SELECT /*+ use_nl(ld_promissory)
                   index(ld_promissory IDX_LD_PROMISSORY02)
                   leading(ld_promissory)
                */
               promissory_id "CODE_PAGARE_ID",
               holder_bill "CODE_TITULAR_FACT",
               debtorname || ' ' || last_name  "CODE_NOMBRE",
               identification "CODE_IDENTIFICATION",
               DAge_geogra_location.fsbGetDescription(forwardingplace) "CODE_LUGAR_EXPEDICION",
               to_char(forwardingdate, 'DD/MM/YYYY') "CODE_FECHA_EXPEDICION",
               gender "CODE_GENERO",
               DAge_civil_state.fsbGetDescription(civil_state_id) "CODE_ESTADO_CIVIL",
               to_char(birthdaydate, 'DD/MM/YYYY') "CODE_FEC_NAC",
               DAge_school_degree.fsbGetDescription(school_degree_) "CODE_NIVEL_ESTUDIO",
               (select address_parsed
                  from ab_address
                 where ab_address.address_id = ld_promissory.address_id) "CODE_DIRECCION",
               (select ge_geogra_location.description
                  from ab_address, ge_geogra_location
                 where ab_address.address_id = ld_promissory.address_id
                   and ab_address.neighborthood_id =
                       ge_geogra_location.geograp_location_id) "CODE_BARRIO",--neighborthood_id,
               (select ge_geogra_location.description
                  from ab_address, ge_geogra_location
                 where ab_address.address_id = ld_promissory.address_id
                   and ab_address.geograp_location_id =
                       ge_geogra_location.geograp_location_id) "CODE_CIUDAD", --city,
               (SELECT A.DESCRIPTION
                  FROM GE_GEOGRA_LOCATION A, GE_GEOGRA_LOCATION B, AB_ADDRESS C
                 WHERE C.ADDRESS_ID = ld_promissory.address_id
                   AND C.GEOGRAP_LOCATION_ID = B.GEOGRAP_LOCATION_ID
                   AND A.GEOGRAP_LOCATION_ID = B.GEO_LOCA_FATHER_ID) "CODE_DEPARTAMENTO",
               propertyphone_id "CODE_TELEFONO",
               dependentsnumber "CODE_PERSONAS_CARGO",
               DAGE_HOUSE_TYPE.fsbGetDescription(housingtype) "CODE_TIPO_VIVI",--housingtype,
               housingmonth "CODE_ANTIGUEDAD",
               holderrelation "CODE_RELAC_TITU",
               (select description
                  from ge_profession
                 where profession_id = to_number(occupation)) "CODE_OCUPACION",--occupation,
               companyname "CODE_NOMBRE_EMPRESA",
               (select address
                  from ab_address
                 where ab_address.address_id =
                       ld_promissory.companyaddress_id) "CODE_DIRECC_EMPRESA",--companyaddress_id,
               phone1_id "CODE_TEL1",
               phone2_id "CODE_TEL2",
               movilphone_id "CODE_CELULAR",
               oldlabor "CODE_TIPO_CONTRATO",
               activity "CODE_ACTI",
               trim(to_char(monthlyincome, '$999G999G999G999G999D99')) "CODE_INGRESO_MENSUAL" ,
               trim(to_char(expensesincome, '$999G999G999G999G999D99')) "C_expensesincome",
               commerreference "C_commerreference",
               phonecommrefe "C_phonecommrefe",
               movilphocommrefe "C_movilphocommrefe",
               daab_address.fsbGetAddress(addresscommrefe, 0) "C_addresscommrefe",
               familiarreference "C_familiarreference",
               phonefamirefe "C_phonefamirefe",
               movilphofamirefe "C_movilphofamirefe",
               daab_address.fsbGetAddress(addressfamirefe, 0) "C_addressfamirefe",
               personalreference "C_personalreference",
               phonepersrefe "C_phonepersrefe",
               movilphopersrefe "C_movilphopersrefe",
               addresspersrefe "C_addresspersrefe",
               email "C_email",
               package_id "C_package_id",
               promissory_type "C_promissory_type",
               (select digital_prom_note_cons
                  from ld_non_ba_fi_requ t
                 where non_ba_fi_requ_id = nuPackageId) "C_digital_prom_note_cons",
               (select trunc(request_date)
                  from mo_packages
                 where package_id = nuPackageId) "C_request_date",
               (select trunc(request_date) +
                       DALD_PARAMETER.FNUGETNUMERIC_VALUE('DAYS_AVAILABLE_PAGARE')
                  from mo_packages
                 where package_id = nuPackageId) "C_effective_date",
               (select person_id
                  from mo_packages
                 where package_id = nuPackageId) "C_person_id",
               (select payment
                  from ld_non_ba_fi_requ
                 where non_ba_fi_requ_id = nuPackageId) "C_payment",
               (select subscriber_name || ' ' || subs_last_name
                  from ge_subscriber
                 where subscriber_id in
                       (select mo_packages.subscriber_id
                          from mo_packages
                         where mo_packages.package_id = nuPackageId)) "C_subscriber_name",
               contract_type_id "C_contract_type_id",
               (select catedesc from categori where catecodi = category_id) "C_categoria",
               (select sucadesc
                  from subcateg
                 where sucacate = category_id
                   and sucacodi = subcategory_id) "C_subcategoria",
               (select description
                  from ge_identifica_type
                 where ge_identifica_type.ident_type_id =
                       ld_promissory.ident_type_id) "C_ident_type_id"

            FROM ld_promissory
            WHERE package_id = nuPackageId
            AND promissory_type = sbPromissoryTypeCosigner
        ) cod,
        --FIN CODEUDOR
        ld_non_ban_fi_item,
        ld_article a
             /*+ Ubicación: LD_BCPortafolio.FtrfPromissory */
       WHERE ld_non_ban_fi_item.non_ba_fi_requ_id = nuPackageId
       AND package_id = ld_non_ban_fi_item.non_ba_fi_requ_id
       AND ld_non_ban_fi_item.article_id = a.article_id
       AND PACKAGE_ID = "C_package_id" (+);

    ut_trace.trace('Fin LD_BCPortafolio.FtrfPromissory', 10);

    RETURN trfPromissory;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;

  END FtrfPromissory;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FsbPropertArticle
    Descripcion    : Retorna las propiedades del articulo
                     en una cadena.

    Autor          : Jorge Valiente
    Fecha          : 06/11/2012

    Parametros       Descripcion
    ============     ===================
    nuArticleId      Codigo del articulo a consultar

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FsbPropertArticle(nuArticleId ld_propert_by_article.article_id%type)
    RETURN varchar2 IS

    cursor cuLdPropertArticle is
      SELECT property_id, value
        FROM ld_propert_by_article
       WHERE article_id = nuArticleId;

    cursor cuLdProperty(nuPropertyId ld_property.property_id%type) is
      SELECT description FROM ld_property WHERE property_id = nuPropertyId;

    sbPropertArticle varchar2(4000);
    sbDescription    ld_property.description%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FsbPropertArticle', 10);

    for tempcuLdPropertArticle in cuLdPropertArticle loop
      open cuLdProperty(tempcuLdPropertArticle.Property_Id);
      fetch cuLdProperty
        into sbDescription;
      if cuLdProperty%found then
        sbPropertArticle := sbPropertArticle || sbDescription || ':' ||
                            tempcuLdPropertArticle.Value || '|';
      else
        sbPropertArticle := sbPropertArticle || 'Codigo[' ||
                            tempcuLdPropertArticle.Property_Id ||
                            '] No existe:' || tempcuLdPropertArticle.Value || '|';
      end if;
      close cuLdProperty;
    end loop;

    ut_trace.trace('Fin LD_BCPortafolio.FsbPropertArticle', 10);

    RETURN sbPropertArticle;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      sbPropertArticle := null;
      RETURN sbPropertArticle;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      sbPropertArticle := null;
      RETURN sbPropertArticle;
      RAISE ex.CONTROLLED_ERROR;

  END FsbPropertArticle;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuAmountPrintOuts
    Descripcion    : Actualiza la cantidad de impresiones
                     realizadas a una lsta de precios.

    Autor          : Jorge Valiente
    Fecha          : 07/11/2012

    Parametros       Descripcion
    ============     ===================
    nuArticleId      Codigo del articulo a consultar

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FnuAmountPrintOuts(nuPriceListId Ld_Price_List.Price_List_Id%type)
    RETURN Ld_Price_List.Amount_Printouts%type IS

    nuAmountPrintouts Ld_Price_List.Amount_Printouts%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FnuAmountPrintOuts', 10);

    nuAmountPrintouts := NVL(dald_price_list.fnuGetAmount_Printouts(nuPriceListId),
                             0);

    nuAmountPrintouts := nuAmountPrintouts + 1;

    dald_price_list.updAmount_Printouts(nuPriceListId, nuAmountPrintouts);

    ut_trace.trace('Fin LD_BCPortafolio.FnuAmountPrintOuts', 10);

    RETURN nuAmountPrintouts;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuAmountPrintouts := null;
      RETURN nuAmountPrintouts;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuAmountPrintouts := null;
      RETURN nuAmountPrintouts;
      RAISE ex.CONTROLLED_ERROR;

  END FnuAmountPrintOuts;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuAmountArt
    Descripcion    : Servicio que valida que a partir de una orden  busca todos los articulos de todos
                     los proveedores y tengan estado PA(Pendiente de aprobación) si trae (0) significa
                     que el estado de la orden ya puede ser cambiada a A(Aprobada), ya que todos los articulos
                     de todos los proveedores se encuentra como no PA(Pendiente de aprobación)

    Autor          : AAcuna
    Fecha          : 23/05/2013

    Parametros       Descripcion
    ============     ===================
    inuRaiseError    Número de error
    inuOrder         Número de orden

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    23/05/2013       AAcuna                Creación
  ******************************************************************/

  FUNCTION FnuAmountArt(inuOrder      or_order.order_id%type,
                        inuRaiseError in number default 1)

   RETURN number IS

    nuGetAmmountArt number;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FnuAmountArt', 10);

    SELECT count(1)
      INTO nuGetAmmountArt
      FROM ld_item_work_order w,
           or_order_activity  oa,
           ld_article         a,
           or_order           o
     WHERE w.order_activity_id = oa.order_activity_id
       AND w.order_id = oa.order_id
       AND w.order_id = o.order_id
       AND a.article_id = w.article_id
       AND oa.order_id = oa.order_id
       AND w.state = 'PA'
       AND oa.activity_id =
           dald_parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB')
       AND oa.order_id = o.order_id
       AND o.order_id = inuOrder;

    ut_trace.trace('Fin LD_BCPortafolio.FnuAmountArt', 10);

    RETURN nuGetAmmountArt;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;

  END FnuAmountArt;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : bocopylist
  Descripcion    : Consultar la lista a partir del c?digo de lista que entra y crear
                   una lista la descripci?n y fecha inicial y final de vigencia

  Autor          : Evens Herard
  Fecha          : 30/10/2012

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE bocopylist(inuPrice_List_Id in ld_Price_List.price_list_id%type,
                       isbDescription   in Ld_Price_List.Description%type,
                       idtInitial_date  in Ld_Price_List.Initial_Date%type,
                       idtFinal_date    in Ld_Price_List.Final_Date%type,
                       inuSupplier_id   in Ld_Price_List.Price_List_Id%type) is
    --Variables
    rcList   LD_Price_List%rowtype;
    cuCursor constants.tyrefcursor;

    --Cursor con los datos de la lista
    CURSOR cuLista is
      select price_list_id,
             isbDescription description,
             supplier_id,
             creation_date,
             idtInitial_date initial_date,
             idtFinal_date final_date,
             decode(inuSupplier_id, null, 'Y', 'N') approved,
             last_date_approved,
             decode(inuSupplier_id, null, 1, 0) version,
             condition_approved
        from ld_price_list
       where price_list_id = inuPrice_List_Id;
    ---Variable tipo Cursor
    rcLD_price_list cuLista%Rowtype;

    --Cursor con los datos del detalle de la lista
    CURSOR cuLista_Deta is
      select price_list_deta_id,
             price_list_id,
             article_id,
             price,
             price_aproved,
             sale_chanel_id,
             geograp_location_id,
             version
        from ld_price_list_deta
       where price_list_id = inuPrice_List_Id;
    ---Variables
    rcLD_price_list_Deta cuLista_Deta%Rowtype;

    --Cursor con los datos de la lista original

    CURSOR cuListaOrigin IS
       select initial_date, final_date
       from ld_price_list
       where price_list_id = inuPrice_List_Id;

    --Variable tipo CURSOR
     rcPrice_List_Ori cuListaOrigin%rowtype;


    ---Variable tipo registro
    styLD_price_list      DALD_Price_List.styLD_price_list;
    styLD_price_list_Deta Dald_Price_List_Deta.styLD_price_list_Deta;
    nuNextSeq_list        number;
    nuNextSeq_list_Deta   number;
    --
  BEGIN
    ut_trace.trace('Inicio LD_BCPortafolio.bocopylist', 10);

    OPEN cuLista;
    FETCH cuLista
      INTO rcLD_price_list;

    open cuListaOrigin;
    fetch cuListaOrigin
    INTO rcPrice_List_Ori;

    /*Verifico si hay registros en el cursor*/
   IF (cuLista%found) then
   IF(cuListaOrigin%found) then
    if((trunc(to_date(idtInitial_date)) BETWEEN trunc((rcPrice_List_Ori.initial_date)) and trunc((rcPrice_List_Ori.final_date)))
            OR
       (trunc(to_date(idtFinal_date))   BETWEEN trunc((rcPrice_List_Ori.initial_date)) and trunc((rcPrice_List_Ori.final_date))))then

      CLOSE cuListaOrigin;
      CLOSE cuLista;
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                           'Las fechas de vigencia de la nueva lista no se deben sobreponer a las fechas la lista Original ');
    else

      /*Obtiene el valor de la secuencia de la tabla*/
      SELECT SEQ_LD_price_list.Nextval INTO nuNextSeq_List FROM dual;

      /*Asigna los valores e inserta el registro*/
      styLD_price_list.price_list_id := nuNextSeq_List;
      styLD_price_list.description   := rcLD_price_list.Description;
      styLD_price_list.supplier_id   := rcLD_price_list.supplier_id;
      styLD_price_list.creation_date := SYSDATE; --rcLD_price_list.creation_date; --evesan 25-abr-2013
      styLD_price_list.initial_date  := rcLD_price_list.initial_date;
      styLD_price_list.final_date    := rcLD_price_list.final_date;
      styLD_price_list.approved      := ld_boconstans.csbNOFlag; --EVESAN --rcLD_price_list.approved;
      --styLD_price_list.last_date_approved := rcLD_price_list.last_date_approved; --evesan 25-abr-2013
      styLD_price_list.version            := rcLD_price_list.version;
      styLD_price_list.condition_approved := rcLD_price_list.condition_approved;
      /*Registro los detalles*/
      DALD_Price_List.insRecord(styLD_price_list);

      CLOSE cuLista;
      CLOSE cuListaOrigin;
      /*Abre Cursor con el detalle de la lista*/
      FOR rcLD_price_list_Deta IN cuLista_Deta LOOP

        /*Obtiene el valor de la secuencia de la tabla por cada registro*/
        SELECT SEQ_LD_price_list_deta.Nextval
          INTO nuNextSeq_list_Deta
          FROM dual;

        /*Asigna los valores e inserta el registro en un loop*/
        styLD_price_list_Deta.price_list_deta_id  := nuNextSeq_list_Deta;
        styLD_price_list_Deta.price_list_id       := nuNextSeq_list;
        styLD_price_list_Deta.article_id          := rcLD_price_list_Deta.Article_Id;
        styLD_price_list_Deta.price               := rcLD_price_list_Deta.Price;
        styLD_price_list_Deta.price_aproved       := rcLD_price_list_Deta.Price_Aproved;
        styLD_price_list_Deta.sale_chanel_id      := rcLD_price_list_Deta.Sale_Chanel_Id;
        styLD_price_list_Deta.geograp_location_id := rcLD_price_list_Deta.Geograp_Location_Id;
        styLD_price_list_Deta.version             := rcLD_price_list_Deta.Version;

        /*Registro los detalles*/
        Dald_Price_List_Deta.insRecord(styLD_price_list_Deta);

      END LOOP;

    END if;

    END IF;

    END IF;

    ut_trace.trace('Finaliza LD_BCPortafolio.bocopylist', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END bocopylist;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FtrfArticle
    Descripcion    : Retorna los articulos del pagare.

    Autor          : Jorge Valiente
    Fecha          : 01/11/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FtrfArticle(nuPackageId in ld_promissory.package_id%type)

   RETURN constants.tyRefCursor IS

    trfArticle constants.tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FtrfArticle', 10);

    open trfArticle for
      select ld_article.article_id,
             reference,
             description,
             amount,
             unit_value,
             quotas_number
        from ld_non_ban_fi_item, ld_article
       where ld_non_ban_fi_item.non_ba_fi_requ_id = nuPackageId
         and ld_non_ban_fi_item.article_id = ld_article.article_id;

    ut_trace.trace('Fin LD_BCPortafolio.FtrfArticle', 10);

    RETURN trfArticle;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;

  END FtrfArticle;
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FblLine
    Descripcion    : Retorna si existe o no la linea a la
                     que se asociara el articulo.

    Autor          : Jorge Valiente
    Fecha          : 29/10/2012

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION FblLine(nulineid Ld_line.line_id%type) RETURN Boolean IS

    cursor culine is
      select line_id
        from ld_line
       where line_id = nulineid
         and approved = 'Y';

    nuReturn Boolean;
    nuline   Ld_line.line_id%type;

  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FblLine', 10);

    open culine;
    fetch culine
      into nuline;

    nuReturn := culine%found;

    close culine;

    ut_trace.trace('Fin LD_BCPortafolio.FblLine', 10);

    RETURN nuReturn;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;

  END FblLine;
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuGetDupliDate
    Descripcion    : Retorna 0 cuando un rango de fechas de la tabla
                     esta superponiendo a otro rango con las mismas
                     caracteristicas de parametrizacion
                     y retorna 1 cuando este no superpone la
                     parametrizacion
    Autor          : Evelio Sanjuanelo
    Fecha          : 14/03/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
  ******************************************************************/
  FUNCTION fnuGetDupliDate(identificador   in LD_EXTRA_QUOTA.EXTRA_QUOTA_ID%type,
                           proveedor       in LD_EXTRA_QUOTA.supplier_id%type,
                           categoria       in LD_EXTRA_QUOTA.category_id%type,
                           subcatega       in LD_EXTRA_QUOTA.subcategory_id%type,
                           ubica_geo       in LD_EXTRA_QUOTA.geograp_location_id%type,
                           canal_ven       in LD_EXTRA_QUOTA.sale_chanel_id%type,
                           linea           in LD_EXTRA_QUOTA.line_id%type,
                           sublinea        in LD_EXTRA_QUOTA.subline_id%type,
                           fecha_ini       in LD_EXTRA_QUOTA.Initial_Date%type,
                           fecha_fin       in LD_EXTRA_QUOTA.Final_Date%type)
    RETURN NUMBER IS

    fecha_final_max LD_EXTRA_QUOTA.Final_Date%type;
  BEGIN
    if(identificador is null)then
       SELECT MAX(trunc(final_date))
      --  SELECT trunc(final_date)
          into fecha_final_max
          FROM LD_EXTRA_QUOTA E
         WHERE nvl(supplier_id, -99) = nvl(proveedor, -99)
           and nvl(category_id, -99) = nvl(categoria, -99)
           and nvl(subcategory_id, -99) = nvl(subcatega, -99)
           and nvl(geograp_location_id, -99) = nvl(ubica_geo, -99)
           and nvl(sale_chanel_id, -99) = nvl(canal_ven, -99)
           and nvl(line_id, -99) = nvl(linea, -99)
           and nvl(subline_id, -99) = nvl(sublinea, -99)
           and (fecha_ini between trunc(e.initial_date) and trunc(e.final_date)
           or fecha_fin between trunc(e.initial_date) and trunc(e.final_date))
           and rownum = 1;

    else
        --SELECT MAX(trunc(final_date))
        SELECT trunc(final_date)
          into fecha_final_max
          FROM LD_EXTRA_QUOTA E
         WHERE nvl(supplier_id, -99) = nvl(proveedor, -99)
           and nvl(category_id, -99) = nvl(categoria, -99)
           and nvl(subcategory_id, -99) = nvl(subcatega, -99)
           and nvl(geograp_location_id, -99) = nvl(ubica_geo, -99)
           and nvl(sale_chanel_id, -99) = nvl(canal_ven, -99)
           and nvl(line_id, -99) = nvl(linea, -99)
           and nvl(subline_id, -99) = nvl(sublinea, -99)
           and (fecha_ini between trunc(initial_date) and trunc(e.final_date)
           or fecha_fin between trunc(initial_date) and trunc(e.final_date))
           and e.extra_quota_id <> identificador
           and rownum = 1;
    end if;

        if (fecha_final_max is null) then
          RETURN(1); --No hay conflicto de fechas
        else
   --       if (fecha_final_max < trunc(fecha_ini)) then
    --        RETURN(1); --No hay conflicto de fechas
    --      else
            RETURN(0); --Hay conflicto de fechas
    --      end if;
        end if;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return (1);
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetDupliDate;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuArticleInPriceList
    Descripcion    : Indica si un articulo con una determinada ubicacion geografica
           se encuentra en otra lista de precios.

    Autor          : Alex Valencia
    Fecha          : 19/03/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha                 Autor                   Modificacion
    =========             ===========             ====================
    19/jun/2013           EveSan                  Se agregan los parámetros proveedor y canal de venta
  ******************************************************************/

  FUNCTION FnuArticleInPriceList
           (
                     nuArticleId           IN ld_price_list_deta.article_id%TYPE,
                     nuGeoLocatId          IN ld_price_list_deta.geograp_location_id%TYPE,
                     inuSupplier           IN ld_price_list.supplier_id%type,
                     inuSalesChannel       IN ld_price_list_deta.sale_chanel_id%type,
                     inuInitialDate        IN ld_price_list.initial_date%type,
                     inuFinalDate          IN ld_price_list.final_date%type,
                     inuPriceListId        in ld_price_list.price_list_id%type
           )

   RETURN PLS_INTEGER IS
    con varchar2(2000);
    nuReturn PLS_INTEGER;
  BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.FnuArticleInPriceList', 10);

    SELECT count(1)
      INTO nuReturn
      FROM ld_price_list l, ld_price_list_deta d
     WHERE l.price_list_id                     =    d.price_list_id
       AND
       (
            (trunc(to_date(inuInitialDate)) BETWEEN trunc((l.initial_date)) and trunc((l.final_date)))
            OR
            (trunc(to_date(inuFinalDate))   BETWEEN trunc((l.initial_date)) and trunc((l.final_date)))
       )
       AND d.article_id                        =    nuArticleId
       AND NVL(d.geograp_location_id, -1)      =    NVL(nuGeoLocatId, -1) --DECODE(NVL(nuGeoLocatId,-1), -1, NVL(d.geograp_location_id, -1),nuGeoLocatId)
       AND NVL(d.sale_chanel_id,-1)            =    NVL(inuSalesChannel,-1)
       and l.supplier_id                       =    inuSupplier
       AND l.approved                          =    'Y'
	   AND l.price_list_id != inuPriceListId;

    RETURN nuReturn;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 0;
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;

  END FnuArticleInPriceList;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FsbgetApprove_Sales_OrderRowid
    Descripcion    : Marca como aprobada una orden de venta pendiente
                     por aprobaacion
    Autor          : jonathan alberto consuegra lara
    Fecha          : 19/03/2013

    Parametros                Descripcion
    ============              ===================
    inuApprove_Sales_Order_Id identificador unico de registro
    inuRaiseError             controlador de error

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    19/03/2013       jconsuegra.SAO156917  Creacion
  ******************************************************************/
  Function FsbgetApprove_Sales_OrderRowid(inuApprove_Sales_Order_Id in LD_approve_sales_order.Approve_Sales_Order_Id%type,
                                          inuRaiseError             in number default 1)
    return varchar2 is
    sbrowid varchar2(1000);

  Begin

    ut_trace.trace('Inicio LD_BcPortafolio.FsbgetApprove_Sales_OrderRowid',
                   10);

    SELECT l.rowid
      INTO sbrowid
      FROM LD_approve_sales_order l
     WHERE l.approve_sales_order_id = inuApprove_Sales_Order_Id;

    Return sbrowid;

    ut_trace.trace('Fin LD_BcPortafolio.FsbgetApprove_Sales_OrderRowid',
                   10);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  End FsbgetApprove_Sales_OrderRowid;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnugetApprove_Sales_OrderId
    Descripcion    : Obtiene el ID de un registro de la tabla
                     approve_sales_order

    Autor          : jonathan alberto consuegra lara
    Fecha          : 19/03/2013

    Parametros       Descripcion
    ============     ===================
    inuorder         identificador de la orden
    inuRaiseError    controlador de error

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    19/03/2013       jconsuegra.SAO156917  Creacion
  ******************************************************************/
  Function FnugetApprove_Sales_OrderId(inuorder      in or_order.order_id%type,
                                       inuRaiseError in number default 1)
    return LD_approve_sales_order.Approve_Sales_Order_Id%type is

    nuid LD_approve_sales_order.Approve_Sales_Order_Id%type;

  Begin

    ut_trace.trace('Inicio LD_BcPortafolio.FnugetApprove_Sales_OrderId',
                   10);

    SELECT l.approve_sales_order_id
      INTO nuid
      FROM LD_approve_sales_order l
     WHERE l.order_id = inuorder;

    Return nuid;

    ut_trace.trace('Fin LD_BcPortafolio.FnugetApprove_Sales_OrderId', 10);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  End FnugetApprove_Sales_OrderId;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad :         frfGetArticleOrder
  Descripcion    : Retorna el valor de las pólizas que fueron adquiridadas despues de la edad maxima para
                   coger un seguro
  Autor          : AAcuna
  Fecha          : 22/05/2013 SAO

  Parametros         Descripción
  ============   ===================
  inuorden:      Número de orden

  Historia de Modificaciones
  Fecha            Autor            Modificación
  =========      =========          ====================
  18-Ene-2014   AEcheverrySAO230039 se modifica para obtener solo los articulos
                                    pendientes de aprobacion de precio
  ******************************************************************/
  FUNCTION frfGetArticleOrder(inuorden in or_order.order_id%type)

   RETURN constants.tyrefcursor

   IS

    rfGetPoliTransfer constants.tyrefcursor;

    nuContratorId   ge_contratista.id_contratista%type;
    nuOperUnitId    or_operating_unit.operating_unit_id%type;

  BEGIN

    --Se consulta la unidad operativa del funcionario conectado
    nuOperUnitId := ld_bcnonbankfinancing.fnuGetUnitBySeller;

    ut_trace.trace('nuOperUnitId ' || nuOperUnitId, 10);

    nuContratorId := daor_operating_unit.fnugetcontractor_id(nuOperUnitId);
    ut_trace.trace('nuContratorId ' || nuContratorId, 10);

    OPEN rfGetPoliTransfer FOR
      SELECT distinct w.item_work_order_id, w.article_id,oa.package_id
        FROM ld_item_work_order w,
             or_order_activity  oa,
             ld_article         a,
             or_order           o
       WHERE w.order_activity_id = oa.order_activity_id
         AND w.order_id = oa.order_id
         AND w.order_id = o.order_id
         AND a.article_id = w.article_id
         AND oa.order_id = oa.order_id
         AND w.supplier_id = nuContratorId
         AND w.state   = 'PA'
         AND oa.activity_id =
             dald_parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB')
         AND oa.order_id = o.order_id
         AND o.order_id = inuorden;

    RETURN rfGetPoliTransfer;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END frfGetArticleOrder;



  FUNCTION FnuGetSupplierPerson

   RETURN number

   IS
  nuSupplier ge_contratista.id_contratista%type;

  BEGIN
  /*select u.contractor_id into nuSupplier from or_oper_unit_persons op, or_operating_unit u
       where op.person_id              = ge_bopersonal.fnuGetPersonId
       and   op.operating_unit_id      = u.operating_unit_id
       and   u.oper_unit_classif_id    = DALD_PARAMETER.FNUGETNUMERIC_VALUE('SUPPLIER_FNB')
       and   rownum = 1;*/

    /*Se modifica para obtener el contratista asociado al punto de venta conectado*/
    select u.contractor_id into nuSupplier
      from or_oper_unit_persons op, or_operating_unit u,cc_orga_area_seller cc
     where op.person_id  = ge_bopersonal.fnuGetPersonId
       and op.operating_unit_id  = u.operating_unit_id
       and cc.organizat_area_id = op.operating_unit_id
       and cc.person_id = op.person_id
       and cc.is_current = 'Y'
       and u.oper_unit_classif_id = DALD_PARAMETER.FNUGETNUMERIC_VALUE('SUPPLIER_FNB')
       and rownum = 1;

       return nuSupplier;
  EXCEPTION
    when no_data_found then
      nuSupplier := null;
      return nuSupplier;
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END FnuGetSupplierPerson;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad :         FnuGetMailNameSupplier
  Descripcion    : Retorna el Nombre y Mail de la persona conectada
  Autor          : Evelio Sanjuanelo
  Fecha          : 18/Jun/2013

  Parametros           Descripción
  ============         ===================
  inuorden:            Número de orden

  Historia de Modificaciones
  Fecha               Autor            Modificación
  ==============      ============     ====================
  18-09-2014      KCienfuegos.NC2256   Se modifica ya que no estaba enviando la informacion correcta
                                       del contratista conectado.
  ******************************************************************/
PROCEDURE  FnuGetMailNameSupplier
  (
      osMail out ge_contratista.correo_electronico%TYPE,
      osName out ge_contratista.nombre_contratista%TYPE
   ) IS
BEGIN
        SELECT open.dage_contratista.fsbGetCorreo_Electronico(or_operating_unit.CONTRACTOR_ID,
                                                            NULL),
             open.dage_contratista.fsbGetNombre_Contratista(or_operating_unit.CONTRACTOR_ID,
                                                            NULL)
        INTO osMail, osName
        FROM open.or_operating_unit
       WHERE or_operating_unit.operating_unit_id =
             (SELECT c.organizat_area_id
                FROM open.cc_orga_area_seller c
               WHERE person_id = GE_BOPersonal.fnuGetPersonId
                 AND IS_current = 'Y'
                 AND rownum = 1)
         AND or_operating_unit.contractor_id is not null
         and rownum = 1;
          /*SELECT dage_contratista.fsbGetCorreo_Electronico(or_operating_unit.CONTRACTOR_ID, NULL),
                 dage_contratista.fsbGetNombre_Contratista(or_operating_unit.CONTRACTOR_ID, NULL)
                  INTO osMail, osName
                     FROM   or_oper_unit_persons, or_operating_unit
                     WHERE  or_oper_unit_persons.person_id = GE_BOPERSONAL.FNUGETPERSONID -- 1 --Usuario con correo
                     AND    or_oper_unit_persons.operating_unit_id = or_operating_unit.operating_unit_id
                     AND    or_operating_unit.contractor_id is not null and rownum = 1;*/
EXCEPTION
   WHEN NO_DATA_FOUND THEN
     null;
   WHEN OTHERS THEN
     null;
END FnuGetMailNameSupplier;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fblSegSupplierbyLine
    Descripcion    : Retorna si existe configuración para la línea y el
                     proveedor dado en la entidad LD_SEGMEN_SUPPLIER.

    Autor          : Jorge Alejandro Carmona Duque
    Fecha          : 15/10/2013

    Parametros       Descripcion
    ============     ===================

    Historia de Modificaciones
    Fecha           Autor                   Modificacion
    =========       =========               ====================
    15/10/2013      JCarmona.SAO219877      Creación.
    ******************************************************************/
    FUNCTION fblSegSupplierbyLine
    (
        nuLineId        LD_SEGMEN_SUPPLIER.LINE_ID%type,
        nuSupplierId    LD_SEGMEN_SUPPLIER.supplier_id%type
    )
    RETURN Boolean
    IS

        CURSOR cuSegSupplierbyLine
        IS
            SELECT supplier_id
            FROM LD_SEGMEN_SUPPLIER
            WHERE LINE_ID = nuLineId
            AND SUPPLIER_ID = nuSupplierId
            AND subline_id is null;

        nuReturn  Boolean;
        nuSupplier LD_SEGMEN_SUPPLIER.supplier_id%type;

    BEGIN

    ut_trace.trace('Inicio LD_BCPortafolio.fblSegSupplierbyLine', 1);

    open cuSegSupplierbyLine;
    fetch cuSegSupplierbyLine
        into nuSupplier;
    if cuSegSupplierbyLine%found then
        nuReturn := true;
    else
        nuReturn := false;
    end if;
    close cuSegSupplierbyLine;

    ut_trace.trace('Fin LD_BCPortafolio.fblSegSupplierbyLine', 1);

    RETURN nuReturn;

    EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      nuReturn := false;
      RETURN nuReturn;
      RAISE ex.CONTROLLED_ERROR;

    END fblSegSupplierbyLine;



END LD_BCPORTAFOLIO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BCPORTAFOLIO', 'ADM_PERSON');
END;
/
