CREATE OR REPLACE PACKAGE adm_person.PKEXPREG is
  --  PRAGMA SERIALLY_REUSABLE;

  /************************************************************************
         PROPIEDAD INTELECTUAL DE Sincecomp Ltda. (C) 2008
         PROCEDIMIENTO  : pkExpReg
         AUTOR      : Héctor Terán Torres
         FECHA    : 07.feb.2008
         DESCRIPCION  :Varias Funciones con Expresión Regular
         Cuando se agregue una nueva función usar.

      /************************************************************************
      NOTA: Cuando  se agregue una nueva función agregar el  PRAGMA RESTRICT_REFERENCES(fsbObCad, WNDS);
      para que sea siendo un paqute con un buen nivel de puridad
      -- RESTRICT_REFERENCES Pragma is now deprecated 14.Mar.2008.

      ------------------------------
        Historia de Modificaciones
        Autor   Fecha         Req    Conse   Objeto        Descripción
        hrt     20.Feb.2008                                Creación
        hrt     08.sep.2009   34655                        Se agregan fblLike, fsbSubStr, fnuINSTR
        hrt     28.oct.2009   35845                        Se agrega la funcion fblIP
        Joncon  26.Abr.2011   1766     1     fsbObCadSep   Se crea la función para tener en cuenta los campos vacios
                                                           en el análisis de una expresión regular.
        PAcosta 15/07/2024                                 OSF-2885: Cambio de esquema ADM_PERSON                                                          
  */
  -------------------------------------------------
  --Constantes de Expresione regulares útiles

  function fsbObCad(IsbCad in varchar2,
                    IsbDel in varchar2,
                    InuIn  in number) return varchar2 DETERMINISTIC;
  --Inicio 1766(1)
  --Obtiene un campo en una cadena, determinado por un separador.
  function fsbObCadSep(IsbCad in varchar2,
                       IsbDel in varchar2,
                       InuIn  in number) return varchar2 DETERMINISTIC;
  --Fin 1766(1)

  --PRAGMA RESTRICT_REFERENCES(fsbObCad, WNDS);
  function fnuObCad(IsbCad in varchar2, IsbDel in varchar2) return integer
    DETERMINISTIC;
  function fblLike(vsbString varchar2, isbExp varchar2) return boolean
    DETERMINISTIC;
  function fsbSubStr(vsbString varchar2, isbExp varchar2, InuIn in number)
    return varchar2 DETERMINISTIC;
  function fnuINSTR(vsbString varchar2, isbExp varchar2) return number
    DETERMINISTIC;
  function fblIP(vsbString varchar2) return boolean DETERMINISTIC;

  function fblEsPar(inumber in number) return boolean deterministic;
  function fnuEsPar(inumber in number) return number deterministic;
  function fblEsImpar(inumber in number) return boolean deterministic;
  function fnuEsImpar(inumber in number) return number deterministic;

  --Verifica que la cadena pasada como parametro contenga solo número
  function fblSoloDigitos(vsbString varchar2) return boolean DETERMINISTIC;

  --  Obtiene el digito dela posicion pasada como parametro
  function fsbgetDig(IsbCad in varchar2, InuIn in number) return varchar2
    DETERMINISTIC;

  --  Obtiene la cantidad de digitos de un numero
  function fnugetNumOfDig(InuNum in varchar2) return integer;

