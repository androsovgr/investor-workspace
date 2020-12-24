begin;

drop schema if exists investor_workspace cascade;

create schema investor_workspace;

CREATE TABLE investor_workspace.t_sector
( 
	id_sector		serial,
	sector_name		character varying (20),
	PRIMARY KEY (id_sector)
);

CREATE TABLE investor_workspace.t_company
( 
	id_company		serial,
	company_name		character varying (20) not null,
	PRIMARY KEY (id_company)
);

CREATE TABLE investor_workspace.t_stocks
( 
	id_stock		serial,
	id_sector		integer not null,
	id_company		integer not null,
	free_floar		double precision not null,
	price			numeric (12, 2),
	dividends		double precision not null,
	s_type			boolean not null,
	RTS			double precision not null,
	IMOEX			double precision not null,
	PRIMARY KEY (id_stock),
	FOREIGN KEY (id_sector) REFERENCES investor_workspace.t_sector (id_sector),
	FOREIGN KEY (id_company) REFERENCES investor_workspace.t_company (id_company)
);

CREATE TABLE investor_workspace.tcl_types_multiplicators
( 
	id_type_multiplicator		serial,
	multiplicator_name		character varying (20) not null,
	PRIMARY KEY (id_type_multiplicator)
);

CREATE TABLE investor_workspace.t_multiplicators
( 
	id_multiplicator	serial,
	id_stock		integer not null,
	id_type_multiplicator	integer not null,
	m_values		double precision not null,

	PRIMARY KEY (id_stock),
	FOREIGN KEY (id_stock) REFERENCES investor_workspace.t_stocks (id_stock),
	FOREIGN KEY (id_type_multiplicator) REFERENCES investor_workspace.tcl_types_multiplicators (id_type_multiplicator)
);
end;