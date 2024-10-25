select ciclcodi, cicldesc, pc.pecscons, pc.pecsfeci, pc.pecsfecf, pf.pefacodi, pf.pefafimo, pf.pefaffmo, pf.pefaactu
from open.ciclo
left join open.pericose pc on pc.pecscico=ciclcodi  and pc.pecsproc='N'
left join open.perifact pf on pf.pefacicl=ciclcodi and pc.pecsfecf between pf.pefafimo and pf.pefaffmo and sysdate between pf.pefafimo and pf.pefaffmo and pf.pefaactu='S'