
clear scree;
set verify off;
set serveroutput on;

drop table BundesLiga CASCADE CONSTRAINTS;
drop table SeriaA CASCADE CONSTRAINTS;

drop sequence B;
drop sequence S;

--create Bundesliga Table with Primary key auto increment--
create table BundesLiga(
	bID int not null,
	Country Varchar2(20),
	Name varchar2(20),
	Points number,
	Year_Goal number,
	constraint BundesLiga_PK primary key (bID)
	);
create sequence B;
create or replace trigger BundesLiga_Trig
before insert on BundesLiga
for each row
begin
	select B.nextval into :new.bID from dual;
end;
/

--create SeriaA Table with Primary key auto increment--
create table SeriaA(
	sID int not null,
	Country varchar2(20),
	Name varchar2(20),
	Points number,
	Year_Goal number,
	constraint SeriaA_PK primary key(sID)
	);
create sequence S;
create or replace trigger SeriaA_Trg
before insert on SeriaA
for each row
begin
	select S.nextval into :new.sID from dual;
end;
/


--Bundesliga Standing--
insert into Bundesliga(Country, Name, Points,Year_Goal) values ('Germany','Bayern Munchen',98,120);
insert into Bundesliga(Country, Name, Points,Year_Goal) values ('Germany','Borussia Dortmund',95,110);
insert into Bundesliga(Country, Name, Points,Year_Goal) values ('Germany','RB LeipZig',90,115);
insert into Bundesliga(Country, Name, Points,Year_Goal) values ('Germany','Sc Frelburg',84,98);
insert into Bundesliga(Country, Name, Points,Year_Goal) values ('Germany','Bayer 04 Leverkusen',81,101);
insert into Bundesliga(Country, Name, Points,Year_Goal) values ('Germany','1899 Hoffenheim',80,80);
insert into Bundesliga(Country, Name, Points,Year_Goal) values ('Germany','Bochum',72,65);
insert into Bundesliga(Country, Name, Points,Year_Goal) values ('Germany','Wolfsburg',70,90);
insert into Bundesliga(Country, Name, Points,Year_Goal) values ('Germany','FC Koin',69,76);
insert into Bundesliga(Country, Name, Points,Year_Goal) values ('Germany','FSV Mainz 05',68,82);

--Seria A Standing--
insert into SeriaA(Country, Name, Points,Year_Goal) values ('Italy','Inter Milan',96,111);
insert into SeriaA(Country, Name, Points,Year_Goal) values ('Italy','AC Milan',92,102);
insert into SeriaA(Country, Name, Points,Year_Goal) values ('Italy','Juventus',86,105);
insert into SeriaA(Country, Name, Points,Year_Goal) values ('Italy','Napoli',85,110);
insert into SeriaA(Country, Name, Points,Year_Goal) values ('Italy','Lazio',78,96);
insert into SeriaA(Country, Name, Points,Year_Goal) values ('Italy','Roma',60,90);
insert into SeriaA(Country, Name, Points,Year_Goal) values ('Italy','Verona',55,80);
insert into SeriaA(Country, Name, Points,Year_Goal) values ('Italy','Torino',52,92);
insert into SeriaA(Country, Name, Points,Year_Goal) values ('Italy','Atalanta',51,78);
insert into SeriaA(Country, Name, Points,Year_Goal) values ('Italy','Florentina',50,60);


--collect data in siteA--
set linesize 500;
select * from LaLiga@siteA_Link;
select * from PremierLeague@siteA_Link;
select * from BundesLiga;
select * from SeriaA;

--All team in top four league--
select Country,Name,Points from LaLiga@siteA_Link
union
select Country,Name,Points from PremierLeague@siteA_Link
UNION
select Country,Name,Points from BundesLiga
UNION
select Country,Name,Points from SeriaA;


Select * from LaLiga@siteA_Link order by points desc;
Select * from PremierLeague@siteA_Link order by points desc;
Select * from BundesLiga order by points desc;
Select * from SeriaA order by points desc;


