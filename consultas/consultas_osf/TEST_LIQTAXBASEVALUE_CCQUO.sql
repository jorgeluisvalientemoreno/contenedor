-- Created on 15/11/2023 by JORGE VALIENTE 
declare

  --rfservsusc record;

  cursor cuSERVSUSC is
    select a.* from open.servsusc a where a.sesunuse = 52687671;

  RCSERVSUSC cuSERVSUSC%ROWTYPE;

  NUVALOR          NUMBER;
  NUCONCEPT        NUMBER;
  SBDOCUMENT       CARGOS.CARGDOSO%TYPE;
  NUPROGRAM        CARGOS.CARGPROG%TYPE;
  NUIDPACKAGE      NUMBER;
  NUIDMOTIVE       NUMBER;
  RCSERVSUSC       SERVSUSC%ROWTYPE;
  RCPERIFACT       PERIFACT%ROWTYPE;
  SBEXEMODE        VARCHAR2(1);
  NUPERIACTU       PERICOSE.PECSCONS%TYPE;
  NUPERIPROC       PERICOSE.PECSCONS%TYPE;
  SBZONE           TARICONC.TACOZONA%TYPE;
  dtfechfinmov     PERIFACT.PEFAFFMO%TYPE;
  
  INUPORCIMPTO     NUMBER := NULL;
  INUTARIFFMETHOD  NUMBER := 1;
  ISBUSEPARTTARIFF VARCHAR2(1) := 'N';

begin

  --/*
  open cuSERVSUSC;
  fetch cuSERVSUSC
    into RCSERVSUSC; --rfservsusc; --RCSERVSUSC;
  close cuSERVSUSC;
  --*/

  nuconcept       := 985;
  sbexemode       := 'F';
  NUIDPACKAGE     := null;
  NUIDMOTIVE      := null;
  sbdocument      := null;
  NUPROGRAM      := null;
  dtfechfinmov    := to_date('30-09-2023 23:59:59','DD-MM-YYYY HH24:MI:SS');
  sbzone          := 'U';
  nuperiactu      := null;
  nuperiproc      := null;

  --/*-- Call the procedure
  pkbsliquidatetax.liquidatetax(ircservsusc      => rcservsusc,
                                inuconcepto      => nuconcepto,
                                inuporcimpto     => nuporcimpto,
                                isbexemode       => sbexemode,
                                inupackageid     => nupackageid,
                                inumotiveid      => numotiveid,
                                isbdocumento     => sbdocumento,
                                inuprograma      => nuprograma,
                                idtfechfinmov    => dtfechfinmov,
                                inutariffmethod  => nutariffmethod,
                                isbuseparttariff => sbuseparttariff,
                                isbzone          => sbzone,
                                inuperiactu      => nuperiactu,
                                inuperiproc      => nuperiproc,
                                onuvalorcargo    => nuvalorcargo);
  --*/

end;
