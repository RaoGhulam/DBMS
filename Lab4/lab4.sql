-- Q1.
select d.dept_id, d.dept_name,
       (select count(*) from student s where s.dept_id = d.dept_id) as Student_Count
from department d;

-- Q2.
select s.dept_id, avg(s.gpa) as avg_gpa
from student s
group by s.dept_id
having avg(s.gpa) > 3.0;

-- Q3.
select c.course_name, avg(s.fee_paid) as average_fee
from course c
inner join enrollment e on c.course_id = e.course_id
inner join student s on e.student_id = s.student_id
group by c.course_name;

-- Q4.
select d.dept_id, d.dept_name,
       (select count(*) from faculty f where f.dept_id = d.dept_id) as Faculty_Count
from department d;

-- Q5.
select *
from faculty
where salary > (select avg(salary) from faculty);

-- Q6.
select *
from student
where gpa > any (select gpa from student where dept_id = 1);

-- Q7.
select *
from (select * from student order by gpa desc)
where rownum < 4;

-- Q8.
select s.student_id, s.student_name
from student s
where not exists (
    select c.course_id
    from student a, enrollment ea, course c
    where a.student_name = 'Ali'
      and a.student_id = ea.student_id
      and ea.course_id = c.course_id
      and not exists (
          select 1
          from enrollment e
          where e.student_id = s.student_id
            and e.course_id = c.course_id
      )
);

-- Q9.
select d.dept_id, d.dept_name,
       (select sum(s.fee_paid) from student s where s.dept_id = d.dept_id) as Total_Fees
from department d;

-- Q10.
select e.student_id,
       (select c.course_name from course c where e.course_id = c.course_id) as Courses
from enrollment e
where e.student_id in (
    select s.student_id from student s where s.gpa > 3.5
);

-- Q11.
select dept_id
from student s
where 1000000 <
      (select sum(s1.fee_paid)
       from student s1
       group by s1.dept_id
       having s.dept_id = s1.dept_id);

-- Q12.
select f.dept_id
from faculty f
where f.salary > 100000
group by f.dept_id
having count(f.faculty_id) > 5;

-- Q13.
delete from student
where gpa < (select avg(s.gpa) from student s);

-- Q14.
delete from course c
where c.course_id not in (select e.course_id from enrollment e);

-- Q15.
insert into HighFee_Students (student_id, student_name, dept_id, gpa, fee_paid)
select student_id, student_name, dept_id, gpa, fee_paid
from student
where fee_paid > (select avg(fee_paid) from student);

-- Q16.
insert into Retired_Faculty (faculty_id, faculty_name, dept_id, salary, joining_date)
select faculty_id, faculty_name, dept_id, salary, joining_date
from faculty
where joining_date < to_date('1985,01,01','YYYY,MM,DD');

-- Q17.
select d.dept_id, d.dept_name
from department d
where d.dept_id = (
    select max_id
    from (
        select s.dept_id as max_id
        from student s
        group by s.dept_id
        order by max_id desc
    )
    where rownum < 2
);

-- Q18.
select course_id
from (
    select count(*) as cnt, e.course_id
    from enrollment e
    group by e.course_id
    order by cnt desc
)
where rownum < 4;

-- Q19.
select s.student_id
from student s
inner join enrollment e on e.student_id = s.student_id
where s.gpa > (select avg(gpa) from student)
group by s.student_id
having count(course_id) > 3;

-- Q20.
insert into Unassigned_Faculty (faculty_id, faculty_name, dept_id, salary, joining_date)
select f.faculty_id, f.faculty_name, f.dept_id, f.salary, f.joining_date
from faculty f
where f.faculty_id not in (select fc.faculty_id from facultycourse fc);