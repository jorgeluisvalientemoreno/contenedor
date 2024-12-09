select pf.*, rowid
  from open.perifact pf
 where sysdate not between pf.pefafimo and pf.pefaffmo
   and pf.pefaactu = 'S';
update open.perifact pf
   set pf.pefaactu = 'N'
 where sysdate not between pf.pefafimo and pf.pefaffmo
   and pf.pefaactu = 'S';
commit;
select pf.*, rowid
  from open.perifact pf
 where sysdate not between pf.pefafimo and pf.pefaffmo
   and pf.pefaactu = 'S';
update open.perifact pf
   set pf.pefaactu = 'S'
 where sysdate between pf.pefafimo and pf.pefaffmo;
commit;
select pf.*, rowid
  from open.perifact pf
 where sysdate between pf.pefafimo and pf.pefaffmo
   and pf.pefaactu = 'S';
