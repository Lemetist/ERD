USE COMPANY;


CREATE TABLE грузы(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    описание TEXT,
    категория VARCHAR(100),
    вес DECIMAL(10,2),
    условия_хранения VARCHAR(100)
);

CREATE TABLE транспорт(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    марка NVARCHAR(100),
    тип VARCHAR(100),
    грузоподъемность DECIMAL(10,2),
    статус VARCHAR(100)
);

CREATE TABLE экипаж (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    уровень_квал VARCHAR(100),
    имя VARCHAR(100),
    специализация VARCHAR(100)
);

CREATE TABLE обслуживающий_персонал (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    уровень_квал VARCHAR(100),
    имя VARCHAR(100),
    специализация VARCHAR(100)
);

CREATE TABLE уровень_риска(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    название VARCHAR(100) NOT NULL
);


CREATE TABLE назначения_экипажа_на_транспорт(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_экипажа INT,
    ID_транспорта INT,
    ID_обслуживающий_персонал INT,
    
    FOREIGN KEY (ID_экипажа) REFERENCES экипаж(ID),
    FOREIGN KEY (ID_транспорта) REFERENCES транспорт(ID),
    FOREIGN KEY (ID_обслуживающий_персонал) REFERENCES обслуживающий_персонал(ID)
);

CREATE TABLE маршрут(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Начальный_узел NVARCHAR(100),
    Конечный_узел NVARCHAR(100),
    уровень_риска INT,
    
    FOREIGN KEY (уровень_риска) REFERENCES уровень_риска(ID)
);

CREATE TABLE транспортные_рейсы(
     ID INT AUTO_INCREMENT PRIMARY KEY,
     ID_груза INT,
     ID_назначение_на_транспорт INT,
     ID_маршрута INT,
     статус BOOLEAN,
     
     FOREIGN KEY (ID_груза) REFERENCES грузы(ID),
     FOREIGN KEY (ID_назначение_на_транспорт) REFERENCES назначения_экипажа_на_транспорт(ID),
     FOREIGN KEY (ID_маршрута) REFERENCES маршрут(ID)
);

