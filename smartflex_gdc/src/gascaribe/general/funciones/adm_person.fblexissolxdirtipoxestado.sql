CREATE OR REPLACE FUNCTION ADM_PERSON.FBLEXISSOLXDIRTIPOXESTADO (inupackaddressid IN ab_address.address_id%TYPE,
                                                                 isbtagnames      IN VARCHAR2,
                                                                 inustatusid      IN mo_packages.motive_status_id%TYPE
) RETURN BOOLEAN IS
  /************************************************************************
   PROPIEDAD INTELECTUAL DE LUDYCOM S.A
   PROCEDIMIENTO   : fblExisSolXDirTipoXEstado
   AUTOR       : JERY ANN SILVERA DE LA RANS
   FECHA    : 24/05/2013
   DESCRIPCION  : Indica si existe una solicitud del tipo indicado, en la dirección y que esté
                  en el estado indicado
   PARÁMETROS:
      Parámetro       Descripción
      inuPackAddressId    Código de la dirección
      isbTagNames         Tags de los tipos de solicitud
      inuStatusId         Estado de la solicitud

  Historia de Modificaciones
  Autor         Fecha           Descripcion
  Ludycom       17-08-2013      se suprime el cursor cuSolXDirTipoXEst para usar un cursor dinamico.
  Adrianavg     20/02/2024      OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                Se ajusta cadena entrecomillada del FOR-SELECT del campo a.tag_name, ya que retornaba cursor inválido
  ************************************************************************/
  sbMensaje varchar2(300);
  --nuValPar        LD_FA_PARAGENE.PAGEVANU%type := NULL;
  --sbValPar        LD_FA_PARAGENE.PAGEVATE%type := NULL;
  inuIndex number;

  type tyrcSolXDirTipoXEst is record(
    nuAddressId ab_address.address_id%type,
    sbTagName   mo_packages.tag_name%type,
    nuStatusId  mo_packages.motive_status_id%type);
  type tytbSolXDirTipoXEst is table of tyrcSolXDirTipoXEst INDEX BY binary_integer;
  tbSolXDirTipoXEst tytbSolXDirTipoXEst;


  contador mo_packages.package_id%type;

  type r_cursor is REF CURSOR;
  registro r_cursor;

  campo mo_packages.package_id%type;

  BEGIN

  OPEN registro FOR 'SELECT a.package_id
                       FROM mo_packages a, mo_address b
                      WHERE a.package_id = b.package_id
                        AND b.parser_address_id = '||inupackaddressid||
                      ' AND a.motive_status_id = '|| inustatusid ||
                      ' AND a.tag_name in ('''||isbtagnames||''')';
  LOOP
    FETCH registro INTO campo;
    EXIT WHEN registro%notfound;
    RETURN TRUE;
  END LOOP;

  RETURN FALSE;

EXCEPTION
  --{
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;

  WHEN others THEN
    errors.seterror;
    RAISE EX.CONTROLLED_ERROR;
END FBLEXISSOLXDIRTIPOXESTADO; 
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FBLEXISSOLXDIRTIPOXESTADO
BEGIN
    pkg_utilidades.prAplicarPermisos('FBLEXISSOLXDIRTIPOXESTADO', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion FBLEXISSOLXDIRTIPOXESTADO
GRANT EXECUTE ON ADM_PERSON.FBLEXISSOLXDIRTIPOXESTADO TO REXEREPORTES;
/