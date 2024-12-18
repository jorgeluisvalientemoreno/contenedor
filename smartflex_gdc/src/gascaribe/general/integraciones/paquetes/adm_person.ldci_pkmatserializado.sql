CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKMATSERIALIZADO AS
/*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   FUNCION    : LDCI_PKMATSERIALIZADO.pks
   AUTOR      : OLSoftware / Carlos E. Virgen
   FECHA      : 02/03/2012
   TIQUETE    : 161461
   DESCRIPCION: Recibe una cadena de caracteres, la procesa y
                determina los siguientes campos:
                +------------------------------------------------------------+
                |Archivo de Proveedores Con Materiales Serializados con      |
                |Unidades de ManipulaciÃ³n                                    |
                +------------------------------------------------------------+
                |                      Sistema legado          SAP          |
                |Campo                PosiciÃ³n Longitud  PosiciÃ³n Longitud |
                +------------------------------------------------------------+
                |Marca                   1        2         1        2     |
                |Serial                  3        7         3        18    |
                |Ano                     10      2         21      2     |
                |UM/Caja                 12      10         23      20    |
                |Referencia x Marca      22        2         43      2     |
                |Tipo Entrada            24        2         45      2     |
                +------------------------------------------------------------+


  Historia de Modificaciones
  Autor     Fecha      Descripcion
  carlosvl 02/03/2012  Version inicial
*/
-- Procedimientos
-- Limpia la variables globales
procedure proLimpiaValores;
-- Procedimiento que recibe una cadena de caracteres
procedure proSetSerie(sbEstrSeri in  VARCHAR2,
                      sbMesg     out VARCHAR2);

-- Funciones
-- Retorna la estructura de serial procesada
function fsbGetEstr  return VARCHAR2;
-- Retorna la marca
function fsbGetMarca  return VARCHAR2;
--Retorna serial
function fsbGetSerial  return VARCHAR2;
-- Retorna ano
function fsbGetAno  return VARCHAR2;
-- Retorna caja
function fsbGetCaja  return VARCHAR2;
-- Retorna Referencia por marca
function fsbRefMarc  return VARCHAR2;
-- Retorna tipo de entrada
function fsbTipoEnt  return VARCHAR2;


