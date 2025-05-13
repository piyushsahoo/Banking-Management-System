CREATE DATABASE bankdb;
use bankdb;
create table customer(
cust_no varchar(5) primary key,
check (cust_no like 'C____'),
name varchar(30) not null,
phone_no varchar(10),
city varchar(20) not null
);
create table branch(
branch_code varchar(5) primary key,
branch_name varchar(30) not null,
branch_city varchar(30),
check (branch_city in ('DELHI', 'MUMBAI','KOLKATA','CHENNAI'))
);
create table account(
account_no varchar(5) primary key,
check (account_no like 'A____'),
type varchar(2) check (type in ('SB','FD','CA')),
balance int check(balance < 10000000),
branch_code varchar(5) references branch(branch_code)
);
create table depositor(
cust_no varchar(5) references customer(cust_no),
account_no varchar(5) references account(account_no),
primary key(cust_no,account_no)
);
create table loan(
loan_no varchar(5) primary key,
check(loan_no like 'L____'),
cust_no varchar(5) references customer(cust_no),
amount int check (amount > 1000),
branch_code varchar(5) references branch(branch_code)
);
create table installment(
inst_no int check(inst_no <= 10),
loan_no varchar(5) references loan(loan_no),
inst_amount int not null,
primary key(inst_no,loan_no)
);

INSERT INTO branch (branch_code, branch_name, branch_city) VALUES
  ('B001', 'JANAKPURI BRANCH',     'DELHI'),
  ('B002', 'CHANDNICHOWK BRANCH',  'DELHI'),
  ('B003', 'JUHU BRANCH',          'MUMBAI'),
  ('B004', 'ANDHERI BRANCH',       'MUMBAI'),
  ('B005', 'SALTLAKE BRANCH',      'KOLKATA'),
  ('B006', 'SRIRAMPURAM BRANCH',   'CHENNAI');

INSERT INTO customer (cust_no, name, phone_no, city) VALUES
  ('C0001', 'RAJ ANAND SINGH',   '9861258466', 'DELHI'),
  ('C0002', 'ANKITA SINGH',      '9879958651', 'BANGALORE'),
  ('C0003', 'SOUMYA JHA',        '9885623344', 'MUMBAI'),
  ('C0004', 'ABHIJIT MISHRA',    '9455845425', 'MUMBAI'),
  ('C0005', 'YASH SARAF',        '9665854585', 'KOLKATA'),
  ('C0006', 'SWAROOP RAY',       '9437855466', 'CHENNAI'),
  ('C0007', 'SURYA NARAYAN',     '9937955212', 'GURGAON'),
  ('C0008', 'PRANAV PRAVEEN',    '9336652441', 'PUNE'),
  ('C0009', 'STUTI MISRA',       '7870266534', 'DELHI'),
  ('C0010', 'ASLESHA TIWARI',    NULL,         'MUMBAI');

INSERT INTO account (account_no, type, balance, branch_code) VALUES
  ('A0001', 'SB', 200000, 'B003'),
  ('A0002', 'SB',  15000, 'B002'),
  ('A0003', 'CA', 850000, 'B004'),
  ('A0004', 'CA',  35000, 'B004'),
  ('A0005', 'FD',  28500, 'B005'),
  ('A0006', 'FD', 550000, 'B005'),
  ('A0007', 'SB',  48000, 'B001'),
  ('A0008', 'SB',   7200, 'B002'),
  ('A0009', 'SB',  18750, 'B003'),
  ('A0010', 'FD',  99000, 'B004');

INSERT INTO depositor (cust_no, account_no) VALUES
  ('C0003','A0001'),
  ('C0004','A0001'),
  ('C0004','A0002'),
  ('C0006','A0003'),
  ('C0006','A0004'),
  ('C0001','A0005'),
  ('C0002','A0005'),
  ('C0010','A0006'),
  ('C0009','A0007'),
  ('C0008','A0008'),
  ('C0007','A0009'),
  ('C0006','A0010');

  INSERT INTO loan (loan_no, cust_no, amount, branch_code) VALUES
  ('L0001', 'C0005', 3000000, 'B006'),
  ('L0002', 'C0001',   50000, 'B005'),
  ('L0003', 'C0002', 8000000, 'B004'),
  ('L0004', 'C0010',  100000, 'B004'),
  ('L0005', 'C0009', 9500000, 'B005'),
  ('L0006', 'C0008',   25000, 'B006');

  INSERT INTO installment (inst_no, loan_no, inst_amount) VALUES
  (1, 'L0005', 500000),
  (1, 'L0002',  10000),
  (1, 'L0003',  50000),
  (1, 'L0004',  20000),
  (2, 'L0005', 500000),
  (1, 'L0006',   3000),
  (2, 'L0002',  10000),
  (3, 'L0002',  10000),
  (2, 'L0003',  50000),
  (2, 'L0004',  20000);
