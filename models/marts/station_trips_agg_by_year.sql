WITH trips AS (
select 
extract(year from trip_start_date) as trip_year,
start_station_name,
start_station_id,
count(distinct pk) as total_trips_started,
COUNT(DISTINCT CASE WHEN start_station_id = end_station_id THEN pk end) as total_round_trips
from {{ ref('int_citibike_trips') }} 
group by 1,2,3
order by 1,2,3
)


select
trip_year,
start_station_name,
total_trips_started,
total_round_trips
from trips 
    