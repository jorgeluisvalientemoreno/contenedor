PL/SQL Developer Test script 3.0
11
begin
  -- Call the function
  :result := open.ldc_pkcostoingreso.fnugeneingreservcump(inuano => :inuano,
                                                          inumes => :inumes,
                                                          dtfefein => :dtfefein,
                                                          dtfefefin => :dtfefefin,
                                                          sbcorreo => :sbcorreo,
                                                          sbtipobd => :sbtipobd,
                                                          sbmensa => :sbmensa,
                                                          error => :error);
end;
9
result
1
-1
4
inuano
1
2023
4
inumes
1
9
4
dtfefein
1
1/09/2023
12
dtfefefin
1
30/09/2023 11:59:59 p. m.
12
sbcorreo
0
5
sbtipobd
0
5
sbmensa
1
ERROR: [FnuGeneIngreServCump]: ORA-20000: ERROR CODIGO : -29279  MENSAJE : ORA-29279: error permanente de SMTP: 503 5.5.2 Need Rcpt command.
5
error
0
4
1
sbmensa
