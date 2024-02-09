SELECT 
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
FROM {{ source('citibike','citibike_stations') }}
WHERE is_installed = TRUE 
and is_renting = TRUE
and is_returning = TRUE