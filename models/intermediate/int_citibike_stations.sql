select
station_id,
station_name,
short_name,
region_id,
rental_methods,
capacity,
num_bikes_available,
num_bikes_disabled,
num_docks_available,
num_docks_disabled
from {{ ref('stg_citibike_stations') }}
