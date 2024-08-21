PL/SQL Developer Test script 3.0
63
-- Created on 16/08/2024 by JORGE VALIENTE 
declare
  -- Local variables here

  nuOrdenPadre number := 0;
  nuOrdenHija  number := 319147256;
  nuFin        number := 0;

  cursor cuRelacion(inuOrdenHija number) is
    select oro.order_id OrdenPadre,
           (select ott.task_type_id || ' - ' || tt.description
              from open.or_order ott, open.or_task_type tt
             where ott.order_id = oro.order_id
               and tt.task_type_id = ott.task_type_id) TTPadre,
           oro.related_order_id OrdenHija,
           (select ott.task_type_id || ' - ' || tt.description
              from open.or_order ott, open.or_task_type tt
             where ott.order_id = oro.related_order_id
               and tt.task_type_id = ott.task_type_id) TTHija,
           oro.rela_order_type_id
      from open.or_related_order oro
     where oro.related_order_id in inuOrdenHija;
  rfRelacion cuRelacion%rowtype;

  cursor cuultimaRelacion(inuOrdenPadre number) is
    select oro.order_id OrdenPadre,
           (select ott.task_type_id || ' - ' || tt.description
              from open.or_order ott, open.or_task_type tt
             where ott.order_id = oro.order_id
               and tt.task_type_id = ott.task_type_id) TTPadre,
           oro.related_order_id OrdenHija,
           (select ott.task_type_id || ' - ' || tt.description
              from open.or_order ott, open.or_task_type tt
             where ott.order_id = oro.related_order_id
               and tt.task_type_id = ott.task_type_id) TTHija,
           oro.rela_order_type_id
      from open.or_related_order oro
     where oro.order_id in inuOrdenPadre;
  rfultimaRelacion cuultimaRelacion%rowtype;

begin
  -- Test statements here
  WHILE nuFin <= 0 LOOP
  
    open cuRelacion(nuOrdenHija);
    fetch cuRelacion
      into rfRelacion;
    if cuRelacion%found then
      dbms_output.put_line('Orden Padre: ' || rfRelacion.Ordenpadre ||
                           ' Tipo Trabajo Padre ' || rfRelacion.Ttpadre ||
                           ' - Orden Hija: ' || rfRelacion.Ordenhija ||
                           ' Tipo Trabajo Hija ' || rfRelacion.Tthija ||
                           ' - Tipo Relacion: ' ||
                           rfRelacion.Rela_Order_Type_Id);
      nuOrdenHija  := rfRelacion.Ordenpadre;
      nuOrdenPadre := rfRelacion.Ordenhija;
    else
      nuFin := 1;
    end if;
    close cuRelacion;
  END LOOP;

end;
0
0
