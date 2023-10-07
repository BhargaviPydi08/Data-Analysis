--creating a join table --

select  * from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r
on a.Reason_for_absence = r.Number


--find the healthiest employees for the bonus -- 

select * from Absenteeism_at_work 
where Social_drinker = 0 and Social_smoker = 0
and Body_mass_index < 25 
and Absenteeism_time_in_hours < (select(AVG(Absenteeism_time_in_hours))
from Absenteeism_at_work)


-- compensation for non smokers ||  budhet $983,221 so 0.68 imcrease per hr/ $1,414.4 per year-- 
select count(*) as nonsmokers from Absenteeism_at_work 
where Social_smoker = 0 

-- optimizing the query - To bring only necessary information and avoiding duplicate columns-- 

select 
a.ID,
r.Reason,
a.Month_of_absence,
a.Body_mass_index,
--creating some categories--

case when a.Body_mass_index <18.5 then 'Underweight'
	 when a.Body_mass_index between 18.5 and 25  then 'Healthy Weight'
	 when a.Body_mass_index between 25 and 30 then 'Overweight'
	 when a.Body_mass_index > 30 then 'Obese'
	 else ' Unknown' end as BMI_Category,

case when Month_of_absence IN (12, 1, 2) then 'Winter'
	 when Month_of_absence IN (3, 4, 5)  then 'Spring'
	 when Month_of_absence IN (6, 7, 8)  then  'Summer'
	 when Month_of_absence IN (9, 10, 11) then 'Fall'
	 else 'Unknown' end as season_Names,
a.Seasons,
a.Day_of_the_week,
a.Transportation_expense,
a.Education,
a.Son,
a.Social_drinker,
a.Social_smoker,
a.Pet,
a.Disciplinary_failure,
a.Age,
case when a.Age between 18 and 24 then 'Young'
	 when a.Age between 25 and 44  then 'Typical working age'
	 when a.Age between 45 and 64  then  'Middle Aged'
	 when a.age > 65 then 'Senior Citizens '
	 end as Age_Category,

a.Work_load_Average_day,
a.Absenteeism_time_in_hours,
a.Distance_from_Residence_to_Work
from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r
on a.Reason_for_absence = r.Number
