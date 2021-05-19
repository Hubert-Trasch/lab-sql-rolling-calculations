;
-- Get number of monthly active customers.



create or replace view user_activity as
select customer_id, rental_date as Activity_date,
month(rental_date) as Activity_Month,
year(rental_date) as Activity_year
from rental;


create or replace view monthly_active_users as
select Activity_year, Activity_Month, count(customer_id) as Active_users
from user_activity
group by Activity_year, Activity_Month
order by Activity_year asc, Activity_Month asc;



-- Active users in the previous month.

select 
   Activity_year, 
   Activity_month,
   Active_users, 
   lag(Active_users,1) over () as Last_month
   from monthly_active_users;



-- Percentage change in the number of active customers.

   
   
create or replace view activity_test as
  select
    Activity_year, Activity_month, Active_users,
    lag(Active_users,1) over () as last_month
  from monthly_active_users
  order by Activity_year,Activity_month;

  
  
  select 
   Activity_year, 
   Activity_month,
   Active_users, 
   last_month,((Active_users-last_month)/Active_users)*100 as diff_in_percent
   from activity_test;
   
   


-- Retained customers every month.