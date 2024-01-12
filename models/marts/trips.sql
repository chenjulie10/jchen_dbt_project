
select
t.pk,
t.start_station_id,
t.start_station_name,
t.trip_start_ts,
t.trip_start_date,
t.end_station_id,
t.end_station_name,
t.trip_end_ts,
t.trip_end_date,
t.trip_length_mins,
t.trip_length_days,
t.round_trip_yn,
s.capacity,
s.num_bikes_available,
s.num_bikes_disabled,
s.num_docks_available,
s.num_docks_disabled
from {{ ref('int_citibike_trips') }} t 
left join {{ ref('int_citibike_stations') }} s 
    on t.start_station_id = s.station_id

