CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUGETNUMBEREXPACCOUNTS" (nuproduc_id  in PR_PRODUCT.PRODUCT_ID%type) RETURN NUMBER IS
/**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :  LDC_FnuGetNumberExpAccounts
    Descripcion :
    Autor       : Emiro Leyva
    Fecha       : 12-09-2013

    Historia de Modificaciones
      Fecha               Autor                Modificación
    =========           =========          ====================
    12-09-2013          emirol              Creación.

    **************************************************************************/

   nuResultado      number;
   ounError         number(6);
   sbMens           varchar2(200);
begin
    pkServNumber.GetNumberExpAccounts(nuproduc_id,nuResultado,ounError,sbMens);
	return(nuResultado);
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETNUMBEREXPACCOUNTS', 'ADM_PERSON');
END;
/