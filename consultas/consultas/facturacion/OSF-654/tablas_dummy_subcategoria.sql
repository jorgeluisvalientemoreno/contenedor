select *
from coprsuca 
where cpscubge = 55
for update 
 
CREATE TABLE ldc_coprsuca_sil ( cpsccons  number(10) ,
cpsccate number(2) ,
cpscsuca  number(2) ,
cpscubge number(6) ,
cpscanco number(4) ,
 cpscmeco number(2) ,
 cpscprod number(7) ,
 cpscprdi number(15,3) ,
 cpsccoto number(15,3) )
 
 CREATE TABLE coprsuca_sil ( cpsccate number(2) ,
 cpscsuca number(2) ,
 cpsctcon number(4) ,
 cpscubge  number(6) ,
 cpscanco number(4) ,
 cpscmeco  number(2) ,
 cpsccons  number(10) ,
 cpscprod number(7) ,
 cpscprdi number(15,3) ,
 cpsccoto  number(15,3) )

 DELETE FROM ldc_coprsuca WHERE cpscubge = 55
 
INSERT INTO ldc_coprsuca (cpsccons  ,cpsccate ,cpscsuca,cpscubge ,cpscanco , cpscmeco , cpscprod  , cpscprdi , cpsccoto )
select cpsccons ,cpsccate ,cpscsuca ,cpscubge ,cpscanco ,cpscmeco ,cpscprod ,cpscprdi ,cpsccoto 
from ldc_coprsuca_sil 
where cpscubge = 55
 ;
 
 INSERT INTO coprsuca (cpsccate,cpscsuca , cpsctcon , cpscubge  , cpscanco , cpscmeco , cpsccons , cpscprod , cpscprdi , cpsccoto )
select cpsccate,cpscsuca , cpsctcon , cpscubge  , cpscanco , cpscmeco , cpsccons , cpscprod , cpscprdi , cpsccoto
from coprsuca_sil
where cpscubge = 55
