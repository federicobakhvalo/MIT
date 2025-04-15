BEGIN TRANSACTION;
CREATE TABLE Адрес (
            id_адрес INTEGER PRIMARY KEY AUTOINCREMENT,
            Город VARCHAR(50) NOT NULL,
            Улица VARCHAR(50) NOT NULL,
            Дом VARCHAR(5) NOT NULL,
            Квартира VARCHAR(5) NULL
        );
INSERT INTO "Адрес" VALUES(1,'Ярославль','Гагарина','5','2');
INSERT INTO "Адрес" VALUES(2,'Москва','Мира','1',NULL);
INSERT INTO "Адрес" VALUES(3,'Волгоград','Советская','2','44');
INSERT INTO "Адрес" VALUES(4,'Челябинск','Проектируемая','222','2222');
INSERT INTO "Адрес" VALUES(5,'Ярославль','Ленина','40','40');
CREATE TABLE Дисциплина (
            id_дисциплина INTEGER PRIMARY KEY AUTOINCREMENT,
            Наименование_дисциплины VARCHAR(50) NOT NULL
        );
INSERT INTO "Дисциплина" VALUES(1,'Физика');
INSERT INTO "Дисциплина" VALUES(2,'Математика');
INSERT INTO "Дисциплина" VALUES(3,'История');
INSERT INTO "Дисциплина" VALUES(4,'Биология');
INSERT INTO "Дисциплина" VALUES(5,'Информатика');
INSERT INTO "Дисциплина" VALUES(6,'Физкультура');
CREATE TABLE Оценка (
            id_оценка INTEGER PRIMARY KEY AUTOINCREMENT,
            Наименование_оценки VARCHAR(10) NOT NULL
        );
INSERT INTO "Оценка" VALUES(1,'1');
INSERT INTO "Оценка" VALUES(2,'2');
INSERT INTO "Оценка" VALUES(3,'3');
INSERT INTO "Оценка" VALUES(4,'4');
INSERT INTO "Оценка" VALUES(5,'5');
CREATE TABLE "Паспортные_данные" (
            id_паспортных_данных INTEGER PRIMARY KEY AUTOINCREMENT,
            серия VARCHAR(4) NOT NULL CHECK(LENGTH(серия) = 4),
            номер VARCHAR(6) NOT NULL CHECK(LENGTH(номер) = 6)
        );
INSERT INTO "Паспортные_данные" VALUES(1,'2222','333333');
INSERT INTO "Паспортные_данные" VALUES(2,'4444','555555');
INSERT INTO "Паспортные_данные" VALUES(3,'2212','243545');
INSERT INTO "Паспортные_данные" VALUES(4,'2212','232354');
INSERT INTO "Паспортные_данные" VALUES(5,'2222','454678');
CREATE TABLE Успеваемость (
                    id_успеваемость INTEGER PRIMARY KEY AUTOINCREMENT,
                    id_ученик INTEGER NOT NULL,
                    id_оценка INTEGER NOT NULL,
                    id_дисциплина INTEGER NOT NULL,
                    Присутствие_на_занятии VARCHAR(50) NOT NULL CHECK (Присутствие_на_занятии IN ('да', 'нет')),
                    Дата DATE NOT NULL,
                    id_учителя INTEGER NOT NULL,
                    FOREIGN KEY (id_ученик) REFERENCES Ученик(id_ученика) ON DELETE CASCADE,
                    FOREIGN KEY (id_оценка) REFERENCES Оценка(id_оценка) ON DELETE CASCADE,
                    FOREIGN KEY (id_дисциплина) REFERENCES Дисциплина(id_дисциплина) ON DELETE CASCADE,
                    FOREIGN KEY (id_учителя) REFERENCES Учитель(id_учителя) ON DELETE CASCADE
                );
INSERT INTO "Успеваемость" VALUES(1,1,2,6,'да','2025-04-08',2);
INSERT INTO "Успеваемость" VALUES(2,1,5,5,'да','2025-04-07',5);
INSERT INTO "Успеваемость" VALUES(3,5,3,1,'нет','2025-04-08',3);
INSERT INTO "Успеваемость" VALUES(4,4,5,2,'да','2025-04-08',4);
INSERT INTO "Успеваемость" VALUES(5,2,1,6,'нет','2025-04-08',2);
CREATE TABLE "Ученик" (
            id_ученика INTEGER PRIMARY KEY AUTOINCREMENT,
            Фамилия_ученика VARCHAR(50) NOT NULL,
            Имя_ученика VARCHAR(50) NOT NULL,
            Отчество_ученика VARCHAR(50),
            Контактный_телефон_ученика VARCHAR(11) NOT NULL CHECK(Контактный_телефон_ученика GLOB '7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
            id_адрес INTEGER NOT NULL,
            id_паспортных_данных INTEGER UNIQUE,  -- Связь один-к-одному
            FOREIGN KEY(id_адрес) REFERENCES Адрес(id_адрес) ON DELETE CASCADE,
            FOREIGN KEY(id_паспортных_данных) REFERENCES "Паспортные_данные"(id_паспортных_данных) ON DELETE SET NULL
        );
INSERT INTO "Ученик" VALUES(1,'Иванов','Иван','Иванович','79201204090',2,1);
INSERT INTO "Ученик" VALUES(2,'Петров','Петр','Евгеньевич','78005553535',4,2);
INSERT INTO "Ученик" VALUES(3,'Александров','Александр','Васильевич','75555555555',5,3);
INSERT INTO "Ученик" VALUES(4,'Иванова','Александра','Ивановна','77777777777',2,4);
INSERT INTO "Ученик" VALUES(5,'Васильев','Вениамин','Викторович','77737777777',1,5);
CREATE TABLE Учитель (
                id_учителя INTEGER PRIMARY KEY AUTOINCREMENT,
                Фамилия VARCHAR(50) NOT NULL,
                Имя VARCHAR(50) NOT NULL,
                Отчество VARCHAR(50),
                Контактный_телефон VARCHAR(11) NOT NULL CHECK(Контактный_телефон GLOB '7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
                
                UNIQUE(Контактный_телефон)
            );
INSERT INTO "Учитель" VALUES(1,'Волков','Петр','Валерьевич','79001205740');
INSERT INTO "Учитель" VALUES(2,'Cтетхем','Джейсон','Джекович','77777777777');
INSERT INTO "Учитель" VALUES(3,'Эйнштейн','Альберт','Игоревич','77777777779');
INSERT INTO "Учитель" VALUES(4,'Ковалевская','Софья','Викторовна','77777777772');
INSERT INTO "Учитель" VALUES(5,'Маск','Илон',NULL,'76777777777');
DELETE FROM "sqlite_sequence";
INSERT INTO "sqlite_sequence" VALUES('Адрес',8);
INSERT INTO "sqlite_sequence" VALUES('Дисциплина',6);
INSERT INTO "sqlite_sequence" VALUES('Учитель',5);
INSERT INTO "sqlite_sequence" VALUES('Оценка',5);
INSERT INTO "sqlite_sequence" VALUES('Успеваемость',5);
INSERT INTO "sqlite_sequence" VALUES('Паспортные_данные',5);
INSERT INTO "sqlite_sequence" VALUES('Ученик',5);
COMMIT;
