PL/SQL Developer Test script 3.0
9
begin
  -- Call the procedure
  "OPEN".ldc_envianotifsolemergencia(inupackageid => :inupackageid,
                                   inucontrato => :inucontrato,
                                   inucausal => :inucausal,
                                   inupacktype => :inupacktype,
                                   idtrequest => :idtrequest,
                                   isbcomment => :isbcomment);
end;
6
inupackageid
1
-1
4
inucontrato
1
-1
4
inucausal
1
-1
3
inupacktype
1
-1
4
idtrequest
0
12
isbcomment
0
5
0
