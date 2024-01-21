-- Get top 10 stations year over year 
with topten AS (
    select 
trip_year,
start_station_name,
total_trips_started,
total_round_trips
from {{ ref('station_trips_agg_by_year')}}
Qualify ROW_NUMBER() OVER (partition by trip_year order by total_trips_started desc) between 1 and 10
)

-- which stations were more popular over the years? 
--W 21 St & 6 Ave
--West St & Chambers St
--E 17 St & Broadway
--Broadway & E 22 St 
, popular AS (
    select 
start_station_name,
count(distinct trip_year) as count_years
from topten
group by 1
order by count_years desc
) 


-- For these popular stations, how many trips were started MoM? 
select 
* 
from {{ ref('station_trips_agg_by_month')}}
where start_station_name in ('W 21 St & 6 Ave', 'West St & Chambers St', 'E 17 St & Broadway', 'Broadway & E 22 St')
Qualify ROW_NUMBER() OVER (partition by start_station_name order by total_trips_started desc) between 1 and 3
