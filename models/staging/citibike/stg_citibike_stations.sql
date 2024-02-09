select
    station_id,
    name as station_name,
    short_name,
    latitude,
    longitude,
    region_id,
    rental_methods,
    capacity as station_capacity,
    eightd_has_key_dispenser,
    num_bikes_available,
    num_bikes_disabled,
    num_docks_available,
    num_docks_disabled,
    eightd_has_available_keys,
    last_reported as last_reported_ts
from {{ source("citibike", "citibike_stations") }}
where is_installed = true and is_renting = true and is_returning = true
