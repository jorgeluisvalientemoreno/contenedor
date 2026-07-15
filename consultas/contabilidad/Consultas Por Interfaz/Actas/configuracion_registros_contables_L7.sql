declare
	nuIdiClascore number;
	nuIdComproban number; 
	nuRegContableGdga  number;
	nuRegContableGdgu number; 
	usuario       OPEN.ic_compcont.cocousua%TYPE := 'USER';
	terminal      OPEN.ic_compcont.cocoterm%TYPE := pkg_session.fsbgetterminal;
  codigoAnt_id  OPEN.ic_compcont.cococodi%TYPE := 4;
  nuConsecutTipoInterfaz  open.ldci_tipointerfaz.consecutivo%type  ; 
  
	cursor cuClasif is
  select *
	from  open.ic_clascont
	where clcodomi='T';
	
 cursor cuNoIca(nuClas number) is
  with base as(select c.clcrcons,
       nuRegContableGdgu clcrcorc,
       c.clcrclco,
       c.clcrcrit,
       r.ccrccons,
       r.ccrccorc,
       r.ccrcclcr,
       r.ccrccamp,
       r.ccrcoper,
       case when r.ccrcoper  = '=' then ''''||r.ccrcvalo||'''' 
            when r.ccrcoper = 'IN' then  r.ccrcvalo
            when r.ccrcoper is null then null end as ccrcvalo,  
       i.description,
       ct.rcccclcr, 
       ct.rcccnatu, 
       ct.rcccvalo,
       ct.rccccuco,
       ct.rcccpopa,
       ct.rcccpore
  from open.ic_clascont cl
  join open.ic_clascore c on c.clcrclco = cl.clcocodi and c.clcrcorc= nuRegContableGdga
  left join open.ic_crcoreco r on r.CCRCCORC=c.clcrcorc and r.ccrcclcr=c.clcrcons
	left join open.ge_items i on i.items_id=to_number(replace(replace(replace(r.ccrcvalo,'(',''),')',''),'''','')) 
	left join open.ic_recoclco ct on ct.rcccclcr = c.clcrcons
	where cl.clcodomi='T'
	  and cl.clcocodi=nuClas)
	select *
	from base
	where description is null or description not like '%ICA%'
	;
    
	cursor cuExcel(nuClas number) is
	with base as(
         select 245 as clasif,'''100010584''' as item, 2437016601 as cuenta from dual union all
          select 245 as clasif,'''100010586''' as item, 2437016602 as cuenta from dual union all
          select 245 as clasif,'''100010588''' as item, 2437016603 as cuenta from dual union all
          select 245 as clasif,'''100010590''' as item, 2437016604 as cuenta from dual union all
          select 245 as clasif,'''100010592''' as item, 2437016605 as cuenta from dual union all
          select 245 as clasif,'''100010594''' as item, 2437016606 as cuenta from dual union all
          select 245 as clasif,'''100010596''' as item, 2437016607 as cuenta from dual union all
          select 245 as clasif,'''100010598''' as item, 2437016608 as cuenta from dual union all
          select 245 as clasif,'''100010600''' as item, 2437016609 as cuenta from dual union all
          select 245 as clasif,'''100010602''' as item, 2437016610 as cuenta from dual union all
          select 245 as clasif,'''100010604''' as item, 2437016611 as cuenta from dual union all
          select 245 as clasif,'''100010606''' as item, 2437016612 as cuenta from dual union all
          select 245 as clasif,'''100010608''' as item, 2437016613 as cuenta from dual union all
          select 245 as clasif,'''100010610''' as item, 2437016614 as cuenta from dual union all
          select 245 as clasif,'''100010612''' as item, 2437016615 as cuenta from dual union all
          select 247 as clasif,'''100010584''' as item, 2437016601 as cuenta from dual union all
          select 247 as clasif,'''100010586''' as item, 2437016602 as cuenta from dual union all
          select 247 as clasif,'''100010588''' as item, 2437016603 as cuenta from dual union all
          select 247 as clasif,'''100010590''' as item, 2437016604 as cuenta from dual union all
          select 247 as clasif,'''100010592''' as item, 2437016605 as cuenta from dual union all
          select 247 as clasif,'''100010594''' as item, 2437016606 as cuenta from dual union all
          select 247 as clasif,'''100010596''' as item, 2437016607 as cuenta from dual union all
          select 247 as clasif,'''100010598''' as item, 2437016608 as cuenta from dual union all
          select 247 as clasif,'''100010600''' as item, 2437016609 as cuenta from dual union all
          select 247 as clasif,'''100010602''' as item, 2437016610 as cuenta from dual union all
          select 247 as clasif,'''100010604''' as item, 2437016611 as cuenta from dual union all
          select 247 as clasif,'''100010606''' as item, 2437016612 as cuenta from dual union all
          select 247 as clasif,'''100010608''' as item, 2437016613 as cuenta from dual union all
          select 247 as clasif,'''100010610''' as item, 2437016614 as cuenta from dual union all
          select 247 as clasif,'''100010612''' as item, 2437016615 as cuenta from dual union all
          select 248 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 248 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 248 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 248 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 248 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 248 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 248 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 248 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 248 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 248 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 248 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 248 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 248 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 248 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 248 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 249 as clasif,'''100010584''' as item, 2437016601 as cuenta from dual union all
          select 249 as clasif,'''100010586''' as item, 2437016602 as cuenta from dual union all
          select 249 as clasif,'''100010588''' as item, 2437016603 as cuenta from dual union all
          select 249 as clasif,'''100010590''' as item, 2437016604 as cuenta from dual union all
          select 249 as clasif,'''100010592''' as item, 2437016605 as cuenta from dual union all
          select 249 as clasif,'''100010594''' as item, 2437016606 as cuenta from dual union all
          select 249 as clasif,'''100010596''' as item, 2437016607 as cuenta from dual union all
          select 249 as clasif,'''100010598''' as item, 2437016608 as cuenta from dual union all
          select 249 as clasif,'''100010600''' as item, 2437016609 as cuenta from dual union all
          select 249 as clasif,'''100010602''' as item, 2437016610 as cuenta from dual union all
          select 249 as clasif,'''100010604''' as item, 2437016611 as cuenta from dual union all
          select 249 as clasif,'''100010606''' as item, 2437016612 as cuenta from dual union all
          select 249 as clasif,'''100010608''' as item, 2437016613 as cuenta from dual union all
          select 249 as clasif,'''100010610''' as item, 2437016614 as cuenta from dual union all
          select 249 as clasif,'''100010612''' as item, 2437016615 as cuenta from dual union all
          select 250 as clasif,'''100010584''' as item, 2437016601 as cuenta from dual union all
          select 250 as clasif,'''100010586''' as item, 2437016602 as cuenta from dual union all
          select 250 as clasif,'''100010588''' as item, 2437016603 as cuenta from dual union all
          select 250 as clasif,'''100010590''' as item, 2437016604 as cuenta from dual union all
          select 250 as clasif,'''100010592''' as item, 2437016605 as cuenta from dual union all
          select 250 as clasif,'''100010594''' as item, 2437016606 as cuenta from dual union all
          select 250 as clasif,'''100010596''' as item, 2437016607 as cuenta from dual union all
          select 250 as clasif,'''100010598''' as item, 2437016608 as cuenta from dual union all
          select 250 as clasif,'''100010600''' as item, 2437016609 as cuenta from dual union all
          select 250 as clasif,'''100010602''' as item, 2437016610 as cuenta from dual union all
          select 250 as clasif,'''100010604''' as item, 2437016611 as cuenta from dual union all
          select 250 as clasif,'''100010606''' as item, 2437016612 as cuenta from dual union all
          select 250 as clasif,'''100010608''' as item, 2437016613 as cuenta from dual union all
          select 250 as clasif,'''100010610''' as item, 2437016614 as cuenta from dual union all
          select 250 as clasif,'''100010612''' as item, 2437016615 as cuenta from dual union all
          select 251 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 251 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 251 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 251 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 251 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 251 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 251 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 251 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 251 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 251 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 251 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 251 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 251 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 251 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 251 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 252 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 252 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 252 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 252 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 252 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 252 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 252 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 252 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 252 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 252 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 252 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 252 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 252 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 252 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 252 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 253 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 253 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 253 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 253 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 253 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 253 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 253 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 253 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 253 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 253 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 253 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 253 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 253 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 253 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 253 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 254 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 254 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 254 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 254 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 254 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 254 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 254 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 254 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 254 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 254 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 254 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 254 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 254 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 254 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 254 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 255 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 255 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 255 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 255 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 255 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 255 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 255 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 255 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 255 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 255 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 255 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 255 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 255 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 255 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 255 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 256 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 256 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 256 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 256 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 256 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 256 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 256 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 256 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 256 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 256 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 256 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 256 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 256 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 256 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 256 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 257 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 257 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 257 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 257 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 257 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 257 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 257 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 257 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 257 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 257 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 257 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 257 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 257 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 257 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 257 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 258 as clasif,'''100010584''' as item, 2437016601 as cuenta from dual union all
          select 258 as clasif,'''100010586''' as item, 2437016602 as cuenta from dual union all
          select 258 as clasif,'''100010588''' as item, 2437016603 as cuenta from dual union all
          select 258 as clasif,'''100010590''' as item, 2437016604 as cuenta from dual union all
          select 258 as clasif,'''100010592''' as item, 2437016605 as cuenta from dual union all
          select 258 as clasif,'''100010594''' as item, 2437016606 as cuenta from dual union all
          select 258 as clasif,'''100010596''' as item, 2437016607 as cuenta from dual union all
          select 258 as clasif,'''100010598''' as item, 2437016608 as cuenta from dual union all
          select 258 as clasif,'''100010600''' as item, 2437016609 as cuenta from dual union all
          select 258 as clasif,'''100010602''' as item, 2437016610 as cuenta from dual union all
          select 258 as clasif,'''100010604''' as item, 2437016611 as cuenta from dual union all
          select 258 as clasif,'''100010606''' as item, 2437016612 as cuenta from dual union all
          select 258 as clasif,'''100010608''' as item, 2437016613 as cuenta from dual union all
          select 258 as clasif,'''100010610''' as item, 2437016614 as cuenta from dual union all
          select 258 as clasif,'''100010612''' as item, 2437016615 as cuenta from dual union all
          select 259 as clasif,'''100010584''' as item, 2437016601 as cuenta from dual union all
          select 259 as clasif,'''100010586''' as item, 2437016602 as cuenta from dual union all
          select 259 as clasif,'''100010588''' as item, 2437016603 as cuenta from dual union all
          select 259 as clasif,'''100010590''' as item, 2437016604 as cuenta from dual union all
          select 259 as clasif,'''100010592''' as item, 2437016605 as cuenta from dual union all
          select 259 as clasif,'''100010594''' as item, 2437016606 as cuenta from dual union all
          select 259 as clasif,'''100010596''' as item, 2437016607 as cuenta from dual union all
          select 259 as clasif,'''100010598''' as item, 2437016608 as cuenta from dual union all
          select 259 as clasif,'''100010600''' as item, 2437016609 as cuenta from dual union all
          select 259 as clasif,'''100010602''' as item, 2437016610 as cuenta from dual union all
          select 259 as clasif,'''100010604''' as item, 2437016611 as cuenta from dual union all
          select 259 as clasif,'''100010606''' as item, 2437016612 as cuenta from dual union all
          select 259 as clasif,'''100010608''' as item, 2437016613 as cuenta from dual union all
          select 259 as clasif,'''100010610''' as item, 2437016614 as cuenta from dual union all
          select 259 as clasif,'''100010612''' as item, 2437016615 as cuenta from dual union all
          select 260 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 260 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 260 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 260 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 260 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 260 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 260 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 260 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 260 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 260 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 260 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 260 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 260 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 260 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 260 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 262 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 262 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 262 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 262 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 262 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 262 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 262 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 262 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 262 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 262 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 262 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 262 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 262 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 262 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 262 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 262 as clasif,'''100010584''' as item, 2437016601 as cuenta from dual union all
          select 262 as clasif,'''100010586''' as item, 2437016602 as cuenta from dual union all
          select 262 as clasif,'''100010588''' as item, 2437016603 as cuenta from dual union all
          select 262 as clasif,'''100010590''' as item, 2437016604 as cuenta from dual union all
          select 262 as clasif,'''100010592''' as item, 2437016605 as cuenta from dual union all
          select 262 as clasif,'''100010594''' as item, 2437016606 as cuenta from dual union all
          select 262 as clasif,'''100010596''' as item, 2437016607 as cuenta from dual union all
          select 262 as clasif,'''100010598''' as item, 2437016608 as cuenta from dual union all
          select 262 as clasif,'''100010600''' as item, 2437016609 as cuenta from dual union all
          select 262 as clasif,'''100010602''' as item, 2437016610 as cuenta from dual union all
          select 262 as clasif,'''100010604''' as item, 2437016611 as cuenta from dual union all
          select 262 as clasif,'''100010606''' as item, 2437016612 as cuenta from dual union all
          select 262 as clasif,'''100010608''' as item, 2437016613 as cuenta from dual union all
          select 262 as clasif,'''100010610''' as item, 2437016614 as cuenta from dual union all
          select 262 as clasif,'''100010612''' as item, 2437016615 as cuenta from dual union all
          select 268 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 268 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 268 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 268 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 268 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 268 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 268 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 268 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 268 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 268 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 268 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 268 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 268 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 268 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 268 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 269 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 269 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 269 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 269 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 269 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 269 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 269 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 269 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 269 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 269 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 269 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 269 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 269 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 269 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 269 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 269 as clasif,'''100010584''' as item, 2437016601 as cuenta from dual union all
          select 269 as clasif,'''100010586''' as item, 2437016602 as cuenta from dual union all
          select 269 as clasif,'''100010588''' as item, 2437016603 as cuenta from dual union all
          select 269 as clasif,'''100010590''' as item, 2437016604 as cuenta from dual union all
          select 269 as clasif,'''100010592''' as item, 2437016605 as cuenta from dual union all
          select 269 as clasif,'''100010594''' as item, 2437016606 as cuenta from dual union all
          select 269 as clasif,'''100010596''' as item, 2437016607 as cuenta from dual union all
          select 269 as clasif,'''100010598''' as item, 2437016608 as cuenta from dual union all
          select 269 as clasif,'''100010600''' as item, 2437016609 as cuenta from dual union all
          select 269 as clasif,'''100010602''' as item, 2437016610 as cuenta from dual union all
          select 269 as clasif,'''100010604''' as item, 2437016611 as cuenta from dual union all
          select 269 as clasif,'''100010606''' as item, 2437016612 as cuenta from dual union all
          select 269 as clasif,'''100010608''' as item, 2437016613 as cuenta from dual union all
          select 269 as clasif,'''100010610''' as item, 2437016614 as cuenta from dual union all
          select 269 as clasif,'''100010612''' as item, 2437016615 as cuenta from dual union all
          select 300 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 300 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 300 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 300 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 300 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 300 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 300 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 300 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 300 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 300 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 300 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 300 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 300 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 300 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 300 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 301 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 301 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 301 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 301 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 301 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 301 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 301 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 301 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 301 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 301 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 301 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 301 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 301 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 301 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 301 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 304 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 304 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 304 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 304 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 304 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 304 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 304 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 304 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 304 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 304 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 304 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 304 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 304 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 304 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 304 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 305 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 305 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 305 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 305 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 305 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 305 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 305 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 305 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 305 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 305 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 305 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 305 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 305 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 305 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 305 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 306 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 306 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 306 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 306 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 306 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 306 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 306 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 306 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 306 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 306 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 306 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 306 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 306 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 306 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 306 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 308 as clasif,'''100010584''' as item, 2437016601 as cuenta from dual union all
          select 308 as clasif,'''100010586''' as item, 2437016602 as cuenta from dual union all
          select 308 as clasif,'''100010588''' as item, 2437016603 as cuenta from dual union all
          select 308 as clasif,'''100010590''' as item, 2437016604 as cuenta from dual union all
          select 308 as clasif,'''100010592''' as item, 2437016605 as cuenta from dual union all
          select 308 as clasif,'''100010594''' as item, 2437016606 as cuenta from dual union all
          select 308 as clasif,'''100010596''' as item, 2437016607 as cuenta from dual union all
          select 308 as clasif,'''100010598''' as item, 2437016608 as cuenta from dual union all
          select 308 as clasif,'''100010600''' as item, 2437016609 as cuenta from dual union all
          select 308 as clasif,'''100010602''' as item, 2437016610 as cuenta from dual union all
          select 308 as clasif,'''100010604''' as item, 2437016611 as cuenta from dual union all
          select 308 as clasif,'''100010606''' as item, 2437016612 as cuenta from dual union all
          select 308 as clasif,'''100010608''' as item, 2437016613 as cuenta from dual union all
          select 308 as clasif,'''100010610''' as item, 2437016614 as cuenta from dual union all
          select 308 as clasif,'''100010612''' as item, 2437016615 as cuenta from dual union all
          select 309 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 309 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 309 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 309 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 309 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 309 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 309 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 309 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 309 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 309 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 309 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 309 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 309 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 309 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 309 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 310 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 310 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 310 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 310 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 310 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 310 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 310 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 310 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 310 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 310 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 310 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 310 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 310 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 310 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 310 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 311 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 311 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 311 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 311 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 311 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 311 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 311 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 311 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 311 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 311 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 311 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 311 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 311 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 311 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 311 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 313 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 313 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 313 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 313 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 313 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 313 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 313 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 313 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 313 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 313 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 313 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 313 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 313 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 313 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 313 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 314 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 314 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 314 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 314 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 314 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 314 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 314 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 314 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 314 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 314 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 314 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 314 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 314 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 314 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 314 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 315 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 315 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 315 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 315 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 315 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 315 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 315 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 315 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 315 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 315 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 315 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 315 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 315 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 315 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 315 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 316 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 316 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 316 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 316 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 316 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 316 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 316 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 316 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 316 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 316 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 316 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 316 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 316 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 316 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 316 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 317 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 317 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 317 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 317 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 317 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 317 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 317 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 317 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 317 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 317 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 317 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 317 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 317 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 317 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 317 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 318 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 318 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 318 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 318 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 318 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 318 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 318 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 318 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 318 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 318 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 318 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 318 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 318 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 318 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 318 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 390 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 390 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 390 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 390 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 390 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 390 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 390 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 390 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 390 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 390 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 390 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 390 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 390 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 390 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 390 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 394 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 394 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 394 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 394 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 394 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 394 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 394 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 394 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 394 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 394 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 394 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 394 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 394 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 394 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 394 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 395 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 395 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 395 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 395 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 395 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 395 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 395 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 395 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 395 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 395 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 395 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 395 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 395 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 395 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 395 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 396 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 396 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 396 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 396 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 396 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 396 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 396 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 396 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 396 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 396 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 396 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 396 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 396 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 396 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 396 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 397 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 397 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 397 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 397 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 397 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 397 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 397 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 397 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 397 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 397 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 397 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 397 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 397 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 397 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 397 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 411 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 411 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 411 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 411 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 411 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 411 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 411 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 411 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 411 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 411 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 411 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 411 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 411 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 411 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 411 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 413 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 413 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 413 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 413 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 413 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 413 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 413 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 413 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 413 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 413 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 413 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 413 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 413 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 413 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 413 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 414 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 414 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 414 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 414 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 414 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 414 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 414 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 414 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 414 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 414 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 414 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 414 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 414 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 414 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 414 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 488 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 488 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 488 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 488 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 488 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 488 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 488 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 488 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 488 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 488 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 488 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 488 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 488 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 488 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 488 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 551 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 551 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 551 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 551 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 551 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 551 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 551 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 551 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 551 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 551 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 551 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 551 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 551 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 551 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 551 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 552 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 552 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 552 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 552 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 552 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 552 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 552 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 552 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 552 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 552 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 552 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 552 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 552 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 552 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 552 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 567 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 567 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 567 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 567 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 567 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 567 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 567 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 567 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 567 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 567 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 567 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 567 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 567 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 567 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 567 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 568 as clasif,'''100010584''' as item, 2437016601 as cuenta from dual union all
          select 568 as clasif,'''100010586''' as item, 2437016602 as cuenta from dual union all
          select 568 as clasif,'''100010588''' as item, 2437016603 as cuenta from dual union all
          select 568 as clasif,'''100010590''' as item, 2437016604 as cuenta from dual union all
          select 568 as clasif,'''100010592''' as item, 2437016605 as cuenta from dual union all
          select 568 as clasif,'''100010594''' as item, 2437016606 as cuenta from dual union all
          select 568 as clasif,'''100010596''' as item, 2437016607 as cuenta from dual union all
          select 568 as clasif,'''100010598''' as item, 2437016608 as cuenta from dual union all
          select 568 as clasif,'''100010600''' as item, 2437016609 as cuenta from dual union all
          select 568 as clasif,'''100010602''' as item, 2437016610 as cuenta from dual union all
          select 568 as clasif,'''100010604''' as item, 2437016611 as cuenta from dual union all
          select 568 as clasif,'''100010606''' as item, 2437016612 as cuenta from dual union all
          select 568 as clasif,'''100010608''' as item, 2437016613 as cuenta from dual union all
          select 568 as clasif,'''100010610''' as item, 2437016614 as cuenta from dual union all
          select 568 as clasif,'''100010612''' as item, 2437016615 as cuenta from dual union all
          select 611 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 611 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 611 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 611 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 611 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 611 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 611 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 611 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 611 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 611 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 611 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 611 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 611 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 611 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 611 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual union all
          select 658 as clasif,'''100010583''' as item, 2437016601 as cuenta from dual union all
          select 658 as clasif,'''100010585''' as item, 2437016602 as cuenta from dual union all
          select 658 as clasif,'''100010587''' as item, 2437016603 as cuenta from dual union all
          select 658 as clasif,'''100010589''' as item, 2437016604 as cuenta from dual union all
          select 658 as clasif,'''100010591''' as item, 2437016605 as cuenta from dual union all
          select 658 as clasif,'''100010593''' as item, 2437016606 as cuenta from dual union all
          select 658 as clasif,'''100010595''' as item, 2437016607 as cuenta from dual union all
          select 658 as clasif,'''100010597''' as item, 2437016608 as cuenta from dual union all
          select 658 as clasif,'''100010599''' as item, 2437016609 as cuenta from dual union all
          select 658 as clasif,'''100010601''' as item, 2437016610 as cuenta from dual union all
          select 658 as clasif,'''100010603''' as item, 2437016611 as cuenta from dual union all
          select 658 as clasif,'''100010605''' as item, 2437016612 as cuenta from dual union all
          select 658 as clasif,'''100010607''' as item, 2437016613 as cuenta from dual union all
          select 658 as clasif,'''100010609''' as item, 2437016614 as cuenta from dual union all
          select 658 as clasif,'''100010611''' as item, 2437016615 as cuenta from dual)

select distinct (clasif) , item ,  cuenta
from base
where clasif=nuClas;
      
begin
  
  select max(cococodi) + 1
  into nuIdComproban
  from open.ic_compcont;

  insert into open.ic_compcont
  select  nuIdComproban,
          cocotcco,
          'L7-ACTA-GDGU',
          sysdate,
          usuario,
          terminal,
          cocoprog,
          cocosist
  from open.ic_compcont
  where cocotcco = 4
  and cococodi = codigoant_id;
  
  DBMS_OUTPUT.PUT_LINE('Nuevo comprobante creado:' || nuIdComproban);
  
  nuRegContableGdgu:= sq_ic_confreco_corccons.nextval ; 
  
  insert into open.ic_confreco
  select  nuRegContableGdgu,
          nuIdComproban,
          corctido,
          corctimo,
          corccrit,
          sysdate,
          usuario,
          terminal,
          corcprog
  from open.ic_confreco
  where corccoco = codigoant_id
  and corctimo = 63;
  
 insert into open.ic_auxicorc 
 select sq_ic_auxicorc_187974.nextval as aucrcons,  
        c_new.corccons, 
        aucrsign, 
        aucranme, 
        aucrbare, 
        aucrbatr, 
        aucrcale, 
        aucrcate, 
        aucrceco, 
        aucrcicl, 
        aucrcldp, 
        aucrclie, 
        aucrconc, 
        aucrcupo, 
        aucrdoso, 
        aucredde, 
        aucrfetr, 
        aucrfopa, 
        aucrnibr, 
        aucrnibt, 
        aucrnica, 
        aucrnips, 
        aucrnite, 
        aucrnufa, 
        aucrproy, 
        aucrserv, 
        aucrsici, 
        aucrsifa, 
        aucrsipr, 
        aucrsire, 
        aucrsuca, 
        aucrtibr, 
        aucrtica, 
        aucrtiuo, 
        aucrunne, 
        aucrvaba, 
        aucrubg1, 
        aucrubg2, 
        aucrubg3, 
        aucrubg4, 
        aucrubg5, 
        aucrunco, 
        aucrsuba, 
        aucrdipr, 
        aucrclit, 
        aucrtitr, 
        aucrbaco, 
        aucritem
  from open.ic_auxicorc a
  inner join open.ic_confreco c_old on a.aucrcorc = c_old.corccons 
  inner join open.ic_confreco c_new on c_new.corctido = c_old.corctido 
   and c_new.corctimo = c_old.corctimo 
   and c_old.corccrit = c_new.corccrit 
   and c_new.corccoco = nuIdComproban 
  where c_old.corccoco = codigoant_id ; 
  
  select corccons
  into nuRegContableGdga
	from open.ic_confreco
	where corccoco=codigoAnt_id  
  and corctimo=63 ;
  
 
	for reg in cuClasif loop
		for reg2 in cuNoIca(reg.clcocodi) loop
			begin
				nuIdiClascore := sq_ic_clascore_clcrcons.NEXTVAL;
				INSERT INTO open.ic_clascore(clcrcons, clcrcorc,clcrclco,clcrcrit,clcrfecr, clcrusua, clcrterm, clcrprog)
				values(nuIdiClascore,
					   reg2.clcrcorc, 
					   reg2.clcrclco,
					   case when reg2.CCRCCAMP='' then reg2.clcrcrit else '--' end,
					   SYSDATE,
					   usuario,
					   terminal,
					   'MASIVO');
				if reg2.ccrccons is not null then	   
					INSERT INTO OPEN.ic_crcoreco(ccrccons, ccrccorc, ccrcclcr, ccrccamp, ccrcoper, ccrcvalo, ccrcfecr, ccrcusua, ccrcterm, ccrcprog)
						values(sq_ic_crcoreco_ccrccons.nextval,
							   reg2.clcrcorc,
							   nuIdiClascore,
							   'MOVIITEM',
							   '=',
							   reg2.ccrcvalo,
							   SYSDATE,
							   usuario,
							   terminal,
							   'MASIVO');
		        end if;
				if reg2.rcccclcr is not null then
					INSERT INTO OPEN.IC_RECOCLCO(rccccons,rcccclcr,rcccnatu,rcccvalo,rccccuco,rcccfecr,rcccusua,rcccterm,rcccprog,rcccpopa,rcccpore)
						values(sq_ic_recoclco_rccccons.nextval,
							   nuIdiClascore,
							   reg2.rcccnatu,
							   reg2.rcccvalo,
							   reg2.rccccuco,
							   sysdate,
							   usuario,
							   terminal,
							   'MASIVO',
							   reg2.rcccpopa,
							   reg2.rcccpore
							   );
						
				end if;
				commit;
				
			exception
				when others then
				 rollback;
				 dbms_output.put_line('Error1 :'||sqlerrm);
			end;
		end loop;
    
		for reg2 in cuExcel(reg.clcocodi) loop
			begin
				nuIdiClascore := sq_ic_clascore_clcrcons.NEXTVAL;
				INSERT INTO open.ic_clascore(clcrcons, clcrcorc,clcrclco,clcrcrit,clcrfecr, clcrusua, clcrterm, clcrprog)
				values(nuIdiClascore,
					   nuRegContableGdgu,
					   reg2.clasif,
					   '  AND MOVIITEM = '||reg2.item||' ',
					   SYSDATE,
					   usuario,
					   terminal,
					   'MASIVO');
					   
			    INSERT INTO OPEN.ic_crcoreco(ccrccons, ccrccorc, ccrcclcr, ccrccamp, ccrcoper, ccrcvalo, ccrcfecr, ccrcusua, ccrcterm, ccrcprog)
					values(sq_ic_crcoreco_ccrccons.nextval,
						   nuRegContableGdgu,
						   nuIdiClascore,
						   'MOVIITEM',
						   '=',
						   reg2.item,
						   SYSDATE,
						   usuario,
						   terminal,
						   'MASIVO');
				INSERT INTO OPEN.IC_RECOCLCO(rccccons,rcccclcr,rcccnatu,rcccvalo,rccccuco,rcccfecr,rcccusua,rcccterm,rcccprog,rcccpopa,rcccpore)
				    values(sq_ic_recoclco_rccccons.nextval,
					       nuIdiClascore,
						   'D',
						   'V',
						   reg2.cuenta,
						   sysdate,
						   usuario,
						   terminal,
						   'MASIVO',
						   100,
						   null
						   );
					commit;
			exception
				when others then
				rollback;
				dbms_output.put_line('Error1 :'||sqlerrm);
			end;
		end loop;    
       
    
	end loop;
  
  select max(consecutivo ) + 1
  into nuConsecutTipoInterfaz
  from open.ldci_tipointerfaz;

  
  insert into open.ldci_tipointerfaz 
    select nuConsecutTipoInterfaz, 
          tipointerfaz, 
          nuIdComproban, 
          cod_tipocomp, 
          ledgers, 
          'GDGU'
   from open.ldci_tipointerfaz 
   where tipointerfaz ='L7'  
   and cod_comprobante = codigoAnt_id; 

	commit;
end;
/
