select
station_id,
station_name,
region_id,
rental_methods,
station_capacity,
num_bikes_available,
num_bikes_disabled,
num_docks_available,
num_docks_disabled,
CASE WHEN num_bikes_available + num_bikes_disabled + num_docks_available + num_docks_disabled = station_capacity THEN TRUE ELSE FALSE end as accurate_capacity 
from {{ ref('stg_citibike_stations') }}
