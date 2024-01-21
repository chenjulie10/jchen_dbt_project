WITH trips AS (
select 
extract(month from trip_start_date) as month,
start_station_name,
start_station_id,
count(distinct pk) as total_trips_started,
COUNT(DISTINCT CASE WHEN start_station_id = end_station_id THEN pk end) as total_round_trips
from {{ ref('int_citibike_trips') }} 
group by 1,2,3
order by 1,2,3
)


select
m.month as trip_month,
start_station_name,
total_trips_started,
total_round_trips
from trips t
left join {{ ref('month_mapping') }} m
    on t.month = m.number