END LDCI_PKMATSERIALIZADO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKMATSERIALIZADO AS
/*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   FUNCION    : LDCI_PKMATSERIALIZADO.pks
   AUTOR      : OLSoftware / Carlos E. Virgen
   FECHA      : 15/02/2012
   TIQUETE    : 161461
   DESCRIPCION: Calcula los valores de los items para las Reservas / Pedidos

  Historia de Modificaciones
  Autor     Fecha      Descripcion
*/
  -- Define variables
  sbEstr    VARCHAR2(46); -- Estructura
  sbMarca   VARCHAR2(2);  -- Marca
  sbSerial  VARCHAR2(18);  -- Serial
  sbAno     VARCHAR2(2);  -- Ano
  sbCaja    VARCHAR2(20); -- Caja
  sbRefMarc VARCHAR2(2);  -- Referenca por Marca
  sbTipoEnt VARCHAR2(2);  -- Tipo de entrada

  procedure proLimpiaValores is
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKMATSERIALIZADO.proLimpiaValores
     AUTOR      : OLSoftware / Carlos E. Virgen
     FECHA      : 15/02/2012
     TIQUETE    : 161461
     DESCRIPCION: Inicializa las variable globales en cero

    Historia de Modificaciones
    Autor     Fecha      Descripcion
  */
  begin
    LDCI_PKMATSERIALIZADO.sbEstr     := NULL; -- Estructura
    LDCI_PKMATSERIALIZADO.sbMarca    := NULL; -- Marca
    LDCI_PKMATSERIALIZADO.sbSerial   := NULL; -- Serial
    LDCI_PKMATSERIALIZADO.sbAno      := NULL; -- Ano
    LDCI_PKMATSERIALIZADO.sbCaja     := NULL; -- Caja
    LDCI_PKMATSERIALIZADO.sbRefMarc  := NULL; -- Referenca por Marca
    LDCI_PKMATSERIALIZADO.sbTipoEnt  := NULL; -- Tipo de entrada
  end proLimpiaValores;

  procedure proSetSerie(sbEstrSeri in  VARCHAR2,
                        sbMesg     out VARCHAR2) is
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKMATSERIALIZADO.fnuCalValItemPedido
     AUTOR      : OLSoftware / Carlos E. Virgen
     FECHA      : 15/02/2012
     TIQUETE    : 161461
     DESCRIPCION: Recibe una cadena de caracteres

    Historia de Modificaciones
    Autor     Fecha      Descripcion
    carlosvl  28-07-2014   Se le adiciona manejo de las letras de los
                           medidores.
    carlosvl  02-03-2015   138682: Se adiciona la validacion de que la marca exista.
  */
  -- Variables
  nuSerial NUMBER;

  -- Cursores
  cursor cuMarca (nuMarca LDCI_MARCA.MARCCODI%type) is
				select NVL(MARCLEMA,TO_CHAR(MARCCODI))
						from   LDCI_MARCA
					where  MARCCODI = nuMarca;

  cursor cuRefMarca(inuMarca LDCI_MARCA.MARCCODI%type, inuRefMarca LDCI_REMEMARC.RMMACODI%type) is --138682: Cursor de la referencia por marca
	SELECT MARCCODI MARCA, MARCDESC DESCRIPCION, RMMACODI REF_MARCA, RMMANDME TOPE
	 from open.LDCI_MARCA, open.LDCI_REMEMARC
	where RMMAMARC =  MARCCODI
	  and MARCCODI = inuMarca
	  and RMMACODI = inuRefMarca;

  -- Excepciones
  exceEstrSeriNull    EXCEPTION;
  exceEstrSeriValLong EXCEPTION;
  exceRefMarc         EXCEPTION;--138682: Excepcion de la referneica por marca
  exceLetraMarc       EXCEPTION;
  errorPara01         EXCEPTION;


  sbLetra          LDCI_MARCA.marclema%type;
  nuCodigoMarca    LDCI_MARCA.MARCCODI%type;
  nuCodRefMarca    LDCI_REMEMARC.RMMACODI%type;--138682: Código de la refrencia por marca
  reRefMarca       cuRefMarca%rowtype;         --138682: Registro de la referencia por marca
  sbFORMATO_SERIAL LDCI_CARASEWE.CASEVALO%type;
  begin

	LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_MOVIMIENTO_MATERIAL', 'FORMATO_SERIAL', sbFORMATO_SERIAL, sbMesg);
	if(sbMesg != '0') then
	 RAISE errorPara01;
	end if;--if(sbMesg != '0') then

	sbMesg := null;	--138682: Se inicializa la variable de salida

    -- Se valida que el campo no sea nulo
    if (sbEstrSeri is null or sbEstrSeri = '') then
       RAISE exceEstrSeriNull;
    end if;-- if (sbEstrSeri is null or sbEstrSeri = '') then

    -- Valida la longitud de la cadena
    if (LENGTH(sbEstrSeri) < 45) then
     --RAISE exceEstrSeriValLong;
     null;
    end if;-- if (LENGTH(sbEstrSeri) < 45)

    -- Se Estructura
    LDCI_PKMATSERIALIZADO.sbEstr := sbEstrSeri;

    -- Determina la marca
    LDCI_PKMATSERIALIZADO.sbMarca   := substr(sbEstrSeri, 1, 2);

    nuCodigoMarca := to_number(LDCI_pkMatSerializado.sbMarca);	-- determina el id de la marca para consultar la letra
    -- Se obtiene la letra correspondiente a la marca
    open cuMarca (nuCodigoMarca);
    fetch cuMarca into sbLetra;
    if (cuMarca%notfound) then
       close cuMarca;
       RAISE exceLetraMarc;
    end if;
    close cuMarca;

    -- Determina el ano
    LDCI_PKMATSERIALIZADO.sbAno     := substr(sbEstrSeri, length(sbEstrSeri) - 5, 2);

    -- Determina la caja
    -- LDCI_PKMATSERIALIZADO.sbCaja    := substr(sbEstrSeri, 23, 20);

    -- Determina referencia por marca
    LDCI_PKMATSERIALIZADO.sbRefMarc    := substr(sbEstrSeri, length(sbEstrSeri) - 3, 2);

	/*nuCodRefMarca := to_number(LDCI_PKMATSERIALIZADO.sbRefMarc);--138682: Código de la refrencia por marca
	open cuRefMarca (nuCodigoMarca, nuCodRefMarca); --138682: Abre el cursor de la referencia por marca
    fetch cuRefMarca into reRefMarca;
    if (cuRefMarca%notfound) then
       close cuRefMarca;
       RAISE exceRefMarc;
    end if;
    close cuRefMarca;*/

    -- Determina referencia por marca
    LDCI_PKMATSERIALIZADO.sbTipoEnt    := substr(sbEstrSeri, length(sbEstrSeri) - 1, 2);

    if (sbFORMATO_SERIAL = 'N') then
							-- Determina el numero de serie
							LDCI_PKMATSERIALIZADO.sbSerial  := substr(sbEstrSeri, 1, length(sbEstrSeri) - 4);
				else
      if (sbFORMATO_SERIAL = 'S') then
									LDCI_pkMatSerializado.sbSerial  := sbLetra ||'-'|| substr(sbEstrSeri, 3, (length(sbEstrSeri)-2) - 6) ||'-'||LDCI_pkMatSerializado.sbAno;
      end if;--if (sbFORMATO_SERIAL = 'S') then
    end if;--if (sbFORMATO_SERIAL = 'N') then


  exception
   when exceEstrSeriNull then
      sbMesg :=  '<proSetSerie> Error procesando el numero de serie, el campo no debe de ser nulo. ';

   when exceLetraMarc then
      sbMesg :=  '<proSetSerie> Error procesando el numero de serie, no existe letra para la marca. '|| LDCI_pkMatSerializado.sbMarca;

   when exceRefMarc then
      sbMesg :=  '<proSetSerie> Error procesando el numero de serie, no existe refrencia '|| LDCI_pkMatSerializado.sbRefMarc || ', para la marca ' || LDCI_pkMatSerializado.sbMarca;

    When Errorpara01 then
      sbMesg := '<proSetSerie> proCargaVarGlobal : Cargando el parametro : ' || sbMesg;

   when exceEstrSeriValLong then
      sbMesg :=  '<proSetSerie> Error procesando el numero de serie, longitud de la cadena incorrecta (Longitud calculada '|| LENGTH(sbEstrSeri) ||'). '|| DBMS_UTILITY.format_error_backtrace;

   when INVALID_NUMBER then
      sbMesg :=  '<proSetSerie> Error procesando el numero de serie, la cadena contiene caracter invalido. ' || SQLCODE || ' -ERROR- ' || SQLERRM || ' -TRACE- ' || DBMS_UTILITY.format_error_backtrace;

   when others then
      sbMesg :=  '<proSetSerie> Error procesando el numero de serie: - ' || SQLCODE || ' -ERROR- ' || SQLERRM || ' -TRACE- ' || DBMS_UTILITY.format_error_backtrace;
  end proSetSerie;

  function fsbGetEstr return VARCHAR2 is
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKMATSERIALIZADO.fsbGetEstr
     AUTOR      : OLSoftware / Carlos E. Virgen
     FECHA      : 15/02/2012
     TIQUETE    : 161461
     DESCRIPCION: Retorna la cadena procesada

    Historia de Modificaciones
    Autor     Fecha      Descripcion
  */
  begin
    -- Retorna la estrcutura de serial procesada
    return LDCI_PKMATSERIALIZADO.sbEstr;
  end fsbGetEstr;

  function fsbGetMarca return VARCHAR2 is
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKMATSERIALIZADO.fsbGetMarca
     AUTOR      : OLSoftware / Carlos E. Virgen
     FECHA      : 15/02/2012
     TIQUETE    : 161461
     DESCRIPCION: Retorna la marca

    Historia de Modificaciones
    Autor     Fecha      Descripcion
  */
  begin
    -- Retorna la estrcutura de serial procesada
    return LDCI_PKMATSERIALIZADO.sbMarca;
  end fsbGetMarca;

  function fsbGetSerial return VARCHAR2 is
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKMATSERIALIZADO.fsbGetSerial
     AUTOR      : OLSoftware / Carlos E. Virgen
     FECHA      : 15/02/2012
     TIQUETE    : 161461
     DESCRIPCION: Construye el serial y lo retorna

    Historia de Modificaciones
    Autor     Fecha      Descripcion
  */
  sbSerialOut varchar(18);
  begin
    -- sbSerialOut := LDCI_PKMATSERIALIZADO.sbMarca || LDCI_PKMATSERIALIZADO.sbSerial || LDCI_PKMATSERIALIZADO.sbAno || LDCI_PKMATSERIALIZADO.sbRefMarc || LDCI_PKMATSERIALIZADO.sbTipoEnt;
    -- Se arama la cadena del serial
    --sbSerialOut := LDCI_PKMATSERIALIZADO.sbMarca || LDCI_PKMATSERIALIZADO.sbSerial || LDCI_PKMATSERIALIZADO.sbAno;
    -- Retorna la estrcutura de serial procesada
    return LDCI_PKMATSERIALIZADO.sbSerial;
  end fsbGetSerial;

  function fsbGetAno return VARCHAR2 is
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKMATSERIALIZADO.fsbGetAno
     AUTOR      : OLSoftware / Carlos E. Virgen
     FECHA      : 15/02/2012
     TIQUETE    : 161461
     DESCRIPCION: Retorna ano

    Historia de Modificaciones
    Autor     Fecha      Descripcion
  */
  begin
    -- Retorna ano
    return LDCI_PKMATSERIALIZADO.sbAno;
  end fsbGetAno;

  function fsbGetCaja return VARCHAR2 is
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKMATSERIALIZADO.fsbGetCaja
     AUTOR      : OLSoftware / Carlos E. Virgen
     FECHA      : 15/02/2012
     TIQUETE    : 161461
     DESCRIPCION: Retorna caja

    Historia de Modificaciones
    Autor     Fecha      Descripcion
  */
  begin
    -- Retorna caja
    return LDCI_PKMATSERIALIZADO.sbCaja;
  end fsbGetCaja;

  function fsbRefMarc return VARCHAR2 is
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKMATSERIALIZADO.fsbRefMarc
     AUTOR      : OLSoftware / Carlos E. Virgen
     FECHA      : 15/02/2012
     TIQUETE    : 161461
     DESCRIPCION: Retorna referencia por marca

    Historia de Modificaciones
    Autor     Fecha      Descripcion
  */
  begin
    -- Retorna referencia por marca
    return LDCI_PKMATSERIALIZADO.sbRefMarc;
  end fsbRefMarc;

  function fsbTipoEnt return VARCHAR2 is
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKMATSERIALIZADO.fsbTipoEnt
     AUTOR      : OLSoftware / Carlos E. Virgen
     FECHA      : 15/02/2012
     TIQUETE    : 161461
     DESCRIPCION: Retorna tipo de entrada

    Historia de Modificaciones
    Autor     Fecha      Descripcion
  */
  sbTien VARCHAR2(1);
  begin
    -- Retorna tipo de entrada
    if (LDCI_PKMATSERIALIZADO.sbTipoEnt = '01') then
      sbTien := 'I';
    else
      sbTien := 'D';
    end if;--if (LDCI_PKMATSERIALIZADO.sbTipoEnt = '01') then

    return sbTien;
  end fsbTipoEnt;
END LDCI_PKMATSERIALIZADO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKMATSERIALIZADO', 'ADM_PERSON');
END;
/