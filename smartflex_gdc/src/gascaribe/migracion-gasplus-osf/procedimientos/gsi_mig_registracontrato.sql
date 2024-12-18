CREATE OR REPLACE PROCEDURE      "GSI_MIG_REGISTRACONTRATO" (
   ionusubscription_id      IN OUT suscripc.susccodi%TYPE,
   inusubscriber_id         IN     suscripc.suscclie%TYPE,
   inusubscription_type     IN     suscripc.susctisu%TYPE,
   isbmoney_type            IN     suscripc.susctimo%TYPE,
   inubilling_cycle_id      IN     suscripc.susccicl%TYPE,
   inubank                  IN     suscripc.suscbanc%TYPE,
   inubranch                IN     suscripc.suscsuba%TYPE,
   isbbankaccount           IN     suscripc.susccuco%TYPE,
   inubankaccounttype       IN     suscripc.susctcba%TYPE,
   inucollectaddressid      IN     suscripc.susciddi%TYPE,
   idtcreditcardexpiredat   IN     suscripc.suscvetc%TYPE,
   isbcardtype              IN     suscripc.suscttpa%TYPE,
   isbcostcenter            IN     suscripc.suscceco%TYPE,
   isbtipodireccioncobro    IN     suscripc.susctdco%TYPE,  --'VT' o 'DA'
   isbelectchargeadr        IN     suscripc.suscdeco%TYPE,
   inucardowneridentty      IN     suscripc.susctitt%TYPE,
   isbcardownerident        IN     suscripc.suscidtt%TYPE,
   isbsuscriptionmail       IN     suscripc.suscmail%TYPE,
   inuchargeentity          IN     suscripc.suscenco%TYPE,
   inuchargeprogram         IN     suscripc.suscprca%TYPE,
   inupositivebalance       IN     suscripc.suscsafa%TYPE,
   inususccoem              IN     suscripc.susccoem%TYPE,
   inususccemf              IN     suscripc.susccemf%TYPE,
   inususccemd              IN     suscripc.susccemd%TYPE,
   inususcefce              in     SUSCRIPC.SUSCEFCE%type,
   onuerrorcode                OUT ge_error_log.error_log_id%TYPE,
   osberrormessage             OUT ge_error_log.description%TYPE)
IS
   /*
    Nombre objeto      gsi_mig_registracontrato
    Proposito          Creacion de cliente tabla suscripc.

    Historial
    Fecha           Modificacion        Autor
    2012-01-31      Creacion            Wospina
    2012-11-26      Modificacion        Wospina, se cambia para compatibilidad de version 7.07.001.
                                        Se elimina el campo SUSCPROC, existente en versiones anteriores a 7.07.
    2013-02-13      Modificacion        Wospina, se cambia para compatibilidad de version 7.07.002.
                                        Se agrega el campo susccoem, creado en version    7.07.002

    2013-04-02                          PDELAPENA: Se agregan parametros de entrada para sucursales bancarias debido a no
                                                   estaba siendo utilizado el campo de tipo de dirección de cobro.
                                                   Se llena el  parametro de salida con la descripción del error de
                                                   oracle para el caso de errores no controlados osberrormessage:=SQLERRM

    2013-04-17                          PDELAPENA: Se agrega parámetro de entrada inususccoem para llenar el campo susccoem

   */
   rcsuscripc   suscripc%ROWTYPE;
   nususccodi   suscripc.susccodi%TYPE;
   nususctisu   suscripc.susctisu%TYPE;
   nususccicl   suscripc.susccicl%TYPE;
   nususcnupr   suscripc.suscnupr%TYPE;
   --sbsuscproc   suscripc.suscproc%TYPE;
   nususciddi   suscripc.susciddi%TYPE;
   sbsusctimo   suscripc.susctimo%TYPE;
   sbsuscdeta   suscripc.suscdeta%TYPE;
   sbsuscceco   suscripc.suscceco%TYPE;
   nususccemf   suscripc.susccemf%TYPE;
   nususccemd   suscripc.susccemd%TYPE;
   sbsusctdco   suscripc.susctdco%TYPE;
   nususcbanc   suscripc.suscbanc%TYPE;
   sbsuscsuba   suscripc.suscsuba%TYPE;
   sbsusccuco   suscripc.susccuco%TYPE;
   nususctcba   suscripc.susctcba%TYPE;
   dtsuscvetc   suscripc.suscvetc%TYPE;
   sbsuscttpa   suscripc.suscttpa%TYPE;
   nususcbapa   suscripc.suscbapa%TYPE;
   sbsuscsbbp   suscripc.suscsbbp%TYPE;
   nususctcbp   suscripc.susctcbp%TYPE;
   sbsusccubp   suscripc.susccubp%TYPE;
   sbsuscdeco   suscripc.suscdeco%TYPE;
   nususcclie   suscripc.suscclie%TYPE;
   nususcsist   suscripc.suscsist%TYPE;
   sbsuscefce   suscripc.suscefce%TYPE;
   nususctitt   suscripc.susctitt%TYPE;
   sbsuscidtt   suscripc.suscidtt%TYPE;
   sbsuscmail   suscripc.suscmail%TYPE;
   nususcenco   suscripc.suscenco%TYPE;
   nususcprca   suscripc.suscprca%TYPE;
   nususcsafa   suscripc.suscsafa%TYPE;
   nususccoem   suscripc.susccoem%TYPE;