end pkExpReg;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PKEXPREG IS
  SOLOLETRA  CONSTANT varchar2(14) := '^[[:alpha:]]+$'; --by hrt
  SOLONUMERO CONSTANT varchar2(14) := '^[[:digit:]]+$'; --by hrt
  PAR        CONSTANT varchar2(22) := '([:digit:]?)[02468]\1$'; --BY HRT
  IMPAR      CONSTANT varchar2(22) := '([:digit:]?)[13579]\1$'; --BY HRT
  IP CONSTANT varchar2(105) := '^(([1-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$';
  -- PRAGMA SERIALLY_REUSABLE;
  function fsbObCad(IsbCad in varchar2,
                    IsbDel in varchar2,
                    InuIn  in number) return varchar2 DETERMINISTIC is
    /************************************************************************
           PROPIEDAD INTELECTUAL DE Sincecomp Ltda. (C) 2008
           PROCEDIMIENTO  : fsbObCad
           AUTOR      : Héctor Terán Torres
           FECHA    : 07.feb.2008
           DESCRIPCION  : Extrae una subcadena entre un delimitador especial
          Parametros de Entrada
                         OsbCad   Cadena.
                         osbDel   Delimitador.
                         onuIn    Indice.
          Retorna la subcadena entre el delimitador especial.
          Ej: si la cadena es sbCad y el delimitador es '|' entonces
          sbCade varchar2(50):='LI|1010|Nombre|Apellido';
          fsbObCad(sbCade,'|',1)); return=>LI
          fsbObCad(sbCade,'|',2)); return=>1010
          fsbObCad(sbCade,'|',3)); return=>NOMBRE
          fsbObCad(sbCade,'|',4)); return=>APELLIDO
          fsbObCad(sbCade,'|',5)); return=>    'No devuelve Nada'


        /************************************************************************
          Historia de Modificaciones
          Autor   Fecha             REQ          Descripción
          hrt   20.Feb.2008                Creación
          hrt 14.Mar.2008                 La función ahora es deterministic porque
                                          RESTRICT_REFERENCES Pragma is deprecated.
    */
    --------------------------------------------------
  begin
    return REGEXP_SUBSTR(IsbCad, '[^' || IsbDel || ']+', 1, InuIn);
  exception
    when others then
      return null;
  end fsbObCad;
  function fnuObCad(IsbCad in varchar2, IsbDel in varchar2) return integer
    DETERMINISTIC is
    /************************************************************************
           PROPIEDAD INTELECTUAL DE Sincecomp Ltda. (C) 2008
           PROCEDIMIENTO  : fnuObCad
           AUTOR      : Héctor Terán Torres
           FECHA    : 09.Jul.2008
           DESCRIPCION  : Devuelve el Número de Veces en que una Cadena
           se encuntra entre un delimitador.
          Parametros de Entrada
                         OsbCad   Cadena.
                         osbDel   Delimitador.
          Retorna la subcadena entre el delimitador especial.
          Ej: si la cadena es sbCad y el delimitador es '|' entonces
          sbCade varchar2(50):='LI|1010|Nombre|Apellido';
          fnuObCad(sbCade,'|'); return=>4

          sbCade varchar2(50):='Nombre|Apellido';
          fnuObCad(sbCade,'|'); return=>2
          etc.
          Nota Cuando Se Actualice a ORACLE 11 Esta función es más eficiente con el REG_COUNT
        /************************************************************************
          Historia de Modificaciones
          Autor   Fecha             REQ          Descripción
          hrt   20.JUl.2008                Creación
    */
    --------------------------------------------------
    nuCont integer := 1;
  begin
    while fsbObCad(IsbCad, IsbDel, nuCont) is not null loop
      nuCont := nucont + 1;
    end loop;
    return nucont - 1;
  exception
    when others then
      return - 1;
  end fnuObCad;
  --------------------------------------------------------------------------
  function fsbObCadSep(IsbCad in varchar2,
                       IsbDel in varchar2,
                       InuIn  in number) return varchar2 DETERMINISTIC is
    /************************************************************************
       NOMBRE:       fsbObCadSep
       AUTOR:        Jonathan Consuegra
       FECHA:        26.Abr.2011
       DESCRIPCION:  Se modifica la expresión regular, para tener en cuenta
                     los campos vacios
       Parámetros


      HISTORIA DE MODIFICACIONES
      Autor   Fecha         Req    Conse   Descripción
      Joncon  26.Abr.2011   1766     1     Creación
    */
    --------------------------------------------------
    sbCad varchar2(500);
  begin

    sbCad := RTRIM(REGEXP_SUBSTR(IsbCad || IsbDel,
                                 '.*?\' || IsbDel,
                                 1,
                                 InuIn),
                   IsbDel);

    return sbCad;
  exception
    when others then
      return null;
  end fsbObCadSep;
  --------------------------------------------------------------------------
  function fblIP(vsbString varchar2) return boolean DETERMINISTIC is
    /************************************************************************
    PROPIEDAD INTELECTUAL DE Sincecomp Ltda. (C) 2008
    PROCEDIMIENTO  : fblIP
    AUTOR      : Héctor Terán Torres
    FECHA    : 28.oct.2009
    DESCRIPCION  : Valida direccion ip*/
  begin
    return REGEXP_LIKE(vsbString, IP);
  end fblIP;
  function fblLike(vsbString varchar2, isbExp varchar2) return boolean
    DETERMINISTIC is
  begin
    return REGEXP_LIKE(vsbString, isbExp, 'i');
  exception
    when others then
      return false;
  end fblLike;
  function fsbSubStr(vsbString varchar2, isbExp varchar2, InuIn in number)
    return varchar2 DETERMINISTIC is
  begin
    return REGEXP_SUBSTR(vsbString, isbExp, 1, InuIn);
  exception
    when others then
      return null;
  end fsbSubStr;
  function fnuInStr(vsbString varchar2, isbExp varchar2) return number
    DETERMINISTIC is
  begin
    return REGEXP_INSTR(vsbString, isbExp);
  exception
    when others then
      return 0;
  end;

  ---------------------------------------------------------------------------
  function fblEsPar(inumber in number) return boolean deterministic is
    /************************************************************************
           PROPIEDAD INTELECTUAL DE Sincecomp Ltda. (C) 2008
           PROCEDIMIENTO  : fblEsPar
           AUTOR      : Héctor Terán Torres
           FECHA    : 30.jun.2010
           DESCRIPCION  : Válida si un numero es Par
        /************************************************************************
          Historia de Modificaciones
          Autor   Fecha             REQ          Descripción
    */
    --------------------------------------------------
  begin
    return REGEXP_LIKE(inumber, PAR);
  exception
    when others then
      return false;
  end fblEsPar;
   --------------------------------------------------
  function fnuEsPar(inumber in number) return number deterministic is
  begin
    return sys.diutil.bool_to_int(fblEsPar(inumber));
  end fnuEsPar;
  --------------------------------------------------
  function fblEsImpar(inumber in number) return boolean deterministic is
    /************************************************************************
           PROPIEDAD INTELECTUAL DE Sincecomp Ltda. (C) 2008
           PROCEDIMIENTO  : fblEsImpar
           AUTOR      : Héctor Terán Torres
           FECHA    : 30.jun.2010
           DESCRIPCION  : Válida si un numero es Impar
        /************************************************************************
          Historia de Modificaciones
          Autor   Fecha             REQ          Descripción
    */
    --------------------------------------------------
  begin
    return REGEXP_LIKE(inumber, IMPAR);
  exception
    when others then
      return false;
  end fblEsImpar;
  --------------------------------------------------
  function fnuEsImpar(inumber in number) return number deterministic is
  begin
    return sys.diutil.bool_to_int(fblEsImpar(inumber));
  end fnuEsImpar;
  ---------------------------------------------------------------------------
  function fblSoloDigitos(vsbString varchar2) return boolean DETERMINISTIC is
  begin
    return REGEXP_LIKE(vsbString, SOLONUMERO);
  end fblSoloDigitos;
  function fnuSoloDigitos(vsbString varchar2) return NUMBER is
  begin
    return sys.diutil.bool_to_int(fblSoloDigitos(vsbString));
  end fnuSoloDigitos;
  ---------------------------------------------------------------------------
  function fsbgetDig(IsbCad in varchar2, InuIn in number) return varchar2
    DETERMINISTIC is
    --------------------------------------------------
  begin
    return REGEXP_SUBSTR(IsbCad, '[^:digit:]?', 1, InuIn);
  exception
    when others then
      return null;
  end fsbgetDig;
  ---------------------------------------------------------------------------
  function fnugetNumOfDig(InuNum in varchar2) return integer is
    nuCont integer := 1;
  begin
    while fsbgetDig(InuNum, nuCont) is not null loop
      nuCont := nucont + 1;
    end loop;
    return nucont - 1;
  exception
    when others then
      return - 1;
  end fnugetNumOfDig;
  ---------------------------------------------------------------------------

end pkExpReg;
/
PROMPT Otorgando permisos de ejecucion a PKEXPREG
BEGIN
    pkg_utilidades.praplicarpermisos('PKEXPREG', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre PKEXPREG para reportes
GRANT EXECUTE ON adm_person.PKEXPREG TO rexereportes;
/
