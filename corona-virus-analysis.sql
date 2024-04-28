-- Q1: Write a code to check the missing values

select * from corona_virus
where province is null or country is null 
or latitude is null or longitude is null
or date is null or confirmed is null or 
deaths is null or recovered is null;

--Q2 if null values are present, update them with zeros for all columns

update corona_virus set province = COALESCE(province, ''),
country = COALESCE(country, ''),
latitude = COALESCE(latitude, 0),
longitude = COALESCE(longitude, 0),
confirmed = COALESCE(confirmed, 0),
deaths = COALESCE(deaths, 0),
recovered = COALESCE(recovered,0);

-- Q3 Check total number of rows

select count(*) from corona_virus;

-- Q4 Check what is end date
select date from corona_virus
order by date desc
limit 1;

-- And what is start date
select date from corona_virus
order by date
limit 1;
-- select min(date) from corona_virus;
-- Q5 Number of months present in dataset
select Extract(month from date) as number_of_month
from corona_virus
group by extract(month from date)
order by number_of_month;
			 
-- Q6 Find country having highest number of the confirmed case
select country, max(confirmed) as highest_confirmed_case from corona_virus
group by country
order by highest_confirmed_case desc
limit 1;


--Q7 Find country having lowest number of the death case
select country, min(deaths) as lowest_deaths_case from corona_virus
group by country
order by lowest_deaths_case;

--Q8 Find top 5 countries having highest recovered case
select country, max(recovered) as highest_recovered_case from corona_virus
group by country
order by highest_recovered_case desc
limit 5;

-- ADD a month column in table 
--ALTER table corona_virus ADD month INT;
--ALTER  table corona_virus ADD year INT;
--select * from corona_virus;
-- Extract month and year from date column
select date,
EXTRACT(month FROM date) as month,
EXTRACT(year FROM date) as year,
EXTRACT(day FROM date) as day
from corona_virus;

--Q9 Find monthly average for confirmed,deaths,recovered
select Extract(month from date)as month,
avg(confirmed) as avg_confirmed,
avg(deaths) as avg_deaths,
avg(recovered) as avg_recovered
from corona_virus
group by extract(month from date)
order by month;

-- Q10 Find most frequent value for confirmed, deaths, recovered each month 

select extract(month from date) as month,
max(confirmed) as most_frequent_confirmed,
max(deaths) as most_frequent_deaths,
max(deaths) as most_frequent_recovered
from corona_virus
group by extract(month from date)
order by month;

-- Q11 Find minimum values for confirmed, deaths, recovered per year

select extract(year from date) as year,
min(confirmed) as min_confirmed,
min(deaths) as min_deaths,
min(recovered) as min_recovered
from corona_virus
group by extract(year from date)
order by year;

-- Q12 Find maximum values of confirmed, deaths, recovered per year
select extract(year from date) as year,
max(confirmed) as max_confirmed,
max(deaths) as max_deaths,
max(recovered) as max_recovered
from corona_virus
group by extract(year from date)
order by year;

-- Q13 The total number of case of confirmed, deaths, recovered each month
select extract(month from date) as month,
count(confirmed) as total_confirmed,
count(deaths) as total_deaths,
count(recovered) as total_recovered
from corona_virus
group by extract (month from date)
order by month;


-- Q14 Check how corona virus spread out with respect to confirmed case
-- (Eg.: total confirmed cases, their average, variance & STDEV )
select count(confirmed) as total_confirmed_cases,
avg(confirmed) as avg_confirmed,
VARIANCE(confirmed) as variance_confirmed,
STDDEV(confirmed) as std_confirmed
from corona_virus;

-- Q15 Check how corona virus spread out with respect to death case per month
-- (Eg.: total confirmed cases, their average, variance & STDEV)

select extract(month from date) as month,
count(deaths) as total_deaths_per_month,
avg(deaths) as avg_deaths_per_months,
variance(deaths) as var_deaths_per_months,
stddev(deaths) as std_deaths_per_months
from corona_virus
group by extract (month from date)
order by month;

-- Q16 Check how corona virus spread out with respect to recovered case
-- (Eg.: total confirmed cases, their average, variance & STDEV )

select count(recovered) as total_recovered,
avg(recovered) as avg_recovered,
variance(recovered) as var_recovered,
stddev(recovered) as std_recovered
from corona_virus;

