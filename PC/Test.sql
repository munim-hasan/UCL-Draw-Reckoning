set serveroutput on;
set verify off;

CREATE OR REPLACE FUNCTION FindATeam(A IN BundesLiga.Name%Type)
RETURN NUMBER
IS

	c BundesLiga.Country%Type;
	N BundesLiga.Name%Type;
	P BundesLiga.Points%Type;
	y BundesLiga.Year_Goal%Type;
BEGIN
	select Country,Name,Points,Year_Goal into c,n,p,y 
	from TopGoal where Name=A;
	
	DBMS_OUTPUT.PUT_LINE('Country: '||c);
	DBMS_OUTPUT.PUT_LINE('Name: '||n);
	DBMS_OUTPUT.PUT_LINE('Points: '||p);
	
	return y;
	
END FindATeam;
/

ACCEPT H PROMPT "Search a team: ";
declare
	Team varchar2(20);
	Goal number;
Begin
	Team:='&H';
	Goal:=FindATeam(Team);
	DBMS_OUTPUT.PUT_LINE('Yearly Goal: '||Goal);
	
EXCEPTION	
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('MANY ROWS DETECTED');
		
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('DATA not found');
		
	WHEN DUP_VAL_ON_INDEX THEN
		DBMS_OUTPUT.PUT_LINE('DUPPLICATE VALUE');
		
	WHEN PROGRAM_ERROR THEN
		DBMS_OUTPUT.PUT_LINE('DATA not found');
		
	WHEN INVALID_NUMBER THEN
		DBMS_OUTPUT.PUT_LINE('INVALID NUMBER');
		
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('OTHER ERRORS FOUND');
end;
/


CREATE OR REPLACE PROCEDURE Pick_PotA(M IN PotA.aID%TYPE,N IN PotA.aID%Type)
IS
	A PotA.aID%Type;
	B PotA.Country%Type;
	C PotA.Name%Type;
	E PotA.Position%Type;
	
	gpa PotA.aID%Type;
	gpb PotA.aID%Type;
	gpc PotA.aID%Type;
	gpd PotA.aID%Type;
	
	Country PotA.Country%Type;
	Name PotA.Name%Type; 
	Position PotA.Position%Type;
BEGIN
	select aID,Country,Name,Position
	into A,B,C,E from PotA where aID=M;
	DBMS_OUTPUT.PUT_LINE(A||' '||B||' '||C||' '||E);
	
	select count(Name) into gpa from GroupA; 
	select count(Name) into gpb from GroupB; 
	select count(Name) into gpc from GroupC; 
	select count(Name) into gpd from GroupD; 
	Case N
		when 1 then
			
			if gpa=0 then
				insert into GroupA(Country,Name,Position) values (B,C,E);
				delete potA where aID=M;
			else
				for i in(select Country,Name,Position from groupA) loop
					Country:=i.Country;
					Name:=i.Name;
					Position:=i.Position;
					if Country!=B and Name!=C and Position!=E then
						insert into GroupA(Country,Name,Position) values (B,C,E);
						delete potA where aID=M;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		when 2 then
			
			if gpb=0 then
				insert into GroupB(Country,Name,Position) values (B,C,E);
				delete potA where aID=M;
			else
				for i in(select Country,Name,Position from groupB) loop
					Country:=i.Country;
					Name:=i.Name;
					Position:=i.Position;
					if Country!=B and Name!=C and Position!=E then
						insert into GroupB(Country,Name,Position) values (B,C,E);
						delete potA where aID=M;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		when 3 then
			
			if gpc=0 then
				insert into GroupC(Country,Name,Position) values (B,C,E);
				delete potA where aID=M;
			else
				for i in(select Country,Name,Position from groupC) loop
					Country:=i.Country;
					Name:=i.Name;
					Position:=i.Position;
					if Country!=B and Name!=C and Position!=E then
						insert into GroupC(Country,Name,Position) values (B,C,E);
						delete potA where aID=M;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		when 4 then
			
			if gpd=0 then
				insert into GroupD(Country,Name,Position) values (B,C,E);
				delete potA where aID=M;
			else
				for i in(select Country,Name,Position from groupD) loop
					Country:=i.Country;
					Name:=i.Name;
					Position:=i.Position;
					if Country!=B and Name!=C and Position!=E then
						insert into GroupD(Country,Name,Position) values (B,C,E);
						delete potA where aID=M;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		else
			DBMS_OUTPUT.PUT_LINE('Wrong group Selected');
	end case;
	
