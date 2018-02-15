create or replace PACKAGE BODY emp_mgmt AS
   tot_emps NUMBER;
   tot_depts NUMBER;
   
FUNCTION validate_manager_id(manager_id NUMBER)
    RETURN BOOLEAN IS invalid BOOLEAN;
    no_of_count NUMBER;
BEGIN 
  if(manager_id <= 0) THEN
    invalid := TRUE;
--    RAISE invalid_manager_id;
   ELSE
     SELECT COUNT(*) INTO no_of_count from EMPLOYEES where Employees.manager_id = validate_manager_id.manager_id;
     IF (no_of_count > 0) THEN
        invalid := FALSE;
       
        else
         invalid := TRUE;
     END IF;
  END IF;
   return (invalid);
--  EXCEPTION WHEN invalid_manager_id then
--    RAISE_APPLICATION_ERROR(-20001,'Invalid Manager Id');
END;

 FUNCTION validate_department_id(department_id NUMBER)
    RETURN BOOLEAN IS invalid BOOLEAN;
        no_of_count NUMBER;
BEGIN
    
  if(department_id <= 0) THEN
    invalid := TRUE;
   ELSE
     SELECT COUNT(*) INTO no_of_count from Departments where Departments.department_id = validate_department_id.department_id;
     IF no_of_count > 0 THEN
        invalid := FALSE;
    else
        invalid := TRUE;
     END IF;
  END IF;
  return(invalid);
END;

 FUNCTION validate_employee_id(employee_id NUMBER)
    RETURN BOOLEAN IS invalid BOOLEAN;
        no_of_count NUMBER;
BEGIN
    
  if(employee_id <= 0) THEN
    invalid := TRUE;
   ELSE
     SELECT COUNT(*) INTO no_of_count from Employees where Employees.employee_id = validate_employee_id.employee_id;
     IF no_of_count > 0 THEN
        invalid := FALSE;
    else
        invalid := TRUE;
     END IF;
  END IF;
  return(invalid);
END;
    
  FUNCTION validate_location_id(location_id NUMBER)
    RETURN BOOLEAN IS invalid BOOLEAN;
        no_of_count NUMBER;
BEGIN
    
  if(location_id <= 0) THEN
    invalid := TRUE;
   ELSE
     SELECT COUNT(*) INTO no_of_count from Locations where Locations.location_id = validate_location_id.location_id;
     IF no_of_count > 0 THEN
        invalid := FALSE;
    else
        invalid := TRUE;
     END IF;
  END IF;
  return(invalid);
END;

FUNCTION hire
   (first_name VARCHAR2,last_name VARCHAR2,phone_number VARCHAR2, hire_date DATE, job_id VARCHAR2,
    manager_id NUMBER, salary NUMBER,
    commission_pct NUMBER, department_id NUMBER)
   RETURN NUMBER IS new_empno NUMBER;
   invalid_manager BOOLEAN := FALSE;
   invalid_department BOOLEAN := FALSE;
   
BEGIN
    if(first_name IS NULL) OR (first_name ='') then
      RAISE invalid_argument;
    else
    invalid_manager := validate_manager_id(hire.manager_id);
     if (invalid_manager) THEN
       RAISE invalid_manager_id;
     else 
        invalid_department := validate_department_id(hire.department_id);
        if(invalid_department) THEN
         RAISE invalid_department_id;
        else 
            SELECT employees_seq.NEXTVAL
            INTO new_empno
            FROM DUAL;
            INSERT INTO employees
                VALUES (new_empno, first_name, last_name,first_name||last_name||'@oracle.com',
                phone_number,hire_date,job_id,salary,commission_pct,
                manager_id,department_id);
                tot_emps := tot_emps + 1;
            RETURN(new_empno);
        END IF;
    END IF;
  END IF;
END;
FUNCTION create_dept(department_name VARCHAR2, manager_id NUMBER, location_id NUMBER)
   RETURN NUMBER IS
      new_deptno NUMBER;
      invalid_manager BOOLEAN;
      invalid_location BOOLEAN;
   BEGIN
    invalid_manager := validate_manager_id(create_dept.manager_id);
     IF (invalid_manager) THEN
       RAISE invalid_manager_id;
     ELSE
       invalid_location := validate_location_id(create_dept.location_id);
       IF (invalid_location) THEN
        RAISE invalid_location_id;
       ELSE
        SELECT departments_seq.NEXTVAL
         INTO new_deptno
         FROM dual;
        INSERT INTO departments
         VALUES (new_deptno, department_name, manager_id, location_id);
        tot_depts := tot_depts + 1;
        RETURN(new_deptno);
       END IF;
    END IF;
   END;
   
PROCEDURE remove_emp (employee_id NUMBER) IS
   BEGIN
      if (validate_employee_id(remove_emp.employee_id)) THEN
        RAISE invalid_employee_id;
      ELSE
       DELETE FROM employees
          WHERE employees.employee_id = remove_emp.employee_id;
        tot_emps := tot_emps - 1;
     END IF;
   END;
   
PROCEDURE remove_dept(department_id NUMBER) IS
   BEGIN
      IF (validate_department_id(remove_dept.department_id)) THEN
        RAISE invalid_department_id;
      ELSE
        DELETE FROM departments
        WHERE departments.department_id = remove_dept.department_id;
        tot_depts := tot_depts - 1;
        SELECT COUNT(*) INTO tot_emps FROM employees;
     END IF;
   END;
PROCEDURE increase_sal(employee_id NUMBER, salary_incr NUMBER) IS
   curr_sal NUMBER;
   BEGIN
      SELECT salary INTO curr_sal FROM employees
      WHERE employees.employee_id = increase_sal.employee_id;
      IF curr_sal IS NULL
         THEN RAISE no_sal;
      ELSE
         UPDATE employees
         SET salary = salary + salary_incr
         WHERE employee_id = employee_id;
      END IF;
   END;
PROCEDURE increase_comm(employee_id NUMBER, comm_incr NUMBER) IS
   curr_comm NUMBER;
   BEGIN
      SELECT commission_pct
      INTO curr_comm
      FROM employees
      WHERE employees.employee_id = increase_comm.employee_id;
      IF curr_comm IS NULL
         THEN RAISE no_comm;
      ELSE
         UPDATE employees
         SET commission_pct = commission_pct + comm_incr;
      END IF;
   END;
END emp_mgmt;
