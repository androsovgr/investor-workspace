begin;

drop schema if exists investor_workspace cascade;

create schema investor_workspace;

CREATE TABLE investor_workspace.tcl_sector
( 
	id_sector		serial,
	sector_name		character varying (20),
	PRIMARY KEY (id_sector)
);

CREATE TABLE investor_workspace.t_companies
( 
	id_company		serial,
	company_name		character varying (20) not null,
	PRIMARY KEY (id_company)
);

CREATE TABLE investor_workspace.t_sectors_of_companies
( 
	id_sectors_of_companies		serial,
	id_company			integer not null,
	id_sector			integer not null,
	PRIMARY KEY (id_sectors_of_companies),
	FOREIGN KEY (id_company) REFERENCES investor_workspace.t_companies (id_company),
	FOREIGN KEY (id_sector) REFERENCES investor_workspace.tcl_sector (id_sector)
);

CREATE TABLE investor_workspace.t_stocks
( 
	id_stocke		serial,
	id_company		integer not null,
	stocke_name		varchar(5) not null,
	stocke_ticker		varchar(15) not null,
	PRIMARY KEY (id_stocke),
	FOREIGN KEY (id_company) REFERENCES investor_workspace.t_companies (id_company)
);

CREATE TABLE investor_workspace.t_stocks_prices
( 
	id_stocks_prices		serial,
	id_stocke			integer not null,
	setting_time			timestamp not null,
	price				money not null,
	PRIMARY KEY (id_stocks_prices),
	FOREIGN KEY (id_stocke) REFERENCES investor_workspace.t_stocks (id_stocke)
);

CREATE TABLE investor_workspace.tcl_indexes
( 
	id_index		serial,
	index_name		character varying (20),
	PRIMARY KEY (id_index)
);

CREATE TABLE investor_workspace.t_date_of_indexes_changes
( 
	id_date_of_indexes_changes	serial,
	id_index			integer,
	date_of_change			date,
	PRIMARY KEY (id_date_of_indexes_changes),
	FOREIGN KEY (id_index) REFERENCES investor_workspace.tcl_indexes (id_index)
);

CREATE TABLE investor_workspace.t_stocks_in_indexes
( 
	id_stocks_in_indexes		serial,
	id_stocke			integer not null,
	id_date_of_indexes_changes	integer not null,
	PRIMARY KEY (id_stocks_in_indexes),
	FOREIGN KEY (id_stocke) REFERENCES investor_workspace.t_stocks (id_stocke),
	FOREIGN KEY (id_date_of_indexes_changes) REFERENCES investor_workspace.t_date_of_indexes_changes (id_date_of_indexes_changes)
);

end;