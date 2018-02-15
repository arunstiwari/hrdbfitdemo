create or replace PACKAGE emp_mgmt AS

    FUNCTION validate_manager_id(manager_id NUMBER)
       RETURN BOOLEAN;
       
     FUNCTION validate_department_id(department_id NUMBER)
       RETURN BOOLEAN;
       
    FUNCTION validate_employee_id(employee_id NUMBER)
       RETURN BOOLEAN;
       
    FUNCTION validate_location_id(location_id NUMBER)
       RETURN BOOLEAN;


   FUNCTION hire (first_name VARCHAR2,last_name VARCHAR2,phone_number VARCHAR2,hire_date DATE, job_id VARCHAR2,
      manager_id NUMBER, salary NUMBER,
      commission_pct NUMBER, department_id NUMBER)
      RETURN NUMBER;

   FUNCTION create_dept(department_name VARCHAR2, manager_id NUMBER, location_id NUMBER)
      RETURN NUMBER;

   PROCEDURE remove_emp(employee_id NUMBER);

   PROCEDURE remove_dept(department_id NUMBER);

   PROCEDURE increase_sal(employee_id NUMBER, salary_incr NUMBER);

   PROCEDURE increase_comm(employee_id NUMBER, comm_incr NUMBER);

   no_comm EXCEPTION;
   PRAGMA EXCEPTION_INIT (no_comm, -5999);
   no_sal EXCEPTION;
   PRAGMA EXCEPTION_INIT (no_sal, -6000);
   invalid_manager_id EXCEPTION;
   PRAGMA EXCEPTION_INIT(invalid_manager_id, -6001);   
   invalid_department_id EXCEPTION;
   PRAGMA EXCEPTION_INIT(invalid_department_id, -6002);
   invalid_argument EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_argument, -6003);
   invalid_employee_id EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_employee_id, -6004);
   invalid_location_id EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_location_id, -6005);
   

END emp_mgmt;
