CREATE OR REPLACE FUNCTION LDC_FUNCVALNUMFOR(inudocument_type_id in mo_packages.document_type_id%type,
                                             inudocument_key     in mo_packages.document_key%type)
  RETURN NUMBER IS
  /**************************************************************************************
  Propiedad Intelectual de Gases del caribe S.A E.S.P
  
  Funcion     : LDC_FUNCVALNUMFOR - Validar numero de formulario
  Descripcion : Esta funci?n tiene como parametros de entrada el numero del formulario de la venta de gas realizada
                Si encuentra el numero del formulario con el tipo de formulario ya existten en al campo document_key y document_type_id
                de la entidad mo_packages
                entonces se devuelve el valor de uno (1)
                y si no se devuelve o cero (0).
  Autor       : Jorge Valiente
  Fecha       : 08/02/2023
  
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/

  nuExitNumeroFormulario number;

  cursor cuExitNumeroFormulario is
    SELECT COUNT(*)
      FROM open.mo_packages mp
     where mp.document_type_id = inudocument_type_id
       and mp.document_key = inudocument_key;

BEGIN

  open cuExitNumeroFormulario;
  fetch cuExitNumeroFormulario
    into nuExitNumeroFormulario;
  close cuExitNumeroFormulario;

  RETURN nuExitNumeroFormulario;

END;
/

GRANT EXECUTE on LDC_FUNCVALNUMFOR to SYSTEM_OBJ_PRIVS_ROLE;
/

GRANT EXECUTE on LDC_FUNCVALNUMFOR to RSELOPEN;
/

GRANT EXECUTE on LDC_FUNCVALNUMFOR to REPORTES;
/

