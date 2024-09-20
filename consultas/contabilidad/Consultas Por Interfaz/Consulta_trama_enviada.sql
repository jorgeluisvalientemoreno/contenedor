select * --substr(lp.procpara,61,instr(substr(lp.procpara,61),'<')-1) trama
  from open.ldci_mesaenvws l, open.LDCI_ESTAPROC lp
 where l.mesadefi = 'WS_INTER_CONTABLE' 
   and lp.PROCCODI = l.mesaproc
   and substr(lp.procpara,61,instr(substr(lp.procpara,61),'<')-1) = 3964
