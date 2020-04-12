CREATE TABLE DataDasar (
    id int not null,
    nama varchar(50)
);

CREATE TABLE KategoriUnit (
    id int not null,
    nama varchar(50)
);

CREATE TABLE Unit (
    id int not null,
	KategoriUnit_id int not null,
    nama varchar(50)
);

CREATE TABLE Capaian_Unit
(
    DataDasar_id int NOT NULL,
    Unit_id int NOT NULL,
	waktu datetime,
	capaian float,
    CONSTRAINT PK_mendaftar PRIMARY KEY
    (
        DataDasar_id,
        Unit_id
    ),
    FOREIGN KEY (DataDasar_id) REFERENCES DataDasar(id),
    FOREIGN KEY (Unit_id) REFERENCES Unit(id)
);

ALTER TABLE DataDasar
ADD CONSTRAINT pk_datadasar
PRIMARY KEY (id);

ALTER TABLE KategoriUnit
ADD CONSTRAINT pk_kategoriunit
PRIMARY KEY (id);

ALTER TABLE Unit
ADD CONSTRAINT pk_unit
PRIMARY KEY (id);

ALTER TABLE Unit
ADD CONSTRAINT fk1_unit
FOREIGN KEY (KategoriUnit_id) REFERENCES KategoriUnit(id);