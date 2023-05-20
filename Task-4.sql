--1.Удалите всех студентов с неуказанной датой рождения 
DELETE FROM student 
WHERE date_birth IS NULL;
--2.
UPDATE student 
SET date_birth = '01-01-1999' 
WHERE date_birth IS NULL
--3.
DELETE FROM student 
WHERE id = 21; 
--4.
SELECT hobby_id, 
    COUNT(*) AS count 
FROM student_hobby 
GROUP BY hobby_id 
ORDER BY count DESC 
LIMIT 1; 
UPDATE hobby 
SET risk = risk - 1 
WHERE id = 4; 
--5.
SELECT DISTINCT student_id 
FROM student_hobby; 
UPDATE student SET score = score + 0.01 
WHERE id IN (SELECT DISTINCT student_id FROM student_hobby); 
--6.
SELECT id FROM student_hobby 
WHERE date_finish IS NOT NULL; 
DELETE FROM student_hobby 
WHERE id IN (SELECT id FROM student_hobby WHERE date_finish IS NOT NULL); 
--7.
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_finish) 
VALUES (4, 5, '2009-11-15', NULL); 
--8.
DELETE FROM student_hobby sh1
WHERE date_start =
(SELECT MIN(date_start)
FROM student_hobby sh2
WHERE sh1.student_id = sh2.student_id
AND sh1.hobby_id = sh2.hobby_id
AND sh2.date_finish IS NOT NULL
AND sh1.date_start > sh2.date_finish);
--9.
UPDATE student_hobby 
SET hobby_id = (SELECT id FROM hobby WHERE name = 'бальные танцы') 
WHERE hobby_id = (SELECT id FROM hobby WHERE name = 'футбол'); 
UPDATE student_hobby 
SET hobby_id = (SELECT id FROM hobby WHERE name = 'вышивание крестиком') 
WHERE hobby_id = (SELECT id FROM hobby WHERE name = 'баскетбол'); 
--10.
INSERT INTO hobby (id, name, risk) VALUES (9,'Учёба', 0.00);
--11.
UPDATE hobby
SET hobby_name = 'Учеба'
WHERE id IN (SELECT score from student WHERE score < 3.2);
--12.
UPDATE student
SET n_group = n_group + 1000
WHERE n_group < 4000;
--13.
DELETE FROM student WHERE id = 2; 
--14.
UPDATE Student
SET score = 5.00
WHERE id IN (
    SELECT sh.student_id
    FROM Student_hobby sh
    INNER JOIN Hobby h ON sh.hobby_id = h.id
    WHERE (current_timestamp - sh.date_start) > interval'10 years'
);
--15.
DELETE FROM Student_hobby
WHERE student_id IN (
    SELECT sh.student_id
    FROM Student_hobby sh
    JOIN Student s ON sh.student_id = s.id
    JOIN Hobby h ON sh.hobby_id = h.id
    WHERE sh.date_start > s.date_birth
);

