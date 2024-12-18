CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKWEBSERVUTILS AS  -- spec
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_pkWebServUtils.pks
 * Tiquete : 143105
 * Autor   : Carlos Virgen
 * Fecha   : 18/05/2011
 * Descripcion : Definicion de paquete de utilidades generales de web services
 *
 * Historia de Modificaciones
 * Autor          Fecha  Descripcion
**/

   --Definicion de procedimietno
 PROCEDURE proCaraServWeb(vCaseDese in  LDCI_CARASEWE.CASECODI%type,
                          vCaseCodi in  LDCI_CARASEWE.CASECODI%type,
                          vCaseValo out LDCI_CARASEWE.CASEVALO%type,
                          sbMens    out varchar2);

Procedure Procrearerrorlogint(Sbnombreint In LDCI_Logiint.Loginoin%Type,
                             Sbtipoint  In LDCI_Logiint.Logitipo%Type ,
                             Sberror In LDCI_Logiint.Logierro%Type,
                             Clmensaje In LDCI_Logiint.Logimens%Type);

Procedure Procrearerrorlogint(Sbnombreint In LDCI_Logiint.Loginoin%Type,
                             Sbtipoint  In LDCI_Logiint.Logitipo%Type ,
                             Sberror In LDCI_Logiint.Logierro%Type,
                             Clmensaje In LDCI_Logiint.Logimens%Type,
                             sbInco in LDCI_Logiint.LOGIINCO%type);

END LDCI_PKWEBSERVUTILS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKWEBSERVUTILS AS  -- body

PROCEDURE proCaraServWeb(vCaseDese in  LDCI_CARASEWE.CASECODI%type,
                         vCaseCodi in  LDCI_CARASEWE.CASECODI%type,
                         vCaseValo out LDCI_CARASEWE.CASEVALO%type,
                         sbMens    out varchar2 )IS
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : proCaraServWeb.prc
 * Tiquete : 143105
 * Autor   : OLSoftware / Carlos E. Virgen
 * Fecha   : 18/05/2011
 * Descripcion : Realiza la carga de los parametros o caracteristas de un servicio web
 *
 * Parametros
 *vCaseDese in  LDCI_CARASEWE.CASECODI%type,
                                           vCaseCodi in  LDCI_CARASEWE.CASECODI%type,
                                           vCaseValo out LDCI_CARASEWE.CASECODI%type,
                                           sbMens    out varchar2
 * Historia de Modificaciones
 * Autor          Fecha         Descripcion
 * hectorfdv      05-11-2013    Se coloca pragma autonumus en los procedimientos Procrearerrorlogint
 *                              Para evitar que otro llamado reverse la insercion.
**/

 --Cursor de la caracteristica del web services
 cursor cuLdcCaraSewe (vCaseDese1 in  LDCI_CARASEWE.CASECODI%type,
                      vCaseCodi1 in  LDCI_CARASEWE.CASECODI%type) is
    select CASEVALO
      from LDCI_CARASEWE
     where CASECODI = vCaseCodi1
       and CASEDESE = vCaseDese1;
BEGIN
  --Hace la carga del cursor de caracteristicas
  open cuLdcCaraSewe(vCaseDese, vCaseCodi);
  fetch cuLdcCaraSewe into vCaseValo;
  if (cuLdcCaraSewe%notfound) then
      close cuLdcCaraSewe;
      sbMens := '-1| No se ha encontrado la caracteristica ' || vCaseDese || ' - ' || vCaseCodi;
      return;
  end if;--if (cuLdcCaraSewe%notfound) then
  close cuLdcCaraSewe;
  sbMens := '0';
EXCEPTION
  WHEN OTHERS THEN
      	--sbMens := '-1| No se ha encontrado la caracteristica ' || vCaseDese || ' - ' || vCaseCodi || replace(Fsbmensaje(92), '<ObjBD>', 'proCaraServWeb') || SQLERRM;
       sbMens := '-1| No se ha encontrado la caracteristica ' || vCaseDese || ' - ' || vCaseCodi || ' proCaraServWeb' || SQLERRM;
END proCaraServWeb;


Procedure Procrearerrorlogint(Sbnombreint In LDCI_Logiint.Loginoin%Type,
                             Sbtipoint  In LDCI_Logiint.Logitipo%Type ,
                             Sberror In LDCI_Logiint.Logierro%Type,
                             Clmensaje In LDCI_Logiint.Logimens%Type) As
 PRAGMA AUTONOMOUS_TRANSACTION;
Begin

  --cargar el consecutivo
    Insert Into LDCI_Logiint (Logicodi, Logifech, Loginoin,Logitipo, Logierro, Logimens, Logiesta) Values
    (LDCI_SEQLOGI.NEXTVAL, SYSDATE, Sbnombreint, Sbtipoint, Sberror, Clmensaje, '1');
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
End Procrearerrorlogint;

Procedure Procrearerrorlogint(Sbnombreint In LDCI_Logiint.Loginoin%Type,
                             Sbtipoint  In LDCI_Logiint.Logitipo%Type ,
                             Sberror In LDCI_Logiint.Logierro%Type,
                             Clmensaje In LDCI_Logiint.Logimens%Type,
                             sbInco in LDCI_Logiint.LOGIINCO%type) As
 PRAGMA AUTONOMOUS_TRANSACTION;
Begin

  --cargar el consecutivo
    Insert Into LDCI_Logiint (Logicodi, Logifech, Loginoin,Logitipo, Logierro, Logimens, Logiesta, Logiinco) Values
    (LDCI_Seqlogi.Nextval, Sysdate, Sbnombreint, Sbtipoint, Sberror, Clmensaje, '1', sbInco);
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
End Procrearerrorlogint;

END LDCI_PKWEBSERVUTILS;
/


PROMPT Asignación de permisos para el método LDCI_PKWEBSERVUTILS
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKWEBSERVUTILS', 'ADM_PERSON');
end;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKWEBSERVUTILS to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKWEBSERVUTILS to INTEGRADESA;
/
