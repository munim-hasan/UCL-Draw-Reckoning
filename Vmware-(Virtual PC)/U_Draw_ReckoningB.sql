clear screen;
set verify off;
set serveroutput on;

drop table LaLiga CASCADE CONSTRAINTS;
drop table PremierLeague CASCADE CONSTRAINTS;

drop sequence L;
drop sequence P;




--create La Liga table with primary key auto increment--
create table LaLiga(
	lID int NOT NULL,
	Country VARCHAR2(20),
	Name VARCHAR2(50),
	Points NUMBER,
	Year_Goal number,
	constraint LaLiga_Pk primary key (lID)
	);
create sequence L;
create or replace trigger L_TRIG
before insert on LaLiga
for each row
begin
	select L.nextval into :new.lID from Dual;
end;
/


--create Premier League table with primary key auto increment--
create table PremierLeague(
	pID int not null,
	Country Varchar2(50),
	Name VARCHAR2(50),
	Points NUMBER,
	Year_Goal number,
	constraint PremierLeague_Pk primary key(pID)
	);
	
create sequence P;
create or replace trigger PremierLeague_TRG
before insert on PremierLeague
for each row
begin
	select P.nextval into :new.pID from dual;
end;
/








--LA LIGA Standing--
insert into LaLiga(Country, Name, Points,Year_Goal) values ('Spain','Barcelona',102,101);
insert into LaLiga(Country, Name, Points,Year_Goal) values ('Spain','Atletico Madrid',98,90);
insert into LaLiga(Country, Name, Points,Year_Goal) values ('Spain','Real Madrid',91,80);
insert into LaLiga(Country, Name, Points,Year_Goal) values ('Spain','Atletico Bilbao',87,72);
insert into LaLiga(Country, Name, Points,Year_Goal) values ('Spain','Real Sociedad',85,95);
insert into LaLiga(Country, Name, Points,Year_Goal) values ('Spain','Celta Vigo',80,85);
insert into LaLiga(Country, Name, Points,Year_Goal) values ('Spain','Sevilla',75,94);
insert into LaLiga(Country, Name, Points,Year_Goal) values ('Spain','Real Betis',76,84);
insert into LaLiga(Country, Name, Points,Year_Goal) values ('Spain','Villarreal',70,60);
insert into LaLiga(Country, Name, Points,Year_Goal) values ('Spain','Osasuna',64,72);

--Premier League Standing--
insert into PremierLeague(Country, Name, Points,Year_Goal) values ('England','Mancester City',98,120);
insert into PremierLeague(Country, Name, Points,Year_Goal) values ('England','Chelsea',96,101);
insert into PremierLeague(Country, Name, Points,Year_Goal) values ('England','Arsenal',85,105);
insert into PremierLeague(Country, Name, Points,Year_Goal) values ('England','Liverpool',84,102);
insert into PremierLeague(Country, Name, Points,Year_Goal) values ('England','Leicester City',81,110);
insert into PremierLeague(Country, Name, Points,Year_Goal) values ('England','Aston Villa',78,95);
insert into PremierLeague(Country, Name, Points,Year_Goal) values ('England','Tottenham',76,95);
insert into PremierLeague(Country, Name, Points,Year_Goal) values ('England','West Ham',75,80);
insert into PremierLeague(Country, Name, Points,Year_Goal) values ('England','Manchester United',70,60);
insert into PremierLeague(Country, Name, Points,Year_Goal) values ('England','Newcastle',60,84);

commit;

set linesize 500;
select * from LaLiga;
select * from PremierLeague;

select * from potA@siteB_Link;
select * from potB@siteB_Link;
select * from potC@siteB_Link;
select * from potD@siteB_Link;


