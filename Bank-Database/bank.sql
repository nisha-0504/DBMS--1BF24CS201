create database bank;
show databases;
use bank;
create table branch(branch_name varchar(20),branch_city varchar(20),assets real,primary key(branch_name));
desc branch;
create table bank_account(acc_no int,branch_name varchar(20),balance real,primary key(acc_no),foreign key(branch_name) references branch(branch_name));
desc bank_account;
create table bank_customer(customer_name varchar(20),customer_street varchar(30),customer_city varchar(20),primary key(customer_name));
desc bank_customer;
create table depositor(customer_name varchar(30),acc_no int,primary key(acc_no),foreign key(acc_no) references bank_account(acc_no),foreign key(customer_name) references bank_customer(customer_name));
desc depositor;
create table loan(loan_no int,branch_name varchar(20),amount int,primary key(loan_no),foreign key(branch_name) references branch(branch_name));
desc loan;
insert into branch values("SBI_Chamrajpet","Bangalore",50000);
insert into branch values("SBI_ResidencyRoad","Bangalore",10000);
insert into branch values("SBI_ShivajiRoad","Bombay",20000);
insert into branch values("SBI_ParliamentRoad","Delhi",10000);
insert into branch values("SBI_Jantarmantar","Delhi",20000);
select * from branch;
insert into bank_account values(1,"SBI_Chamrajpet",2000);
insert into bank_account values(2,"SBI_ResidencyRoad",5000);
insert into bank_account values(3,"SBI_ShivajiRoad",6000);
insert into bank_account values(4,"SBI_ParliamentRoad",9000);
insert into bank_account values(5,"SBI_Jantarmantar",8000);
insert into bank_account values(6,"SBI_ShivajiRoad",4000);
insert into bank_account values(8,"SBI_ResidencyRoad",4000);
insert into bank_account values(9,"SBI_ParliamentRoad",3000);
insert into bank_account values(10,"SBI_ResidencyRoad",5000);
insert into bank_account values(11,"SBI_Jantarmantar",2000);
select * from bank_account;
insert into bank_customer values("Avinash","Bull_temple_road","Bangalore");
insert into bank_customer values("Dinesh","Bannerghatta_road","Bangalore");
insert into bank_customer values("Mohan","National_college_road","Bangalore");
insert into bank_customer values("Nikil","Akbar_road","Delhi");
insert into bank_customer values("Ravi","Prithviraj_road","Delhi");
select * from bank_customer;
insert into depositor values("Avinash",1);
insert into depositor values("Dinesh",2);
insert into depositor values("Nikil",4);
insert into depositor values("Ravi",5);
insert into depositor values("Avinash",8);
insert into depositor values("Nikil",9);
insert into depositor values("Dinesh",10);
insert into depositor values("Nikil",11);
select * from depositor;
insert into loan values(1,"SBI_Chamrajpet",1000);
insert into loan values(2,"SBI_ResidencyRoad",2000);
insert into loan values(3,"SBI_ShivajiRoad",3000);
insert into loan values(4,"SBI_ParliamentRoad",4000);
insert into loan values(5,"SBI_Jantarmantar",5000);
select * from loan;
select d.customer_name,b.branch_name from depositor d join bank_account b on d.acc_no=b.acc_no group by d.customer_name,b.branch_name having count(b.acc_no)>=2;
select branch_name,(assets/100000) as assets_in_lakh from branch;
select d.customer_name,b.branch_name from depositor d join bank_account b on d.acc_no=b.acc_no group by d.customer_name,b.branch_name having count(d.acc_no)>=2;
create view Branch_loan_info AS SELECT branch_name,sum(amount) AS total_loan_amount FROM loan group by branch_name;
Select * from Branch_loan_info;
update bank_account set balance=balance*1.05;
select * from bank_account;
SELECT d.customer_name
FROM depositor d
JOIN bank_account ba ON d.acc_no = ba.acc_no
JOIN branch b ON ba.branch_name = b.branch_name
WHERE b.branch_city = 'Delhi'
GROUP BY d.customer_name
HAVING COUNT(DISTINCT b.branch_name) =
       (SELECT COUNT(*) FROM branch WHERE branch_city = 'Delhi');
SELECT DISTINCT l.loan_no
FROM loan l
WHERE l.loan_no NOT IN (
    SELECT d.acc_no
    FROM depositor d
);
SELECT DISTINCT d.customer_name
FROM depositor d
JOIN bank_account ba ON d.acc_no = ba.acc_no
JOIN loan l ON ba.branch_name = l.branch_name
JOIN branch b ON ba.branch_name = b.branch_name
WHERE b.branch_city = 'Bangalore';


select b1.branch_name from branch b1 where b1.assets>all(select b2.assets from branch b2 where b2.branch_city="Bangalore");
DELETE FROM bank_account
WHERE branch_name IN (
    SELECT branch_name
    FROM branch
    WHERE branch_city = 'Bombay'
);
select * from bank_account;
