begin;

drop schema if exists "investors" cascade;

create schema "investors";

CREATE TABLE investors.t_people
( 
	id_person		serial,
	last_name		character varying(15) not null,
	first_name		character varying(15) not null,
	patronymic		character varying(15),
	date_of_birth		date,
	login			character varying(15) not null,
	passwd			character varying(100) not null,
	account			money not null,
	PRIMARY KEY (id_person) 
);

CREATE TABLE investors.t_case_of_stocks
( 
	id_case_of_stocks	serial,
	id_person		integer not null,
	case_name		character varying(15) not null,
	PRIMARY KEY (id_case_of_stocks),
	FOREIGN KEY (id_person) REFERENCES investors.t_people (id_person)	
);

CREATE TABLE investors.t_stocks_of_investor
( 
	id_stocks_of_investor	serial,
	id_stock		integer not null,
	id_case_of_stocks	integer not null,
	number_of_stocks	integer not null,
	PRIMARY KEY (id_stocks_of_investor),
	FOREIGN KEY (id_stock) REFERENCES investor_workspace.t_stocks (id_stock),
	FOREIGN KEY (id_case_of_stocks) REFERENCES investors.t_case_of_stocks (id_case_of_stocks)	
);
end;