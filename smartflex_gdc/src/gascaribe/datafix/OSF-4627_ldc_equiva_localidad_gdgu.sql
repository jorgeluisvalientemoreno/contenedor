declare
 nuConta  NUMBER;


CURSOR cuExiste(nuUbicacion NUMBER) IS
  SELECT COUNT(1)
  FROM LDC_EQUIVA_LOCALIDAD
  WHERE GEOGRAP_LOCATION_ID = nuUbicacion;
  
BEGIN

OPEN cuExiste(9265); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9265,'44','001','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9038); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9038,'44','430','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9315); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9315,'44','090','004','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9340); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9340,'44','090','003','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9326); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9326,'44','001','003','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9013); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9013,'44','090','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9212); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9212,'44','847','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9104); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9104,'44','560','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9016); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9016,'44','378','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9173); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9173,'44','078','006','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9223); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9223,'44','078','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9121); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9121,'44','279','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9196); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9196,'44','650','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9021); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9021,'44','110','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9077); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9077,'44','874','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9329); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9329,'44','855','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9137); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9137,'44','098','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9001); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9001,'44','098','001','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9090); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9090,'44','035','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9152); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9152,'44','035','001','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9101); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9101,'44','090','001','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9170); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9170,'44','090','002','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9320); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9320,'44','090','006','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9190); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9190,'44','420','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9007); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9007,'44','560','003','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9010); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9010,'44','650','012','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9351); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9351,'44','001','033','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(8998); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (8998,'44','001','027','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9164); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9164,'44','001','021','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9256); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9256,'44','001','020','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9004); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9004,'44','001','028','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9143); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9143,'44','001','011','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9247); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9247,'44','001','040','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9209); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9209,'44','001','025','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9300); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9300,'44','430','007','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9334); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9334,'44','078','009','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9074); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9074,'44','279','005','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9155); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9155,'44','001','028','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9134); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9134,'44','035','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9071); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9071,'44','560','001','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9262); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9262,'44','001','037','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9253); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9253,'44','430','002','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9161); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9161,'44','078','001','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9184); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9184,'44','078','013','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9032); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9032,'44','279','002','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9244); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9244,'44','001','026','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9181); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9181,'44','650','001','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9187); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9187,'44','650','008','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9193); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9193,'44','650','014','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9235); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9235,'44','650','005','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9095); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9095,'44','650','009','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9178); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9178,'44','650','019','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9109); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9109,'44','090','005','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9238); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9238,'44','098','002','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9149); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9149,'44','650','013','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9146); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9146,'44','650','021','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9217); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9217,'44','001','012','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9026); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9026,'44','001','008','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9241); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9241,'44','001','001','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9115); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9115,'44','001','016','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9029); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9029,'44','001','002','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9035); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9035,'44','001','005','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9098); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9098,'44','001','017','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9348); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9348,'44','001','031','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9140); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9140,'44','078','007','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9250); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9250,'44','078','014','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9303); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9303,'44','078','015','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9112); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9112,'44','078','016','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9167); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9167,'44','650','003','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9259); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9259,'44','650','006','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9312); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9312,'44','650','007','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9323); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9323,'44','650','011','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9357); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9357,'44','650','017','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9345); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9345,'44','650','018','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9354); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9354,'44','001','022','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9306); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9306,'44','001','024','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9220); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9220,'44','001','035','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9337); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9337,'44','098','008','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9118); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9118,'44','001','012','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9158); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9158,'44','078','000','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9232); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9232,'44','078','011','N');
END IF;
----------------------------------------------------------------
OPEN cuExiste(9309); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN 
INSERT INTO LDC_EQUIVA_LOCALIDAD VALUES (9309,'44','650','018','N');
END IF;
----------------------------------------------------------------
COMMIT;

END;
/