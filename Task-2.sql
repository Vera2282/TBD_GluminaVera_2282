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




