DECLARE
  --CREATE OR REPLACE function OPEN.fblAplicaEntrega(isbEntrega In Varchar2) return boolean is
  isbEntrega Varchar2(4000) := 'OSS_OYM_DSS_200_2470_4';
  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GASES DEL CARIBE E.S.P.
  
  UNIDAD         : fblAplicaEntrega
  DESCRIPCION    : Funcion usada para verificar si una entrega aplica para la empresa.
  AUTOR          : JVivero (LUDYCOM)
  CASO           : 100-10465
  FECHA          : 08/03/2016
  
  PARAMETROS            DESCRIPCION
  ============      ===================
  isbEntrega        Nombre de la entrega
  
  FECHA             AUTOR                   MODIFICACION
  ==========        =========               ====================
  08/03/2016        JVivero (LUDYCOM)       CreaciOn.
  ******************************************************************/

  -- Cursor para consultar si la entrega aplica para la gasera
  Cursor Cu_Aplica Is
    Select a.Aplica
      From open.Ldc_Versionentrega t,
           open.Ldc_Versionempresa e,
           open.Ldc_Versionaplica  a,
           open.Sistema            s
     Where t.Codigo = a.Codigo_Entrega
       And e.Codigo = a.Codigo_Empresa
       And e.Nit = s.Sistnitc
       And t.Nombre_Entrega = isbEntrega;

  -- Variables
  sbAplica Ldc_Versionaplica.Aplica%Type;

BEGIN

  -- Se abre el cursor para validar si aplica la entrega
  Open Cu_Aplica;
  Fetch Cu_Aplica
    Into sbAplica;
  Close Cu_Aplica;

  -- Si aplica la entrega se retorna True, sino aplica se retorna False
  If Nvl(sbAplica, 'N') = 'S' Then
  
    dbms_output.put_line('Entrega ' || isbEntrega || ' - Return True');
  
  Else
  
    dbms_output.put_line('Entrega ' || isbEntrega || ' - Return False');
  
  End If;

END;
