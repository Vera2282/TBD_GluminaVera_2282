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
