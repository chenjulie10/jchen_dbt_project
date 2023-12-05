SELECT
-- need to make a primary key using dbt utils package 
(tripduration)/60 as trip_length_mins,
starttime,
stoptime,
start_station_id,
start_station_name,
start_station_latitude,
start_station_longitude,
end_station_id,
end_station_name,
end_station_latitude,
end_station_longitude,
bikeid as bike_id,
usertype as user_type,
birth_year,
gender,
customer_plan
from `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE starttime is not null