END Pick_PotA;
/





CREATE OR REPLACE PROCEDURE Pick_PotB(O IN PotA.aID%TYPE,P IN PotA.aID%Type)
IS
	E PotB.bID%Type;
	F PotB.Country%Type;
	G PotB.Name%Type;
	I PotB.Position%Type;
	
	gpa PotB.bID%Type;
	gpb PotB.bID%Type;
	gpc PotB.bID%Type;
	gpd PotB.bID%Type;
	
	Cnt PotB.Country%Type;
	Nm PotB.Name%Type; 
	Pt PotB.Position%Type;
BEGIN
	select bID,Country,Name,Position
	into E,F,G,I from PotB where bID=O;
	
	DBMS_OUTPUT.PUT_LINE(E||' '||F||' '||G||' '||I);
	
	select count(Name) into gpa from GroupA; 
	select count(Name) into gpb from GroupB; 
	select count(Name) into gpc from GroupC; 
	select count(Name) into gpd from GroupD;
	
	case P
		when 1 then
			if gpa=0 then
				insert into GroupA(Country,Name,Position) values(F,G,I);
				delete potB where bID=O;
			else
				for j in (select Country,Name,Position from GroupA) loop
					Cnt:=j.Country;
					Nm:=j.Name;
					Pt:=j.Position;
					if cnt!=F and nm!=G and pt!=I then
						insert into GroupA(Country,Name,Position) values (F,G,I);
						delete potB where bID=O;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		when 2 then
		
			if gpb=0 then
				insert into GroupB(Country,Name,Position) values(F,G,I);
				delete potB where bID=O;
			else
				for j in (select Country,Name,Position from GroupB) loop
					Cnt:=j.Country;
					Nm:=j.Name;
					Pt:=j.Position;
					if cnt!=F and nm!=G and pt!=I then
						insert into GroupB(Country,Name,Position) values (F,G,I);
						delete potB where bID=O;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		when 3 then
			
			if gpc=0 then
				insert into GroupC(Country,Name,Position) values(F,G,I);
				delete potB where bID=O;
			else
				for j in (select Country,Name,Position from GroupC) loop
					Cnt:=j.Country;
					Nm:=j.Name;
					Pt:=j.Position;
					if cnt!=F and nm!=G and pt!=I then
						insert into GroupC(Country,Name,Position) values (F,G,I);
						delete potB where bID=O;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		when 4 then
			if gpd=0 then
				insert into GroupD(Country,Name,Position) values(F,G,I);
				delete potB where bID=O;
			else
				for j in (select Country,Name,Position from GroupD) loop
					Cnt:=j.Country;
					Nm:=j.Name;
					Pt:=j.Position;
					if cnt!=F and nm!=G and pt!=I then
						insert into GroupD(Country,Name,Position) values (F,G,I);
						delete potB where bID=O;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
		else
			DBMS_OUTPUT.PUT_LINE('Wrong group selected');
	end case;
END Pick_PotB;
/



CREATE OR REPLACE PROCEDURE Pick_PotC(Q IN PotA.aID%TYPE,R IN PotA.aID%Type)
IS
	J PotC.cID%Type;
	K PotC.Country%Type;
	L PotC.Name%Type;
	N PotC.Position%Type;
	
	gpa PotA.aID%Type;
	gpb PotA.aID%Type;
	gpc PotA.aID%Type;
	gpd PotA.aID%Type;
	
	Country PotA.Country%Type;
	Name PotA.Name%Type; 
	Position PotA.Position%Type;
