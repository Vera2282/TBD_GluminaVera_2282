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
SELECT n_group, name 
FROM student
WHERE score = (SELECT max(score) 
FROM student) 
GROUP BY n_group, name
--10
SELECT stu.n_group, stu.name, stu.score
FROM student stu
JOIN (
SELECT n_group, MAX(score) AS max_score
FROM student
GROUP BY n_group
) stu_max ON stu.n_group = stu_max.n_group AND stu.score = stu_max.max_score
ORDER BY stu.n_group;

--_____________________________________________________открой файл_ питоновский_________________
--2.3
--1
SELECT student.name, student.surname, hobby.name
FROM student INNER JOIN hobby 
ON student.id = hobby.id;
--2
SELECT student.name, student.surname, student_hobby.date_start
FROM student, student_hobby
WHERE student.id = student_hobby.student_id AND student_hobby.date_finish IS NULL
ORDER BY student_hobby.date_start
LIMIT 1;
--3
SELECT st.name, st.surname, st.date_birth, AVG(score), SUM(h.risk)
FROM student st INNER JOIN student_hobby sh
ON st.id = sh.student_id
INNER JOIN hobby h
ON sh.hobby_id = h.id
WHERE sh.date_finish IS NULL
GROUP BY st.name, st.surname, st.score, st.date_birth
HAVING SUM(h.risk) > 0.9 AND st.score > (SELECT AVG(score) FROM student)
--4
SELECT student.name, student.surname, student.n_group, student.date_birth, zpr.monthes, zpr.name
FROM student
INNER JOIN
(SELECT (to_char(student_hobby.date_finish, 'MM')::numeric(10,0) + to_char(student_hobby.date_finish, 'YYYY')::numeric(10,0) * 12) - (to_char(student_hobby.date_start, 'MM')::numeric(10,0) + to_char(student_hobby.date_start, 'YYYY')::numeric(10,0) * 12) as monthes, student_hobby.student_id, hobby.name
FROM student_hobby, hobby
WHERE hobby.id = student_hobby.id) zpr
ON zpr.student_id = student.id
--5
SELECT st.surname, st.name, st.date_birth, COUNT(sh.hobby_id)
FROM student st INNER JOIN student_hobby sh
ON st.id = sh.student_id
WHERE extract(year from age(now()::date,st.date_birth))=20 AND (sh.date_finish IS Null)
GROUP BY st.surname, st.name, st.date_birth
HAVING COUNT(sh.hobby_id) > 1
--6
SELECT DISTINCT student.n_group, avg(student.score)::numeric(3,2)
FROM student
INNER JOIN(SELECT DISTINCT student_hobby.student_id
FROM student_hobby, hobby
WHERE student_hobby.hobby_id = hobby.id AND student_hobby.date_finish IS NULL) zpr
ON zpr.student_id = student.id
GROUP BY student.n_group
--7
Select h.name, h.risk, extract (year from age(now()::date, sh.date_start)) * 12 + extract(month from age(now()::date, sh.date_start)) as length_hobby, st.n_group
FROM hobby h INNER JOIN student_hobby sh
ON h.id = sh.hobby_id
INNER JOIN student st
ON sh.student_id = st.id
WHERE (sh.date_finish IS null)
ORDER BY sh.date_start ASC
--8
SELECT st.n_group, st.name,st.surname, h.name
FROM student st INNER JOIN student_hobby sh
ON st.id = sh.student_id
INNER JOIN hobby h
ON sh.hobby_id = h.id
WHERE sh.date_finish is not NULL
GROUP BY st.n_group, st.name, h.name, st.surname
--9
SELECT DISTINCT h.name
FROM student st INNER JOIN student_hobby sh
ON st.id = sh.student_id
INNER JOIN hobby h
ON sh.hobby_id = h.id
WHERE st.n
--10
SELECT DISTINCT substr(st.n_group::varchar,1,1) AS n_course
FROM student st INNER JOIN student_hobby sh
ON st.id = sh.student_id
INNER JOIN hobby h
ON sh.hobby_id = h.id
WHERE (sh.date_finish IS Null)
GROUP BY st.surname, st.name, st.n_group

