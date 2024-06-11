with base as(select c.configura_type_id, c.expression,c.description,  count(1), min(c.config_expression_id) id
from open.OR_OPUNI_TSKTYP_NOTI t, open.gr_config_expression c
where t.config_expression_id=c.config_expression_id
group by c.configura_type_id, c.expression, c.description)
select *
from  open.OR_OPUNI_TSKTYP_NOTI t 
inner join open.gr_config_expression c on t.config_expression_id = c.config_expression_id
inner join base on base.expression=c.expression and base.configura_type_id=c.configura_type_id
and  t.config_expression_id!=base.id;



SELECT 'with base as
   (select c.configura_type_id,
           c.expression,
           c.description,
           count(1),
           min(c.config_expression_id) id
      from open.'||&sbTableName||' t, open.gr_config_expression c
     where t.'||&sbColumnName||' = c.config_expression_id
     group by c.configura_type_id, c.expression, c.description)
  select t.rowid record_rowid,
         t.config_expression_id old_config_expression_id,
         base.id                new_config_expression_id,
         c.object_type,
         c.object_name,
         '||
         (select substr(pk, 1, length(pk)-12)
         from (select listagg(column_name) within group(order by column_name) as pk
            from (select ''''||column_name||'='''||'||'||column_name|| ' || '' AND '''||'||' column_name
             from dba_constraints t, dba_cons_columns d
            where t.TABLE_NAME='OR_OPUNI_TSKTYP_NOTI'
              and constraint_type='P'
              and t.CONSTRAINT_NAME=d.CONSTRAINT_NAME
              and t.TABLE_NAME=d.TABLE_NAME
              and t.OWNER=d.OWNER)))||' primary_key
    from open.'||&sbTableName||' t
   inner join open.gr_config_expression c
      on t.'||&sbColumnName||' = c.config_expression_id
   inner join base
      on base.expression = c.expression
     and base.configura_type_id = c.configura_type_id
     and t.config_expression_id != base.id'
     FROM DUAL
