select
    {{ dbt_utils.generate_surrogate_key(["bikeid", "starttime", "start_station_id"]) }}
    as pk,
    round((tripduration) / 60, 1) as trip_length_mins,
    starttime as trip_start_ts,
    date(starttime) as trip_start_date,
    extract(hour from starttime) as trip_start_hr,
    stoptime as trip_end_ts,
    date(stoptime) as trip_end_date,
    extract(hour from stoptime) as trip_end_hr,
    cast(start_station_id as string) as start_station_id,
    start_station_name,
    start_station_latitude,
    start_station_longitude,
    cast(end_station_id as string) as end_station_id,
    end_station_name,
    end_station_latitude,
    end_station_longitude,
    bikeid as bike_id,
    usertype as user_type,
    birth_year,
    gender,
    customer_plan
from `bigquery-public-data.new_york_citibike.citibike_trips`
where starttime is not null
