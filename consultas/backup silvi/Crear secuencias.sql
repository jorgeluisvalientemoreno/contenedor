create sequence SSJ_TYPE_SEC start with 1 increment by 1;
create sequence SSJ_EVENT_SEC start with 1 increment by 1;
create sequence SSJ_HISTORIC_SEC start with 1 increment by 1;
create sequence SSJ_AVAILABILITY_SEC start with 1 increment by 1;

SELECT *
FROM SSJ_AVAILABILITY
FOR UPDATE 
