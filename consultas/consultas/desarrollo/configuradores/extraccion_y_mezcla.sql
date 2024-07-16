select *
from ld_parameter
where parameter_id='COD_EXT_MEZ_NET_LDCGFV';

select *
from ed_confexme
where coemcodi=95;


 SELECT *
FROM ed_franform f, ed_bloqfran b, ed_bloque bl, ed_fuendato fd
WHERE f.frfoform = 43
 AND f.frfocodi = b.blfrfrfo
  AND b.blfrbloq = bl.bloqcodi
  AND fd.fudacodi = bl.bloqfuda;
  
  
select *
from ed_confexme

--ese es el bloque
--padi es la plantilla
select *
from OPEN.ED_BLOQUE;
select *
from OPEN.ED_PLANTILL;



select *
from ED_Formato;
select *
from ED_Franja;
select *
from ED_FranForm;

select *
from ED_FuenDato;

select *
from ED_AtriFuda;

select *
from ED_AtriFuda;

select *
from ED_BloqFran;

select *
from ED_Item;

select *
from ED_ItemBloq;



select c.coemcodi,
       c.coemdesc,
       c.coemtido,
       c.coempada,
       ef.formcodi,
       ef.formdesc,
       ef.formtido,
       ef.formiden,
       ef.formtico,
       fr.francodi,
       fr.frandesc,
       f.frfoorde,
       f.frfomult,
       b.blfrcodi,
       bl.bloqcodi,
       bl.bloqdesc,
       bl.bloqiden,
       bl.bloqfuda,
       fd.fudaserv,
       fd.fudasent,
       b.blfrorde,
       b.blfrmult,
       b.blfrsait,
       i.itemcodi,
       i.itemdesc,
       i.itematfd, 
       itbl.itblblfr,
       itbl.itblorde,
       itbl.itbliden
from open.ed_confexme c
inner join open.ed_formato ef on ef.formiden=c.coempada
left join open.ed_franform f on f.frfoform=ef.formcodi
left join open.ed_franja fr on fr.francodi=f.frfofran
left join open.ed_bloqfran b on f.frfocodi = b.blfrfrfo
left join open.ed_bloque bl on  b.blfrbloq = bl.bloqcodi
left join open.ed_fuendato fd on fd.fudacodi=bl.bloqfuda
left join open.ed_itembloq itbl on itbl.itblblfr=b.blfrcodi
left join open.ed_item i on i.itemcodi=itbl.itblitem
where coemcodi=72
order by frfoorde, blfrorde, itblorde;



select ef.formcodi,
       ef.formdesc,
       ef.formtido,
       ef.formiden,
       ef.formtico,
       c.coemcodi,
       c.coemdesc,
       c.coemtido,
       c.coempada,
       fr.francodi,
       fr.frandesc,
       f.frfoorde,
       f.frfomult,
       b.blfrcodi,
       bl.bloqcodi,
       bl.bloqdesc,
       bl.bloqiden,
       bl.bloqfuda,
       fd.fudaserv,
       fd.fudasent,
       b.blfrorde,
       b.blfrmult,
       b.blfrsait,
       i.itemcodi,
       i.itemdesc,
       i.itematfd, 
       itbl.itblblfr,
       itbl.itblorde,
       itbl.itbliden
from open.ed_formato ef 
left join open.ed_confexme c on ef.formiden=c.coempada
left join open.ed_franform f on f.frfoform=ef.formcodi
left join open.ed_franja fr on fr.francodi=f.frfofran
left join open.ed_bloqfran b on f.frfocodi = b.blfrfrfo
left join open.ed_bloque bl on  b.blfrbloq = bl.bloqcodi
left join open.ed_fuendato fd on fd.fudacodi=bl.bloqfuda
left join open.ed_itembloq itbl on itbl.itblblfr=b.blfrcodi
left join open.ed_item i on i.itemcodi=itbl.itblitem
order by frfoorde, blfrorde, itblorde;