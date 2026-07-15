
select *
from orm.opt_directorio
where nombre='_VALIDACION MIGRACION GUAJIRA';
--80187

select *
from dba_tab_columns
where owner='ORM'
  and column_name='ID_CONSULTA';
  
  
SELECT *
FROM ORM.OPT_PAGESETTINGS
WHERE ID_CONSULTA=
13  ORM OPT_PARAMETROS  ID_CONSULTA NUMBER      22  9 0 N 1   <Long>                      NO  NO    0   NO  YES NONE
14  ORM OPT_PIVOT ID_CONSULTA NUMBER      22  9 0 N 1   <Long>                      NO  NO    0   NO  YES NONE
  

select *
from dba_sequences
where sequence_owner='ORM';

select ORM.OPTSEQ_CONSULTA.nextval from dual
---2418
insert into orm.opt_consulta(id_consulta,
nombre,
consulta,
descripcion,
fecha_reg,
id_usuario,
id_directorio,
publica,
max_segs_dif,
produccion,
ejec_concurrentes,
guardado_automatico,
tipodoc,
habilweb)
values(2418, 
       'Validacion Cliente',
       'select * from migragg.ge_subscriber',
       '',
       sysdate,
       'ELIBER',
       80187,
       'N',
       0,
       'N',
       0,
       'N',
       'Q',
       'N');
    
select orm.OPTSEQ_LAYOUT.nextval from dual; 
--102504
  
insert into orm.opt_layout(id_consulta,
id_layout,
nombre,
descripcion,
fecha_reg,
id_usuario,
layout,
numera_lin)
values(2418,
102504, 
'Validacion Cliente',
'',
sysdate,
'ELIBER',
'',
'N');

insert into ORM.OPT_PAGESETTINGS(id_consulta,id_layout,left,
right,
top,
bottom,
landscape,
paperkind,
papername,
hleftcol,
hmiddlecol,
hrightcol,
hfont,
hlinealign,
fleftcol,
fmiddlecol,
frightcol,
ffont,
flinealign,
fitpages,
escala)
values(2418,
       102504,
       254,
       254,
       254,
       254,
       'N',
       'Letter',
       '',
       '',
       'Validacion Cliente',
       '',
       'Tahoma; 10pt',
       1,
       'Usuario: eliber@SFPL0707',
       'Fecha: [Date Printed]',
       'Pag.: [Page #]',
       'Tahoma; 8pt',
       1,
       0,
       1);
       