SELECT substr(t.course::varchar,1,1) as course
FROM
(
SELECT substr(s.n_group::varchar,1,1) as course, count(*) as all_students, SUM(CASE WHEN sh.date_finish IS NULL THEN 1 ELSE 0 END) as students_h
FROM student s
INNER JOIN student_hobby sh ON s.id = sh.student_id
INNER JOIN hobby h ON h.id = sh.hobby_id
GROUP BY substr(s.n_group::varchar,1,1)
) t
WHERE t.all_students/t.students_h >= 0.5
--11
Select n_group
From
(
Select n_group, COUNT(*) as all_students, SUM(CASE WHEN score>=4 THEN 1 ELSE 0 END) as good_students
From student
GROUP BY n_group
) t
WHERE all_students/good_students >= 0.6
--12
Select LEFT(n_group::text,1), COUNT(DISTINCT(hobby.name))
From student
INNER JOIN student_hobby ON student.id = student_hobby.student_id
INNER JOIN hobby ON hobby.id = student_hobby.hobby_id,
WHERE (student_hobby.date_finish is NULL)
GROUP BY n_group
ORDER BY n_group
--13
Select LEFT(n_group::text,1) ,student.surname, student.name, student.date_birth
From student
INNER JOIN student_hobby ON student.id = student_hobby.student_id
INNER JOIN hobby ON hobby.id = student_hobby.hobby_id
WHERE (score = 5 and student_hobby.student_id is null)
GROUP BY n_group, student.surname, student.name, student.date_birth
ORDER BY n_group DESC, date_birth
--14
CREATE OR REPLACE VIEW Students AS
SELECT student.id, student.surname, student.name, student.n_group, student.date_birth FROM student
INNER JOIN student_hobby ON student.id = student_hobby.student_id
INNER JOIN hobby ON hobby.id = student_hobby.hobby_id
WHERE student_hobby.date_finish is null and extract(year from age(CURRENT_DATE, date_birth)) >=5
--15
SELECT h.name, COUNT(sh.student_id) AS stud_on_hobby
FROM student_hobby sh inner join hobby h
ON sh.hobby_id = h.id
GROUP BY hobby_id, h.name
ORDER BY stud_on_hobby DESC
--16
SELECT h.id as most_popular_hobby_id 
FROM student_hobby sh INNER JOIN hobby h
ON sh.hobby_id = h.id
GROUP BY h.id
ORDER BY COUNT(sh.student_id)  desc
limit 1
--17
SELECT h.name, h.risk,st.name,st.n_group,
extract (year from age(now()::date, sh.date_start)) * 12 + extract(month from age(now()::date, sh.date_start)) as da
FROM student st inner join student_hobby sh
ON st.id = sh.student_id
INNER JOIN hobby h
ON sh.hobby_id = h.id
ORDER BY da DESC limit 10
--18
SELECT h.risk AS most_risk_hobby_id 
FROM hobby h
--WHERE risk = (SELECT MAX(risk)FROM hobby)
ORDER BY risk DESC
limit 3
--19
SELECT st.name,st.surname
FROM student st
INNER JOIN
(SELECT DISTINCT sh.student_id, extract(day from (justify_days(now() - sh.date_start))) as countofdays
FROM student_hobby sh
WHERE sh.date_finish IS NULL
ORDER BY countofdays DESC) tt
ON tt.student_id = st.id
ORDER BY countofdays DESC LIMIT 10
--20
SELECT DISTINCT st.n_group
FROM student st
INNER JOIN(
SELECT st.name,st.surname, st.id
FROM student st
INNER JOIN
(SELECT DISTINCT sh.student_id, extract(day from (justify_days(now() - sh.date_start))) as countofdays
FROM student_hobby sh
WHERE sh.date_finish IS NULL
ORDER BY countofdays DESC) tt
ON tt.student_id = st.id
ORDER BY countofdays DESC LIMIT 10
) tt
ON tt.id = st.id
--21
CREATE OR replace view fio_student AS 
SELECT name, surname
FROM student
ORDER BY score DESC
--22
CREATE OR REPLACE VIEW Popular_Hobby AS
SELECT LEFT(student.n_group::text, 1) AS course, hobby.name AS hobby
FROM student
INNER JOIN student_hobby ON student.id = student_hobby.student_id
INNER JOIN hobby ON hobby.id = student_hobby.hobby_id
GROUP BY course, hobby
HAVING COUNT(DISTINCT student_hobby.student_id) = (
SELECT
MAX(student_count.count)
FROM (
SELECT
COUNT(DISTINCT student_hobby.student_id) AS count,
LEFT(student.n_group::text, 1) AS course
FROM
student
INNER JOIN student_hobby ON student.id = student_hobby.student_id
GROUP BY
course,
student_hobby.hobby_id
) AS student_count
WHERE student_count.course = course
);
Select * FROM popular_Hobby;
--23
--Представление: найти хобби с максимальным риском среди самых популярных хобби на 2 курсе.
CREATE OR REPLACE VIEW max_risk_hobby AS
SELECT hobby.risk
FROM hobby
INNER JOIN student_hobby ON hobby.id = student_hobby.hobby_id
GROUP BY hobby.id
HAVING COUNT(DISTINCT student_hobby.hobby_id =
(
SELECT risk, MAX(score) AS mx_sc
FROM hobby
ORDER by mx_sc DESC
GROUP BY student_hobby.hobby_id
) AS counts
)
LIMIT 1
--24
CREATE OR REPLACE VIEW students AS
SELECT substr(n_group::varchar,1,1) as course,count(*), SUM(CASE WHEN score = 5 THEN 1 ELSE 0 END)
From student
GROUP BY course;
--25
CREATE OR REPLACE VIEW the_most_popular_hobby AS
SELECT hobby.name
FROM hobby
INNER JOIN student_hobby ON hobby.id = student_hobby.hobby_id,
GROUP BY hobby.id
HAVING COUNT(DISTINCT student_hobby.hobby_id) =
(
	SELECT MAX(hobby_counts)
FROM (
SELECT COUNT(DISTINCT student_hobby.hobby_id) AS hobby_counts
FROM student_hobby
GROUP BY student_hobby.hobby_id
) AS counts
)
LIMIT 1;
--26
CREATE OR REPLACE VIEW ST2 AS
SELECT id, surname, name, N_group FROM Students
WITH CHECK OPTION;
--27
SELECT 
  SUBSTR(name, 1, 1) AS first_letter,
  MAX(score) AS max_score,
  AVG(score) AS avg_score,
  MIN(score) AS min_score FROM student
