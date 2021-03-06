
  CREATE TABLE "HR"."EMPLOYEES_STG"
   (	"EMPLOYEE_ID" NUMBER(6,0),
	"FIRST_NAME" VARCHAR2(20 BYTE),
	"LAST_NAME" VARCHAR2(25 BYTE),
	"EMAIL" VARCHAR2(25 BYTE),
	"PHONE_NUMBER" VARCHAR2(20 BYTE),
	"HIRE_DATE" DATE,
	"JOB_ID" VARCHAR2(10 BYTE),
	"SALARY" NUMBER(8,2),
	"COMMISSION_PCT" NUMBER(2,2),
	"MANAGER_ID" NUMBER(6,0),
	"DEPARTMENT_ID" NUMBER(4,0)
   ) ;


  ALTER TABLE "HR"."EMPLOYEES_STG" ADD CONSTRAINT "EMP_SALARY_MIN_STG" CHECK (salary > 0) ENABLE;
  ALTER TABLE "HR"."EMPLOYEES_STG" MODIFY ("JOB_ID" CONSTRAINT "EMP_JOB_NN" NOT NULL ENABLE);
  ALTER TABLE "HR"."EMPLOYEES_STG" MODIFY ("HIRE_DATE" CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL ENABLE);
  ALTER TABLE "HR"."EMPLOYEES_STG" MODIFY ("EMAIL" CONSTRAINT "EMP_EMAIL_NN" NOT NULL ENABLE);
  ALTER TABLE "HR"."EMPLOYEES_STG" MODIFY ("LAST_NAME" CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL ENABLE);

  INSERT INTO EMPLOYEES_STG SELECT * FROM EMPLOYEES;