BEGIN
	select cID,Country,Name,Position
	into J,K,L,N from PotC where cID=Q;
	DBMS_OUTPUT.PUT_LINE(J||' '||K||' '||L||' '||N);
	
	select count(Name) into gpa from GroupA; 
	select count(Name) into gpb from GroupB; 
	select count(Name) into gpc from GroupC; 
	select count(Name) into gpd from GroupD; 
	
	case R
		when 1 then
			
			if gpa=0 then
				insert into GroupA(Country,Name,Position) values (K,L,N);
				delete potC where cID=Q;
			else
				for i in(select Country,Name,Position from groupA) loop
					Country:=i.Country;
					Name:=i.Name;
					Position:=i.Position;
					if Country!=K and Name!=L and Position!=N then
						insert into GroupA(Country,Name,Position) values (K,L,N);
						delete potC where cID=Q;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		when 2 then
			
			if gpb=0 then
				insert into GroupB(Country,Name,Position) values (K,L,N);
				delete potC where cID=Q;
			else
				for i in(select Country,Name,Position from groupB) loop
					Country:=i.Country;
					Name:=i.Name;
					Position:=i.Position;
					if Country!=K and Name!=L and Position!=N then
						insert into GroupB(Country,Name,Position) values (K,L,N);
						delete potC where cID=Q;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		when 3 then
			
			if gpc=0 then
				insert into GroupC(Country,Name,Position) values (K,L,N);
				delete potC where cID=Q;
			else
				for i in(select Country,Name,Position from groupC) loop
					Country:=i.Country;
					Name:=i.Name;
					Position:=i.Position;
					if Country!=K and Name!=L and Position!=N then
						insert into GroupC(Country,Name,Position) values (K,L,N);
						delete potC where cID=Q;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		when 4 then
			
			if gpd=0 then
				insert into GroupD(Country,Name,Position) values (K,L,N);
				delete potC where cID=Q;
			else
				for i in(select Country,Name,Position from groupD) loop
					Country:=i.Country;
					Name:=i.Name;
					Position:=i.Position;
					if Country!=K and Name!=L and Position!=N then
						insert into GroupD(Country,Name,Position) values (K,L,N);
						delete potC where cID=Q;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		else
			DBMS_OUTPUT.PUT_LINE('Wrong group selected');
	end case;
	
END Pick_PotC;
/





CREATE OR REPLACE PROCEDURE Pick_PotD(S IN PotA.aID%TYPE,T IN PotA.aID%Type)
IS
	O PotD.dID%Type;
	P PotD.Country%Type;
	Q PotD.Name%Type;
	V PotD.Position%Type;
	
	gpa PotA.aID%Type;
	gpb PotA.aID%Type;
	gpc PotA.aID%Type;
	gpd PotA.aID%Type;
	
	Country PotA.Country%Type;
	Name PotA.Name%Type; 
	Position PotA.Position%Type;
BEGIN
	select dID,Country,Name,Position
	into O,P,Q,V from PotD where dID=S;
	DBMS_OUTPUT.PUT_LINE(O||' '||P||' '||Q||' '||V);
	
	select count(Name) into gpa from GroupA; 
	select count(Name) into gpb from GroupB; 
	select count(Name) into gpc from GroupC; 
	select count(Name) into gpd from GroupD; 
	
	Case T
		when 1 then
			
			if gpa=0 then
				insert into GroupA(Country,Name,Position) values (P,Q,V);
				delete potD where dID=S;
			else
				for i in(select Country,Name,Position from groupA) loop
					Country:=i.Country;
					Name:=i.Name;
					Position:=i.Position;
					if Country!=P and Name!=Q and Position!=V then
						insert into GroupA(Country,Name,Position) values (P,Q,V);
						delete potD where dID=S;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		when 2 then
			
			if gpb=0 then
				insert into GroupB(Country,Name,Position) values (P,Q,V);
				delete potD where dID=S;
			else
				for i in(select Country,Name,Position from groupB) loop
					Country:=i.Country;
					Name:=i.Name;
					Position:=i.Position;
					if Country!=P and Name!=Q and Position!=V then
						insert into GroupB(Country,Name,Position) values (P,Q,V);
						delete potD where dID=S;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		when 3 then
			
			if gpc=0 then
				insert into GroupC(Country,Name,Position) values (P,Q,V);
				delete potD where dID=S;
			else
				for i in(select Country,Name,Position from groupC) loop
					Country:=i.Country;
					Name:=i.Name;
					Position:=i.Position;
					if Country!=P and Name!=Q and Position!=V then
						insert into GroupC(Country,Name,Position) values (P,Q,V);
						delete potD where dID=S;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		when 4 then
			
			if gpd=0 then
				insert into GroupD(Country,Name,Position) values (P,Q,V);
				delete potD where dID=S;
			else
				for i in(select Country,Name,Position from groupD) loop
					Country:=i.Country;
					Name:=i.Name;
					Position:=i.Position;
					if Country!=P and Name!=Q and Position!=V then
						insert into GroupD(Country,Name,Position) values (P,Q,V);
						delete potD where dID=S;
					else
						DBMS_OUTPUT.PUT_LINE('Can not be placed in this group');
					end if;
				end loop;
			end if;
			
		else
			DBMS_OUTPUT.PUT_LINE('Wrong group Selected');
	end case;
	
