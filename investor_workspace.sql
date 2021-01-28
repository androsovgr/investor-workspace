begin;

create schema investor_workspace;

CREATE TABLE investor_workspace.t_sector
/**
*Таблица, в которой перечислены все возможные отрасли экономики.
*@author Софрнов И.Е.
*@version 11.01.2021
*/
( 
	sctr_pk		serial,
	sctr_name	character varying (20) not null,
	PRIMARY KEY (sctr_pk)
);

CREATE TABLE investor_workspace.t_companies
/**
*Таблица, в которой перечислены все компании, акции которых торгуются на бирже.
*@author Софрнов И.Е.
*@version 11.01.2021
*/
( 
	cmpn_pk			serial,
	cmpn_name		character varying (20) not null,
	PRIMARY KEY (cmpn_pk)
);

CREATE TABLE investor_workspace.t_sectors_of_companies
/**
*Таблица для создания связи многие ко многим таблиц investor_workspace.t_companies и investor_workspace.t_sector.
*@author Софрнов И.Е.
*@version 11.01.2021
*/
( 
	soc_pk			serial,
	soc_cmpn_fk		integer not null,
	soc_sctr_fk		integer not null,
	PRIMARY KEY (soc_pk),
	FOREIGN KEY (soc_cmpn_fk) REFERENCES investor_workspace.t_companies (cmpn_pk),
	FOREIGN KEY (soc_sctr_fk) REFERENCES investor_workspace.t_sector (sctr_pk)
);

CREATE TABLE investor_workspace.t_stocks
/**
*Таблица для хранения всех акций, торгуемых на бирже.
*@author Софрнов И.Е.
*@version 11.01.2021
*/
( 
	stck_pk			serial,
	stck_cmpn_fk		integer not null,
	stck_name		varchar(5) not null,
	stck_ticker		varchar(15) not null,
	PRIMARY KEY (stck_pk),
	FOREIGN KEY (stck_cmpn_fk) REFERENCES investor_workspace.t_companies (cmpn_pk)
);

CREATE TABLE investor_workspace.t_stocks_prices
/**
*Таблица хранения истории изменения цены каждой акции.
*@author Софрнов И.Е.
*@version 11.01.2021
*/
( 
	sp_pk				serial,
	sp_stck_fk			integer not null,
	sp_time_set			timestamp not null,
	sp_price			money not null,
	PRIMARY KEY (sp_pk),
	FOREIGN KEY (sp_stck_fk) REFERENCES investor_workspace.t_stocks (stck_pk)
);

CREATE TABLE investor_workspace.t_indexes
/**
*Таблица для хранения информации по индексом ценных бумаг, которые учитываются в приложении.
*@author Софрнов И.Е.
*@version 11.01.2021
*/
( 
	indx_pk			serial,
	indx_name		character varying (20) not null,
	PRIMARY KEY (indx_pk)
);

CREATE TABLE investor_workspace.t_date_of_indexes_changes
/**
*Таблица для хранения истории пересчёта каждого индекса ценных бумаг.
*@author Софрнов И.Е.
*@version 11.01.2021
*/
( 
	doic_pk				serial,
	doic_indx_fk			integer not null,
	doic_date_chng			date not null,
	PRIMARY KEY (doic_pk),
	FOREIGN KEY (doic_indx_fk) REFERENCES investor_workspace.t_indexes (indx_pk)
);

CREATE TABLE investor_workspace.t_stocks_in_indexes
/**
*Таблица для создания связи многие ко многим таблиц investor_workspace.t_date_of_indexes_changes и investor_workspace.t_stocks.
*@author Софрнов И.Е.
*@version 11.01.2021
*/
( 
	sii_pk			serial,
	sii_stck_fk		integer not null,
	sii_doic_fk		integer not null,
	sii_num_stck		integer not null,
	PRIMARY KEY (sii_pk),
	FOREIGN KEY (sii_stck_fk) REFERENCES investor_workspace.t_stocks (stck_pk),
	FOREIGN KEY (sii_doic_fk) REFERENCES investor_workspace.t_date_of_indexes_changes (doic_pk)
);

end;