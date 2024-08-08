select p.* , PF.PEFACODI  from pericose p
inner join perifact  pf on pefacicl = pecscico and  pecsfecf between pf.pefafimo and pf.pefaffmo
inner join ciclo c on c.ciclcodi = pf.pefacicl 
where p.pecsfecf >= '18/04/2024 11:59:59'
and pecsproc ='S' and pecsflav ='N' 
and  not exists ( select NULL from procejec pc where pc.prejcope= pefacodi and pc.prejprog = 'FCRI')
