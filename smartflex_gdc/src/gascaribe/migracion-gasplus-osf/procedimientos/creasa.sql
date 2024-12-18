CREATE OR REPLACE Procedure creasa(numinicio   Number,
                                   numfinal    Number,
                                   inubasedato Number) As

  Cursor cusa Is
    Select *
      From open.cargos
     Where cargdoso Like '%CTN%'
       And cargsign = 'SA';

  Cursor cusanc Is
    Select *
      From open.cargos
     Where cargsign = 'SA'
       And cargdoso Like 'NC%'
       and cargcuco = 112792861;

  Cursor cusaunique Is
    Select *
      From open.cargos a
     Where cargsign = 'SA'
       And Exists (Select 1
              From open.cargos b
             Where a.cargcuco = b.cargcuco
             Group By a.cargcuco
            Having Count(1) = 1);

  Cursor cund Is
    Select *
      From open.cargos
     Where cargdoso Like '%ND%'
       And cargsign = 'SA';

  nulogerror  Number;
  nutotalregs Number := 0;
  nuerrores   Number := 0;
  nuconection Number := 0;
  vfecha_ini  Date;
  vfecha_fin  Date;
  vprograma   Varchar2(100);
  vcont       Number := 0;
  vcontlec    Number := 0;
  vcontins    Number := 0;
  verror      Varchar2(4000);

Begin
  vprograma  := 'CREASA';
  vfecha_ini := Sysdate;
  -- Inserta registro de inicio en el log
  pklog_migracion.prinslogmigra(3945,
                                3945,
                                1,
                                vprograma,
                                0,
                                0,
                                'Inicia Proceso',
                                'INICIO',
                                nulogerror);
  Update migr_rango_procesos
     Set raprterm = 'P',
         raprfein = Sysdate
   Where raprbase = inubasedato
     And raprrain = numinicio
     And raprrafi = numfinal
     And raprcodi = 3945;
  Commit;

  /*For r In cusa Loop
  
    Begin
    
      Insert \*+ APPEND*\
      Into cargos
      Values
        (r.cargcuco,
         r.cargnuse,
         145,
         r.cargcaca,
         'CR',
         r.cargpefa,
         r.cargvalo,
         'CREDITOCREADO',
         r.cargcodo,
         r.cargusua,
         r.cargtipr,
         r.cargunid,
         r.cargfecr,
         161,
         r.cargcoll,
         r.cargpeco,
         r.cargtico,
         r.cargvabl,
         r.cargtaco);
      Update cuencobr
         Set cucovato = cucovato - r.cargvalo,
             cucovaab = cucovaab - r.cargvalo
       Where cucocodi = r.cargcuco;
      Commit;
    
    Exception
      When Others Then
        Rollback;
    End;
  
  End Loop;
*/
  For r In cusanc Loop
  
    Begin
    
      Insert /*+ APPEND*/
      Into cargos
      Values
        (r.cargcuco,
         r.cargnuse,
         145,
         r.cargcaca,
         'CR',
         r.cargpefa,
         r.cargvalo,
         'CREDITOCREADOSANC',
         r.cargcodo,
         r.cargusua,
         r.cargtipr,
         r.cargunid,
         r.cargfecr,
         161,
         r.cargcoll,
         r.cargpeco,
         r.cargtico,
         r.cargvabl,
         r.cargtaco);
      Update cuencobr
         Set cucovato = cucovato - r.cargvalo,
             cucovaab = cucovaab - r.cargvalo
       Where cucocodi = r.cargcuco;
      Commit;
    
    Exception
      When Others Then
        Rollback;
    End;
  
  End Loop;

 /* For r In cund Loop
  
    Begin
    
      Insert \*+ APPEND*\
      Into cargos
      Values
        (r.cargcuco,
         r.cargnuse,
         145,
         r.cargcaca,
         'CR',
         r.cargpefa,
         r.cargvalo,
         'CREDITOCREADOND',
         r.cargcodo,
         r.cargusua,
         r.cargtipr,
         r.cargunid,
         r.cargfecr,
         161,
         r.cargcoll,
         r.cargpeco,
         r.cargtico,
         r.cargvabl,
         r.cargtaco);
      Update cuencobr
         Set cucovato = cucovato - r.cargvalo,
             cucovaab = cucovaab - r.cargvalo
       Where cucocodi = r.cargcuco;
      Commit;
    
    Exception
      When Others Then
        Rollback;
    End;
  
  End Loop;

  For r In cusaunique Loop
  
    Begin
    
      Insert \*+ APPEND*\
      Into cargos
      Values
        (r.cargcuco,
         r.cargnuse,
         145,
         r.cargcaca,
         'CR',
         r.cargpefa,
         r.cargvalo,
         'CREDITOCREADOSA',
         r.cargcodo,
         r.cargusua,
         r.cargtipr,
         r.cargunid,
         r.cargfecr,
         161,
         r.cargcoll,
         r.cargpeco,
         r.cargtico,
         r.cargvabl,
         r.cargtaco);
      Update cuencobr
         Set cucovato = cucovato - r.cargvalo,
             cucovaab = cucovaab - r.cargvalo
       Where cucocodi = r.cargcuco;
      Commit;
    
    Exception
      When Others Then
        Rollback;
    End;
  
  End Loop;
*/
  pklog_migracion.prinslogmigra(3945,
                                3945,
                                3,
                                vprograma,
                                nutotalregs,
                                nuerrores,
                                'TERMINO PROCESO #regs: ' || vcontins,
                                'FIN',
                                nulogerror);
  Update migr_rango_procesos
     Set raprterm = 'T',
         raprfefi = Sysdate
   Where raprbase = inubasedato
     And raprrain = numinicio
     And raprrafi = numfinal
     And raprcodi = 3945;
  Commit;

Exception
  When Others Then
    Begin
    
      nuerrores := nuerrores + 1;
      pklog_migracion.prinslogmigra(3800,
                                    3800,
                                    2,
                                    vprograma || vcontins,
                                    0,
                                    0,
                                    ' - Error: ' || Sqlerrm,
                                    to_char(Sqlcode),
                                    nulogerror);
    
    End;
  
End;
/
