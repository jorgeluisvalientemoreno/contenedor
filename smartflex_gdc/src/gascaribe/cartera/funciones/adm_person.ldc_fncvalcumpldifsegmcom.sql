CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNCVALCUMPLDIFSEGMCOM" (
inudife in diferido.difecodi%type, -- numero del diferido
inupldi diferido.difepldi%type ,   -- codigo plan diferido
inuloca number,                    -- codigo localidad
inucategoria number,               -- codigo categoria
inuestadocorte number,             -- codigo estado de corte
sbestadofinanciero   varchar2              -- estado financiero
) return varchar2 is
cursor locas is
       select distinct nvl(GEOG_GEOGPH_LOC_ID,-1) m
              from OPEN.CC_COM_SEG_FEA_VAL VSG
              WHERE VSG.COMMERCIAL_SEGM_ID IN
                    (SELECT X.COMMERCIAL_SEGM_ID
                            FROM OPEN.CC_COM_SEG_FINAN X
                            WHERE X.FINANCING_PLAN_ID=inupldi);
cursor cucategorias is
       select distinct nvl(GEOG_CATEGORY_ID,-1) g
              from OPEN.CC_COM_SEG_FEA_VAL VSG
              WHERE VSG.COMMERCIAL_SEGM_ID IN
                    (SELECT X.COMMERCIAL_SEGM_ID
                            FROM OPEN.CC_COM_SEG_FINAN X
                            WHERE X.FINANCING_PLAN_ID=inupldi);
cursor cuestadocorte is
       select distinct nvl(PROD_CUTTING_STATE,'-1') cq
              from OPEN.CC_COM_SEG_FEA_VAL VSG
              WHERE VSG.COMMERCIAL_SEGM_ID IN
                    (SELECT X.COMMERCIAL_SEGM_ID
                            FROM OPEN.CC_COM_SEG_FINAN X
                            WHERE X.FINANCING_PLAN_ID=inupldi);
cursor cuestadofinanciero is
       select distinct nvl(FINAN_FINAN_STATE ,'-') ef
              from OPEN.CC_COM_SEG_FEA_VAL VSG
              WHERE VSG.COMMERCIAL_SEGM_ID IN
                    (SELECT X.COMMERCIAL_SEGM_ID
                            FROM OPEN.CC_COM_SEG_FINAN X
                            WHERE X.FINANCING_PLAN_ID=inupldi);
vl number;
rpta varchar2(4000) :='';
begin
     vl:=0;
     for l in locas loop
         if l.m=-1 or l.m=inuloca then
            vl:=1;
         end if;
     end loop;
     if vl=0 then
        rpta:=rpta||'La localidad del producto al momento de crear el diferido no aplica a las localidades asociadas las segmentaciones comerciales asociadas al plan de diferido.';
     end if;
     vl:=0;

     for c in cucategorias loop
         if c.g=-1 or c.g=inucategoria then
            vl:=1;
         end if;
     end loop;
     if vl=0 then
        rpta:=rpta||' La categoria del producto al momento de crear el diferido no aplica a las categorias asociadas las segmentaciones comerciales asociadas al plan de diferido.';
     end if;
     vl:=0;

     for s in cuestadocorte loop
         if s.cq=-1 or s.cq=inuestadocorte then
            vl:=1;
         end if;
     end loop;
     if vl=0 then
        rpta:=rpta||' El estado de corte del producto al momento de crear el diferido no aplica a los estados de corte asociados las segmentaciones comerciales asociadas al plan de diferido.';
     end if;
     vl:=0;

     for y in cuestadofinanciero loop
         if y.ef='-' or y.ef=sbestadofinanciero then
            vl:=1;
         end if;
     end loop;
     if vl=0 then
        rpta:=rpta||' El estado financiero del producto al momento de crear el diferido no aplica a los estados financieros asociados las segmentaciones comerciales asociadas al plan de diferido.';
     end if;


     if rpta='' or rpta is null then

        rpta:='Diferido cumple condiciones de segmentacion comercial al momento de crear el diferido';
     end if;

     return(rpta);
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCVALCUMPLDIFSEGMCOM', 'ADM_PERSON');
END;
/