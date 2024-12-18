CREATE OR REPLACE package adm_person.ldc_pkg_reports_fact is
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad           : LDC_REPORTS_FACT
    Descripcion      : Paquete para reportes de facturaciones
    Autor            :  Diego Fernando Rodriguez
    Fecha            :  31/05/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    18/06/2024        Adrianavg         OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
  ******************************************************************/

   -- Variable globales para manejo para el reporte de cargos a las -1
   nuPeriodo   PERIFACT.PEFACODI%type;
   sbCadena    Varchar2(2000) := '1';

   -- Retornan los productos que deben se visualizados en el reporte
   function fsbCuenCobrMenosUno ( inuPeriodo   PERIFACT.PEFACODI%type,
                                  inuPos       number) return varchar2;

--function fsbObtieneProductos (inuPeriodo   PERIFACT.PEFACODI%type) return varchar2 ;

 --  function fnuLlenaTabla (inuPeriodo   PERIFACT.PEFACODI%type) return varchar2;
end LDC_PKG_REPORTS_FACT;
/
CREATE OR REPLACE package body adm_person.LDC_PKG_REPORTS_FACT is
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad           : fsbObtieneProductos
    Descripcion      : Retorna los producto para la consulta
    Autor            :  Diego Fernando Rodriguez
    Fecha            :  31/05/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/

  /******************************************************************/
  ---- Variables Privadas del Paquete

  type tyrcCatSubca IS record
  (
        nuCategory      servsusc.sesucate%type,
        nuSubcategory   servsusc.sesusuca%type
  );

  type tytbMemTable IS table of tyrcCatSubca index BY binary_integer;

  tbMemTable  tytbMemTable;

  nuPefa    perifact.pefacodi%type;

  -------------------------------------------------------------------------
-- Retornan los productos que deben se visualizados en el reporte

    /* ========================================================================
      Modificaciones:
      21-01-2014    carlosr
      Se hace mejora de rendimiento

     =========================================================================*/
function fsbObtieneProductos (inuPeriodo   PERIFACT.PEFACODI%type) return varchar2
IS
   -- Categorias a evaluar en el reporte
    cursor cuCate is
      select
             ss.sesucate ,
             sesusuca
      from cargos c,SERVSUSC ss
      where CARGPEFA = inuPeriodo
        and c.cargnuse = ss.sesunuse
      group by sesucate,sesusuca
      order by sesucate,sesusuca;

    -- Productos para filtar el select
    cursor cuProducto(inuCate servsusc.sesucate%type,
                      inusuca servsusc.sesusuca%type,
                      inuRegistro Ld_Parameter.Numeric_Value%type )  is
       select sesunuse from
           (
             select  sesunuse
                from
                (  select sesunuse,(1+ABS(MOD(dbms_random.random,100000))) ordenar
                from cargos c,SERVSUSC ss
                where c.cargnuse = ss.sesunuse
                  and CARGPEFA = inuPeriodo
                  and sesucate = inuCate
                  and sesusuca = inusuca
                  and cargcuco = -1
                group by sesunuse
                order by sesunuse)
              order by ordenar
             )
          where rownum <= inuRegistro;

    sbRetornar Varchar2(2000);

    cursor cuParametro is
    select Numeric_Value from Ld_Parameter where Parameter_Id =  'LDC_REPORTES_FACT_CUEN_COB_-1';

    nuParametro Ld_Parameter.Numeric_Value%type;
    nuCount number;
begin

    for rcParametro in cuParametro loop
        nuParametro := rcParametro.Numeric_Value;
    end loop;

    -- Variable para retornar los productos para consultar
    sbRetornar := '|';

    if(nuPefa IS null OR nuPefa <> inuPeriodo) then

        nuPefa := inuPeriodo;
        if(tbMemTable.count = 0) then
            open    cuCate;
            fetch   cuCate bulk collect into tbMemTable;
            close   cuCate;
        end if;
    end if;

    nuCount := tbMemTable.first;
    -- Arma la cadena de los productos
    loop
        exit when (nuCount IS null);

        for rcProducto in cuProducto(tbMemTable(nuCount).nuCategory ,tbMemTable(nuCount).nuSubCategory,nuParametro) loop
             sbRetornar := sbRetornar||rcProducto.sesunuse||'|';
         end loop;
        nuCount := tbMemTable.next(nuCount);
    end loop;

    -- Retorna la cadena con los productos
    return sbRetornar;

end fsbObtieneProductos;

/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad           : fsbCuenCobrMenosUno
    Descripcion      : Retorna los producto para la consulta
    Autor            :  Diego Fernando Rodriguez
    Fecha            :  31/05/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
function fsbCuenCobrMenosUno (inuPeriodo   PERIFACT.PEFACODI%type,
                               inuPos       number) return varchar2
 is

  sbProctos Varchar2(2000);
  nuCantidad number;
 begin

      -- Valida si se requiere volver a generar la informacion de los productos
      -- hay tres condiciones:
      -- 1. Cuando la cadena sea '1', es el valor por defecto de la variable y se debe calcular el valor
      -- 2. Cuando ejecuten un periodo diferente del que esta en memoria.
      -- 3. cuando la posicion es 1, esto quiere decir que es el primer registro de la consulta
      if (LDC_PKG_REPORTS_FACT.sbCadena = '1' or
          LDC_PKG_REPORTS_FACT.nuPeriodo <> inuPeriodo or
          inuPos = 1) then

         -- Calcula el valor de los productos que se deben consultar
         sbProctos := LDC_PKG_REPORTS_FACT.fsbObtieneProductos(inuPeriodo);
         -- Variable global
         LDC_PKG_REPORTS_FACT.sbCadena := sbProctos;
      end if;

      -- Productos a rretornar
      sbProctos := LDC_PKG_REPORTS_FACT.sbCadena;

      -- Actualiza la variable de memoria con el periodo que se proceso
      LDC_PKG_REPORTS_FACT.nuPeriodo := inuPeriodo;

      -- Retornar variable
      return sbProctos;

 end fsbCuenCobrMenosUno;

end LDC_PKG_REPORTS_FACT;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKG_REPORTS_FACT
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKG_REPORTS_FACT', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_PKG_REPORTS_FACT
GRANT EXECUTE ON ADM_PERSON.LDC_PKG_REPORTS_FACT TO REXEREPORTES;
/