create or replace view ChampionsLeague as
SELECT Country,Name,Points FROM
(Select * from LaLiga@siteA_Link order by points desc) 
WHERE ROWNUM <=4
UNION
SELECT Country,Name,Points FROM 
(Select * from PremierLeague@siteA_Link order by points desc) 
WHERE ROWNUM <=4
UNION
SELECT Country,Name,Points FROM 
(Select * from BundesLiga order by points desc) 
WHERE ROWNUM <=4
UNION
SELECT Country,Name,Points FROM 
(Select * from SeriaA order by points desc) 
WHERE ROWNUM <=4;


create or replace view TopGoal as
SELECT Country,Name,Points,Year_Goal FROM 
(SELECT * FROM LaLiga@siteA_Link order by Year_Goal desc)
UNION
SELECT Country,Name,Points,Year_Goal FROM 
(SELECT * FROM PremierLeague@siteA_Link order by Year_Goal desc)
UNION
SELECT Country,Name,Points,Year_Goal FROM
(SELECT * FROM BundesLiga order by Year_Goal desc)
UNION
SELECT Country,Name,Points,Year_Goal FROM 
(SELECT * FROM SeriaA order by Year_Goal desc);



Select * from ChampionsLeague 
order by Country,points desc ;


select * from TopGoal 
order by Year_Goal DESC;



drop table PotA;
drop table PotB;
drop table PotC;
drop table PotD;
drop sequence PA;
drop sequence PB;
drop sequence PC;
drop sequence PD;



--create Pot A table with primary key auto increment--
create table PotA(
	aID int,
	Country VARCHAR2(20),
	Name VARCHAR2(20) unique,
	Points number,
	Position number,
	CONSTRAINT PotA_PK PRIMARY KEY (aID)
	);
create sequence PA;
create or replace trigger PA_Trig
before insert on PotA
for each row
begin
	select PA.nextval into :new.aID from DUAL;
end;
/

--create Pot B table with primary key auto increment--
create table PotB(
	bID int,
	Country VARCHAR2(20),
	Name VARCHAR2(20) unique,
	Points number,
	Position number,
	CONSTRAINT PotB_PK PRIMARY KEY (bID)
	);
create sequence PB;
create or replace trigger PB_Trig
before insert on PotB
for each row
begin
	select PB.nextval into :new.bID from DUAL;
end;
/

--create Pot C table with primary key auto increment--
create table PotC(
	cID int,
	Country VARCHAR2(20),
	Name VARCHAR2(20) unique, 
	Points number,
	Position number,
	CONSTRAINT PotC_PK PRIMARY KEY (cID)
	);
create sequence PC;
create or replace trigger PC_Trig
before insert on PotC
for each row
begin
	select PC.nextval into :new.cID from DUAL;
end;
/

--create Pot D table with primary key auto increment--
create table PotD(
	dID int,
	Country VARCHAR2(20),
	Name VARCHAR2(20) unique, 
	Points number,
	Position number,
	CONSTRAINT PotD_PK PRIMARY KEY (dID)
	);
create sequence PD;
create or replace trigger PD_Trig
before insert on PotD
for each row
begin
	select PD.nextval into :new.dID from DUAL;
end;
/


--LA LIGA--
DECLARE
	C varchar2(20);
	N varchar2(20);
	K int;
	P number;
	x int;
BEGIN
	FOR i in (SELECT lid,Country,Name,Points FROM (Select * from LaLiga@siteA_Link order by points desc) 
	WHERE ROWNUM <=4) LOOP
		K:=i.lid;
		C:=i.Country;
		N:=i.Name;
		P:=i.Points;
		CASE K
			when 1 then
				insert into PotA(Country, Name, Points,Position) values (C,N,P,1);
			when 2 then 
				insert into PotB(Country, Name, Points,Position) values (C,N,P,2);
			when 3 then
				insert into PotC(Country, Name, Points,Position) values (C,N,P,3);
			when 4 then
				insert into PotD(Country, Name, Points,Position) values (C,N,P,4);
			else
				DBMS_OUTPUT.PUT_LINE('No Data can found in La Liga table');
		end case;
		DBMS_OUTPUT.PUT_LINE(K||'     '||C||'     '||N||'     '||P);
	END LOOP;
	
