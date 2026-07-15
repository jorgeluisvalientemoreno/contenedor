
DECLARE

    CURSOR periodos IS
     SELECT DISTINCT PEFACODI ,PECSCONS ,ciclo, pefaano
        FROM open.pericose pc  
        inner join open.perifact pf on pc.pecscico = pf.pefacicl and pc.pecsfecf between pf.pefafimo and pf.pefaffmo 
        inner JOIN open.ciclo_facturacion on ciclo= pefacicl and empresa='GDGU'
        WHERE not exists ( select NULL from procejec pc2 where pc2.prejcope= pf.pefacodi and pc2.prejprog = 'FCRI')
        and pc.pecsflav='S' and pc.pecsproc='S' 
        and pc.pecsfecf>=trunc(sysdate)
        order by ciclo ;



BEGIN
 FOR rec IN periodos LOOP
  UPDATE open.pericose p
  SET pecsflav='N', pecsproc='N'
  WHERE PECSCONS = rec.PECSCONS;

  DBMS_OUTPUT.PUT_LINE('Actualizado PECSCONS: ' || rec.PECSCONS);
 END LOOP;

COMMIT;
END;
