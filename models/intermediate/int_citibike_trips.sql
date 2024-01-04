select 
start_station_id,
start_station_name,
trip_start_ts,
trip_start_date,
end_station_id,
end_station_name,
trip_end_ts,
trip_end_date,
trip_length_mins,
DATE_DIFF(trip_end_date, trip_start_date, day) as trip_length_days,
CASE WHEN start_station_id = end_station_id THEN 1 ELSE 0 END AS round_trip_yn
from {{ ref('stg_citibike_trips') }}