EXCEPTION	
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('MANY ROWS DETECTED');
		
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('DATA not found');
		
	WHEN CASE_NOT_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('CASE not found');
		
	WHEN DUP_VAL_ON_INDEX THEN
		DBMS_OUTPUT.PUT_LINE('DUPPLICATE VALUE');
		
	WHEN PROGRAM_ERROR THEN
		DBMS_OUTPUT.PUT_LINE('DATA not found');
		
	WHEN INVALID_NUMBER THEN
		DBMS_OUTPUT.PUT_LINE('INVALID NUMBER');
		
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('OTHER ERRORS FOUND');
END;
/
commit;


--Premier League--
DECLARE
	C varchar2(20);
	N varchar2(20);
	K int;
	P number;
	x int;
BEGIN
	FOR i in (SELECT pID,Country,Name,Points FROM (Select * from PremierLeague@siteA_Link order by points desc) WHERE ROWNUM <=4) LOOP
		K:=i.pID;
		C:=i.Country;
		N:=i.Name;
		P:=i.Points;
		CASE K
			when 1 then
				insert into PotA(Country, Name, Points,Position) values (C,N,P,1);
			when 2 then 
				insert into PotB(Country, Name, Points,Position) values (C,N,P,2);
			when 3 then
				insert into PotC(Country, Name, Points,Position) values (C,N,P,3);
			when 4 then
				insert into PotD(Country, Name, Points,Position) values (C,N,P,4);
			else
				DBMS_OUTPUT.PUT_LINE('No data can found in premier league table');
		end case;
		DBMS_OUTPUT.PUT_LINE(K||'     '||C||'     '||N||'     '||P);
	END LOOP;

EXCEPTION	
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('MANY ROWS DETECTED');
		
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('DATA not found');
		
	WHEN CASE_NOT_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('CASE not found');
		
	WHEN DUP_VAL_ON_INDEX THEN
		DBMS_OUTPUT.PUT_LINE('DUPPLICATE VALUE');
		
	WHEN PROGRAM_ERROR THEN
		DBMS_OUTPUT.PUT_LINE('DATA not found');
		
	WHEN INVALID_NUMBER THEN
		DBMS_OUTPUT.PUT_LINE('INVALID NUMBER');
		
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('OTHER ERRORS FOUND');
END;
/
commit;


--Bundes Liga--
DECLARE
	C varchar2(20);
	N varchar2(20);
	K int;
	P number;
	x int;
BEGIN
	FOR i in (SELECT bID,Country,Name,Points FROM (Select * from BundesLiga order by points desc) WHERE ROWNUM <=4) LOOP
		K:=i.bID;
		C:=i.Country;
		N:=i.Name;
		P:=i.Points;
		CASE K
			when 1 then
				insert into PotA(Country, Name, Points,Position) values (C,N,P,1);
			when 2 then 
				insert into PotB(Country, Name, Points,Position) values (C,N,P,2);
			when 3 then
				insert into PotC(Country, Name, Points,Position) values (C,N,P,3);
			when 4 then
				insert into PotD(Country, Name, Points,Position) values (C,N,P,4);
			else
				DBMS_OUTPUT.PUT_LINE('Something Wrong');
		end case;
		DBMS_OUTPUT.PUT_LINE(K||'     '||C||'     '||N||'     '||P);
	END LOOP;
	
EXCEPTION	
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('MANY ROWS DETECTED');
		
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('DATA not found');
		
	WHEN CASE_NOT_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('CASE not found');
		
	WHEN DUP_VAL_ON_INDEX THEN
		DBMS_OUTPUT.PUT_LINE('DUPPLICATE VALUE');
		
	WHEN PROGRAM_ERROR THEN
		DBMS_OUTPUT.PUT_LINE('DATA not found');
		
	WHEN INVALID_NUMBER THEN
		DBMS_OUTPUT.PUT_LINE('INVALID NUMBER');
		
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('OTHER ERRORS FOUND');
END;
/
commit;

