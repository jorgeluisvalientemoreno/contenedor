CREATE OR REPLACE PACKAGE adm_person.PKACUCARTOT IS
  /**************************************************************************
      Proceso     : DATOSBASICOSPROYCTCOTIZ
      Autor       : Josh Brito / Horbath
      Fecha       : 2018-24-10
      Ticket      : 200-2022
      Descripcion : Proceso para obtener los datso basicos del proyecto y de la cotizacion

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  PROCEDURE PROLDRACUCARTOT;

  PROCEDURE PROLDRACUCARTOTK;

END PKACUCARTOT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PKACUCARTOT IS

  PROCEDURE PROLDRACUCARTOT IS
  /**************************************************************************
      Proceso     : PROLDRACUCARTOT
      Autor       : Josh Brito / olsoftware
      Fecha       : 2020-07-08
      CASO        : 453
      Descripcion : Proceso para obtener los datso basicos del proyecto y de la cotizacion

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    nuTipoProducto  ge_boInstanceControl.stysbValue;
    nuDepartamento  ge_boInstanceControl.stysbValue;
    nuLocalidad     ge_boInstanceControl.stysbValue;
    nuCategoria     ge_boInstanceControl.stysbValue;
    nuAnoIni        ge_boInstanceControl.stysbValue;
    nuMesInicial    ge_boInstanceControl.stysbValue;

    cnuNULL_ATTRIBUTE constant number := 2126;

    nuerror       number;
    sbmessage     varchar2(2000);

  begin

    nuTipoProducto := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue('SERVICIO', 'SERVSETI'));
    nuDepartamento := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue('LDC_LOC_TIPO_LIST_DEP', 'DEPARTAMENTO'));
    nuLocalidad := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue('LDC_LOC_TIPO_LIST_DEP', 'LOCALIDAD'));
    nuCategoria := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue('PS_CLASS_CATEGORY', 'CATEGORY_ID'));
    nuAnoIni := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFAANO'));
    nuMesInicial := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFAMES'));



    if (nuTipoProducto is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Tipo de Producto');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (nuDepartamento is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Departamento');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (nuLocalidad is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Localidad');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (nuCategoria is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Categoria');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (nuAnoIni is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'A�o');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (nuMesInicial is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Mes Inicial');
      raise ex.CONTROLLED_ERROR;
    end if;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;

    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PROLDRACUCARTOT;

  PROCEDURE PROLDRACUCARTOTK IS
  /**************************************************************************
      Proceso     : PROLDRACUCARTOTK
      Autor       : Josh Brito / olsoftware
      Fecha       : 2020-07-08
      CASO        : 453
      Descripcion : Proceso para obtener los datso basicos del proyecto y de la cotizacion

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    nuTipoProducto  ge_boInstanceControl.stysbValue;
    nuDepartamento  ge_boInstanceControl.stysbValue;
    nuLocalidad     ge_boInstanceControl.stysbValue;
    nuCategoria     ge_boInstanceControl.stysbValue;
    nuAnoIni        ge_boInstanceControl.stysbValue;
    nuMesInicial    ge_boInstanceControl.stysbValue;

    cnuNULL_ATTRIBUTE constant number := 2126;

    nuerror       number;
    sbmessage     varchar2(2000);

  begin

    nuTipoProducto := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue('SERVICIO', 'SERVSETI'));
    nuDepartamento := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue('LDC_LOC_TIPO_LIST_DEP', 'DEPARTAMENTO'));
    nuLocalidad := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue('LDC_LOC_TIPO_LIST_DEP', 'LOCALIDAD'));
    nuCategoria := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue('PS_CLASS_CATEGORY', 'CATEGORY_ID'));
    nuAnoIni := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFAANO'));
    nuMesInicial := ut_convert.fnuchartonumber(ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFAMES'));



    if (nuTipoProducto is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Tipo de Producto');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (nuDepartamento is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Departamento');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (nuLocalidad is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Localidad');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (nuCategoria is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Categoria');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (nuAnoIni is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'A�o');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (nuMesInicial is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Mes Inicial');
      raise ex.CONTROLLED_ERROR;
    end if;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;

    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PROLDRACUCARTOTK;


END PKACUCARTOT;
/
PROMPT Otorgando permisos de ejecucion a PKACUCARTOT
BEGIN
    pkg_utilidades.praplicarpermisos('PKACUCARTOT', 'ADM_PERSON');
END;
/