END Pick_PotD;
/




declare 
	pot1 number;
	pot2 number;
	pot3 number;
	pot4 number;
	A PotA.aID%TYPE;
	B PotB.bID%TYPE;
	C PotC.cID%TYPE;
	D PotD.dID%TYPE;
begin
	DBMS_OUTPUT.PUT_LINE('From BOX A:');
	select count(Name)into pot1 from PotA;
	DBMS_OUTPUT.PUT_LINE(pot1||' '||'balls are avilable');
	DBMS_OUTPUT.PUT_LINE('Those are:');
	for i in (select aID from PotA) loop
		A:=i.aID;
		DBMS_OUTPUT.PUT_LINE(A);
	end loop;
	DBMS_OUTPUT.PUT_LINE(chr(10));
	
	
	
	DBMS_OUTPUT.PUT_LINE('From BOX B:');
	select count(Name)into pot2 from PotB;
	DBMS_OUTPUT.PUT_LINE(pot2||' '||'balls are avilable');
	DBMS_OUTPUT.PUT_LINE('Those are:');
	for i in (select bID from PotB) loop
		B:=i.bID;
		DBMS_OUTPUT.PUT_LINE(B);
	end loop;
	DBMS_OUTPUT.PUT_LINE(chr(10));
	
	
	DBMS_OUTPUT.PUT_LINE('From BOX C:');
	select count(Name)into pot3 from PotC;
	DBMS_OUTPUT.PUT_LINE(pot3||' '||'balls are avilable');
	DBMS_OUTPUT.PUT_LINE('Those are:');
	for i in (select cID from PotC) loop
		C:=i.cID;
		DBMS_OUTPUT.PUT_LINE(C);
	end loop;
	DBMS_OUTPUT.PUT_LINE(chr(10));
	
	
	
	DBMS_OUTPUT.PUT_LINE('From BOX D:');
	select count(Name)into pot4 from PotD;
	DBMS_OUTPUT.PUT_LINE(pot4||' '||'balls are avilable');
	DBMS_OUTPUT.PUT_LINE('Those are:');
	for i in (select dID from PotD) loop
		D:=i.dID;
		DBMS_OUTPUT.PUT_LINE(D);
	end loop;
	DBMS_OUTPUT.PUT_LINE(chr(10));
end;
/


ACCEPT P PROMPT "Choose a POT: ";
ACCEPT B PROMPT "Pick any ball: ";
ACCEPT G PROMPT "Which group do you want to put this team: ";

DECLARE 
	E varchar2(10);
	F number;
	Q PotA.aID%TYPE;
	R PotA.aID%TYPE;
BEGIN
	E:='&P';
	Q:=&B;
	R:=&G;
	if E='A' then
		DBMS_OUTPUT.PUT_LINE(chr(10)||'You Select POT: '||E);
		select count(Name) into F from potA;
		
		if F>=1 then
			Pick_PotA(Q,R);
		else
			DBMS_OUTPUT.PUT_LINE(chr(10)||'But no balls are availabe');
		end if;
		
	elsif E='B' then
		DBMS_OUTPUT.PUT_LINE(chr(10)||'You Select POT: '||E);
		select count(Name) into F from potB;
		if F>=1 then
			Pick_PotB(Q,R);
		else
			DBMS_OUTPUT.PUT_LINE(chr(10)||'But no balls are availabe');
		end if;
		
	elsif  E='C' then
		DBMS_OUTPUT.PUT_LINE(chr(10)||'You Select POT: '||E);
		select count(Name) into F from potC;
		if F>=1 then
			Pick_PotC(Q,R);
		else
			DBMS_OUTPUT.PUT_LINE(chr(10)||'But no balls are availabe');
		end if;
		
	elsif E='D' then
		DBMS_OUTPUT.PUT_LINE(chr(10)||'You Select POT: '||E);
		select count(Name) into F from potD;
		if F>=1 then
			Pick_PotD(Q,R);
		else
			DBMS_OUTPUT.PUT_LINE(chr(10)||'But No balls are availabe');
		end if;
		
	else
		DBMS_OUTPUT.PUT_LINE(chr(10)||'Wrong Pot Selected');
	end if;

EXCEPTION	
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('MANY ROWS DETECTED');
		
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('DATA not found');
		
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


select * from GroupA;
select * from GroupB;
select * from GroupC;
select * from GroupD;