--SERIA A--
DECLARE
	C varchar2(20);
	N varchar2(20);
	K int;
	P number;
	x int;
BEGIN
	FOR i in (SELECT sID,Country,Name,Points FROM (Select * from SeriaA order by points desc) WHERE ROWNUM <=4) LOOP
		K:=i.sID;
		C:=i.Country;
		N:=i.Name;
		P:=i.Points;
		CASE K
			when 1 then
				insert into PotA(Country, Name, Points,Position) values (C,N,P,1);
			when 2 then 
				insert into PotB(Country, Name, Points,Position) values (C,N,P,2);
			when 3 then
				insert into PotC(Country, Name, Points,Position) values (C,N,P,3);
			when 4 then
				insert into PotD(Country, Name, Points,Position) values (C,N,P,4);
			else
				DBMS_OUTPUT.PUT_LINE('Something Wrong');
		end case;
			DBMS_OUTPUT.PUT_LINE(K||'     '||C||'     '||N||'     '||P);
	END LOOP;
	
EXCEPTION	
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('MANY ROWS DETECTED');
		
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('DATA not found');
		
	WHEN CASE_NOT_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('CASE not found');
		
	WHEN DUP_VAL_ON_INDEX THEN
		DBMS_OUTPUT.PUT_LINE('DUPPLICATE VALUE');
		
	WHEN PROGRAM_ERROR THEN
		DBMS_OUTPUT.PUT_LINE('DATA not found');
		
	WHEN INVALID_NUMBER THEN
		DBMS_OUTPUT.PUT_LINE('INVALID NUMBER');
		
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('OTHER ERRORS FOUND');
END;
/
commit;

set linesize 500;
select * from potA;
select * from potB;
select * from potC;
select * from potD;


select * from potA order by Points desc;
select * from potB order by Points desc;
select * from potC order by Points desc;
select * from potD order by Points desc;


drop table GroupA;
drop table GroupB;
drop table GroupC;
drop table GroupD;
drop sequence GA;
drop sequence GB;
drop sequence GC;
drop sequence GD;


--create Group A table with primary key auto increment--
create table GroupA(
	gaID int,
	Country VARCHAR2(20) unique,
	Name VARCHAR2(20) unique,
	Position number,
	CONSTRAINT GroupA_PK PRIMARY KEY (gaID)
	);
create sequence GA;
create or replace trigger GA_Trig
before insert on GroupA
for each row
begin
	select GA.nextval into :new.gaID from DUAL;
end;
/


--create Pot A table with primary key auto increment--
create table GroupB(
	gbID int,
	Country VARCHAR2(20) unique,
	Name VARCHAR2(20) unique,
	Position number,
	CONSTRAINT GroupB_PK PRIMARY KEY (gbID)
	);
create sequence GB;
create or replace trigger GB_Trig
before insert on GroupB
for each row
begin
	select GB.nextval into :new.gbID from DUAL;
end;
/


--create Pot A table with primary key auto increment--
create table GroupC(
	gcID int,
	Country VARCHAR2(20) unique,
	Name VARCHAR2(20) unique,
	Position number,
	CONSTRAINT GroupC_PK PRIMARY KEY (gcID)
	);
create sequence GC;
create or replace trigger GC_Trig
before insert on GroupC
for each row
begin
	select GC.nextval into :new.gcID from DUAL;
end;
/


--create Pot A table with primary key auto increment--
create table GroupD(
	gdID int,
	Country VARCHAR2(20),
	Name VARCHAR2(20) unique,
	Position number,
	CONSTRAINT GroupD_PK PRIMARY KEY (gdID)
	);
create sequence GD;
create or replace trigger GD_Trig
before insert on GroupD
for each row
begin
	select GD.nextval into :new.gdID from DUAL;
end;
/


select * from PotA;
select * from PotB;
select * from PotC;
select * from PotD;

