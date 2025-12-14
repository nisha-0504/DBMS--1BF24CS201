create database Employee;
show databases;
use Employee;
create table dept(deptno int,dname varchar(50),dloc varchar(50),primary key(deptno));
desc dept;
create table employee(empno int,ename varchar(50),mgr_no int,hiredate date,sal decimal(10,2),deptno int,primary key(empno),foreign key(deptno) references dept(deptno));
desc employee;
create table project(pno int,ploc varchar(50),pname varchar(50),primary key(pno));
desc project;
create table assigned_to(empno int,pno int,job_role varchar(50),foreign key(empno) references employee(empno),foreign key(pno) references project(pno));
desc assigned_to;
create table incentives(empno int,incentive_date date,incentive_amount decimal(10,2),primary key(incentive_date),foreign key(empno) references employee(empno));
desc incentives;
insert into dept values (10,'Research','Bangalore'),(20,'Sales','Hyderabad'),(30,'Production','Mysuru'),(40,'HR','Chennai'),(50,'Finance','Hyderabad'),(60,'Marketing','Mysuru');
select * from dept;
insert into employee values(101,'Alisha',Null,'2015-01-10',8000.00,10),(102,'Bobby',101,'2016-05-15',5500.00,10),(103,'Charlie',101,'2017-08-20',6000.00,20),(104,'Dravid',103,'2018-03-01',5000.00,20),(105,"Eisha",102,'2015-01-25',3500.00,30),(106,"Farah",101,'2017-04-03',6500.00,40),(107,'Garima',105,'2021-09-12',3000.00,30);
select * from employee;
insert into project values(1,"Bangalore","Alpha"),(2,"Hyderabad",'beta'),(3,'Mysuru','gamma'),(4,'Chennai','delta'),(5,'Bengaluru','epsilon'),(6,'Hyderabad','phi');
select * from project;
insert into assigned_to values(101,1,'Project Lead'),(102,2,'Developer'),(103,2,'Texter'),(104,3,'Analyst'),(105,5,'Developer'),(106,4,'HR Specialist');
select * from assigned_to;
insert into incentives values(101,'2023-01-01',500.00),(103,'2023-02-01',350.0),(104,'2023-03-01','400.00'),(105,'2019-01-31',250.00),(107,'2019-01-11',520.00),(103,'2019-01-21',550.00);
select * from incentives;
select e.empno from employee e,dept d where e.deptno=d.deptno and d.dloc in('Bangalore','Hyderabad','Mysuru');
select empno from employee where empno not in(select empno from incentives);
SELECT e.ename,
       e.empno,
       d.dname,
       a.job_role,
       d.dloc,
       p.ploc
FROM employee e
JOIN dept d ON e.deptno = d.deptno
JOIN assigned_to a ON e.empno = a.empno
JOIN project p ON a.pno = p.pno
WHERE d.dloc = p.ploc;
SELECT m.ename
FROM employee m
JOIN employee e ON m.empno = e.mgr_no
GROUP BY m.empno, m.ename
HAVING COUNT(e.empno) = (
    SELECT MAX(emp_count)
    FROM (
        SELECT COUNT(empno) AS emp_count
        FROM employee
        WHERE mgr_no IS NOT NULL
        GROUP BY mgr_no
    ) t
);

SELECT m.ename
FROM employee m
JOIN employee e ON m.empno = e.mgr_no
GROUP BY m.empno, m.ename, m.sal
HAVING m.sal > AVG(e.sal);
SELECT e.ename, d.dname
FROM employee e
JOIN dept d ON e.deptno = d.deptno
WHERE e.mgr_no IS NULL
AND e.sal < (
    SELECT MAX(sal)
    FROM employee
    WHERE mgr_no IS NULL
    AND deptno = e.deptno
);
SELECT *
FROM incentives
WHERE incentive_date BETWEEN '2019-01-01' AND '2019-01-31'
AND incentive_amount = (
    SELECT MAX(incentive_amount)
    FROM incentives
    WHERE incentive_date BETWEEN '2019-01-01' AND '2019-01-31'
    AND incentive_amount < (
        SELECT MAX(incentive_amount)
        FROM incentives
        WHERE incentive_date BETWEEN '2019-01-01' AND '2019-01-31'
    )
);
SELECT e.ename
FROM employee e
JOIN employee m ON e.mgr_no = m.empno
WHERE e.deptno = m.deptno;




