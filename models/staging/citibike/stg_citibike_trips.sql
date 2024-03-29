select
    {{
        dbt_utils.generate_surrogate_key(
            ["bikeid", "starttime", "start_station_id", "end_station_id"]
        )
    }} as pk,
    {{ secs_to_mins('tripduration', decimal_places=0) }} as trip_length_mins,
    starttime as trip_start_ts,
    date(starttime) as trip_start_date,
    format_date('%B', starttime) as trip_start_month,
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
    bikeid,
    usertype as user_type,
    birth_year,
    gender,
    customer_plan
from {{ source("citibike", "citibike_trips") }}
where starttime is not null and bikeid is not null