GROUP BY SUBSTR(name, 1, 1)
HAVING MAX(score) > 3.6
ORDER BY first_letter;
--28
SELECT surname,LEFT(CAST(student.n_group AS varchar), 1) AS course_number,
  MAX(score) AS max_score,
  MIN(score) AS min_score
FROM student
GROUP BY surname, LEFT(CAST(student.n_group AS varchar), 1)
ORDER BY surname;
--29
SELECT EXTRACT(year FROM student.date_birth) AS year_of_birth,
       COUNT(DISTINCT student_hobby.hobby_id) AS hobbies
FROM student
JOIN student_hobby ON student.id = student_hobby.student_id
GROUP BY year_of_birth;
--30
SELECT LEFT(student.name, 1) AS first_letter,
       MAX(hobby.risk) AS max_risk,
       MIN(hobby.risk) AS min_risk
FROM student
JOIN student_hobby ON student.id = student_hobby.student_id
JOIN hobby ON student_hobby.hobby_id = hobby.id
GROUP BY first_letter;
--31
SELECT EXTRACT(month FROM student.date_birth) AS month_of_birth,
       AVG(student.score) AS average_score
FROM student
JOIN student_hobby ON student.id = student_hobby.student_id
JOIN hobby ON student_hobby.hobby_id = hobby.id
WHERE hobby.name = 'Футбол'
GROUP BY month_of_birth;
--32
SELECT concat('Имя: ', student.name, ', фамилия: ', student.surname, ', группа: ', student.n_group) AS output
FROM student
WHERE EXISTS (SELECT 1 FROM student_hobby WHERE student.id = student_hobby.student_id);
--33
SELECT surname,
CASE WHEN position('ов' in surname) > 0
THEN cast(position('ов' in surname) as varchar)
     ELSE 'не найдено'
END AS result
FROM student;
--34
SELECT rpad(surname, 10, '#') AS padded_surname
FROM student;
--35
SELECT replace(rpad(surname, 10, '#'), '#', '') AS unpadded_surname
FROM student;
