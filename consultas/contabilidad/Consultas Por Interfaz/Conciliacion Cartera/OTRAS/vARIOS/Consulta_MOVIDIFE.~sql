select modicaca, g.cacadesc, modisign, 
      sum(decode(modisign, 'DB', modivacu, 0)) VALO_DB, sum(decode(modisign, 'DB', 0, -modivacu)) VALO_CR
  from open.movidife m, open.causcarg g
 where m.modifech >= '09-02-2015'
   and m.modifech <  '01-03-2015' and modicaca = g.cacacodi
group by modicaca, g.cacadesc, modisign