BEGIN
   --{
   IF (ionusubscription_id IS NULL)
   THEN
      ionusubscription_id :=
         pkgeneralservices.fnugetnextsequenceval ('SEQ_MO_SUBSCRIPTION');
   END IF;

   nususccodi := ionusubscription_id;
   nususctisu := inusubscription_type;
   nususccicl := inubilling_cycle_id;
   nususcnupr := 0;
   --sbsuscproc := 'N';
   nususciddi := inucollectaddressid;
   sbsusctimo := '--';                                        -- isbMoney_Type
   sbsuscdeta := 'N';
   sbsuscceco := isbcostcenter;
 --  nususccemf := NULL;
 --  nususccemd := NULL;
   sbsusctdco := isbtipodireccioncobro;
   nususcbanc := inubank;
   sbsuscsuba := inubranch;
   sbsusccuco := isbbankaccount;
   nususctcba := inubankaccounttype;
   dtsuscvetc := idtcreditcardexpiredat;
   sbsuscttpa := isbcardtype;
   nususcbapa := NULL;
   sbsuscsbbp := NULL;
   nususctcbp := NULL;
   sbsusccubp := NULL;
   sbsuscdeco := isbelectchargeadr;
   nususcclie := inusubscriber_id;
   nususcsist := 99;
   sbsuscefce := inususcefce;
   nususctitt := inucardowneridentty;
   sbsuscidtt := isbcardownerident;
   sbsuscmail := isbsuscriptionmail;
   nususcenco := inuchargeentity;
   nususcprca := inuchargeprogram;
   nususcsafa := inupositivebalance;
   --nususccoem := NULL;
   nususccoem := inususccoem;
   nususccemf := inususccemf;
   nususccemd := inususccemd;

   -- Valores por defecto especificados con cliente LDC

   INSERT INTO suscripc
        VALUES (nususccodi,
                nususctisu,
                nususccicl,
                nususcnupr,
                --sbsuscproc,
                nususciddi,
                sbsusctimo,
                sbsuscdeta,
                sbsuscceco,
                nususccemf,
                nususccemd,
                sbsusctdco,
                nususcbanc,
                sbsuscsuba,
                sbsusccuco,
                nususctcba,
                dtsuscvetc,
                sbsuscttpa,
                nususcbapa,
                sbsuscsbbp,
                nususctcbp,
                sbsusccubp,
                sbsuscdeco,
                nususcclie,
                nususcsist,
                sbsuscefce,
                nususctitt,
                sbsuscidtt,
                sbsuscmail,
                nususcenco,
                nususcprca,
                nususcsafa,
                nususccoem
                );

   -------------pktblSuscripc.insrecord (rcSuscripc);


EXCEPTION
   WHEN ex.controlled_error
   THEN
      errors.geterror (onuerrorcode, osberrormessage);
      ut_trace.trace ('Fallo Creacion de Contrato: ' || nususccodi, 5);
   WHEN OTHERS
   THEN
      errors.seterror;
      errors.geterror (onuerrorcode, osberrormessage);
      ut_trace.trace ('Fallo Creacion de Contrato: ' || nususccodi, 5);
      osberrormessage:=SQLERRM;
END; 
/
