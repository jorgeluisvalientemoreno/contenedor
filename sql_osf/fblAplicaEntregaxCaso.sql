declare
  isbNumeroCaso Varchar2(4000) := '0000858';--'200-2471';--'0000147';--'0000678';--'0000272';

  /**************************************************************************
    Autor       : Elkin Alvarez / Horbath
    Fecha       : 2019-02-15
    Ticket      : 200-2431
    Descripcion : retorna si la aplica o no la entrega por caso
  
    Parametros Entrada
    isbNumeroCaso numero de caso
  
    Valor de salida
      retorna 0 si espera pago o 1 sino espera
   sbErrorMessage mensaje de error.
  
    nuError  codigo del error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  --se valida aplicacion de entrega
  CURSOR cuAplicaEntrega IS
    Select a.Aplica
      From open.Ldc_Versionentrega t,
           open.Ldc_Versionempresa e,
           open.Ldc_Versionaplica  a,
           open.Sistema            s
     Where t.Codigo = a.Codigo_Entrega
       And e.Codigo = a.Codigo_Empresa
       And e.Nit = s.Sistnitc
       And T.Codigo =
           (SELECT max(t1.codigo)
              FROM open.Ldc_Versionentrega t1
             WHERE T1.Codigo_Caso like '%' || isbNumeroCaso || '%');

  -- Variables
  sbAplica Ldc_Versionaplica.Aplica%Type;

BEGIN

  -- Se abre el cursor para validar si aplica la entrega
  Open cuAplicaEntrega;
  Fetch cuAplicaEntrega
    Into sbAplica;
  Close cuAplicaEntrega;

  -- Si aplica la entrega se retorna True, sino aplica se retorna False
  If Nvl(sbAplica, 'N') = 'S' Then
    dbms_output.put_line('fblAplicaEntregaxCaso(' || isbNumeroCaso || ') --> Return True');
  Else
    dbms_output.put_line('fblAplicaEntregaxCaso(' || isbNumeroCaso || ') --> Return false');
  End If;

end;
