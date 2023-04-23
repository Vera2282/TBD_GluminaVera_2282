BEGIN;

DROP TABLE IF EXISTS student_hobby;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS hobby;

CREATE TABLE student (
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(255) NOT NULL,
    surname    VARCHAR(255) NOT NULL,
    n_group    INTEGER NOT NULL,
    score      NUMERIC(3,2),
    address    VARCHAR(3000),
    date_birth DATE
);

CREATE TABLE hobby (
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(255) NOT NULL,
    risk  NUMERIC(4,2) NOT NULL
);

CREATE TABLE student_hobby (
    id          SERIAL PRIMARY KEY,
    student_id  INTEGER NOT NULL REFERENCES student(id),
    hobby_id    INTEGER NOT NULL REFERENCES hobby(id),
    date_start  TIMESTAMP NOT NULL,
    date_finish DATE
);
--данные
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (1, 'Иван', 'Иванов', 2222, '09-09-1999', 4.02);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (2, 'Михаил', 'Михайлов', 4032, '03-12-1997', 3.25);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (3, 'Виктория', 'Николаева', 4011, '11-23-1994', 4.23);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (4, 'Нуль', 'Нулёвый', 2222, '04-05-1998', 4.23);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (5, 'Евгения', 'Сидорова', 2222, '04-05-1996', 3.59);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (6, 'Сергей', 'Иванцов', 3011, '12-24-1995', 3.85);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (7, 'Николай', 'Борисов', 3011, '12-08-2000', 4.22);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (8, 'Виктория', 'Воронцов', 3011, '11-11-1999', 4.63);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (9, 'Марина', 'Кузнецов', 3011, '01-25-1998', 3.11);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (10, 'Джон', 'Уик', 3011, null, 3.45);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (11, 'Виктор', 'Понедельник', 3011, '11-23-1994', 3.98);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (12, 'Алиса', 'Васильченко', 2222, null, 2.98);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (13, 'Артём', 'Иван', 2222, '05-28-1999', 4.03);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (14, 'Шарлотта', 'Калла', 2222, '05-23-1996', 4.67);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (15, 'Юлия', 'Белорукова', 4011, '11-28-1997', 3.58);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (16, 'Татьяна', 'Акимова', 4011, '01-23-1995', 4.98);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (17, 'Ульяна', 'Кайшева', 4011, '03-03-1998', 4.37);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (19, 'Никита', 'Крюков', 4011, '08-04-1999', 2.55);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (20, 'Иван', 'Шаповалов', 4032, '04-29-2002', 2);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (21, 'Анастасия', 'Овсянникова', 4032, '12-31-1998', 4.25);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (22, 'Людмила', 'Иванова', 4032, '05-02-1993', 3.65);
INSERT INTO student (id, name, surname, n_group, date_birth, score) VALUES (23, 'Валентина', 'Сидорова', 4032, null, 3.76);


INSERT INTO hobby (id, risk, name) VALUES (2, 0.3, 'Теннис');
INSERT INTO hobby (id, risk, name) VALUES (5, 0.4, 'Лыжные');
INSERT INTO hobby (id, risk, name) VALUES (7, 0.2, 'Фехтование');
INSERT INTO hobby (id, risk, name) VALUES (1, 0.8, 'Футбол');
INSERT INTO hobby (id, risk, name) VALUES (3, 0.5, 'Баскетбол');
INSERT INTO hobby (id, risk, name) VALUES (4, 0.4, 'Биатлон');
INSERT INTO hobby (id, risk, name) VALUES (6, 0.6, 'Волейбол');
INSERT INTO hobby (id, risk, name) VALUES (8, 0, 'Музыка');


INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (1, 2, 3, '03-15-2004', null);
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (2, 2, 5, '02-18-2009', null);
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (3, 3, 4, '11-12-1993', '12-11-2016');
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (4, 4, 5, '03-14-2004', '05-03-2006');
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (5, 5, 8, '06-18-2014', '08-09-2017');
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (6, 6, 7, '03-19-2018', '03-15-2017');
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (7, 7, 4, '04-07-2017', null);
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (8, 8, 2, '11-09-2018', null);
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (9, 8, 1, '02-28-2019', '03-02-2019');
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (10, 9, 4, '12-19-2009', '12-24-2009');
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (11, 9, 5, '06-18-2013', '09-25-2018');
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (12, 11, 6, '06-18-2014', null);
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (13, 12, 7, '01-23-1999', '04-14-2004');
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (14, 1, 1, '07-19-2017', null);
INSERT INTO student_hobby (id, student_id, hobby_id, date_start, date_finish) VALUES (15, 16, 5, '02-13-2018', null);

COMMIT;
