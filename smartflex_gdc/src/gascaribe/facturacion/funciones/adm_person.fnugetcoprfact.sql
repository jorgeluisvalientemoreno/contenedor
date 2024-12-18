CREATE OR REPLACE FUNCTION adm_person.fnuGetCoPrFact  (inuProducto  IN open.servsusc.sesunuse%type,
                                            idtFecha     IN date,
                                            inuPeriodos  IN number) return number AS

/*******************************************************************************
  Propiedad intelectual de GC

  Descripcion    : Funcion que devuelve el Consumo promedio facturado de un producto 
                   en la facturacion N anterior a una fecha recibida como parametro
                   inuperiodos es 1 para la ultima facturacion antes de la fecha dada
                                  2 para la penultima. etc
                   
                   Devuelve Nulo: en el periodo solicitado el producto no tuvo facturacion
                               -1: se facturo real
                               >0: consumo promedio facturado

                   

  Autor          : F.Castro
  Fecha          : 23-05-2016

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================

  *******************************************************************************/


nupefa      number;
dtfech      date;
i           number;
nuProm      open.conssesu.cosscoca%type := -1;


cursor cupefa is
select factpefa, factfege
  from open.factura , open.servsusc ss
 where factsusc=ss.sesususc
   and factprog=6
   and factfege < idtFecha
   and ss.sesunuse=inuProducto
  order by factpefa desc;

begin
  i := 1;
  nupefa := null;
  for rg in cupefa loop
    if i = inuPeriodos then
       nupefa := rg.factpefa;
       dtfech := rg.factfege;
    end if;
    exit when i = inuPeriodos;
    i := i + 1;
  end loop;

  if nupefa is null then  -- el producto no tuvo facturacion en el periodo dado
    nuProm := null;
  else
     nuProm := nvl(open.fnuGetConsPromFact  (inuProducto, dtfech,  nupefa),-1);
  end if;


return (nuProm);

EXCEPTION
    WHEN OTHERS THEN

      return null;
END fnuGetCoPrFact;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETCOPRFACT', 'ADM_PERSON');
END;
/