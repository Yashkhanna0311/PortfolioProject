
--combining all three tables and naming it hotels
with hotels as
(
select * 
from dbo.['2018$']
union
select *
from dbo.['2019$']
union
select *
from dbo.['2020$']
)

--caculating the revenue per year without discount of two different types of hotel
select arrival_date_year,hotel,sum( (stays_in_weekend_nights + stays_in_week_nights )*adr) as revenue
from hotels
group by arrival_date_year, hotel




--calculating revenue per year after apllying dicount of two different types of hotel

create table reve_Table(weekend INT , weeek INT , adr INT , discount DECIMAL(3,2),hotel VARCHAR(20),arrival  INT,meal DECIMAL(3,2) );

with hotels as
(
select * 
from dbo.['2018$']
union
select *
from dbo.['2019$']
union
select *
from dbo.['2020$']
)
insert into reve_Table (weekend , weeek, adr , discount, hotel,arrival,meal )
select  stays_in_weekend_nights , stays_in_week_nights ,adr,discount, hotel,arrival_date_year, meal_cost$.meal
from hotels
left join dbo.market_segment$
on hotels.market_segment=market_segment$.market_segment
left join dbo.meal_cost$
on hotels.meal=meal_cost$.meal

select arrival, hotel, sum( (weekend + weeek)*adr*(1-discount)+(weekend + weeek)*meal) as total_revenue
from reve_Table
group by arrival,hotel
order by hotel, arrival

--calculating revenue per year after apllying dicount and adding cost of meal of two different types of hotel
create table revenu_Table(weekend INT , weeek INT , adr INT , discount DECIMAL(3,2),hotel VARCHAR(20),arrival  INT,meal DECIMAL(4,2) );

with hotels as
(
select * 
from dbo.['2018$']
union
select *
from dbo.['2019$']
union
select *
from dbo.['2020$']
)
insert into revenu_Table (weekend , weeek, adr , discount, hotel,arrival,meal )
select  stays_in_weekend_nights , stays_in_week_nights ,adr,discount, hotel,arrival_date_year, meal_cost$.cost
from hotels
left join dbo.market_segment$
on hotels.market_segment=market_segment$.market_segment
left join dbo.meal_cost$
on hotels.meal=meal_cost$.meal

select arrival, hotel, sum( (weekend + weeek)*adr*(1-discount)+(weekend + weeek)*meal) as total_revenue
from revenu_Table
group by arrival,hotel
order by hotel, arrival


--
with hotels as
(
select * 
from dbo.['2018$']
union
select *
from dbo.['2019$']
union
select *
from dbo.['2020$']
)


select  *
from hotels
left join dbo.market_segment$
on hotels.market_segment=market_segment$.market_segment
left join dbo.meal_cost$
on hotel.meal=meal_cost$.meal

