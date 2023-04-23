--2.1
--1.
Select name, surname
from student
WHERE (score >= 4 and score <= 4.5);
--method 2
Select name, surname
from student
WHERE(score between 4 and 4.5);
--2. introduction to CAST( with LIKE)
Select *
from student
WHERE CAST(n_group as text) LIKE '2%';
--3. output of all stedents and sorting
Select *
from student
ORDER BY n_group DESC, name;
--4. students who have AVG >4 and sorting
Select *
From student
WHERE(score > 4)
ORDER BY score DESC;
--5. 2 hobby and risk
Select name,risk
From hobby
LIMIT 2;
--6.
SELECT student_id, hobby_id 
FROM student_hobby  
WHERE (date_finish BETWEEN '05-03-2006' AND '03-02-2019')
AND (date_finish IS NULL)
--7.
SELECT * 
FROM student 
WHERE (score >= 4.5)
ORDER BY score DESC
--8
Select *
from student
ORDER BY score DESC
LIMIT 5;
--method 2
SELECT *
FROM student
WHERE(score > 4)
ORDER BY score
LIMIT 5
--9
Select name,
CASE
WHEN risk >= 8 THEN 'Очень высокий'
WHEN risk >= 6 and risk < 8 THEN 'Высокий'
WHEN risk >=4 and risk < 6 THEN 'Средний'
WHEN risk >= 2 and risk < 4 THEN 'Низкий'
When risk < 2 THEN 'Очень Низкий'
ELSE 'Мы точно никогда не выведем это сообщение'
End AS category
from hobby;
--10
Select name, risk
from hobby
ORDER BY risk DESC
LIMIT 3;
--____________________________________________________________________________________________________
--2.2 group functions
--1Выведите номера групп и количество студентов, обучающихся в них
 SELECT COUNT(n_group), n_group
FROM student
GROUP BY n_group
--2 Выведите для каждой группы максимальный средний балл
SELECT MAX(score), n_group
FROM student
GROUP BY n_group
--3 Подсчитать количество студентов с каждой фамилией
SELECT COUNT(surname), surname
FROM student
GROUP BY surname
--4Подсчитать студентов, которые родились в каждом году
SELECT COUNT(*), to_char(date_birth,'YYYY')
FROM student
GROUP BY to_char(date_birth,'YYYY')
--5Для студентов каждого курса подсчитать средний балл !(Substr)
SELECT substr(CAST(n_group as text), 1, 1), avg(score) AverageScore
FROM student
group by substr(CAST(n_group as text), 1, 1)
--6Для студентов заданного курса вывести один номер группы с максимальным средним баллом
SELECT  n_group, AVG (score) AS avg_sc
FROM student 
WHERE n_group::text LIKE '4%'
GROUP BY  n_group 
ORDER BY avg_sc DESC
LIMIT 1;
--7Для каждой группы подсчитать средний балл, вывести на экран только те номера групп и их средний балл, в которых он менее или равен 3.5. Отсортировать по от меньшего среднего балла к большему.
Select n_group, AVG(score) AS avg_sc
from student
GROUP BY n_group
HAVING(AVG(score) <= 3.5)
ORDER BY avg_sc ASC;
--8 Для каждой группы в одном запросе вывести количество студентов, максимальный балл в группе, средний балл в группе, минимальный балл в группе
SELECT n_group, COUNT(n_group), MAX(score), MIN(score)
FROM student
GROUP BY n_group;
--9 Вывести студента/ов, который/ые имеют наибольший балл в заданной группе
--10
--_______________________________________________________________________
--2.3
--1
SELECT student.name, student.surname, hobby.name
FROM student, hobby, student_hobby 
WHERE student_hobby.student_id = student_id AND student_hobby.hobby_id = hobby.id;
--2
SELECT student.name, student.surname, student_hobby.date_start
FROM student, student_hobby
WHERE student.id = student_hobby.student_id AND student_hobby.date_finish IS NULL
ORDER BY student_hobby.date_start
LIMIT 1;
--3

--4
SELECT student.name, student.surname, student.n_group, student.date_birth, zpr.monthes, zpr.name
FROM student
INNER JOIN
(SELECT (to_char(student_hobby.date_finish, 'MM')::numeric(10,0) + to_char(student_hobby.date_finish, 'YYYY')::numeric(10,0) * 12) - (to_char(student_hobby.date_start, 'MM')::numeric(10,0) + to_char(student_hobby.date_start, 'YYYY')::numeric(10,0) * 12) as monthes, student_hobby.student_id, hobby.name
FROM student_hobby, hobby
WHERE hobby.id = student_hobby.id) zpr
ON zpr.student_id = student.id
--5
--6
SELECT DISTINCT student.n_group, avg(student.score)::numeric(3,2)
FROM student
INNER JOIN(SELECT DISTINCT student_hobby.student_id
FROM student_hobby, hobby
WHERE student_hobby.hobby_id = hobby.id AND student_hobby.date_finish IS NULL) zpr
ON zpr.student_id = student.id
GROUP BY student.n_group
--7
SELECT hobby.name, hobby.risk, -1 * (to_char(zpr.dl, 'YYYY')::numeric(5,0) * 12 + to_char(zpr.dl, 'MM')::numeric(5,0)) + (to_char(now(), 'YYYY')::numeric(5,0) * 12 + to_char(now(),'MM')::numeric(5,0))
FROM hobby
INNER JOIN(
SELECT student_hobby.hobby_id, min(student_hobby.date_start) as dl, student_hobby.student_id
FROM student_hobby
GROUP BY student_hobby.student_id, student_hobby.hobby_id
HAVING student_hobby.student_id = 3
LIMIT 1) zpr
ON zpr.hobby_id = hobby.id
--8
SELECT hobby.name
FROM student
INNER JOIN student_hobby on student_hobby.student_id = student.id
INNER JOIN hobby on hobby.id = student_hobby.hobby_id
WHERE student.score = (SELECT max(student.score)
FROM student)
--
