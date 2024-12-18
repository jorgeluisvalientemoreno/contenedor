create or replace procedure ADM_PERSON.PRANULASOLINEGO(inusolicitud in number) is
 /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: prAnulaSoliNego
    Descripcion: proceso para marcar solciitudes de negociacion a Anular
    Autor    : Luis Javier Lopez Barrios / Horbath
    Fecha    : 27/05/2022

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
 ******************************************************************/
  pragma AUTONOMOUS_TRANSACTION;
begin
 insert into ldc_solinean (solicitud, fecha, estado)
  values(inusolicitud, sysdate, 'P');
  commit;
end prAnulaSoliNego;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('PRANULASOLINEGO', 'ADM_PERSON');
END;
/
